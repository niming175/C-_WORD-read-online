
$(document).ready(function(){
    $(".addteatype_p .addteatypename").keyup(function(){
        var a=$.trim($(this).val());
        if(a.length>2 &&  a.length<15)
        {
            $(this).next(".addteatype_but").addClass("ok")
        }
        else
        {
            $(this).next(".addteatype_but").removeClass("ok")
        }
    })
    $(".addteatype_p .addteatype_but").on("click",addteachertype)
    $(".teatyin_table .teatype_text").on("dblclick",function(){
         $(this).removeAttr("readonly").addClass("active")
         $(this).parent("td").next("td").find("input").removeClass("hiden")
         $(this).next("label").addClass("hiden")
    })
    $(".teatyin_table .changeteatyepcan").on("click",function(){
       $(this).addClass("hiden");
       $(this).prev(".savetextype_but").removeClass("ok").addClass("hiden");
       $(this).parent("td").prev(".td2").find("label").removeClass("hiden");
       $(this).parent("td").prev(".td2").find("input").attr("readonly","readonly").removeClass("active")
    })
    $(".teatyin_table .teatype_text").keyup(function(){
       var a=$.trim($(this).val())
       
         if(a.length>2 && a.length<15)
         {
            $(this).parent("td").next(".td3").find(".savetextype_but").addClass("ok");
         }
         else
         {
            $(this).parent("td").next(".td3").find(".savetextype_but").removeClass("ok");
         }
    })
   $(".teatyin_table .savetextype_but").on("click",function(){
      if($(this).hasClass("ok"))
      {
         var teatyid=$(this).parent("td").prev(".td2").find(".teatype_text").attr("id");
         var teatyname=$(this).parent("td").prev(".td2").find(".teatype_text").val();
         teatyname=$.trim(teatyname);
         if(teatyname.length>2 && teatyname.length<15)
         {
            changeteatype(teatyid,teatyname)
         }
         
      }
   })

   $(".addteacher-tbody .addteaphone").on("keyup",numinput)
   $(".addteacher-tbody .addteabutton").on("click",addteacher)
})
function loadtea()
{
	loadteachtype()
}
function loadlession()
{
   loadlesstype()
}

/*加载教研室*/
function loadteachtype()
{
	var value=ajax("post","ajax/man-tea.aspx",{'type':'1'},false)
	if(value.state=="success")
	{
		var html="";
		$(value.data).each(function(){
			html+="<li class='teadchertype_li' value='"+this.教研室编号+"'>"+this.教研室名称+"</li>"
		})
		$(".teacher_typediv .teachertype_ul").html(html);

		$(".teadchertype_li").on("click",function(){
			if($(this).hasClass("active"))
			{

			}
			else
			{
				var teatypeid=$(this).attr("value")
				loadteacheatable(teatypeid);
				$(".teadchertype_li").removeClass("active");
				$(this).addClass("active")

			}
			
		})
	}
}

/*添加教研室*/
function addteachertype()
{
   if($(this).hasClass("ok"))
   {
      var typename=$(this).prev(".addteatypename").val();
      typename=$.trim(typename);
      $(this).prev(".addteatypename").val("");
      $(this).removeClass("ok");
      if(typename.length>2 && typename.length<15)
      {
         var value=ajax("post",'ajax/man-tea.aspx',{'type':'9','教研室名称':typename},false);
         if(value.state=="success")
         {
            alert("添加成功！");
            loadteachtype();
         }
         else if(value.state=="msg")
         {
            alert("已将存在教研室'"+typename+"'，操作已经被取消！");

         }
         else
         {
            alert("添加失败，未做任何修改，稍后再试！");
         }
      }
   }
   else
   {}

}

