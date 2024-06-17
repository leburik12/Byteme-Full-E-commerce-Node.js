"use strict";
import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/db.js';
import Country from './Country.js';
import State from './State.js';

export default () => {
    class City extends Model {
        static associate(models) {

            City.belongsTo(models.Country, {
                foreignKey: {
                    name: 'id_country',
                    allowNull: false
                },
                as: 'country',
                onDelete: 'NO ACTION',
                onUpdate: 'CASCADE'  
            });
/*
            models.Country.hasMany(models.City, {
                foreignKey: {
                    name: 'id_country',
                    allowNull: false
                },
                as: 'cities',
                onDelete: 'NO ACTION',
                onUpdate: 'CASCADE'
            });
*/
            this.belongsTo(models.State, {
                foreignKey: {
                    name: 'id_state',
                    allowNull: false,
                },
                 as: 'state',
                 onDelete: 'NO ACTION',
                 onUpdate: 'CASCADE'
            });
/*
            models.State.hasMany(models.City, {
                foreignKey: {
                    name: 'id_state',
                    allowNull: false
                },
                as: 'cities',
                onUpdate: 'NO ACTION',
                onDelete: 'CASCADE'
            });
*/
        }

    }

    City.init(
        {
          id: {
            type:DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false
          },
          city_name : {
            type: DataTypes.STRING(30),
            allowNull: false
          },
          geom_location: {
            type: DataTypes.GEOMETRY('POINT',4326),
            allowNull: true
           },
           
          id_country: {
            type: DataTypes.INTEGER,
            references: {
                model: 'Country',
                key: 'id',
            }
          },
          id_state : {
            type: DataTypes.INTEGER,
            references: {
                model: 'State',
                key: 'id'
            },
          }
        },

        {
            sequelize,
            modelName: 'City',
            tableName: 'city',
            paranoid: true,
            indexes: [
                {
                    fields: ['city_name'],
                    name: 'idx_city_name'
                },
                {
                    fields: ['geom_location'],
                    using: 'GIST',
                    name: 'idx_city_geom_location',
                }
            ]
        });

        return City;
}