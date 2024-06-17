const logger = require('../config/logger.js');
const UserModel = require('../models/UserModel.js');
const keyGenerator = require('../utility/redis_key_generator.js');
const {cacheUnAuthUser,scanHash } = require('../cache/cacheData.js');
require('dotenv').config();

const {TWILIO_SERVICE_SID,TWILIO_ACCOUNT_SID,TWILIO_AUTH_TOKEN} = process.env;
const client = require('twilio')(TWILIO_ACCOUNT_SID,TWILIO_AUTH_TOKEN,{lazyLoading: true});

const sendOTP = async (countryCode,phone) => {
    
    try {
        const otpResponse = await client.verify.v2.services(TWILIO_SERVICE_SID)
                 .verifications.create({
                    to: `+${countryCode}${phone}`,
                    channel: "sms"
                 });
                 logger.info(`OTP sent successfully - ${JSON.stringify(otpResponse)}`);
                 return 1;
    } catch (error) {
        logger.error(`OTP sent error - ${error.message}`);
        throw error;
        //res.status(error?.status || 400).send(error?.message || 'Something went wrong!');
    }
};

const verifyOTP = async (req,res,next) => {
   const { countryCode, phone, otp } = req.body;
   try {
    const userkey = keyGenerator.getUserAuthKey(phone);
    /* const verifiedResponse = await client.verify.v2.services(TWILIO_SERVICE_SID)
                  .verificationChecks.create({
                    to: `+${countryCode}${phone}`,
                    code: otp
                  });  
                  const userkey = keyGenerator.getUserAuthKey(phone);
                  // output response object key value pairs from twilio 
                  Object.keys(verifiedResponse).forEach((key) => {
                    logger.info(`${key} : ${verifiedResponse[key]}`);
                  });*/
                  const verifiedResponse = {
                    'valid': true
                  }
                  if (verifiedResponse['valid'] === true) {
                    // read the cached redis user database and save it in the relation db
                     
                    let readCacheData = await scanHash(userkey);
                    const { email,gender,phone,last_name,first_name,id_role,password} = readCacheData;
                    for (const key in readCacheData) {
                        if (readCacheData.hasOwnProperty(key)) {
                          logger.info(`User Controller ${key} : ${readCacheData[key]}`);
                        }
                    }
                   try {
                   const user = await UserModel.createUser(id_role,first_name,last_name,phone,gender,email,password);
                    if (user.success === true) {
                       logger.info(`User saved successfully. ${user.createdUser}`);
                       return res.status(200).json({success:true,message: `Registration successfull.`});
                       ;
                   } else {
                    logger.error(`Error in saving user. ${user.createdUser}`)
                   return res.status(500).json({success:false,message: `Registration failed.Sorry try again.`})
                   } 
                   /*user.success ? logger.info(`User saved successfully. ${user.createdUser}`) :
                                  logger.error(`Error in saving user.`) */
              } catch(error) {
                  logger.error(`User creation failed after verification - ${error.message}`);
                  next(error);
                }
            } else {
              return res.status(500).json({success:false,message: `OPT verification failed.`})
             }
   } catch (error) {
    logger.error(`verify OTP  error - ${error.message}`);
    next(error);
    //res.status(error?.status || 400).send(error?.message || 'Something went wrong!');
   }
};

module.exports = { sendOTP, verifyOTP };