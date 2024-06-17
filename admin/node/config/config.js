import dotenv from 'dotenv';
dotenv.config();


export const databaseConfig = {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
    username: process.env.DB_USER,
    password: process.env.DB_PASS,
    db_dialect: process.env.DB_DIALECT
};

export const redisConfig = {
   redis_host: process.env.REDIS_HOST,
   redis_port: process.env.REDIS_PORT,
   redis_pass: process.env.REDIS_PASS,  // Optional if password is required
   redis_prefix : process.env.REDIS_KEY_PREFIX,
   db:0  // Optional, default database index (can be changed)
};

export const authConfig = {
    jwtSecret : process.env.JWT_TOKEN
}

export const serverConfig = {
    host: 'localhost',
    port: 3000
}

export const loggingConfig = {
    level: 'info',
    filePath: ''
}

export const cacheConfig = {
    host: 'local'
}
