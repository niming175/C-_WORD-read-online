$(document).ready(function function_name (argument) {
	// body...
	teacher_info();
	$(".add_task_div .title_box").on("blur",title_test);
	$(".add_task_div .task_area").on("blur",text_test);
	$(".add_task_div .task_submit").on("click",submit_task)
	//左边菜单点击事件
	$(".menu_liat_div .menu_list").on("click",menu_list_click)

	//添加附件按钮点击
	$(".task_table .addafix_but").on("click",addafixbut_click)
	task_list("","")

	$(".task_details .task_back").on("click",close_deatis_div)

	//修改密码各个文本框失去焦点
	$(".changepsw_table .oldpsw_textbox").on("blur", oldpsw_blur);
	$(".changepsw_table .newpsw_textbox").on("blur",newpsw_blur);
	$(".changepsw_table .conpsw_textbox").on("blur",conpsw_blur);
	//修改密码点击确定
    $(".changepsw_table .changepsw_but").on("click",changepsw_lick);

    //点击搜索
    $(".tr_search .search_but").on("click",search_task_click)
	
})

//点击左边菜单事件
function menu_list_click()
{
	clear_pswbox()
	if($(this).hasClass("active"))
	{

	}
	else
	{
		$(".menu_liat_div .menu_list").removeClass("active");
		$(this).addClass("active");
		$(".right .right_con_div").addClass("hiden");
		var div =$(this).attr("divname");
		if(div=="task_list_div")
		{
			$(".task_list_div").removeClass("hiden");
			 task_list("","")
		}
		if(div=="add_task_div")
		{
			$(".add_task_div").removeClass("hiden");
			class_list();
		}
		if(div=="changepsw_div")
		{
			$(".changepsw_div").removeClass("hiden");
		}
	}
	
}

//加载教师信息
function teacher_info()
{
	$.ajax({
		type:'post',
		url:'ajax/teacher_maneage.aspx',
		data:{
			'type':'3'
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")");
			if(json.state=="success")
			{
				var html="";
				var option="<option class_id=''>全部</option>";
				$(".hello_text .teacher_name").html(json.姓名);
				if(json.data!="null")
				{
					var i=1;
					$(json.data).each(function(){
					html+="<label class='class_label block'>"+i+":"+this.科目名称+"</label>";
					i++;
					})
					$(".my_class").html(html).removeClass("error");
					//$(".tr_search .class_select").html(option).removeClass("error");

				}
				else
				{
					$(".my_class").html("<label class='class_label block error'>未分配负责科目</label>");
				}
				
				
			}
			else if(json.state=="out")
			{
				alert("你登陆状态已经掉线，请重新登陆！")
				
			}
			else
			{
				alert("获取数据失败请稍后再试！")
			}
		},
		error:function(){
			alert("未知错误！");
		}
	})
}
function title_test(){
	var title=$(".add_task_div .title_box").val();
	if($.trim(title)=="")
	{
		$(".td_remark .label_title.remark").html("标题不能为空").addClass("error").removeClass("hiden")
		return false;
	}
	else
	{
		$(".td_remark .label_title.remark").addClass("hiden")
		return true;
	}
}
function text_test(){
	var text=$(".add_task_div .task_area").val();
	if($.trim(text)=="")
	{
		$(".td_remark .label_text.remark").html("请输入内容").addClass("error").removeClass("hiden").addClass("block");
		return false;
	}
	else
	{
		$(".td_remark .label_text.remark").addClass("hiden").removeClass("block")
		return true;
	}
}

var class_id=null;
//加载班级列表
function class_list()
{
	$.ajax({
		type:'post',
		url:'ajax/teacher_maneage.aspx',
		data:{
			type:'1'
		},
		success:function(data){
			var json=eval("("+data+")");
			if(json.static=="success")
			{
				var html="";
				$(json.data).each(function(){
					html+="<option valueid='"+this.班级编号+"'>"+this.班级名称+"</option>";
				});
				$(".task_table .dr_select").html(html);

				class_id=$(".task_table .dr_select").children("option").attr("valueid")
				project_load(class_id)

            	$(".task_table .dr_select").change(function(){
            		class_id=$(this).children("option:selected").attr("valueid");
            		project_load(class_id)
            	})
			}
			else
			{
				$(".task_table .dr_select").html("<option valueid='0'>未分配班级</option>");
			}
		},
		error:function(){
	   		alert("未知错误！")
	   	}
	})
}
//加载公告列表
function task_list(a,b)
{
	$.ajax({
		type:'post',
		url:'ajax/teacher_maneage.aspx',
		data:{
			'type':'4',
			'class_id':a,
			'text':b
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")");
			if(json.static=="success")
			{
				$(".task_list_div .task_sum .la_sum").html(json.总量);
				var html="";
				var a=1;

				$(json.data).each(function(){
					var b=a%2==0?" ":"odd";
					html+="<tr class='tr1 "+b+"'>"
                    html+="<td class='center'>"+a+"</td>"
                    html+="<td class='tasklist_title' taskid='"+this.任务编号+"'>"+decodeURIComponent(this.标题)+"</td>"
                    html+="<td >"+this.时间+"</td>"
                    html+="<td>"+this.班级+"：&nbsp"+this.科目名称+"</td>"
                    var c=this.数量==0?'error':'';
                    html+="<td class='center "+c+"'>"+this.数量+"</td>"
                    html+="<td><input type='button' taskid='"+this.任务编号+"' value='编辑' class='edit_but' /></td>"
                	html+="</tr>"
                	a++
				})
				$(".task_list_div .task_list_tbody").html(html);
				$(".tasklist_title").click(function(){
					task_details($(this).attr("taskid"));
				})
			}
			//当列表为空
			if(json.static=="null")
			{
				$(".task_list_div .task_sum .la_sum").html(json.总量);
				$(".task_list_div .task_list_tbody").html(json.message);
			}
			//当已经离线
		},
		error:function(){
			alert("未知错误！");
		}
	})
}


