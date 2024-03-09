const express = require('express');
const router = express.Router();

const {saveInfo} = require('../reception/userprofile');

//获取资讯列表
router.post('/userprofile', async (req, res) => {
    
    try {
      const {uid, userName, email, dolpassword, newpassword} = req.body;
      console.log(req.body);
      const results = await saveInfo(uid, userName, email, dolpassword, newpassword);
      res.json({
        meta: { results, status: 200 }
      });
    } catch (error) {
      if (error.message === '用户名已存在') {
        res.status(400).send('用户名已存在');
    } else if (error.message === '旧密码不正确') {
        res.status(401).send('旧密码不正确');
    } else {
        console.error('Error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
    }
});

module.exports = router;