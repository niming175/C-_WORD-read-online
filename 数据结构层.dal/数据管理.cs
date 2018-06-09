using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace 数据结构层.DAL
{
    public class 数据管理
    {
        /*
         * 
         * 
         */
        private SqlConnection 连接;//创建连接对象
        #region 打开数据库连接
        private void 打开()
        {
            if (连接 == null)
            {
                连接 = new SqlConnection(ConfigurationManager.AppSettings["连接字段"]);
            }
            try
            {
                if (连接.State == System.Data.ConnectionState.Closed)
                    连接.Open();
            }
            catch (SqlException E)
            {

                this.关闭();
                throw new Exception(E.Message);
            }
        }
        #endregion
        #region 关闭连接
        private void 关闭()
        {
            if (连接 != null)
            {
                连接.Close();
            }
        }
        #endregion
        #region 将命令文本添加到sqldataadapter
        private SqlDataAdapter 创建适配器(string 参数名, SqlParameter[] 参数)
        {
            this.打开();
            SqlDataAdapter 适配器 = new SqlDataAdapter(参数名, 连接);
            适配器.SelectCommand.CommandType = CommandType.Text;
            if (参数 != null)
            {
                foreach (SqlParameter 参数组 in 参数)
                {
                    适配器.SelectCommand.Parameters.Add(参数组);
                }
            }
            return 适配器;
        }
        #endregion
        #region 将命令文本添加到sqlcommand
        private SqlCommand 创建命令(string 参数名, SqlParameter[] 参数)
        {
            this.打开();
            SqlCommand 命令 = new SqlCommand(参数名, 连接);
            命令.CommandType = CommandType.Text;
            if (参数 != null)
            {
                foreach (SqlParameter 参数组 in 参数)
                    命令.Parameters.Add(参数组);
            }
            return 命令;
        }
        #endregion
        #region 传入参数并且转换为sqlParameter类型
        public SqlParameter 输入参数(string 参数名, SqlDbType 数据类型, int 大小, object 值)
        {
            SqlParameter 参数;
            if (大小 > 0)
            {
                参数 = new SqlParameter(参数名, 数据类型, 大小);
            }
            else
            {
                参数 = new SqlParameter(参数名, 数据类型);
            }
            参数.Direction = ParameterDirection.Input;
            if (值 != null)
            {
                参数.Value = 值;
            }
            return 参数;
        }
        #endregion
        #region 执行参数命令文本
        public DataSet 执行参数命令文本(string 参数名, SqlParameter[] 参数, string 表名)
        {
            SqlDataAdapter 适配器 = 创建适配器(参数名, 参数);
            DataSet 资料组 = new DataSet();
            适配器.Fill(资料组, 表名);
            this.关闭();
            return 资料组;
        }
        #endregion


        #region 执行参数修改文本
        /*
          
          */
        public int 执行参数修改(string 参数名, SqlParameter[] 参数)
        {
            SqlCommand 命令 = 创建命令(参数名, 参数);
            int i = 命令.ExecuteNonQuery();
            return i;
        }
        #endregion
    }
}
