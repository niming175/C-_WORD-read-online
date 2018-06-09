$(document).ready(function(){

readyload()

$(".add_studenttbody .student_notext").on('focus',defaultcode)
$(".add_studenttbody .aadd_but").on("click",addstudent)

$(".left_menu .listmenu").on('click',listmenuclick)
$(".changepsw_div input[type='password']").on("focus",function(){
	$(this).next("label").addClass("hiden")
})
$(".changepsw_div input[type='password']").on("blur",function(){
	var a=$(this).val();
	a=$.trim(a)
	if(a.length<6)
	{
		$(this).next("label").removeClass("hiden").html("密码长度错误")


	}
	else
	{
		$(this).next("label").addClass("hiden")

	}
})

$(".changepsw_div .comfpsw_input").on("blur",function(){
	var a=$.trim($(".changepsw_div .newpsw_input").val())
	var b=$.trim($(this).val())
	if(a.length>5 && a!=b && b.length>5)
	{
		$(this).next("label").html("与新密码不一致").removeClass("hiden");
	}
	else
	{
		//$(this).next("label").addClass("hiden")
	}
})

$(".changepsw_div .change_but").on("click",changepassword)
$(".changepsw_div .camcel_but").on("click",function(){
	$(".changepsw_div input[type='password']").val("")
	$(".changepsw_div label.error").addClass("hiden")
})
})

//左边的菜单点击
function listmenuclick()
{
	$(".insright_div .rightdiv").addClass("hiden")
	var a=$(this).attr("value");
	if(a=="1")
	{
		$(".rightdiv.classstudendiv").removeClass("hiden");
		readyload()
	}
	if(a=="2")
	{
		$(".rightdiv.lessman_div").removeClass("hiden");
		//loadtrem(2015,'2016-12-11')
		loadgread ();
	}
	if(a=="3")
	{
		$(".rightdiv.changepsw_div").removeClass("hiden")
	}
}
function readyload(){
	$.ajax({
		type:'post',
		url:'ajax/instructor.aspx',
		data:{
			'type':'1'
		},
		success:function(data){
			var json=eval('('+data+')');
			if(json.state=="success")
			{
				$(".time_text").html(json.时间);
				$(".week_text").html("星期"+json.星期);
				$(".hello_text").html("你好："+json.姓名);

				if(json.data!="null")
				{
					var html="";
					$(json.data).each(function(){
						html+="<li value='"+this.班级编号+"'>"+this.班级名称+"</li>";

					})
					$(".rightdiv .classlist_li").html(html);
					$(".rightdiv .classlist_li li").on('click',function(){
						var classid=$(this).attr("value");
						jiazaibanji(classid);
						$(".add_studenttbody .student_notext").val("")

					})
					var classid=json.data[0].班级编号;
					jiazaibanji(classid)


				}
				else
				{
					var html="";
					html+="<li class='error'>没有班级</li>"
					$(".rightdiv .classlist_li").html(html);
				}

			}
		}
	})
}


//加载班级名单
function jiazaibanji(classid){
	var data={'type':'2','班级编号':classid};
	var value=ajax('post','ajax/instructor.aspx',data,false)
	if(value.state=="success")
	{
		var html="";
		var a=0;
		$(value.data).each(function(){
			html+="<tr class=";
			html+=a%2==0?'tr1':'tr2';
			html+=">";
			html+="<td class='td0'>"+this.学号+"</td>";
			html+="<td class='td1'><input class='student_nola full' type='text' readonly value='"+this.座号+"' /></td>";
			html+="<td class='td2'><input class='student_namela full' type='text' readonly=false value='"+this.姓名+"'/></td>";
			html+="<td class='td3'><div class='student_sex full'>"
			html+=this.性别=="0"?"男":"女";
			html+="</div>";
			html+="<select class='student_sexselect full hiden'>";
			html+="<option value='0'>男</option>";
			html+="<option value='1'>女</option>";
			html+="</select>";
			html+="</td>";
			html+="<td class='td4'>";
			html+="<label class='student_change'>修改</label>";
			html+="<label class='student_del error'>删除</label>";
			html+="<input type='button' class='recove_psw' value='恢复密码'/>";
			html+="</td>";
			html+="</tr>";
			a++;
		})
		$(".student_tbody").html(html);
		$(".classcode .coed").html(value.班级代码);

		$(".studentlist_div .classname").html(value.班级名称)

				//双击姓名
		$(".student_namela").on("dblclick",studentname_bdlclick)
		$(".student_nola").on("dblclick",studentname_bdlclick)

		$(".student_namela").on("blur",onlyread_blur)
		$(".student_nola").on("blur",onlyread_blur)

		$(".student_namela").on("keyup",function(){

			$(this).parent("td").parent("tr").find(".student_change").addClass("ok");
		})
	}
	else
	{
		$(".student_tbody").html("");


	}
	$(".studentlist_div .classcode .coed").attr("classid",classid)
	$(".add_studenttbody .student_addname").val("");
	$(".add_studenttbody .student_notext").val("");
}

