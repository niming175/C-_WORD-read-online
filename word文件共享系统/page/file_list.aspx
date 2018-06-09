<%@ Page Title="" Language="C#" MasterPageFile="~/母板页/页眉登录.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../css/file_list.css" rel="stylesheet" type="text/css" />
    <script src="../js/file_list.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="contend_div  clearfix">
    <div class="menu_list_div pull_left">
     <div class="list active">IT/计算机</div>
     <div class="list">数理化生</div>
     <div class="list">文学著作</div>
     <div class="list">土木工程</div>
     <div class="list">金融会计</div>
     <div class="list">其他报告</div>
    </div>

    <div class="file_list pull_left">
      <div class="head">
        <div class="sort pull_left">排序：</div> <!--sort v.排序-->
        <div class="sort_list pull_left active">热度</div>
        <div class="sort_list pull_left">最新</div>
        <div class="sort_list pull_left">下载量</div>
      </div>
<div class="filelist_div clearfix">


 </div>

      <!--分页-->
      <div class="page_div">
       <div fun="first" class="page page_first first">首页</div>
       <div fun="up" class="page page_next up">上一页</div>


        <div class="page_list_div">
         <div class="page_list ">1</div>
         <div class="page_list active">2</div>
        
        </div>
      
       
       <div fun="next" class="page page_next next">下一页</div>
       <div fun="last" class="page page_next last">尾页</div>
       <div class="page_sumtext count">总共</div>
       <div class="page_sum">99</div>
       <div class="page_sumtext">页</div>
      </div>



    </div>
</div>
</asp:Content>

