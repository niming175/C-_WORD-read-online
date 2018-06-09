<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        业务逻辑层.BLL.数据获取 获取 = new 业务逻辑层.BLL.数据获取();
        string teacher_id = Session["teacher_id"].ToString(); 
        //string teacher_id = "400003";
        string type = Request["type"].ToString();
        if (type == "1")
        {
            
            string strsql = "select distinct 班级名称,课任.班级编号 from 班级 inner join 课任 on 班级.班级编号=课任.班级编号 inner join 教师 on 课任.教师编号=教师.教师编号 where 课任.教师编号=" + teacher_id;
          
            DataSet 班级列表=  获取.获取数据(strsql, "课任");
            if (班级列表.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','data':[";
                foreach (DataRow dr in 班级列表.Tables[0].Rows)
                {
                    str+="{'班级编号':'"+dr["班级编号"].ToString()+"','班级名称':'"+dr["班级名称"].ToString()+"'},";
                     
                }
                str+="]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error'}"); 
            }
            
        }
        
        //添加公告
        if (type == "2")
        {
            业务逻辑层.BLL.后台管理 后台 = new 业务逻辑层.BLL.后台管理();
            string 标题 = Request["标题"].ToString();
            string 要求 = Request["要求"].ToString();
            int 课任编号 =Convert.ToInt32( Request["课任编号"].ToString());
            //int 教师编号 = Convert.ToInt32(teacher_id);
            DateTime 时间 = DateTime.Now;
            string 附件位置 = Request["附件位置"].ToString();
            
            后台.title=标题;
            后台.text=要求;
            //后台.teacherid=教师编号;
            后台.course_id = 课任编号;
            后台.addtime=时间;
            后台.afix = 附件位置;

            int 结果 = 0;
            try
            {
                结果 = 后台.添加任务公告(后台);
            }
            catch
            {
                结果 = 0; 
            }


            if (结果 > 0)
            {
                Response.Write("{'static':'success'}");
            }
            else
            {
                Response.Write("{'static':'error'}"); 
            }
            
           
            
             
        }
        
        //获取教师信息
        if (type == "3")
        {
            if (teacher_id == null || teacher_id == "")
            {
                Response.Write("{'static':'out'}");
            }
            else
            {
                int 教师编号 = Convert.ToInt32(teacher_id);
                string strsql1 = "select * from 教师 where 教师编号=" + 教师编号;
                DataSet da = 获取.获取数据(strsql1, "教师");
                if (da.Tables[0].Rows.Count > 0)
                {
                    string 姓名 = da.Tables[0].Rows[0]["姓名"].ToString();
                    姓名 = HttpUtility.JavaScriptStringEncode(姓名);
                    string str = "{'state':'success','姓名':'" + 姓名 + "','data':";
                    string strsql = "select 科目名称 from 课任  inner join 科目 on 科目.科目编号=课任.科目编号 where 状态=1 and 课任.教师编号=" + 教师编号;

                    DataSet 教师信息 = 获取.获取数据(strsql, "课任");
                    if (教师信息.Tables[0].Rows.Count > 0)
                    {

                        str += "[";
                        foreach (DataRow dr in 教师信息.Tables[0].Rows)
                        {
                            string 科目 = dr["科目名称"].ToString();
                            科目 = HttpUtility.JavaScriptStringEncode(科目);
                            str += "{'科目名称':'" + 科目 + "'},";

                        }
                        str += "]}";


                    }

                    else
                    {
                        str += "'null'}";
                    }
                    Response.Write(str);
                }
                else
                {
                    Response.Write("{'state':'error'}");
                }
            }
        }
        //获取任务公告列表
        if (type == "4")
        {
            string 班级编号 = Request["class_id"].ToString();
            string 关键字 = Request["text"].ToString();
            if (关键字 != "")
            {
                关键字 = "and  任务公告.标题 like '%" + 关键字 + "%'";
            }
         
            if (班级编号 != "")
            {
                班级编号 = "and 课任.班级编号=" + 班级编号;
            }
         

            string 教师编号 = teacher_id;
            string strsql = "select top 10  count(任务文档.任务编号) as 数量,任务公告.任务编号,任务公告.标题,任务公告.时间,班级.班级名称,科目名称 from 任务文档 right join 任务公告 on 任务公告.任务编号=任务文档.任务编号 inner join 课任 on 课任.课任编号=任务公告.课任编号 inner join 班级 on 班级.班级编号=课任.班级编号 inner join 科目 on 科目.科目编号 =课任.科目编号 where 课任.教师编号=" + 教师编号 + " " + 班级编号 + " " + 关键字 + "  group by 任务公告.任务编号,任务公告.标题,任务公告.时间,班级.班级名称,任务文档.任务编号,科目.科目名称  order by 任务公告.时间 desc";
            string strsql2 = "select COUNT(*) as 数量 from 任务公告 inner join 课任 on 课任.课任编号=任务公告.课任编号 where 课任.教师编号=" + 教师编号;
            DataSet 公告列表 = 获取.获取数据(strsql, "任务公告");
            DataSet 列表总数=获取.获取数据(strsql2,"任务公告");
            string 总量=列表总数.Tables[0].Rows[0]["数量"].ToString();
            if (公告列表.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','总量':'" + 总量 + "','data':[";
                foreach (DataRow dr in 公告列表.Tables[0].Rows)
                { 
                    string 任务编号=dr["任务编号"].ToString();
                    string 标题=Server.UrlEncode(dr["标题"].ToString());
                    DateTime da=Convert.ToDateTime(dr["时间"]);
                    string 时间=da.ToString("yyyy")+"-"+da.ToString("MM")+"-"+da.ToString("dd");
                    string 班级=dr["班级名称"].ToString();
                    string 科目 = dr["科目名称"].ToString();
                    string 数量=dr["数量"].ToString();
                    str += "{'任务编号':'" + 任务编号 + "',";
                    str += "'标题':'" + 标题 + "',";
                    str += "'时间':'" + 时间 + "',";
                    str += "'班级':'" + 班级 + "',";
                    str += "'科目名称':'" + 科目 + "',";
                    str += "'数量':'" + 数量 + "'},";
                }
                str += "]}";
                Response.Write(str);

            }
            else
            {
                Response.Write("{'static':'null','总量':'" + 总量 + "','message':'暂时没有公告'}");
            }
        }
        
        //加载任务详细信息
        if (type == "5")
        {
            string 任务编号 = Request["任务编号"].ToString();
            string strsql="select 标题,要求,时间,班级名称,科目名称,附件位置 from 任务公告 inner join 课任 on 课任.课任编号=任务公告.课任编号 inner join 科目 on 科目.科目编号=课任.科目编号 inner join 班级 on 课任.班级编号 =班级.班级编号 where 任务编号="+任务编号;
            string strsql2="select 任务文档.文档编号,任务文档.标题,用户.姓名,任务文档.上传时间,成绩 from  任务文档 inner join 任务公告  on 任务公告.任务编号= 任务文档.任务编号 inner join 用户 on 任务文档.用户编号=用户.用户编号 where 任务文档.任务编号="+任务编号+" order by 上传时间 desc";
            
            DataSet 详细任务信息 = 获取.获取数据(strsql, "任务公告");
            DataSet 详细任务列表=获取.获取数据(strsql2,"任务公告");
            if (详细任务信息.Tables[0].Rows.Count > 0)
            {
                DataRow dr=详细任务信息.Tables[0].Rows[0];
                string 任务标题 =Server.UrlEncode(dr["标题"].ToString());
                string 要求 =Server.UrlEncode(dr["要求"].ToString());
                string 班级 = dr["班级名称"].ToString();
                string 科目 = dr["科目名称"].ToString();
                DateTime da = Convert.ToDateTime(dr["时间"]);
                string 附件位置 = dr["附件位置"].ToString();
                string 任务时间 = da.ToString("yyyy") + "-" + da.ToString("MM") + "-" + da.ToString("dd");
                string str = "{'static':'success','任务标题':'" + 任务标题 + "','要求':'" + 要求 + "','班级':'" + 班级 + "','科目名称':'"+科目+"','时间':'" + 任务时间 + "','附件位置':'"+附件位置+"','data':[";
                if (详细任务列表.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr1 in 详细任务列表.Tables[0].Rows)
                    {
                        string 文档编号 = dr1["文档编号"].ToString();
                        string 标题 = Server.UrlEncode(dr1["标题"].ToString());
                        string 姓名 = Server.UrlEncode(dr1["姓名"].ToString());
                        DateTime da1 = Convert.ToDateTime(dr1["上传时间"]);
                        string 上传时间 = da1.ToString("yyyy") + "-" + da1.ToString("MM") + "-" + da1.ToString("dd");
                        string 成绩 = dr1["成绩"].ToString();
                        str += "{'文档编号':'" + 文档编号 + "','标题':'" + 标题 + "','姓名':'" + 姓名 + "','上传时间':'" + 上传时间 + "','成绩':'" + 成绩 + "'},";
                    }
                }
                else
                {
                    str += ""; 
                }
                str += "]}";
                Response.Write(str);
            }
        }
        
        //上传附件
        if (type == "6")
        {
            //获取文件
            HttpFileCollection 文件组 = Request.Files;
            //判断是否有文件
            if (文件组 != null && 文件组.Count > 0)
            {
                HttpPostedFile 文件 = 文件组[0];
                string 服务端地址 = Server.MapPath("../../data/afix/");
                string 文件名 = Path.GetFileName(文件.FileName);
                string 后缀 = System.IO.Path.GetExtension(文件名);
                DateTime 时间 = new DateTime();
                时间 = DateTime.Now;
                string 新文件名 = 时间.ToString("HHmmss") + 后缀;
                string 文件时间路径 = 时间.ToString("yyyy") + "/" + 时间.ToString("MM") + "/" + 时间.ToString("dd")+"/";
                string 完整路径 = 服务端地址 + 文件时间路径;
                //判断文件路径是否存在，否者创建
                if (!System.IO.Directory.Exists(完整路径))
                {
                    Directory.CreateDirectory(完整路径);
                }
                
                string 文件相对路径 = "../data/afix/" + 文件时间路径 + 新文件名;
                try
                {
                    文件.SaveAs(Server.MapPath("../"+文件相对路径));
                    Response.Write("{'static':'success','附件位置':'" + 文件相对路径 + "'}");
                }
                catch
                {
                    Response.Write("{'static':'error'}"); 
                }
            } 
        }
        //修改密码
        if (type == "7")
        { 
            //判断时候在线
            if (Session["teacher_id"] == null || Session["teacher_id"] == "")
            {
                Response.Write("{'static':'out'}");
            }
            else
            {
                 int 教师编号=Convert.ToInt32(Session["teacher_id"]);
                 string 原密码 = Request["oldpsw"].ToString();
                 string 新密码 = Request["newpsw"].ToString();

                 string str = "select * from 教师 where 教师编号=" + 教师编号 + " and 密码='" + 原密码 + "'";
                 DataSet da = 获取.获取数据(str, "教师");
                 if (da.Tables[0].Rows.Count > 0)
                 {
                     业务逻辑层.BLL.后台管理 后台 = new 业务逻辑层.BLL.后台管理();
                     后台.teacher_id = 教师编号;
                     后台.psw = 新密码;
                     int i = 0;
                     i = 后台.修改教师密码(后台);
                     if (i > 0)
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
                    Response.Write("{'static':'mistake'}"); 
                }
            }
        }
        
        //加载科目
        if (type=="8")
        {
            string 班级编号 = Request["班级编号"].ToString();
            string sql = "select 科目名称,课任编号 from 课任 inner join 科目 on 课任.科目编号=科目.科目编号 where 班级编号=" + 班级编号 + " and 教师编号=" + teacher_id;
            DataSet da = 获取.获取数据(sql, "课任");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str="{'static':'success','data':[";
                foreach(DataRow dr in da.Tables[0].Rows)
                {
                    string 课任编号 = dr["课任编号"].ToString();
                    string 科目 = dr["科目名称"].ToString();
                    str += "{'课任编号':'" + 课任编号 + "',";
                    str += "'科目':'" + 科目 + "'},";
                    
                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'null'}"); 
            }
        }
    }
</script>