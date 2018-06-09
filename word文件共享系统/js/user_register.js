$(document).ready(function(){
	load();
	$(".tr_button .re_button").on("click",register);
	$(".phone.textbox").on("keyup",phone_test);
	$(".phone.textbox").on("blur",re_phone_test);
	$(".username.textbox").on("blur",user_name_test);
	$(".real_username.textbox").on("blur",real_username_test);
	$(".password.textbox").on("blur",password_test);
	$(".confirm_password.textbox").on("blur",confirm_password_test)
	$(".check_div .checkbox").on("click",checkbox_click)



	$(".td_div .label").click(function(){
		if($(".protocol_div").hasClass("hiden"))
		{
			$(".protocol_div").show(500);
			$(".protocol_div").removeClass("hiden")
		}
	})
	$(".pro_head .head_close").click(function(){
		$(".protocol_div").addClass("hiden");
		$(".protocol_div").fadeOut(300);
		});
	
})


/*定义全局变量，用于采集用户信息*/
var user_name=null;  //昵称
var real_name=null;  //真实姓名
var psw=null;
var phone=null;
var grade=null;
//初次加载
//加载系别列表，默认加载班级列别
//通过点击选择系别，班级列表产生变化
function load(){
	$.ajax({
						type: 'post',
				        url: "../ajax/user_register.aspx",
                        data: {
                        "type":"1"
               
                        },
                        datatype: "json",
                        success: function (data){
                        	var a="";
                        	var json=eval("(" + data + ")");

                            if(json.static=="success")
                            {
                            	$(".select.department").html("");
                            	var option=""
                            	$(json.data).each(function(){
                            	option+="<option valueid='"+this.系别编号+"'>"
                        		option+=this.系别;
                        		option+="</option>"
	                        	})
	                        	$(".select.department").html(option);
	                        	var depar_id=$(".select.department").children("option").attr("valueid")
								banji_load(depar_id);
	                        	$(".select.department").change(function(){
	                        		var dapar_id1=$(this).children("option:selected").attr("valueid");
	                        		banji_load(dapar_id1);
	                        	})
                        	}
                       // 
				       
						},
						error:function(){
							alert("error")
						},
	})
}

/*加载班级*/
function banji_load(depar_id){
	$.ajax({
		type:"post",
		url: "../ajax/user_register.aspx",
		data:{
			'type':'2',
			'系别编号':depar_id
		},
		datatype:"json",
		success:function(data){
			var json=eval("(" + data + ")");
			 if(json.static=="success")
                            {
                            	$(".select.grade").html("");
                            	var option=""
                            	$(json.data).each(function(){
                            	option+="<option valueid='"+this.班级编号+"'>"
                        		option+=this.班级名称;
                        		option+="</option>";
	                        	})
	                        	$(".select.grade").html(option);
	                        	grade=$(".select.grade").children("option").attr("valueid");
	                        	$(".select.grade").change(function(){
	                        		grade=$(this).children("option:selected").attr("valueid");
	                        	})
	                        }
                        	


		},
		error:function(){
			alert("error")

		}
	})
}

/*电话框验证*/
function phone_test()
{
  var tmptxt=$(this).val();     
  $(this).val(tmptxt.replace(/\D|^0/g,''));     
   
   
}


/*电话框失去焦点判断*/
function re_phone_test(){
	var re_phone=$(".phone.textbox").val();
	if(re_phone.length==11)
	{
		

		$.ajax({
			type:'post',
			url:'../ajax/user_register.aspx',
			data:{
				'type':'4',
				'phone':re_phone
			},
			datatype:'json',
			success:function(data){
				var json=eval("("+data+")");
				if(json.static=="success")
				{
					if(json.i=="1")
					{
						$(".ok_icon.phone").addClass("hiden");
						$(".lb_remark.phone").addClass("error").removeClass("hiden").html("该手机号已经被注册");
						return false;
					}
					if(json.i=="0")
					{
						$(".ok_icon.phone").removeClass("hiden");
						$(".lb_remark.phone").addClass("hiden");
						return true;
					}

				}

			},
			error:function(){
				return false;
			}

		})

	}
	else
	{
		$(".ok_icon.phone").addClass("hiden");
		$(".lb_remark.phone").addClass("error").removeClass("hiden").html("手机格式错误");
		return false;
	}
}

