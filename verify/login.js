const jwt = require('jsonwebtoken');
const { createConnection } = require('../db/db');
const bcrypt = require('bcrypt');

const SECRET_KEY = process.env.SECRET_KEY || "LGDD";

//验证用户
async function authenticateUser(username, password) {
  try {
    const db = await createConnection();
    const [rows] = await db.execute('SELECT * FROM users WHERE username = ?', [username]);

    if (rows.length === 0) {
      return { status: 401, message: '用户不存在' };
    }

    const user = rows[0];
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return { status: 401, message: '密码不正确' };
    }
    console.log(user);
    if (user.rightId === 1) {
    const tokenPayload = { userId: user.id, username: user.username, isAdmin: true  };
    const adminToken  = jwt.sign(tokenPayload, SECRET_KEY, {
      expiresIn: '6h',
    });
    return { status: 200, user: user, message: '管理员登录成功', token: adminToken };
   }else{
    return { status: 200, user: user, message: '普通用户登录成功'};
   }

  } catch (error) {
    console.error('查询数据库时出错:', error);
    throw { status: 500, message: '服务器错误' };
  }
}

// 获取菜单
async function getShopData() {
  const connection = await createConnection();
  try {
    const [rows] = await connection.execute('SELECT * FROM list');
    return rows;
  } catch (error) {
    console.error('Error:', error);
    throw error;
  } finally {
    connection.end(); // 关闭数据库连接
  }
}

module.exports = {
  authenticateUser,
  getShopData,
};
