using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class bg_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
            this.RadioButtonList1.SelectedIndex = 0;
        }
     
        

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       
        string name = TextBox1.Text;
        string psw = TextBox2.Text;
        string password = md5(psw, 32);
        业务逻辑层.BLL.后台管理 管理 = new 业务逻辑层.BLL.后台管理();
        

        if (RadioButtonList1.SelectedIndex == 0)
        {
            管理.name = name;
            管理.psw = psw;
            DataSet da = 管理.管理员登录(管理);
            if (da.Tables[0].Rows.Count > 0)
            {
                Response.Redirect("manerager.aspx", false);
            }
            else
            {
                Response.Write("<script>alert('账户或密码错误')</script>");
            }
           
        }
        else if(RadioButtonList1.SelectedIndex==1)
        {
           
            管理.name = name;
            管理.psw = password;
            DataSet da = 管理.登录(管理);
            if (da.Tables[0].Rows.Count > 0)
            {
                Session["teacher_id"] = da.Tables[0].Rows[0]["教师编号"].ToString();
                Response.Redirect("teacher_maneage.aspx", false);
            }
            else 
            {
                Response.Write("<script>alert('账户或密码错误')</script>");
            }
        }
        else if(RadioButtonList1.SelectedIndex==2)
        {

            管理.手机号 = name;
            管理.psw = password;
            try
            {
                DataSet da = 管理.辅导员登录(管理);
                if (da.Tables[0].Rows.Count > 0)
                {
                    Session["辅导员编号"] = da.Tables[0].Rows[0]["辅导员编号"].ToString();
                    Response.Redirect("instructor.aspx", false);

                }
                else
                {
                    Response.Write("<script>alert('账户或密码错误')</script>");
                }


            }
            catch { Response.Write("<script>alert('出现错误，请稍后再试')</script>"); }
            
            
        }
        
        

    }
    public string md5(string str, int code)  //code 16 或 32  
    {
        if (code == 16) //16位MD5加密（取32位加密的9~25字符）  
        {
            return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(str, "MD5").ToLower().Substring(8, 16);
        }

        if (code == 32) //32位加密  
        {
            return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(str, "MD5").ToLower();
        }

        return "00000000000000000000000000000000";
    }
}