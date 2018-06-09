$(document).ready(function function_name (argument) {
	// body...
	
	load_typelist()
	$(".addline_div .add_but").on("click",addtype_click) //添加类型
	$(".saveaddtype_button").on("click",saveadd_butclick)
	$(".addline_div .caneladdtype_button").on("click",canceltypeadd_click)
	$(".meau_list .menulist").on("click",leftmenu_click);

	//添加系别点击
	$(".add_deptline_div .adddept_button").on("click",adddept_button_click)
	$(".add_classline_div .addclass_but").on("click",addclass_but_click)
	//点击取消
	$(".canceladddept_button").on("click",canceladddept)
	$(".canceladdclass_button").on("click",camceladdclass)

	//添加系别，保存按钮点击
	$(".deptbox_div .saveadddept_button").on("click",saveadddept_click)

	//添加班级，保存按钮点击
	$(".calssbox_div .saveaddclass_button").on("click",saveaddclass_click)
	//教师管理的手机号失去焦判断
	$(".addteacher_table .teaphone_box").on("blur",teaphone_boxblur)
	//添加教师按钮
	$(".addteacher_table .addtea_button").on("click",addteacher_info)

	$(".classliat_table .classname_div").on("dblclick",classname_focus)
	$(".classliat_table .classname_text").on("blur",classname_blur)
	$(".classliat_table .classgread_div").on("dblclick",classgread_fcous)
	$(".classliat_table .classgread_select").on("change",classgread_select)
	

	/*添加辅导员失去焦点,检测名字*/
	$(".instructor_mandiv .add_body .addname_text").on("blur",check_insname)
	$(".instructor_mandiv .add_body .daaphone_text").on("blur",check_insphone)
	$(".instructor_mandiv .add_body .addname_text").on("focus",insname_focus)
	$(".instructor_mandiv .add_body .daaphone_text").on("focus",insphone_focus)
	$(".instructor_mandiv .add_body .addname_text").on("keyup",addname_keyup)
	$(".instructor_mandiv .add_body .daaphone_text").on("keyup",phonekeyup)
	$(".instructor_mandiv .add_body .add_but").on("click",add_instructor)

	
})

function changetype_click()
{
	$(".type_text").removeClass("hiden");
	$(".type_input").addClass("hiden");
	$(".changetype_button").removeClass("hiden");
	$(".savetype_button").addClass("hiden")

	var a=$(this).parent(".type_list");
	$(this).parent().children(".type_text").addClass("hiden");
	a.children(".type_input").removeClass("hiden");
	a.children(".savetype_button").removeClass("hiden")
	$(this).addClass("hiden")
}

//保存修改
function savetype_click()
{
	var a=$(this).parent(".type_list");
	a.children(".type_text").removeClass("hiden");
	a.children(".type_input").addClass("hiden");
	a.children(".changetype_button").removeClass("hiden");
	$(this).addClass("hiden")
    var type_id=$(this).attr("type_id");
	var str=a.children(".type_input").val();
	if($.trim(str)=="" || str.length<2)
	{
		alert("类型不能为空或者小于两个字符");

	}
	else
	{
		$.ajax({
		post:'post',
		url:'ajax/manerager.aspx',
		data:{
			'type':'3',
			'分类编号':type_id,
			'类型':str
		},
		datatype:'json',
		success:function(data){
			var json =eval("("+data+")");
			if(json.static=="success")
			{
				alert("修改成功！");
				load_typelist();
			}
			else
			{
				alert("修改类型时出现了错误")
			}
		},
		error:function(){
				alert("修改类型时出现了错误")
		}
	})
	}
	
}

//加载类型列表
function load_typelist()
{
	$.ajax({
		type:'post',
		url:'ajax/manerager.aspx',
		data:{
			'type':'1'
		},
		datatype:'json',
		success:function(data){
			var json =eval("("+data+")");
			if(json.static=="success")
			{
				var html=""
				var b=1
				$(json.data).each(function(){
					html+="<div class='type_list'>"
                	html+="<b>"+b+"</b>&nbsp&nbsp"
                	html+="<div class='type_text inblock'>"+decodeURIComponent(this.类型)+"</div>"
                	html+="<input type='text' class='type_input input hiden' maxlength='6' value='"+decodeURIComponent(this.类型)+"'/>"
                	html+="<input type='button' class='changetype_button button1' value='修改'/>"
                	html+="<input type='button' class='savetype_button button2 hiden' value='保存' type_id='"+this.分类编号+"'/>"
            		html+="</div>"
            		b++;
				})

				$(".right .typelist_div").html(html)
				$(".changetype_button").on("click",changetype_click)
				/*$(".savetype_button").click(function(){
					savetype_click($(this).attr("type_id"))
				})*/

				$(".savetype_button").on("click",savetype_click)
			}
			if(json.static="null")
			{

			}
		},
		error:function(){
			alert("在加载类型列表时出现了未知错误！")
		},
	})
}

//添加类型按钮点击
function addtype_click(){
	var a=$(this).parent(".addline_div");
	a.children("input").show(200)
	$(this).addClass("hiden").hide();

	
}


//添加类型保存按钮提交
function saveadd_butclick()
{

		var type_text=$(".addline_div .add_textbox").val();
		if($.trim(type_text)=="" || type_text.length<2)
		{
			alert("类型不能为空,并且至少为两个字")
		}
		else
		{
			canceltypeadd_click()
			addtype(type_text)
		}
	
}
//点击取消
function canceltypeadd_click(){
$(".addline_div .add_textbox").val("");
$(".addline_div input").addClass("hiden").hide(0)
$(".addline_div .add_but").show(0);
	
}


//添加类型
function addtype(type_text)
{
	$.ajax({
		type:'post',
		url:'ajax/manerager.aspx',
		data:{
			'type':'2',
			'类型':type_text
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")")
			if(json.static=="success")
			{
				alert("添加类型成功");
				canceltypeadd_click();
				load_typelist();
			}
			else
			{
				alert("在添加失败！")
				canceltypeadd_click();
			}
		},
		error:function(){
			alert("在添加类型时出现未知错误！");
		}

	})
}

//点击右边菜单加载
function leftmenu_click()
{
	if($(this).hasClass("active"))
	{

	}
	else
	{
		$(".meau_list .menulist").removeClass("active");
		$(this).addClass("active")
		$(".right_condiv").addClass("hiden")
		var a=$(this).attr("divname");
		if(a=="1")
		{
			$(".right_condiv.filetype_mandiv").removeClass("hiden")
		}
		if(a=="2")
		{
			$(".right_condiv.class_mandiv").removeClass("hiden");
			load_dept()
			//classlist_load()

		}
		if(a=="3")
		{
			$(".right_condiv.teacher_mandiv").removeClass("hiden")
			load_teacherinfo()
		}
		/*加载辅导员模块*/
		if(a=="4")
		{
			$(".right_condiv.instructor_mandiv").removeClass("hiden")
			load_instructor()
		}
	}
}



function classname_focus()
{
	$(this).addClass("hiden");
	$(this).next("input").removeClass("hiden").focus();
}
function classname_blur(){
	$(this).addClass("hiden")
	$(this).prev("div").removeClass("hiden")
}

