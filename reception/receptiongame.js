const { createConnection } = require('../db/db');

// 获取资讯
async function fetchGameList(query, pagenum, pagesize) {
    const connection = await createConnection();
    try{
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
      const results = rows.map(row => {
        const imagePaths = row.imagePath.map(item => `http://localhost:3000/${item.pic}`);
            return {
                ...row,
                imagePath: imagePaths
            };
        });
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

  module.exports = {
    fetchGameList
  };