//双击
function studentname_bdlclick()
{
	$(this).removeAttr("readOnly");
	$(this).focus();
}

//失去焦点
function onlyread_blur()
{
	$(this).attr("readOnly","readOnly");
	
}


//添加用户
function addstudent()
{
	var classid=$(".classcode .coed").attr("classid");
	var no=$(".add_studenttbody .student_notext").val();
	var name=$(".add_studenttbody .student_addname").val();
	name=$.trim(name);
	if(name.length>1 && name.length<15)
	{

		if(no=="")
		{
			$(".add_studenttbody .student_notext").focus();
			$(".add_studenttbody .student_notext").blur();
		}
		else
		{}
			no=$(".add_studenttbody .student_notext").val();
			var sex=$(".sex_select").children("option:selected").attr("value");
			
			var data={'type':'4','姓名':name,'性别':sex,'座号':no,'班级编号':classid};
			var value=ajax('post','ajax/instructor.aspx',data,false);
			if(value.state=="success")
			{

				jiazaibanji(classid) //成功之后对名单进行刷新
			}
			else
			{
				alert("添加名单的时候出错，请稍后再试");
			}

		

	}
	else
	{
		alert("请规范输入")
	}

}

//加载学期
//year:年级  now：今天日期  id：班级编号

function loadtrem(year,now,id)
{
	var html=""
	for (var i=0;i<8;i++)
	{
		var a="";
		if(i==0 || i==1)
		{
			a="大一"
		}
		else if(i==2 || i==3)
		{
			a="大二"
		}
		else if(i==4 || i==5)
		{
			a="大三"
		}
		else if(i==6 || i==7)
		{
			a="大四"
		}
	
		var z=year+parseInt(i/2)
		var Date1;
		var Date2;
		var Date3=new Date(now)
		var str=""
		if(i%2==0)
		{
			Date1=z+"-09-01"
		    Date2=(z+1)+"-01-31"
		    a=a+"上学期";
		}
		else if(i%2==1)
		{
			Date1=(z+1)+"-03-01"
		    Date2=(z+1)+"-06-31"
		    a=a+"下学期";
		}
		var x=new Date(Date1)
		var y=new Date(Date2)
		var css=""
		if(Date3<x)
		{
			str="还未开始"
			css="blue"
		}
		else if(x<Date3 && Date3<y)
		{
			str="正在进行";
			css="green"
		}
		else if(Date3>y)
		{
			str="已经结束"
			css="error"
		}
		html+="<tr value='"+(i+1)+"' class='tremlisttr ";
		html+=i%2==0?'tr1':'tr2';
		html+="'>";
		html+="<td class='td1'>"+(i+1)+"</td>";
		html+="<td class='td2'>"+a+"</td>";
		html+="<td class='td3'>"+Date1+"</td>";
		html+="<td class='td4'>"+Date2+"</td>";
		html+="<td class='td5 "+css+"'>"+str+"</td>";
		html+="</tr>"
		html+="<tr class='tremless_tbody'>";
		html+="<td colspan='5'>";
		html+="<div class='lesslistdiv clearfix hiden'></div>";
		html+="<td></tr>";

	}

	$(".term_table .tremtbody").html(html)
	$(".tremtbody .tremlisttr").on("click",function(){
		var dom =$(this).next(".tremless_tbody").find(".lesslistdiv");
		
			var num=$(this).attr("value")
		loadtremlessdiv(dom,num,id)
		
	})


}

