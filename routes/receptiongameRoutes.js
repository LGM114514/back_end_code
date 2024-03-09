const express = require('express');
const router = express.Router();

const {fetchGameList} = require('../reception/receptiongame');

//获取资讯列表
router.get('/fetchgame', async (req, res) => {
    try {
      const { query, pagenum, pagesize } = req.query;
      
      const results = await fetchGameList(query, pagenum, pagesize);
      res.json({
        data: results,
        meta: { msg: '创建成功', status: 200 }
      });
    } catch (error) {
      console.error('Error:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
});
module.exports = router;