<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        
        string type = Request["type"].ToString();

        #region 请求session是否在线
        if (type == "1")
        {
            if (Session["user_id"] != null && Session["user_id"] != "")
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
        #endregion
    }
</script>