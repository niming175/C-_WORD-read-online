using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


namespace word文件共享系统.后台管理.ajax
{
    public partial class man_tea : System.Web.UI.Page
    {
        业务逻辑层.BLL.数据获取 获取 = new 业务逻辑层.BLL.数据获取();
        业务逻辑层.BLL.后台管理 后台 = new 业务逻辑层.BLL.后台管理();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            int type = Convert.ToInt32(Request["type"]);
            switch (type)
            {
                case 1: 加载教研室(); break;
                case 2: 加载教师(Convert.ToInt32(Request["教研室编号"])); break;
                case 3: 加载科目类别(); break;
                case 4: 加载科目(); break;
                case 5: 修改科目类型(); break;
                case 6: 添加科目类型(); break;
                case 7: 添加科目(); break;
                case 8: 修改科目(); break;
                case 9: 添加教研室(); break;
                case 10: 修改教研室(); break;
                case 11: 添加教师(); break;
                case 12: 修改教师隶属(); break;
                case 13: 修改教师信息(); break;
                case 14: 恢复教师密码(); break;
                case 15: 加载课任(); break;
                case 16: 添加课任(); break;
                case 17: 停用课任(); break;
                case 18: 启用课任(); break;
            }
        }

        //加载教研室
        public void 加载教研室()
        {
            string strsql = "select * from 教研室";
            DataSet da=获取.获取数据(strsql,"教研室");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'state':'success',data:[";
                foreach (DataRow d in da.Tables[0].Rows)
                {
                    string 教研室编号 = d["教研室编号"].ToString();
                    string 教研室名称 = d["教研室名称"].ToString();
                    str += "{'教研室编号':'" + 教研室编号 + "','教研室名称':'" + 教研室名称 + "'},";
                }
                str += "]}";
                Response.Write(str);
            }
            else

            {
                Response.Write("{'state':'error'}");
            }


        }

        //加载教师
        public void 加载教师(int id)
        {
            string 查询1 = "select 教研室名称,COUNT(教师编号) as 人数 from 教研室 left join 教师 on 教研室.教研室编号 =教师.教研室编号 where 教研室.教研室编号=" + id +" group by 教研室名称" ;
            DataSet da =获取.获取数据(查询1, "教研室");
            if (da.Tables[0].Rows.Count > 0)
            {
                string 教研室名称 = da.Tables[0].Rows[0]["教研室名称"].ToString();
                string 人数 = da.Tables[0].Rows[0]["人数"].ToString();
                string str = "{'state':'success','教研室名称':'" + 教研室名称 + "','人数':'" + 人数 + "',";

                string 查询2 = "select 教师编号,账户,姓名,性别 from 教师 inner join 教研室 on  教研室.教研室编号 =教师.教研室编号 where 教师.教研室编号=" + id;
                DataSet da2 = 获取.获取数据(查询2, "教师");
                if (da2.Tables[0].Rows.Count > 0)
                {
                    str += "'data':[";
                    foreach (DataRow d in da2.Tables[0].Rows)
                    {
                        string 姓名 = HttpUtility.JavaScriptStringEncode(d["姓名"].ToString());
                        string 手机号 = d["账户"].ToString();
                        string 教师编号 = d["教师编号"].ToString();
                        string 性别 = Convert.ToInt32(d["性别"]) == 0 ? "男" : "女";
                        str += "{'教师编号':'" + 教师编号 + "','姓名':'" + 姓名 + "','性别':'" + 性别 + "','手机号':'" + 手机号 + "'},";
                    }
                    str += "]}";
                    Response.Write(str);
                }
                else
                {
                    str += "'data':'null'}";
                    Response.Write(str);
                }
            }
            else
            {
                Response.Write("{'state':'error'}");
            }
        }

        //加载科目类别
        public void 加载科目类别()
        {
            string str = "select * from 科目类型";
            DataSet da = 获取.获取数据(str, "科目类型");
            if (da.Tables[0].Rows.Count > 0)
            {
                string s = "{'state':'success','data':[";
                foreach (DataRow d in da.Tables[0].Rows)
                {
                    string 科目类型编号 = d["科目类型编号"].ToString();
                    string 科目类型名称 = d["科目类型名称"].ToString();
                    s += "{'科目类型编号':'" + 科目类型编号 + "','科目类型名称':'" + 科目类型名称 + "'},";
                }
                s += "]}";
                Response.Write(s);
            }
            else
            {
                Response.Write("{'state':'error'}");
            }
            
        }

