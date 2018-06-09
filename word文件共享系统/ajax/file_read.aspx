<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        业务逻辑层.BLL.数据获取 获取 = new 业务逻辑层.BLL.数据获取();
        业务逻辑层.BLL.文档管理 文档 = new 业务逻辑层.BLL.文档管理();
        string type = Request["type"].ToString();

        #region 获取文档相关信息
        if (type == "1")
        {
            int 文档编号 = Convert.ToInt32(Request["文档编号"]);
            文档.文档编号 = 文档编号;
            文档.阅读量加1(文档);
            
            string strsql = "select 标题,标签,网页位置,文件位置,类型,阅读量,下载量,昵称,上传时间 from 报告文档 inner join 用户 on 报告文档.用户编号=用户.用户编号 inner join 报告分类 on 报告分类.分类编号=报告文档.分类编号 where 文档编号=" + 文档编号;
            DataSet 文档资料 = 获取.获取数据(strsql, "报告文档");
          
            
            if (文档资料.Tables[0].Rows.Count > 0)
            {
                DataRow dr = 文档资料.Tables[0].Rows[0];
                string 标题 = dr["标题"].ToString();
                string 昵称 = dr["昵称"].ToString();
                string 网页位置 = dr["网页位置"].ToString();
                string 文件位置 = dr["文件位置"].ToString();
                string 类型 = dr["类型"].ToString();
                string 阅读量 = dr["阅读量"].ToString();
                string 下载量 = dr["下载量"].ToString();
                DateTime da = Convert.ToDateTime(dr["上传时间"]);
                string 上传时间 = da.ToString("yyyy") + "-" + da.ToString("MM") + "-" + da.ToString("dd");
                string str = "{'static':'success','data':[";
                str += "{'标题':'" + 标题 + "',";
                str += "'昵称':'" + 昵称 + "',";
                str += "'网页位置':'" + 网页位置 + "',";
                str += "'文件位置':'" + 文件位置 + "',";
                str += "'下载量':'" + 下载量 + "',";
                str += "'上传时间':'" + 上传时间 + "',";
                str += "'阅读量':'" + 阅读量 + "'}]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error','message':'数据获取失败'}");
            }
        }
        #endregion 
        
        #region 添加评论
        if (type == "2")
        {
            int 用户编号 =Convert.ToInt32(Session["user_id"]);
            int 文档编号 =Convert.ToInt32( Request["文档编号"]);
            string 评论内容 =Server.HtmlEncode( Request["评论内容"].ToString());
            DateTime 评论时间 = DateTime.Now;
            if (用户编号 != null && 文档编号 != null && 评论内容 != "")
            {

                文档.用户编号 = 用户编号;
                文档.文档编号 = 文档编号;
                文档.评论内容=评论内容;
                文档.评论时间 = 评论时间;
                int result = 文档.添加评论(文档);
                if (result > 0)
                {
                    Response.Write("{'static':'success'}");
                }
                else
                {
                    Response.Write("{'static':'error','message':'添加失败！'}");
                }
            }
            else
            {
                Response.Write("{'static':'error','message':'获取参数失败'}");
            }
        }
        #endregion

        #region 获取评论列表
        if (type == "3")
        {
            string 报告编号 = Request["报告编号"].ToString();
            string strsql = "select top 10 昵称,头像位置,评论时间,内容 from 报告评论 inner join 用户 on 报告评论.用户编号=用户.用户编号 where 报告编号=" + 报告编号+"order by 评论时间 desc";
            string strnum = "select COUNT(*) as 数量  from 报告评论 where 报告编号=" + 报告编号;
            DataSet 评论数据 = 获取.获取数据(strsql, "报告评论");
            DataSet 评论数量 = 获取.获取数据(strnum, "报告评论");
            if (评论数据.Tables[0].Rows.Count > 0)
            {
                string 数量 = 评论数量.Tables[0].Rows[0]["数量"].ToString();
               //DataRow dr = 评论数据.Tables[0].Rows[0];

                string str = "{'static':'success','num':'"+数量+"','data':[";
                foreach (DataRow dr in 评论数据.Tables[0].Rows)
                { 
                
                DateTime da = Convert.ToDateTime(dr["评论时间"]);
                string 评论时间 = da.ToString("yyyy") + "-" + da.ToString("MM") + "-" + da.ToString("dd");

                string 内容 = HttpUtility.JavaScriptStringEncode(dr["内容"].ToString()); //进行编码，避免出现json干扰
                str += "{'昵称':'" + dr["昵称"] + "',";
                str += "'头像位置':'" + dr["头像位置"] + "',";
                str += "'评论时间':'" + 评论时间 + "',";
                str += "'内容':'" + 内容 + "'},";
                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'none'}"); 
            }
          
        }
        #endregion 
        
        //下载量加1
        if (type == "4")
        {
            int  文档编号 =Convert.ToInt32(Request["file_id"]);
            文档.文档编号 = 文档编号;
            int i = 文档.下载量加1(文档);
            if (i > 0)
            {
                Response.Write("{'static':'success'}"); 
            }
        }
        
        //获取相关阅读
        if (type == "5")
        {
            string 文档编号 = Request["文档编号"].ToString();
            string sql = "select top 10 文档编号,标题 from 报告文档 where 分类编号=( select 分类编号 from 报告文档 where 文档编号=" + 文档编号 + ")";
            DataSet da = 获取.获取数据(sql, "报告文档");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','data':[";
                foreach (DataRow dr in da.Tables[0].Rows)
                {
                    string 编号 = dr["文档编号"].ToString();
                    string 标题 = Server.UrlPathEncode(dr["标题"].ToString());
                    str += "{'文档编号':'" + 编号 + "',";
                    str += "'标题':'" + 标题 + "'},";

                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'null'}"); 
            }
        }
        //下载排行
        if (type == "6")
        {
            string sql = "select top 10 文档编号,标题 from 报告文档 order by 下载量 desc";
            DataSet da = 获取.获取数据(sql, "报告文档");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','data':[";
                foreach (DataRow dr in da.Tables[0].Rows)
                {
                    string 编号 = dr["文档编号"].ToString();
                    string 标题 = Server.UrlPathEncode(dr["标题"].ToString());
                    str += "{'文档编号':'" + 编号 + "',";
                    str += "'标题':'" + 标题 + "'},";

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
