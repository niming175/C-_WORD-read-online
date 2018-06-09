<%@ Page Title="" Language="C#" MasterPageFile="~/后台管理/bg_manerge.master" AutoEventWireup="true" CodeFile="bg_read.aspx.cs" Inherits="page_后台管理_bg_read" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<link rel="stylesheet" type="text/css" href="css/bg_read.css">
    <script src="js/bg_read.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="left pull_left">
	 
     <div class="con_head taskfile_title">
     	实验报告1
     </div>
     <p class="p_task">任务：<label class="task">周五实验报告</label></p>
     <div class="info">
     	作者：<label class="auther">张三</label>&nbsp&nbsp|&nbsp&nbsp
     	班级：<label class="banji">信息管理</label>&nbsp&nbsp|&nbsp&nbsp
     	时间：<label class="titme">2016-04-18</label>
     </div>

     <!--文件内容，用ajax加载-->
     <div class="file_con clearfix">
     </div>

	</div>

<div class="right pull_right">
		<div class="right_head">教师点评</div>
		<div class="score_div">
			<label>成绩：</label>
			<input class="score_box" type="text" maxlength="2">
		</div>
		<div class="discuss_div" style=" vertical-align:top">
			<label class="block pull_left">评语：</label>
			<textarea class="discuss_box" maxlength="240"></textarea>
		</div>
		<div class="submit_div">
			<input class="submit" type="button" value="保存" >
		</div>
        </div>
</asp:Content>

