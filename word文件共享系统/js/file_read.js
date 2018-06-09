
var file_id=null;
$(document).ready(function() {

    file_id=request("file_id");
    load(file_id);
    load_diss(file_id)
    $(".discuss_div .textbox").on("focus",discuss_div_focus)
    $(".discuss_div .textbox").on("blur",discuss_div_blur)
    $(".discuss_div .textbox").on("keyup",discuss_div_key)
    $(".discuss_but .button").on("click",discuss_submit)
    aboutread_load(file_id)
    hotdown_load()
})

function discuss_div_focus()
{
    if($(this).val()=="输入您的评论")
    {
        $(this).val("").removeClass("blur");
    }
}
function discuss_div_blur(){
    if($(this).val()=="")
    {
         $(this).val("输入您的评论").addClass("blur");
    }

}

//评论字数计数
function discuss_div_key()
{
    var a=100;
    var b=$(this).val().length;
    $(".discuss_textbox .label").html(a-b);
}
function request(paras)
{
     var url = location.href;
     var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
     var paraObj = {};
    　　 for (i=0; j=paraString[i]; i++){
    　　   paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length);
    　　  }
        　　var returnValue = paraObj[paras.toLowerCase()];
            if(typeof(returnValue)=="undefined")
            {
            　 return "";
            }
            else {
        　　return returnValue;
        　　}
}


//加载
function load(file_id)
{
    
  $.ajax({
    type:'post',
    url:'../ajax/file_read.aspx',
    data:{
        'type':'1',
        '文档编号':file_id
    },
    datatype:'json',
    success:function(data){
        var json=eval("("+data+")");
        if(json.static=="success")
        {
            var da=json.data[0];
           $(".read_head_div .title").html(""+da.标题+"");
           $(".deli_div .upload_er").html(""+da.昵称+"");
           $(".deli_div .time").html(""+da.上传时间+"");
           $(".deli_div .red_num").html(""+da.阅读量+"");
           $(".deli_div .download_num").html(""+da.下载量+"");
           document.title=da.标题;
           $(".file_content").html("");

var html="<iframe src='"+da.网页位置+"' id='iframepage' name='iframepage' frameBorder=0 scrolling=no width='100%' onLoad='iFrameHeight()' ></iframe>" 
$(".file_content").html(html)



          /* $(".file_content").load(da.网页位置,function(){
               $(".file_content img").each(function(){
                var a=$(this).attr("src");
                $(this).attr("src",da.网页位置.substr(0, 24)+a);
                });
                $(".file_content link").each(function(){
                var a=$(this).attr("href");
                $(this).attr("href",da.网页位置.substr(0, 24)+a)
               })
            });*/
          


           $(".download_aboudread .download").click(function(){
               window.location.href=da.文件位置;
               douwnnum_add(file_id);

            })


          
        }
        else
        {

        }
    },
    error:function(){
        alert("未知错误")
    }
  })
}


function iFrameHeight() { 
var ifm= document.getElementById("iframepage"); 
var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument; 
if(ifm != null && subWeb != null) { 
ifm.height = subWeb.body.scrollHeight; 
$("#iframepage meta:first").attr("content","text/html; charset=GB2312")
} 
}

//加载评论列表
function load_diss(file_id)
{
    $.ajax({
        type:'post',
        url:'../ajax/file_read.aspx',
        data:{
            'type':'3',
            '报告编号':file_id
        },
        datatype:'json',
        success:function(data){
            var json=eval("("+data+")");
            if(json.static=="success")
            {
                $(".discuss_count").html("("+json.num+")");
                $(".discuss_list_div").html("");
                var html="";

                $(json.data).each(function(){
                    
                    html+="<div class='list_div'>";
                    html+="<div class='list'>";
                    html+="<div class='headicon pull_left'>";
                    html+="<img src='"+this.头像位置+"' height='50px' width='50px'>";
                    html+="</div>";
                    html+="<div class='discuss_content pull_left'>";
                    html+="<div class='discuss_er'>"+this.昵称+"<div class='time pull_right inblock'>"+this.评论时间+"</div>"      
                    html+="</div>";
                    html+="<div class='discuss_text'>"+decodeURI(this.内容)+"</div>"
                    html+="</div>";
                    html+="</div>";
                    html+="</div>";
                })

                $(".discuss_list_div").html(html);
                
            }
            if(json.static=="none")
            {
                $(".discuss_list_div").html("暂无评论");
            }
        },
        error:function(){
            alert("未知错误");
        }
    })
}

