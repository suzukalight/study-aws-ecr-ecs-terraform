import { Sequelize } from 'sequelize';

export const sequelize = new Sequelize('terraform', 'root', undefined, {
  dialect: 'mysql',
});
