const GiftModel = require('../models/GiftModel.js');
const logger = require('../config/logger.js');
const RegexpUtils = require('../utility/regexUtils.js');
const DbUtils = require('../utility/dbUtils.js');

const GiftController = {

    getAllGift : async (req,res,next) => {
        try {
            const gifts = await GiftModel.getAllGift();
            if (!gifts) {
                logger.error(`internal sql server error in getting all gifts`);
                res.status(500).json({message: 'internal server error'});
            } else {
                res.status(200).json(gifts);
            } 
        } catch (error) {
          logger.error(`Error getting gifts : ${error.message}`);
          next(error);
        }
    },

    getGiftById : async (req,res,next) => {
        const { id } = req.params;
 
        // check if the id parameter is a valid
        if (!RegexpUtils.isRegexpValid(RegexpUtils.idRegexp,id)) {
         logger.error(`Invalid gift id format: ${id}`);
         return res.status(400).json({message: 'Invalid gift ID format'});
        }
 
         try {
             const role = await GiftModel.getGiftById(id);
             if (!role) {
                 logger.error(`Gift not found by this id : ${id}`);
                 return res.status(404).json({success:false,message: 'Gift not found'});
             } else {
               logger.info(`Gift found by id : ${id}`);
             res.status(200).json(role);
         }
         } catch (error) {
             logger.error(`Error getting Gift by id ${error.message}`);
             next(error);
         }
     },

      getGiftJoinOrder : async (req,res,next) => {
        const { id } = req.params;
 
        // check if the id parameter is a valid
        if (!RegexpUtils.isRegexpValid(RegexpUtils.idRegexp,id)) {
         logger.error(`Invalid Gift id format: ${id}`);
         return res.status(400).json({message: 'Invalid Gift ID format'});
        }
 
         try {
             const role = await GiftModel.getGiftJoinOrder(id);
             if (!role) {
                 logger.error(`Gift not found by this id : ${id}`);
                 return res.status(404).json({success:false,message: 'Gift not found'});
             } else {
               logger.info(`Gift found by id : ${id}`);
             res.status(200).json(role);
         }
         } catch (error) {
             logger.error(`Error getting Gift by id ${error.message}`);
             next(error);
         }
     },

     getGiftForUser : async (req,res,next) => {
        const { id } = req.params;
 
        // check if the id parameter is a valid
        if (!RegexpUtils.isRegexpValid(RegexpUtils.idRegexp,id)) {
         logger.error(`Invalid gift id format: ${id}`);
         return res.status(400).json({message: 'Invalid gift ID format'});
        }
 
         try {
             const gift = await GiftModel.getGiftJoinUser(id);
             if (!gift) {
                 logger.error(`Gift not found by this id : ${id}`);
                 return res.status(404).json({success:false,message: 'Gift not found'});
             } else {
               logger.info(`Gift found by user id : ${id}`);
               res.status(200).json(role);
           }
         } catch (error) {
             logger.error(`Error getting gift by user id ${error.message}`);
             next(error);
         }
     },

     createGift : async (req,res,next) => {
        const { id_order,id_recipient,recipient_name,recipient_address,gift_message,instructions } = req.body;
        const isValidRecipientAddres = false;
        // check if id_recipient exists


        // check if json recipient_address contains valid name and phone number

          // check if city exists
        if (!(DbUtils.checkForeignKeysExist(id,'city'))) {
            logger.error(`Invalid city: ${city_id}`);
            return res.status(404).json({success:false,message: 'City not found.'})
        }

        if (!(is_shipping_available === true || is_shipping_available === false)) {
            logger.error(`Invalid is_shipping available value`);
            return res.status(400).json({success:false, message: 'Invalid is shipping available value'});
        }
      
        try {
          const createdDistrict = await GiftModel.createDistrict(district_name,city_id,is_shipping_available);
          if (createdDistrict.rowCount === 0) {
            logger.error(`internal server error in create role`);
           res.status(500).json({message: 'Internal server error'});
          } else {
            logger.info(`Create district successfully`);
            res.status(200).json(createdRole);
          }
        } catch (error) {
          logger.error(`Error in create district ${error.message}`);
          next(error);
        }
  },

  updateGift : async (req,res,next) => {
    const {id} = req.params;

    // check if the id parameter is a valid
    if (!RegexpUtils.isRegexpValid(RegexpUtils.idRegexp,id)) {
     logger.error(`Invalid Gift id format: ${id}`);
     return res.status(400).json({message: 'Invalid Gift ID format'});
    }
    const { id_order,id_recipient,recipient_name,recipient_address,gift_message,instructions } = req.body;

    try {
        const updatedGift = await GiftModel.updateGift(id,id_order,id_recipient,recipient_name,recipient_address,gift_message,instructions );
        if (updatedGift === 0) {
            logger.error(`internal server error in update gift`);
            res.status(500).json({message: 'Internal server error'});
        } else {
            logger.info(`Successfully updated gift`);
            res.status(200).json(updatedDistrict);
        }
    } catch (error) {
     logger.error(`Error updating gift with id ${id} : ${error.message}`);
     next(error);
    }
 },

 deleteGift : async (req,res,next) => {
    const {id} = req.params;

    // check if the id parameter is a valid
    if (!RegexpUtils.isRegexpValid(RegexpUtils.idRegexp,id)) {
     logger.error(`Invalid role id format: ${id}`);
     return res.status(400).json({message: 'Invalid role ID format'});
    } 
    try {
     const deletedDistrict = await GiftModel.deleteGift(id);
     if (deletedDistrict === 0) {
        logger.error(`internal server error in deleting gift by id`);
        res.status(500).json({message: 'Internal server error'});
     } else {
        logger.info(`Successfully deleted the gift with ID : ${id}`);
        res.status(200).json(deletedRole);
     }
    } catch (error) {
     logger.error(`Error deleting gift with id ${id} : ${error.message}`)
       next(error);
    }
 },

}