using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace 业务逻辑层.dll
{
   
   public class 用户管理
    {
        数据结构层.DAL.数据管理 数据 = new 数据结构层.DAL.数据管理();

        #region 数据模型
        private int pr班级编号;
        private int pr性别;
        private int pr座号;
        private string pr姓名;

        public int 班级编号
        {
            get { return pr班级编号; }
            set { pr班级编号 = value; }
        }
        public int 性别
        {
            get { return pr性别; }
            set { pr性别 = value; }
        }
        public int 座号
        {
            get { return pr座号; }
            set { pr座号 = value; }
        }
        public string 姓名 {
            get { return pr姓名; }
            set { pr姓名 = value; }
        }
        #endregion

        #region 添加用户
        public int 添加用户(用户管理 用户)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@班级编号",SqlDbType.Int,0,用户.班级编号),
                               数据.输入参数("@座号",SqlDbType.Int,0,用户.座号),
                               数据.输入参数("@性别",SqlDbType.Bit,0,用户.性别),
                               数据.输入参数("@姓名",SqlDbType.VarChar,20,用户.姓名)
                               };
            return (数据.执行参数修改("insert into 用户 (姓名,座号,性别,班级编号,头像位置,密码,昵称) values (@姓名,@座号,@性别,@班级编号,'../images/userhead/default.jpg','e10adc3949ba59abbe56e057f20f883e','学生')",参数));
        }
        #endregion
    }
}
