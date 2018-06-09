<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        业务逻辑层.BLL.会员管理 会员 = new 业务逻辑层.BLL.会员管理();
        业务逻辑层.BLL.数据获取 获取=new 业务逻辑层.BLL.数据获取();
        string type = Request["type"].ToString();

        #region 请求session是否在线
        if (type == "1")
        {
            if (Session["user_id"] != null && Session["user_id"]!= "")
            {
                int 用户编号 = Convert.ToInt32(Session["user_id"]);
                string strsql = "select 昵称,头像位置 from 用户 where 用户编号=" + 用户编号 + "";
                DataSet 用户信息组 = 会员.获取数据(strsql, "用户");
                if (用户信息组.Tables[0].Rows.Count > 0)
                {
                    string 昵称 = 用户信息组.Tables[0].Rows[0]["昵称"].ToString();
                    string 头像位置 = 用户信息组.Tables[0].Rows[0]["头像位置"].ToString();
                    string str = "{'static':'success','昵称':'" + 昵称 + "','头像位置':'" + 头像位置 + "'}";
                    Response.Write(str);
                }
            }
            else
            {
                string str = "{'static':'error'}";
                Response.Write(str);
            }
        }
        #endregion

        #region 请求登录
        if (type == "2")
        {
            string phone = Request["手机号"].ToString();
            string psw = Request["密码"].ToString();
            会员.手机号 = phone;
            会员.密码 = psw;
            DataSet 资料组 = null;
            资料组 = 会员.登录(会员);

            if (资料组.Tables[0].Rows.Count > 0)
            {
               
                string 用户编号="";
                
                string strsql="select 用户编号 from 用户 where 手机号='"+phone+"'";
                DataSet 会员资料组 = 会员.获取数据(strsql, "用户");
                foreach (DataRow rs in 会员资料组.Tables[0].Rows)
                {
                    用户编号=rs["用户编号"].ToString();
                }
                Session["user_id"] = 用户编号;
                string str = "{'static':'success'}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error'}");
            }
        }
        #endregion

        #region 清除session缓存
        if (type == "3")
        {
            Session["user_id"] = null;
            if (Session["user_id"] == null || Session["user_id"] == "")
            {
                Response.Write("{'static':'success'}"); 
            } 
        }
        #endregion

        #region 获取报告列表
        if (type == "4")
        {
            string strsql = "select top 5 文档编号,标题,概述,类型,上传时间 from 报告文档 inner join 报告分类 on 报告文档.分类编号 =报告分类.分类编号 order by 上传时间 desc";
            DataSet 报告资料组 = 获取.获取数据(strsql, "报告文档");
            if (报告资料组.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','data':[";
                foreach (DataRow dr in 报告资料组.Tables[0].Rows)
                {
                    string 文档编号 = dr["文档编号"].ToString();
                    string 标题 =Server.UrlPathEncode(dr["标题"].ToString());
                    string 概述 =Server.UrlPathEncode(dr["概述"].ToString());
                    string 类型 = dr["类型"].ToString();
                    DateTime da = Convert.ToDateTime(dr["上传时间"]);
                    string 上传时间 = da.ToString("yyyy") + "-" + da.ToString("MM") + "-" + da.ToString("dd");
                    str += "{'文档编号':'" + 文档编号 + "','标题':'" + 标题 + "','类型':'" + 类型 + "','上传时间':'" + 上传时间 + "','概述':'" + 概述 + "'},";
                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error'}");
            }
        }
        #endregion
        
        //加载任务列
        if (type == "5")
        {
            string sql = "select top 6 班级名称,标题 from 任务公告 inner join 课任 on 任务公告.课任编号= 课任.课任编号 inner join 班级 on 班级.班级编号=课任.班级编号";
            DataSet da = 获取.获取数据(sql, "任务公告");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','data':[";
                foreach (DataRow dr in da.Tables[0].Rows)
                {
                    string 班级=dr["班级名称"].ToString();
                    string 标题=Server.UrlEncode(dr["标题"].ToString());
                    str += "{'班级':'" + 班级 + "','标题':'" + 标题 + "'},";
                }
                str += "]}";
                Response.Write(str);
            }
        }
        
        //获取热门类表
        if (type == "6")
        {
            string sql = "select top 9 文档编号,标题 from 报告文档 order by 阅读量 desc";
            string sql1 = "select COUNT(*) 数量 from 报告文档";
            
            DataSet da = 获取.获取数据(sql, "报告文档");
          
            if (da.Tables[0].Rows.Count > 0)
            {
                string 数量 = "0";
                try
                {
                    DataSet da1 = 获取.获取数据(sql1, "报告文档");
                    数量 = da1.Tables[0].Rows[0]["数量"].ToString();
                }
                catch { }
                string str = "{'static':'success','数量':'"+数量+"','data':[";
                foreach (DataRow dr in da.Tables[0].Rows)
                {
                    string 文档编号 = dr["文档编号"].ToString();
                    string 标题 = Server.UrlPathEncode(dr["标题"].ToString());
                    str += "{'文档编号':'" + 文档编号 + "','标题':'" + 标题 + "'},";
                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error'}"); 
            }
                 
        }

    }
    

</script>