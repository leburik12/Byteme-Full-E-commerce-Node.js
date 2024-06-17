const pino = require('pino');
const pretty = require('pino-pretty');

const prettyStream = pretty({
    colorize: true,
    translateTime: 'yyyy-mm-dd HH:MM:ss',
    ignore: 'pid,hostname'
});

const logger = pino({
    level: process.env.LOGLEVEL || 'info',
}, prettyStream);

module.exports = logger;


