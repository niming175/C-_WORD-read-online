using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace 业务逻辑层.dll
{
    public class 辅导员管理
    {
        数据结构层.DAL.数据管理 数据 = new 数据结构层.DAL.数据管理();
        #region 学期数据类型
        private int pr班级编号;
        private int pr课任编号;
        private int pr学期号;
        public int 班级编号
        {
            get { return pr班级编号; }
            set { pr班级编号 = value; }
        }
        public int 课任编号
        {
            get { return pr课任编号; }
            set { pr课任编号 = value; }
        }
        public int 学期号
        {
            get { return pr学期号; }
            set { pr学期号 = value; }
        }


        private int pr学期编号;
        public int 学期编号
        {
            get { return pr学期编号; }
            set { pr学期编号 = value; }

        }
        private string pr密码;
        public string 密码
        {
            get { return pr密码; }
            set { pr密码 = value; }
        }
        private int pr辅导员编号;
        public int 辅导员编号
        {
            get { return pr辅导员编号; }
            set { pr辅导员编号 = value; }
        }
        #endregion


        #region 添加学期
        public int 添加学期(辅导员管理 辅导员)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@班级编号",SqlDbType.Int,0,辅导员.班级编号),
                               数据.输入参数("@课任编号",SqlDbType.Int,0,辅导员.课任编号),
                               数据.输入参数("@学期号",SqlDbType.Int,0,辅导员.学期号)};
            return (数据.执行参数修改("insert into 学期(班级编号,课任编号,学期号) values (@班级编号,@课任编号,@学期号)", 参数));
 
        }
        #endregion

        #region
        public int 删除学期课程(辅导员管理 辅导员)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@学期编号",SqlDbType.Int,0,辅导员.学期编号)};
            return (数据.执行参数修改("delete from 学期 where 学期编号=@学期编号", 参数));
        }
        #endregion

        #region 修改辅导员密码
        public int 修改辅导员密码(辅导员管理 辅导员)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@密码",SqlDbType.VarChar,32,辅导员.密码),
                               数据.输入参数("辅导员编号",SqlDbType.Int,0,辅导员.辅导员编号)};
            return (数据.执行参数修改("update 辅导员 set 密码=@密码 where 辅导员编号=@辅导员编号", 参数));
        }
        #endregion
    }
}