/*真实姓名失去焦点判断*/
function real_username_test(){
	var str=$(".real_username.textbox").val();
	var str1=$.trim(str);
	if(str1.length<2)
	{
		$(".ok_icon.real_name").addClass("hiden");
		$(".lb_remark.real_name").html("请输入真实姓名").addClass("error").removeClass("hiden");
		return false;
	}
	else
	{
		$(".ok_icon.real_name").removeClass("hiden");
		$(".lb_remark.real_name").addClass("hiden");
		return true;
	}
}
/*昵称框失去焦点判断*/
function user_name_test(){
    var str=$(".username.textbox").val();
	if($.trim(str)=="")
	{
		$(".ok_icon.user_name").addClass("hiden");
		$(".lb_remark.username").html("请输入昵称").addClass("error").removeClass("hiden");
		return false;

	}
	else
	{
		$(".ok_icon.user_name").removeClass("hiden");
		$(".lb_remark.username").addClass("hiden");
		return true;
	}
}

/*密码框失去判断*/
function password_test(){
	var str=$(".password.textbox").val();
	if(str.length<6)
	{
		$(".ok_icon.password").addClass("hiden");
		$(".lb_remark.password").html("密码不能少于6个字符！").addClass("error").removeClass("hiden");
		return false;
	}
	else
	{
		$(".ok_icon.password").removeClass("hiden");
		$(".lb_remark.password").addClass("hiden");
		return true;
	}
	
}

/*确认密码失去焦点*/
function confirm_password_test(){
	var str=$(".confirm_password").val();
	if($(".textbox.password").val()!=str || str.length<6)
	{
		$(".ok_icon.confirm_password").addClass("hiden");
		$(".lb_remark.confirm_password").html("与密码不一致").addClass("error").removeClass("hiden");
		return false;
	}
	else
	{
		$(".ok_icon.confirm_password").removeClass("hiden");
		$(".lb_remark.confirm_password").addClass("hiden");
		return true;

	}
}

/*chaecked点击*/
function checkbox_click(){
	if($(this).attr('checked'))
	{
		$(this).removeAttr('checked')
	}
	else
	{
		$(this).attr('checked',true)
	}
	
}
function checkbox_test(){
	if($(".check_div .checkbox").attr('checked'))
	{
		
		$(".lb_remark.agree_box").addClass("hiden");
		return true;
	}
	else
	{
		$(".lb_remark.agree_box").removeClass("hiden").addClass("error");
		return false;
	}

}
/*注册*/
function register(){

	var re_phone=$(".phone.textbox").val();
	if(re_phone.length==11)
	{
		

		$.ajax({
			type:'post',
			url:'../ajax/user_register.aspx',
			data:{
				'type':'4',
				'phone':re_phone
			},
			datatype:'json',
			success:function(data){
				var json=eval("("+data+")");
				if(json.static=="success")
				{
					if(json.i=="1")
					{
						$(".ok_icon.phone").addClass("hiden");
						$(".lb_remark.phone").addClass("error").removeClass("hiden").html("该手机号已经被注册");
						return;
					}
					if(json.i=="0")
					{
						$(".ok_icon.phone").removeClass("hiden");
						$(".lb_remark.phone").addClass("hiden");
						

						if( user_name_test() && real_username_test() && password_test() &&   confirm_password_test() &&  checkbox_test())
						{
							
									user_name=$(".username.textbox").val();
									real_name=$(".real_username.textbox").val();
								    psw=$(".password.textbox").val();
								    phone=$(".phone.textbox").val();
								    var hash_psw= hex_md5(psw); //转换为md5加密
								    $.ajax({
								    	type:'post',
								    	url:'../ajax/user_register.aspx',
								    	data:{
								    		'type':'3',
								    		'user_name':user_name,
								    		'real_name':real_name,
								    		'phone':phone,
								    		'hash_psw':hash_psw,
								    		'grade':grade
								    	},
								    	datatype:'json',
								    	success:function(data){
								    		var json=eval("("+data+")");
								    		if(json.static=="success")
								    		{
								    			alert("注册成功,正在跳转....");
								    			window.location.href="../index/index.aspx";
								    		}
								    		else
								    		{
								    			alert("出现错误，请稍后再试");
								    			$(".textbox").val("");
								    		}

								    	},
								    	error:function(){
								    		alert("出现错误");
								    		$(".textbox").val("");
								    	}
								    })
								

						}
						else
						{
							return;
						}



					}

				}
				else return;

			},
			error:function(){
				return ;
			}

		})

	}
	else
	{
		$(".ok_icon.phone").addClass("hiden");
		$(".lb_remark.phone").addClass("error").removeClass("hiden").html("手机格式错误");
		return ;
	}

}

