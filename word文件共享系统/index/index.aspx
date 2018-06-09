<%@ Page Title="" Language="C#" MasterPageFile="~/母板页/页眉登录.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="stylesheet" type="text/css" href="../css/style.css">
    <script src="../js/jquery.luara.0.0.1.min.js" type="text/javascript"></script>

    <script src="../js/commandjs/fileload.js" type="text/javascript"></script>
    <script src="../js/index.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <div class="banner relative">
   <div class="point absolute">
  
     <div class="content clearfix relative">
      <div class="banner_text absolute"></div>  
    </div>
    </div>
     <div class="example1 clearfix">
        <ul>
            <li class="li1"><img class="img1" alt=""/></li>
            <li class="li1"><img class="img2" alt=""/></li>
            <li class="li1"><img class="img3" alt=""/></li>
            <li class="li1"><img class="img4" alt=""/></li>
        </ul>
        <ol>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ol>
	

       </div>
   </div>

   <!--内容部分-->
   <div class="content_div">
    <div class="left pull_left">
      <!--分类-->
      <div class="classify">
        <div class="head">
          <div class="bg">分类</div>
         
        </div>
        <table class="type_table">
          <tr class="tr">
            <td class="td">
              <div class="ba_icon relative">
                <img src="../images/icon/classify_1.png" height='80px' width="110px">
                <div class="type_text absolute">IT/计算机</div>
              </div>
            </td>
            <td class="td">
              <div class="ba_icon relative">
                <img src="../images/icon/classify_2.png" height='80px' width="110px">
                <div class="type_text absolute">IT/计算机</div>
              </div>
            </td>
          </tr>
          <tr class="tr">
            <td class="td">
              <div class="ba_icon relative">
                <img src="../images/icon/classify.png" height='80px' width="110px">
                <div class="type_text absolute">IT/计算机</div>
              </div>
            </td>
            <td class="td">
              <div class="ba_icon relative">
                <img src="../images/icon/classify_1.png" height='80px' width="110px">
                <div class="type_text absolute">IT/计算机</div>
              </div>
            </td>
          </tr>
          <tr class="tr">
            <td class="td">
              <div class="ba_icon relative">
                <img src="../images/icon/classify.png" height='80px' width="110px">
                <div class="type_text absolute">IT/计算机</div>
              </div>
            </td>
            <td class="td">
              <div class="ba_icon relative">
                <img src="../images/icon/classify_2.png" height='80px' width="110px">
                <div class="type_text absolute">IT/计算机</div>
              </div>
            </td>
          </tr>
        </table>
      </div>
      <!--相关连接-->
      <div class="about_link ">
        <div class="head relative">
          最新任务
          <div class=" absolute shadow"></div>
        </div>
       <ul class="task_ul">
        <li class="task_list">[班级]&nbsp&nbsp测试</li>
         <li class="task_list">[班级]&nbsp&nbsp测试</li>
          <li class="task_list">[班级]&nbsp&nbsp测试</li>
           <li class="task_list">[班级]&nbsp&nbsp测试</li>
       </ul>
      </div>



    </div>

    <!--相关阅读-->
    <div class="center pull_left">
      <div class="head">推荐阅读</div>
      <div class="rad_contnet_div clearfix">
                                  <div class="read_content">
        <div class="read_head">
          <div class="title pull_left">.关于ipv4和ipv6的差异实验报告</div>
          <div class="time pull_right"><label class="la_type">IT/计算机</label><label class="lb_time">更新：2016-04-05</label> </div>
        </div>
        <div class="text">&nbsp&nbsp&nbsp&nbspIPv6是Internet Protocol Version 6的缩写，其中Internet Protocol译为“互联网协议”。IPv6是IETF（互联网工程任务组，Internet Engineering Task Force）...</div>
      </div>
      </div>
    </div>

    <!--时事-->
    <div class="right pull_right">
      <div class="top clearfix">
        <div class="head">
          <div class="bg">热门</div>
          <div class="news_box">
            <ul class="host_file_ur">
              <li>惊天猜想：月球竟是宇宙飞船？</li>
              <li>外媒:科学家计划从"红矮星"系中寻...</li>
              <li>站在月球上撒尿的第一个人：美国... </li>
              <li>外媒:科学家计划从"红矮星"系...</li>
              <li>站在月球上撒尿的第一个人：美国... </li>
              <li>惊天猜想：月球竟是宇宙飞船？</li>
              <li>外媒:科学家计划从"红矮星"系中...</li>
              <li>世界十大考古之谜：五万年前就有...</li>
              <li>7个秘诀让你快速提高深蹲水平</li>
           </ul>
          </div>
        </div>
      </div>
      <div class="bottom clearfix">
        <div class="text">已收录实验报告</div>
        <div class="sum"><label class="sum sum_la">2,016</label><div class="text2 inblock">篇</div></div>
        <div class="uploa_but"></div>
      </div>
    </div>
   </div>
</asp:Content>

