$(document).ready(function function_name (argument) {
	// body...
	//$(".file_con").load("../../data/html/test2.html")


	var fileid=request("fileid")
	if(fileid=="")
	{
		$("body").html("404 未发现资源！")
	}
	else
	{
		load_file(fileid);
		$(".right .score_box").on("keyup",only_num)
		$(".submit_div .submit").click(function(){
		   //任务点评
		   task_command(fileid)
		})
	}
	
})


//获取get传值
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

//加载文档
function load_file(fileid)
{
	$.ajax({
		type:'post',
		url:'ajax/bg_read.aspx',
		data:{
			'type':'1',
			'文档编号':fileid

		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")")
			var da=json.data[0];
			$(".content .taskfile_title").html(decodeURIComponent(da.文档标题));
			$(".content .p_task .task").html(decodeURIComponent(da.公告标题));
			$(".left .info .auther").html(decodeURIComponent(da.姓名));
			$(".left .info .banji").html(da.班级)
			$(".left .info .time").html(da.时间);
			
			$(".right .score_box").val(da.成绩);
			$(".right .discuss_box").val(decodeURIComponent(da.评语));


			//$(".left .file_con").load(da.网页位置);



			$(".left .file_con").load(da.网页位置,function(){
               $(".left .file_con img").each(function(){
                var a=$(this).attr("src");
                $(this).attr("src",da.网页位置.substr(0, 29)+a);
                });
                $(".left .file_con link").each(function(){
                var a=$(this).attr("href");
                $(this).attr("href",da.网页位置.substr(0, 29)+a)
               })
            });

		},
		error:function(){

		}
	})
}

//任务点评
function  task_command(fileid){
	var 成绩=$(".right .score_box").val();
	var 评语=$(".right .discuss_box").val();
	if($.trim(成绩)=="")
	{
		alert("请输入有效成绩")
	}
	if($.trim(评语)=="")
	{
		alert("请输入有效评语");
	}
	if($.trim(成绩)!="" && $.trim(评语)!="")
	{

		$.ajax({
			type:'post',
			url:'ajax/bg_read.aspx',
			data:{
				'type':'2',
				'成绩':成绩,
				'评语':评语,
				'文档编号':fileid
			},
			datatype:'json',
			success:function(data){
				var json =eval("("+data+")");
				if(json.static=="success")
				{
					alert("点评成功");
				}
				else
				{
					alert("点评失败，请刷新后再试");
				}
			},
			error:function(){
				alert("未知错误！")
			}


	    })
	}
	

}

//仅限数字输入
function only_num(){
	var tmptxt=$(this).val();     
  $(this).val(tmptxt.replace(/\D|^0/g,''));     
}