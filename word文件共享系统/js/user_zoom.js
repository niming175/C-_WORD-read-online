$(document).ready(function function_name (argument) {
	// body...
	document.title="个人中心"
	$(".change_head .change_close").click(function(){
		$(".change_bg").addClass("hiden");
		$("body").removeClass("body_overflow")
	})
    
    /*点击修改信息*/
    $(".user_button .change_but").click(function(){
    	$(".change_bg").removeClass("hiden");
		//$("body").addClass("body_overflow");
		 //document.documentElement.scrollTop = document.body.scrollTop =0;
    })
	$(".file").change(function(){
	var file = $(this).val();
    //var strFileName=file.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi,"$1");  //正则表达式获取文件名，不带后缀
    //var FileExt=file.replace(/.+\./,"");
	//var strimgs=strFileName+"."+FileExt;
	 $('.img_head').attr("src",file);
	})

	/*点击文件，跳转*/
	$(".file_title").click(function(){
		window.location.href="../page/file_read.html";
	})
	/*点击我的文档*/
	$(".list_menu .my_file").on("click",my_file_load)

	/*点击左边菜单，跳转各个子页面*/
	$(".list_menu .list").click(function(){
		var page=$(this).attr("value");
		$(".right_page").addClass("hiden");
		$("."+page).removeClass("hiden");
		$(".list_menu .list").removeClass("active");
		$(this).addClass("active");
	})

	//点击退出
	$(".user_button .logiout_but").click(function(){
		$(".user_static .user_logout").click();
	})
//点击选择任务公告上传 选择文件
$(".tr_file .select_but").click(function(){$("#taskfile").click()})
/*我的任务点击*/
//$(".con_mytask .task_div .new_text").click(function(){})
load();
//点击加载最新任务
$(".new_task .new_text").on("click",new_task_click);
//点击加载已经完成任务
$(".finish_task .new_text").on("click",finish_task_click);
//修改信息中点击信息保存
$(".change_info_div .save_button_div .button").on("click",save_user_info)

$(".psw_box.old_psw").on("blur",old_psw_blur)
$(".psw_box.new_psw").on("blur",new_psw_blur)
$(".psw_box.conf_psw").on("blur",conf_psw_blur)
$(".chan_table .button").on("click",changepsw)


//点击提交按钮提交文档
$(".submit_table .submit_button").click(function(){
	if($(".submit_table .file_box").val()=="" || $("#taskfile").val()=="")
	{
		task_title_blur()
		$(".submit_table .file_la").html("你还未选择文件").addClass("error").removeClass("hiden")
	}
	else if(task_title_blur())
	{
		$(".submit_div .submit_loding_bg").removeClass("hiden")
		$(".submit_loding_bg .loding_text").removeClass("error")
		file_submit(task_id)
	}
	
});
//文档标题失去焦点
$(".submit_table .title_box").on("blur",task_title_blur)

//点击关闭提交文档
$(".submit_task_div_bg .submit_close").click(function(){
		$(".submit_task_div_bg").addClass("hiden")
		$("#taskfile").val("")
		$(".tr_file .file_box").val($("#taskfile").val())
		$(".submit_task_div_bg").addClass("hiden")
		$(".submit_div .submit_table").addClass("hiden");
		$(".newtasksubmit_now_div").removeClass("hiden");
		$(".submit_div .title_box").val("");
		$(".submit_div .file_box").val("");
		$("#taskfile").val("")
	
	})
//点击取消
$(".submit_table .cancesubmit_button").click(function(){
	$(".submit_div .submit_table").addClass("hiden");
	$(".newtasksubmit_now_div").removeClass("hiden");
	$(".submit_div .title_box").val("");
	$(".submit_div .file_box").val("");
	$("#taskfile").val("")
})
				

})
var task_id=""

//用户信息
function load(){
	//判断是否在线，否者推到退到首页
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
	            	
					user_inform()
	            }
	            if(json.static=="error")
	            {
	            	window.location.href="../index/index.aspx";
	            }
	        },
	        error:function(){}
	    });
}