function classgread_fcous()
{
	$(this).addClass("hiden");
	$(this).next("select").removeClass("hiden");
}
function classgread_select()
{
	$(this).addClass("hiden")
	$(this).prev("div").removeClass("hiden")
}
//加载系别
function load_dept(){
	$.ajax({
		type:'post',
		url:'ajax/manerager.aspx',
		data:{
			'type':'4'
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")")
			if(json.static=="success")
			{
				var html="";
				a=1
				$(json.data).each(function(){
					html+="<div class='dept_list_div' value='"+this.系别编号+"'>"+this.识别码+"：<div class='inblock deptname_la' value='"+this.系别编号+"'>"+this.系别名称+"</div class='inblock deptname_la'>"
					html+="<input class='deptname_textbox hiden' type='text' maxlength='15' value='"+this.系别名称+"' />";
					html+="<input class='savedept_button hiden' type='button' value='保存' />"
					html+="<input class='changedept_cancel hiden error' type='button' value='取消' />"
					html+="<input class='changedept_button' type='button' value='修改'>";
					html+="</div>";
					html+=" <div class='class_infodiv clearfix hiden'></div>"
					a++;

				})
				$(".class_mandiv .dept_list").html(html);
				//点击系别中的修改
				$(".changedept_button").on("click",function(){changedept_click($(this))})
				$(".deptname_textbox").on("keyup",function(){
					if($.trim($(this).val()).length>2 && $.trim($(this).val()).length<15) {
						$(this).next(".savedept_button").addClass("ok");
					}
					else {
					 	$(this).next(".savedept_button").removeClass("ok");
					} 
				});
				$(".changedept_cancel").on("click",function(){
					

						savedept_button_cancel($(this))

				})
				//修改系别--》保存
				$(".savedept_button").on("click",function(){
					savedeptchange($(this))
				})

				$(".deptname_la").on("click",loadclass_info)
			}
			else
			{
				$(".class_mandiv .dept_list").html("<div class='error'>为获取相关信息</div>");
			}
		},
		error:function(){
			$(".class_mandiv .dept_list").html("<div class='error'>为获取相关信息</div>");
		}
	})
}

//系别修改取消点击
function savedept_button_cancel(dom)
{
	dom.parent("div").find(".changedept_button").removeClass("hiden");
	dom.parent("div").find(".savedept_button").addClass("hiden").removeClass("ok")
	dom.addClass("hiden");
	dom.parent("div").find(".deptname_la").removeClass("hiden");
	var a=dom.parent("div").find(".deptname_la").html();
	dom.parent("div").find(".deptname_textbox").addClass("hiden").val(a);
}

//修改系别-->保存
function savedeptchange(dom){

	if(dom.hasClass("ok"))
	{
		var pedtid=dom.parent(".dept_list_div").attr("value");
		var deptname=dom.parent("div").find(".deptname_textbox").val();
		var data={'type':'5.6','系别编号':pedtid,'系别名称':deptname};
		var value=ajax("post","ajax/manerager.aspx",data,false);
		if(value.state=="success")
		{
			alert("修改成功！");
			dom.parent("div").find(".deptname_la").html(deptname);
			

		}
		else if(value.state=="msg")
		{
			alert("已经存在系别名称'"+deptname+"',操作被取消，请稍后再试！")
		}
		else

		{
		
			alert("在修改系别的时候出现错误，请稍后再试！");
		}
		dom.removeClass("ok");
		savedept_button_cancel(dom.next(".changedept_cancel"))

	}
}
//点击修改事件
function changedept_click(dom)
{
	dom.parent("div").find(".savedept_button").removeClass("hiden");
	dom.parent("div").find(".changedept_cancel").removeClass("hiden");
	dom.addClass("hiden");
	dom.parent("div").find(".deptname_la").addClass("hiden");
	dom.parent("div").find(".deptname_textbox").removeClass("hiden")

}
//加载班级
function classlist_load()
{
	$.ajax({
		type:'post',
		url:'ajax/manerager.aspx',
		data:{
			'type':'5'
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")");
			if(json.static=="success")
			{
				
				
				
			}
		},
		error:function(){

		}
	})
}

//点击系别，展开专业列表
function loadclass_info()
{
	var depatid=$(this).attr("value")
	var dom1=$(this).parent(".dept_list_div").next(".class_infodiv");
    if(dom1.hasClass("active"))
    {
    	dom1.slideUp("100").removeClass("active");
    }
	else
	{
		var html="<div class='title'>专业列表：</div>"
		
		html+="<p class='error remintext' >共有<label class='classcount'>0</label>条记录</p>"
		html+="<table class='major_table' cellpadding='0' cellspacing='0'>"
		html+="<tr class='table_head'>"
		html+="<td class='td1'>专业编码</td>"
		html+="<td class='td2'>专业名称</td>"
		html+="<td class='td3'>班级数量</td>"
		html+="<td class='td4'>操作</td>"
		html+="<td class='td5'>状态</td>"
		html+="</tr>"
		html+="<tbody class='list_tbocy'>"
		
		html+="</tbody>"
		html+="<tr class='addmajor'>"
		html+="<td class='td1'><div class='add_icon'>添加</div></td>"
		html+="<td class='td2'><input class='full major_text' type='text'/></td>"
		html+="<td class='td3'></td>"
		html+="<td class='td4'><input class='addmojor_but' type='button' value='添加'/></td>"
		html+="<td class='td5'></td>"
		html+="</tr>"
		html+="</table>"
		html+="<div class='remain_text error clearfix'>"
		html+="<p style='font-size:16px;'>注意事项：</p>"
		html+="<p>1、班级操作需谨慎，容易造成矛盾问题。</p>"
		html+="<p>2、班级只能添加、修改操作，不能删除！因为可能存在班级已有学生加入，删除导致学生没有班级隶属问题！</p>"
		html+="<p>3、班级编号用于唯一标识班级的号码，自动生成，不可更改！</p>"
		html+="<p>4、识别码用于快速别人班级属于那个学院，第几个班级，与学生学号相关联！</p>"
		html+="</div>"

		dom1.html(html);
		
		dom1.slideDown("1000").addClass("active");
		var value=ajax("post","ajax/manerager.aspx",{"type":"5.3","系别编号":depatid},false);
		if(value.state=="success"){
			dom1.find(".classcount").html(value.num);
			var html1="";
			var i=0;
			$(value.data).each(function(){
				html1+="<tr class=";
				html1+=i%2==0?'tr1':'tr2';
				html1+=">";
				html1+="<td class='td1'>"+this.识别码+"</td>"
				html1+="<td class='td2'><div class='full majorname_div'>"+this.专业名称+"</div><input class='full majorname_text hiden' value='"+this.专业名称+"' type='text'/></td>"
				html1+="<td class='td3'>"+this.班级数+"</td>"
				html1+="<td class='td4'><input type='button' class='majorchange_input' maxlength=‘15’ value='修改' id='"+this.专业编号+"'></td>"
				html1+="<td class='td5'><div class='openclose_div full' value='"+this.专业编号+"'>展开"
				html1+="</div></td>"
				html1+="</tr>"
				html1+="<tr class='marjoinfo_tbody'></tr>"
				

				i++;

			})
			dom1.find(".list_tbocy").html(html1);
			$(".majorname_div").dblclick(function(){
				$(this).next("input").removeClass("hiden");
				$(this).addClass("hiden")
			})
			$(".majorname_text").blur(function(){$(this).prev("div").removeClass("hiden");$(this).addClass("hiden")})
			$(".majorname_text").keyup(function(){$(this).prev("div").html($(this).val());$(this).parent("td").parent("tr").find(".majorchange_input").addClass("ok")})
			$(".majorchange_input").click(function(){
				if($(this).hasClass("ok"))
				{
					if(confirm("确定修改专名名称？")==true)
					{
						var text=$.trim($(this).parent("td").parent("tr").find(".majorname_text").val());
						if(text.length>3 && text.length<15)
						{
							$(this).removeClass("ok")
							var value=ajax("post","ajax/manerager.aspx",{"type":"5.4","专业编号":$(this).attr("id"),"专业名称":text},false)
							if(value.state=="success")
							{
								alert("修改成功！");
							}
							else
							{
								alert("修改失败，未做任何修改，请稍后再试！")
							}
						}
						else
						{
							alert("不规范输入！")
						}
						
					}
					else
					{
						alert("未做任何修改！");
					}
				}
				else
				{

				}
			})

			$(".list_tbocy .openclose_div").click(function(){

				var dom =$(this);
				load_classliat(dom)

			})

			
			
		
		}
		else{
			
		}


		$(".major_text").keyup(function(){
				if($.trim($(this).val()).length>2)
				{
					$(this).parent("td").parent("tr").find(".addmojor_but").addClass("ok");
				}
				else
				{
					$(this).parent("td").parent("tr").find(".addmojor_but").removeClass("ok");
				}
			})
			$(".addmajor .addmojor_but").click(function(){
				
				if($(this).hasClass("ok"))
				{
					if(confirm("对于添加的专业信息将不可删除，您确定这么做么？")==true)
					{
						$(this).removeClass("ok")
						var a=$(this).parent("td").parent("tr").find(".major_text").val();
						a=$.trim(a);
						if(a.length>0 && a.length<15)
						{
							var data={"type":"5.5","系别编号":depatid,"专业名称":a};
							var value=ajax("post","ajax/manerager.aspx",data,false);
							if(value.state=="success")
							{
								alert("添加成功！")

								var html2="";
								html2+="<tr class=";
								html2+=$(".list_tbocy tr").length%2==0?'tr2':'tr1';
								html2+=">";
								html2+="<td class='td1'>"+value.识别码+"</td>"
								html2+="<td class='td2'><div class='full majorname_div'>"+a+"</div><input class='full majorname_text hiden' value='"+this.专业名称+"' type='text'/></td>"
								html2+="<td class='td3'>0</td>"
								html2+="<td class='td4'><input type='button' class='majorchange_input' maxlength=‘15’ value='修改' id='"+this.专业编号+"'></td>"
								html2+="</tr>"
								dom1.find(".list_tbocy").append(html2).slideDown("500")
								$(this).parent("td").parent("tr").find(".major_text").val("")
							}
							else if(value.state=="msg")
							{
								alert("已经存在'"+a+"'这个专业，操作被取消！");
								$(this).parent("td").parent("tr").find(".major_text").val("")
							}
							else 
							{
								alert("添加失败，未做任何修改，请稍后再试！")
							}

						}
						else
						{
							alert("输入专业名称不规范！")
						}
					}
					else
					{
						alert("操作已经取消，未做任何改变！")
					}
				}
				else
				{

				}
			})
		var data={"系别编号":depatid,"type":"5",'学年':'null'};
		//loadclass_list(depatid,dom1,data)

		//选择辅导员
		$(".addclass .td7 div").on("click",select_instructor)
		$(".select_instructor").change(function(){
			alert($(this).children("option:selected").attr("value"));
		})

	}

}