/*修改教研室*/
function changeteatype(teatyid,teatyname){
    var data={'type':'10','教研室编号':teatyid,'教研室名称':teatyname}
    var value=ajax('post','ajax/man-tea.aspx',data,false)
    $(".teatyin_table .changeteatyepcan").click();
    if(value.state=="success")
    {
      alert("修改成功！");
      loadteachtype();
    }
    else if(value.state="msg")
    {
      alert("已经存在'"+teatyname+"'，操作已经被取消！");
    }
    else
      {alert("修改失败，未做任何修改！请稍后再试！")}

}
function loadteacheatable(id){
	$(".teachertypeinfo_div").removeClass("hiden")
   var value=ajax("post","ajax/man-tea.aspx",{'type':'2','教研室编号':id},false)
   if(value.state=="success")
   {
   	$(".teatyin_table .teatype_text").val(value.教研室名称);
      $(".teatyin_table .teatype_text").attr('id',id)
   	$(".teatyin_table .teanum").html(value.人数);
   	if(value.data!="null")
   	{
   		var html="";
   		var i=1;
   		$(value.data).each(function(){
   			html+="<tr value='"+this.教师编号+"' class='ttr ";
   			html+=i%2==0?'ttr1':'ttr2';
   			html+="'>";
   			html+="<td class='td1'>"+i+"</td>";
   			html+="<td class='td2'>"+this.姓名+"</td>";
   			html+="<td class='td3'>"+this.性别+"</td>";
   			html+="<td class='td4'>"+this.手机号+"</td>";
   			html+="<td class='td5'></td>";
   			html+="<td class='td6'></td>";
            html+="</tr>"
            html+="<tr class='teacherinfo_tbody'></tr>"
            i++;
   		});
   		$(".teacher_table .teacherlist_tbody").html(html);

         $(".teacher_table .teacherlist_tbody .ttr").click(function(){
            if($(this).next(".teacherinfo_tbody").hasClass("active"))
            {
               var aa=$(this).next(".teacherinfo_tbody").find(".teacherinfo_div");
               aa.slideUp("200")
               var aa=$(this).next(".teacherinfo_tbody").removeClass("active");
            }
            else
            {
               var teacherid=$(this).attr("value")
               var dom=$(this);
              /*教师详情*/
              loadteacherinfo(dom,teacherid)
            }

         })
   	}
   	else
   	{
   		$(".teacher_table .teacherlist_tbody").html("<tr><td colspan='6' class='error'>没有添加老师</td></tr>");
   	}

      $(".addteacher-tbody .addteaname").val("");
      $(".addteacher-tbody .addteaphone").val(""); 
   }
}