/*加载点击学期，加载课程div*/
/*dom 元素节点 num 学期  id 班级编号*/
function loadtremlessdiv(dom,num,id){
	if(dom.hasClass("active"))
	{
		dom.removeClass("active")
		dom.slideUp("200")
	}
	else
	{
		dom.addClass("active")
		
		var html="";
		
		html+="<p class='headteat_p'>当前学期：<label class='lab1'>大二上学期</label>"
		html+="<label class='trem_stae'>(正在进行)</label></p>"
		html+="<p>课程表：</p>"
		html+="<table class='less_table'>"
		html+="<tr class='lt_head'>"
		html+="<td class='ltd1'>序号</td>"
		html+="<td class='ltd2'>科目类型</td>"
		html+="<td class='ltd3'>科目名称</td>"
		html+="<td class='ltd4'>教研室</td>"
		html+="<td class='ltd5'>教师</td>"
		html+="<td class='ltd6'>操作</td></tr>"
		html+="<tbody class='lesslist_tbody'>"
		html+="</tbody>"
		html+="<tr class='addless'>"
		html+="<td class='ltd1 green'>添加</td>"
		html+="<td class='ltd2'><select class='selectlesstype full'><option>选择科目类型</option></select></td>"
		html+="<td class='ltd3'><select class='selectlessname full'><option></option></select></td>"
		html+="<td class='' colspan='2'><select class='selectteacher full'><option></option><select></td>"
		html+="<td class='ltd6'><input class='addlessteabut' type='button' value='添加'/></td>"
		html+="</table>"
		html+="<div class='error remaindiv'>";
		html+="<p>注意事项：</p>";
		html+="<p>1、已结束的学期对课程不能再进行任何修改！</p>";
		html+="<p>2、添加班级课程需谨慎，已添加的课程理论上不能删除！</p>";
		html+="<p>3、对于误操作添加错的课程，可以通过删除重新添加！</p></div>"

		dom.html(html);
		dom.slideDown("500")

		//加载课程表
		loadlesstabel(dom,id,num)
		//加载科目类别
		$(".addless .selectlesstype").on("click",function(){
			
			if($(this).hasClass("active"))
			{

			}
			else
			{
				var value=ajax('post','ajax/man-tea.aspx',{'type':'3'},false)
		        if(value.state=="success")
		        {
		            var option="";
		            $(value.data).each(function(){
		               option+="<option value='"+this.科目类型编号+"'>"+this.科目类型名称+"</option>"
		            })
		            $(this).html(option).addClass("active")
		            var dom=$(this).parent("td").next("td").children(".selectlessname");
		            lessonsselect(dom,value.data[0].科目类型编号,id)
		        }
	    	}
		})
		//选择科目类别
		$(".addless .selectlesstype").change(function(){
			var dom=$(this).parent("td").next("td").children(".selectlessname");
			var lessid=$(this).children("option:selected").attr("value")
		    lessonsselect(dom,lessid,id)
		})
		//选择科目
		$(".addless .selectlessname").change(function(){
			var id2=$(this).children("option:selected").attr("value");
			if(id2=="null")
			{}
			else
			{
				var dom2=$(this).parent("td").next("td").children(".selectteacher");
				loadlessteacher(dom2,id2)
			}
		})

		//添加班级课程
		$(".addless .addlessteabut").on("click",function(){
			try{
				var dom3=$(this).parent("td").prev("td").children(".selectteacher");
				var valid=dom3.children("option:selected").attr("value")
				if(valid!="null" && valid !=undefined)
				{
					var data={'type':'9','学期号':num,'班级编号':id,'课任编号':valid};
					var value=ajax('post','ajax/instructor.aspx',data,false);
					if(value.state=="success")
					{
						alert("添加成功！")
						dom3.html("")
						//成功后刷新表格
						$(this).parent("td").parent("tr").find(".selectlesstype").html("<option value='null'>点击选择</>").removeClass("active");
						$(this).parent("td").parent("tr").find(".selectlessname").html("")
						loadlesstabel(dom,id,num)
					}
					else
					{
						alert("添加失败！")
					}
				}
				else
				{
					alert("还未选择相关教师！")
				}
			}
			catch(e)
			{
				alert(e.message); 
			}
			
				
			
		})
	}
}

