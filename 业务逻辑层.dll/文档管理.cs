using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace 业务逻辑层.BLL
{
    public class 文档管理
    {
        数据结构层.DAL.数据管理 管理 = new 数据结构层.DAL.数据管理();
        #region 定义报告文档文件类型
        private string 保护_标题;
        private string 保护_标签;
        private string 保护_概述;
        private DateTime 保护_上传时间;
        private int 保护_分类编号;
        private int 保护_用户编号;
        private string 保护_文档位置;
        private string 保护_网页位置;

        private int 保护_任务编号; //任务文档中

        public string 标题
        {
            get { return 保护_标题; }
            set { 保护_标题 = value; }
        }
        public string 标签
        {
            get { return 保护_标签; }
            set { 保护_标签 = value; }
        }
        public string 概述
        {
            get { return 保护_概述; }
            set { 保护_概述 = value; }
        }
        public int 分类编号
        {
            get { return 保护_分类编号; }
            set { 保护_分类编号 = value; }
        }
        public DateTime 上传时间
        {
            get { return 保护_上传时间; }
            set { 保护_上传时间 = value; }
        }
        public string 文档位置
        {
            get { return 保护_文档位置; }
            set { 保护_文档位置 = value; }
        }
        public string 网页位置
        {
            get { return 保护_网页位置; }
            set { 保护_网页位置 = value; }
        }
        public int 用户编号
        {
            get { return 保护_用户编号; }
            set { 保护_用户编号 = value; }
        }

        public int 任务编号
        {
            get { return 保护_任务编号; }
            set { 保护_任务编号 = value; }
        }
        #endregion
        #region 报告评论数据
        private int 保护_文档编号;
        private string 保护_评论内容;
        private DateTime 保护_评论时间;
        public int 文档编号
        {
            get { return 保护_文档编号; }
            set { 保护_文档编号 = value; }
        }

        public string 评论内容
        {
            get { return 保护_评论内容; }
            set { 保护_评论内容 = value; }
        }
        public DateTime 评论时间
        {
            get { return 保护_评论时间; }
            set { 保护_评论时间 = value; }
        }
        #endregion 

        #region 任务评分
        private int 保护_成绩;
        private string 保护_评语;
        public int 成绩
        {
            get { return 保护_成绩; }
            set {保护_成绩=value;}
        }
        public string 评语
        {
            get { return 保护_评语; }
            set { 保护_评语 = value; }
        }

        #endregion

        #region 添加文档数据
        public int 上传文档数据(文档管理 文档)
        {
            SqlParameter[] 参数 ={
                              管理.输入参数("@文档位置",SqlDbType.VarChar,100,文档.文档位置),
                              管理.输入参数("@标题",SqlDbType.VarChar,50,文档.标题),
                              管理.输入参数("@标签",SqlDbType.VarChar,20,文档.标签),
                              管理.输入参数("@概述",SqlDbType.VarChar,140,文档.概述),
                              管理.输入参数("@上传时间",SqlDbType.DateTime,0,文档.上传时间),
                              管理.输入参数("@分类编号",SqlDbType.Int,0,文档.分类编号),
                              管理.输入参数("@用户编号",SqlDbType.Int,0,文档.用户编号),
                              管理.输入参数("@网页位置",SqlDbType.VarChar,100,文档.网页位置)
                              
                              };
            return 管理.执行参数修改("insert into 报告文档(文件位置,标题,标签,概述,上传时间,分类编号,用户编号,网页位置) values(@文档位置,@标题,@标签,@概述,@上传时间,@分类编号,@用户编号,@网页位置)", 参数);
        }
        #endregion

        #region 添加评论
        public int 添加评论(文档管理 评论)
        {
            SqlParameter[] 参数 = {
                                管理.输入参数("@文档编号",SqlDbType.Int,0,评论.文档编号),
                                管理.输入参数("@评论内容",SqlDbType.VarChar,200,评论.评论内容),
                                管理.输入参数("@评论时间",SqlDbType.DateTime,0,评论时间),
                                管理.输入参数("@用户编号",SqlDbType.Int,0,评论.用户编号)
                                };
            return 管理.执行参数修改("insert into 报告评论(评论时间,内容,报告编号,用户编号) values (@评论时间,@评论内容,@文档编号,@用户编号)", 参数);
        }
        #endregion 

        #region 添加任务文档
        public int 添加任务文档(文档管理 文档)
        {
            SqlParameter[] 参数 ={
                                   管理.输入参数("@任务编号",SqlDbType.Int,0,文档.任务编号),
                                   管理.输入参数("@标题",SqlDbType.VarChar,50,文档.标题),
                                   管理.输入参数("@文档位置",SqlDbType.VarChar,100,文档.文档位置),
                                   管理.输入参数("@网页位置",SqlDbType.VarChar,100,文档.网页位置),
                                   管理.输入参数("@用户编号",SqlDbType.Int,0,文档.用户编号),
                                   管理.输入参数("@上传时间",SqlDbType.DateTime,0,文档.上传时间)
                              };
            return 管理.执行参数修改("insert into 任务文档(标题,上传时间,文档位置,任务编号,用户编号,网页位置) values(@标题,@上传时间,@文档位置,@任务编号,@用户编号,@网页位置)", 参数);
        }
        #endregion 

        #region 添加评语
        public int 任务评分(文档管理 文档)
        {
            SqlParameter[] 参数 ={
                                   管理.输入参数("@文档编号",SqlDbType.Int,0,文档.文档编号),
                                   管理.输入参数("@成绩",SqlDbType.Int,0,文档.成绩),
                                   管理.输入参数("@评语",SqlDbType.Text,0,文档.评语)
                               };
            return 管理.执行参数修改("update 任务文档 set 成绩=@成绩,评语=@评语 where 文档编号=@文档编号", 参数);
        }
        #endregion 

        #region 阅读量加1
        public int 阅读量加1(文档管理 文档)
        {
            SqlParameter[] 参数={管理.输入参数("@文档编号",SqlDbType.Int,0,文档.文档编号)};
            return 管理.执行参数修改("update 报告文档 set 阅读量=isnull(阅读量,0)+1 where 文档编号=@文档编号",参数);
        }
        #endregion 

        #region 下载量加1
        public int 下载量加1(文档管理 文档)
        {
            SqlParameter[] 参数 = { 管理.输入参数("@文档编号", SqlDbType.Int, 0, 文档.文档编号) };
            return 管理.执行参数修改("update 报告文档 set 下载量=isnull(下载量,0)+1 where 文档编号=@文档编号", 参数);
        }
        #endregion 
    }
}
