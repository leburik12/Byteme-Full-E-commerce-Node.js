const RoleModel = require('../models/RoleModel.js');
const logger = require('../config/logger.js');
const RegexpUtils = require('../utility/regexUtils.js');
const {idRegexp,isRegexpValid,rolenameDescriptionRegexp,isActiveRegexp} = require('../utility/regexUtils.js');
const {authMiddleware} = require('../middlewares/authMiddleware.js')
const {checkColumnExists} = require('../utility/dbUtils.js');

const RoleController = {

    getAllRoles : async (req,res,next) => {
        try {
            const roles = await RoleModel.getAllRoles();
            if (!roles) {
                logger.error(`internal sql server error in getting all roles`);
                res.status(500).json({message: 'internal server error'});
            } else {
                res.status(200).json(roles);
            } 
        } catch (error) {
          logger.error(`Error getting roles: ${error.message}`);
          next(error);
          //res.status(500).send({message: 'Failed to fetch roles'});
        }
    },

    getRoleById : async (req,res,next) => {
       const { id } = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(idRegexp,id)) {
        logger.error(`Invalid role id format: ${id}`);
        return res.status(400).json({message: 'Invalid role ID format'});
       }

        try {
            const role = await RoleModel.getRoleById(id);
            if (!role) {
                logger.error(`Role not found by this id : ${id}`);
                return res.status(404).json({success:false,message: 'Role not found'});
            } else {
              logger.info(`Role found by id : ${id}`);
            res.status(200).json(role);
        }
        } catch (error) {
            logger.error(`Error getting roles by id ${error.message}`);
            next(error);
            //res.status(500).send({message: 'Internal server error'});
        }
    },

    createRole : async (req,res,next) => {
          const {role_name, description, isactive} = req.body;

          // check if isactive value is valid
          if (!isRegexpValid(isActiveRegexp,isactive)) {
            logger.error(`Invalid role id format: ${id}`);
            return res.status(400).json({success: false,
              message: 'Invalid role ID format'});
           }

            // check if rolename value is valid
          if (!isRegexpValid(rolenameDescriptionRegexp,role_name)) {
            logger.error(`Invalid rolename format : ${role_name}`);
              return res.status(400).json({
                success: false,
                message: 'Invalid role rolename format',
                body: {role_name: `${role_name}`}
                });
           }

          // check if description value is valid
          if (!isRegexpValid(rolenameDescriptionRegexp,role_name)) {
            logger.error(`Invalid rolename format : ${role_name}`);
            return res.status(400).json({
                success: false,
                message: `Invalid description format. ${role_name}`
           })
          }
         
          // check for role_name uniqueness
          try {
          const rolenameExists = await checkColumnExists('role_name', 'roles',role_name.toLowerCase());
          if (rolenameExists.rows[0].count > 0) {
            logger.error(`Column name exists already.Please try another : ${role_name}`);
            return res.status(409).json({
              success: false,
              message: `role name exists. ${role_name}`
            });
          }
        } catch (error) {
          logger.error(`Role name exists ${error.message}`);
          next(error);
        }
        
          try {
            const createdRole = await RoleModel.createRole(role_name.toLowerCase(),description,isactive);
            if (createdRole.id !== 0) {
             res.status(200).json(createdRole);
            } else {
             logger.error(`internal server error in create role`);
             res.status(500).json({message: 'Internal server error'});
            }
          } catch (error) {
            logger.error(`Error in create roles ${error.message}`);
            //res.status(500).send({message: 'Internal server error'});
            next(error);
          }
    },

    updateRole : async (req,res,next) => {
       const {id} = req.params;

       // check if the id parameter is a valid
       if (!RegexpUtils.isRegexpValid(RegexpUtils.idRegexp,id)) {
        logger.error(`Invalid role id format: ${id}`);
        return res.status(400).json({message: 'Invalid role ID format'});
       }
       const { role_name, description, isactive } = req.body;

      // check if isactive value is valid
          if (!RegexpUtils.isRegexpValid(RegexpUtils.isActiveRegexp,isactive)) {
            logger.error(`Invalid role id format: ${id}`);
            return res.status(400).json({message: 'Invalid role ID format'});
          }

        // check if rolename value is valid
        if (!RegexpUtils.isRegexpValid(RegexpUtils.rolenameDescriptionRegexp,role_name)) {
          logger.error(`Invalid rolename format : ${role_name}`);
            return res.status(400).json({
              message: 'Invalid role rolename format',
              body: {role_name: `${role_name}`}
              });
         }

        // check if description value is valid
        if (!RegexpUtils.isRegexpValid(RegexpUtils.rolenameDescriptionRegexp,role_name)) {
          logger.error(`Invalid rolename format : ${role_name}`);
          logger.error(`Invalid description format : ${description}`);
          return res.status(400).json({
              message: 'Invalid description format', 
              body : {description : `${description}`}});
         } 
       
       try {
           const updatedRole = await RoleModel.updateRole(id,role_name,description,isactive);
           if (updatedRole.rowCount !== 0) {
            res.status(200).json(updatedRole);
           } else {
            logger.error(`internal server error in update role`);
            res.status(500).json({message: 'Internal server error'});
           }
       } catch (error) {
        logger.error(`Error updating role with id ${id} : ${error.message}`);
        next(error);
       }
    },

    deleteRole : async (req,res,next) => {
       const {id} = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(RegexpUtils.idRegexp,id)) {
        logger.error(`Invalid role id format: ${id}`);
        return res.status(400).json({message: 'Invalid role ID format'});
       } 
       try {
        const deletedRole = await RoleModel.deleteRole(id);
        if (deletedRole.rowCount !== 0) {
            res.status(200).json(deletedRole);
        } else {
            logger.error(`internal server error in deleting role by id`);
            res.status(500).json({message: 'Internal server error'});
        }
       } catch (error) {
        logger.error(`Error deleting role with id ${id} : ${error.message}`)
          next(error);
        //res.status(500).json({message: 'Internal server error'});
       }
    },

}

module.exports = RoleController;
