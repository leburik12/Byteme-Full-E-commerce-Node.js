const { Pool } = require('pg');
const redis = require('redis');
const logger = require('../config/logger.js');
require('dotenv').config();

const redisClientConfig = {
	host: process.env.REDIS_HOST,
	port: process.env.REDIS_PORT,
	retry_strategy: (options) => {
		if (options.attempt > 5) {
			return new Error('Retry attemps exhausted');
		}

		return (options.attempt * 1000);
	},
};

const pool = new Pool({ 
 	user:process.env.DB_USER,
	host: process.env.DB_HOST,
	database: process.env.DB_NAME,
	password: process.env.DB_PASS,
	port: process.env.DB_PORT
});
const redisClient = redis.createClient(redisClientConfig);

(async () => {
   await redisClient.connect();
})();

pool.on('error', (err) => {
   logger.error(`Postgresql pool error: ${err}`);
});

redisClient.on('connect', () => {
   logger.info('**** Redis connection was successfull.');
});

redisClient.on('error', (err) => {
    console.error('Redis client error: ',err);
});


const checkConnection = async () => {
try {
    const res = await pool.query('SELECT NOW()');
	logger.info(`Connected to the database yesssss : ${res.rows[0].now}`);
} catch (error) {
    logger.error(`Error connection to the database: ${error}`);
   } 
}
checkConnection();

module.exports = { pool , redisClient };