        //加载科目()
        public void 加载科目()
        {
            int 类型编号 = Convert.ToInt32(Request["科目类型编号"]);
            string strsql="select * from 科目 where 科目类型编号="+类型编号;
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
        //修改科目类型
        public void 修改科目类型()
        {
            int 科目类型编号 = Convert.ToInt32(Request["科目类型编号"]);
            string 科目类型名称 = Request["科目类型名称"].ToString();
            string strsql = "select * from 科目类型 where 科目类型名称='" + 科目类型名称+"'";
            DataSet da = 获取.获取数据(strsql, "科目类型");
            if (da.Tables[0].Rows.Count > 0)
            {
                Response.Write("{'state':'msg'}");
            }
            else
            {
                后台.科目类型编号 = 科目类型编号;
                后台.科目类型名称 = 科目类型名称;
                try
                {
                    if (后台.修改科目类型(后台) > 0)
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
        }

        //添加科目类型
        public void 添加科目类型()
        {
            string 科目类型名称 = Request["科目类型名称"].ToString();
            string strsql = "select * from 科目类型 where 科目类型名称='" + 科目类型名称 + "'";
            DataSet da = 获取.获取数据(strsql, "科目类型");
            if (da.Tables[0].Rows.Count > 0)
            {
                Response.Write("{'state':'msg'}");
            }
            else
            {
                后台.科目类型名称 = 科目类型名称;
                try
                {
                    if (后台.添加科目类型(后台) > 0)
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
            
        }

        //添加科目
        public void 添加科目()
        {
            int 科目类型编号 = Convert.ToInt32(Request["科目类型编号"]);
            string 科目名称 = Request["科目名称"].ToString();
            string strsql = "select * from 科目 where 科目名称='" + 科目名称 + "' and 科目类型编号=" + 科目类型编号;
            DataSet da = 获取.获取数据(strsql, "科目");
            if (da.Tables[0].Rows.Count > 0)
            {
                Response.Write("{'state':'msg'}");
            }
            else
            {
                try
                {
                    后台.科目类型编号 = 科目类型编号;
                    后台.科目名称 = 科目名称;
                    if (后台.添加科目(后台) > 0)
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
        }

        //修改科目
        public void 修改科目()
        {
            int 科目编号 = Convert.ToInt32(Request["科目编号"]);
            string 科目名称 = Request["科目名称"].ToString();
            int 科目类型编号 = Convert.ToInt32(Request["科目类型编号"]);
            string strsql = "select * from 科目 where 科目名称='" + 科目名称 + "' and 科目类型编号=" + 科目类型编号;
            DataSet da = 获取.获取数据(strsql, "科目");
            if (da.Tables[0].Rows.Count > 0)
            {
                Response.Write("{'state':'msg'}");
            }
            else
            {
                后台.科目编号 = 科目编号;
                后台.科目名称 = 科目名称;
                try
                {
                    if (后台.修改科目(后台) > 0)
                        Response.Write("{'state':'success'}");
                    else
                        Response.Write("{'state':'error'}");
                }
                catch
                {
                    Response.Write("{'state':'error'}");
                }
            }
                

        }

        //添加教研室
        public void 添加教研室()
        {
            string 教研室名称 = Request["教研室名称"].ToString();
            string strsql = "select * from 教研室 where 教研室名称='" + 教研室名称 + "'";
            DataSet da = 获取.获取数据(strsql, "教研室");
            if (da.Tables[0].Rows.Count > 0)
            {
                Response.Write("{'state':'msg'}");
            }
            else
            {
                后台.教研室名称 = 教研室名称;
                try
                {
                    if (后台.添加教研室(后台) > 0) Response.Write("{'state':'success'}");
                    else Response.Write("{'state':'error'}");
                }
                catch
                {
                    Response.Write("{'state':'error'}");
                }
            }
        }

        //修改教研室
        public void 修改教研室()
        {
            int 教研室编号 = Convert.ToInt32(Request["教研室编号"]);
            string 教研室名称 = Request["教研室名称"].ToString();
            string strsql = "select * from 教研室 where 教研室名称='" + 教研室名称 + "'";
            DataSet da = 获取.获取数据(strsql, "教研室");
            if (da.Tables[0].Rows.Count > 0)
            {
                Response.Write("{'state':'msg'}");
            }
            else
            {
                后台.教研室编号 = 教研室编号;
                后台.教研室名称 = 教研室名称;
                try
                {
                    if (后台.修改教研室(后台) > 0) Response.Write("{'state':'success'}");
                    else Response.Write("{'state':'error'}");
                }
                catch
                {
                    Response.Write("{'state':'error'}");
                }
            }
        }

        //添加教师
        public void 添加教师()
        {
            int 教研室编号 = Convert.ToInt32(Request["教研室编号"]);
            string 手机号 = Request["手机号"].ToString();
            string 姓名 = Request["姓名"].ToString();
            string strsql="select * from 教师 where 账户='"+手机号+"'";
            int 性别 = Convert.ToInt32(Request["性别"]);
            DataSet da = 获取.获取数据(strsql, "教师");
            if (da.Tables[0].Rows.Count > 0)
            {
                Response.Write("{'state':'msg'}");
            }
            else
            {
                后台.手机号 = 手机号;
                后台.姓名 = 姓名;
                后台.教研室编号 = 教研室编号;
                后台.性别 = 性别;
                try
                {
                    if (后台.添加教师(后台) > 0) Response.Write("{'state':'success'}");
                    else Response.Write("{'state':'error'}");
                }
                catch { Response.Write("{'state':'error'}"); }
            }
        }

        //修改教师隶属
        public void 修改教师隶属()
        {
            int 教师编号 = Convert.ToInt32(Request["教师编号"]);
            int 教研室编号 = Convert.ToInt32(Request["教研室编号"]);
            后台.教师编号 = 教师编号;
            后台.教研室编号 = 教研室编号;
            try
            {
                if (后台.修改教师隶属(后台) > 0) Response.Write("{'state':'success'}");
                else Response.Write("{'state':'error'}");
            }
            catch { Response.Write("{'state':'error'}"); }
        }

        //修改教师信息
        public void 修改教师信息()
        {
            int 教师编号 = Convert.ToInt32(Request["教师编号"]);
            string 姓名 = Request["姓名"].ToString();
            string 手机号 = Request["手机"].ToString();
            int 性别 = Convert.ToInt32(Request["性别"]);
            string strsql = "select * from 教师 where 账户='" + 手机号 + "' and 教师编号 <> "+教师编号;
            
            DataSet da = 获取.获取数据(strsql, "教师");
            if (da.Tables[0].Rows.Count > 0)
            {
                Response.Write("{'state':'msg'}");
            }
            else
            {
                后台.姓名 = 姓名;
                后台.手机号 = 手机号;
                后台.性别 = 性别;
                后台.教师编号 = 教师编号;
                try
                {
                    if (后台.修改教师信息(后台) > 0) Response.Write("{'state':'success'}");
                    else Response.Write("{'state':'error'}");
                }
                catch
                {
                    Response.Write("{'state':'error'}");
 
                }
            }

        }

        //恢复教师密码
        public void 恢复教师密码()
        {
            int 教师编号 = Convert.ToInt32(Request["教师编号"]);
            try
            {
                后台.教师编号 = 教师编号;
                if (后台.恢复教师密码(后台) > 0)
                    Response.Write("{'state':'success'}");
                else Response.Write("{'state':'error'}");
            }
            catch { Response.Write("{'state':'error'}"); }
        }

        //加载课任
        public void 加载课任()
        {
            int 教师编号 = Convert.ToInt32(Request["教师编号"]);
            string strsl="select 课任编号,科目类型名称,科目名称,状态 from 科目类型 ";
            strsl+=" inner join 科目 on 科目.科目类型编号=科目类型.科目类型编号";
            strsl += " inner join 课任 on 课任.科目编号=科目.科目编号";
            strsl += " where 教师编号=" + 教师编号;
            DataSet da = 获取.获取数据(strsl, "课任");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'state':'success',data:[";
                foreach (DataRow d in da.Tables[0].Rows)
                {
                    string 科目名称 = HttpUtility.JavaScriptStringEncode(d["科目名称"].ToString());
                    string 科目类型名称 = HttpUtility.JavaScriptStringEncode(d["科目类型名称"].ToString());
                    string 课任编号 = d["课任编号"].ToString();
                    int 状态 = Convert.ToInt32(d["状态"]);
                    str += "{'课任编号':'" + 课任编号 + "','科目类型名称':'" + 科目类型名称 + "','科目名称':'" + 科目名称 + "','状态':'"+状态+"'},";

                }
                str += "]}";
                Response.Write(str);

            }
            else
            {
                Response.Write("{'state':'error'}");
            }
        }

        //添加课任
        public void 添加课任()
        {
            int 教师编号 = Convert.ToInt32(Request["教师编号"]);
            int 科目编号 = Convert.ToInt32(Request["科目编号"]);

            string strsql = "select * from 课任 where 教师编号=" + 教师编号;
            strsql += " and 科目编号=" + 科目编号;
            DataSet da = 获取.获取数据(strsql, "课任");
            if (da.Tables[0].Rows.Count > 0)
            {
                Response.Write("{'state':'msg'}");
            }
            else
            {
                后台.教师编号 = 教师编号;
                后台.科目编号 = 科目编号;
                try
                {
                    if (后台.添加课任(后台) > 0) Response.Write("{'state':'success'}");
                    else Response.Write("{'state':'error'}");
                }
                catch
                {
                    Response.Write("{'state':'error'}");
                }
            }
        }

        //停用负责课任
        public void 停用课任()
        {
            int 课任编号 = Convert.ToInt32(Request["课任编号"]);
            try
            {
                后台.课任编号 = 课任编号;
                if (后台.停用课任(后台) > 0) Response.Write("{'state':'success'}");
                else Response.Write("{'state':'error'}");
            }
            catch { Response.Write("{'state':'error'}"); }
        }

        //启用负责课任
        public void 启用课任()
        {
            int 课任编号 = Convert.ToInt32(Request["课任编号"]);
            try
            {
                后台.课任编号 = 课任编号;
                if (后台.启用课任(后台) > 0) Response.Write("{'state':'success'}");
                else Response.Write("{'state':'error'}");
            }
            catch { Response.Write("{'state':'error'}"); }
        }

    }
}