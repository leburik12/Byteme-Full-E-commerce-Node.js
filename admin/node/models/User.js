"use strict";
import { Model,DataTypes } from 'sequelize';
import sequelize from '../config/db.js';
import Role from './Role.js';
import Sequelize from 'sequelize';

export default () => {
    class User extends Model {
        static associate(models) {

          this.belongsTo(models.Role, {
            foreignKey : {
              name: 'id_role',
              allowNull: false
            },
            as: 'role',
            onDelete: 'NO ACTION',
            onUpdate: 'CASCADE',
          });
        }
    }

    User.init(
        {
           id: {
             type:DataTypes.INTEGER,
             autoIncrement: true,
             primaryKey: true,
             allowNull: false,    
           },
           
           id_role: {
            type: DataTypes.INTEGER,
            references : {
               model: Role,
               key: 'id'
            },
            defaultValue: 1
           },
           
           id_byteme : {
            type: DataTypes.UUID,
            defaultValue: sequelize.literal('uuid_generate_v4()'),
            allowNull: false,
           },
           first_name : {
            type: DataTypes.STRING(30),
            allowNull: false
           },
           last_name : {
            type: DataTypes.STRING(30),
            allowNull: false
           },
           phone: {
            type: DataTypes.STRING(15),
            allowNull: false
           },
           gender:{
             type: DataTypes.BOOLEAN,
             allowNull: false
           },
           identification_type: {
              type: DataTypes.SMALLINT,  /* 'passport', 'international_id','driving licence' */
              allowNull: true
           },
           email: {
            type: DataTypes.STRING(255),
            allowNull: false,
            unique: true
           },
           password_hash: {
            type: DataTypes.STRING(60),
            allowNull: false
           },
           is_active: {
            type: DataTypes.BOOLEAN,
            defaultValue: true,
            allowNull: false
           },
           geom_location : {
             type: DataTypes.GEOMETRY('POINT',4326),
             allowNull: true
           }
        },

        {
          sequelize,
          modelName: 'User',
          tableName: '"user"',
          paranoid: true,
          indexes: [
            {
                fields: ['first_name','last_name'],
                name: 'idx  _user_name'
            },
            {
                fields: ['geom_location'],
                using: Sequelize.GIST,
                name: 'idx_user_geom_location'
            }
          ]
        });

    return User;
}