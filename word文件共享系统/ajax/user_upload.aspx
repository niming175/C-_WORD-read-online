<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        业务逻辑层.BLL.数据获取 数据 = new 业务逻辑层.BLL.数据获取();
        业务逻辑层.BLL.文档管理 管理 = new 业务逻辑层.BLL.文档管理();
        string type = Request["type"].ToString();
        if (type == "1")
        {
            string str = "select * from 报告分类";
            DataSet 报告分类列= 数据.获取数据(str, "报告分类");
            if (报告分类列.Tables[0].Rows.Count > 0)
            {
                string data = "{'static':'success','data':[";
                foreach(DataRow dr in 报告分类列.Tables[0].Rows)
                {
                    data+="{'分类编号':'"+dr["分类编号"]+"','类型':'"+dr["类型"]+"'},";  
                }
                data += "]}";
                Response.Write(data);
            }
            else
            {
                Response.Write("{'static':'error'}");
               
            }
        }
        
        //文件数据插入数据库
        if (type == "2")
        {
            if (Session["user_id"] != null && Session["user_id"] != "")
            {

                string 文件位置 = Request["文件位置"].ToString();
                string 标题 = Request["标题"].ToString();
                string 标签 = Request["标签"].ToString();
                string 概述 = Request["概述"].ToString();
                int 分类编号 =Convert.ToInt32(Request["分类编号"]);
                string 网页位置 = Request["网页位置"].ToString();
                管理.文档位置 = 文件位置;
                管理.标题 = 标题;
                管理.标签 = 标签;
                管理.概述 = 概述;
                管理.分类编号 = 分类编号;
                管理.网页位置 = 网页位置;
                管理.上传时间 = DateTime.Now;
                管理.用户编号 = Convert.ToInt32( Session["user_id"]);

                int result = 管理.上传文档数据(管理);
                if (result > 0)
                {
                    Response.Write("{'static':'success'}");
                }
                else
                {
                    Response.Write("{'static':'error','message':'添加失败'}");
                }
            }
            else
            {
                Response.Write("{'static':'error','message':'你已经掉线'}");
            }

        }
        
    }
</script>