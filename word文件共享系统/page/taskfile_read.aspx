<%@ Page Title="" Language="C#" MasterPageFile="~/母板页/页眉登录.master" %>

<script runat="server">


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="../css/taskfile_read.css" rel="stylesheet" type="text/css" />
    <script src="../js/taskfile_read.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="file_content clearfix">


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
			<label class="score_box"></label>
		</div>
		<div class="discuss_div" style=" vertical-align:top">
			<label class="block pull_left">评语：</label>
			<div class="discuss_box pull_left"></div>
		</div>
		
        </div>
</div>
</asp:Content>

