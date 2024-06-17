"use strict";
import { DataTypes,Model } from "sequelize";
import sequelize from "../config/db";

module.exports = (sequelize) => {
    class Product extends Model {
        static associations(models) {

        }
    }

    Product.init(
    {
       id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false
       },
       name: {
        type: DataTypes.STRING(255),
        allowNull: false
       },
       productType: {
        type: DataTypes.SMALLINT,
        allowNull: false,
        field: product_type,
       },
       createdAt: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW,
        field: created_at
       }
    },

    {
        sequelize,
        timestamps: false,
        paranoid: true,
        indexes: [
            {
                fields: ['name'],
            },
            {
                fields: ['productType']
            }
        ]
    });

    return Product;
}
