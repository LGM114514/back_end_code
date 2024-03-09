const { createConnection } = require('../db/db');

//权限
async function someAsyncFunction(callback) {
    const connection = await createConnection();
    try {
      const [rows, fields] = await connection.execute('SELECT id, pid, authName, level, path FROM rights');
      callback(null, rows);
    } catch (err) {
      console.error('Error getting rights', err);
      callback(err, null);
    } finally {
      connection.end();
    }
  }

  module.exports = {
    someAsyncFunction,
  };
  