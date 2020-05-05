import { Sequelize } from 'sequelize';

const db_name = process.env.DB_DATABASE!;
const db_user = process.env.DB_USERNAME!;
const db_pass = process.env.DB_PASSWORD!;

export const sequelize = new Sequelize(db_name, db_user, db_pass, {
  dialect: 'mysql',
  retry: { max: 3 },
});
