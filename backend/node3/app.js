'use-strict'
const cluster = require('cluster');
const os = require('os');
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const multer = require('multer');
const { Server } = require('socket.io');

const logger = require('./config/logger.js');
const errorHandler = require('./middlewares/errorHandler.js');
const rolesRoute = require('./routes/roleRoute.js');
const userRoute = require('./routes/userRoute.js');
const categoryRoute = require('./routes/categoryRoute.js');
const productRoute = require('./routes/productRoute.js');
const inventoryRoute = require('./routes/inventoryRoute.js');
const storeRoute = require('./routes/storeRoute.js');
const chatRoute = require('./routes/chatRoute.js');
const brandRoute = require('./routes/brandRoute.js');


if (cluster.isMaster) {
    // Determine the number of CPU cores
    const numCpus = os.cpus().length;
    logger.info(`Master ${process.pid} is running`);

    // Fork workers for each CPU core
    for (let i = 0; i < numCpus; i++) {
        cluster.fork();
    }
    // Listen for dying workers and restart them
    cluster.on('exit', (worker, code, signal) => {
        logger.info(`Worker ${worker.process.pid} died`);
        if (signal) {
            logger.info(`worker was killed by signal: ${signal}`);
        } else if (code !== 0) {   
             logger.info(`worker was exited with error code: ${code}`);
        } else {
             logger.info(`worker success`);
        }
     
      logger.info(`Starting a new worker`);
      cluster.fork();
    });
} else {
 // put all the code below   in server.js and 
 // require('./server.js')()
const port = process.env.PORT || 3000;
const app = express();

app.use(cors());
app.use(express.json());
app.use(bodyParser.urlencoded({extended:true}));
app.use((req,res,next) => {
    logger.info({method: req.method, url: req.url});
    next();
});

app.use('/api/roles/',rolesRoute);
app.use('/api/users/',userRoute);
app.use('/api/categories/',categoryRoute);
app.use('/api/products/',productRoute);
app.use('api/inventory/',inventoryRoute);
app.use('api/brand/', brandRoute);
app.use('api/store/', storeRoute);
app.use('api/chat/', chatRoute);

app.use(errorHandler);

const startServer = () => {
    app.listen(port, () => {
       console.log(`Sever is running in port ${port}`);
    });
};
/*
process.on('SIGINT', () => {
    pool.end().then(() => {
        logger.info('Pool has been closed');
        process.exit(0);tele
    });
});
*/
startServer();
}