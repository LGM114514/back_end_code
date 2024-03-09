const express = require('express');
const router = express.Router();

const {getUsers, getUserInfo, updateUserState,addUser, deleteUser}= require('../verify/users');

//获取/查询用户信息
router.get('/users', (req, res) => {
    const { query, pagenum, pagesize } = req.query;
  
    getUsers(query, pagenum, pagesize, (err, result) => {
      if (err) {
        return res.status(err.status).json({ meta: { msg: err.msg, status: err.status } });
      }
      res.json({
        data: result,
        meta: { msg: '获取数据成功', status: 200 },
      });
    });
});

// PUT接口处理
router.put('/users/:uid/state/:type', async (req, res) => {
    const { uid, type } = req.params;
    if (!uid || (type !== 'true' && type !== 'false')) {
      return res.status(400).json({ meta: { msg: '请求参数不合法', status: 400 } });
    }
    try {
      // 更新用户状态
      const affectedRows = await updateUserState(uid, type);
  
      if (affectedRows === 0) {
        return res.status(404).json({ meta: { msg: '用户不存在', status: 404 } });
      }
  
      // 查询更新后的用户数据
      const updatedUser = await getUserInfo(uid);
      res.json({
        data: updatedUser,
        meta: { msg: '设置状态成功', status: 200 },
      });
    } catch (err) {
      console.error('服务器内部错误:', err);
      res.status(500).json({ meta: { msg: '服务器内部错误', status: 500 } });
    }
});

//新增用户
router.post('/users', async (req, res) => {
  const { username, password, email } = req.body;

  if (!username || !password || !email) {
    return res.status(400).json({ meta: { msg: '请求参数不能为空', status: 400 } });
  }

  try {
    const responseData = await addUser(username, password, email);

    res.json({
      data: responseData,
      meta: { msg: '用户创建成功', status: 201 }
    });
  } catch (error) {
    console.error(error); 
    res.json({ meta: { msg: error, status: 500 } });
  }
});

//删除用户
router.delete('/users/:id', async (req, res) => {
    const userId = req.params.id;
  
    try {
      const deleted = await deleteUser(userId);
      if (deleted) {
        res.status(200).json({
          data: null,
          meta: {msg: '删除成功',status: 200}
        });
      } else {
        res.status(404).json({
          meta: { msg: '用户不存在或者删除失败',status: 404}
        });
      }
    } catch (error) {
      console.error('Error deleting user:', error);
      res.status(500).json({
        meta: {msg: '服务器错误',status: 500}
      });
    }
});

module.exports = router;