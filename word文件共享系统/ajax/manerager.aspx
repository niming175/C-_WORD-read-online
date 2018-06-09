<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        业务逻辑层.BLL.后台管理 后台 = new 业务逻辑层.BLL.后台管理();
        业务逻辑层.BLL.数据获取 获取=new 业务逻辑层.BLL.数据获取();
        string type=Request["type"].ToString();
        if (type == "1")
        {
            string sql = "select 分类编号,类型 from 报告分类";
            //业务逻辑层.BLL.数据获取 获取 = new 业务逻辑层.BLL.数据获取();
            DataSet da = 获取.获取数据(sql, "分类");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','data':[";
                foreach (DataRow dr in da.Tables[0].Rows)
                {
                    string 分类编号 = dr["分类编号"].ToString();
                    string 类型 =Server.UrlEncode(dr["类型"].ToString());
                    str += "{'分类编号':'" + 分类编号 + "',";
                    str += "'类型':'" + 类型 + "'},";
                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("'static':'null'"); 
            } 
        }

        if (type == "2")
        {
            string 类型 = Request["类型"].ToString();
            string sql = "select top 1 分类编号 from 报告分类 order by 分类编号 desc";
            //业务逻辑层.BLL.数据获取 获取 = new 业务逻辑层.BLL.数据获取();
            DataSet da = 获取.获取数据(sql, "报告分类");
            string 分类 = da.Tables[0].Rows[0]["分类编号"].ToString();
            //int num =Convert.ToInt32( GetLastStr(分类, 2));
           // num = num + 1;
           // 分类 = "t00" + num.ToString();
            //Response.Write(分类);

            后台.type = 类型;
            //后台.typeid = 分类;

            int resule = 0;
           resule=后台.添加类型(后台);
            if(resule>0)
            {
                Response.Write("{'static':'success'}");
            }
            else
            {
                Response.Write("{'static':'error'}");
            }
               
            
            
        }
        if (type == "3")
        {
            int 分类编号 =Convert.ToInt32(Request["分类编号"].ToString());
            string 类型 = Request["类型"].ToString();
            后台.type = 类型;
            后台.typeid = 分类编号;
            int i = 后台.修改类型(后台);
            if (i > 0)
            {
                Response.Write("{'static':'success'}");
            }
            else
            {
                Response.Write("{'static':'error'}"); 
            }
            
             
        }
        
        //获取系别列表
        if (type == "4")
        {
            string sql = "select * from 系别";
            DataSet da = 获取.获取数据(sql, "系别");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','data':[";
                foreach (DataRow dr in da.Tables[0].Rows)
                {
                    string 系别编号 = dr["系别编号"].ToString();
                    string 系别名称 = dr["系别名称"].ToString();
                    str += "{'系别编号':'" + 系别编号 + "',";
                    str += "'系别名称':'" + 系别名称 + "'},";

                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error'}");  
            }
        }
        
        //获取班级列表
        if (type == "5")
        {
            string sql = "select 班级编号,系别名称,班级名称 from 班级 inner join 系别 on 系别.系别编号=班级.系别编号 order by 系别名称";
            DataSet da = 获取.获取数据(sql, "班级");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'static':'success','data':[";
                foreach (DataRow dr in da.Tables[0].Rows)
                {
                    string 班级编号 = dr["班级编号"].ToString();
                    string 系别名称 = dr["系别名称"].ToString();
                    string 班级名称 = dr["班级名称"].ToString();

                    str += "{'系别名称':'" + 系别名称 + "',";
                    str += "'班级编号':'" + 班级编号 + "',";
                    str += "'班级名称':'" + 班级名称 + "'},";

                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'static':'error'}"); 
            } 
        }

        
        //添加系别
        if (type == "6")
        {
            string 系别名称 = Request["系别名称"].ToString();
            后台.系别名称 = 系别名称;
            int 结果 = 后台.添加系别(后台);
            if (结果 > 0)
            {
                Response.Write("{'static':'success'}");
            }
            else
            {
                Response.Write("{'static':'error'}"); 
            }
        }
        
        //添加班级
        if (type =="7")
        {
            string 班级名称 = Request["班级名称"].ToString();
            int 系别编号 = Convert.ToInt32(Request["系别编号"]);
            后台.班级名称 = 班级名称;
            后台.系别编号 = 系别编号;
            int i = 后台.添加班级(后台);
            if (i > 0)
            {
                Response.Write("{'static':'success'}");
            }
            else
            {
                Response.Write("{'static':'error'}"); 
            }
            
        }
        
        /*添加辅导员*/
        if (type == "8")
        {
            string 手机号 = Request["phone"].ToString();
            string 姓名 = Request["name"].ToString();
            int 性别= Convert.ToInt32(Request["sex"]);
            后台.姓名 = 姓名;
            后台.手机号 = 手机号;
            后台.性别 = 性别;
            int i = 0;
            try {
                i = 后台.添加辅导员(后台);
                
            }
            catch
            {
                i=0;
            }
            if (i == 1)
            {
                Response.Write("{'state':'success'}");
            }
            else
            {
                Response.Write("{'state':'error'}");
            }
            
            
        }
        /*加载辅导员*/
        if (type == "9")
        {
            string str = "select 辅导员.辅导员编号,姓名,性别,手机,count(班级编号) 数量 from 辅导员 left join 班级 on 班级.辅导员编号=辅导员.辅导员编号 group by 辅导员.辅导员编号, 姓名,性别, 手机";
            string str2 = "select count(*) from 辅导员";
            try
            {

                DataSet da = 获取.获取数据(str, "辅导员");
                DataSet da2 = 获取.获取数据(str2, "辅导员");
                if (da.Tables[0].Rows.Count > 0)
                {
                    string data = "{'state':'success','count':'"+da2.Tables[0].Rows[0][0].ToString()+"','data':[";
                    foreach (DataRow dr in da.Tables[0].Rows)
                    {
                        data += "{'辅导员编号':'" + dr["辅导员编号"].ToString() + "',";
                        data += "'姓名':'" + HttpUtility.JavaScriptStringEncode(dr["姓名"].ToString()) + "',";
                        data += "'性别':'" + Convert.ToInt32(dr["性别"]) + "',";
                        data += "'数量':'" + dr["数量"].ToString() + "',";
                        data += "'手机号':'" + dr["手机"].ToString() + "'},";
                    }
                    data += "]}";
                    Response.Write(data);
                }
                else
                {
                    Response.Write("{'state':'error','msg':'0'}"); 
                }
            }
            catch {
                Response.Write("{'state':'error','msg':'1'}"); 
            }
        }
        /*根据辅导员编号加载辅导员信息*/
        if (type == "10")
        {
            //string 辅导员编号 = Request["辅导员编号"].ToString();
            //string 查询 = "select 辅导员编号,姓名,性别,手机号 from 辅导员 where 辅导员编号='" + 辅导员编号 + "'";
            //try {
            //    DataSet 结果 = 获取.获取数据(查询, "辅导员");
            //    if (结果.Tables[0].Rows.Count > 0)
            //    {
            //        string 姓名
            //        Response.Write("{'state':'success','辅导员编号'}") 
            //    }
            //} 
        }
        if (type == "11")
        {
            if (Request["项目"].ToString() == "1")
            {
                string 手机号 = Request["手机号"].ToString();
                string 查询 = "select * from 辅导员 where 手机='" + 手机号 + "'";
                try
                {
                    DataSet 结果 = 获取.获取数据(查询, "辅导员");
                    if (结果.Tables[0].Rows.Count > 0)
                    {
                        Response.Write("{'state':'error','msg':'手机号已注册'}");
                    }
                    else
                    {
                        Response.Write("{'state':'success'}");
                    }
                }
                catch
                {
                    Response.Write("{'state':'error','msg':'查询出错'}");
                } 
            }
            
            /*为辅导员修改手机号，判断是否别人占用*/
            if (Request["项目"].ToString() == "2")
            {
                int 辅导员编号 = Convert.ToInt32(Request["辅导员编号"]);
                string 手机号 = Request["手机号"].ToString();

                string 查询 = "select 手机 from 辅导员 where 手机='" + 手机号 + "' and 辅导员编号<>" + 辅导员编号;
                try {
                    DataSet 结果 = 获取.获取数据(查询, "辅导员");
                    if (结果.Tables[0].Rows.Count > 0)
                    {
                        Response.Write("{'state':'error','msg':'手机号已注册'}");
                    }
                    else
                    {
                        Response.Write("{'state':'success'}");
                    }
                }
                catch
                {
                    Response.Write("{'state':'error','msg':'查询出错'}");
                } 
                
            } 
        }
        
        /*修改辅导员信息*/
        if (type == "12")
        {
            int 辅导员编号 = Convert.ToInt32(Request["辅导员编号"]);
            string 手机号 = Request["手机号"].ToString();
            string 姓名 = Request["姓名"].ToString();
            int 性别 = Convert.ToInt32(Request["性别"]);
            后台.辅导员编号 = 辅导员编号;
            后台.姓名 = 姓名;
            后台.性别 = 性别;
            后台.手机号 = 手机号;
            try
            {
                int 结果 = 后台.修改辅导员信息(后台);
                if (结果 > 0)
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

        /*恢复辅导员密码*/
        if (type == "13")
        {
            int 辅导员编号 = Convert.ToInt32(Request["辅导员编号"]);
            try
            {
                后台.辅导员编号 = 辅导员编号;
                int 结果 = 后台.恢复辅导员密码(后台);
                if (结果 > 0)
                {
                    Response.Write("{'state':'success'}");
                }
                else
                {
                    Response.Write("{'state':'error'}");
                }
            }
            catch { Response.Write("{'state':'error'}"); }
        }
        
        //加载年级
        if (type == "14")
        {
            int 系别编号 = Convert.ToInt32(Request["系别编号"]);
            int 年级 = Convert.ToInt32(Request["年级"]);
            string 查询 = "select * from 班级 where 系别编号=" + 系别编号 + " and 年级=" + 年级 + " and 辅导员编号 is null";
            try
            {
                DataSet 结果 = 获取.获取数据(查询, "辅导员");
                
                if (结果.Tables[0].Rows.Count > 0)
                {

                    string json = "{'state':'success','data':[";
                    foreach (DataRow da in 结果.Tables[0].Rows)
                    {
                        string 班级编号 = da["班级编号"].ToString();
                        string 班级名称 =HttpUtility.JavaScriptStringEncode(da["班级名称"].ToString()+da["班别"].ToString()+"班");

                        json += "{'班级编号':'" + 班级编号 + "','班级名称':'" + 班级名称 + "'},";
                    }
                    json += "]}";
                    Response.Write(json);
                }
                else
                {
                    Response.Write("{'state':'error'}");
                }
                
            }
            catch {
                Response.Write("{'state':'error'}");
            }
        }
        
        if(type=="15")
        {
            DateTime date =new  DateTime();
            date = DateTime.Now;
            int i= Convert.ToInt32(date.ToString("yyyy"));
            Response.Write("{'state':'success','year':"+i+"}");
        }
        
        //添加辅导员负责班级
        if (type == "16")
        {
            int 班级编号 = Convert.ToInt32(Request["班级编号"]);
            int 辅导员编号 = Convert.ToInt32(Request["辅导员编号"]);
            后台.classid = 班级编号;
            后台.辅导员编号 = 辅导员编号;
            try
            {
                int 结果 = 后台.添加负责班级(后台);
                if (结果 == 1)
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
        if (type == "17")
        {
            int 辅导员编号 = Convert.ToInt32(Request["辅导员编号"]);
            string 查询 = "select 班级编号,专业名称,年级,班别,系别名称 from 班级 ";
            查询+=" inner join 专业 on 专业.专业编号 =班级.专业编号:";
            查询 += "inner join 系别 on 专业.系别编号=系别.系别编号 where 辅导员编号=" + 辅导员编号;
            try
            {
                DataSet 结果 = 获取.获取数据(查询, "班级");
                if (结果.Tables[0].Rows.Count > 0)
                {
                    string str = "{'state':'success','data':[";
                    foreach (DataRow da in 结果.Tables[0].Rows)
                    {
                        string 系别名称 = da["系别名称"].ToString();
                        string 班级编号 = da["班级编号"].ToString();
                        string 班级名称 = HttpUtility.JavaScriptStringEncode(da["年级"].ToString().Substring(2) + "级" + da["专业名称"].ToString() + da["班别"].ToString() + "班");
                        str += "{'班级编号':'" + 班级编号 + "','系别名称':'" + 系别名称 + "','班级名称':'" + 班级名称 + "'},";
                    }
                    str += "]}";
                    Response.Write(str);
                }
                else
                {
                    Response.Write("{'state':'error'}");
                }
            }
            catch {

                Response.Write("{'state':'error'}");
            }
            
        }
        if (type == "18")
        {
            int 班级编号=Convert.ToInt32(Request["班级编号"]);
            int 辅导员编号 = Convert.ToInt32(Request["辅导员编号"]);
            后台.classid = 班级编号;
            后台.辅导员编号 = 辅导员编号;
            try
            {
                if (后台.删除负责班级(后台) > 0)
                {
                    Response.Write("{'state':'success'}");
                }
                else
                {
                    Response.Write("{'state':'error'}");
                }
            }
            catch {
                Response.Write("{'state':'error'}");
            }
            
            
        }
        
        
    }


 
</script>