//点击学期，加载课程表
/*dom 元素 
*classid 班级编号
*num 学期号*/
function loadlesstabel(dom,classid,num)
{
 var data={'type':'11','班级编号':classid,'学期号':num};
 var value=ajax('post','ajax/instructor.aspx',data,false);
 if(value.state=="success")
 {
 	dom.find(".lab1").html(value.学期)
 	var s=value.状态;
 	if(s=="1")
 	{
 		dom.find(".trem_stae").html("（已经结束）").addClass("error")
 		//dom.find(".addless").html("");
 	}
 	else if(s=="2")
 	{
 		dom.find(".trem_stae").html("（正在进行）").addClass("green")
 	}
 	else if(s=="3")
 	{
 		dom.find(".trem_stae").html("（还未开始）").addClass("blue")
 	}
 	if(value.data!="null")
 	{
 		var html="";
 		var i=1;
 		$(value.data).each(function(){
	 		html+="<tr><td class='ltd1'>"+i+"</td>"
			html+="<td class='ltd2'>"+this.科目类型名称+"</td>"
			html+="<td class='ltd3'>"+this.科目名称+"</td>"
			html+="<td class='ltd4'>"+this.教研室名称+"</td>"
			html+="<td class='ltd5'>"+this.姓名+"</td>"
			html+="<td class='ltd6'>";
			html+=s==1?"":"<input class='deleteless_but' type='button' id='"+this.学期编号+"' value='删除'/>"
			html+="</td></tr>"
			i++;
 		})
 		dom.find(".lesslist_tbody").html(html);
 		//点击删除学期的课程
 		$(".lesslist_tbody .deleteless_but").on("click",function(){
 			if(confirm("请谨慎操作，你确定删除该课程？")==true)
 			{
 				var tremid=$(this).attr("id")
 				var value2=ajax("post","ajax/instructor.aspx",{'type':'12','学期编号':tremid},false);
 				if(value.state=="success")
 				{
 					alert("删除成功！");
 					loadlesstabel(dom,classid,num)

 				}
 				else
 				{
 					alert("删除失败，请稍后再试！")
 				}
 			}
 		})
 	}

 }

}

//加载科目选择
function lessonsselect(dom,id,classid)
{

   var value=ajax("post","ajax/instructor.aspx",{'type':'10',"科目类型编号":id,"班级编号":classid},false)
   var html="";
   if(value.state=="success")
   {
      $(value.data).each(function(){
         html+="<option value='"+this.科目编号+"'>"+this.科目名称+"</option>"
      })

      var dom1=dom.parent("td").parent("tr").find(".selectteacher");

      loadlessteacher(dom1,value.data[0].科目编号)

   }
   else
   {
      html+="<option value='null'>没有</option>"
      var dom1=dom.parent("td").parent("tr").find(".selectteacher");
      dom1.html("<option value='null'>没有符合教师</option>")

   }
   dom.html(html)

}
//加载科目教师
function loadlessteacher(dom,id)
{
	var value=ajax('post','ajax/instructor.aspx',{'type':'8','科目编号':id},false)
	if(value.state=="success")
	{
		var option="";
		$(value.data).each(function(){
			option+="<option value='"+this.课任编号+"'>"+this.教师名称+"</option>"
		})
		dom.html(option)
		dom.parent("td").next("td").children(".addlessteabut").addClass("ok")
	}
	else
	{
		dom.html("<option value='null'>没有符合教师</option>")
		dom.parent("td").next("td").children(".addlessteabut").removeClass("ok")
	}
}
/*通用的ajax*/
/*a:type   b:url  c:data  d:async*/
function ajax(a,b,c,d)
{
	var value="";
	$.ajax({
		type:a,
		url:b,
		data:c,
		async:d,
		success:function(data){
			value=data
		},
		error:function(){
			value="{'state':'error'}";
		}
	});
	return eval('('+value+')')
}

