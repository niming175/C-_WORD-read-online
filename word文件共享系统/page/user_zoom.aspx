<%@ Page Title="" Language="C#" MasterPageFile="~/母板页/页眉登录.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="stylesheet" type="text/css" href="../css/user_zoom.css">
<script type="text/javascript" src="../js/user_zoom.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<form  method="POST" id="img_upload" class="form-inline" role="form">

<div class="content_div clearfix">
  <div class="con_left pull_left">
    <div class="head_img">
      <img src="" height="150px" width="150px;" class="image">
    </div>
    <div class="user_name clearfix">
    <h3 class="user_name_h3"></h3>
    <div class="class_name">班级：&nbsp&nbsp 网络工程</div>
    </div>
    <div class="upload_num">我共分享了<label class="number">0</label>篇报告</div>
    <div class="user_button">
      <input type="button" value="修改信息" class="change_but button">
      <input type="button" value="退出" class="logiout_but button">
    </div>

    <div class="list_menu">
      <div class="my_task list active" value="con_mytask">作业任务</div>
      <div class="my_file list" value="con_myfile">我的共享</div>
      <div class="change_psw list" value="con_change_psw">修改密码</div>
    </div>
  </div>


  <div class="con_right pull_left">
    <!--我的任务-->
    <div class="con_mytask right_page">
      <h1>作业任务</h1>
      <hr>

      <div class="new_task task_div">
        <div class="new_text ">最新作业</div>
        <div class="new_task_table hiden">
          
          <p class="new_p">共有<label class="label_newtask">0</label>篇报告任务未提交</p>
          <table class="table1">
            <tr class="tr_title">
              <td class="td1"></td>
              <td class="td2">标题</td>
              <td class="td6">科目</td>
              <td class="td3">课任老师</td>
              <td class="td4">时间</td>
              <td class="td5">状态</td>
              <td class="td7">附件</td>
             
            </tr>
            <tbody class="new_task_list"></tbody>
         

          </table>
        </div>
      </div>

      <div class="finish_task task_div">
        <div class="new_text">已完成作业</div>
        <div class="new_task_table hiden">
         
          <p class="new_p">已提交<label class="label_finishtask" style=" font-weight:bold; letter-spacing:3px">0</label>篇作业报告</p>
          <table class="table2">
            <tr class="tr_title">
              <td class="td1">编号</td>
              <td class="td2">任务</td>
              <td class="td3">科目</td>
              <td class="td4">负责老师</td>
              <td class="td5">完成时间</td>
              <td class="td6">成绩</td>
            </tr>
            <tbody class="finished_task_tbody"></tbody>
           

          </table>
        </div>
      </div>
    </div>

    <div class="con_myfile right_page hiden">
      <h1>我的上传的文档</h1>
      <hr>
      <table class="file_table "cellpadding="0" cellspacing="1" >
        <tbody class="tb_head" >
          <tr class="tr_head">
            <td class="file_id">编号</td>
            <td class="file_title">标题</td>
            <td class="file_time">上传时间</td>
            <td class="file_static">状态</td>
            <td class="file_option">操作</td>
          </tr>
        </tbody>
        <tbody class="tb_file_list">
          <tr class="tr_list">
            <td class="file_id">001</td>
            <td class="file_title">这个是报告的标题</td>
            <td class="file_time">2016-04-1</td>
            <td class="file_static">公开</td>
            <td class="file_option">
              <input type="button" class="file_edit button" value="编辑">
              <input type="button" class="fiel_del button" value="删除">
            </td>
          </tr>

          <tr class="tr_list even">
            <td class="file_id">001</td>
            <td class="file_title">这个是报告的标题</td>
            <td class="file_time">2016-04-1</td>
             <td class="file_static">公开</td>
            <td class="file_option">
              <input type="button" class="file_edit button" value="编辑">
              <input type="button" class="fiel_del button" value="删除">
            </td>
          </tr>

        </tbody>
      </table>
      <div class="file_more">加载更多...</div>
      </div>
    
    <!--修改密码-->
    <div class="con_change_psw right_page hiden">
      <h1>修改密码</h1>
      <hr>
      <table class="chan_table">

        <tr class="old">
          <td class="td1">原密码：</td>
          <td class="td2"><input type="password" class="psw_box old_psw"></td>
          <td class="remian "><label class="oldpsw_la hiden">请输入原密码</label></td>
        </tr>
        <tr class="new">
          <td>新密码：</td>
          <td><input type="password" class="psw_box new_psw"></td>
          <td class="remian"><label class="newpsw_la hiden"></label> </td>
        </tr>
        <tr class="confirm">
          <td>确认密码：</td>
          <td><input type="password" class="psw_box conf_psw"></td>
          <td class="remin"><label class="confpsw_la hiden"></label></td>
        </tr>
        <tr class="but">
          <td></td>
          <td><input class="button" type="button" value="保存"></td>
          <td class="remin"></td>
        </tr>
      </table>
    </div>