//公告搜索
function search_task_click(){
	var class_id=$(this).parent(".td_search").children(".dr_select").children("option:selected").attr("class_id");
	var text=$(".td_search .search_box").val();
	task_list(class_id,text)

}

//加载公告详细
function task_details(taskid)
{
	$(".right .right_con_div").addClass("hiden");
	$(".right .task_details.right_con_div").removeClass("hiden")



	$.ajax({
		type:'post',
		url:'ajax/teacher_maneage.aspx',
		data:{
			'type':'5',
			'任务编号':taskid
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")");
			if(json.static=="success")
			{
				$(".taskdetails_table .la_tasktitle").html(decodeURIComponent(json.任务标题));
				$(".taskdetails_table .la_taskclass").html(json.班级);
				$(".taskdetails_table .la_tasktime").html(json.时间);
				$(".taskdetails_table  .project_label").html(json.科目名称)
				$(".taskdetails_table .td_taskreques").html("&nbsp&nbsp"+decodeURIComponent(json.要求));
				if(json.附件位置!="")
				{
					$(".taskdetails_table .afixdown").attr("href",json.附件位置).html("下载附件").removeClass("none")
				}
				else
				{
					$(".taskdetails_table .afixdown").html("没有附件").attr("href","#").removeAttr("href").addClass("none")

				}
				
				
				if(json.data.length>0)
				{
					var a=1;
					var html="";
					$(json.data).each(function(){
						var b=a%2==0?"tr2":"tr1";
						html+="<tr class="+b+">"
	                    html+="<td class='center'>"+a+"</td>"
	                    html+="<td class='td2 taskfile_title' fileid='"+this.文档编号+"'>"+decodeURIComponent(this.标题)+"</td>"
	                    html+="<td class='td3'>"+decodeURIComponent(this.姓名)+"</td>"
	                    html+="<td class='center'>"+this.上传时间+"</td>"
	                    var c=this.成绩==""?"未点评":this.成绩;
	                    var d=this.成绩==""?"error":"";
	                    html+="<td class='center "+d+"'>"+c+"</td>"
	                	html+="</tr>"
	                	a++;
					})
					$(".taskedtails_list .taskdetails_tbody").html(html)
					$(".taskedtails_list .taskfile_title").click(function(){
						window.open("bg_read.aspx?fileid="+$(this).attr("fileid"))
					})
				}
				else
				{
					var html="<tr><td colspan='5' class='center error'>暂无人提交</td></tr>"
					$(".taskedtails_list .taskdetails_tbody").html(html)
				}
			}
		},
		error:function(){
			alert("未知错误！");
		}

	})
	//alert(taskid)
}
//添加公告与附件
function submit_task(){
	if(title_test() && text_test())
	{

		var 附件位置="";
		var file=document.getElementById("afix_file");
		if(file.files.length>0)//有文件
		{

			var fromData=new FormData();
			fromData.append('file',document.getElementById("afix_file").files[0]) 
			fromData.append('type','6');
			$.ajax({
				type:'post',
				url:'ajax/teacher_maneage.aspx',
				data:fromData,
				cache: false,
				processData: false,
				contentType: false,
				datatype:'json',
				success:function(data)
				{
					var json=eval("("+data+")");
					if(json.static=="success")
					{
						附件位置=json.附件位置;
						addtask_data(附件位置);
						file.files=null;
						$("#afix_file").val("");
						$(".task_table .afixfile_name").html("没有选择附件")
					}
					else
					{
						alert("在上传附件的时候出现错误")
					}
				},
				error:function(){
					alert("附件上传失败")
				}
			})
		}
		else
		{
			addtask_data("")
		}
	}
	else
	{

	}
	
}

