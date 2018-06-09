using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using 数据结构层.DAL;

namespace 业务逻辑层.BLL
{
   public class 数据获取
    {
        数据结构层.DAL.数据管理 数据 = new 数据结构层.DAL.数据管理();
        #region 获取数据
        public DataSet 获取数据(string 执行文本语言, string 表名)
        {
            return (数据.执行参数命令文本(执行文本语言, null, 表名));
        }
        #endregion
    }
}
