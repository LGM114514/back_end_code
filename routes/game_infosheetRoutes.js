const express = require('express');
const router = express.Router();

const {queryGameList, deleteGame, addGameInfo} = require('../verify/game_infosheet');

//获取资讯列表
router.get('/gamelist', async (req, res) => {
    try {
      const { query, pagenum, pagesize } = req.query;
  
      const results = await queryGameList(query, pagenum, pagesize);
  
      res.json({
        data: results,
        meta: { msg: '获取资讯成功', status: 200 }
      });
    } catch (error) {
      console.error('Error:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
});
  
  //删除资讯
router.delete('/delgame/:gid', async (req, res) => {
    const gId = req.params.gid;
  
    try {
      const deleted = await deleteGame(gId);
      if (deleted) {
        res.status(200).json({
          data: null,
          meta: {msg: '删除成功',status: 200}
        });
      } else {
        res.status(404).json({
          meta: {msg: '用户不存在或者删除失败',status: 404}
        });
      }
    } catch (error) {
      console.error('Error deleting user:', error);
      res.status(500).json({
        meta: {msg: '服务器错误',status: 500}
      });
    }
});
  
  //添加资讯
router.post('/game_infosheet', async (req, res) => {
    try {
      const addForm = req.body;
      const result = await addGameInfo(addForm);
  
      res.json({
        data: result,
        meta: { msg: '添加成功', status: 201 }
      });
    } catch (error) {
      console.error('处理请求时出错:', error);
      res.status(500).send('处理请求时出错');
    }
});

module.exports = router;