//用户信息
function user_inform(){
	$.ajax({
		type:'post',
		url:'../ajax/user_zoom.aspx',
		data:{
			'type':'1'
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")");
			if(json.static="success")
			{
				$(".user_name .user_name_h3").html(decodeURI(json.昵称));
            	$(".user_name .class_name").html("班级：&nbsp&nbsp"+json.班级);
            	$(".upload_num .number").html(json.数量);
            	$(".head_img .image").attr("src",json.头像位置)

            	$(".change_info_div .tr_name .input").val(decodeURI(json.昵称));
            	$(".change_info_div .tr_email .input").val(json.邮箱);
            	$(".user_img_div .img_head").attr("src",json.头像位置);
			}
			
		},
		error:function(){
			alert("未知错误");
		}
	})
}

//保存用信息
function save_user_info(){
	var 邮箱=$(".change_info_div .tr_email .input").val();
	var 昵称=$(".change_info_div .tr_name .input").val();
	if(email_test() && namebox_test())
	{

			$(".change_loding_bg").removeClass("hiden")
			var formData=new FormData();
			formData.append('iamge',document.getElementById("user_image").files[0]);
			formData.append('type','2');
			formData.append('昵称',昵称);
			formData.append('邮箱',邮箱);
			formData.append('头像位置',$(".head_img .image").attr("src"))
			$.ajax({
				type:'post',
				url:'../ajax/user_zoom.aspx',
				cache: false,
				data:formData,
				datatype:'json',
				processData: false,
			    contentType: false,
				success:function(data){
					var json =eval("("+data+")")
					if(json.static=="success")
					{
						$(".change_loding_bg .label").html("修改成功！").removeClass("error");
						user_inform();
						loading();
						setTimeout(function(){
							$(".change_loding_bg").fadeOut(300);
						},1500);
					}
					if(json.static=="error")
					{
						$(".change_loding_bg .label").html(json.message).addClass("error");
						setTimeout(function(){
							$(".change_loding_bg").fadeOut(300);
						},1500);
					}
				},
				error:function(){
					$(".change_loding_bg .label").html("未知错误").addClass("error");
				   setTimeout(function(){
							$(".change_loding_bg").fadeOut(300);
						},1500);
				}
			})
		}
	else
	{}

}

//判断邮箱格式
function email_test()
{
	var 邮箱=$(".change_info_div .tr_email .input").val();
		if(!isEmail(邮箱) && $.trim(邮箱)!="")
	{
		$(".tr_email .label_email").html("邮箱格式错误！").removeClass("hiden").addClass("error");
		return false;
	}
	else
	{
		$(".tr_email .label_email").addClass("hiden");
		return true;
	}
}

//昵称格式判断
function namebox_test(){
	var username=$(".change_info_div .tr_name .input").val();
	if($.trim(username)=="")
	{
		$(".tr_name .label_usernamebox").html("用户名不能为空").removeClass("hiden").addClass("error");
		return false;
	}
	else
	{
		$(".tr_name .label_usernamebox").addClass("hiden")
		return true;
	}
}

//邮箱格式验证
function isEmail(str){ 
	var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/; 
	return reg.test(str); 
} 

//加载我的文档
function my_file_load(){
	$.ajax({
		type:'post',
		url:'../ajax/user_zoom.aspx',
		data:{
			'type':'3'
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")");
			if(json.static="success")
			{
				$(".tb_file_list").html("");
				var html="";
				var a=1;
				$(json.data).each(function(){
				var b=a%2==0?"even":"";
				html+="<tr class='tr_list "+b+"'>"
            	html+="<td class='file_id'>00"+a+"</td>"
            	html+="<td class='file_title' file_id='"+this.文档编号+"'>"+decodeURI(this.标题)+"</td>"
            	html+="<td class='file_time'>"+this.上传时间+"</td>"
            	html+="<td class='file_static'>公开</td>"
            	html+="<td class='file_option'>"
              	html+="<input type='button' class='file_edit button' value='编辑'>"
              	html+="<input type='button' class='fiel_del button' value='删除''>"
            	html+="</td>"
          		html+="</tr>"
          		a++;
				})
				$(".tb_file_list").html(html)
				$(".tb_file_list .file_title").click(function(){
					window.open("../page/file_read.aspx?file_id="+$(this).attr("file_id"));
				})

			}
		},
		error:function(){}
	})
}