//自动获取座号
function defaultcode()
{
	var calssid=$(".studentlist_div .classcode .coed").attr("classid")
	if(calssid=="null")
	{

	}
	else
	{
		data={'type':'3','班级编号':calssid};
		var value=ajax('post','ajax/instructor.aspx',data,false);
		if(value.state=="success")
		{
			$(this).val(value.座号);
		}
		else
		{

		}
	}
}

//获取年级
function loadgread () {
	var value=ajax('post','ajax/instructor.aspx',{'type':'5'},false)
	if(value.state=="out")
	{
		alert("你已经掉线！请冲重新登录！")
	}
	else if(value.state=="success")
	{
		html="";
		$(value.data).each(function(){
			html+="<label value='"+this.年级+"'>"+this.年级+"级</label>"
		})
		$(".nianjidiv .nianjilistdiv").html(html)
		$(".nianjilistdiv label:eq(0)").addClass("active")
		loadclasslist(value.data[0].年级)
		$(".nianjilistdiv label").on("click",function(){
			if($(this).hasClass("active"))
			{}
			else
			{
				$(".nianjilistdiv label").removeClass("active");
				$(this).addClass("active");
				var gread=$(this).attr("value");
				loadclasslist(gread)
			}
		})
	}
	else
	{
		$(".nianjidiv .nianjilistdiv").html("<label class='error'>没有数据</label>")
	}
}

//获取班级列表
function loadclasslist(gread){
	var value=ajax('post','ajax/instructor.aspx',{'type':'6','年级':gread},false)
	if(value.state=="success")
	{
		var html="";
		$(value.data).each(function(){
			html+="<li value='"+this.班级编号+"' class='classlist'>"+this.班级名称+"</li>"

		})
		$(".classlistdiv .classlistul").html(html);
		$(".classlistul li:eq(0)").addClass("active")
		classlistclick(value.data[0].班级编号)
		$(".classlistul li").on("click",function(){
			if($(this).hasClass("active"))
			{

			}
			else
			{
				$(".classlistul li").removeClass("active");
				$(this).addClass("active");
				var id=$(this).attr("value");
				classlistclick(id);
			}
		})

	}
	else
	{
		$(".classlistdiv .classlistul").html("<li class='error'>没有数据</li>");
	}
}

//班级列表点击()
function classlistclick(id){
	var value=ajax('post','ajax/instructor.aspx',{'type':'7','班级编号':id},false)
	if(value.state=="success")
	{
		$(".classinfodiv .classname").html(value.班级名称);
		loadtrem(parseInt(value.年级),value.时间,id)
	}
}

//修改辅导员密码
function changepassword(){
	if(confirm("请谨慎操作，你确定修改密码？"))
	{
		var oldpsw=$.trim($(".changepsw_div .oldpsw_input").val());
		var newpsw=$.trim($(".changepsw_div .newpsw_input").val());
		var conpsw=$.trim($(".changepsw_div .comfpsw_input").val());

		if (oldpsw.length<6 || newpsw.length<6 || conpsw.length<6) {

		}
		else if(newpsw==conpsw)
		{
			var data={'type':'13','旧密码':hex_md5(oldpsw),'新密码':hex_md5(newpsw)};
			var value=ajax('post','ajax/instructor.aspx',data,false);
			if(value.state=="success")
			{
				alert("修改成功！")
				$(".changepsw_div input[type='password']").val("")
			}
			else if(value.state=="msg")
			{
				alert("旧密码有误，请确认后再试！");
				$(".changepsw_div .oldpsw_input").focus().val("");
			}
			else if(value.state=="out")
			{
				alert("你已经掉线！请冲重新登录！")
				$(".changepsw_div input[type='password']").val("")
			}
			else
			{
				alert("修改失败，请稍后再试！")
				$(".changepsw_div input[type='password']").val("")
			}
		}
	}
}