//点击专业列表，展开班级列表
function load_classliat(dom)
{
	if(dom.parent("td").parent("tr").next(".marjoinfo_tbody").hasClass("active"))
	{
		dom.parent("td").parent("tr").next(".marjoinfo_tbody").slideUp("200").removeClass("active");
		dom.html("展开");
	}
	else
	{

	
		var html2="";
		
		html2+="<td colspan='5'>"
		html2+="<div class='marjoinfo_div clearfix'>"
		html2+="<h1 class='h1_mojorname'>网络工程</h1>"
		html2+="<div class='clearfix changefoedept_div'>"
		html2+="<label>修改专业隶属：</label>"
		html2+="<select class='pept_select'></select><input class='changedept_but' type='button' value='修改'/>"
		html2+="</div>"

		html2+="<h2 class='h2'>班级列表：</h2>"

		html2+="<div class='classgread_sediv clearfix'><label>年级：</label><select class='gread_select'></select></div>"
		html2+="<table class='classtable' cellspacing='0' cellpadding='0'>"
		html2+="<tr class='thead'>"
		html2+="<td class='ctd1'>班级编码</td>"
		html2+="<td class='ctd2'>年级</td>"
		html2+="<td class='ctd3'>班别</td>"
		html2+="<td class='ctd4'>辅导员</td>"
		html2+="<td class='ctd5'>人数</td>"
		html2+="<td class='ctd6'>操作</td>"
		html2+="</tr>"
		html2+="<tbody class='classlistbody'></tbody>"
		html2+="<tr class='addClass_tr'>"
		html2+="<td class='ctd1'>+</td>"
		html2+="<td class='ctd2'><select class='addgread_select full'><option value='null'>双击选择年级</option></select></td>"
		html2+="<td class='ctd3'><input class='addclassno full' readonly type='text' /></td>"
		html2+="<td class='ctd4'><select class='instructorselect full'><option value='null'>双击选择辅导员</option></select></td>"
		html2+="<td class='ctd5'></td>"
		html2+="<td class='ctd6'><input class='addClass_but' value='添加' type='button'/></td>"
		html2+="</tr>"
		html2+="</table>"
		html2+="</div>"
		html2+="</td>"
		html2+="</tr>"

		dom.parent("td").parent("tr").next(".marjoinfo_tbody").html(html2)
		dom.parent("td").parent("tr").next(".marjoinfo_tbody").slideDown("1000")
		dom.parent("td").parent("tr").next(".marjoinfo_tbody").addClass("active")
		dom.html("关闭");

		var majorid=dom.attr("value");
		var data={'type':'5.7','专业编号':majorid};
		var value=ajax("post","ajax/manerager.aspx",data,false);
		if(value.state=="success")
		{
			var dom1=dom.parent("td").parent("tr").next(".marjoinfo_tbody");
			dom1.find(".h1_mojorname").html(value.专业名称);
			var htmlo="<option value='"+value.系别编号+"'>"+value.系别名称+"</option>";
			$(value.data).each(function(){
				 htmlo+="<option value='"+this.系别编号+"'>"+this.系别名称+"</option>";
			})
			dom1.find(".pept_select").html(htmlo);

			$(".pept_select").change(function(){
				$(this).next(".changedept_but").addClass("ok");
			})

			//修改专业隶属
			$(".changedept_but").on("click",function(){
				if($(this).hasClass("ok"))
				{
					var newdept=dom1.find(".pept_select").children("option:selected").html();
					var dept_id=dom1.find(".pept_select").children("option:selected").attr("value")
					if(confirm("确定修改‘"+value.专业名称+"'的隶属学院改为‘"+newdept+"’")==true)
					{
						var data1={'type':'5.8','系别编号':dept_id,'专业编号':majorid};
						var value1 =ajax('post','ajax/manerager.aspx',data1,false)
						if (value1.state=="success")
						{
							alert("修改成功！")
							load_dept();
						}
						else
						{
							alert("修改失败，未做任何修改，请稍后再试！")
						}
					}
					else
					{

					}
				}
				else
				{}
			})

			var value2=ajax('post','ajax/manerager.aspx',{'type':'5.9','专业编号':majorid},false);
			if(value2.state=="success")
			{
				var html3="";
				$(value2.year).each(function(){
					html3+="<option value='"+this.年级+"'>"+this.年级+"级</option>";
				})
				dom1.find(".gread_select").html(html3);
				var a=dom1.find(".classlistbody");
				var b=value2.year[0].年级;
				var c=majorid;
				loadclasslist(a,b,c)
				dom1.find(".gread_select").change(function(){
					b=$(this).children("option:selected").attr("value");
					loadclasslist(a,b,c)

				})
			}
		}
		else
		{

		}

		//加载年级
		$(".addgread_select").on("dblclick",function(){
			var dom2=$(this);
			loadthisyear(dom2);
			var year=$(this).children("option:selected").attr("value");
			var value2=ajax('post','ajax/manerager.aspx',{'type':'21','年级':year,'专业编号':majorid},false);
			if(value2.state=="success")
			{
				$(this).parent("td").parent("tr").find(".addclassno").val(value2.班别);
				$(this).parent("td").parent("tr").find(".addClass_but").addClass("ok");
			}
			else
			{}
		})

		//获取班级
		$(".addgread_select").change(function(){
			var year=$(this).children("option:selected").attr("value");
			var value2=ajax('post','ajax/manerager.aspx',{'type':'21','年级':year,'专业编号':majorid},false);
			if(value2.state=="success")
			{
				$(this).parent("td").parent("tr").find(".addclassno").val(value2.班别);
			}
			else
			{}
		})
		//加载辅导员
		$(".instructorselect").on("dblclick",function(){
			var dom2=$(this);
			loadinstrinfo(dom2,'null','取消')

		})

		//添加年级
		$(".addClass_tr .addClass_but").click('click',function(){
			if($(this).hasClass("ok"))
			{
				var year=$(".addClass_tr .addgread_select").children("option:selected").attr("value");
				if(year=="null")
				{
					alert("请选择年级");
				}
				else
				{
					var insid=$(".addClass_tr .instructorselect").children("option:selected").val();
					var calssno=$(".addClass_tr .addclassno").val();
					var data2={'type':'22','专业编号':majorid,'辅导员编号':insid,'班别':calssno,'年级':year};
					var value3=ajax('post','ajax/manerager.aspx',data2,false)
					if(value3.state=="success")
					{
						alert("添加成功！");
						var a=dom1.find(".classlistbody");
						var b=year;
						var c=majorid;
						loadclasslist(a,b,c)
					}
					else
					{
						alert("添加失败！未做任何修改，请稍后再试！")
					}
					var html4="";
					html4+="<td class='ctd1'>+</td>"
					html4+="<td class='ctd2'><select class='addgread_select full'><option value='null'>双击选择年级</option></select></td>"
					html4+="<td class='ctd3'><input class='addclassno full' readonly type='text' /></td>"
					html4+="<td class='ctd4'><select class='instructorselect full'><option value='null'>双击选择辅导员</option></select></td>"
					html4+="<td class='ctd5'></td>"
					html4+="<td class='ctd6'><input class='addClass_but' value='添加' type='button'/></td>"
					dom1.find(".addClass_tr").html(html4);
				}
				$(this).removeClass("ok");
			}
			else
			{}

		})
	}
}