</div>   
</div>

<div class="change_bg fixed hiden">
  <div class="center_point relative absolute">
    <div class="change_info_div absolute ">
      <div class="change_head relative">
        <h1>信息修改</h1>
        <div class="change_close absolute">X</div>
      </div>

      <div class="clearfix" width="100%" height="auto">
      <div class="user_img_div pull_left">
        <img src="../images/userhead/img_head.jpg" class="img_head" height="150px" width="150px">
      </div>
      <div class="change_img_but_div pull_left">
        <input type="button" class="button" value="修改头像" onclick="$(this).next('.file').click()">
        
        
        <input type="file" class="file" id="user_image">
       
      </div>
   </div>
      <div class="table_div clearfix">
        <table class="table">
          <tr class="tr tr_name">
            <td class="tr_text">昵称：</td>
            <td class="tr_textbox"><input class="input" type="text"></td>
            <td class="tr_remain"><label class="label_usernamebox hiden"></label></tr>
          </tr>
          <tr class="tr tr_email">
            <td class="tr_text">邮箱：</td>
            <td class="tr_textbox"><input class="input" type="text"></td>
            <td class="tr_remain"><label class="label_email hiden"></label></tr>
          </tr>
        </table>
      </div>
      <div class="save_button_div">
        <input class="button pull_right" type="button"value="保存">

</div> 

    <div class="change_loding_bg absolute relative hiden">
    <div class="image_div absolute">
        <img src="../images/gif/uploading.gif" />
        <label class="label block">更新中....</label>
    </div>
    </div>
    </div>

  </div>
</div>



<!--点击提交任务文档弹框-->
<div class="submit_task_div_bg fixed  absolute hiden">
    <div class="task_point relative">
        <div class="submit_div relative">
         <div class="submit_head relative">
           <div class="text"><h1>任务详情</h1></div>
           <div class="submit_close absolute">X</div>
         </div>
         <div class="task_title">任务标题：<label class="task_title_label">任务标题</label></div>
         <div class="task_request clearfix">
            <label class="block pull_left">要求：</label>
            <div class="request pull_left">这个是要求</div>
         </div>
         <div class="task_time">时间：<label class="time_la">2016-05-02</label></div>
         <div class="daown_afix hiden">附件：<a class="downafix_a">下载附件</a></div>

         <div class="newtasksubmit_now_div"> <input class="newtasksubmit_but" type="button" value="马上提交"/></div>
         
         <table class="submit_table hiden">
         <tr class="tr_title">
         <td class="td_text">标题</td>
         <td class="td_box"><input type="text" class="title_box input_box" maxlength="25" /></td>
         <td class="td_remark"><label class="title_la error label hiden">请输入标题</label></td>
         </tr>
         <tr class="tr_file">
            <td><input class="select_but" type="button" value="选择文件..."/><input  type="file" id="taskfile" class="hiden" /></td>
            <td><input class="file_box input_box"  readonly="true"/></td>
            <td><label class="file_la error label hiden">你您未选择文件</label></td>
         </tr>
         <tr class="tr_button">
           
            <td style="text-align:right" colspan="3">
                <input type="button"  class="submit_button" value="提交"/>
                <input type="button" class="cancesubmit_button" value="取消" />
                </td>
           
         </tr>
         </table>
        
    
    <!--点击提交弹出瞪大背景-->
     <div class="submit_loding_bg absolute relative hiden">
        <div class="point absolute">
            <div class="loding_div">
                <img src="../images/gif/uploading.gif" />
                <label class="loding_text">正在提交....</label>
            </div>
        </div>
     </div>
    
    </div>


</div>
</div>

 </form>
</asp:Content>

