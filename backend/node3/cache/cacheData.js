const { redisClient } =  require('../config/config.js');
const keyGenerator = require('../utility/redis_key_generator.js');
const logger = require('../config/logger.js');

const cacheUnAuthUser = async (userObject) => {
    const { phone } = userObject;
    const key = keyGenerator.getUserAuthKey(phone);
    const result = await redisClient.del(key);

    try {
    for (const [field,value] of Object.entries(userObject)) {
        await redisClient.HSET(key,field,value);
    }
    logger.info(`------ user data cached in redis successfully`);
    return true;
    } catch (error) {
       logger.error(`Error in saving user data in redis : ${error.message}`);
       throw error
    }
}

const saveUserAddress = async (userObject) => {
    // User-id, Street,Suite or Apartment,State,Location,Label(Home,work),Delivery-Instructions 
    const { phone } = userObject;
    const key = keyGenerator.getUserAddressKey(phone);
    const result = await redisClient.del(key);

    try {
        for (const [field,value] of Object.entries(userObject)) {
            await redisClient.HSET(key,field,value);
        }
    logger.info(`------ user address saved in redis successfully`);
    return true;
    } catch (error) {
       logger.error(`Error in saving user address in redis : ${error.message}`);
       throw error
    }
}

const getUserAddress = async (userKey) => {
    const key = keyGenerator.getUserAddressKey(userKey);
    let readUserAddressData;
    readUserAddressData = await scanHash(key);

    // Object to store the key-value pairs
    let userAddressObject = {};

    for (const key in readUserAddressData) {
        if (readUserAddressData.hasOwnProperty(key)) {
            logger.info(`User Address ${key} : ${readUserAddressData[key]}`);
            userAddressObject[key] = readUserAddressData[key];
            }
        }
    logger.info(`Cached User Address :  ${readUserAddressData}`);

    return userAddressObject;
}

async function* scanHashGenerator(key,countVal) {
    let cursor = '0';

    do {
       const result = await redisClient.hScan(key,cursor, {count:countVal});

       cursor = result.cursor;
       const fields = result.keys;

       for (let i = 0; i < fields.length; i += 2) {
         yield {field: fields[i], value: fields[i+1]};
       }
    } while (cursor !== 0);
} 


async function scanHash(hashKey) {
    const result = {};

    try {
        // Iterate over fields and values in the hash
        for await (const { field, value } of redisClient.hScanIterator(hashKey)) {
            result[field] = value;
            logger.info(`Here is the ${field} : ${value}`);
        }
    } catch (error) {
        console.error('Error reading Redis hash:', error);
        throw error;
    }

    return result;
}

module.exports = { cacheUnAuthUser,scanHash,scanHashGenerator,saveUserAddress,getUserAddress }