//加载今年
function loadthisyear(dom)
{
	var value4=ajax('post','ajax/manerager.aspx',{'type':'19'},false);
	if(value4.state=="success")
	{
		var option="";
		for(var i=0;i<5;i++)
		{
			var year=value4.今年-i;
			option+="<option value='"+year+"'>"+year+"</option>"
		}
		dom.html(option);
	}
}

//加载辅导员列表
function loadinstrinfo(dom,a,b)
{
	var value=ajax('post','ajax/manerager.aspx',{'type':'20'},false);
	var html="";
	if(a=="null")
	{

	}
	else
	{
		 html+="<option value='"+a+"'>"+b+"</option>";
	}
	
	if(value.state=="success")
	{
		
		$(value.data).each(function(){
			html+="<option value='"+this.辅导员编号+"'>"+this.姓名+"("+this.手机号+")</option>"
		})
			html+="<option value='error'>不选择</option>"

	}
	dom.html(html);
}
//用于加载专业中的班级信息
//a 节点信息
//b 年级
//c 专业编号
function loadclasslist(a,b,c)
{
	var data={'type':'6.0','专业编号':c,'年级':b}
	var value=ajax('post','ajax/manerager.aspx',data,false)
	if (value.state=="success") {
		var html="";
		var marjorid=value.识别码;
		$(value.data).each(function(){
			html+="<tr>";
			html+="<td class='ctd1'>"+marjorid+this.班别+"</td>";
			html+="<td class='ctd2'>"+this.年级+"</td>;"
			html+="<td class='ctd3'>"+this.班别+"</td>";
			html+="<td class='ctd4 ";
			html+=this.姓名==""?'error':'';
			html+="'>";
			html+=this.姓名==""?'未分配':this.姓名+"</td>";
			html+="<td class='ctd5'>";
			html+=this.数量==""?"0":this.数量;
			html+="</td>";
			html+="<td class='ctd6'><input class='changeclass' type='button' value='修改' /></td>"
			html+="</tr>"
		})

		a.html(html);

	};
}

//系别--加载系别信息-班级列表
function loadclass_list(depatid,dom,data)
{
	var value=ajax("post","ajax/manerager.aspx",data,false)
		if(value.static=="success")
		{
			

			dom.find(".classcount").html(value.data.length)
			if(value.data1!="error")
			{
				var html="";
				$(value.data).each(function(){
					html+="<tr class='tr1 list'>"
					html+="<td class='td0'>"+this.班级编号+"</td>"
					html+="<td class='td1'>"+this.系别识别码+this.班级识别码+this.班别+"</td>"
					html+="<td class='td2'>"
					html+="<div class='classgread_div full'>"+this.学年+"级</div>"
					html+="<select class='full classgread_select hiden'>"
					html+="<option value='2015'>2015级</option>"
					html+="<option value='2016'>2016级</option>"
					html+="</select>"
					html+="</td>"
					html+="<td class='td3'><div class='classname_div'>"+this.班级名称+"</div><input class='classname_text hiden' value='"+this.班级名称+"'/></td>"
					html+="<td class='td4'>"+this.班别+"班</td>"
					html+="<td class='td7 ";
					html+=this.辅导员==""?"error":"";
					html+="'>"
					html+=this.辅导员==""?"未分配":this.辅导员;
					html+="</dt>"
					html+="<td class='td5'>35</td>"
					html+="<td class='td6'><label class='class_change'>修改</label></td>"
					html+="</tr>"

				});
				dom.find(".list_tbocy").html(html);

			}
		}
}

//加载辅导员选择
function select_instructor()
{
	if (!$(this).hasClass("active"))
	{
		var value=ajax("post","ajax/manerager.aspx",{"type":"5.2"},false)
		if(value.state=="success")
		{
			var html="";
			$(value.data).each(function(){

				html+="<option value='"+this.辅导员编号+"'>"
				html+=this.姓名+"("+this.手机+")";
				html+="</option>";
			})
			html+="<option value='cancel'>取消</option>"
			$(this).next("select").html(html).removeClass("hiden");
			$(this).addClass("active").addClass("hiden")
		}
	}

}



//显示加载添加系别框
function adddept_button_click(){
	$(".add_deptline_div .deptbox_div").removeClass("hiden").show(200)
	$(this).addClass("hiden").hide(0)
}
function addclass_but_click(){
	$(".add_classline_div .calssbox_div").removeClass("hiden").show(200)
	$(this).addClass("hiden").hide(0)
	add_olad_dept()
}
function canceladddept()
{
	$(".add_deptline_div .deptbox_div").addClass("hiden").hide(0)
	$(".add_deptline_div .adddept_button").removeClass("hiden").show(0)
}
function camceladdclass()
{
	$(".add_classline_div .calssbox_div").addClass("hiden").hide(0)
	$(".add_classline_div .addclass_but").removeClass("hiden").show(0)
}

//添加班级中加载系别
function add_olad_dept()
{
		$.ajax({
		type:'post',
		url:'ajax/manerager.aspx',
		data:{
			'type':'4'
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")")
			if(json.static=="success")
			{
				var html="";
				
				$(json.data).each(function(){
					html+="<option dept_id='"+this.系别编号+"'>"+this.系别名称+"</option>"
				})
				$(".dept_select").html(html);
			}
		},
		error:function(){

		}
	})
}

