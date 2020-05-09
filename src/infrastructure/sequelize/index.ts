import { Sequelize, Options } from 'sequelize';
import dotenv from 'dotenv';

dotenv.config();

type ConfigMap = {
  [key: string]: Options;
};

const configMap: ConfigMap = require('./config');
const nodeEnv = process.env.NODE_ENV || 'development';
const config = configMap[nodeEnv];

export const sequelize = new Sequelize(config);
