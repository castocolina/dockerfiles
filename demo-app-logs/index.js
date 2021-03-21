const CronJob = require('cron').CronJob;
const winston = require('winston');
const nconf = require('nconf');

nconf.defaults({
    'LOGS_FOLDER': 'logs',
    'FILE_NAME': 'output.log',
    'FILE_MAX_SIZE_BYTES': 1024 * 5,
    'MAX_FILES': 100,
    'TAILABLE': true,
  });

const LOGS_FOLDER = nconf.get('LOGS_FOLDER');
const FILE_NAME = nconf.get('FILE_NAME');
const MAX_SIZE_BYTES = nconf.get('FILE_MAX_SIZE_BYTES');
const MAX_FILES = nconf.get('MAX_FILES');
const TAILABLE = nconf.get('TAILABLE');
console.log(`logs folder target: ${LOGS_FOLDER}/${FILE_NAME}`)


const logConfiguration = {
    transports: [
        new winston.transports.Console(),
        // new winston.transports.Console({
        //     level: 'debug'
        // }),
        new winston.transports.File({
            level: 'debug',
            // Create the log directory if it does not exist
            filename: `${LOGS_FOLDER}/${FILE_NAME}`,
            maxsize: MAX_SIZE_BYTES,
            maxFiles: MAX_FILES,
            tailable: TAILABLE
        })
    ],
    format: winston.format.combine(
        winston.format.label({
            label: `Label🏷️`
        }),
        winston.format.timestamp({
           format: 'MMM-DD-YYYY HH:mm:ss'
       }),
        winston.format.printf(info => `${info.level}: ${info.label}: ${[info.timestamp]}: ${info.message}`),
    )
};

const logger = winston.createLogger(logConfiguration);

var job = new CronJob('* * * * * *', function() {
  logger.info('You will see this message every second *********************************************************');
}, null, true, 'America/Los_Angeles');
job.start();