//添加系别
function saveadddept_click(){

	var a=$(".deptbox_div .dept_name").val()
	if($.trim(a).length>2)
	{


		$.ajax({
			type:'post',
			url:'ajax/manerager.aspx',
			data:{
				'type':'6',
				'系别名称':a
			},
			datatype:'json',
			success:function(data){
				var json=eval("("+data+")")
				if(json.static=="success")
				{
					alert("添加成功");
					$(".deptbox_div .dept_name").val("") //清除内容
					$(".deptbox_div .canceladddept_button").click();
					load_dept()

				}
				else if(json.state=="msg")
				{
					alert("已经存在“"+a+"”这个系别，操作已经别取消！");
					$(".deptbox_div .dept_name").val("") //清除内容
					$(".deptbox_div .canceladddept_button").click();
				}
				else
				{
					alert("在添加系别的时候出现错误")
					$(".deptbox_div .dept_name").val("") //清除内容
					$(".deptbox_div .canceladddept_button").click();

				}

			},
			error:function(){
				alert("在添加系别的时候出现错误")
				$(".deptbox_div .dept_name").val("") //清除内容
					$(".deptbox_div .canceladddept_button").click();
			},

		})
	}
	else
	{
		alert("系别名称不能为空")
	}
}


//添加班级，点击保存事件
function saveaddclass_click(){
	var a=$(".calssbox_div .calss_namebox").val()
	var b=$(".calssbox_div .dept_select option:selected").attr("dept_id")

	if($.trim(a).length<3)
	{
		alert("班级名称不能小于两个字")
	}
	else
	{
		$(".calssbox_div .canceladdclass_button").click();
		$.ajax({
			type:'post',  //type有两种，1，get,2、post
			url:'ajax/manerager.aspx',
			data:{
				'type':'7',
				'班级名称':a,
				'系别编号':b
			},
			datatype:'josn' , //datetype 有 1，josn,2、xml，3、html
			success:function(data){
				var json=eval("("+data+")");
				if(json.static=="success")
				{
					alert("添加成功！");
					$(".calssbox_div .calss_namebox").val("")
					//classlist_load();

				}
				else
				{
					alert("在添加班级的时候出现错误")
					$(".calssbox_div .calss_namebox").val("")

				}
			}, //处理成功之后事件
			error:function(){
				alert("在添加班级的时候出现错误")
					$(".calssbox_div .calss_namebox").val("")
			},   //处理失败事件

		})
	}

}

/*加载教师信息*/
function load_teacherinfo()
{
	$.ajax({
		type:'post',
		url:'ajax/manerager.asp',
		data:{
			'typeid':'1',
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")")
			if(json.static="success")
			{
				var html=""
				var a=1
				$(json.data).each(function(){
					html+="<div class='tea_info_line claerfix'><label class='block pull_left'>"+a+"</label>&nbsp&nbsp"
					html+="<label class='la_name'>"+this.姓名+"</label>&nbsp&nbsp"
					html+="<label class='la_zhanghu block pull_left'>"+this.账户+"</label>"
					html+="<input class='changetea_info' type='button'  value='修改'/></div>"
					a++
				})
				$(".teachaerinfo_div").html(html)
			}
		},
		error:function(){

		},

	})	
}


function teaphone_boxblur()
{
	var phone=$(".addteacher_table .teaphone_box").val();
	if(phone.length<11)
	{
		$(".addteacher_table .phone_la").html("手机号不能为空").removeClass("hiden").addClass("error")
	}
	else
	{
		$.ajax({
			type:'post',
			url:'ajax/manerager.asp',
			data:{
				'typeid':'2',
				'phone':phone
			},
			datatype:'json',
			success:function(data){
				var json=eval("("+data+")")
				if(json.static=="error")
				{
					$(".addteacher_table .phone_la").html("手机号已经被注册").removeClass("hiden").addClass("error")
					return false
				}
				else
				{
					$(".addteacher_table .phone_la").addClass("hiden")
					return true
				}
			},
			error:function(){
				alert("在添加教师过程中出现未知错误")
			}
		})
	}
}

/*添加教师信息*/
function addteacher_info()
{
	
		var phone=$(".addteacher_table .teaphone_box").val();
		var name=$(".addteacher_table .teaname_box").val();
		$.ajax({
			type:'post',
			url:'ajax/manerager.asp',
			data:{
				'typeid':'3',
				'name':name,
				'phone':phone
			},
			datatype:'json',
			success:function(data){
				var json =eval("("+data+")")
				if(json.static="success")
				{
					alert("添加成功")
					$(".addteacher_table .teaphone_box").val("");
					$(".addteacher_table .teaname_box").val("")
					load_teacherinfo()
				}
				else
				{
					alert("添加失败")
				}
			},
			error:function(data){
				alert("在添加教师过程中出现未知错误")
			}

		})
	

}



