$(document).ready(function function_name (argument) {
	// body..
	document.title="上传文档";
	isonline();
	$(".select_botton").click(function(){
		$(".select_file").click();
	})

	load()
	$(".upload_table .file_name_box").on("blur",file_name_blur)
	$(".upload_table .file_lable_box").on("blur",file_lable_blur)
	$(".upload_table .file_area").on("blur",file_area_blur)
	$(".upload_table .file_area").on("keyup",file_area_keyup)
	$(".button_box .upload_button").on("click",file_upload)
})
var type_id=null;  //类型编号

function load(){
	$.ajax({
		type:'post',
		url:'../ajax/user_upload.aspx',
		data:{
			'type':'1',
		},
		datatype:'json',
		success:function(data){
			var json=eval("("+data+")");
			var option="";
			if(json.static=="success")
			{
				$(".fiel_type").html("");
				var option="";
				$(json.data).each(function(){
					option+="<option valueid='"+this.分类编号+"'>";
					option+=this.类型;
					option+="</option>";
				})
				$(".fiel_type").html(option);
				type_id=$(".fiel_type").children("option").attr("valueid");
				$(".fiel_type").change(function(){
	                        		type_id=$(this).children("option:selected").attr("valueid");
	                        	})
			    
			}

		},
		error:function(){
			alert("error")
		}
	})
}
function file_name_blur()
{
	var str=$(".upload_table .file_name_box").val();
	if($.trim(str)=="" || $.trim(str).length==0)
	{
		$(".upload_remark.file_name").html("文档标题不能为空！").addClass("error").removeClass("hiden");
		return false;
	}
	else{
		$(".upload_remark.file_name").addClass("hiden");
		return true;
	}
}
/*标签失去焦点*/
function file_lable_blur(){
	if($.trim($(".upload_table .file_lable_box").val())=="" || $.trim($(".upload_table .file_lable_box").val()).length<2)
	{
		$(".remark.file_lable").html("请输入标签").addClass("error").removeClass("hiden");
		return false
	}
	else
	{
		$(".remark.file_lable").addClass("hiden");
		return true
	}
}

/*概述失去焦点*/
function file_area_blur(){
	var str= $(".upload_table .file_area").val();
	if($.trim(str)=="")
	{
		$(".file_area_label.remark").html("请输入概述").addClass("error").removeClass("hiden");
		return false
	}
	else
	{
		$(".file_area_label.remark").addClass("hiden")
		return true
	}
}
function file_area_keyup(){
	var a=70;
	var b=$(".upload_table .file_area").val().length;
	$(".file_area_label.remark").addClass("hiden")
	$(".upload_table .file_area_num").html("剩余"+(a-b)+"个字数");
}



/*点击上传*/
function file_upload(){

		if(file_name_blur() && file_lable_blur() && file_area_blur())
		{
			
			var file_name=$(".upload_table .file_name_box").val();
			var label_text=$(".upload_table .file_lable_box").val();
			var gaishu=$(".upload_table .file_area").val();
			$(".upload_bd").removeClass("hiden");
			var fromData=new FormData();
							fromData.append('file',document.getElementById("file").files[0]) 
							fromData.append('type','1')
							$.ajax({
								    url: '../ajax/upload.aspx',
								    type: 'POST',
								    cache: false,
								    data: fromData,
								    processData: false,
								    contentType: false
								}).done(function(data) {
									var json=eval("("+data+")")
									/*文件上传成功后执行插入书库库*/
									if(json.static=="success")
									{
										var docpath=json.文档位置;
										var htmlpath=json.网页位置;
										$.ajax({
											type:'post',  //为更新数据库
											url:'../ajax/user_upload.aspx',
											data:{
												'type':'2',
												'文件位置':docpath,
												'标题':file_name,
												'标签':label_text,
												'概述':gaishu,
												'分类编号':type_id,
												'网页位置':htmlpath
											},
											datatype:'json',
											success:function(data){
												var json=eval("("+data+")");
												if(json.static=="success")
												{
													$(".upload_bd .loding_la").html("上传成功").removeClass("error");
														setTimeout(function(){
															$(".upload_bd").fadeOut(300);
														},1500);

												}
												if(json.static=="error")
												{
													$(".upload_bd .loding_la").html(json.message).addClass("error");
														setTimeout(function(){
															$(".upload_bd").fadeOut(300);
														},1500);
												}
											},
											error:function(){
												$(".upload_bd .loding_la").html("未知错误").addClass("error");
														setTimeout(function(){
															$(".upload_bd").fadeOut(300);
														},1500);
											}
										})
									}
									if(json.static=="error")
									{
										$(".upload_bd .loding_la").html(json.message).addClass("error");
										setTimeout(function(){
											$(".upload_bd").fadeOut(300);
										},2000);

									}
									
								}).fail(function(res) {
									$(".upload_bd .loding_la").html("您的浏览器版本过低，不支持上传").addClass("error");
									setTimeout(function(){
															$(".upload_bd").fadeOut(300);
														},1500);
								});
		}
		else
		{

		}

	
					
}

//判断是否在线
function isonline()
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
								return true;
						    }
						     if(json.static=="error")
				            {
				            	window.location.href="../index/index.aspx";
				               return false;
				            }
					    },
						error:function(){
							alert("未知错误");
						},
		           });
}