//上传任务公告数据
function addtask_data(afix)
{

		if(class_id!=null && class_id!="0")
		{

			if(course_id=="")
			{
				alert("上传中出现错误")
			}
			else
			{


			   var task_title=$(".add_task_div .title_box").val();
			   var task_text=$(".add_task_div .task_area").val();
			   $.ajax({
			   	type:'post',
			   	url:'ajax/teacher_maneage.aspx',
			   	data:{
			   		'type':'2',
			   		'标题':task_title,
			   		'要求':task_text,
			   		'课任编号':course_id,
			   		'附件位置':afix
			   	},
			   	datatype:'json',
			   	success:function(data){
			   		var json=eval("("+data+")")
			   		if(json.static=="success")
			   		{
			   			$(".add_task_div .title_box").val("");
			   			$(".add_task_div .task_area").val("");

			   			alert("添加成功");

			   		}
			   	},
			   	error:function(){
			   		alert("未知错误！")
			   	}
			   })
			}
	    }
	    else
	    {
	    	alert("出现错误")
	    }

}
//添加附件按钮点击
function addafixbut_click(){
	$("#afix_file").click();
		$("#afix_file").change(function(){
			var a=$(this).val();
			if ($.trim(a)!="")
			{
				var file_size=this.files[0].size;
				var size=file_size;
				if(size>(10240*1024))
				{
					$(".remark_afixlabel").html("文件过大").addClass("error")
					this.files[0]=null;
					$(this).val("")
                    //$(this).remove();   
                    $(".task_table .afixfile_name").html("没有选择附件")

				}
				else
				{
					$(".task_table .afixfile_name").html(this.files[0].name)
					$(".remark_afixlabel").html("小于10M的附件").removeClass("error")
				
				}
				
			}
			else
			{
				$(".task_table .afixfile_name").html("没有选择附件")
			}
			
		})
}

//点击关闭
function close_deatis_div()
{
	$(".task_details.right_con_div").addClass("hiden");
	$(".task_list_div.right_con_div").removeClass("hiden")
}

//修改密码
//原密码失去焦点判断
function oldpsw_blur()
{
	var a=$(".changepsw_table .oldpsw_textbox").val();
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
	var a=$(".changepsw_table .newpsw_textbox").val();
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

//确认密码失去焦点
function conpsw_blur()
{
	var a=$(".changepsw_table .conpsw_textbox").val();
	if($.trim(a)=="" || a.length<6)
	{
		$(".changepsw_table .conpsw_la").html("确认密码不能为空或小于六个字符").removeClass("hiden");
		return false;
	}
	else if(a.length>6 && a!=$(".changepsw_table .newpsw_textbox").val())
	{
		$(".changepsw_table .conpsw_la").html("密码不一致").removeClass("hiden");
		return false;
	}
	else
	{
		$(".changepsw_table .conpsw_la").addClass("hiden");
		return true;
	}
}


//修改密码
function changepsw_lick(){
	if(oldpsw_blur() && newpsw_blur() && conpsw_blur())
	{
		var oldpsw=hex_md5($(".changepsw_table .oldpsw_textbox").val());
		var newpsw=hex_md5($(".changepsw_table .newpsw_textbox").val());
		$.ajax({
			type:'post',
			url:'ajax/teacher_maneage.aspx',
			data:{
				'type':'7',
				'oldpsw':oldpsw,
				'newpsw':newpsw
			},
			datatype:'json',
			success:function(data){
				var json=eval("("+data+")")
				if(json.static=="out")
				{
					alert("你登陆状态已经掉线，请重新登陆！");
					window.location.href="bg_login.aspx";
				}
				if(json.static=="mistake")
				{
					$(".changepsw_table .oldpsw_la").html("原密码错误！").removeClass("hiden");
					$(".changepsw_table .oldpsw_textbox").val("")
				}
				if(json.static=="success")
				{
					alert("密码修改成功");
					$(".changepsw_table .oldpsw_textbox").val("")

				}
				if(json.static=="error")
				{
					alert("在修改密码的时候出现未知错误");
					$(".changepsw_table .oldpsw_textbox").val("")
				}
			},
			error:function()
			{
				alert("在修改密码的时候出现未知错误");
				$(".changepsw_table .oldpsw_textbox").val("")
			}
		})
	}
	
}

//加载科目

var course_id="";
function project_load(class_id){
	$.ajax({
		type:'post',
		url:'ajax/teacher_maneage.aspx',
		data:{
			'type':'8',
			'班级编号':class_id
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")")
			if(json.static=="success")
			{
				var html="";
				$(json.data).each(function(){
					html+="<option course_id='"+this.课任编号+"'>"+this.科目+"</option>"
				});
				$(".select_project").html(html)
				course_id=$(".task_table .select_project").children("option").attr("course_id")
				$(".task_table .select_project").change(function(){
            		course_id=$(this).children("option:selected").attr("course_id");
            		//project_load(class_id)
            	})
			}
		}

	})
}
//清除修改密码数据
function clear_pswbox(){
	$(".changepsw_table .oldpsw_textbox").val("");
	$(".changepsw_table .newpsw_textbox").val("");
	$(".changepsw_table .conpsw_textbox").val("");
	$(".changepsw_table .oldpsw_la").addClass("hiden");
	$(".changepsw_table .newpsw_la").addClass("hiden");
	$(".changepsw_table .conpsw_la").addClass("hiden");

}