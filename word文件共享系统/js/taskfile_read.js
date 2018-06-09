$(document).ready(function(){
document.title="文档详情"
 var fileid=request("fileid")

 load_file(fileid)


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
		url:'../ajax/taskfile_read.aspx',
		data:{
			'type':'1',
			'文档编号':fileid

		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")")
			var da=json.data[0];
			$(".file_content .taskfile_title").html(decodeURIComponent(da.文档标题));
			$(".file_content .p_task .task").html(decodeURIComponent(da.公告标题));
			$(".left .info .auther").html(decodeURIComponent(da.姓名));
			$(".left .info .banji").html(da.班级)
			$(".left .info .time").html(da.时间);
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

			if(da.成绩=="")
			{
				$(".right .score_box").html("未点评").addClass("error");
			}
			if(da.成绩!="")
			{
				$(".right .score_box").html(da.成绩).removeClass("error");
			}
			
			$(".right .discuss_box").html(decodeURIComponent(da.评语));

		},
		error:function(){

		}
	})
}