using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace 业务逻辑层.BLL
{
   
    public class 后台管理
    {
        #region 教师信息
        private string pr_name;
        private string pr_psw;
        private int pr教师编号;
        public string name
        {
            get { return pr_name; }
            set { pr_name = value; }
        }
        public string psw
        {
            get { return pr_psw; }
            set { pr_psw = value; }
        }
        public int 教师编号
        {
            get { return pr教师编号; }
            set { pr教师编号 = value; }
        }
        #endregion 
        #region 教研室字段
        private int pr教研室编号;
        private string pr教研室名称;
        public int 教研室编号
        {
            get { return pr教研室编号; }
            set { pr教研室编号 = value; }
        }
        public string 教研室名称
        {
            get { return pr教研室名称; }
            set { pr教研室名称 = value; }
        }
        #endregion

        #region 辅导员信息
        private string pr_姓名;
        private string pr_手机号;
        private int pr_性别;
        private int pr_辅导员编号;
        public string 姓名
        {
            get { return pr_姓名; }
            set {   pr_姓名=value; }
        }
        public int 性别
        {
            get { return pr_性别; }
            set { pr_性别 = value; }
        }
        public string 手机号
        {
            get { return pr_手机号; }
            set { pr_手机号 = value; }
        }
        public int 辅导员编号
        {
            get { return pr_辅导员编号; }
            set { pr_辅导员编号 = value; }
        }
        #endregion

        #region 添加公告字段
        private string pr_title;
        private string pr_text;
        private int pr_classid;
        private DateTime pr_addtime;
        private int pr_teacherid;
        private string pr_afix;
        private int pr_course_id;
        public string title
        {
            get { return pr_title;}
            set
            {
                pr_title = value;
            }
        }
        public string text
        {
            get { return pr_text; }
            set { pr_text = value; }
        }
        public int classid
        {
            get { return pr_classid; }
            set { pr_classid = value; }
        }
        public DateTime addtime
        {
            get { return pr_addtime; }
            set { pr_addtime = value; }
        }
        public int teacherid
        {
            get { return pr_teacherid; }
            set { pr_teacherid = value; }
        }
        public string afix
        {
            get { return pr_afix; }
            set { pr_afix = value; }
        }
        public int course_id
        {
            get { return pr_course_id; }
            set { pr_course_id = value; }
        }
        #endregion 

        #region 类型字段
        private int pr_typeid;
        private string pr_type;
        public int typeid
        {
            get { return pr_typeid; }
            set { pr_typeid = value; }
        }
        public string type
        {
            get { return pr_type; }
            set { pr_type = value; }
        }
        #endregion
        #region 系别字段
        private string 保护_系别名称;
        public string 系别名称
        {
            get { return 保护_系别名称; }
            set { 保护_系别名称 = value; }
        }

        #endregion
        #region 班级字段
        private string 保护_班级名称;
        private int 保护_系别编号;
        private int pr_年级;
        private int pr_班别;
        public string 班级名称
        {
            get { return 保护_班级名称; }
            set { 保护_班级名称 = value; }
        }
        public int 系别编号
        {
            get { return 保护_系别编号; }
            set { 保护_系别编号 = value; }
        }

        public int 年级
        {
            get { return pr_年级; }
            set { pr_年级 = value; }
        }
        public int 班别
        {
            get { return pr_班别; }
            set { pr_班别 = value; }
        }
        #endregion
        #region 科目类型字段
        private int pr_科目类型编号;
        private string pr_科目类型名称;
        private string pr_科目名称;
        private int pr_科目编号;
        public int 科目类型编号
        {
            get { return pr_科目类型编号; }
            set { pr_科目类型编号 = value; }
        }
        public string 科目类型名称
        {
            get { return pr_科目类型名称; }
            set { pr_科目类型名称 = value; }
        }
        public int pr课任编号;
        public int 课任编号
        {
            get { return pr课任编号; }
            set { pr课任编号 = value; }
        }
        public string 科目名称 {
            get { return pr_科目名称; }
            set { pr_科目名称 = value; }
        }
        public int 科目编号
        {
            get { return pr_科目编号; }
            set { pr_科目编号 = value; }
        }
        #endregion
        #region 专业信息
        private int pr_专业编号;
        private string pr_专业名称;
        private int pr_识别码;
        public int 专业编号
        {
            get { return pr_专业编号; }
            set { pr_专业编号=value;}
        }
        public string 专业名称
        {
            get { return pr_专业名称; }
            set { pr_专业名称 = value; }
        }
        public int 识别码
        {
            get { return pr_识别码; }
            set { pr_识别码 = value; }
        }

        #endregion

        private int pr_teacher_id;
        public int teacher_id
        {
            get { return pr_teacher_id; }
            set { pr_teacher_id = value; }
        }

        数据结构层.DAL.数据管理 数据 = new 数据结构层.DAL.数据管理();
        #region 教师登录
        public DataSet 登录(后台管理 管理)
        {
            SqlParameter[] 参数 ={
                                    数据.输入参数("@账户",SqlDbType.VarChar,20,管理.name),
                                    数据.输入参数("@密码",SqlDbType.VarChar,50,管理.psw),
                                };
            return (数据.执行参数命令文本("select * from 教师 where (账户=@账户) and (密码=@密码)", 参数, "教师"));
        }
        #endregion 

        #region 修改教师密码
        public int 修改教师密码(后台管理 管理)
        {
            SqlParameter[] 参数 ={
                                  数据.输入参数("@教师编号",SqlDbType.Int,0,管理.teacher_id),
                                  数据.输入参数("@密码",SqlDbType.VarChar,50,管理.psw)
                              };
            return (数据.执行参数修改("update 教师 set 密码=@密码 where 教师编号=@教师编号", 参数));
        }
        #endregion 
        #region 管理员登录
        public DataSet 管理员登录(后台管理 管理)
        {
            SqlParameter[] 参数 ={
                                    数据.输入参数("@账户",SqlDbType.VarChar,11,管理.name),
                                    数据.输入参数("@密码",SqlDbType.VarChar,20,管理.psw),
                                };
            return (数据.执行参数命令文本("select * from 管理员 where 帐号=@账户 and 密码=@密码", 参数, "管理员"));
        }
        #endregion
        #region 辅导员登录
        public DataSet 辅导员登录(后台管理 管理)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@手机",SqlDbType.VarChar,11,管理.手机号),
                               数据.输入参数("@密码",SqlDbType.VarChar,32,管理.psw)};
            return (数据.执行参数命令文本("select * from 辅导员 where 手机=@手机 and 密码=@密码", 参数, "辅导员"));
        }

        #endregion
        #region 添加任务公告
        public int 添加任务公告(后台管理 管理)
        {
            SqlParameter[] 参数 ={
                                  数据.输入参数("@标题",SqlDbType.VarChar,50,管理.title),
                                  数据.输入参数("@要求",SqlDbType.VarChar,500,管理.text),
                                  数据.输入参数("@时间",SqlDbType.DateTime,0,管理.addtime),
                                  数据.输入参数("@课任编号",SqlDbType.Int,0,管理.course_id),
                                 // 数据.输入参数("@教师编号",SqlDbType.Int,0,管理.teacherid),
                                  数据.输入参数("@附件位置",SqlDbType.VarChar,100,管理.afix)
                              };
            return (数据.执行参数修改("insert into 任务公告(标题,要求,时间,课任编号,附件位置) values(@标题,@要求,@时间,@课任编号,@附件位置)", 参数));
        }
        #endregion

        #region 添加类型
        public int 添加类型(后台管理 管理)
        {
            SqlParameter[] 参数 ={
                                  //数据.输入参数("@分类编号",SqlDbType.VarChar,10,管理.typeid),
                                  数据.输入参数("@类型",SqlDbType.VarChar,20,管理.type)
                              };
            return (数据.执行参数修改("insert into 报告分类(类型) values(@类型)", 参数));
        }
        #endregion 

        #region 修改类型
        public int 修改类型(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@分类编号",SqlDbType.Int,0,后台.typeid),
                               数据.输入参数("@类型",SqlDbType.VarChar,20,后台.type)
                               };
            return (数据.执行参数修改("update 报告分类 set 类型=@类型 where 分类编号=@分类编号", 参数));
        }
        #endregion
        #region 添加系别
        public int 添加系别(后台管理 管理)
        {
            SqlParameter[] 参数 ={
                                  数据.输入参数("@系别名称",SqlDbType.VarChar,20,管理.系别名称),
                                  数据.输入参数("@识别码",SqlDbType.Int,0,管理.识别码)
                              };
            return (数据.执行参数修改("insert into 系别 (系别名称,识别码) values(@系别名称,@识别码)", 参数));
        }
        #endregion

        #region 修改系别

        public int 修改系别(后台管理 后台)
        {
            SqlParameter[] 参数 = { 
                              数据.输入参数("@系别名称",SqlDbType.VarChar,20,后台.系别名称),
                                数据.输入参数("@系别编号",SqlDbType.Int,0,后台.系别编号)};
            return (数据.执行参数修改("update 系别 set 系别名称=@系别名称 where 系别编号=@系别编号", 参数));
        }
        #endregion
        #region 添加班级
        //public int 添加班级(后台管理 后台)
        //{
        //    SqlParameter[] 参数 ={
        //                           数据.输入参数("@班级名称",SqlDbType.VarChar,20,后台.班级名称),
        //                           数据.输入参数("@系别编号",SqlDbType.Int,0,后台.系别编号)
        //                       };
        //    return (数据.执行参数修改("insert into 班级 values(@班级名称,@系别编号)", 参数));

        //}
        #endregion 

        #region 添加辅导员
        public int 添加辅导员(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                                  数据.输入参数("@姓名",SqlDbType.VarChar,20,后台.姓名),
                                  数据.输入参数("@手机",SqlDbType.VarChar,11,后台.手机号),
                                  数据.输入参数("性别",SqlDbType.Bit,0,后台.性别)
                              };
            return (数据.执行参数修改("insert into 辅导员 values(@姓名,@手机,'e10adc3949ba59abbe56e057f20f883e',@性别)",参数));
        }
        #endregion 

        #region 修改辅导员信息
        public int 修改辅导员信息(后台管理 后台)
        {
            SqlParameter[] 参数={
                                数据.输入参数("@姓名",SqlDbType.VarChar,20,后台.姓名),
                                数据.输入参数("@手机",SqlDbType.VarChar,11,后台.手机号),
                                数据.输入参数("@性别",SqlDbType.Bit,0,后台.性别),
                                数据.输入参数("@辅导员编号",SqlDbType.Int,0,后台.辅导员编号)
        };
            return (数据.执行参数修改("update 辅导员 set 手机=@手机,姓名=@姓名,性别=@性别 where 辅导员编号=@辅导员编号",参数));
        }
        #endregion

        #region 恢复辅导员密码
        public int 恢复辅导员密码(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                                  数据.输入参数("@辅导员编号",SqlDbType.Int,0,后台.辅导员编号)
                              };
            return (数据.执行参数修改("update 辅导员 set 密码='e10adc3949ba59abbe56e057f20f883e' where 辅导员编号=@辅导员编号", 参数));
        }
        #endregion

        #region 为辅导员添加负责班级
        public int 添加负责班级(后台管理 后台)
        {
            SqlParameter [] 参数={
                                   数据.输入参数("@班级编号",SqlDbType.Int,0,后台.classid),
                                   数据.输入参数("@辅导员编号",SqlDbType.Int,0,后台.辅导员编号)
            };
            return (数据.执行参数修改("update 班级 set 辅导员编号=@辅导员编号 where 班级编号=@班级编号", 参数));
        }
        #endregion

        #region 删除辅导员负责班级
        public int 删除负责班级(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                                   数据.输入参数("@班级编号",SqlDbType.Int,0,后台.classid),
                                   数据.输入参数("@辅导员编号",SqlDbType.Int,0,后台.辅导员编号)
                               };
            return (数据.执行参数修改("update 班级 set 辅导员编号 = null where 班级编号=@班级编号 and 辅导员编号=@辅导员编号", 参数));
        }
        #endregion
        #region 删除班级辅导员
        public int 删除班级辅导员(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                                   数据.输入参数("@班级编号",SqlDbType.Int,0,后台.classid),
                                   //数据.输入参数("@辅导员编号",SqlDbType.Int,0,后台.辅导员编号)
                               };
            return (数据.执行参数修改("update 班级 set 辅导员编号 = null where 班级编号=@班级编号", 参数));
        }
        #endregion

        #region 修改专业名称
        public int 修改专业(后台管理 后台) {
            SqlParameter[] 参数 ={
                              数据.输入参数("@专业编号",SqlDbType.Int,0,后台.专业编号),
                              数据.输入参数("@专业名称",SqlDbType.VarChar,50,后台.专业名称)
                          };
            return (数据.执行参数修改("update 专业 set 专业名称=@专业名称 where 专业编号=@专业编号", 参数));
        }
        #endregion

        #region 添加专业
        public int 添加专业(后台管理 后台) {
            SqlParameter[] 参数 ={
                          数据.输入参数("@专业名称",SqlDbType.VarChar,50,后台.专业名称),
                          数据.输入参数("@系别编号",SqlDbType.Int,0,后台.系别编号),
                          数据.输入参数("@识别码",SqlDbType.Int,0,后台.识别码)};
            return (数据.执行参数修改("insert into 专业(专业名称,识别码,系别编号) values(@专业名称,@识别码,@系别编号)", 参数));
        }
        #endregion 

        #region 修改专业归属
        public int 修改专业归属(后台管理 后台)
        {
            SqlParameter[] 参数 = { 
                                数据.输入参数("@系别编号",SqlDbType.Int,0,后台.系别编号),
                                数据.输入参数("@专业编号",SqlDbType.Int,0,后台.专业编号),
                                数据.输入参数("@识别码",SqlDbType.Int,0,后台.识别码)};
            return (数据.执行参数修改("update 专业 set 识别码=@识别码, 系别编号=@系别编号 where 专业编号=@专业编号", 参数));
        }
        #endregion

        #region 添加班级
        public int 添加班级(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                              数据.输入参数("@年级",SqlDbType.Int,0,后台.年级),
                              数据.输入参数("@班别",SqlDbType.Int,0,后台.班别),
                              数据.输入参数("@辅导员编号",SqlDbType.Int,0,后台.辅导员编号),
                              数据.输入参数("@专业编号",SqlDbType.Int,0,后台.专业编号)};
            if (辅导员编号 == 0)
            {
                return (数据.执行参数修改("insert into 班级 (年级,班别,辅导员编号,专业编号) values (@年级,@班别,null,@专业编号)", 参数));
            }
            else
            {
                return (数据.执行参数修改("insert into 班级 (年级,班别,辅导员编号,专业编号) values (@年级,@班别,@辅导员编号,@专业编号)", 参数));
            }
        }
        #endregion

        #region 修改科目类型
        public int 修改科目类型(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@科目类型编号",SqlDbType.Int,0,后台.科目类型编号),
                               数据.输入参数("@科目类型名称",SqlDbType.VarChar,50,后台.科目类型名称)
                               };
            return (数据.执行参数修改("update 科目类型 set 科目类型名称=@科目类型名称 where 科目类型编号=@科目类型编号", 参数));
        }
        #endregion

        #region 添加科目类型
        public int 添加科目类型(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@科目类型名称",SqlDbType.VarChar,50,后台.科目类型名称),};
            return (数据.执行参数修改("insert into 科目类型(科目类型名称) values (@科目类型名称)", 参数));
        }
        #endregion

        #region 添加科目
        public int 添加科目(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@科目名称",SqlDbType.VarChar,50,后台.科目名称),
                               数据.输入参数("@科目类型编号",SqlDbType.Int,0,后台.科目类型编号)};
            return(数据.执行参数修改("insert into 科目(科目名称,科目类型编号) values(@科目名称,@科目类型编号)",参数));
        }
        #endregion

        #region 修改科目
        public int 修改科目(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@科目编号",SqlDbType.Int,0,后台.科目编号),
                               数据.输入参数("@科目名称",SqlDbType.VarChar,50,后台.科目名称)};
            return (数据.执行参数修改("update 科目 set 科目名称=@科目名称 where 科目编号=@科目编号", 参数));
            
        }
        #endregion

        #region 添加教研室
        public int 添加教研室(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                              数据.输入参数("@教研室名称",SqlDbType.VarChar,20,后台.教研室名称)};
            return (数据.执行参数修改("insert into 教研室(教研室名称) values (@教研室名称)", 参数));
        }
        #endregion

        #region 修改教研室
        public int 修改教研室(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@教研室编号",SqlDbType.Int,0,后台.教研室编号),
                               数据.输入参数("@教研室名称",SqlDbType.VarChar,20,后台.教研室名称)};
            return (数据.执行参数修改("update 教研室 set 教研室名称=@教研室名称 where 教研室编号=@教研室编号", 参数));
        }
        #endregion

        #region 添加教师
        public int 添加教师(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@手机号",SqlDbType.VarChar,11,后台.手机号),
                               数据.输入参数("@姓名",SqlDbType.VarChar,20,后台.姓名),
                               数据.输入参数("@教研室编号",SqlDbType.Int,0,后台.教研室编号),
                               数据.输入参数("@性别",SqlDbType.Bit,0,后台.性别)};
            return (数据.执行参数修改("insert into 教师 (账户,密码,姓名,性别,教研室编号) values(@手机号,'e10adc3949ba59abbe56e057f20f883e',@姓名,@性别,@教研室编号)", 参数));
        }
        #endregion

        #region 修改教师隶属
        public int 修改教师隶属(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@教师编号",SqlDbType.Int,0,后台.教师编号),
                               数据.输入参数("@教研室编号",SqlDbType.Int,0,后台.教研室编号)};
            return (数据.执行参数修改("update 教师 set 教研室编号=@教研室编号 where 教师编号=@教师编号", 参数));
        }
        #endregion

        #region 修改教师信息
        public int 修改教师信息(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@姓名",SqlDbType.VarChar,20,后台.姓名),
                               数据.输入参数("@手机号",SqlDbType.VarChar,11,后台.手机号),
                               数据.输入参数("@性别",SqlDbType.Bit,0,后台.性别),
                               数据.输入参数("@教师编号",SqlDbType.Int,0,后台.教师编号)};
            return (数据.执行参数修改("update 教师 set 姓名=@姓名,账户=@手机号,性别=@性别 where 教师编号=@教师编号", 参数));
        }
        #endregion

        #region 恢复教师密码
        public int 恢复教师密码(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@教师编号",SqlDbType.Int,0,后台.教师编号)};
            return (数据.执行参数修改("update 教师 set 密码='e10adc3949ba59abbe56e057f20f883e' where 教师编号=@教师编号", 参数));
        }
        #endregion

        #region 添加课任
        public int 添加课任(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                              数据.输入参数("@教师编号",SqlDbType.Int,0,后台.教师编号),
                              数据.输入参数("@科目编号",SqlDbType.Int,0,后台.科目编号)};
            return(数据.执行参数修改("insert into 课任 (教师编号,科目编号,状态) values(@教师编号,@科目编号,1)",参数));
        }

        #endregion

        #region 停用课任负责
        public int 停用课任(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@课任编号",SqlDbType.Int,0,后台.课任编号)};
            return (数据.执行参数修改("update 课任 set 状态=0 where 课任编号=@课任编号", 参数));
        }
        #endregion

        #region 启用课任负责
        public int 启用课任(后台管理 后台)
        {
            SqlParameter[] 参数 ={
                               数据.输入参数("@课任编号",SqlDbType.Int,0,后台.课任编号)};
            return (数据.执行参数修改("update 课任 set 状态=1 where 课任编号=@课任编号", 参数));
        }
        #endregion
    }
}
