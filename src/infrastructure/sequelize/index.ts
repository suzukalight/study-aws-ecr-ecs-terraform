import { Sequelize, Options } from 'sequelize';

require('dotenv').config();

type ConfigMap = {
  [key: string]: Options;
};

const configMap: ConfigMap = require('./config');
const nodeEnv = process.env.NODE_ENV || 'development';
const config = configMap[nodeEnv] || configMap.development;

// FIXME
config.host = process.env.DB_HOST;

export const sequelize = new Sequelize(config);
