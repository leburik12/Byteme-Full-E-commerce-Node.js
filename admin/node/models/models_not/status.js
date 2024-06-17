"use strict";
import { Model, DataTypes } from sequelize;
import sequelize from "../config/db";

module.exports = (sequelize) => {
    class Status extends Model {
        static associations(models) {

        }
    }

    Status.init(
    {
       id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false
       },
       status_name: {
        type: DataTypes.STRING(30),
        allowNull: false
       }
    },
    {
        sequelize,
        paranoid: true,
        indexes: [
          {
            fields: ['status_name'],
          }
        ]
    });

    return Status;
}
