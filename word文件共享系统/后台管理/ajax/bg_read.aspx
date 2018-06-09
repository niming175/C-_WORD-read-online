<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        string type = Request["type"].ToString();
        
        if (type == "1")
        {
            业务逻辑层.BLL.数据获取 获取 = new 业务逻辑层.BLL.数据获取();
            int 文档编号 = Convert.ToInt32(Request["文档编号"]);
            string strsql = "select 任务文档.标题 as 任务标题,任务公告.标题 as 公告标题,班级名称, 姓名,上传时间,网页位置,成绩,评语 from 任务文档 inner join 任务公告 on 任务文档.任务编号=任务公告.任务编号 inner join 用户 on 任务文档.用户编号=用户.用户编号 inner join 班级 on 班级.班级编号=用户.班级编号 where 文档编号=" + 文档编号;
            DataSet 任务文档 = 获取.获取数据(strsql, "任务文档");
            if (任务文档.Tables[0].Rows.Count > 0)
            {
                DataRow dr = 任务文档.Tables[0].Rows[0];
                string 文档标题 =Server.UrlEncode( dr["任务标题"].ToString());
                string 公告标题 =Server.UrlEncode(dr["公告标题"].ToString());
                string 班级 = dr["班级名称"].ToString();
                string 姓名 =Server.UrlEncode(dr["姓名"].ToString());
                string 网页位置 = dr["网页位置"].ToString();
                DateTime da = Convert.ToDateTime(dr["上传时间"]);
                string 时间 = da.ToString("yyyy") + "-" + da.ToString("MM") + "-" + da.ToString("dd");
                string 成绩 = dr["成绩"].ToString();
                string 评语 =Server.UrlEncode(dr["评语"].ToString());

                string str = "{'static':'success','data':[";
                str += "{'文档标题':'" + 文档标题 + "',";
                str += "'公告标题':'" + 公告标题 + "',";
                str += "'班级':'" + 班级 + "',";
                str += "'姓名':'" + 姓名 + "',";
                str += "'网页位置':'" + 网页位置 + "',";
                str += "'时间':'" + 时间 + "',";
                str += "'成绩':'" + 成绩 + "',";
                str += "'评语':'" + 评语 + "',";
                str += "}]}";
                Response.Write(str);



            }
            else
            {
                Response.Write("{'static':'error','message':'获取数据失败'}"); 
            }
        }
        if (type == "2")
        {
            int 文档编号 = Convert.ToInt32(Request["文档编号"]);
            int 成绩 = Convert.ToInt32(Request["成绩"]);
            string 评语 = Request["评语"].ToString();

            //业务逻辑层.BLL.文档管理 文档 = new 业务逻辑层.BLL.文档管理();
            业务逻辑层.BLL.文档管理 文档 = new 业务逻辑层.BLL.文档管理();
            文档.文档编号 = 文档编号;
            文档.成绩 = 成绩;
            文档.评语 = 评语;
         
            int result = 文档.任务评分(文档);
            if (result > 0)
            {
                Response.Write("{'static':'success'}");
            }
            else
            {
                Response.Write("{'static':'error'}"); 
            }
        }
    }
</script>