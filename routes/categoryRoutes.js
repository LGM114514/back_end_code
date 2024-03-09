const express = require('express');
const router = express.Router();

const {getCategoryData, getParentCateList, addCategory} = require('../verify/category');

//获取分类列表
router.get('/categories', async (req, res) => {
  const { type, pagenum, pagesize } = req.query;

  getCategoryData(pagenum, pagesize, (err, result) => {
    if (err) {
      return res.status(err.status).json({ meta: { msg: err.msg, status: err.status } });
    }
    return res.json({
      data: result,
      meta: { msg: '获取数据成功', status: 200 },
    });
  });
});
  
  //获取分类前两级的数据
router.get('/parentCateList', async (req, res) => {
    getParentCateList((err, result) => {
      if (err) {
        return res.status(err.status).json({ meta: { msg: err.msg, status: err.status } });
      }
      return res.json({
        data: result,
        meta: { msg: '获取数据成功', status: 200 },
      });
    });
});
  
  //创建分类
router.post('/categories', async (req, res) => {
    try {
      const { cat_name, cat_pid, cat_level } = req.body;
      // console.log(cat_name)
      const result = await addCategory(cat_name, cat_pid, cat_level);
      // console.log(result)
      res.json({
        data: result,
        meta: { msg: '创建分类成功', status: 201 },
      
      });
    } catch (err) {
      console.error('处理请求时发生错误:', err);
      res.status(500).json({ success: false, message: '服务器错误' });
    }
});

module.exports = router;