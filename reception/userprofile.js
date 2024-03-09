const { createConnection } = require('../db/db');
const bcrypt = require('bcrypt');

 async function saveInfo(uid, userName, email, dolpassword, newpassword) {
    const connection = await createConnection();
    try {
        const [existingUsers] = await connection.execute('SELECT * FROM users WHERE userName = ?', [userName]);
        if (existingUsers.length > 0 && existingUsers[0].uid !== uid) {
            throw new Error('用户名已存在');
        }
        const [rows] = await connection.execute('SELECT * FROM users WHERE uid = ?', [uid]);
        const user = rows[0];
        console.log(user);
        if (dolpassword) {
          const isPasswordValid = await bcrypt.compare(dolpassword, user.password);
          const hashednewpassword = await bcrypt.hash(newpassword, 10);
          if (isPasswordValid) {
              await connection.execute('UPDATE users SET password = ?, userName = ?, email = ? WHERE uid = ?', [hashednewpassword, userName, email, uid]);
          } else {
              throw new Error('旧密码不正确');
          }
        } else {
            await connection.execute('UPDATE users SET userName = ?, email = ? WHERE uid = ?', [userName, email, uid]);
        }
        
        return {
          msg: '修改成功',
        };
      } catch (err) {
        console.error('Error:', err);
        throw err;
      }finally {
        connection.end();
      }
 }

 module.exports = {
    saveInfo,
  };