/*点击辅导员列表，加载详情*/
function load_infotbody(){
	  if($(this).next(".info_tbody").hasClass("active"))
	  	{
	  		$(this).next(".info_tbody").find(".info_idv").slideUp(200)
	  		$(this).find(".open_close").removeClass("open").addClass("close")
	  		$(this).next(".info_tbody").removeClass("active")
	  	}
	  	else
	  	{
		var html=""
		    html+="<tr>"
            html+="<td colspan='6'>"
            html+="<div class='info_idv clearfix hiden'>"
            html+="<div class='pull_left idiv_left'>"
            html+="<div class='info_name'>"
            html+="<label class='la1'>姓名：</label>"
            html+="<input type='text' class='name_text' value='"+$(this).find(".td2").html()+"' />"
            html+="<i class=' re_icon ok hiden'></i>"
            html+="<label class='re_text error hiden'>输入出错</label>"
            html+="</div>"
            html+="<div class='info_sex'>"
            html+="<label class='la1'>性别：</label>"
            html+="<input type='radio' name='sex' value='0' class='sex_radio1' "
            html+=$(this).find(".td3").html()=="男"?"checked":""
            html+=" />男"
            html+="<input type='radio' name='sex' value='1' class='sex_radio1' "
            html+=$(this).find(".td3").html()=="女"?"checked":""
            html+="/>女"
            html+="</div>"
            html+="<div class='info_phone'>"
            html+="<label class='la1'>手机号：</label>"
            html+="<input class='phone_text' type='text' maxlength='11' value='"+$(this).find(".td4").html()+"'/>"
            html+="<i class='ph_reicon error hiden'></i>"
            html+="<label class='ph_retext error hiden'>手机号被暂用</label>"
            html+="</div>"
            html+="<div class='info_button'>"
            html+="<div class='info_change pull_left ok1 ok2'>修改</div>"
            html+="<div class='info_repassword pull_left'>恢复密码</div>"
            html+="</div>"
            html+="</div>"
            html+="<div class='pull_left idv_right'>"
            html+="<div class='info_title'>管理的班级：</div>"
            html+="<p>共有<label class='class_num'>"+$(this).find(".td5").html()+"</label>个班级</p>"
            html+="<table class='class_list' cellspacing='0' cellpadding='0'>"
            html+="<tbody class='classlist_tbody'>"
           
            html+="<tbody>"
            html+="<tr class='tr2'>"
            html+="<td class='td1'><i class='add_icon'></i></td>"
            html+="<td class='td2'>"
            html+="<select class='depart_sele'>"
            html+="</select>"
            html+="</td>"
            html+="<td class='td3'>"
            html+="<select class='gread_sele'>"
            html+="</select>"
            html+="<select class='class_sele'>"
            html+="<option value='null'>没有班级可选</option>"
            html+="</select>"
            html+="</td>"
            html+="<td class='td4'><label class='add_la'>添加</label></td>"
            html+="</tr>"
            html+="</tbody>"
            html+="</table>"
            html+="</div>"
            html+="</div>"
            html+="</td>"
            html+="</tr>"
         $(this).next(".info_tbody").html(html);

	  		$(this).next(".info_tbody").find(".info_idv").slideDown(500)
	  		$(this).find(".open_close").removeClass("close").addClass("open")
	  		$(this).next(".info_tbody").addClass("active")
	  	

	  	/*修改辅导员信息*/
	 var id=$(this).attr("value");
	$(".info_idv .info_name .name_text").on("keyup",chengeinsname_keyup).on("focus",chengeinsname_focus).on("blur",chengeinsname_blur);
	$(".info_phone .phone_text").on("keyup",chengeinsphone_keyup).on("focus",chengeinsphone_focus);
	$(".info_phone .phone_text").on("blur",{msg:id},chengeinsphone_blur)
	$(".info_button .info_change").on("click",{msg:id},change_insinfo)
	/*恢复密码点击*/
	$(".info_button .info_repassword").on("click",{msg:id},recover_inspsw)

	/*加载院系*/
	var a=load_college();
	if(a.static=="success")
	{
		var html="<option value='null'>选择院系</option>";
		$(a.data).each(function(){
			html+="<option value='"+this.系别编号+"'>"+this.系别名称+"</option>";

		});
		$(this).next(".info_tbody").find(".class_list .depart_sele").html(html);
	}

	var time =ajax('post','ajax/manerager.aspx',{'type':'15'},false)
	if(time.state=="success")
	{
		var html=""
		var year=time.year;
		for(var i=0;i<5;i++)
		{
			html+="<option>"+(year-i)+"</option>";
		}
		$(".class_list .gread_sele").html(html);
	}

	$(".class_list .depart_sele").change(function(){
		if($(this).children("option:selected").attr("value")!="null")
		{
			var a=$(this).children("option:selected").attr("value");//系别编号
			var b=$(this).parent("td").parent("tr").find(".td3 .gread_sele option:selected").html();

			var data1={'type':'14','系别编号':a,"年级":b}
			var value=ajax('post','ajax/manerager.aspx',data1,false)
			var html="";
			if(value.state=="success")
			{
				
				$(value.data).each(function(){
					html+="<option value='"+this.班级编号+"'>"+this.班级名称+"</option>";
				})
				$(this).parent("td").parent("tr").find(".td4 .add_la").addClass("ok");
			}
			else
			{
				html+="<option value='null'>没有班级可选</option>";
				$(this).parent("td").parent("tr").find(".td4 .add_la").removeClass("ok");
				

			}
			$(this).parent("td").parent("tr").find(".td3 .class_sele").html(html);
		}
		else
		{
			$(this).parent("td").parent("tr").find(".td3 .class_sele").html("<option value='null'>没有班级可选</option>");
			$(this).parent("td").parent("tr").find(".td4 .add_la").removeClass("ok");
		}
	})

	//年级选择事件
	$(".class_list .gread_sele").change(function(){
		if($(this).parent("td").parent("tr").find(".depart_sele").children("option:selected").attr("value")!="null")
		{
			var a=$(this).parent("td").parent("tr").find(".depart_sele").children("option:selected").attr("value");//系别编号
			var b=$(this).children("option:selected").html();

			var data2={'type':'14','系别编号':a,"年级":b}
			var value=ajax('post','ajax/manerager.aspx',data2,false)
			var html="";
			if(value.state=="success")
			{
				
				$(value.data).each(function(){
					html+="<option value='"+this.班级编号+"'>"+this.班级名称+"</option>";
				})
				$(this).parent("td").parent("tr").find(".td4 .add_la").addClass("ok");
			}
			else
			{
				html+="<option value='null'>没有班级可选</option>";
				$(this).parent("td").parent("tr").find(".td4 .add_la").removeClass("ok");
			}
			$(this).parent("td").parent("tr").find(".td3 .class_sele").html(html);
		}
		else
		{
			$(this).parent("td").parent("tr").find(".td3 .class_sele").html("<option value='null'>没有班级可选</option>");
			$(this).parent("td").parent("tr").find(".td4 .add_la").removeClass("ok");
		}
	})
	//班级选择事件
	$(".class_list .class_sele").change(function(){
		if($(this).children("option:selected").attr("value")!="null")
		{
			$(this).parent("td").parent("tr").find(".td4 .add_la").addClass("ok");
		}
		else
		{
			$(this).parent("td").parent("tr").find(".td4 .add_la").removeClass("ok");
		}
	})

	var dom =$(this).next(".info_tbody");
	var root=$(this);
	//添加负责班级
	$(".add_la").click(function(){
		if($(this).parent("td").parent("tr").find(".td3 .class_sele").children("option:selected").attr("value")!="null")
		{
			var classid=$(this).parent("td").parent("tr").find(".td3 .class_sele").children("option:selected").attr("value");
			data={"type":"16","班级编号":classid,"辅导员编号":id}
			var value =ajax("post","ajax/manerager.aspx",data,false);
			if(value.state=="success")
			{
				var i =dom.find(".class_list .classlist_tbody");
				var a=i.find("tr").length+1;
				var b= dom.find(".class_sele").children("option:selected").html();
				var c=dom.find(".gread_sele").children("option:selected").html();
				var d=dom.find(".depart_sele").children("option:selected").html()
				c=c.substr(2,2);
				alert("添加成功！");
				var html="";
				html+="<tr class="
                html+=a%2==0?'tr1':'tr2';
	            html+="><td class='td1'>"+a+"</td>"
	            html+="<td class='td2'>"+d+"</td>"
	            html+="<td class='td3'>"+c+"级"+b+"</td>";
	            html+="<td class='td4'><label class='del_la' value='"+this.班级编号+"'>删除</label></td>"
	            html+="</tr>"
	            i.append(html);
	            dom.find(".class_num").html(""+(parseInt(dom.find(".class_num").html())+1)+"");
	            root.find(".td5").html(""+(parseInt(root.find(".td5").html())+1)+"");



	            if($(this).parent("td").parent("tr").find(".depart_sele").children("option:selected").attr("value")!="null")
				{
					var a=$(this).parent("td").parent("tr").find(".depart_sele").children("option:selected").attr("value");//系别编号
					var b=dom.find(".gread_sele").children("option:selected").html();

					var data2={'type':'14','系别编号':a,"年级":b}
					var value=ajax('post','ajax/manerager.aspx',data2,false)
					var html="";
					if(value.state=="success")
					{
						
						$(value.data).each(function(){
							html+="<option value='"+this.班级编号+"'>"+this.班级名称+"</option>";
						})
						$(this).parent("td").parent("tr").find(".td4 .add_la").addClass("ok");
					}
					else
					{
						html+="<option value='null'>没有班级可选</option>";
						$(this).parent("td").parent("tr").find(".td4 .add_la").removeClass("ok");
					}
					$(this).parent("td").parent("tr").find(".td3 .class_sele").html(html);
				}
				else
				{
					$(this).parent("td").parent("tr").find(".td3 .class_sele").html("<option value='null'>没有班级可选</option>");
					$(this).parent("td").parent("tr").find(".td4 .add_la").removeClass("ok");
				}

			}
			else
			{
				alert("在添加辅导员负责班级的时候出错了，请稍后再试！")
			}
		}
		else
		{

		}
	})

	//加载负责班级
	if($(this).find(".td5").html()>0)
	{
		var data={"type":"17","辅导员编号":id};
		var value=ajax("post","ajax/manerager.aspx",data,false)
		if(value.state=="success")
		{
			var html="";
			var a=1;
			$(value.data).each(function(){
                html+="<tr class="
                html+=a%2==0?'tr1':'tr2';
	            html+="><td class='td1'>"+a+"</td>"
	            html+="<td class='td2'>"+this.系别名称+"</td>"
	            html+="<td class='td3'>"+this.班级名称+"</td>"
	            html+="<td class='td4'><label class='del_la' value='"+this.班级编号+"'>删除</label></td>"
	            html+="</tr>"
	            a++;
			})

			$(this).next(".info_tbody").find(".class_list .classlist_tbody").html(html);
		}
		else
		{
			$(this).next(".info_tbody").find(".class_list .classlist_tbody").html("");
		}
	}


	//删除辅导员负责班级
	 $(".del_la").click(function(){
	 	if(confirm("是否删除该条信息")==true)
	 	{
	 		var classid=$(this).attr("value");
	 		var data={"type":"18","班级编号":classid,"辅导员编号":id};
	 		var value=ajax("post","ajax/manerager.aspx",data,false);
	 		if (value.state=="success")
	 		{
	 			alert("删除成功！");
	 			$(this).parent("td").parent("tr").slideUp("1000").html("");
	 			dom.find(".class_num").html(""+(parseInt(dom.find(".class_num").html())-1)+"");
	            root.find(".td5").html(""+(parseInt(root.find(".td5").html())-1)+"");
	 		}
	 	}
	 	else
	 	{

	 	}
	 })

	  	
     }
}