/*加载教师详情*/
function loadteacherinfo(dom,teacherid){

               var html2=" <td colspan='6'>";
               html2+="<div class='teacherinfo_div hiden clearfix'>";
               html2+="<div class='tileft clearfix pull_left'>";
               html2+="<p class='text-p'><label>隶属教研室：</label></p>"
               html2+="<p class='lishujys-p'><select class='jysselect'></select><input class='changejys_but' type='button' value='修改'/>'</p>"
               html2+="<hr/>"
               html2+="<table class='table1'>";
               html2+="<tr >";
               html2+="<td >姓名：</td>";
               html2+="<td><input class='teacher_name' type='text'  value='"+dom.find(".td2").html()+"' maxlength='11'/></td>";
               html2+="<td><label class='error teaname_label hiden'>名字不能为空</label></td>";
               html2+="</tr>";
               html2+="<tr >";
               html2+="<td >性别：</td>";
               html2+="<td><input value'0' class='sexselect_ra' name='teacher_ra' type='radio'";
               html2+=dom.find(".td3").html()=="男"?'checked':'';
               html2+=" />&nbsp 男&nbsp&nbsp&nbsp&nbsp";
               html2+="<input value='1' class='sexselect_ra' name='teacher_ra' type='radio'";
               html2+=dom.find(".td3").html()=="女"?'checked':'';
               html2+=" />&nbsp 女</td>";
               html2+="<td></td>";
               html2+="</tr>";
               html2+=" <tr >";
               html2+="<td >手机号：</td>";
               html2+="<td><input class='teacher_phone' type='text'  value='"+dom.find(".td4").html()+"' maxlength='11'/></td>";
               html2+="<td><label class='error teapho_label error hiden'>手机号被占用</label></td>";
               html2+="</tr>";
               html2+="</table>";
               html2+="<div class='teacher_butdiv clearfix'>";
               html2+="<input class='changetea_but' type='button' value='保存'/>";
               html2+="<input class='repswtea_but' type='button' value='恢复密码'/>";
               html2+="</div>";
               html2+="</div>";
               html2+="<div class='tiright clearfix pull_left'>";
               html2+="<h2>负责的课程</h2>";
               html2+="<table class='lession_table' cellspance='0' cellpaddintg='0'></table>";
               html2+="</div>";
               html2+="</div>";
               html2+="</td>"

               dom.next(".teacherinfo_tbody").html(html2);
               dom.next(".teacherinfo_tbody").find(".teacherinfo_div").slideDown("500");
               dom.next(".teacherinfo_tbody").addClass("active");


               $(".teacherinfo_tbody .teacher_name").val();

               var typename=$(".teatyin_table .teatype_text").val();
               var typeid=$(".teatyin_table .teatype_text").attr("id");
               var option="<option value='"+typeid+"'>"+typename+"</option>";
               var value2=ajax('post','ajax/man-tea.aspx',{'type':'1'},false)
               if(value2.state=="success"){
                  
                  $(value2.data).each(function(){
                     option+="<option value='"+this.教研室编号+"'>"+this.教研室名称+"</option>"
                  })
                  
               }
               dom.next(".teacherinfo_tbody").find(".jysselect").html(option);
               $(".lishujys-p .jysselect").change(function(){
                  $(this).next(".changejys_but").addClass("ok");
               })

               $(".lishujys-p .changejys_but").on("click",function(){
                  if($(this).hasClass("ok"))
                  {
                     var tyid=$(this).prev("select").children("option:selected").attr("value");
                     var data={'type':'12','教研室编号':tyid,'教师编号':teacherid};
                     var value=ajax('post','ajax/man-tea.aspx',data,false)
                     if(value.state=="success")
                     {
                        alert("修改成功！")
                        loadteacheatable(tyid)
                     }
                     else
                     {
                        alert("修改失败，未做任何修改！请稍后再试！")
                     }
                  }
                  
               })
               $(".table1 .teacher_phone").on("keyup",numinput)
               /*点击修改*/
               $(".teacher_butdiv .changetea_but").on("click",function(){
                  var name=$.trim($(".table1 .teacher_name").val());
                  var phone=$.trim($(".table1 .teacher_phone").val());
                  var sex=$(".table1 .sexselect_ra[name='teacher_ra']:checked").attr("value");
                  if(name.length<2 || name.length>15)
                  {
                     //alert("姓名输入有误！");
                     $(".table1 .teaname_label").removeClass("hiden").html("姓名输入有误！")
                  }
                  else
                  {
                     if(phone.length!=11)
                     {
                        $(".table1 .teapho_label").removeClass("hiden").html("手机格式有错！")
                     }
                     else
                     {
                        var data={'type':'13','姓名':name,'手机':phone,'性别':sex,'教师编号':teacherid}
                        var value=ajax('post','ajax/man-tea.aspx',data,false);
                        if(value.state=="success")
                        {
                           alert("修改成功！")
                           loadteacheatable(typeid);
                        }
                        else if(value.state=="msg")
                        {
                           $(".table1 .teapho_label").removeClass("hiden").html("手机已经注册")
                        }
                        else
                        {
                           alert("修改失败，未做任何修改！请稍后再试！")
                        }
                     }
                  }
               })
               /*恢复密码*/
               $(".teacher_butdiv .repswtea_but").on("click",function(){
                  if(confirm("确定恢复该老师的密码？")==true)
                  {
                     var value=ajax('post','ajax/man-tea.aspx',{'type':'14','教师编号':teacherid},false)
                     if(value.state=="success")
                     {
                        alert("恢复密码成功！");
                     }
                     else
                     {
                        alert("修改失败，未做任何修改！请稍后再试！")
                     }
                  }
               })

               /*加载负责课程*/
               var dom1=dom.next(".teacherinfo_tbody").find(".tiright .lession_table")
               loadtealesson(dom1,teacherid)


            
}
/*加载科目类别*/
function loadlesstype()
{
   var value=ajax("post","ajax/man-tea.aspx",{'type':'3'},false)
   if(value.state=="success")
   {  var html="";
      var i=1;
      $(value.data).each(function(){
         html+="<p class='lesstype_p'>";
            html+="<label>"+i+":</label>";
            html+="<input class='lesstype_text ok' type='text' readonly value='"+this.科目类型名称+"' id='"+this.科目类型编号+"' />";
            html+="<input class='savelesschange hiden' type='button' value='保存'/>";
            html+="<input class='changelesstype' type='button' value='修改'/></label>";
            html+="</p>";
            html+="<div class='lessiondiv clearfix hiden '>";
            html+="</div>"
            i++;
      })
      $(".lessiontypelist").html(html);
      $(".lessiontypelist .lesstype_text").on("click",function(){
         if($(this).hasClass("ok"))
         {


            var dom=$(this).parent("p").next(".lessiondiv");
            if(dom.hasClass("active"))
            {
               dom.slideUp("200").removeClass("active");
            }
            else
            {
               var html2="";
               html2+=" <h3>科目：</h3>";
               html2+="<br />";
               html2+="<table class='lessiontable' cellspacing='0' cellpadding='0'>";
               html2+="</table>";
               html2+="<p>添加：</p>";
               html2+="<p class='addless-p'><input class='addlession' type='text'/><input class='addlessionbut' type='button' value='添加'/></p>"
               
               dom.html(html2).slideDown("500").addClass("active")
               var lessid=$(this).attr("id");
               loadlesslist(dom,lessid)

               $(".addless-p .addlessionbut").on("click",function(){
                  var a=$.trim($(this).prev(".addlession").val());
                  if(a.length>2 && a.length<20)
                  {
                     var data={'type':"7","科目类型编号":lessid,"科目名称":a};
                     var value=ajax('post','ajax/man-tea.aspx',data,false);
                     if(value.state=="success")
                     {
                        alert("添加成功！");
                         loadlesslist(dom,lessid)
                     }
                     else if(value.state=="msg")
                     {
                        alert("已经存在科目'"+a+"',操作被取消！")
                     }
                     else
                     {
                        alert("添加失败，未做任何修改，稍后再试！")
                     }
                     $(this).prev(".addlession").val("")
                  }
               })
            }
         }
         else
         {}
      })
      $(".changelesstype").on("click",function(){
         if($(this).hasClass("active"))
         {
            $(this).val("修改").removeClass("active");
            $(this).prev("input").addClass("hiden");
            $(this).parent("p").find(".lesstype_text").attr("readonly","readonly").addClass("ok")
         }
         else
         {
            $(this).val("取消").addClass("active");
            $(this).prev("input").removeClass("hiden");
            $(this).parent("p").find(".lesstype_text").removeAttr("readonly").focus().removeClass("ok");

         }
      })
      $(".lesstype_text").on("keyup",function(){
         var a=$.trim($(this).val());
         if(a.length>2 && a.length<15)
         {
            $(this).next(".savelesschange").addClass("ok")
         }
         else
         {
            $(this).next(".savelesschange").removeClass("ok")
         }
      })
      $(".savelesschange").on("click",function(){
         if($(this).hasClass("ok"))
         {
            var a=$.trim($(this).prev(".lesstype_text").val());
            var b=$(this).prev(".lesstype_text").attr("id");
               var data={'type':'5','科目类型编号':b,'科目类型名称':a}
               var value=ajax('post','ajax/man-tea.aspx',data,false)
               if(value.state=="success")
               {
                  alert("修改成功！");
                  $(this).prev(".lesstype_text").addClass("ok").attr("readonly","readonly");
                  $(this).parent("p").find(".changelesstype").click();
               }
               else if(value.state=="msg")
               {
                  alert("已经存在'"+a+"'这个类型，操作已经被取消，未做任何修改！");
                  $(this).parent("p").find(".changelesstype").click();
               }
               else
               {
                   alert("修改失败，未做任何修改！请稍后再试！");
                  $(this).parent("p").find(".changelesstype").click();
               }
         }
      })
   }
   else

   {
      $(".lessiontypelist").html("<p class='error'>没有该信息</div>");
   }
}

