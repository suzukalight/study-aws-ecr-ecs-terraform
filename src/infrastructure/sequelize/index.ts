import { Sequelize, Config, Options } from 'sequelize';
import dotenv from 'dotenv';

dotenv.config();

type ConfigMap = {
  [key: string]: Options;
};

const configMap: ConfigMap = require('./config');
const node_env = process.env.NODE_ENV || 'development';
const config = configMap[node_env];

export const sequelize = new Sequelize(config);
