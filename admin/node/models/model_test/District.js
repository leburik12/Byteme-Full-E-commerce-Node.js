"use strict";
import { Model, DataTypes, Sequelize } from 'sequelize';
import sequelize from '../config/db.js';
import City from './City.js'; 

export default () => {
    class District extends Model {
        static associate(models) {
            
            District.belongsTo(models.City, {
                foreignKey: {
                    name: 'id_city',
                    allowNull: false
                },
                as: 'city',
                onDelete : 'NO ACTION',
                onUpdate: 'CASCADE'
            });
            /*
            models.City.hasMany(models.District), {
                foreignKey: {
                    name: 'id_city',
                    allowNull: false
                },
                as: 'districts',
                onDelete: 'NO ACTION',
                onUpdate: 'CASCADE'
            }
            */
        }
    }

    District.init(
        {
          id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primaryKey: true,
            allowNull: false
          },
          district_name: {
            type: DataTypes.STRING(30),
            allowNull: false
          },
          geom_location: {
            type: DataTypes.GEOMETRY('POINT',4326),
            allowNull: true
          },
          
          id_city: {
            type: DataTypes.INTEGER,
            references: {
                Model: City,
                key: 'id'
            },
          },
          
          is_shipping_available: {
            type: DataTypes.BOOLEAN,
            defaultValue: true,
            allowNull: false
          }
        },
        {
          sequelize,
          modelName: 'District',
          tableName: 'districts',
          paranoid: true,
          indexes : [
            {
                fields : ['district_name'],
                name: 'idx_district_name'
            },
            {
                fields: ['geom_location'],
                using: Sequelize.GIST,
                name: 'idx_district_geom_location'
            }
          ]
        });

        return District;
}