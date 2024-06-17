"use strict";
import { Model, DataTypes,Sequelize } from 'sequelize';
import sequelize from '../config/db.js';
import Country from './Country.js';

export default (sequelize, Sequelize) => {
    class State extends Model {
        static associate(models) {

           State.belongsTo(models.Country,{
            foreignKey: {
                name: 'id_country',
                allowNull: false
            },
            as: 'country',
            onDelete: 'NO ACTION',
            onUpdate: 'CASCADE',
        });
      /*
          models.Country.hasMany(models.State, {
            foreignKey: {
                name: 'id_country',
                allowNull: false
            },
            as: 'states',
            onDelete: 'NO ACTION',
            onUpdate: 'CASCADE',
          });
      */
        }
    }

    State.init(
      {
        id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primaryKey: true,
            allowNull: false
        },
       state_name: {
        type: DataTypes.STRING(30),
        allowNull: false
       },
       /*
       id_country_ref: {
        type: DataTypes.INTEGER,
        allowNull: false
       },
       */
       geom_location: {
        type: DataTypes.GEOMETRY('POINT',4326),
        allowNull: true
       },
       id_country: {
        type: DataTypes.INTEGER,
        references: {
            model: 'Country',
            key:'id'
        },
        onUpdate:'CASCADE',
        onDelete:'CASCADE'
       },
      },
      {
        sequelize,
        modelName: 'State',
        tableName:'states',
        paranoid: true,
        indexes: [
            {
                fields: ['geom_location'],
                using: 'GIST',
                name: 'idx_state_geom_location',
            },
            {
            fields: ['state_name'],
            name: 'idx_state_name', 
            },
        ]
      });

      return State;
}