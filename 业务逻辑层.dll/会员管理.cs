using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using 数据结构层.DAL;
using System.Data;
using System.Data.SqlClient;

namespace 业务逻辑层.BLL
{
    public class 会员管理
    {
        数据结构层.DAL.数据管理 数据 = new 数据结构层.DAL.数据管理();

        #region 定义数据模型
        private int 保护_用户编号;
        private string 保护_密码;
        private string 保护_手机号;
        private string 保护_昵称;
        private string 保护_姓名;
        private string 保护_邮箱;
        private int 保护_班级编号;
        private string 保护_头像位置;

        public int 用户编号
        {
            get { return 保护_用户编号; }
            set {  保护_用户编号=value; }
        }

        public string 手机号
        {
            get { return 保护_手机号; }
            set { 保护_手机号=value ; }
        }

        public string 密码
        {
            get { return 保护_密码; }
            set { 保护_密码=value; }
        }

        public string 昵称 {
            get { return 保护_昵称; }
            set { 保护_昵称 = value; }
        }
        public string 姓名
        {
            get { return 保护_姓名; }
            set { 保护_姓名 = value; }
        }
        public string 邮箱
        {
            get { return 保护_邮箱; }
            set { 保护_邮箱 = value; }
        }
        public int 班级编号
        {
            get { return 保护_班级编号; }
            set { 保护_班级编号=value; }
        }
        public string 头像位置
        {
            get { return 保护_头像位置; }
            set { 保护_头像位置 = value; }
        }

        #endregion

    


        #region 登录方法
        public DataSet 登录(会员管理 管理)
        {
            SqlParameter[] 参数 ={
                                    数据.输入参数("@手机号",SqlDbType.VarChar,11,管理.手机号),
                                    数据.输入参数("@密码",SqlDbType.VarChar,50,管理.密码),
                                };
            return (数据.执行参数命令文本("select * from 用户 where (手机号=@手机号) and (密码=@密码)", 参数, "用户"));
        }
        #endregion 


        #region 获取数据
        public DataSet 获取数据(string 执行文本语言, string 表名)
        {
            return (数据.执行参数命令文本(执行文本语言, null, 表名));
        }
        #endregion

        #region  注册会员信息
        public int 注册会员(会员管理 管理)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@昵称",SqlDbType.VarChar,20,管理.昵称),
                               数据.输入参数("@密码",SqlDbType.VarChar,50,管理.密码),
                               数据.输入参数("@姓名",SqlDbType.VarChar,20,管理.姓名),
                               数据.输入参数("@手机号",SqlDbType.VarChar,11,管理.手机号),
                               数据.输入参数("@班级编号",SqlDbType.Int,0,管理.班级编号)
                               };
            return (数据.执行参数修改("insert into 用户(昵称,密码,头像位置,手机号,班级编号,姓名) values (@昵称,@密码,'../images/userhead/default.jpg',@手机号,@班级编号,@姓名)", 参数));
        }
        #endregion

        #region 修改用户信息
        public int 修改信息(会员管理 管理)
        {
            SqlParameter[] 参数 = { 
                                数据.输入参数("@昵称",SqlDbType.VarChar,20,管理.昵称),
                                数据.输入参数("@头像位置",SqlDbType.VarChar,100,管理.头像位置),
                                数据.输入参数("@邮箱",SqlDbType.VarChar,50,管理.邮箱),
                                数据.输入参数("@用户编号",SqlDbType.Int,0,管理.用户编号)
                                };
            return (数据.执行参数修改("update 用户 set 昵称=@昵称, 头像位置=@头像位置, 邮箱=@邮箱 where 用户编号=@用户编号",参数));
        }
        #endregion 

        #region 修改密码
        public int 修改密码(会员管理 管理)
        {
            SqlParameter[] 参数 ={
                                   数据.输入参数("@用户编号",SqlDbType.Int,0,管理.用户编号),
                                   数据.输入参数("@密码",SqlDbType.VarChar,50,管理.密码)

                               };
            return (数据.执行参数修改("update 用户 set 密码=@密码 where 用户编号=@用户编号", 参数));
        }
        #endregion 
    }
}
