const { createConnection } = require('../db/db');
const bcrypt = require('bcrypt');
  
  // 获取用户
  async function getUsers(query, pagenum, pagesize, callback) {
    const connection = await createConnection();
  
    try {
      if (!pagenum || !pagesize) {
        return callback({ status: 400, msg: 'pagenum和pagesize不能为空' }, null);
      }
  
      const offset = (pagenum - 1) * pagesize;
  
      let sql = 'SELECT * FROM users';
      const values = [];
  
      if (query) {
        sql += ` WHERE userName LIKE ? `;
        values.push(`%${query}%`);
      } else {
        sql += ` LIMIT ${pagesize} OFFSET ${offset}`;
        values.push(pagesize, offset);
      }
  
      const [results] = await connection.execute(sql, values);
       // 将 mg_state 从整数转换为布尔值
       const users = results.map(user => {
        return {
          ...user,
          mg_state: user.mg_state === 1 ? true : false
        };
      });
      
      const [countResult] = await connection.execute('SELECT COUNT(*) AS total FROM users');
  
      const total = countResult[0].total;
  
      const response = {
        totalpage: Math.ceil(total / pagesize),
        pagenum: parseInt(pagenum),
        users: users,
      };
      callback(null, response);
    } catch (err) {
      console.error('数据库查询错误:', err);
      callback({ status: 500, msg: '服务器内部错误' }, null);
    } finally {
      connection.end(); // 关闭数据库连接
    }
  }
  
  // 更新用户状态
  async function updateUserState(uid, type) {
    const connection = await createConnection();
    let typeInt;
    if (type === 'false') {
      typeInt = 0;
    } else if (type === 'true') {
      typeInt = 1;
    } else {
      throw new Error('type must be a boolean value');
    }
    try {
      // 更新用户状态
      const [result] = await connection.execute(
        'UPDATE users SET mg_state = ? WHERE uid = ?',
        [typeInt, uid]
      );
      return result.affectedRows;
    } catch (err) {
      console.error('数据库查询错误:', err);
      throw err;
    }finally {
      connection.end(); // 关闭数据库连接
    }
  }
  
  // 获取用户信息
  async function getUserInfo(uid) {
    const connection = await createConnection();
  
    try {
      // 查询用户信息
      const [user] = await connection.execute(
        'SELECT * FROM users WHERE uid = ?',
        [uid]
      );
      return user[0];
    } catch (err) {
      console.error('数据库查询错误:', err);
      throw err;
    }finally {
      connection.end(); // 关闭数据库连接
    }
  }
  
  //添加用户
  async function addUser(username, password, email) {
    const connection = await createConnection();
    try {
      // 检查是否存在相同的用户名
      const checkSql = 'SELECT COUNT(*) as count FROM users WHERE userName = ?';
      const [checkResults] = await connection.execute(checkSql, [username]);
      const count = checkResults[0].count;
      const hashedPassword = await bcrypt.hash(password, 10);
    if (count > 0) {
      throw '用户名已存在'; // 如果存在相同用户名，抛出错误
    }

      const sql = 'INSERT INTO users (userName, password, email, rightId) VALUES (?, ?, ?, ?)';
      const values = [username, hashedPassword, email, 0];
  
      const [results] = await connection.execute(sql, values);
      return results;
    } catch (error) {
      console.error('Error inserting user:', error);
      throw '用户名已存在,创建用户失败';
    }finally {
      connection.end(); // 关闭数据库连接
    }
  }
  
  //删除用户
  async function deleteUser(id) {
    const connection = await createConnection();
  
    try {
      const sql = 'DELETE FROM users WHERE uid = ?';
      const [results] = await connection.execute(sql, [id]);
  
      return results.affectedRows > 0; // 如果大于0表示删除成功，否则表示用户不存在或删除失败
    } catch (error) {
      console.error('Error deleting user:', error);
      throw '删除用户失败'; // 返回错误消息
    } finally {
      connection.end();
    }
  }

  module.exports = {
    getUsers,
    getUserInfo,
    updateUserState,
    addUser,
    deleteUser,
  }