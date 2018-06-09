<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Text" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        业务逻辑层.BLL.数据获取 获取 = new 业务逻辑层.BLL.数据获取();
        string type = Request["type"].ToString();
        if (type == "1")
        {
            var 用户编号 = Session["user_id"].ToString();
            string strsql = "select 昵称,班级名称,头像位置,邮箱 from 用户 inner join 班级 on 用户.班级编号=班级.班级编号 where 用户编号 =" + 用户编号;
            string strnum = "select count(*) as 数量 from 报告文档 where 用户编号=" + 用户编号;
            DataSet 用户资料 = 获取.获取数据(strsql, "报告文档");
            DataSet 数量资料 = 获取.获取数据(strnum, "报告文档");
            if (用户资料.Tables[0].Rows.Count > 0 && 数量资料.Tables[0].Rows.Count > 0)
            {
                string 数量 = 数量资料.Tables[0].Rows[0]["数量"].ToString();
                DataRow dr = 用户资料.Tables[0].Rows[0];
                string 昵称 = Server.UrlEncode(dr["昵称"].ToString());
                string 班级 = dr["班级名称"].ToString();
                string 邮箱 = dr["邮箱"].ToString();
                string 头像位置 = dr["头像位置"].ToString();
                string str = "{'static':'success','数量':'" + 数量 + "','昵称':'" + 昵称 + "','班级':'" + 班级 + "','邮箱':'" + 邮箱 + "','头像位置':'" + 头像位置 + "'}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error'}");
            }

        }


        #region 修改用户信息
        if (type == "2")
        {
            string 昵称 = Request["昵称"].ToString();
            string 邮箱 = Request["邮箱"].ToString();
            string 头像位置 = Request["头像位置"].ToString();
            // 有上传文件
            HttpFileCollection files = Request.Files;
            if (files != null && files.Count > 0)
            {
                HttpPostedFile file = files[0];
                string filetype = file.ContentType.ToLower();
                if (!filetype.Contains("image"))
                {
                    Response.Write("{'static':'error','message':'非法图片格式'}");
                    return;
                }
                else
                {
                    string tmpPath = Server.MapPath("~/data/head_img/"); //服务端地址
                    string fileName = Path.GetFileName(file.FileName);//获取文件的文件名
                    string ext = System.IO.Path.GetExtension(fileName);//获取文件名后缀
                    DateTime da = DateTime.Now;
                    string path = da.ToString("yyyy") + "/" + da.ToString("MM") + "/" + da.ToString("dd") + "/";
                    //检查文件是否存在，不存在就创建
                    string fullpath = tmpPath + path;
                    if (!System.IO.Directory.Exists(fullpath))
                    {
                        Directory.CreateDirectory(fullpath);
                    }
                    头像位置 = "../data/head_img/" + path + da.ToString("HHmmss") + ext;//对文件重命名
                    fileName = Server.MapPath(头像位置);
                    try
                    {
                        file.SaveAs(fileName);

                    }
                    catch
                    {
                        Response.Write("{'static':'error','message':'文件保存失败'}");
                        return;
                    }

                }

            }

            业务逻辑层.BLL.会员管理 管理 = new 业务逻辑层.BLL.会员管理();
            管理.昵称 = 昵称;
            管理.头像位置 = 头像位置;
            管理.邮箱 = 邮箱;
            管理.用户编号 = Convert.ToInt32(Session["user_id"]);
            try
            {
                int i = 管理.修改信息(管理);
                if (i > 0)
                {
                    Response.Write("{'static':'success'}");
                }

            }
            catch
            {
                Response.Write("{'static':'error','message':'修改信息失败'}");
            }

        }
        #endregion

        #region
        if (type == "3")
        {
            string 用户编号 = Session["user_id"].ToString();
            string strsql = "select 文档编号,标题,状态,上传时间 from 报告文档 where 用户编号=" + 用户编号;
            DataSet 文档列表 = 获取.获取数据(strsql, "报告文档");
            if (文档列表.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','data':[";
                foreach (DataRow dr in 文档列表.Tables[0].Rows)
                {
                    string 文档编号 = dr["文档编号"].ToString();
                    string 标题 = Server.UrlEncode(dr["标题"].ToString());
                    string 状态 = dr["状态"].ToString();
                    DateTime da = Convert.ToDateTime(dr["上传时间"]);
                    string 上传时间 = da.ToString("yyyy") + "-" + da.ToString("MM") + "-" + da.ToString("dd");
                    str += "{'文档编号':'" + 文档编号 + "',";
                    str += "'标题':'" + 标题 + "',";
                    str += "'状态':'" + 状态 + "',";
                    str += "'上传时间':'" + 上传时间 + "'},";
                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error','message':'你还未上传文档'}");

            }
        }
        #endregion

        //获取最新公告
        if (type == "4")
        {
            string 用户编号 = Session["user_id"].ToString();
            if (用户编号 != null)
            {
               // string strsql1 = "select top 10 任务编号,标题,时间,教师.姓名  from 任务公告 inner join 班级 on 任务公告.班级编号=班级.班级编号 inner join 用户 on 班级.班级编号=用户.班级编号 inner join 教师 on 任务公告.教师编号=教师.教师编号 where 任务公告.任务编号 not in (select 任务编号 from 任务文档 where 用户编号=" + 用户编号+") and  用户编号=" + 用户编号+" order by 时间 desc";
                string strsql1 = "select top 10 任务编号,标题,科目名称,教师.姓名,时间,附件位置 from 任务公告 inner join 课任 on 课任.课任编号=任务公告.课任编号 inner join 科目 on 科目.科目编号= 课任.科目编号 inner join 教师 on 教师.教师编号 =课任.教师编号 where 课任.班级编号=(select 班级编号 from 用户 where 用户编号=" + 用户编号 + ") and  任务公告.任务编号 not in (select 任务编号 from 任务文档 where 用户编号=" + 用户编号 + ") order by 时间 desc";
                string strsql2 = "select COUNT(*) as 数量 from 任务公告 inner join 课任 on 课任.课任编号=任务公告.课任编号 where 课任.班级编号=(select 班级编号 from 用户 where 用户编号=" + 用户编号 + ") and  任务公告.任务编号 not in (select 任务编号 from 任务文档 where 用户编号=" + 用户编号 +")";
                DataSet 公告列表 = 获取.获取数据(strsql1, "任务公告");
                DataSet 公告数量 = 获取.获取数据(strsql2, "任务公告");
                string 数量 = 公告数量.Tables[0].Rows[0]["数量"].ToString();
                if (公告列表.Tables[0].Rows.Count > 0)
                {
                    string str = "{'static':'success','count':'" + 数量 + "','data':[";
                    foreach (DataRow dr in 公告列表.Tables[0].Rows)
                    {
                        string 标题 = Server.UrlEncode(dr["标题"].ToString());
                        string 任务编号 = dr["任务编号"].ToString();
                        string 姓名 = dr["姓名"].ToString();
                        DateTime dt = Convert.ToDateTime(dr["时间"]);
                        string 时间 = dt.ToString("yyyy") + "-" + dt.ToString("MM") + "-" + dt.ToString("dd");
                        string 科目=dr["科目名称"].ToString();
                        string 附件位置 = dr["附件位置"].ToString();
                        str += "{'标题':'" + 标题 + "',";
                        str += "'任务编号':'" + 任务编号 + "',";
                        str += "'姓名':'" + 姓名 + "',";
                        str+="'科目名称':'"+科目+"',";
                        str += "'附件位置':'"+附件位置+"',";
                        str += "'时间':'" + 时间 + "'},";

                    }
                    str += "]}";
                    Response.Write(str);

                }
                else
                {
                    Response.Write("{'static':'error'}");
                }

            }
            else
            {
                Response.Write("{'static':'error'}");
            }
        }
        
        //获取任务信息
        if (type == "5")
        {
            string 任务编号 = Request["任务编号"].ToString();
            string strsql = "select 标题,要求,时间,附件位置 from 任务公告 where 任务编号 =" + 任务编号;
            DataSet 任务信息 = 获取.获取数据(strsql, "任务公告");
            if (任务信息.Tables[0].Rows.Count > 0)
            {
                DataRow dr = 任务信息.Tables[0].Rows[0];
                string 标题=Server.UrlEncode(dr["标题"].ToString());
                string 要求=Server.UrlEncode(dr["要求"].ToString());
                string 附件位置 = dr["附件位置"].ToString();
                DateTime da=Convert.ToDateTime(dr["时间"]);
                string 时间=da.ToString("yyyy")+"-"+da.ToString("MM")+"-"+da.ToString("dd");
                string str = "{'static':'success','标题':'" + 标题 + "','要求':'" + 要求 + "','时间':'" + 时间 + "','附件位置':'"+附件位置+"'}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error'}"); 
            }     
        }
        
        //添加任务信息
        if (type == "6")
        {
            int 任务编号 = Convert.ToInt32(Request["任务编号"]);
            string 标题=Request["标题"].ToString();
            string 网页位置 = Request["网页位置"].ToString();
            string 文档位置 = Request["文档位置"].ToString();
            int 用户编号 = Convert.ToInt32(Session["user_id"]);
            DateTime 上传时间 = DateTime.Now;
            if (Session["user_id"] != null)
            {
                业务逻辑层.BLL.文档管理 文档 = new 业务逻辑层.BLL.文档管理();
                文档.标题 = 标题;
                文档.网页位置 = 网页位置;
                文档.文档位置 = 文档位置;
                文档.用户编号 = 用户编号;
                文档.上传时间 = 上传时间;
                文档.任务编号 = 任务编号;

                int 结果 = 文档.添加任务文档(文档);
                if (结果 > 0)
                {
                    Response.Write("{'static':'success'}");
                }
                else
                {
                    Response.Write("{'static':'error','message':'添加失败'}"); 
                }
            }
            
        }
        
        
        //加载已经完成任务
        if (type == "7")
        {
            string 用户编号=Session["user_id"].ToString();
            string strsql = "select top 10 文档编号,任务公告.标题 as 任务,科目名称,教师.姓名,上传时间,成绩 from 任务文档 inner join 任务公告 on 任务公告.任务编号=任务文档.任务编号 inner join 课任 on 任务公告.课任编号=课任.课任编号 inner join 教师 on 教师.教师编号=课任.教师编号 inner join 科目 on 科目.科目编号=课任.科目编号 where 用户编号="+用户编号+" order by 上传时间 desc";
            string strsql2 = "select count(*) as 数量 from 任务文档 where 用户编号=" + 用户编号;
            if (Session["user_id"] != null)
            {
                DataSet 任务列表 = 获取.获取数据(strsql, "任务文档");
                if (任务列表.Tables[0].Rows.Count > 0)
                {
                    DataSet 任务数量 = 获取.获取数据(strsql2, "任务文档");
                    string 数量 = 任务数量.Tables[0].Rows[0]["数量"].ToString();
                    string str = "{'static':'success','数量':'"+数量+"','data':[";
                    foreach (DataRow dr in 任务列表.Tables[0].Rows)
                    {
                        string 文档编号 = dr["文档编号"].ToString();
                        string 任务 = Server.UrlEncode(dr["任务"].ToString());
                        //string 标题 = Server.UrlEncode(dr["标题"].ToString());
                        string 科目名称 = dr["科目名称"].ToString();
                        string 姓名 = dr["姓名"].ToString();
                        DateTime da = Convert.ToDateTime(dr["上传时间"]);
                        string 时间 = da.ToString("yyyy") + "-" + da.ToString("MM") + "-" + da.ToString("dd");
                        string 成绩 = dr["成绩"].ToString();
                       

                        str += "{'文档编号':'" + 文档编号 + "',";
                        str += "'任务':'" + 任务 + "',";
                        str += "'科目名称':'" + 科目名称 + "',";
                        str += "'姓名':'" + 姓名 + "',";
                        str += "'时间':'" + 时间 + "',";
                        str += "'成绩':'" + 成绩 + "'},";

                    }
                    str += "]}";
                    Response.Write(str);
                }
                else
                {
                    Response.Write("{'static':'null'}");
                }
                
            }
            else
            {
                Response.Write("{'static':'error','message':'你已经掉线，请重新登录'}");
            }
        }
        //确认旧密码是否正确
        if (type == "8")
        {
            if (Session["user_id"] != "")
            {
                string 旧密码 = Request["旧密码"].ToString();
                int 用户编号 = Convert.ToInt32(Session["user_id"]);
                string strql = "select * from 用户 where 用户编号=" + 用户编号 + " and 密码='" + 旧密码 + "'";
                DataSet 资料组 = 获取.获取数据(strql,"用户");
                if (资料组.Tables[0].Rows.Count > 0)
                {
                    业务逻辑层.BLL.会员管理 会员 = new 业务逻辑层.BLL.会员管理();
                    会员.密码 = Request["新密码"].ToString();
                    会员.用户编号 = 用户编号;
                    int 结果 = 会员.修改密码(会员);
                    if (结果 > 0)
                    {
                        Response.Write("{'static':'success'}");
                    }
                    else
                    {
                        Response.Write("{'static':'error'}");
                    }
                }
                else
                {
                    Response.Write("{'static':'lose'}");
                }
            }
            else
            {
                Response.Write("{'static':'out'}"); 
            }
        }
    }
   
   
</script>
