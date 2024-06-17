import Sequelize from 'sequelize';
import { databaseConfig } from './config.js';

const sequelize = new Sequelize({
    database: databaseConfig.database,
    username: databaseConfig.username,
    password:databaseConfig.password,
    host: databaseConfig.host,
    dialect: databaseConfig.db_dialect
});

export default sequelize;