/*加载科目类型详情*/
function loadlesslist(dom,id)
{
   var value=ajax("post","ajax/man-tea.aspx",{'type':'4','科目类型编号':id},false)
   if(value.state=="success")
   {
      var html="";
      var i=1;
      $(value.data).each(function(){
         html+="<tr class='tr1'>";
            html+="<td class='td1'>"+i+":</td>";
            html+="<td class='td2'><input class='full lessionname' type='text' value='"+this.科目名称+"' readonly /></td>";
            html+="<td class='td3'><input class='changelession hiden' type='button' value='保存' id='"+this.科目编号+"'/><input class='error changelessioncancel' type='button' value='修改' /></td>";
            html+="</tr>";
            i++;
      })
      dom.find(".lessiontable").html(html);
      $(".changelessioncancel").on("click",function(){
         var a=$(this).parent("td").parent("tr");
         if($(this).hasClass("active"))
         {
            $(this).val("修改").removeClass("active");
            a.find(".lessionname").attr("readonly","readonly");
            a.find(".changelession").addClass("hiden");
         }
         else
         {
            $(this).val("取消").addClass("active");
            a.find(".lessionname").removeAttr("readonly").focus();
            a.find(".changelession").removeClass("hiden");
         }
         
      })
      $(".lessiontable .lessionname").keyup(function(){
         var a=$(this).val();
         a=$.trim(a);
         if(a.length>2 && a.length<20)
         {
            $(this).parent("td").parent("tr").find(".changelession").addClass("ok")
         }
         else
         {
            $(this).parent("td").parent("tr").find(".changelession").removeClass("ok")
         }
      })
      $(".lessiontable .changelession").click(function(){
         var lessname=$(this).parent("td").parent("tr").find(".lessionname").val();
         lessname=$.trim(lessname)
         var data={'type':'8','科目编号':$(this).attr("id"),'科目名称':lessname,'科目类型编号':id};
         var value=ajax('post','ajax/man-tea.aspx',data,false)
         if(value.state=="success")
         {
            alert("修改成功！");
            $(this).next(".changelessioncancel").click();
         }
         else if (value.state=="msg") {
            alert("科目'"+lessname+"'已经存在，操作被取消！")
         }
         else
            {alert("修改失败，未做任何修改！请稍后再试！");$(this).next(".changelessioncancel").click();}
         
         
      })

   }
   else
   {
      dom.find(".lessiontable").html("<tr><td colspan='3' class='error'>暂时没有该项目</td></tr>");
   }
}

