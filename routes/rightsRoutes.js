const express = require('express');
const router = express.Router();

const {someAsyncFunction} = require('../verify/rights');
//获取权限列表
router.get('/rights', (req, res) => {
    someAsyncFunction((error, results) => {
      if (error) {
        console.error('Error in someAsyncFunction', error); // 输出错误信息
        return res.status(500).json({ msg: '获取权限列表失败', status: 500 });
      }
      const response = {
        data: results,
        meta: {
          msg: '获取权限列表成功',
          status: 200
        }
      };
      // console.log(response)
      res.json(response);
    });
  });

  module.exports = router;