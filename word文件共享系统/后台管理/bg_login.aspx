<%@ Page Title="" Language="C#" MasterPageFile="bg_manerge.master" AutoEventWireup="true" CodeFile="bg_login.aspx.cs" Inherits="bg_login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <link rel="stylesheet" type="text/css" href="css/bg_index.css">
    <script src="js/bg_index.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="con">
    <table  class="table1 pull_right">
        <tr>
            <td colspan="3" class="title">
                登录</td>
        </tr>
        <tr>
            <td class="text">
                账户：</td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server" class="textbox" MaxLength="11"></asp:TextBox>
            </td>
            <td class="remark hiden">
                账户不能为空</td>
        </tr>
        <tr>
            <td class="text">
                密码：</td>
            <td>
                <asp:TextBox ID="TextBox2" runat="server" class="textbox" TextMode="Password"></asp:TextBox>
            </td>
            <td class="remark hiden">
                请输入密码</td>
        </tr>
        <tr>
            <td class="text">
                身份：</td>
            <td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
                    RepeatDirection="Horizontal" class="radio" Width="169px">
                    <asp:ListItem>管理员</asp:ListItem>
                    <asp:ListItem>教师</asp:ListItem>
                    <asp:ListItem>辅导员</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="3" class="error_text hiden">
                账户不存在或密码错误</td>
        </tr>
        <tr>
            <td colspan="3" class="td_but">
                <asp:Button ID="Button1" runat="server" Text="登录" class="log_but" 
                    onclick="Button1_Click"/>
            </td>
        </tr>
    </table>
    </div>
</asp:Content>

