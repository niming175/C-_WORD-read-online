<%@ Page Title="" Language="C#" MasterPageFile="bg_manerge.master" AutoEventWireup="true" CodeFile="teacher_maneage.aspx.cs" Inherits="page_后台管理_teacher_maneage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/teacher_maneage.css" rel="stylesheet" type="text/css" />
    <link href="css/tasl_list.css" rel="stylesheet" type="text/css" />
    <script src="js/teacher_manegae.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<form >
<div class="conter_div clearfix">

<div class="left pull_left">
<p><h1 class="title">教师管理</h1></p>
<hr />
<p class="hello_text">您好：<label class="teacher_name">张三</label>老师</p>
<br/>
<h2 class="myclass_title">负责科目:</h2>
<div class="my_class">
    <label class="class_label block">网络工程</label>
    <label class="class_label block">信息管理</label>
</div>

<div class="menu_liat_div clearfix">
    <div class="menu_list active" divname="task_list_div">作业公告</div>
    <div class="menu_list" divname="add_task_div">添加作业</div>
    <div class="menu_list" divname="changepsw_div">修改密码</div>
</div>
</div>
<div class="right pull_right">
    <!--公告列表-->
    <div class="task_list_div right_con_div clearfix ">
    <h1 class="title">作业公告</h1>
    <hr />

    <table style="width:100%;" class="task_list_div">
        <tr class="tr_search">
            <td class="td_search" colspan="2">
                <input type="text" class="search_box">
                <select class="dr_select class_select">
                  
                </select>
                <input type="button" class="search_but" value="搜素" />
            </td>
        </tr>
        <tr class="tr_search">
            <td colspan="2">
                <label class="task_sum">总共有<label class="la_sum" style=" font-weight:bold">0</label>条任务公告</label>
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
                    <tbody class="task_list_tbody">
                    </tbody>
                   
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
    <!--公告详情-->
    <div class="task_details right_con_div hiden relative">
     <h1 class="title">作业详情</h1><h2 class="blcok task_back absolute">返回</h2>
    <hr />

        <table class="taskdetails_table">
            <tr class="tr1">
             <td class="td1">标题：</td><td class="td2" colspan="3"><label class="la_tasktitle">这是标题</label></td>
             
            </tr>
            <tr class="tr1">
            <td>班级：</td><td class="td2"> <label class="la_taskclass">信管</label></td>
            <td class="td1">时间：</td><td class="td2"><label class="la_tasktime">2016-5-02</label></td>
            </tr>
            <tr class="tr1">
                <td>科目：</td>
                <td><label class="project_label">科目</label></td>
                 <td>附件：</td><td><a href="#" class="afixdown">下载附件</a></td>
            </tr>
           
            <tr class="tr2">
            <td>要求：</td><td class="" colspan="3"><div class="td_taskreques"></div></td>
            </tr>
            
        </table>

        <table class="taskedtails_list">
            <tr class="tr_head">
                <td class="td1">编号</td>
                <td class="td2">标题</td>
                <td class="td3">姓名</td>
                <td class="td4">提交时间</td>
                <td class="td5">成绩</td>

            </tr>
            <tbody class="taskdetails_tbody">
                <tr class="tr1">
                    <td class="center">1</td>
                    <td class="td2">这是标题</td>
                    <td class="td3">李四</td>
                    <td class="center">2016-5-2</td>
                    <td class="center" >85</td>
                </tr>
                  <tr class="tr2">
                    <td class="center">1</td>
                    <td class="td2">这是标题</td>
                    <td class="td3">李四</td>
                    <td class="center">2016-5-2</td>
                    <td class="center" >85</td>
                </tr>
               
            
            </tbody>
        </table>

    </div>
    <!--添加公告-->
    <div class="add_task_div right_con_div clearfix hiden">
    <h1 class="title">添加作业</h1>
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
                            <select class="select_project"></select>
                            
                        </td>
                        <td></td>
                    </tr>
                    <tr class="">
                        <td class=""><input class="addafix_but" type="button" value="添加附件"/>
                        <input type="file" id="afix_file" class="hiden"/>
                        </td>
                        <td class=""><label class="afixfile_name">没有选择附件</label></td>
                        <td class=""><label class="remark_afixlabel">小于10M的附件</label></td>
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
    <div class="changepsw_div right_con_div clearfix hiden">
       <h1 class="title">修改密码</h1>
    <hr />
    <table class="changepsw_table">
    <tr class="tr">
        <td class="td1">原密码：</td>
        <td class="td2"><input class="oldpsw_textbox" type="password" maxlength="18"/></td>
        <td class="td3"><label class="error oldpsw_la hiden">原密码错误</label></td>
    </tr>
    <tr  class="tr">
        <td>新密码：</td>
        <td><input class="newpsw_textbox" type="password" maxlength="18"/></td>
        <td><label class="error newpsw_la hiden">新密码不能为空</label></td>
    </tr>
    <tr  class="tr">
        <td>确认密码：</td>
        <td><input class="conpsw_textbox" type="password" maxlength="18" /></td>
        <td><label class="error conpsw_la hiden">与新密码不一致</label></td>
    </tr>
    <tr class="tr1">
        <td></td>
        <td><input class="changepsw_but pull_right" type="button" value="确认"/></td>
        <td></td>
    </tr>
    </table>
    </div>

</div>



</div>
</form>
</asp:Content>

