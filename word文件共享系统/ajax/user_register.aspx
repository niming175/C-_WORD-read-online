<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        业务逻辑层.BLL.数据获取 获取 = new 业务逻辑层.BLL.数据获取();
        业务逻辑层.BLL.会员管理 会员 = new 业务逻辑层.BLL.会员管理();
        string type = Request["type"].ToString();
        if (type == "1")
        {
            string str = "";
            DataSet 系别列表 = 获取.获取数据("select * from 系别", "系别");
            if (系别列表.Tables[0].Rows.Count > 0)
            {
                str += "{'static':'success','data':[";

            }

            foreach (DataRow rs in 系别列表.Tables[0].Rows)
            {

                str += "{'系别':'" + rs["系别名称"] + "','系别编号':'" + rs["系别编号"] + "'},";
            }
            str += "]}";
            //string str="[{'static':'sucess'},{'static':'sucess'}]";
            Response.Write(str);


        }
        if (type == "2")
        {
            string str = "";
            int 系别编号 = Convert.ToInt32(Request["系别编号"]);
            string strsql = "select 班级名称,班级编号 from 班级 where 系别编号=" + 系别编号 + "";
            DataSet 班级列表 = 获取.获取数据(strsql, "班级");
            if (班级列表.Tables[0].Rows.Count > 0)
            {
                str += "{'static':'success','data':[";
                foreach (DataRow dr in 班级列表.Tables[0].Rows)
                {
                    str += "{'班级名称':'" + dr["班级名称"] + "','班级编号':'" + dr["班级编号"] + "'},";
                }
                str += "]}";
                Response.Write(str);
            }
            else
            {
                str += "{'static':'success'}";
                Response.Write(str);
            }
        }

        if (type == "3")
        {
            string username = Request["user_name"].ToString();
            string real_name = Request["real_name"].ToString();
            string phone = Request["phone"].ToString();
            string psw = Request["hash_psw"].ToString();
            int grede = Convert.ToInt32(Request["grade"]);

            会员.昵称 = username;
            会员.姓名 = real_name;
            会员.手机号 = phone;
            会员.密码 = psw;
            会员.班级编号 = grede;
            int result;
            result = 会员.注册会员(会员);
            if (result == 1)
            {
                string str = "{'static':'success'}";
                Response.Write(str);
            }
            else
            {
                string str = "{'static':'error'}";
                Response.Write(str);

            }


        }
        if (type == "4")
        {
            string 手机号 = Request["phone"].ToString();
            string str="select 手机号 from 用户 where 手机号='"+手机号+"'";
            DataSet 手机列表 = 会员.获取数据(str,"用户");
            int i=0;
            if (手机列表.Tables[0].Rows.Count > 0)
            {
                i = 1;
            }
            else
            {
                i = 0; 
            }
            Response.Write("{'static':'success','i':'" + i + "'}");
        }
    }
</script>