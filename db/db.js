const mysql = require('mysql2/promise');

async function createConnection() {
  try {
    const connection = await mysql.createConnection({
      host: 'localhost',
      user: 'root',
      password: '123456',
      database: 'code',
    });
    console.log('已成功连接到MySQL数据库');
    return connection;
  } catch (err) {
    console.error('无法连接到MySQL数据库:', err);
    throw err;
  }
}

module.exports = {
  createConnection,
};