"use strict";
import { DataTypes, Model } from 'sequelize';
import sequelize from '../config/db.js';

export default () => {
    class Role extends Model {
        static associate(models) {
            
        }
    }

Role.init(
        {
           id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primaryKey: true,
            allowNull: false
           },
           roleName: {
            type: DataTypes.STRING(30),
            allowNull: false,
            field: 'role_name'
           },
           description: {
            type: DataTypes.STRING(4),
            allowNull: false,
           },
           isActive: {
            type: DataTypes.BOOLEAN,
            defaultValue: true,
            field: 'is_active',
           }
    },      
        {
           sequelize,
           modelName: 'Role',
           tableName: 'roles',
           paranoid: true,   // soft delete 
           timestamps: true
        }
    );

 return Role;
}