/*检测辅导员名字正确性*/
function check_insname()
{
	var name=$.trim($(".instructor_mandiv .add_body .addname_text").val());
	if(name=="")
	{
		$(".instructor_mandiv .add_body .name .errortext").html("姓名不能为空");
		$(".instructor_mandiv .add_body .name.errdiv").removeClass("hiden");
		$(".instructor_mandiv .add_body .add_but").removeClass("ok1")
		return false

	}
	else if(name.length<2 || name.length>18)
	{
		$(".instructor_mandiv .add_body .name .errortext").html("姓名长度错误");
		$(".instructor_mandiv .add_body .name.errdiv").removeClass("hiden");
		$(".instructor_mandiv .add_body .add_but").removeClass("ok1")
		return false

	}
	else
	{
		$(".instructor_mandiv .add_body .name.errdiv").addClass("hiden");
		$(".instructor_mandiv .add_body .add_but").addClass("ok1")
		return true
	}
}

/*检测辅导员手机号的正确性*/
function check_insphone()
{
	var phone =$.trim($(".instructor_mandiv .add_body .daaphone_text").val())
	if(phone=="")
	{
		$(".instructor_mandiv .add_body .phone .errortext").html("手机号不能为空");
		$(".instructor_mandiv .add_body .phone.errdiv").removeClass("hiden");
		$(".instructor_mandiv .add_body .add_but").removeClass("ok2")
		return false

	}
	else if(phone.length!=11)
	{
		$(".instructor_mandiv .add_body .phone .errortext").html("手机长度错误");
		$(".instructor_mandiv .add_body .phone.errdiv").removeClass("hiden");
		$(".instructor_mandiv .add_body .add_but").removeClass("ok2")
		return false

	}
	else
	{
        
		
		$(".instructor_mandiv .add_body .phone.errdiv").addClass("hiden");
		$(".instructor_mandiv .add_body .add_but").addClass("ok2");
		phone_ifuse('1',phone)
		return true;
				
				
	}

		

		
	
}

/*电话仅数字输入*/
function phonekeyup()
{
	  var tmptxt=$(this).val();     
  $(this).val(tmptxt.replace(/\D|^0/g,''));     
  if($(this).val().length==11)
  {
  	$(".instructor_mandiv .add_body .add_but").addClass("ok2")
  }
  else
  {
  	$(".instructor_mandiv .add_body .add_but").removeClass("ok2")
  }
   
}
function addname_keyup(){
	var name=$.trim($(".instructor_mandiv .add_body .addname_text").val());
	if(name.length>1)
	{
		$(".instructor_mandiv .add_body .add_but").addClass("ok1")
	}

	else
	{
		$(".instructor_mandiv .add_body .add_but").removeClass("ok1")
	}
}

function insname_focus()
{
	$(".instructor_mandiv .add_body .name.errdiv").addClass("hiden");
}
function insphone_focus()
{
	$(".instructor_mandiv .add_body .phone.errdiv").addClass("hiden");
}
/*添加辅导员*/
function add_instructor(){
	if($(this).hasClass("ok1") && $(this).hasClass("ok2"))
	{
		if(check_insname() && check_insphone())
		{

			$.ajax({
				type:'post',
				url:'ajax/manerager.aspx',
				data:{
					'type':'11',
					'项目':'1',
					'手机号':$(".instructor_mandiv .add_body .daaphone_text").val()
				},
				datatype:'json',
				success:function(data){
					var json=eval('('+data+')');
					if(json.state=="error")
					{
						$(".instructor_mandiv .add_body .phone .errortext").html(json.msg);
						$(".instructor_mandiv .add_body .phone.errdiv").removeClass("hiden");
						$(".instructor_mandiv .add_body .add_but").removeClass("ok2")
						return false
					}
					else
					{
						$(".instructor_mandiv .add_body .add_but").removeClass("ok1").removeClass("ok2");
						var name=$(".instructor_mandiv .add_body .addname_text").val();
						var phone=$(".instructor_mandiv .add_body .daaphone_text").val();
						var sex=$(".instructor_mandiv .add_body .add_sexselect option:selected").attr("value");
						$.ajax({
							type:'post',
							url:'ajax/manerager.aspx',
							data:{
								'type':'8',
								'name':name,
								'phone':phone,
								'sex':sex
							},
							datatype:'json',
							success:function(data){
								var json=eval('('+data+')');
								if(json.state=="success")
								{
									alert("添加成功！");
									//添加成功后要刷新列表
									$(".instructor_mandiv .add_body .addname_text").val("");
									$(".instructor_mandiv .add_body .daaphone_text").val("");
									load_instructor()
								}
							},
							error:function(){
								alert("出现错误")
							}
						})
					}},
				error:function(){
					alert("在判断手机号时出现未知错误，请稍后再试");
				}
		    })
		}
		else
		{

		}
	}
	else
	{

	}
}

/*加载辅导员信息*/
function load_instructor(){
	$.ajax({
		type:'post',
		url:'ajax/manerager.aspx',
		data:{
			'type':'9'
		},
		success:function(data){
			var json=eval('('+data+')')
			if(json.state=="success")
			{
				var a=1;
				var html="";
				$(".instructor_mandiv .ins_number").html(json.count)
				$(json.data).each(function(){


					html+="<tbody class='ins_tbody' value='"+this.辅导员编号+"'>"
					html+="<tr class='"
					html+=(a%2)==0?"tr1":"tr2"
					html+="'>"
					html+="<td class='td1'>"+a+"</td>"
					html+="<td class='td2'>"+this.姓名+"</td>"
					html+="<td class='td3'>"
					html+=this.性别=="0"?"男":"女"
					html+="</td>"
					html+="<td class='td4'>"+this.手机号+"</td>"
					html+="<td class='td5'>"+this.数量+"</td>"
					html+="<td class='td6'>"
					html+="<i class='open_close close'></td>"
					html+="</tr>"
					html+="</tbody>"
					html+="<tbody class='info_tbody'><tr></tr></tbody>"
					a++;
				})
					$(".instructor_mandiv .ins_table .list_tbody ").html(html)
					/*辅导员管理，点击列表，加载详情*/
					$(".ins_table .ins_tbody").on("click",load_infotbody)

					
			}
			if(json.state=="error")
			{
				if(json.msg=="0")
				{

				}
			}
		},
		error:function(){
			
		}
	})
}

/*根据辅导员编号加载辅导员基本信息*/
function load_ins_baseinfo(id)
{
	$.ajax({
		type:'post',
		url:'ajax/manerager.aspx',
		data:{
			'type':'10',
			'辅导员编号':id
		},
		success:function(data){
			var json=eval('('+data+')');
					if(json.state=="error")
					{
						$(".instructor_mandiv .add_body .phone .errortext").html(json.msg);
						$(".instructor_mandiv .add_body .phone.errdiv").removeClass("hiden");
						$(".instructor_mandiv .add_body .add_but").removeClass("ok2")
						return false
					}
					else
					{

					}
		},
		error:function(){}
	})
}

