using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace word文件共享系统.后台管理.ajax
{
    public partial class instructor : System.Web.UI.Page
    {
        业务逻辑层.BLL.后台管理 后台 = new 业务逻辑层.BLL.后台管理();
        业务逻辑层.BLL.数据获取 获取 = new 业务逻辑层.BLL.数据获取();
        //业务逻辑层.BLL.用户管理 用户 = new 业务逻辑层.BLL.用户管理();
        业务逻辑层.dll.用户管理 用户 = new 业务逻辑层.dll.用户管理();
        业务逻辑层.dll.辅导员管理 辅导员 = new 业务逻辑层.dll.辅导员管理();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["辅导员编号"] == null || Session["辅导员编号"] == "")
            {
                Response.Write("{'state':'out'}");
            }
            else
            {
                int 辅导员编号 =Convert.ToInt32(Session["辅导员编号"].ToString());

                int type = Convert.ToInt32(Request["type"].ToString());
                switch (type)
                {
                    case 1: 初始加载(辅导员编号); break;
                    case 2: 获取班级名单(辅导员编号); break;
                    case 3: 自动获取座号(); break;
                    case 4: 添加学生名单(); break;
                    case 5: 获取年级(辅导员编号); break;
                    case 6: 加载班级列表(辅导员编号); break;
                    case 7: 获取年级(); break;
                    case 8: 获取科目老师(); break;
                    case 9: 添加学期(); break;
                    case 10: 加载科目(); break;
                    case 11: 加载课程(); break;
                    case 12: 删除学期课程(); break;
                    case 13: 修改辅导员密码(辅导员编号); break;

                }
            }
        }
        public void 初始加载(int 辅导员编号)
        {
            DateTime 时间 = new DateTime();
            时间 = DateTime.Now;
            string str=时间.ToString("yyyy")+"年"+时间.ToString("MM")+"月"+时间.ToString("dd")+"日";
            int i=Convert.ToInt32(时间.DayOfWeek);
            string[] 星期={"日","一","二","三","四","五","六"};

            string 查询="select * from 辅导员 where 辅导员编号="+辅导员编号;

            try
            {

                DataSet 结果 = 获取.获取数据(查询, "辅导员");
                if (结果.Tables[0].Rows.Count > 0)
                {
                    string 输出 = "{'state':'success','时间':'" + str + "','星期':'" + 星期[i] + "',";
                    string 姓名 = HttpUtility.JavaScriptStringEncode(结果.Tables[0].Rows[0]["姓名"].ToString());
                    输出 += "'姓名':'" + 姓名 + "',";
                    

                    string 查询班级 = "select 班级编号, 系别名称,专业名称,年级,班别,辅导员.姓名 from 专业 inner join 系别 on 专业.系别编号=系别.系别编号 inner join 班级 on 班级.专业编号=专业.专业编号  inner join 辅导员 on 辅导员.辅导员编号=班级.辅导员编号 where 班级.辅导员编号=" + 辅导员编号;
                    DataSet 班级 = 获取.获取数据(查询班级, "班级");
                    if (班级.Tables[0].Rows.Count > 0)
                    {
                       输出 += "'data':[";
                        foreach (DataRow d in 班级.Tables[0].Rows)
                        {
                            string 年级=d["年级"].ToString();
                            string 班别=d["班别"].ToString();
                            string 系别名称=HttpUtility.JavaScriptStringEncode(d["系别名称"].ToString());
                            string 班级名称=HttpUtility.JavaScriptStringEncode(d["专业名称"].ToString());
                            班别=班别.PadLeft(2,'0');
                            年级=年级.Substring(2,2);
                            string 班级全名 = 系别名称 + ":" + 班级名称+"(" + 年级 + 班别 + "）";
                            输出 += "{'班级编号':'" + d["班级编号"].ToString() + "','班级名称':'" + 班级全名 + "'},";
                        }
                        输出+="]";
                        
                    }
                    else
                        {
                            输出 += "'data':'null'";
                        }
                    输出 += "}";
                    
                    Response.Write(输出);
                }
                else
                {
                    Response.Write("{'state':'error'}");
                }


            }
            catch
            {
                Response.Write("{'state':'error'}");
            }


        }
        #region 获取班级名单
        public void 获取班级名单(int 辅导员编号)
        {
            int 班级编号 = Convert.ToInt32(Request["班级编号"]);
            string 查询班级 = "select 班级编号, 系别名称,系别.识别码 as 系别识别码,专业名称,专业.识别码 as 专业识别码,年级,班别,辅导员.姓名 from 专业 inner join 系别 on 专业.系别编号=系别.系别编号 inner join 班级 on 班级.专业编号=专业.专业编号  inner join 辅导员 on 辅导员.辅导员编号=班级.辅导员编号";
            查询班级 += " where 班级.辅导员编号=" + 辅导员编号;
            查询班级 += " and 班级.班级编号=" + 班级编号;
            string 班级查询 = "select 用户编号, 系别.识别码 as 系别识别码,专业.识别码 as 专业识别码,年级,班别,座号,用户.姓名,用户.性别 from 用户";
            班级查询 += " inner join 班级 on 班级.班级编号=用户.班级编号";
            班级查询 += " inner join 专业 on 专业.专业编号=班级.专业编号";
            班级查询 += " inner join 系别 on 系别.系别编号=专业.系别编号";
            班级查询 += " inner join 辅导员 on 班级.辅导员编号=辅导员.辅导员编号";
            班级查询 += " where 用户.班级编号=" + 班级编号;
            班级查询 += " and 辅导员.辅导员编号=" + 辅导员编号;
            try
            {
                DataSet 班级信息 = 获取.获取数据(查询班级, "班级");
                DataRow d = 班级信息.Tables[0].Rows[0];
                string 系别识别码 = d["系别识别码"].ToString();
                string 专业识别码 = d["专业识别码"].ToString();
                string 年级 = d["年级"].ToString();
                年级 = 年级.Substring(2, 2);
                string 班别 = d["班别"].ToString();
                班别 = 班别.PadLeft(2, '0');
                string 班级名称 = d["专业名称"].ToString()+年级+班别;

                string 班级代码 = 系别识别码 + 专业识别码 + 年级 + 班别;
             string str = "{'state':'success','班级名称':'"+班级名称+"','班级代码':'"+班级代码+"','data':";


                try
                {
                    DataSet 班级名单 = 获取.获取数据(班级查询, "班级");
                    if (班级名单.Tables[0].Rows.Count > 0)
                    {
                       // string 班级代码 = "";
                        str += "[";
                        foreach (DataRow da in 班级名单.Tables[0].Rows)
                        {
                            //string 系别识别码 = d["系别识别码"].ToString();
                            //string 专业识别码 = d["专业识别码"].ToString();
                           // string 年级 = d["年级"].ToString();
                           // 年级 = 年级.Substring(2, 2);
                            //string 班别 = d["班别"].ToString();
                           // 班别 = 班别.PadLeft(2, '0');
                            string 座号 = da["座号"].ToString();
                            string 学号 = 班级代码 + 座号.PadLeft(2, '0');
                            string 用户编号 = da["用户编号"].ToString();
                            //班级代码 = 系别识别码 + 专业识别码 + 年级 + 班别;
                            string 姓名 = da["姓名"].ToString();
                            int 性别 = Convert.ToInt32(da["性别"]);


                            str += "{'用户编号':'" + 用户编号 + "','学号':'" + 学号 + "','姓名':'" + 姓名 + "','性别':'" + 性别 + "','座号':'" + 座号 + "'},";
                        }
                        str += "],'班级代码':'" + 班级代码 + "'}";
                        Response.Write(str);
                        return;
                    }
                    else
                    {
                        str += "'null'}";
                        Response.Write(str);
                        return;
                    }
                }
                catch
                {
                    Response.Write("{'state':'error'}");
                }
            }
            catch
            {
                Response.Write("{'state':'error'}");
            }
        }
        #endregion 
        #region 自动获取座号
        public void 自动获取座号()
        {
            int 班级编号 = Convert.ToInt32(Request["班级编号"]);
            string 查询 = "select top 1 座号 from 用户 where 班级编号=" + 班级编号 + " group by 座号,班级编号 order by 座号 desc ";
            int 座号 = 1;
            DataSet da = 获取.获取数据(查询, "班级");
            if (da.Tables[0].Rows.Count > 0)
            {
                座号 = Convert.ToInt32(da.Tables[0].Rows[0]["座号"]) + 1;
            }
            else
            { 
            }
            Response.Write("{'state':'success','座号':'" + 座号 + "'}");
        }
        #endregion
        #region 添加学生名单
        public void 添加学生名单()
        {
            int 班级编号 = Convert.ToInt32(Request["班级编号"]);
            int 性别 = Convert.ToInt32(Request["性别"]);
            string 姓名 = Request["姓名"].ToString();
            int 座号 = Convert.ToInt32(Request["座号"]);
            用户.班级编号 = 班级编号;
            用户.性别 = 性别;
            用户.座号 = 座号;
            用户.姓名 = 姓名;

            //try
            //{
                int i = 用户.添加用户(用户);
                if (i > 0)
                {
                    Response.Write("{'state':'success'}");
                }
                else
                {
                    Response.Write("{'state':'error'}");
                }

            //}
            //catch
            //{
            //    Response.Write("{'state':'error'}");
            //}

            
        }
        #endregion 

        #region 获取辅导员负责班级的年级
        protected void 获取年级(int 辅导员编号)
        {
            string str="select distinct(年级)  from 班级 where 辅导员编号="+辅导员编号;
            DataSet da = 获取.获取数据(str, "班级");
            if (da.Tables[0].Rows.Count > 0)
            {

                string s = "{'state':'success','data':[";
                foreach (DataRow d in da.Tables[0].Rows)
                {
                    string 年级 = d["年级"].ToString();
                    s += "{'年级':'" + 年级 + "'},";

                }
                s += "]}";
                Response.Write(s);
            }
            else
            {
                Response.Write("{'state':'error'}");
            }
 
        }
        #endregion

        #region 获取班级列表
        protected void 加载班级列表(int 辅导员编号)
        {
            int 年级 = Convert.ToInt32(Request["年级"]);
            string 查询班级 = "select 班级编号, 系别名称,专业名称,年级,班别,辅导员.姓名 from 专业";
            查询班级+=" inner join 系别 on 专业.系别编号=系别.系别编号";
            查询班级+=" inner join 班级 on 班级.专业编号=专业.专业编号";
            查询班级+= " inner join 辅导员 on 辅导员.辅导员编号=班级.辅导员编号";
            查询班级+= " where 班级.辅导员编号=" + 辅导员编号;
            查询班级+=" and 年级="+年级;
            DataSet da = 获取.获取数据(查询班级, "班级");
            if (da.Tables[0].Rows.Count > 0)
            {
                string s = "{'state':'success','data':[";
                foreach (DataRow d in da.Tables[0].Rows)
                {
                    string 年级1 = d["年级"].ToString();
                    string 班别 = d["班别"].ToString();
                    string 系别名称 = HttpUtility.JavaScriptStringEncode(d["系别名称"].ToString());
                    string 班级名称 = HttpUtility.JavaScriptStringEncode(d["专业名称"].ToString());
                    班别 = 班别.PadLeft(2, '0');
                    年级1 = 年级1.Substring(2, 2);
                    string 班级全名 = 系别名称 + ":" + 班级名称 + "(" + 年级1 + 班别 + "）";
                    s += "{'班级编号':'" + d["班级编号"].ToString() + "','班级名称':'" + 班级全名 + "'},";
                }
                s += "]}";
                Response.Write(s);
            }
            else
            {
                Response.Write("{'state':'error'}");
            }
           
        }
        #endregion

        #region 获取该班级的年级和当前时间
        protected void 获取年级()
        {
            DateTime dt = new DateTime();
            dt = DateTime.Now;
            string tome = dt.ToString("yyyy") + "-" + dt.ToString("MM") + "-" + dt.ToString("dd");
            int 班级编号=Convert.ToInt32(Request["班级编号"]);
            string strsql = "select 专业名称,班别,年级 from 班级 inner join 专业 on 专业.专业编号=班级.专业编号 where 班级编号=" + 班级编号;
            DataSet da = 获取.获取数据(strsql, "班级");
            if (da.Tables[0].Rows.Count > 0)
            {
                string 专业名称 = HttpUtility.JavaScriptStringEncode(da.Tables[0].Rows[0]["专业名称"].ToString());
                string 年级 = da.Tables[0].Rows[0]["年级"].ToString();
                string 班别 = da.Tables[0].Rows[0]["班别"].ToString();
                string 班级名称 = 专业名称 + 年级.Substring(2, 2) + 班别.PadLeft(2, '0');
                string str = "{'state':'success','时间':'" + tome + "','班级名称':'" + 班级名称 + "','年级':'" + 年级 + "'}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'state':'error'}");
            }
        }
        #endregion

        #region 获取科目对应负责教师
        protected void 获取科目老师()
        {
            int 科目编号 = Convert.ToInt32(Request["科目编号"]);
            string strsql = "select 课任编号, 教师.教师编号,教研室名称,教师.姓名 from 教师";
            strsql += " inner join 课任 on 课任.教师编号=教师.教师编号";
            strsql += " inner join 教研室 on 教研室.教研室编号=教师.教研室编号";
            strsql += " where 状态=1 and 课任.科目编号="+科目编号;
            DataSet da = 获取.获取数据(strsql, "课任");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'state':'success','data':[";
                foreach (DataRow d in da.Tables[0].Rows)
                {
                    string 教研室名称 = HttpUtility.JavaScriptStringEncode(d["教研室名称"].ToString());
                    string 姓名 = HttpUtility.JavaScriptStringEncode(d["姓名"].ToString());
                    string 课任编号 = d["课任编号"].ToString();
                    string 教师名称 = 姓名 + "(" + 教研室名称 + ")";
                    str += "{'课任编号':'" + 课任编号 + "','教师名称':'" + 教师名称 + "'},";
                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'state':'error'}");
            }
        }
        #endregion
        #region 添加学期
        protected void 添加学期()
        {
            int 课任编号 = Convert.ToInt32(Request["课任编号"]);
            int 班级编号 = Convert.ToInt32(Request["班级编号"]);
            int 学期号 = Convert.ToInt32(Request["学期号"]);
            辅导员.班级编号 = 班级编号;
            辅导员.课任编号 = 课任编号;
            辅导员.学期号 = 学期号;
            try
            {
                if (辅导员.添加学期(辅导员) > 0) Response.Write("{'state':'success'}");
                else Response.Write("{'state':'error'}");
            }
            catch { Response.Write("{'state':'error'}"); }

        }
        #endregion

        #region 加载科目
        protected void 加载科目()
        {
            int 类型编号 = Convert.ToInt32(Request["科目类型编号"]);
            int 班级编号 = Convert.ToInt32(Request["班级编号"]);
            //string strsql = "select * from 科目 where 科目类型编号=" + 类型编号;
            string strsql="select * from 科目 where 科目.科目类型编号=" + 类型编号+" AND 科目编号 NOT in";
            strsql += " (select 科目编号 from 课任 inner join 学期 on 课任.课任编号=学期.课任编号 where 学期.班级编号="+班级编号+")";
            DataSet da = 获取.获取数据(strsql, "科目");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'state':'success','data':[";
                foreach (DataRow d in da.Tables[0].Rows)
                {
                    string 科目编号 = d["科目编号"].ToString();
                    string 科目名称 = HttpUtility.JavaScriptStringEncode(d["科目名称"].ToString());
                    str += "{'科目编号':'" + 科目编号 + "','科目名称':'" + 科目名称 + "'},";
                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'state':'error'}");
            }
        }
        #endregion

        #region 加载课程表
        protected void 加载课程()
        {
            int 学期号 = Convert.ToInt32(Request["学期号"]);
            int 班级编号 = Convert.ToInt32(Request["班级编号"]);
            string 学期 = "";
            switch (学期号)
            {
                case 1: 学期 = "大一上学期"; break;
                case 2: 学期 = "大一下学期"; break;
                case 3: 学期 = "大二上学期"; break;
                case 4: 学期 = "大二下学期"; break;
                case 5: 学期 = "大三上学期"; break;
                case 6: 学期 = "大三下学期"; break;
                case 7: 学期 = "大四上学期"; break;
                case 8: 学期 = "大四下学期"; break;
            }
            string str = "select 年级 from 班级 where 班级编号=" + 班级编号;
            DataSet da1 = 获取.获取数据(str, "班级");
            int 年级 = Convert.ToInt32(da1.Tables[0].Rows[0]["年级"]);
            DateTime 时间 = new DateTime();
            时间 = DateTime.Now;
            int 状态 = 3;
            DateTime t1 = new DateTime();
            DateTime t2 = new DateTime();
            int z=年级+((学期号-1)/2);
            if (学期号 % 2 == 1)
            {
                t1 = DateTime.Parse(z.ToString() + "-09-01");
                t2 = DateTime.Parse((z+1).ToString() + "-01-31");
            }
            else
            {
                t1 = DateTime.Parse((z+1).ToString() + "-03-01");
                t2 = DateTime.Parse((z+1).ToString() + "-06-30");
            }
            if (时间 > t2)
            {
                状态 = 1;//已经过期
            }
            else if (时间 > t1 && 时间 < t2)
            {
                状态 = 2;//正在进行
            }
            else if (时间 < t1)
            {
                状态 = 3;//还未开始
            }
            string shuchu = "{'state':'success','学期':'"+学期+"','状态':'" + 状态 + "','data':";
            string strsql = "select 学期编号,教师.姓名,教研室名称,科目名称,科目类型名称 from 学期 inner join 课任 on 课任.课任编号=学期.课任编号";
            strsql += " inner join 教师 on 课任.教师编号=教师.教师编号";
            strsql += " inner join 教研室 on 教研室.教研室编号=教师.教研室编号";
            strsql += " inner join 科目 on 科目.科目编号=课任.科目编号";
            strsql += " inner join 科目类型 on 科目类型.科目类型编号=科目.科目类型编号";
            strsql += " where 学期号=" + 学期号;
            strsql += " and 学期.班级编号=" + 班级编号;
            try
            {
                DataSet da2 = 获取.获取数据(strsql, "课任");
                if (da2.Tables[0].Rows.Count > 0)
                {
                    shuchu += "[";
                    foreach (DataRow d in da2.Tables[0].Rows)
                    {
                        string a = d["教研室名称"].ToString();
                        string b = d["姓名"].ToString();
                        string c = d["科目名称"].ToString();
                        string e = d["科目类型名称"].ToString();
                        string id = d["学期编号"].ToString();
                        shuchu += "{'教研室名称':'" + a + "','姓名':'" + b + "','科目名称':'" + c + "','科目类型名称':'" + e + "','学期编号':'" + id + "'},";

                    }
                    shuchu += "]}";
                }
                else
                {
                    shuchu += "'null'}";
                }
            }
            catch
            {
                shuchu += "'null'}";
            }
            Response.Write(shuchu);

        }
        #endregion
        #region 删除学期课程
        protected void 删除学期课程()
        {
            int 学期编号 = Convert.ToInt32(Request["学期编号"]);
            辅导员.学期编号 = 学期编号;
            try
            {
                if (辅导员.删除学期课程(辅导员) > 0)
                {
                    Response.Write("{'state':'success'}");
                }
                else Response.Write("{'state':'error'}");
            }
            catch
            {
                 Response.Write("{'state':'error'}");
            }
        }
        #endregion

        #region 修改辅导员密码
        protected void 修改辅导员密码(int 辅导员编号)
        {
            string 旧密码 = Request["旧密码"].ToString();
            string strsql = "select * from 辅导员 where 辅导员编号=" + 辅导员编号;
            strsql += " and 密码='" + 旧密码 + "'";
            DataSet da = 获取.获取数据(strsql, "辅导员");
            if (da.Tables[0].Rows.Count > 0)
            {
                string 新密码 = Request["新密码"].ToString();
                辅导员.密码 = 新密码;
                辅导员.辅导员编号 = 辅导员编号;
                try
                {
                    if (辅导员.修改辅导员密码(辅导员) > 0)
                    {
                        Response.Write("{'state':'success'}");
                    }
                    else
                    {
                        Response.Write("{'state':'error'}");
                    }
                }
                catch
                {
                    Response.Write("{'state':'error'}");
                }
            }
            else
            {
                Response.Write("{'state':'msg'}");
            }
        }
        #endregion
    }
}