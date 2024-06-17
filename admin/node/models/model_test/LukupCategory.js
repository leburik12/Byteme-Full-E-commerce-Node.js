"use strict";
import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/db.js';


export default () => {
    class LukupCategory extends Model {
        static associate(models) {
            LukupCategory.belongsTo(models.LukupCategory, {
                as: 'parentCategory',
                foreignKey: 'id_parent_category',
                onDelete: 'NO ACTION',
                onUpdate: 'CASCADE'
            });
/*
            this.hasMany(models.LukupCategory, {
                as: 'subCategory',
                foreignKey:'id_parent_category',
                onDelete: 'NO ACTION',
                onUpdate: 'CASCADE'
            });
*/
        } 
        
    }

    LukupCategory.init(
        {
        id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primaryKey: true,
            allowNull: false
           },
        id_parent_category : {
            type: DataTypes.INTEGER,
            references: {
                model: LukupCategory,
                key: 'id',
            },
            onUpdate: 'CASCADE',
            onDelete: 'NO ACTION',
        },
        name: {
            type: DataTypes.STRING(30),
            allowNull: false,
            unique:true,
        },
        category_type: {
            type: DataTypes.SMALLINT,  /* Food, groceries,book,event */ 
            allowNull: false,
        },
        media_url: {
            type: DataTypes.TEXT,
            allowNull: false,
        },
        upload_date: {
           type: DataTypes.DATE,
           defaultValue: DataTypes.NOW
        },
        update_date: {
            type: DataTypes.DATE,
        }
        },

      {
        sequelize,
        modelName: 'LukupCategory',
        tableName: 'lukup_category',
        paranoid: true,
        indexes: [
           {
             fields: ['name'],
           },
        ],
        timestamps:false
      });  
      
    return LukupCategory;
};
