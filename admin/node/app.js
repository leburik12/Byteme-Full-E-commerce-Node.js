import redis from 'redis';
import sequelize from './config/db.js';
import models from './models/index.js';
import express from 'express';

const app = express();
const port = process.env.PORT || 3000;

const initializeDatabase = async () => {
    try {
       await sequelize.authenticate();
    } catch (error) {
       console.error(`Error connecting database ${error}`);
       process.exit(1);
    }

    try {
        await sequelize.sync({force: true});
    } catch (error) {
        console.error(`Error syncing database: ${error}`);
        process.exit(1);
    }
};

const startServer = () => {
    app.listen(port, () => {
       console.log(`Sever is running in port ${port}`);
    });
};

const initializeApp = async () => {
    await initializeDatabase();
    startServer();
};

initializeApp();