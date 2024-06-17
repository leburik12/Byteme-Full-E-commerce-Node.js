const DistrictModel = require('../models/DistrictModel');
const logger = require('../config/logger.js');
const RegexpUtils = require('../utility/regexUtils.js');
const DbUtils = require('../utility/dbUtils.js');

const DistrictController = {

    getAllDistricts: async (req,res,next) => {
        try {
            const districts = await DistrictModel.getAllDistricts();
            if (!districts) {
                logger.error(`internal sql server error in getting all districts`);
                res.status(500).json({message: 'internal server error'});
            } else {
                res.status(200).json(districts);
            } 
        } catch (error) {
          logger.error(`Error getting roles: ${error.message}`);
          next(error);
          //res.status(500).send({message: 'Failed to fetch roles'});
        }
    },

    getDistrictById : async (req,res,next) => {
        const { id } = req.params;
 
        // check if the id parameter is a valid
        if (!RegexpUtils.isRegexpValid(RegexpUtils.idRegexp,id)) {
         logger.error(`Invalid district id format: ${id}`);
         return res.status(400).json({message: 'Invalid District ID format'});
        }
 
         try {
             const role = await DistrictModel.getDistrictById(id);
             if (!role) {
                 logger.error(`District not found by this id : ${id}`);
                 return res.status(404).json({success:false,message: 'District not found'});
             } else {
               logger.info(`District found by id : ${id}`);
             res.status(200).json(role);
         }
         } catch (error) {
             logger.error(`Error getting District by id ${error.message}`);
             next(error);
             //res.status(500).send({message: 'Internal server error'});
         }
     },

     createDistrict : async (req,res,next) => {
        const {district_name, city_id, is_shipping_available=true} = req.body;

        // check if district name is valid
        if (!RegexpUtils.isRegexpValid(RegexpUtils.isValidName,district_name)) {
          logger.error(`Invalid district name: ${district_name}`);
          return res.status(400).json({success:false,message: 'Invalid role ID format'});
        }

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
          const createdDistrict = await DistrictModel.createDistrict(district_name,city_id,is_shipping_available);
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

  updateDistrict : async (req,res,next) => {
    const {id} = req.params;

    // check if the id parameter is a valid
    if (!RegexpUtils.isRegexpValid(RegexpUtils.idRegexp,id)) {
     logger.error(`Invalid District id format: ${id}`);
     return res.status(400).json({message: 'Invalid District ID format'});
    }
    const { district_name, city_id, is_shipping_available } = req.body;

    // check if district name is valid
    if (!RegexpUtils.isRegexpValid(RegexpUtils.isValidName,district_name)) {
        logger.error(`Invalid district name: ${district_name}`);
        return res.status(400).json({success:false,message: 'Invalid role ID format'});
      }

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
        const updatedDistrict = await DistrictModel.updateDistrict(id,district_name,city_id,is_shipping_available);
        if (updatedDistrict === 0) {
            logger.error(`internal server error in  update district`);
            res.status(500).json({message: 'Internal server error'});
        } else {
            logger.info(`Successfully updated district`);
            res.status(200).json(updatedDistrict);
        }
    } catch (error) {
     logger.error(`Error updating district with id ${id} : ${error.message}`);
     next(error);
    }
 },

 deleteDistrict : async (req,res,next) => {
    const {id} = req.params;

    // check if the id parameter is a valid
    if (!RegexpUtils.isRegexpValid(RegexpUtils.idRegexp,id)) {
     logger.error(`Invalid role id format: ${id}`);
     return res.status(400).json({message: 'Invalid role ID format'});
    } 
    try {
     const deletedDistrict = await DistrictModel.deleteDistrict(id);
     if (deletedDistrict === 0) {
        logger.error(`internal server error in deleting district by id`);
        res.status(500).json({message: 'Internal server error'});
     } else {
        logger.info(`Successfully deleted the district with ID : ${id}`);
        res.status(200).json(deletedRole);
     }
    } catch (error) {
     logger.error(`Error deleting district with id ${id} : ${error.message}`)
       next(error);
     //res.status(500).json({message: 'Internal server error'});
    }
 },

}