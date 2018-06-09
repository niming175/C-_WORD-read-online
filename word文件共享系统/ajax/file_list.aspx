<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
     string type = Request["type"].ToString();
        if (type == "1")
        {
            string strsql = "select 分类编号,类型 from 报告分类";
            业务逻辑层.BLL.数据获取 获取 = new 业务逻辑层.BLL.数据获取();
            DataSet 类型数据 = 获取.获取数据(strsql, "文档类型");
            if (类型数据.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','data':[";

                foreach (DataRow dr in 类型数据.Tables[0].Rows)
                {
                    string 分类编号 = dr["分类编号"].ToString();
                    string 类型 = dr["类型"].ToString();
                    str += "{'类型编号':'" + 分类编号 + "',";
                    str += "'类型':'" + 类型 + "'},";


                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error'}");
            }
        }
        if (type == "2")
        {
            业务逻辑层.BLL.数据获取 获取=new 业务逻辑层.BLL.数据获取();
            string 分类编号 = Request["typeid"].ToString();
            string 检索 = Request["title_text"].ToString();
            int 页码 =Convert.ToInt32(Request["page"]);
            int 排序 =Convert.ToInt32(Request["order"]);
            string 分类 = "";
            string 搜索 = "";
            string 排序方式 = "order by 阅读量 desc";

            if (分类编号 != "")
            {
                分类 = "and 分类编号='" + 分类编号 + "'";
            }
            if (检索 != "")
            {
                搜索 = "and (类型 like '%" + 检索 + "%' or 标题 like '%" + 检索 + "%' or 昵称 like '%" + 检索 + "%' or 标签 like '%" + 检索 + "%')";
            }
            switch (排序){
                case 1: 排序方式 = "order by 上传时间 desc";
                    break;
                case 2: 排序方式 = "order by 阅读量 desc";
                    break;
                case 3: 排序方式 = "order by 下载量 desc";
                    break;
                default: 排序方式 = "order by 阅读量 desc";
                    break;
                    
            }

            int a=(页码-1)*10+1;
            int b=(页码-1)*10+10;
            string sql="with cte as ( select id0=row_number() over(order by 文档编号),* from 文档列表 where 状态=1 "+分类+" "+搜索+" ) select * from cte where id0 between "+a+" and "+b+" "+排序方式;
            
            string 文档数量 = "select COUNT(*) as 数量 from 文档列表 where 状态=1 " + 分类 + " " + 搜索;
            DataSet 数量 = 获取.获取数据(文档数量, "报告文档");
            if((Convert.ToInt32(数量.Tables[0].Rows[0]["数量"])/10)+1<页码 || 页码<1)
            {
                Response.Write("{'static':'error','message':'页码溢出'}");
            }
            else
            {
            DataSet 文档列表=获取.获取数据(sql,"报告文档");
            
            if(文档列表.Tables[0].Rows.Count>0)
            {
                string num = 数量.Tables[0].Rows[0]["数量"].ToString();
                string str="{'static':'success','数量':'"+num+"','页码':'"+页码+"','data':[";
                foreach(DataRow dr in 文档列表.Tables[0].Rows)
                {
                    string 文档编号=dr["文档编号"].ToString();
                    string 标题=Server.UrlEncode(dr["标题"].ToString().Trim());
                    string 标签=Server.UrlEncode(dr["标签"].ToString().Trim());
                    string 概述=Server.UrlEncode(dr["概述"].ToString().Trim());
                    DateTime da=Convert.ToDateTime(dr["上传时间"]);
                    string 时间=da.ToString("yyyy")+"-"+da.ToString("MM")+"-"+da.ToString("dd");
                    string 类型=dr["类型"].ToString();
                    string 阅读量 = dr["阅读量"].ToString();
                    string 下载量 = dr["下载量"].ToString();
                    string 昵称 = Server.UrlEncode(dr["昵称"].ToString().Trim());
                    
                    str+="{'文档编号':'"+文档编号+"',";
                    str+="'标题':'"+标题+"',";
                    str+="'标签':'"+标签+"',";
                    str+="'昵称':'"+昵称+"',";
                    str+="'概述':'"+概述+"',";
                    str+="'时间':'"+时间+"',";
                    str += "'阅读量':'" + 阅读量 + "',";
                    str += "'下载量':'" + 下载量 + "',";
                    str+="'类型':'"+类型+"'},";
                    
                }
                str+="]}";
                Response.Write(str);
                return;
            }
            
            else
            {
                Response.Write("{'static':'null'}");
            }
            
            }
        }
        
    }
</script>