//最新任务公告点击
function new_task_click()
{
	$(this).next(".new_task_table").slideToggle("1000");
		if($(this).hasClass("show"))
		{
			
			$(this).removeClass("show");
		}
		else
		{
			$(this).addClass("show");
			new_task();
		
		}
}
//加载最新公告
function new_task()
{
	$.ajax({
					type:'post',
					url:'../ajax/user_zoom.aspx',
					data:{
						type:'4',
					},
					datatype:'json',
					success:function(data){
						var json=eval("("+data+")");
						if(json.static=="success")
						{
							$(".new_task_table .label_newtask").html(json.count);
							var html="";
							var a=1;
							$(json.data).each(function(){
								var b=a%2==0?'even':''
								html+="<tr class='tr_con "+b+"'>";
								html+="<td class='td1'>new</td>"
					            html+="<td class='td2 newtask_title'  task_id='"+this.任务编号+"'>"+decodeURIComponent(this.标题)+"</td>"
					            html+="<td class='td6'>"+this.科目名称+"</td>"
					            html+="<td class='td3'>"+this.姓名+"</td>"
					            html+="<td class='td4'>"+this.时间+"</td>"
					            html+="<td class='td5'>未提交</td>"
					           if(this.附件位置!="")
					           {
					           	html+="<td class='td7'><a href='"+this.附件位置+"'>附件下载</a></td>"
					           }
					           else
					           {
					           	html+="<td class='td7 null'>没有附件</td>"
					           }
					            html+="</tr>"
					            a++;
							})

							$(".new_task .new_task_list").html(html);
								/*点击提交按钮*/
				            $(".new_task_list .newtask_title").on("click",submit_task)

						}
						if(json.static=="error")
						{
							$(".new_task .new_task_list").html("没有新的任务");
						}

					},
					error:function()
					{
						alert("出现未知错误！")
					}
				})
}

//已经完成任务公告点击
function finish_task_click()
{

		$(this).next(".new_task_table").slideToggle("1000");
		/*
		* 如果下拉框已经显示，收起，不加载文档列表
		* 如果下拉框未展开，展开同时加载文档列表
		*/
		if($(this).hasClass("show"))
		{
			
			$(this).removeClass("show");
			
	    }
		else
		{
			$(this).addClass("show");
			finished_task()
		}
}
//加载已经完成任务公告列表
function finished_task()
{
	$.ajax({
			  	type:'post',
			  	url:'../ajax/user_zoom.aspx',
			  	data:{
			  		'type':'7'

			  	},
			  	datatype:'json',
			  	success:function(data){
			  		var json=eval("("+data+")")
			  		if(json.static=="success")
			  		{
			  			$(".finish_task .label_finishtask").html(json.数量);
			  			var html="";
			  			var a=1;
			  			$(json.data).each(function(){
			  			  var b=a%2==0?'even':''
			  			  html+="<tr class='tr_con "+b+"'>"
			              html+="<td class='td1'>"+a+"</td>"
			              html+="<td class='td2 finishedtask_title' fileid='"+this.文档编号+"'>"+decodeURIComponent(this.任务)+"</td>"
			              html+="<td class='td3'>"+this.科目名称+"</td>"
			              html+="<td class='td4'>"+this.姓名+"</td>"
			              html+="<td class='td5'>"+this.时间+"</td>"
			              if(this.成绩==null || this.成绩==0)
			              {
			              	html+="<td class='td6 error'>未点评</td>"
			              }
			              else
			              {
			              	html+="<td class='td6'>"+this.成绩+"</td>"
			              }
			              
			              html+="</tr>"
			              a++;
			  			})
			  			$(".finished_task_tbody").html(html);
			  			$(".finished_task_tbody .finishedtask_title").click(function(){
			  				window.open("taskfile_read.aspx?fileid="+$(this).attr("fileid"))
			  			})

			  		}
			  		if(json.static=="null")
			  		{
			  			$(".finished_task_tbody").html("没有已经完成的任务")

			  		}
			  		if(json.static=="error")
			  		{
			  			alert(json.message);
			  			window.location.href="../index/index.aspx";
			  		}
			  	},
			  	error:function(){}
	  		})	
}

