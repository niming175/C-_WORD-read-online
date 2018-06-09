<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
        业务逻辑层.BLL.后台管理 后台 = new 业务逻辑层.BLL.后台管理();
        业务逻辑层.BLL.数据获取 获取=new 业务逻辑层.BLL.数据获取();
    private void Page_Load(object sender, EventArgs e)
    {
       
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
                    string 识别码 = dr["识别码"].ToString();
                    str += "{'系别编号':'" + 系别编号 + "',";
                    str += "'识别码':'" + 识别码 + "',";
                    str += "'系别名称':'" + 系别名称 + "'},";

                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                Response.Write("{'state':'error'}");  
            }
        }
        
        //获取班级列表
        if (type == "5.1")
        {
            DateTime 时间 = new DateTime();
            时间 = DateTime.Now;
            string time = 时间.ToString("yyyy");
            int 系别编号 = Convert.ToInt32(Request["系别编号"]);
            string 学年查询 = "select distinct 年级 from 班级 where 系别编号=" + 系别编号 + "order by 年级 desc";
           // string 辅导员查询 = "select 姓名,手机 from 辅导员";
            try
            {
                DataSet 结果 = 获取.获取数据(学年查询, "班级");
                if (结果.Tables[0].Rows.Count > 0)
                {
                    string str = "{'state':'success','时间':'"+time+"','time':[";
                    foreach (DataRow d in 结果.Tables[0].Rows)
                    {
                        str += "{'time':'" + d["年级"].ToString() + "'},";
                    }
                    str += "]}";
                    Response.Write(str);
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
        //获取辅导员信息
        if (type == "5.2")
        {
            string 辅导员查询 = "select 辅导员编号,姓名,手机 from 辅导员";
            try
            {
                DataSet 结果 = 获取.获取数据(辅导员查询, "辅导员");
                if (结果.Tables[0].Rows.Count > 0)
                {
                    string str = "{'state':'success','data':[";
                    foreach (DataRow d in 结果.Tables[0].Rows)
                    {
                        string 辅导员编号 = d["辅导员编号"].ToString();
                        string 姓名 = d["姓名"].ToString();
                        string 手机 = d["手机"].ToString();
                        str += "{'辅导员编号':'"+辅导员编号+"','姓名':'" + 姓名 + "','手机':'" + 手机 + "'},";

                    }
                    str += "]}";
                    Response.Write(str);
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

        if (type == "5.3")
        {
            int 系别编号 = Convert.ToInt32(Request["系别编号"]);
            string 专业查询 = "select 专业.专业编号,系别.识别码 as 系别识别码,专业.识别码 as 专业识别码,专业名称,a.数量 from 专业 inner join 系别 on 系别.系别编号=专业.系别编号 left join (select COUNT(*) as 数量,专业编号  from 班级 group by 班级.专业编号) as a on 专业.专业编号=a.专业编号 where 专业.系别编号=" + 系别编号;
            string 数量 = "0";
            try
            {
                DataSet 结果 = 获取.获取数据(专业查询, "专业");
                if (结果.Tables[0].Rows.Count > 0)
                {
                    数量 = 结果.Tables[0].Rows.Count.ToString();
                    string str = "{'state':'success','num':'" + 数量 + "','data':[";
                    foreach (DataRow d in 结果.Tables[0].Rows)
                    {
                        string 识别码 = d["系别识别码"].ToString() + d["专业识别码"].ToString();
                        string 专业编号 = d["专业编号"].ToString();
                        string 专业名称 = d["专业名称"].ToString();
                        string 班级数 = d["数量"].ToString() == "" ? "0" : d["数量"].ToString();
                        str += "{'识别码':'" + 识别码 + "',";
                        str += "'专业编号':'" + 专业编号 + "',";
                        str += "'专业名称':'" + 专业名称 + "',";
                        str += "'班级数':'" + 班级数 + "'},";

                    }
                    str += "]}";
                    Response.Write(str);
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
        /*修改专业名称*/
        if (type == "5.4")
        {
            int 专业编号 = Convert.ToInt32(Request["专业编号"]);
            string 专业名称 = Request["专业名称"].ToString();
            后台.专业编号 = 专业编号;
            后台.专业名称 = 专业名称;
            try
            {
                if (后台.修改专业(后台) > 0)
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
        //添加专业
        if (type == "5.5")
        {
            int 系别编号 = Convert.ToInt32(Request["系别编号"]);
            string 专业名称 = Request["专业名称"];
            int 识别码;

            string 查询重复 = "select * from 专业 where 专业名称='" + 专业名称 + "' and 系别编号 =" + 系别编号;
            try
            {
                DataSet da1 = 获取.获取数据(查询重复, "专业");
                if (da1.Tables[0].Rows.Count > 0)
                {
                    Response.Write("{'state':'msg'}");
                    return;
                }
                else
                {
                    string 查询 = "select top 1 识别码 from 专业 where 系别编号=" + 系别编号 + " order by 识别码 desc";
                    try
                    {
                        DataSet 结果 = 获取.获取数据(查询, "专业");
                        if (结果.Tables[0].Rows.Count > 0)
                        {
                            识别码 = Convert.ToInt32(结果.Tables[0].Rows[0]["识别码"]) + 1;
                        }
                        else
                        {
                            Random ran = new Random();
                            string i = ran.Next(1, 7).ToString();
                            识别码 = Convert.ToInt32(i + "1");
                        }
                    }
                    catch
                    {
                        Random ran = new Random();
                        string i = ran.Next(1, 7).ToString();
                        识别码 = Convert.ToInt32(i + "1");
                    }
                    后台.系别编号 = 系别编号;
                    后台.专业名称 = 专业名称;
                    后台.识别码 = 识别码;
                    try
                    {
                        int i = 后台.添加专业(后台);
                        if (i > 0)
                        {
                            string ii = "00";
                            try
                            {
                                DataSet da = 获取.获取数据("select 识别码 from 系别 where 系别编号=" + 系别编号, "系别");
                                ii = da.Tables[0].Rows[0]["识别码"].ToString();
                            }
                            catch { }
                            ii = ii + 识别码.ToString();
                            Response.Write("{'state':'success','识别码':'" + ii + "'}");
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
            catch
            {
                Response.Write("{'state':'error'}");
            }
                
        }
        
        //修改系别
        if (type == "5.6")
        {
            int 系别编号 = Convert.ToInt32(Request["系别编号"]);
            string 系别名称 = Request["系别名称"].ToString();
            string 查重 = "select * from 系别 where 系别名称='" + 系别名称 + "'";
            try
            {
                DataSet da = 获取.获取数据(查重, "系别");
                if (da.Tables[0].Rows.Count == 0)
                {
                    后台.系别编号 = 系别编号;
                    后台.系别名称 = 系别名称;
                    try
                    {
                        int i = 后台.修改系别(后台);
                        if (i > 0)
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
            catch
            {
                Response.Write("{'state':'error'}");
            }
        }
        if (type == "5.7")
        {
            int 专业编号 = Convert.ToInt32(Request["专业编号"]);
            string 查询 = "select 专业名称,系别名称,专业.系别编号 from 专业 inner join 系别 on 专业.系别编号=系别.系别编号 where 专业编号=" + 专业编号;
            try
            {
                DataSet 结果 = 获取.获取数据(查询, "专业");
                if (结果.Tables[0].Rows.Count > 0)
                {
                    string 专业名称 = 结果.Tables[0].Rows[0]["专业名称"].ToString();
                    string 系别编号 = 结果.Tables[0].Rows[0]["系别编号"].ToString();
                    string 系别名称 = 结果.Tables[0].Rows[0]["系别名称"].ToString();
                    string str = "{'state':'success','专业名称':'" + 专业名称 + "','系别名称':'"+系别名称+"','系别编号':'"+系别编号+"','data':[";
                    string 学院查询 = "select * from 系别";
                    DataSet 系别结果 = 获取.获取数据(学院查询, "系别");
                    foreach (DataRow d in 系别结果.Tables[0].Rows)
                    {
                        string 系别编号1 = d["系别编号"].ToString();
                        string 系别名称1 = d["系别名称"].ToString();
                        str += "{'系别编号':'" + 系别编号1 + "','系别名称':'" + 系别名称1 + "'},";
                    }
                    str += "]}";
                    Response.Write(str);
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
        if (type == "5.8")
        {
            int 系别编号 = Convert.ToInt32(Request["系别编号"]);
            int 专业编号 = Convert.ToInt32(Request["专业编号"]);
            string 查询 = "select 识别码 from 专业 where 专业编号=" + 专业编号;
            int 识别码;
            string cha = "";
            DataSet 结果 = 获取.获取数据(查询, "专业");
            if (结果.Tables[0].Rows.Count > 0)  //大于零表示
            {
                识别码 = Convert.ToInt32(结果.Tables[0].Rows[0]["识别码"]);
                cha = "select * from 专业 where 识别码=" + 识别码 + " and 系别编号=" + 系别编号;//查看是否存在该识别码
                DataSet jieguo = 获取.获取数据(cha, "专业");
                if (jieguo.Tables[0].Rows.Count > 0)
                {
                    //该识别码已经存在
                    string cha2 = "select top 1 from 专业 where 系别编号=" + 系别编号;
                    DataSet jie2 = 获取.获取数据(cha2, "专业");
                    识别码 = Convert.ToInt32(jie2.Tables[0].Rows[0]["识别码"]) + 1;
                }
                else
                { }
            }
            else
            {
                识别码 = 11; 
            }
            后台.系别编号 = 系别编号;
            后台.识别码 = 识别码;
            后台.专业编号 = 专业编号;
            try
            {
                int i = 后台.修改专业归属(后台);
                if (i > 0)
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

        if (type == "5.9")
        {
            int 专业编号 = Convert.ToInt32(Request["专业编号"]);
            string 年级查询 = "select distinct(年级),专业编号 from 班级 where 专业编号=" + 专业编号 + "  group by 专业编号 ,年级 order by 年级 desc";
            try
            {
                DataSet da = 获取.获取数据(年级查询, "班级");
                if (da.Tables[0].Rows.Count > 0)
                {
                    string str = "{'state':'success','year':[";
                    foreach (DataRow d in da.Tables[0].Rows)
                    {
                        str += "{'年级':'" + d["年级"].ToString() + "'},";
                    }
                    str += "]}";
                    Response.Write(str);

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

        if (type == "6.0")
        {
            int 专业编号 = Convert.ToInt32(Request["专业编号"]);
            int 年级 = Convert.ToInt32(Request["年级"]);
            string 查询识别码 = "select 系别.识别码 as 系别识别码, 专业.识别码 as 专业识别码 from 专业 inner join 系别 on 专业.系别编号=系别.系别编号 where  专业编号=" + 专业编号;
            DataSet 识别码结果 = 获取.获取数据(查询识别码, "专业");
            string 识别码 = 识别码结果.Tables[0].Rows[0]["系别识别码"].ToString() + 识别码结果.Tables[0].Rows[0]["专业识别码"].ToString()+ 年级.ToString().Substring(2,2);

            string 班级查询 = "select 班级.班级编号, 年级,班别,数量,班级.辅导员编号,辅导员.姓名  from 班级 inner join 专业 on 专业.专业编号=班级.专业编号";
            班级查询 += " left join(select COUNT(*) as 数量, 班级编号 from 用户 group by 班级编号) as a";
            班级查询 += " on a.班级编号=班级.班级编号";
            班级查询 += " left join 辅导员 on 辅导员.辅导员编号=班级.辅导员编号";
            班级查询 += " where 年级=" + 年级;
            班级查询 += " and 班级.专业编号=" + 专业编号;
            班级查询 += " order by 班级.班别";

            try
            {
                DataSet da = 获取.获取数据(班级查询, "班级");
                if (da.Tables[0].Rows.Count > 0)
                {
                    string str = "{'state':'success','识别码':'" + 识别码 + "','data':[";
                    foreach (DataRow d in da.Tables[0].Rows)
                    {
                        string 年级1 = d["年级"].ToString();
                        string 班别 = d["班别"].ToString();
                        班别 = 班别.PadLeft(2, '0');
                        string 数量 = d["数量"].ToString();
                        string 姓名 = d["姓名"].ToString();
                        string 辅导员编号 = d["辅导员编号"].ToString();
                        string 班级编号 = d["班级编号"].ToString();

                        str += "{'年级':'" + 年级1 + "',";
                        str += "'班别':'" + 班别 + "',";
                        str += "'班级编号':'" + 班级编号 + "',";
                        str += "'数量':'" + 数量 + "',";
                        str += "'辅导员编号':'" + 辅导员编号 + "',";
                        str += "'姓名':'" + 姓名 + "'},";

                    }
                    str += "]}";
                    Response.Write(str);
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
        if (type == "5")
        {
            DateTime 时间 = new DateTime();
            时间 = DateTime.Now;
            
            int 系别编号=Convert.ToInt32(Request["系别编号"]);
           
            string 学年查询 = "select distinct 年级 from 班级 where 系别编号=" + 系别编号+"order by 年级 desc";
            string xuenian = Request["学年"].ToString();
               int 学年= Convert.ToInt32(时间.ToString("yyyy"));
               
            
            string time = "";
            try
            {
                DataSet 学年结果 = 获取.获取数据(学年查询, "班级");
                if (学年结果.Tables[0].Rows.Count > 0)
                {
                    time = ",'timedata':[";
                    foreach (DataRow d in 学年结果.Tables[0].Rows)
                    {
                        time += "{'time':'" + d["年级"].ToString() + "'},";

                    }
                    time += "]";
                    学年 = Convert.ToInt32(学年结果.Tables[0].Rows[0]["年级"]);
                }
                else
                {
                    time = ",'timedata':'error'";
                    
                }
                 
            }
            catch
            {
                time = ",'timedata':'error'";
            }
            if (xuenian != "null")
            {
                学年 = Convert.ToInt32(xuenian);
            }
            else
            { }
            string sql = "select 班级编号,系别名称,班级名称,系别.识别码 as 系别识别码,班级.识别码 as 班级识别码,年级,班别, 姓名 from 班级 inner join 系别 on 系别.系别编号=班级.系别编号 left join 辅导员 on 辅导员.辅导员编号=班级.辅导员编号 where 班级.系别编号=" + 系别编号 + " and 年级 =" +学年+ " order by 系别名称";
           
            try
            {
                DataSet da = 获取.获取数据(sql, "班级");

                string str = "{'static':'success','时间':'" + 时间.ToString("yyyy") + "',";
                if (da.Tables[0].Rows.Count > 0)
                {
                    str+="'data':[";
                    foreach (DataRow dr in da.Tables[0].Rows)
                    {
                        string 系别识别码 = dr["系别识别码"].ToString();
                        string 班级识别码 = dr["班级识别码"].ToString();
                        string 年级 = dr["年级"].ToString();
                        string 班别 = dr["班别"].ToString();
                        班别 = 班别.PadLeft(2, '0');
                        string 班级编号 = dr["班级编号"].ToString();
                        string 系别名称 = dr["系别名称"].ToString();
                        string 班级名称 = dr["班级名称"].ToString();
                        string 辅导员 = dr["姓名"].ToString();

                        str += "{'系别名称':'" + 系别名称 + "',";
                        str += "'系别识别码':'" + 系别识别码 + "',";
                        str += "'班级识别码':'" + 班级识别码 + "',";
                        str += "'学年':'" + 年级 + "',";
                        str += "'班别':'" + 班别 + "',";
                        str += "'班级编号':'" + 班级编号 + "',";
                        str += "'辅导员':'" + 辅导员 + "',";
                        str += "'班级名称':'" + 班级名称 + "'},";

                    }
                    str += "]";
                    
                    
                }
                else
                {
                    str += "'data':'errro'";
                }
                str += "" + time + "}";
                Response.Write(str);
            }
            catch
            {
                 Response.Write("{'static':'error'}");
            }
        }

        
        //添加系别
        if (type == "6")
        {
            string 系别名称 = Request["系别名称"].ToString();

            string 查重 = "select * from 系别 where 系别名称='" + 系别名称 + "'";
            try
            {
                DataSet 查重结果 = 获取.获取数据(查重, "系别");
                if (查重结果.Tables[0].Rows.Count == 0)
                {
                    string 查询识别码 = "select top 1 识别码 from 系别 order by 识别码 desc";
                    DataSet 查询识别码结果 = 获取.获取数据(查询识别码, "系别");
                    int 系别识别码;
                    if (查询识别码结果.Tables[0].Rows.Count > 0)
                    {
                        系别识别码 = Convert.ToInt32(查询识别码结果.Tables[0].Rows[0]["识别码"]) + 1;
                    }
                    else
                    {
                        系别识别码 = 31;

                    }
                    后台.系别名称 = 系别名称;
                    后台.识别码 = 系别识别码;

                    try
                    {
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
                    catch
                    { Response.Write("{'state':'error'}"); }

                }
                else
                {
                    Response.Write("{'state':'msg'}");
                }
            }
            catch
            { 
                 Response.Write("{'state':'error'}");
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
            string 查询 = "select 班级编号,专业名称,班别,辅导员编号 from 专业";
查询+=" inner join 班级 on 班级.专业编号=专业.专业编号";
查询+=" inner join 系别 on 系别.系别编号=专业.系别编号";
查询+=" where 专业.系别编号="+系别编号;
查询+=" and 年级="+年级;
查询+=" and 辅导员编号 is null";
            try
            {
                DataSet 结果 = 获取.获取数据(查询, "辅导员");
                
                if (结果.Tables[0].Rows.Count > 0)
                {

                    string json = "{'state':'success','data':[";
                    foreach (DataRow da in 结果.Tables[0].Rows)
                    {
                        string 班级编号 = da["班级编号"].ToString();
                        string 班级名称 =HttpUtility.JavaScriptStringEncode(da["专业名称"].ToString()+da["班别"].ToString()+"班");

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
            查询 += " inner join 专业 on 专业.专业编号 =班级.专业编号";
            查询 += " inner join 系别 on 专业.系别编号=系别.系别编号 where 辅导员编号=" + 辅导员编号; 
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
        
        //删除辅导员负责班级
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


        switch (type)
        {
            case "19": 获取今年(); break;
            case "20": 获取辅导员列表(); break;
            case "21": 获取班别(); break;
            case "22": 添加班级(); break;
            case "23": 修改班级辅导员(); break;
        }
        
        
        
       


    }
    #region 获取今年
    public void 获取今年()
    {
        DateTime da = new DateTime();
        da = DateTime.Now;
        string 时间 = da.ToString("yyyy");

        Response.Write("{'state':'success','今年':'" + 时间 + "'}");
    }
    #endregion
    
    //获取辅导员列表 type:19
    public void 获取辅导员列表()
    {
        string 查询 = "select 辅导员编号,姓名,手机 from 辅导员 order by 姓名";
        try
        {
            DataSet da = 获取.获取数据(查询, "辅导员");
            if (da.Tables[0].Rows.Count > 0)
            {
                string str = "{'state':'success','data':[";
                foreach (DataRow d in da.Tables[0].Rows)
                {
                    string 辅导员编号 = d["辅导员编号"].ToString();
                    string 姓名 = d["姓名"].ToString();
                    string 手机号 = d["手机"].ToString();
                    str += "{'辅导员编号':'" + 辅导员编号 + "',";
                    str += "'姓名':'" + 姓名 + "',";
                    str += "'手机号':'" + 手机号 + "'},";
                }
                Response.Write(str + "]}");
            }
            else
            {
                Response.Write("{'state','error'}");
            }
        }
        catch
        {
            Response.Write("{'state','error'}");
        }
    }
    
    //自动获取专业班别
    public void 获取班别()
    {
        int 专业编号 = Convert.ToInt32(Request["专业编号"]);
        int 年级 = Convert.ToInt32(Request["年级"]);
        string 查询 = "select top 1 班别 from 班级 where 专业编号=" + 专业编号;
        查询 += " and 年级=" + 年级;
        查询 += " group by 专业编号,班别 order by 班别 desc";
        int 班别 = 1;
        try
        {
            DataSet da = 获取.获取数据(查询, "班级");
            if (da.Tables[0].Rows.Count > 0)
            {
                班别 = Convert.ToInt32(da.Tables[0].Rows[0]["班别"]) + 1;
            }
            Response.Write("{'state':'success','班别':'" + 班别 + "'}");
        }
        catch
        {
            Response.Write("{'state','error'}");  
        }
    }

    public void 添加班级()
    {
        string 辅导员id = Request["辅导员编号"].ToString();
        int 辅导员编号=辅导员id=="null"?0:Convert.ToInt32(辅导员id);
        int 年级 = Convert.ToInt32(Request["年级"]);
        int 班别 = Convert.ToInt32(Request["班别"]);
        int 专业编号 = Convert.ToInt32(Request["专业编号"]);
        string 查重 = "select * from 班级 where 班别=" + 班别;
        查重 += " and 专业编号=" + 专业编号;
        查重 += " and 年级=" + 年级;
        try
        {
            DataSet 查重结果 = 获取.获取数据(查重, "班级");
            if (查重结果.Tables[0].Rows.Count == 0)
            {
                后台.专业编号 = 专业编号;
                后台.年级 = 年级;
                后台.班别 = 班别;
                后台.辅导员编号 = 辅导员编号;
                try
                {
                    int i = 后台.添加班级(后台);
                    if (i > 0)
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
        catch
        {
            Response.Write("{'state':'error'}"); 
        }
    }
    
    /*修改班级辅导员*/
    public void 修改班级辅导员()
    {
        string a = Request["辅导员编号"];
        int 辅导员编号 = a == "null" ? 0 : Convert.ToInt32(Request["辅导员编号"]);
        int 班级编号 = Convert.ToInt32(Request["班级编号"]);

        if (辅导员编号 == 0)
        {
            后台.classid = 班级编号;
            try
            {
                int i = 后台.删除班级辅导员(后台);
                if (i > 0)
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
            后台.classid = 班级编号;
            后台.辅导员编号 = 辅导员编号;
            try
            {
                int i = 后台.添加负责班级(后台);
                if (i > 0)
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
    
 
</script>