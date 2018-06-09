$(document).ready(function function_name (argument) {
	// body...
	loading();
	$(".menu_box .menu1").on("click",page_href);
	$(".login_box .text_box.log_phone").on("focus",log_phone_test);
	$(".login_box .text_box.log_phone").on("blur",log_phoneblur);
	$(".login_box .text_box.log_phone").on("keyup",phone_keyup);
	//搜索框
	$(".search_div .search_box").on("focus",search_box_foucus)
	$(".search_div .search_box").on("blur",search_box_blur)
	//点击搜索
	$(".search .search_but").on("click",searchfile_click)


	$('.search_div .register_but').click(function(){
		window.location.href="../page/user_register.aspx";
	})

	/*点击登录*/
	 $(".login_box .login_button").on('click',login);
	 $(".user_static .user_logout").on('click',logout);


 	$(".lohin_but").click(function(){
		//$("body").addClass("over_hiden");
		$(".login_bg").removeClass("hiden");
	})
	$(".login_close").click(function(){
		//$("body").removeClass("over_hiden");
		$(".login_bg").addClass("hiden");
	})

	//点击马上注册
	$(".login_bg .register_now").click(function(){window.location.href="../page/user_register.aspx";})

})

/*获取手机框焦点事件*/
function log_phone_test(){
	$(this).addClass("focus");
	if($(this).val()=="请输入手机号")
	{
		$(this).val("");
	}
	
}
function log_phoneblur(){
	if($.trim($(this).val())=="")
	{
		$(this).val("请输入手机号").removeClass("focus");
	}
}

/*仅限数字输入*/
function phone_keyup()
{
  var tmptxt=$(this).val();     
  $(this).val(tmptxt.replace(/\D|^0/g,''));     
   
}

function loading()
{
	//初次加载确认是否存在session缓存
	/*type:1 请求查看缓存
	       2 请求登录*/
     $.ajax({
     	type:'post',
     	url:"../ajax/index.aspx",
     	data:{
     		'type':'1'
     	},
     	datatype:'json',
     	success:function(data){
     		var json=eval("("+data+")")
     		if(json.static=="success")
     		{
				var img=json.头像位置;
                var name=json.昵称;
                $(".user_static").removeClass("hiden");
                $(".head_logoin_div").addClass("hiden");
                $(".user_static .user_head").attr("src",img);
                $(".user_static .user_name").html(name);
     		}
     	},
     	error:function(){
     		alert("未知错误")
     	}
     })
}

/*请求登录在线*/
function login(){
	var phone= $(".login_box .text_box.phone").val();
    var psw= $(".login_box .text_box.password").val();

    if($.trim(phone)==""|| phone=="请输入手机号")
    {
    	$(".log_phone.remark_text").removeClass("hiden").html("输入手机号").addClass("error")
    }
    if($.trim(psw)=="")
    {
    	$(".remark_text.log_psw").removeClass("hiden").html("输入密码").addClass("error");
    }
    if($.trim(phone)!="" && $.trim(psw)!="" && phone!="请输入手机号")
    {
    	$(".log_phone.remark_text").addClass("hiden");
    	$(".remark_text.log_psw").addClass("hiden");
    
    psw=hex_md5(psw);
	  $.ajax({
                        type: 'post',
                        url: "../ajax/index.aspx",
                        data: {
	                        "type":'2',
	                        "手机号":phone,
	                        "密码":psw   
                        },
                        datatype: "json",
                        success: function (data){
	                        json = eval("(" + data + ")");  
	                        if(json.static=="success")
	                        {
	                        	
	                        	$(".login_bg").addClass("hiden"); 
	                        	$("body").removeClass("over_hiden");
	                        	alert("登录成功");
	                        	loading();
	                        }  
	                        if(json.static=="error")
	                        {
	                        	alert("账户或者密码错误")
	                        }

	                       
                         },
                        error: function (){
                           alert("出现未知错误");
                        }

                    });
}
}
/*退出在线状态*/
function logout(){
	$.ajax({
		type:'post',
		url:'../ajax/index.aspx',
		data:{
			'type':'3'
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")");
			if(json.static=="success")
			{
				alert("退出成功！");
				$(".user_static").addClass("hiden");
				$(".head_logoin_div").removeClass("hiden");
				window.location.href="../index/index.aspx";
			}
		},
		error:function(){
			alert("未知错误");

		}
	})
}

//搜索框获取焦点事件
function search_box_foucus(){
	var text=$(".search_div .search_box").val()
	if(text=="报告/类型/作者")
	   $(this).val("");


}
function search_box_blur(){
	if($.trim($(this).val())=="")
	{
		$(this).val("报告/类型/作者");
	}
}
function searchfile_click(){
	var text=$(".search_div .search_box").val()
	if(text!="报告/类型/作者" && text!="")
	{
		text=encodeURIComponent($(".search_div .search_box").val())
		window.location.href="../page/file_list.aspx?title_text="+text;
	}
	if(text=="报告/类型/作者" || text=="")
	{
		window.location.href="../page/file_list.aspx";
	}

}
//页面跳转
function page_href(){

	var divname=$(this).attr("divname")
	if(divname=="首页")
			{
				window.location.href="../index/index.aspx";
			}
		 else if(divname=="文库")
			{
				window.location.href="../page/file_list.aspx";
			}
		 else if(divname=="新闻")
			{
				window.open("http://news.baidu.com/");
			}
		 else if(divname=="上传")
			{

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
								window.open("../page/user_upload.aspx");
						    }
						     if(json.static=="error")
				            {
				              $(".lohin_but").click();
				            }
					    },
						error:function(){
							alert("未知错误");
						},
		           });

				
			}
		 else if(divname=="我的报告")
			{
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
							window.location.href="../page/user_zoom.aspx";
						    }
						     if(json.static=="error")
				            {
				              $(".lohin_but").click();
				            }
					    },
						error:function(){
							alert("未知错误");
						},
		           });
			}
		 else 
			{
				window.location.href="../index/index.aspx";
			}
}