//任务标题失去焦点
function task_title_blur()
{
	var str=$(".submit_table .title_box").val();
	if($.trim(str)=="")
	{
		$(".submit_table .title_la").html("请输入标题").addClass("error").removeClass("hiden")
		return false;
	}
	else
	{
		$(".submit_table .title_la").addClass("hiden")
		return true
	}
}
//点击最新任务提交按钮
function submit_task()
{
     task_id=$(this).attr("task_id");
	$.ajax({
		type:'post',
		url:'../ajax/user_zoom.aspx',
		data:{
			'type':'5',
			'任务编号':task_id
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")")
			if(json.static=="success")
			{
				$(".submit_task_div_bg .task_title_label").html(decodeURIComponent(json.标题));
				$(".submit_task_div_bg .task_request .request").html(decodeURIComponent(json.要求))
				$(".submit_task_div_bg .task_time .time_la").html(decodeURIComponent(json.时间))
				if(json.附件位置!="")
				{
					$(".daown_afix .downafix_a").attr("href",json.附件位置).removeClass("none").html("下载附件");
				}
				else
				{
					$(".daown_afix .downafix_a").attr("href","").html("没有附件").addClass("none").removeAttr("href");
				}
				
				$(".submit_task_div_bg").removeClass("hiden")
				
				$("#taskfile").change(function(){
					$(".tr_file .file_box").val($(this).val());
					$(".submit_table .file_la").addClass("hiden");
				})

				//点击马上提交
				$(".newtasksubmit_now_div .newtasksubmit_but").click(function(){
					$(".submit_div .submit_table").removeClass("hiden");
					$(".newtasksubmit_now_div").addClass("hiden")
				})
			

			}
		},
		error:function(){
			alert("未知错误！");
		}
	})


}

function file_submit(task_id){
var sub_file=new FormData();
		sub_file.append('file',document.getElementById("taskfile").files[0])
		sub_file.append('type','3');
		//sub_file.append('task_id',task_id);
		$.ajax({
			type:'post',
			url:'../ajax/upload.aspx',
			data:sub_file,
			cache: false,
			datatype:'json',
			processData: false,
		    contentType: false,
			success:function(data){
				var json=eval("("+data+")");
				if(json.static=="success")
				{
					var 标题=$(".submit_table .title_box").val();
					var 文档位置=json.文档位置;
					var 网页位置=json.网页位置;
					var 任务编号=task_id;
					$.ajax({
						type:'post',
						url:'../ajax/user_zoom.aspx',
						data:{
							'type':'6',
							'标题':标题,
							'文档位置':文档位置,
							'网页位置':网页位置,
							'任务编号':任务编号
						},
						datatype:'json',
						success:function(data)
						{
							var json=eval("("+data+")");
							if(json.static=="success")
							{
								$(".submit_loding_bg .loding_text").html("提交成功").removeClass("error");
								
								
								$(".submit_table .title_box").val("")
								$(".submit_table .file_box").val("")
								var file = $("#taskfile") ;
								file.after(file.clone().val(""));      
								file.remove();  
								setTimeout(function(){
								$(".submit_div .submit_loding_bg").fadeOut(500);
								$(".submit_task_div_bg").addClass("hiden");
								new_task();
								finished_task();
								},1500);
								
							}
							else
							{
								$(".submit_loding_bg .loding_text").html("提交失败请重试").addClass("error");
								setTimeout(function(){
								$(".submit_div .submit_loding_bg").fadeOut(500);
								},1500);
							}

						},
						error:function()
						{
							$(".submit_loding_bg .loding_text").html("未知错误").addClass("error");
							setTimeout(function(){
							$(".submit_div .submit_loding_bg").fadeOut(300);
							},1500);
						}
					})

				}
				if(json.static=="error")
				{
					$(".submit_loding_bg .loding_text").html(json.message).addClass("error");
					setTimeout(function(){
					$(".submit_div .submit_loding_bg").fadeOut(300);
					},1500);
				}
				
			},
			error:function(){
				$(".submit_loding_bg .loding_text").html("未知错误").addClass("error")
				setTimeout(function(){
					$(".submit_div .submit_loding_bg").fadeOut(300);
				},1500);
				
			},
		})
	
}