/*判断手机号是否重复*/
function phone_ifuse(a,b)
{
	$.ajax({
		type:'post',
		url:'ajax/manerager.aspx',
		data:{
			'type':'11',
			'项目':a,
			'手机号':b
		},
		success:function(data){
			var json=eval('('+data+')');
					if(json.state=="error")
					{
						$(".instructor_mandiv .add_body .phone .errortext").html(json.msg);
						$(".instructor_mandiv .add_body .phone.errdiv").removeClass("hiden");
						$(".instructor_mandiv .add_body .add_but").removeClass("ok2")
						return false
					}

					else
					{

					}
		},
		error:function(){}
	})
}


/*判断修改辅导员信息*/
function chengeinsname_blur(){
	var a=$.trim($(this).val());
	if(a.length<2){
		$(this).parent(".info_name").find(".re_icon").removeClass("ok").removeClass("hiden").addClass("error");
		$(this).parent(".info_name").find(".re_text").html("不能少于两个字符").removeClass("hiden");
		$(this).parent(".info_name").parent(".idiv_left").find(".info_change").removeClass("ok1")
	}
	else
	{
		$(this).parent(".info_name").find(".re_icon").removeClass("error").removeClass("hiden").addClass("ok");
		$(this).parent(".info_name").find(".re_text").addClass("hiden");
		$(this).parent(".info_name").parent(".idiv_left").find(".info_change").addClass("ok1")
	}
}
function chengeinsname_focus(){
		$(this).parent(".info_name").find(".re_icon").removeClass("error").addClass("hiden").addClass("ok");
		$(this).parent(".info_name").find(".re_text").addClass("hiden");
		//$(this).parent(".info_name").parent(".idiv_left").find(".info_change").removeClass("error")
	
}
function chengeinsname_keyup(){
	var a=$.trim($(".info_idv .info_name .name_text").val());
	if(a.length<2){
		$(this).parent(".info_name").find(".re_icon").removeClass("ok").removeClass("hiden").addClass("error");
		$(this).parent(".info_name").find(".re_text").html("不能少于两个字符").removeClass("hiden");
		$(this).parent(".info_name").parent(".idiv_left").find(".info_change").removeClass("ok1");
	}
	else
	{
		$(this).parent(".info_name").find(".re_icon").removeClass("error").removeClass("hiden").addClass("ok");
		$(this).parent(".info_name").find(".re_text").addClass("hiden");
		$(this).parent(".info_name").parent(".idiv_left").find(".info_change").addClass("ok1")
	}
}

/*判断修改辅导员的手机号*/
function chengeinsphone_keyup(){
	if($.trim($(this).val()).length==11)
	{
		$(this).parent(".info_phone").find(".ph_reicon").removeClass("hiden").addClass("ok").removeClass("hiden").removeClass("error");
	    $(this).parent(".info_phone").parent(".idiv_left").find(".info_change").addClass("ok2")
	}
	
}
function chengeinsphone_focus(){
	$(this).parent(".info_phone").find(".ph_reicon").addClass("hiden")
	$(this).parent(".info_phone").find(".ph_retext").addClass("hiden");
}

function chengeinsphone_blur(id)
{
	var phone=$(this).val();
	var a=$(this)
	if(phone.length<11){
		$(this).parent(".info_phone").find(".ph_retext").html("手机格式错误").removeClass("hiden");
		$(this).parent(".info_phone").find(".ph_reicon").removeClass("hiden").addClass("error").removeClass("ok");
	    $(this).parent(".info_phone").parent(".idiv_left").find(".info_change").removeClass("ok2")

	}
	else
	{
		$.ajax({

			type:'post',
			url:'ajax/manerager.aspx',
			data:{
				'type':'11',
				'项目':'2',
				'辅导员编号':id.data.msg,
				'手机号':phone
			},
			success:function(data){
				var json=eval('('+data+')');
				if(json.state=="error")
				{
					a.parent(".info_phone").find(".ph_retext").html(json.msg).removeClass("hiden");
					a.parent(".info_phone").find(".ph_reicon").removeClass("hiden").addClass("error").removeClass("ok");
				    a.parent(".info_phone").parent(".idiv_left").find(".info_change").removeClass("ok2")
				}
				else
				{
					a.parent(".info_phone").find(".ph_retext").addClass("hiden");
					a.parent(".info_phone").find(".ph_reicon").removeClass("hiden").addClass("ok").removeClass("error");
				    a.parent(".info_phone").parent(".idiv_left").find(".info_change").addClass("ok2");
				}

			},
			error:function(){}
		})
		
	}

}


/*修改辅导员信息*/
function change_insinfo(id){
  if($(this).hasClass("ok1") && $(this).hasClass("ok2"))
  {
  	var a=$(this).parent(".info_button").parent(".idiv_left");

  	 var name=a.find(".info_name .name_text").val();
  	 var sex=a.find(".info_sex .sex_radio1:checked").attr("value");
  	 var phone=a.find(".info_phone .phone_text").val();
  	 var b=id.data.msg;

  	 if(phone.length==11 && name.length>1 && name.length<18)
  	 {


  	 	$.ajax({

			type:'post',
			url:'ajax/manerager.aspx',
			data:{
				'type':'11',
				'项目':'2',
				'辅导员编号':b,
				'手机号':phone
			},
			success:function(data){
				var json=eval('('+data+')');
				if(json.state=="error")
				{
					a.parent(".info_phone").find(".ph_retext").html(json.msg).removeClass("hiden");
					a.parent(".info_phone").find(".ph_reicon").removeClass("hiden").addClass("error").removeClass("ok");
				    a.parent(".info_phone").parent(".idiv_left").find(".info_change").removeClass("ok2")
				}
				else
				{
					/*修改辅导员信息*/
					$.ajax({
						type:'post',
						url:'ajax/manerager.aspx',
						data:{
							'type':'12',
							'手机号':phone,
							'辅导员编号':b,
							'姓名':name,
							'性别':sex
						},
						success:function(data){
							var json=eval('('+data+')');
							if(json.state=="success")
							{
								alert("修改成功！");
								load_instructor();
							}
							else
							{
								alert("不为什么，总之就是出错了！（=.=）");
							}
						},
						error:function(){
							alert("在修改辅导员的时候出现错误，请稍后再试！")
						}
					});
				}

			},
			error:function(){}
		})
  	 }
  	else
  	{
  		alert("码农好懒（=.=），就这么报错了，总之姓名跟手机框输入有问题啦！")
  	}

  }
 
}

/*恢复辅导员密码*/
function recover_inspsw(id){
	var a=id.data.msg;
	if(window.confirm("确定恢复该辅导员密码？"))
	{
		$.ajax({
			type:'post',
			url:'ajax/manerager.aspx',
			data:{
				'type':'13',
				'辅导员编号':a
			},
			datatype:'json',
			success:function(data){
				var json=eval('('+data+')');
				if (json.state=="success") {
					alert("恢复成功！")
				}
				else
				{
					alert("失败！未做任何修改！")
				}
			},
			error:function(){
				alert("总之出错了！");
			}
		})

	}
	else
	{

	}
}

/*加载系别2*/
function load_college()
{

	var value="";
		$.ajax({
			type:'post',
			url:'ajax/manerager.aspx',
			async:false, //设置成同步
			data:{
				'type':'4'
			},
			datatype:'json',
			success:function(data){
				var json=eval("("+data+")")
				value=json;
			},
			error:function(){
				value="{'static':'error'}";
			}

		})
	return value;
			
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
