const { createConnection } = require('../db/db');

async function  getComment (gid) {
    const connection = await createConnection();
    try{
        const [rows] = await connection.execute('SELECT * FROM Comment WHERE game_infosheetId = ?', [gid]);
        const results = rows;
        return {
            commentlist: results,
        };
    }catch (err) {
        console.error('操作数据库时发生错误:', err);
        return { success: false, message: '操作数据库时发生错误' };
    } finally {
        connection.end();
    }
}

async function  addComment (newComment, userName, gid) {
    const connection = await createConnection();
    try{
        const formattedDate = dateFormat();
        await connection.execute('INSERT INTO Comment (content, createTime, commentator, game_infosheetId) VALUES (?, ?, ?, ?)', [newComment, formattedDate, userName, gid]);
        return {
            txt: '评论成功',
        };
    }catch (err) {
        console.error('操作数据库时发生错误:', err);
        return { success: false, message: '操作数据库时发生错误' };
    } finally {
        connection.end();
    }
}


function dateFormat() {
    const dt = new Date()

    const y = dt.getFullYear()
    const m = (dt.getMonth() + 1 + '').padStart(2, '0')
    const d = (dt.getDate() + '').padStart(2, '0')
  
    const hh = (dt.getHours() + '').padStart(2, '0')
    const mm = (dt.getMinutes() + '').padStart(2, '0')
    const ss = (dt.getSeconds() + '').padStart(2, '0')
    return `${y}-${m}-${d} ${hh}:${mm}:${ss}`
}

module.exports = {
    getComment,
    addComment
  };