/*点击提交，先查看是否在线，不在线，弹出登录框，在线提交评论*/
function discuss_submit(){
    $.ajax({
        type:'post',
        url:'../ajax/确认是否登录.aspx',
        data:{
            'type':'1'
        },
        success:function(data){
            var json=eval("("+data+")");
            if(json.static=="success")
            {
                var dis_text=$(".discuss_div .textbox").val();
                if(dis_text=="输入您的评论" ||  $.trim(dis_text)=="")
                {
                    alert("输入您的评论")
                }
                else
                {
                     $.ajax({
                    type:'post',
                    url:'../ajax/file_read.aspx',
                    data:{
                        'type':'2',
                        '文档编号':file_id,
                        '评论内容':dis_text

                    },
                    datatype:'json',
                    success:function(data){
                        var json =eval("("+data+")");
                        if(json.static=="success")
                        {
                            alert("评论成功");
                            load_diss(file_id)
                        }
                        if(json.static=="error")
                        {
                            alert(json.message);
                        }

                    },
                    error:function(){
                        alert("未知错误")
                    }
                })
                }
               

            }
            if(json.static=="error")
            {
              $(".lohin_but").click();
            }

        },
        error:function(){
            alert("未知错误");
        }
    })
}

//下载量加一
function douwnnum_add(file_id)
{
    $.ajax({
        type:'post',
        url:'../ajax/file_read.aspx',
        data:{
           'type':'4',
           'file_id':file_id
        },
        datatype:'json',
        success:function(data){
            var json=eval("("+data+")");
            if(json.static=="success")
            {
                var a=$(".deli_div .download_num").html();
                if(a=="")
                {
                     $(".deli_div .download_num").html("1");
                }
                else
                {
                     a=(parseInt(a)+1);
                $(".deli_div .download_num").html(a);
                }
               
            }
        }
    })

}


//加载相关阅读
function aboutread_load(){
    $.ajax({
        type:'post',
        url:'../ajax/file_read.aspx',
        data:{
            'type':'5',
            '文档编号':file_id,
        },
        datatype:'json',
        success:function(data){
            var json=eval("("+data+")");
            if(json.static=="success")
            {
                var html="<ul>";
                $(json.data).each(function(){
                    html+="<li class='aboutread_list' file_id='"+this.文档编号+"'>"+decodeURI(this.标题)+"</li>"
                })
                html+="</ul>";
                $(".aboudread_list_div").html(html);
                 $(".aboudread_list_div .aboutread_list").click(function(){
                    window.open("../page/file_read.aspx?file_id="+$(this).attr("file_id"))
                 })
            }
            else
            {
                $(".aboudread_list_div").html("暂无相关信息")
            }
        },
        error:function(){
             $(".aboudread_list_div").html("暂无相关信息")
        }
    })
}

//加载热门下载
function hotdown_load()
{
     $.ajax({
        type:'post',
        url:'../ajax/file_read.aspx',
        data:{
            'type':'6',
           
        },
        datatype:'json',
        success:function(data){
            var json=eval("("+data+")");
            if(json.static=="success")
            {
                var html="<ul>";
                $(json.data).each(function(){
                    html+="<li class='hotdownload_list' file_id='"+this.文档编号+"'>"+decodeURI(this.标题)+"</li>"
                })
                html+="</ul>";
                $(".hotdown_list_div").html(html);
                 $(".hotdown_list_div .hotdownload_list").click(function(){
                    window.open("../page/file_read.aspx?file_id="+$(this).attr("file_id"))
                 })
            }
            else
            {
                 $(".hotdown_list_div").html("暂无相关信息");

            }
        },
        error:function(){
            $(".hotdown_list_div").html("暂无相关信息");
        }
    })


}















　　

