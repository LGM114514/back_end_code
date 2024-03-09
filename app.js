const express = require('express');
const multer  = require('multer');
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');

// 引入用户路由模块
const userRoutes = require('./routes/userRoutes');
// 引入登录路由模块
const loginRoutes = require('./routes/loginRoutes');
// 引入游戏信息表路由模块
const game_infosheetRoutes = require('./routes/game_infosheetRoutes');
// 引入权限路由模块
const rightsRoutes = require('./routes/rightsRoutes');
// 引入类别路由模块
const categoryRoutes = require('./routes/categoryRoutes');
const receptiongameRoutes = require('./routes/receptiongameRoutes');
const userprofileRoutes = require('./routes/userprofileRoutes');
const commentRoutes = require('./routes/commentRoutes');

// 配置multer以处理文件上传
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'imgs/'); // 指定文件保存的目录为imgs文件夹
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname); // 获取文件扩展名
    const filename = `${Date.now()}${ext}`; // 生成新的文件名
    cb(null, filename);
  }
});
const upload = multer({ storage });

const app = express();
app.use(cors());

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());


// 添加路由
app.use('/', loginRoutes);
// 用户路由
app.use('/', userRoutes);
// 游戏信息表路由
app.use('/', game_infosheetRoutes);
// 权限路由
app.use('/', rightsRoutes);
// 类别路由
app.use('/', categoryRoutes);
app.use('/', receptiongameRoutes);
app.use('/', userprofileRoutes);
app.use('/', commentRoutes);


// 处理文件上传请求
app.post('/upload', upload.single('file'), (req, res) => {
  try {
    // 获取上传后的文件路径
    const filePath = req.file.path;
    const actualPath = filePath.replace(/\\/g, '/');
    const url = `http://localhost:3000/${actualPath}`;
    console.log(actualPath,url)
    // 构造响应数据
    const responseData = {
      data: { tmp_path: actualPath, url: url},
      meta: { msg: '上传成功', status: 200 }
    };

    // 发送响应
    res.json(responseData);
  } catch (err) {
    console.error('上传失败:', err);
    res.status(500).json({ meta: { msg: '上传失败', status: 500 } });
  }
});
// 处理图片请求
app.use('/imgs', express.static('imgs'));


const PORT = 3000;
app.listen(PORT, () => {
  console.log(`服务器已启动，监听端口 ${PORT}`);
});