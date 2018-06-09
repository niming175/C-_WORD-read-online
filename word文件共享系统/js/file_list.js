$(document).ready(function function_name (argument) {
	load_type();
	
	document.title="共享文库"
	title_text=$.trim(decodeURIComponent(request("title_text")));
	if(title_text!="")
	{
		$(".search_div .search_box").val(title_text)
	}
	
	file_type_select("",title_text,"1","1")
					//上一页，下一页，首页，尾页跳转
				$(".page_div .page").click(function(){

                     if($(this).hasClass("visited"))
                     {

                     }
                     else
                     {
                     	var fun=$(this).attr("fun");
                     	switch (fun){
                     		case "first":file_type_select(typeid,title_text,"1",order);
                     		break;
                     		case "up":file_type_select(typeid,title_text,parseInt(页码)-1,order);
                     		break;
                     		case "next":file_type_select(typeid,title_text,parseInt(页码)+1,order);
                     		break;
                     		case "last":file_type_select(typeid,title_text,数量,order);
                     		break;
                     	}
                     }


				})

	
})
var title_text="";
var typeid="";
var 数量=1;
var 页码=1;
var order=1;
//加载文档类别
function load_type(){
	$.ajax({
		type:'post',
		url:'../ajax/file_list.aspx',
		data:{
			'type':'1'
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")")
			if(json.static=="success")
			{
				var html="";
				html+="<div class='list active' typeid=''>全部</div>"
				$(json.data).each(function(){
					html+="<div class='list' typeid='"+this.类型编号+"'>"+this.类型+"</div>"

				})
				$(".menu_list_div").html(html);
				$(".menu_list_div .list").click(function(){
					$(".menu_list_div .list").removeClass("active");
					$(this).addClass("active");
					typeid=$(this).attr("typeid");
					file_type_select($(this).attr("typeid"),title_text,"1","1")

				})
			}

		},
		error:function(){},
	})
}



/*类型编号，关键字，当前页数，排序类型*/
function file_type_select(typeid,title_text,page,order)
{
	$.ajax({
		type:'post',
		url:'../ajax/file_list.aspx',
		data:{
			'type':'2',
			'typeid':typeid,
			'title_text':title_text,
			'page':page,
			'order':order
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")")
			if(json.static=="success")
			{
				 数量=parseInt(json.数量/10)+1
				 页码=json.页码;
				$(".page_div .page_sum").html(数量)
				var page="";
				for(var i=0;i<数量;i++)
				{
					page+="<div page='"+(i+1)+"' class='page_list "+(i+1)+"'>"+(i+1)+"</div>"
				}
				$(".page_div .page_list_div").html(page)
				$(".page_div .page_list").removeClass("active");
				 $(".page_div .page").removeClass("visited");
				if(页码==1)
				{
                    //$(".page_list_div .page_list.1").addClass("active")
                    $(".page_div .page.first").addClass("visited");
                    $(".page_div .page.up").addClass("visited");
				}
				 if(页码==数量)
				{
					 $(".page_div .page.last").addClass("visited");
                     $(".page_div .page.next").addClass("visited");
				}
				 $(".page_list_div .page_list."+页码+"").addClass("active")
				//页数跳转
				$(".page_list_div .page_list").click(function(){
					if(!$(this).hasClass("active")){
						file_type_select(typeid,title_text,$(this).attr("page"),order)
					}
					
				})



				var html="";
				$(json.data).each(function(){

					html+="<div class='file_content' file_id='"+this.文档编号+"'>"
        			html+="<div class='word_icon pull_left'>"
        			html+="</div>"
       				html+="<div class='word_text pull_left'>"
				 	html+="<div class='preview_head clearfix'>"
          			html+="<div class='preview_title pull_left'>"+decodeURIComponent(this.标题)+"</div>"
          			html+="<div class='right pull_right'>"
            		html+="<div class='read_num pull_left inblock'>"+this.阅读量+"</div>人阅读&nbsp&nbsp|&nbsp&nbsp"
            		html+="<div class='time inblock'>"+this.时间+"</div>上传"
          			html+="</div>"
        			html+="</div>"
        			html+="<div class='preview_infor clearfix'>"
          			html+="上传者：<div class='upload_er inblock'>"+decodeURIComponent(this.昵称)+"</div>&nbsp&nbsp|&nbsp&nbsp"
          			html+="类型：<div class='file_type inblock'>"+this.类型+"</div>&nbsp&nbsp|&nbsp&nbsp"
          			html+="下载量：<div class='download_num inblock'>"+this.下载量+"</div>"
        			html+="</div>"
        			html+="<div class='perview_text'>&nbsp&nbsp"+decodeURIComponent(this.概述)+"...</div>"
          			html+="</div>"
      				html+="</div>"
      			})
				$(".filelist_div").html(html);
				$(".filelist_div .file_content").click(function(){
					window.open("../page/file_read.aspx?file_id="+$(this).attr("file_id"))
				})
			}
			if(json.static=="null")
			{
	
				{
					var html="<br/><center class='error'>未搜索到先关信息</center>"
					$(".filelist_div").html(html);
				}
			}
		},
		error:function(){

		}
	})
}

//获取get传值
function request(paras)
{
	var url = location.href;
	var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
	var paraObj = {};
	for (i=0; j=paraString[i]; i++){paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length);}
    var returnValue = paraObj[paras.toLowerCase()];
    if(typeof(returnValue)=="undefined"){ return "";}
    else {return returnValue;}
}