function loadtealesson(dom,id)
{
   var value=ajax('post','ajax/man-tea.aspx',{'type':'15','教师编号':id},false);
   var html="<tr class='tahead'>";
      html+="<td class='ttd0'>编号</td>"
      html+="<td class='ttd1'>类型</td>"
      html+="<td class='ttd2'>科目</td>"
      html+="<td class='ttd3'>状态</td>"
      html+="<td class='ttd4'>操作</td>"
      html+="</tr>";
   if(value.state=="success")
   {
      var i=1;
      $(value.data).each(function(){
         
         html+="<tr class='tr1'>"
         html+="<td>"+i+"</td>"
         html+="<td>"+this.科目类型名称+"</td>"
         html+="<td>"+this.科目名称+"</td>"
         html+="<td class='ttd3 ";
         html+=this.状态=="1"?'ok':'error'
         html+="'>";
         html+=this.状态=="1"?"正常":"停用";
         html+="</td>"
         html+="<td value='"+this.课任编号+"'><input class='deletetealess' type='button' value='删除' />"
         html+=this.状态=="1"?"<input class='stoplesson' type='button'  value='停用' />":"<input class='uselesson' type='button' value='启用'>";
         html+="</td>"
         html+="</tr>";
         i++;
      })
   }
   else
   {
      html+="<tr><td colspan='4' class='error center '>未分配课程</td></tr>"
   }
   html+="<tr class='addtealess'>";
   html+="<td>+</td>";
   html+="<td><select class='selectlesstype'><option>添加选择</option></select></td>";
   html+="<td><select class='selectless'><option></option></select></td>";
   html+="<td  colspan='2' class='center'><input class='addtealess_but' type='button' value='添加' /></td></tr>";

   dom.html(html);
   dom.find(".selectlesstype").click(function(){
      if($(this).hasClass("active"))
      {}
      else
      {
         var value=ajax('post','ajax/man-tea.aspx',{'type':'3'},false)
         if(value.state=="success")
         {
            var option="";
            $(value.data).each(function(){
               option+="<option value='"+this.科目类型编号+"'>"+this.科目类型名称+"</option>"
            })
            $(this).html(option).addClass("active");
            var dom2=$(this).parent("td").next("td").find("select");
            lessonsselect(dom2,value.data[0].科目类型编号)
            $(this).parent("td").parent("tr").find(".addtealess_but").addClass("ok")

         }
      }
   })
   dom.find(".selectlesstype").change(function(){
      var dom2=$(this).parent("td").next("td").find("select");
      var id=$(this).children("option:selected").attr("value");
       lessonsselect(dom2,id)
   })

   dom.find(".addtealess_but").click(function(){
      if($(this).hasClass("ok"))
      {
         var lessid=dom.find(".selectless").children("option:selected").attr("value");
         if(lessid=="null")
         {
            alert("请选择科目")
         }
         else
         {
            var data={'type':'16','教师编号':id,'科目编号':lessid};
            var value=ajax('post','ajax/man-tea.aspx',data,false);
            if(value.state=="success")
            {
               alert("添加成功！");
               loadtealesson(dom,id)

            }
            else if(value.state=="msg")
            {
               alert("已经为这位老师添加了这个科目，操作被取消")

            }
            else
            {
               alert("添加失败，未做任何修改，稍后再试！");
            }
         }
      }
   })
   /*停用课程*/
   dom.find(".stoplesson").click(function(){
      if(confirm("确定停用该教师负责课程？")==true)
      {
         var lessid=$(this).parent("td").attr("value");
         var value=ajax('post','ajax/man-tea.aspx',{'type':'17','课任编号':lessid},false);
         if(value.state=="success")
         {
            alert("停用成功！");
            loadtealesson(dom,id)

         }
         else
         {
            alert("修改失败，未做任何修改！请稍后再试！")
         }
      }
   })

   /*启动课程*/
   dom.find(".uselesson").click(function(){
      if(confirm("确定启用该教师负责课程？")==true)
      {
         var lessid=$(this).parent("td").attr("value");
         var value=ajax('post','ajax/man-tea.aspx',{'type':'18','课任编号':lessid},false);
         if(value.state=="success")
         {
            alert("启用成功！");
            loadtealesson(dom,id)

         }
         else
         {
            alert("启用失败，未做任何修改！请稍后再试！")
         }
      }
   })


}

