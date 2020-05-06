import { Sequelize } from 'sequelize';

const db_host = process.env.DB_HOSTNAME!;
const db_name = process.env.DB_DATABASE!;
const db_user = process.env.DB_USERNAME!;
const db_pass = process.env.DB_PASSWORD!;

console.log('Connection host: ', db_host);
console.log('Connection envs: ', db_name, db_user, db_pass);

export const sequelize = new Sequelize(db_name, db_user, db_pass, {
  host: db_host,
  dialect: 'mysql',
  retry: { max: 3 },
});
