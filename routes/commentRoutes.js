const express = require('express');
const router = express.Router();
const {getComment, addComment} = require('../reception/comment');

//获取评论列表
router.get('/comments', async (req, res) => {
    try{
        const {gid} = req.query;
        const results = await getComment(gid);
        res.json({
            data: results,
            meta: { msg: '获取资讯成功', status: 200 }
          });
  
    }catch (error) {
        console.error('Error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
      }
  });

  router.post('/addComment', async (req, res) => {
    try {
      // 从请求体中获取表单数据
      const { newComment, userName, gid } = req.body;
      const results = await addComment(newComment, userName, gid);
      res.json({
        meta: { msg: results, status: 200 }
      });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
      }
  });
  module.exports = router;