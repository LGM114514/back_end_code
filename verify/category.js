const { createConnection } = require('../db/db');

//获取分类列表
async function getCategoryData(pagenum, pagesize, callback) {
  const connection = await createConnection();
    try {
      const startIndex = (pagenum - 1) * pagesize;
  
  
      let sql = 'SELECT * FROM category';
      const values = [];
      if (pagesize) {
        sql += ` LIMIT ${pagesize} OFFSET ${startIndex}`;
        values.push(pagesize, startIndex);
      }
      const [rows] = await connection.execute(sql, values);
      const result = rows;
  
      const [totalRows] = await connection.execute('SELECT COUNT(*) as total FROM category');
      const total = totalRows[0].total;
      const response = {
          pagenum: Number(pagenum),
          pagesize: Number(pagesize),
          result,
          total
      }
      callback (null,response)
    } catch (err) {
      console.error('数据库查询错误:', err);
      callback({ status: 500, msg: '服务器内部错误' }, null);
    } finally {
      connection.end(); // 关闭数据库连接
    }
  }
 
 // 拿前两级的数据
 async function getParentCateList(callback) {
   const connection = await createConnection();
   try{
       const [rows] = await connection.execute('SELECT * FROM category');
        
         // 进行筛选操作，只保留特定数据
         const result = rows
         .filter(item => item.cat_level < 1)
         .map(item => ({
           cat_id: item.cat_id,
           cat_pid: item.cat_pid,
           cat_Name: item.cat_Name,
           cat_level: item.cat_level,
           children: item.children ? item.children.map(child => ({
             cat_id: child.cat_id,
             cat_pid: child.cat_pid,
             cat_Name: child.cat_Name,
             cat_level: child.cat_level
           })) : [],
         }));
         const response = {result}
         callback (null, response);
      }catch (err) {
       console.error('数据库查询错误:', err);
       callback({ status: 500, msg: '服务器内部错误' }, null);
     } finally {
       connection.end(); // 关闭数据库连接
     }
 }
 
 // 添加分类 （有问题添加二级分类会覆盖之前的）
 async function addCategory(cat_Name, cat_pid, cat_level) {
   const connection = await createConnection();
 
   try {
      // 参数验证
      if (typeof cat_pid !== 'number' || typeof cat_level !== 'number') {
        return { success: false, message: 'cat_pid 和 cat_level 必须是有效的数字' };
      }
    
      const [countResult] = await connection.execute('SELECT COUNT(*) AS count FROM category');
      const totalCount = countResult[0].count;
    
    
      const cat_id = totalCount + 1;
    
      if (cat_pid === 0) {
          const result = await connection.execute(
            'INSERT INTO category (cat_id, cat_pid, cat_Name, cat_level) VALUES (?, ?, ?, ?)',
            [cat_id, cat_pid, cat_Name, cat_level]
          );
          return { success: true, message: '成功添加新数据', data: { cat_id: result.insertId } };
      } else {
       const result = await connection.execute(
         'SELECT * FROM category WHERE cat_id = ?',
         [cat_pid]
       );
 
       if (result.length === 0) {
         return { success: false, message: '指定的cat_id不存在' };
       }
       
       const cat_id2 = cat_pid+5 ;
       const parentCategory = result[0];
       const children = parentCategory.children || [];
       children.push({
         cat_id: cat_id2,
         cat_pid,
         cat_Name,
         cat_level,
         children: []
       });
 
      //  console.log(JSON.stringify(children))
 
       if (cat_id2 > 10){
          const firstItem = children[0];
          let  cat_id3 = firstItem.cat_id + firstItem.cat_pid ;

          // 检查 cat_id3 是否已存在
          const [existingResult] = await connection.execute(
            'SELECT COUNT(*) AS count FROM category WHERE JSON_UNQUOTE(JSON_EXTRACT(children, \'$[0].children[0].cat_id\')) = ?',
            [cat_id3]
          );

          if (existingResult[0].count > 0) {
            // 如果存在，加1
            cat_id3 += 1;
          }
          await connection.execute(
            `UPDATE category SET children = JSON_ARRAY_APPEND(
              children,
              '$[0].children',
                JSON_OBJECT(
                  'cat_id', ?,
                  'cat_pid', ?,
                  'cat_Name', ?,
                  'cat_level', ?,
                  'children', null
              )
            )
            WHERE JSON_UNQUOTE(JSON_EXTRACT(children, '$[0].cat_id')) = ?;`,
            [cat_id3, firstItem.cat_pid, firstItem.cat_Name, firstItem.cat_level, cat_pid]
          );
        } else {
          await connection.execute(
            'UPDATE category SET children = ? WHERE cat_id = ?',
            [JSON.stringify(children), cat_pid]
          );
        }
 
       return { success: true, message: '成功在children中添加新数据' };
     }
   } catch (err) {
     console.error('操作数据库时发生错误:', err);
     return { success: false, message: '操作数据库时发生错误' };
   } finally {
     connection.end();
   }
 }
 
 module.exports = {
    getCategoryData,
    getParentCateList,
    addCategory,
  };