//加载科目选择
function lessonsselect(dom,id)
{

   var value=ajax("post","ajax/man-tea.aspx",{'type':'4',"科目类型编号":id},false)
   var html="";
   if(value.state=="success")
   {
      $(value.data).each(function(){
         html+="<option value='"+this.科目编号+"'>"+this.科目名称+"</option>"
      })

   }
   else
   {
      html+="<option value='null'>没有</option>"
   }
   dom.html(html)

}
/*添加教师*/
function addteacher()
{
   var dom=$(this).parent("td").parent("tr");
   var teachername=$.trim(dom.find(".addteaname").val());
   var phone=$.trim(dom.find(".addteaphone").val());
   var typeid=$(".teatyin_table .teatype_text").attr("id")
   var sex=dom.find(".teasexselect").children("option:selected").attr("value");
   if(teachername.length<2 || teachername.length>15)
   {
      alert("教师名称输入有误！")
   }
   else
   {
      if (phone.length!=11) {alert("手机号格式有误")}
      else
      {
         var data={'type':'11','教研室编号':typeid,'姓名':teachername,'手机号':phone,'性别':sex};
         var value=ajax("post",'ajax/man-tea.aspx',data,false);
         if(value.state=="success")
         {
            alert("添加成功！");
            loadteacheatable(typeid)
         }
         else if(value.state=="msg")
         {
            alert("手机号：“"+phone+"”已经被注册，请更换手机号后再试！");
            dom.find(".addteaphone").focus();
         }
         else
         {
            alert("添加失败，未做任何修改，稍后再试！");
            dom.find(".addteaname").val("");
            dom.find(".addteaphone").val("");


         }
      }
   }

}

/*数字输入正则*/
function numinput()
{
   var tmptxt=$(this).val();     
   $(this).val(tmptxt.replace(/\D|^0/g,''));  
}