const { createConnection } = require('../db/db');

// 获取资讯
async function queryGameList(query, pagenum, pagesize) {
    const connection = await createConnection();
    try{
      // if (!pagenum || !pagesize) {
      //   return callback({ status: 400, msg: 'pagenum和pagesize不能为空' }, null);
      // }
      const startIndex = (pagenum - 1) * pagesize;
      let sql = 'SELECT * FROM game_infosheet';
      const values = [];
  
      if (query) {
        sql += ' WHERE title LIKE ?';
        values.push(`%${query}%`);
      } else {
        sql += ` LIMIT ${pagesize} OFFSET ${startIndex}`;
        values.push(pagesize, startIndex);
      }
  
      const [rows] = await connection.execute(sql, values);
      const results = rows;
      
      const [totalRows] = await connection.execute('SELECT COUNT(*) as total FROM game_infosheet');
      const total = totalRows[0].total;
  
      return {
        gamelist: results,
        pagenum: Number(pagenum),
        total,
      };
    }catch (err) {
      console.error('操作数据库时发生错误:', err);
      return { success: false, message: '操作数据库时发生错误' };
    } finally {
      connection.end();
    }
   
  }
    
  //删除资讯
  async function deleteGame(gid) {
    const connection = await createConnection();
  
    try {
      const sql = 'DELETE FROM game_infosheet WHERE gid = ?';
      const [results] = await connection.execute(sql, [gid]);
  
      return results.affectedRows > 0; // 如果大于0表示删除成功，否则表示用户不存在或删除失败
    } catch (error) {
      console.error('Error deleting game:', error);
      throw '删除游戏失败'; // 返回错误消息
    } finally {
      connection.end();
    }
  }
  
  //添加资讯
  async function addGameInfo(addForm) {
    const connection = await createConnection();
    try {
  
      const [rows, fields] = await connection.execute('INSERT INTO game_infosheet (title, content, createTime, caId, author, imagePath) VALUES (?, ?, ?, ?, ?, ?)', [
        addForm.title,
        addForm.game_content,
        addForm.createTime,
        addForm.game_cat,
        addForm.author,
        addForm.pics,
      ]);
      return { 
        gamelist: rows,
        message: '数据添加成功'
      };
    } catch (error) {
      console.error('添加数据出错:', error);
      return { success: false, message: '添加数据出错' };
    }finally {
      connection.end();
     }
  }
  
  module.exports = {
    queryGameList,
    deleteGame,
    addGameInfo
  };