//旧密码失去焦点判断
function old_psw_blur () {
	// body...
	var old_psw=$(".psw_box.old_psw").val();
	if($.trim(old_psw)=="")
	{
		$(".oldpsw_la").html("请输入原密码").removeClass("hiden").addClass("error");
		return false;
	}
	else
	{
		$(".oldpsw_la").addClass("hiden")
		return true;
	}
}
//新密码失去焦点判断
function new_psw_blur(){
   var new_psw=$(".psw_box.new_psw").val()
   if($.trim(new_psw)=="")
   {
   		$(".newpsw_la").html("请输入密码").removeClass("hiden").addClass("error");
   		return false;
   }
   else
   {
   		$(".newpsw_la").addClass("hiden")
   		return true;
   }
}
//确认密码失去焦点判断
function conf_psw_blur(){
	var conf_psw=$(".psw_box.conf_psw").val();
	 var new_psw=$(".psw_box.new_psw").val()
	if($.trim(conf_psw)=="")
	{
		$(".confpsw_la").html("请输入确认密码").removeClass("hiden").addClass("error");
		return false;
	}
	else if($.trim(conf_psw)!="" && conf_psw!=new_psw)
	{
		$(".confpsw_la").html("密码不一致").removeClass("hiden").addClass("error");
		return false;
	}
	else
	{
		$(".confpsw_la").addClass("hiden")
		return true;
	}
}
//修改密码
function changepsw(){

	if(old_psw_blur () && new_psw_blur() && conf_psw_blur())
	{
		
		var old_psw=hex_md5( $(".psw_box.old_psw").val());
		var new_psw=hex_md5( $(".psw_box.new_psw").val());
		//确认密码是否正确
		$.ajax({
			type:'post',
			url:'../ajax/user_zoom.aspx',
			data:{
				'type':'8',
				'旧密码':old_psw,
				'新密码':new_psw
			},
			datatype:'json',
			success:function(data){
				var json=eval("("+data+")")
				if(json.static=="out")
				{
					$(".lohin_but").click();
				}
				if(json.static=="lose")
				{
					alert("原密码错误！")
					var old_psw= $(".psw_box.old_psw").val("");
				}
				if(json.static=="success")
				{
					alert("修改成功！")
					var old_psw= $(".psw_box.old_psw").val("");
				}
				if(json.static=="erro")
				{
					alert("出现错误");
					var old_psw= $(".psw_box.old_psw").val("");

				}

			},
			error:function(){
				alert("未知错误");
			}
		})
	}
	else
	{
	
	return;
	}
}

//修改密码
//原密码失去焦点判断
function oldpsw_blur()
{
	var a=$(".changepsw_table .oldpsw_textbo").val("");
	if($.trim(a)=="" || a.length<6)
	{
		$(".changepsw_table .oldpsw_la").html("原密码不能空或者小于六个字符").removeClass("hiden");
		return false;
	}
	else
	{
		$(".changepsw_table .oldpsw_la").addClass("hiden");
		return true;
	}
}
//新密码失去焦点判断
function newpsw_blur()
{
	var a=$(".changepsw_table .newpsw_textbox").val("");
	if($.trim(a)=="" || a.length<6)
	{
		$(".changepsw_table .newpsw_la").html("新密码不能为空或者小于六个字符").removeClass("hiden");
		return false;
	}
	else
	{
		$(".changepsw_table .newpsw_la").addClass("hiden")
		return true;
	}
}

