"use strict";
import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/db.js';

export default  () => {
    class Country extends Model {
        static associate (models) {

        }
    }

    Country.init (
        {
          id: {
            type: DataTypes.INTEGER,
            autoIncrement:true,
            primaryKey: true,
            allowNull: false
          },
          country_name: {
            type: DataTypes.STRING(50),
            allowNull: false
          },
          country_image_url: {
            type: DataTypes.STRING(255),
            allowNull: false
        },
        country_phone_code: {
           type: DataTypes.STRING(5),
           allowNull: false
        },
    },
        {
          sequelize,
          modelName: 'Country',
          tableName: 'country',
          paranoid: true,
          indexes: [
            {
              fields: ['country_name']  
            },
            {
                fields: ['country_phone_code']
            }
          ]
        });

        return Country;
}