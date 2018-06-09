<%@ Page Title="" Language="C#" MasterPageFile="~/母板页/页眉登录.master" AutoEventWireup="true" CodeFile="user_upload.aspx.cs" Inherits="page_user_upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="stylesheet" type="text/css" href="../css/user_upload.css">
    <script src="../js/user_upload.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="content_div">
 <div class="content clearfix">
  <div class="con_text">上传我的文档</div>
  <div class="con_left pull_left">
    <table class="upload_table">
      <tr class="tr">
        <td class="upload_text">文档名称：</td>
        <td class="upload_textbox">
          <input class="file_name_box input" type="text" maxlength="25">
        </td>
        <td class="upload_remark file_name"><label class="remark file_name">请输入文档标题</label></td>
      </tr>
      <tr class="tr">
        <td class="upload_text">标&nbsp&nbsp&nbsp&nbsp签：</td>
        <td>
          <input class="file_lable_box input" type="text" maxlength="6">
        </td>
        <td class="upload_remark"><label class="remark file_lable">请输入2-6个字的标签</label></td>
      </tr>

      <tr class="tr">
        <td class="upload_text">分&nbsp&nbsp&nbsp&nbsp类：</td>
        <td>
          <select class="fiel_type">
            <option>IT/计算机</option>
           
          </select>
        </td>
        <td class=""></td>
      </tr>

      <tr class="tr_area">
        <td class="upload_text">概&nbsp&nbsp&nbsp&nbsp述：</td>
        <td>
          <textarea class="file_area" maxlength="70"></textarea>
        </td>
        <td class="upload_remark relative">
        <label class="file_area_label remark ">请输入概述</label>
        <div class="file_area_num absolute">剩余70个字</div>
        </td>
      </tr>
  
      <tr class="tr">
        <td class="upload_text">文&nbsp&nbsp&nbsp&nbsp件：</td>
        <td>

          <input type='text' name='textfield' id='textfield' class='file_txt input' readonly="true"/>  
         
        </td>
        <td class="upload_remark">
          <input type='button' class='select_botton input' value="选择文件..." />
        </td>
      </tr>
      
    </table>
<form action="" method="POST" id="fileupload" class="form-inline" role="form">
    				<input id="file" type="file" name="file" class="select_file" onchange="document.getElementById('textfield').value=this.value" value="" />
</form>
  
 <div class="button_box">
   
      <input type="button" class="upload_button pull_right" value="确认上传">
       
    </div>

  </div>


  <div class="con_right pull_right">

    <div class="upload-notice">
      <h4>温馨提示</h4>
      <ol>
      <li>1.您可以上传日常积累和撰写的文档资料，如模板、总结，每份≤20MB，支持*doc文件：</li>
      <li>2.上传涉及侵权内容的文档将会被移除。如何判断文档是否侵权？查看<a href="http://wenku.baidu.com/portal/browse/help#help/20" target="_blank">文库协议</a>和<a href="http://wenku.baidu.com/portal/browse/help#help/1" target="_blank">用户规则</a></li>
      <li>3.上传有问题需要帮助？查看<a href="http://wenku.baidu.com/portal/browse/help#help/2" target="_blank">文库帮助</a>和<a href="/feedback" target="_blank">意见反馈</a></li>
      <li>4.为营造绿色网络环境，严禁上传含有淫秽色情及低俗信息等文档，让我们一起携手共同打造健康文库</li>
      </ol>
      </div>


  </div>



 </div>


</div>


<div class="upload_bd relative fixed hiden">
    <div class="point absolute">
        <div class="uploding_div">
           
               <img class="loding_gif  block" src="../images/gif/uploading.gif" />
            
            <label class="loding_la">上传中...</label>
       </div>
    </div>
</div>

</asp:Content>

