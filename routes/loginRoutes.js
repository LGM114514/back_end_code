const express = require('express');
const router = express.Router();

const {authenticateUser, getShopData} = require('../verify/login');

//验证用户
router.post('/login', async (req, res) => {
    try {
      const { username, password } = req.body;
      const response = await authenticateUser(username, password);
      if (response.status === 200) {
        // 登录成功，返回令牌给客户端
        // console.log(response.user)
        res.status(response.status).json({ status: response.status, userInfo: response.user, message: response.message, token: response.token });
      } else {
        res.status(response.status).json({ message: response.message });
      }
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  
  // 获取菜单信息
router.get('/menus', async (req, res) => {
    try {
      // 从数据库模块中获取数据
      const shopData = await getShopData();
  
      // 构建响应数据
      const response = {
        data: shopData,
        meta: {
          msg: '获取菜单列表成功',
          status: 200,
        },
      };
  
      // 发送JSON响应
      res.json(response);
    } catch (error) {
      console.error('Error:', error);
      res.status(500).json({ error: '服务器内部错误' });
    }
  });

  module.exports = router;