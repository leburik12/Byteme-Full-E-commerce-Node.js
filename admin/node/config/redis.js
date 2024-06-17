import redis from 'redis';
import { redisConfig } from './config';

let client;

const RedisConnect = async () => {
   client = redis.createClient(redisConfig);
   client.on('error', err => {
    console.log('Redis Client error');
   });
   await client.connect();
   console.log('Connected to Redis');
};

const getClient = () => {
    if (!client) {
        throw new Error('Redis client not connected');
    }
    return client;
};

module.exports = { connect, getClient };

/*
const { RedisConnect, getClient } = require('./redisService');
let redisClient;
(async () => {
  await RedisConnect(); // Connect to Redis
  redisClient = getClient();
})() */

