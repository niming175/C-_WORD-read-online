<%@ Page Title="" Language="C#" MasterPageFile="bg_manerge.master" AutoEventWireup="true" CodeFile="teacher_maneage.aspx.cs" Inherits="page_后台管理_teacher_maneage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/teacher_maneage.css" rel="stylesheet" type="text/css" />
    <link href="css/tasl_list.css" rel="stylesheet" type="text/css" />
    <script src="js/teacher_manegae.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="conter_div clearfix">

<div class="left pull_left">
<p><h1 class="title">教师管理</h1></p>
<hr />
<p class="hello_text">您好：<label class="teacher_name">张三</label>老师</p>
<br/>
<h2 class="myclass_title">我的班级:</h2>
<div class="my_class">
    <label class="class_label block">网络工程</label>
    <label class="class_label block">信息管理</label>
</div>

<div class="menu_liat_div clearfix">
    <div class="menu_list active">任务公告</div>
    <div class="menu_list">添加公告</div>
    <div class="menu_list">修改密码</div>
</div>
</div>
<div class="right pull_right">
    <!--公告列表-->
    <div class="task_list_div right_con_div clearfix hiden">
    <h1 class="title">任务公告</h1>
    <hr />


    <table style="width:100%;" class="task_list_div">
        <tr class="tr_search">
            <td colspan="2">
                <asp:TextBox ID="TextBox1" runat="server" class="search_box"></asp:TextBox>
                <asp:DropDownList ID="DropDownList1" runat="server" class="dr_select">
                    <asp:ListItem>网络工程</asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="Button1" runat="server" Text="搜索" class="search_but" />
            </td>
        </tr>
        <tr class="tr_search">
            <td colspan="2">
                <label class="task_sum">总共有22条任务公告</label>
                </td>
        </tr>
        <tr>
            <td style=" vertical-align:top">
                <table style="width:100%;" class="table2" cellspacing="1">
                    <tr class="tr_list">
                        <td class="td1">
                            编号</td>
                        <td class="td2">
                            标题</td>
                        <td class="td3">
                            时间</td>
                        <td class="td4">
                            派发对象</td>
                        <td class="td5">
                            提交数量</td>
                        <td class="td6">
                            操作</td>
                    </tr>
                    <tr class="tr1 odd ">
                        <td>
                            1</td>
                        <td>
                            周五作业</td>
                        <td >
                            2015-03-04</td>
                        <td>
                            信息管理</td>
                        <td>
                            45</td>
                        <td>
                            <input id="Button2" type="button" value="编辑" class="edit_but" /></td>
                    </tr>
                    <tr class="tr1 even">
                        <td>
                            2</td>
                        <td>
                            虚拟机实验</td>
                        <td>
                            2015-12-05</td>
                        <td>
                            网络工程1班</td>
                        <td>
                            46</td>
                        <td>
                            <input id="Button3" type="button" value="编辑" class="edit_but" /></td>
                    </tr>
                   <tr class="tr1 odd ">
                        <td>
                            3</td>
                        <td>
                            周五作业</td>
                        <td>
                            2015-03-04</td>
                        <td>
                            信息管理</td>
                        <td>
                            45</td>
                        <td>
                            <input id="Button4" type="button" value="编辑"  class="edit_but"  /></td>
                    </tr>
                    <tr class="tr1 even">
                        <td>
                            4</td>
                        <td>
                            虚拟机实验</td>
                        <td>
                            2015-12-05</td>
                        <td>
                            网络工程1班</td>
                        <td>
                            46</td>
                        <td>
                            <input id="Button5" type="button" value="编辑"  class="edit_but"  /></td>
                    </tr>
                </table>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>


    </div>
    <!--添加公告-->
    <div class="add_task_div right_con_div clearfix">
    <h1 class="title">添加公告</h1>
    <hr />

    <table  class="task_table">
                    <tr>
                        <td class="td_text">
                            标题：</td>
                        <td class="td_box">
                            <asp:TextBox ID="TextBox2" runat="server" class="title_box" MaxLength="25"></asp:TextBox>
                        </td>
                        <td class="td_remark"><label class="label_title remark hiden">标题不能为空</label></td>
                    </tr>
                    <tr>
                        <td class="td2">
                            内容：</td>
                        <td>
                            <asp:TextBox ID="TextBox3" runat="server" TextMode="MultiLine" class="text_box task_area"></asp:TextBox>
                        </td>
                        <td class="td_remark" style=" vertical-align:top"><label class="label_text remark  hiden">标题不能为空</label></td>
                    </tr>
                    <tr>
                        <td class="td3">
                            派发对象：</td>
                        <td>
                            
                            <select class="dr_select">
                            </select>
                            
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="td3">
                            &nbsp;</td>
                        <td style=" text-align:right">
                            <input type="button"  value="发布" class="task_submit submit" />
                        </td>
                    </tr>
                </table>


    </div>
    <!--修改密码-->
    <div class="changepsw_div right_con_div clearfix">
    </div>

</div>



</div>

</asp:Content>

