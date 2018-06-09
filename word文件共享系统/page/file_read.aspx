<%@ Page Title="" Language="C#" MasterPageFile="~/母板页/页眉登录.master" AutoEventWireup="true" CodeFile="file_read.aspx.cs" Inherits="page_file_read" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="stylesheet" type="text/css" href="../css/file_read.css">
<script type="text/javascript" src="../js/file_read.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="filerad_content clearfix">
  <!--内容部分-->

   <div class="content_div pull_left">
    <div class="file_infor_div">
      <div class="read_head_div">
        <div class="word_icon pull_left"></div>
        <div class="title pull_left">大学计算机基础人民邮电出版社第二版</div>
      </div>
      <div class="deli_div">
        <div class="inblock upload_er">张三</div>&nbsp上传于
        <div class="time inblock">2016-04-03</div>&nbsp&nbsp|&nbsp&nbsp
        <div class="red_num inblock">21</div>&nbsp人阅读&nbsp&nbsp|&nbsp&nbsp
        <div class="download_num inblock">6</div>&nbsp人下载
      </div>
    </div>
    <!--文件内容，后期用js加载-->
    <div class="file_content clearfix">
    <br/><center style="margin:100px"><img src="../images/gif/loding.gif" /></center>
    </div>

    <!--用户评论-->
    <div class="discuss_div">
      <div class="title">
       您的评论
      </div>
      <div class="discuss_textbox relative">
        <textarea class="textbox blur " maxlength="100">输入您的评论</textarea>
        <label class="label absolute">100</label>
        
      </div>
      <div class="discuss_but ">
        <input type="button" class="button pull_right block" value="提交评论">
      </div>

    </div>
    
    <!--用户评论列表-->
    <div class="discuss_list clearfix">
      <div class="title">
        用户评论<div class="inblock discuss_count">(0)</div>
      </div>

      <div class="discuss_list_div clearfix"></div>
      

    
    </div>


   </div>

   <!--右边内容框-->
   <div class="right_content pull_right">
    <div class="download_aboudread">
      <div class="download">下载</div>
      <div class="about_read_title">相关阅读</div>
      <div class="aboudread_list_div">

        <ul>
          <li class="aboutread_list">2016年这个是神难过的我呢件哈...</li>
          <li class="aboutread_list">2016年这个是神sdfgsfdsdf...</li>
          <li class="aboutread_list">2016年斯蒂芬森神难过的斯蒂芬...</li>
           <li class="aboutread_list">2016年这个是神难过的我呢件...</li>
          <li class="aboutread_list">2016年这个是神sdfgsfdsdf ...</li>
          <li class="aboutread_list">2016年斯蒂芬森神难过的斯蒂...</li>
           <li class="aboutread_list">2016年这个是神难过的我呢件...</li>
          <li class="aboutread_list">2016年这个是神sdfgsfdsdf...</li>
         
        </ul>
      </div>
    </div>
   
    <!--热门下载-->
    <div class="hot_down clearfix">
      <div class="hot_download_title">热门下载</div>
      <div class="hotdown_list_div">
        <ul>
         <li class="hotdownload_list">这个好似人们的下现在哈</li>
         <li class="hotdownload_list">这个好似人们的电风扇电风扇斯蒂芬</li>
         <li class="hotdownload_list">阿斯达地方的下现在哈</li>
         <li class="hotdownload_list">这个好似阿萨德下现在哈</li>
         <li class="hotdownload_list">这个好似人们的下现在哈</li>
         <li class="hotdownload_list">这个好似人们的下现在哈</li>
          <li class="hotdownload_list">阿斯达地方的下现在哈</li>
         <li class="hotdownload_list">这个好似阿萨德下现在哈</li>
         <li class="hotdownload_list">这个好似人们的下现在哈</li>
         <li class="hotdownload_list">这个好似人们的下现在哈</li>
        </ul>
      </div></div>


   </div>
   </div>
</asp:Content>

