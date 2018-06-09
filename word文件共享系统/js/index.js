$(document).ready(function(){
    this.title="首页"
 file_list();
 load_task();
 host_filelist();

    /*分类，鼠标经过上滑显示*/
   /* $(".ba_icon").mouseover(function(){
    	$(this).children(".type_text").slideDown(200);

    })
    $(".ba_icon").mouseout(function(){
    	$(this).children(".type_text").slideUp(50);

    })*/

    $(".ba_icon").hover(function(){
        $(this).children(".type_text").slideDown(200);
    },function(){
        $(this).children(".type_text").slideUp(50);
    })

    $(".ba_icon").click(function(){
    	window.location.href="../page/file_list.aspx";
    })

    $(".bottom .uploa_but").click(function(){
       $(".menu1.user_upload").click()
    })


   
   $(".example1").luara({width:"100%",height:"400",interval:5000,selected:"seleted",deriction:"top"});

      


})
          

/*获取报告列表*/
function file_list(){
    $.ajax({
        type:'post',
        url:'../ajax/index.aspx',
        data:{
            'type':'4'
        },
        datatype:'json',
        success:function(data){
           // var json=eval("("+data+")");
            var json=eval("(" + data + ")");
            if(json.static=="success")
            {
                $(".rad_contnet_div").html("");
                $(".rad_contnet_div").html("获取中");
                var html="";
                $(json.data).each(function(){
                    html+=" <div class='read_content' fileid='"+this.文档编号+"'>";
                    html+="<div class='read_head'>";
                    html+="<div class='title pull_left'>"+decodeURIComponent(this.标题)+"</div>";
                    html+="<div class='time pull_right'>";
                    html+="<label class='la_type'>"+this.类型+"</label>";
                    html+="<label class='lb_time'>更新："+this.上传时间+"</label></div>";
                    html+="</div>";
                    html+="<div class='text'>&nbsp&nbsp&nbsp&nbsp"+decodeURIComponent(this.概述)+"</div>";
                    html+="</div>";
                });
                $(".rad_contnet_div").html(html);




                $(".read_content").click(function(){
                    var file_id=$(this).attr("fileid");
                   window.open("../page/file_read.aspx?file_id="+file_id,"newwindow");
                })
                
            }
            else
            {
                $(".rad_contnet_div").html("");
                $(".rad_contnet_div").html("获取失败");
            }
        },
        error:function(){
            $(".rad_contnet_div").html("");
            $(".rad_contnet_div").html("未知错误");
        },
    })
}

//获取最新公告列表
function load_task()
{
    $.ajax({
        type:'post',
        url:'../ajax/index.aspx',
        data:{
            'type':'5'
        },
        datatype:'josn',
        success:function(data){
            var json =eval("("+data+")");
            if(json.static=="success")
            {
                var html=""
                $(json.data).each(function(){

                    html+="<li class='task_list'>["+this.班级+"]&nbsp&nbsp"+decodeURIComponent(this.标题)+"</li>"
                })
                $(".about_link .task_ul").html(html)

                $(".task_ul .task_list").click(function(){
                    $(".menu_box .m_myfile").click()
                })
            }
        }
    })
}

//获取热门列表
function host_filelist()
{
    $.ajax({
        type:'post',
        url:'../ajax/index.aspx',
        data:{
            'type':'6',

        },
        datatype:'json',
        success:function(data){
            var json=eval("("+data+")");
            if(json.static=="success")
            {
                $(".right .bottom .sum .sum_la").html(json.数量);
                var html="";
                $(json.data).each(function(){
                    
                    html+="<li><a href='../page/file_read.aspx?file_id="+this.文档编号+"'>"+decodeURIComponent(this.标题)+"</li></a>"
              
                })
                $(".news_box .host_file_ur").html(html);
            }
            else
            {
                $(".news_box .host_file_ur").html("<li>获取失败</li>");
            }

        },
        error:function(){
             $(".right .bottom .sum").html("0")
             $(".news_box .host_file_ur").html("<li>获取失败</li>");
        }
    })
}