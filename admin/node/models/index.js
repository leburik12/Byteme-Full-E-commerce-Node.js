"use strict";
import fs from 'fs';
import { dirname,basename,join } from 'path';
import path  from 'path';
import sequelize from '../config/db.js'
import { Sequelize } from 'sequelize';
import { fileURLToPath } from 'url';
import { createRequire } from 'module';
const models = {};  // Object to store all imported models
const require = createRequire(import.meta.url);

const __filename = fileURLToPath(import.meta.url);
const __dirname =  dirname(__filename);

fs.readdirSync(__dirname)
  .filter(file => file != basename(__filename) && file.endsWith('.js'))
  .forEach(
    async file => {
      try {

      const module = await import(join(__dirname,file));
      const model = module.default(sequelize,Sequelize);
      models[model.name] = model;

    } catch (error) {
      console.error(`Error initalizing model from file ${file}: `,error);
    }
    });

Object.keys(models).forEach((modelName) => {
  if (models[modelName].associate) {
    models[modelName].associate(models);
  }
});

export default models;
 /*
fs.readdirSync(__dirname)
   .filter(file => file != basename(__filename) && file.endsWith('.js'))
   .forEach(
    async file => {
    const model = require(join(__dirname,file))(sequelize);
    models[model.name] = model;
   })   

 fs.readdirSync(__dirname)
   .forEach((file) => { 
      if (file !== path.basename(__filename) && file.endsWith('.js')) {
        const model = require(path.join(__dirname,file))(sequelize,Sequelize.DataTypes);
        models[model.name] = model;
      }
   });
   */
/*
Object.keys(db).forEach(modelName => {
  if (db[modelName].associate) {
    db[modelName].associate(db);
  }
}); 
db.sequelize = sequelize;
db.Sequelize = Sequelize;
*/

