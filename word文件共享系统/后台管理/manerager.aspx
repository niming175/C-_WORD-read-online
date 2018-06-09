<%@ Page Title="" Language="C#" MasterPageFile="~/后台管理/bg_manerge.master" AutoEventWireup="true" CodeFile="manerager.aspx.cs" Inherits="后台管理_manerager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/manerager.css" rel="stylesheet" type="text/css" />
    <script src="js/manerager.js" type="text/javascript"></script>
    <script src="js/manerage_tea.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="man_content clearfix">
 <div class="left pull_left">

 <div class="head_title">
 <h1> 管理员管理</h1>
 </div>
 <div class="head2">
  <h2>您好：管理员</h2>
 </div>

    <div class="meau_list">
        <div class="menulist active" divname="1">文档类型管理</div>
        <div class="menulist" divname="2">系别班级管理</div>
        <div class="menulist" divname="3">教师信息管理</div>
        <div class="menulist" divname="4">辅导员管理</div>
        <div class="menulist" divname="5">科目设置</div>
    </div>
 </div>
 <div class="right pull_left">
 <!--文档类型管理-->
    <div class="right_condiv filetype_mandiv clearfix ">
        <h1>文档类型管理</h1>
        <hr />
        <br>
        <p class="error">谨慎操作：文档类型只能添加和修改，不能删除</p>
        <div class="typelist_div clearfix">
            <div class="type_list">
                <b>1</b>&nbsp&nbsp
                <div class="type_text inblock">IT/计算机</div>
                <input type="text" class="type_input input hiden" maxlength="6"/>
                <input type="button" class="changetype_button button1" value="修改"/>
                <input type="button" class="savetype_button button2 hiden" value="保存"/>
            </div>
            <div class="type_list">
                <b>2</b>&nbsp&nbsp
                <div class="type_text inblock">IT/计算机</div>
                <input type="text" class="type_input input hiden" maxlength="6"/>
                <input type="button" class="changetype_button button1" value="修改"/>
                <input type="button" class="savetype_button button2 hiden" value="保存"/>
            </div>
            <div class="type_list">
                <b>3</b>&nbsp&nbsp
                <div class="type_text inblock">IT/计算机</div>
                <input type="text" class="type_input input hiden" maxlength="6"/>
                <input type="button" class="changetype_button button1" value="修改"/>
                <input type="button" class="savetype_button button2 hiden" value="保存"/>
            </div>
           

        </div>

        <hr />
        <div class="addtype_div clearfix">
            <h2>添加文档分类</h2>
            <div class="addline_div">
            <input class="add_textbox hiden" type="text" maxlength="6"/>
            <input class="saveaddtype_button hiden" type="button" value="保存"/>
            <input class="caneladdtype_button hiden" type="button" value="取消" />
            <input class="add_but" type="button" value="添加分类"/>
            </div>
        </div>
    </div>
    <!--系别信息管理-->
    <div class="right_condiv class_mandiv clearfix hiden">
        <h1>系别班级管理</h1>
        <hr />

       <p class="error">系别只能添加与修改，不能删除，请谨慎操作</p>
       <br/>
       <h2>系别列表:</h2>
       <div class="dept_list clearfix">
         <!--加载系别-->
         <div class='dept_list_div'>31：
         <div class='inblock deptname_la'>软件学院</div class='inblock deptname_la'>
					<input class='deptname_textbox hiden' type='text' value='"+this.系别名称+"' />
					<input class='savedept_button hiden' type='button' value='保存' />
					<input class='changedept_button' type='button' value='修改'>
		 </div>
         <div class="class_infodiv clearfix">
            <div class="title">班级列表：</div>
            <div class="classsearch_div">
                <label>学年：</label>
                <select class="gread_select">
                    <option value="2015">2015</option>
                </select>
             </div>
            <p class="error remintext" >共有<label class="classcount">8</label>条记录</p>
            <table class="classliat_table" cellpadding="0" cellspacing="0">
                <tr class="table_head">
                    <td class="td0">班级编号</td>
                    <td class="td1">识别码</td>
                    <td class="td2">年级</td>
                    <td class="td3">专业</td>
                    <td class="td4">班级</td>
                    <td class="td7">辅导员</td>
                    <td class="td5">人数</td>
                    <td class="td6">操作</td>
                
                </tr>
                <tbody class="list_tbocy">
                <tr class="tr1 list">
                <td class="td0">600001</td>
                    <td class="td1">315801</td>
                    <td class="td2">
                        <div class="classgread_div full">2015</div>
                        <select class="full classgread_select hiden">
                            <option value="2015">2015级</option>
                             <option value="2016">2016级</option>
                        </select>
                    </td>
                    <td class="td3"><div class="classname_div">网络工程（专升本）</div><input class="classname_text hiden" value="网络工程（专升本）"/></td>
                    <td class="td4">1班</td>
                    <td class="td7"></td>
                    <td class="td5">35</td>
                    <td class="td6"><label class="class_change">修改</label></td>
                </tr>
                </tbody>
               
                <tr class="addclass">
                     <td class="" colspan="2"><div class="add_icon">添加</div></td>
                    <td class="td2">
                        <select class="gread">
                            <option value="2015">2015级</option>
                        </select></td>
                    <td class="td3"><input class="class_name" type="text"/></td>
                    <td class="td4"><input class="class_num" type="text"/></td>
                    <td class="td5"></td>
                    <td class="td5"><input class="add_but" type="button" value="添加"/></td>
                </tr>
             
             </table>
            <div class="remain_text error clearfix">
                <p style="font-size:16px;">注意事项：</p>
                <p>1、班级操作需谨慎，容易造成矛盾问题。</p>
                <p>2、班级只能添加、修改操作，不能删除！因为可能存在班级已有学生加入，删除导致学生没有班级隶属问题！</p>
                <p>3、班级编号用于唯一标识班级的号码，自动生成，不可更改！</p>
                <p>4、识别码用于快速别人班级属于那个学院，第几个班级，与学生学号相关联！</p>
              
              </div>
         </div>
       </div>
      <%-- <h2 class="h2_class_title">班级列表：</h2>
        <table class="class_table">
            <tr class="tr1">
                <td class="td0">编号</td>
                <td class="td1">系别</td>
                <td class="td2">班级</td>
                <td class="td3">操作</td>
            </tr>
            <tbody class="class_listbody">
             <tr>
                <td class="">信息学院</td>
                <td>信息管理1班</td>
                <td><input class="change_class" type="button" value="修改"/></td>
            </tr>
            </tbody>
           
        </table>--%>

        <br/>
        <h2>添加系别</h2>
        <hr>
        <div class="add_deptline_div clearfix">
            <div class="deptbox_div hiden">
              <input class="dept_name" type="text" maxlength="6"/>
              <input class="saveadddept_button save" type="button" value="保存" />
              <input class="canceladddept_button cancel" type="button" value="取消"/>
            </div> 
              <input class="adddept_button" value="添加系别" type="button"/>
        </div>
        <%--<div class="add_classline_div clearfix">
            <div class="calssbox_div hiden">
            <input class="calss_namebox" type="text" maxlength="6"/>
            <select class="dept_select">
                <option>系别</option>
            </select>
             <input class="saveaddclass_button save" type="button" value="保存" />
              <input class="canceladdclass_button cancel" type="button" value="取消"/>
            </div>
            <input class="addclass_but" type="button" value="添加班级"/>
        </div>--%>
    </div>
    <!--教师信息管理-->
    <div class="right_condiv teacher_mandiv clearfix hiden">
        <h1>教师信息管理管理</h1>
        <hr />
        <br />
        <h2 class="h2">教研室</h2>
        <div  class="teacher_typediv clearfix">
            <ul class="teachertype_ul">
                <li class="teadchertype_li active" value="10001">网络教研室</li>
                 <li class="teadchertype_li" value="10001">网络教研室</li>
                  <li class="teadchertype_li" value="10001">网络教研室</li>
                   
            </ul>
        </div>
        <br />
        
        <h2>添加教研室</h2>
        <br />
        <p class="addteatype_p"><input class="addteatypename" type="text" maxlength="15" /><input class="addteatype_but" value="添加" type="button" /></p>
        <hr />
        <div class="teachertypeinfo_div clearfix hiden">
           <table class="teatyin_table">
            <tr class="ttr1">
                <td class="td1">教研室名称：</td>
                <td class="td2"><input class="teatype_text" type="text" readonly value="网络教研室"/><label style="font-size:10px;color:Red">双击可进行修改</label></td>
                <td class="td3"><input class="savetextype_but hiden" type="button" value="保存"/><input class="changeteatyepcan error hiden" value="取消" type="button" /></td>
            </tr>
            <tr class="ttr2">
                <td class="td1">人数：</td>
                <td class="td2"><label class="teanum">8</label></td>
                <td class="td3"></td>
            </tr>
           
           </table>
           <table class="teacher_table" cellspacing="0" cellpadding="0">
            <tr class="tr_head">
                <td class="td1">编号</td>
                <td class="td2">姓名</td>
                <td class="td3">性别</td>
                <td class="td4">手机号</td>
                <td class="td5">教课课程数</td>
                <td class="td6"></td>
            </tr>
            <tbody class="teacherlist_tbody">
            <tr class="ttr1">
                <td class="td1">1</td>
                <td class="td2">张三</td>
                <td class="td3">男</td>
                <td class="td4">186496803271</td>
                <td class="td5">2</td>
                <td class="td6"></td>
            </tr>
            <tr class="teacherinfo_tbody">
                    <td colspan="6">
                        <div class="teacherinfo_div clearfix">
                            <div class="tileft clearfix pull_left">
                                <table class="table1">
                                    <tr >
                                    <td >姓名：</td>
                                    <td><input class="teacher_name" type="text" readonly value="张三" maxlength="11"/></td>
                                    <td><label class="error teaname_label">名字不能为空</label></td>
                                    </tr>
                                    <tr >
                                    <td >性别：</td>
                                    <td><input class="sexselect_ra" name="teacher_ra" type="radio" checked />&nbsp 男&nbsp&nbsp&nbsp&nbsp
                                        <input class="sexselect_ra" name="teacher_ra" type="radio" />&nbsp 女</td>
                                    <td></td>
                                    </tr>
                                    <tr >
                                    <td >手机号：</td>
                                    <td><input class="teacher_name" type="text" readonly value="18611111111" maxlength="11"/></td>
                                    <td><label class="error teapho_label error">手机号被占用</label></td>
                                    </tr>
                                </table>
                                <div class="teacher_butdiv clearfix">
                                    <input class="changetea_but" type="button" value="保存"/>
                                    <input class="repswtea_but" type="button" value="恢复密码"/>
                                </div>
                            </div>
                            <div class="tiright clearfix pull_left">
                                <h2>教程的课程</h2>
                                <table class="lession_table" cellspance="0" cellpaddintg="0"></table>
                            </div>
                        
                        </div>
                    </td>
            </tr>
          
            </tbody>
            <tr class="addteacher-tbody">
                <td class="td1">添加</td>
                <td class="td2"><input type="text" class="addteaname full" maxlength="15" /></td>
                <td class="td3"><select class="teasexselect full"><option value="0">男</option><option value="1">女</option></select></td>
                <td class="td4"><input class="addteaphone full" type="text" maxlength="11" /> </td>
                <td class="td5"></td>
                <td class="td6"><input class="addteabutton" type="button" value="添加" /></td>
            </tr>
           </table>
        
        </div>
        

    </div>
    <!--辅导员管理-->
    <div class="right_condiv instructor_mandiv clearfix hiden">
    
    <h1>辅导员管理</h1>
    <hr/>
    <div class="ins_serdiv">
        <input type="text" class="ser_txt" value="输入关键字"/>
        <i class="inblock ser_but"></i>
    </div>
    <div class="remain_text">共有<label class="ins_number">8</label>条记录</div>
    <table class="ins_table" cellpadding="0" cellspacing="0" >
        <tr class="tablehead">
            <td class="td1">编号</td>
            <td class="td2">姓名</td>
            <td class="td3">性别</td>
            <td class="td4">手机号</td>
            <td class="td5">班级数</td>
            <td class="td6"></td>
        </tr>
        <tr>
        <td colspan="6">
        <table class="list_tbody" cellpadding="0" cellspacing="0">
        
        <tbody class="ins_tbody">
            <tr class="tr1">
            <td class="td1">1</td>
            <td class="td2">张三</td>
            <td class="td3">男</td>
            <td class="td4">18600000001</td>
            <td class="td5">4</td>
            <td class="td6"><i class="open_close close"></td>
        </tr>
         </tbody>
            <!--详情下拉框-->
        <tbody class=" info_tbody">
        <tr>
            <td colspan="6">
            
                 <div class="info_idv clearfix hiden">
                   <div class="pull_left idiv_left">
                     <div class="info_name">
                       <label class="la1">姓名：</label>
                       <input type="text" class="name_text" />
                       <i class=" re_icon ok"></i>
                       <label class="re_text error">输入出错</label>
                     </div>
                     <div class="info_sex">
                        <label class="la1">性别：</label>
                        <input type="radio" name="sex" value="男" class="sex_radio1" />男
                        <input type="radio" name="sex" value="女" class="sex_radio2" />女
                     </div>
                     <div class="info_phone">
                        <label class="la1">手机号：</label>
                        <input class="phone_text" type="text" />
                        <i class="ph_reicon error"></i>
                        <label class="ph_retext error">手机号被暂用</label>
                     </div>

                     <div class="info_button">
                        <div class="info_change pull_left">修改</div>
                        <div class="info_repassword pull_left">恢复密码</div>
                     </div>
                   </div>
                   <div class="pull_left idv_right">
                   <div class="info_title">管理的班级：</div>
                   <p>共有<label class="class_num">4</label>个班级</p>
                   <table class="class_list" cellspacing="0" cellpadding="0">
                   <tr class="tr1">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">网络工程</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr2">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">计算机应用与科学（专升本）1501</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr1">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">网络工程</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr2">
                    <td class="td1"><i class="add_icon"></i></td>
                    <td class="td2">
                        <select class="depart_sele">
                            <option>会计学院</option>
                            <option>软件学院</option>
                            <option>金融学院</option>
                        </select>
                    </td>
                    <td class="td3">
                        <select class="gread_sele">
                          <option>2014级</option>
                          <option>2015级</option>
                          <option>2014级</option>
                        </select>
                        <select class="class_sele">
                            <option>会计与审计</option>
                            <option>会计学</option>
                            <option>计算机应用与科学（专升本）</option>
                            <option>会计与审计</option>
                            <option>会计学</option>
                        </select>
                    </td>
                    <td class="td4"><label class="add_la">添加</label></td>
                   </tr>
                   </table>
                   </div>
        
        
        
                </div>
            </td>
        </tr>
        </tbody>
        <tbody class="ins_tbody">
            <tr class="tr2">
            <td class="td1">2</td>
            <td class="td2">李四</td>
            <td class="td3">女</td>
            <td class="td4">18600000002</td>
            <td class="td5">4</td>
            <td class="td6"><i class="open_close close"></i></td>
            </tr>
        </tbody>
        <tbody class=" info_tbody">
        <tr>
            <td colspan="6">
            
                 <div class="hiden info_idv clearfix">
                   <div class="pull_left idiv_left">
                     <div class="info_name">
                       <label class="la1">姓名：</label>
                       <input type="text" class="name_text" />
                       <i class=" re_icon ok"></i>
                       <label class="re_text error">输入出错</label>
                     </div>
                     <div class="info_sex">
                        <label class="la1">性别：</label>
                        <input type="radio" name="sex" value="男" class="sex_radio1" />男
                        <input type="radio" name="sex" value="女" class="sex_radio2" />女
                     </div>
                     <div class="info_phone">
                        <label class="la1">手机号：</label>
                        <input class="phone_text" type="text" />
                        <i class="ph_reicon error"></i>
                        <label class="ph_retext error">手机号被暂用</label>
                     </div>

                     <div class="info_button">
                        <div class="info_change pull_left">修改</div>
                        <div class="info_repassword pull_left">恢复密码</div>
                     </div>
                   </div>
                   <div class="pull_left idv_right">
                   <div class="info_title">管理的班级：</div>
                   <p>共有<label class="class_num">4</label>个班级</p>
                   <table class="class_list" cellspacing="0" cellpadding="0">
                   <tr class="tr1">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">网络工程</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr2">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">计算机应用与科学（专升本）1501</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr1">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">网络工程</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr2">
                    <td class="td1"><i class="add_icon"></i></td>
                    <td class="td2">
                        <select class="depart_sele">
                            <option>会计学院</option>
                            <option>软件学院</option>
                            <option>金融学院</option>
                        </select>
                    </td>
                    <td class="td3">
                        <select class="gread_sele">
                          <option>2014级</option>
                          <option>2015级</option>
                          <option>2014级</option>
                        </select>
                        <select class="class_sele">
                            <option>会计与审计</option>
                            <option>会计学</option>
                            <option>计算机应用与科学（专升本）</option>
                            <option>会计与审计</option>
                            <option>会计学</option>
                        </select>
                    </td>
                    <td class="td4"><label class="add_la">添加</label></td>
                   </tr>
                   </table>
                   </div>
        
        
        
                </div>
            </td>
        </tr>
        </tbody>
        <tbody class="ins_tbody">
            <tr class="tr1">
            <td class="td1">1</td>
            <td class="td2">张三</td>
            <td class="td3">男</td>
            <td class="td4">18600000001</td>
            <td class="td5">4</td>
            <td class="td6"><i class="open_close close"></td>
        </tr>
         </tbody>
            <!--详情下拉框-->
        <tbody class="info_tbody">
        <tr>
            <td colspan="6">
            
                 <div class="hiden info_idv clearfix">
                   <div class="pull_left idiv_left">
                     <div class="info_name">
                       <label class="la1">姓名：</label>
                       <input type="text" class="name_text" />
                       <i class=" re_icon ok"></i>
                       <label class="re_text error">输入出错</label>
                     </div>
                     <div class="info_sex">
                        <label class="la1">性别：</label>
                        <input type="radio" name="sex" value="男" class="sex_radio1" />男
                        <input type="radio" name="sex" value="女" class="sex_radio2" />女
                     </div>
                     <div class="info_phone">
                        <label class="la1">手机号：</label>
                        <input class="phone_text" type="text" />
                        <i class="ph_reicon error"></i>
                        <label class="ph_retext error">手机号被暂用</label>
                     </div>

                     <div class="info_button">
                        <div class="info_change pull_left">修改</div>
                        <div class="info_repassword pull_left">恢复密码</div>
                     </div>
                   </div>
                   <div class="pull_left idv_right">
                   <div class="info_title">管理的班级：</div>
                   <p>共有<label class="class_num">4</label>个班级</p>
                   <table class="class_list" cellspacing="0" cellpadding="0">
                   <tr class="tr1">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">网络工程</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr2">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">计算机应用与科学（专升本）1501</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr1">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">网络工程</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr2">
                    <td class="td1"><i class="add_icon"></i></td>
                    <td class="td2">
                        <select class="depart_sele">
                            <option>会计学院</option>
                            <option>软件学院</option>
                            <option>金融学院</option>
                        </select>
                    </td>
                    <td class="td3">
                        <select class="gread_sele">
                          <option>2014级</option>
                          <option>2015级</option>
                          <option>2014级</option>
                        </select>
                        <select class="class_sele">
                            <option>会计与审计</option>
                            <option>会计学</option>
                            <option>计算机应用与科学（专升本）</option>
                            <option>会计与审计</option>
                            <option>会计学</option>
                        </select>
                    </td>
                    <td class="td4"><label class="add_la">添加</label></td>
                   </tr>
                   </table>
                   </div>
        
        
        
                </div>
            </td>
        </tr>
        </tbody>
        <tbody class="ins_tbody">
            <tr class="tr2">
            <td class="td1">2</td>
            <td class="td2">李四</td>
            <td class="td3">女</td>
            <td class="td4">18600000002</td>
            <td class="td5">4</td>
            <td class="td6"><i class="open_close close"></i></td>
            </tr>
        </tbody>
        <tbody class="info_tbody">
        <tr>
            <td colspan="6">
            
                 <div class="hiden info_idv clearfix">
                   <div class="pull_left idiv_left">
                     <div class="info_name">
                       <label class="la1">姓名：</label>
                       <input type="text" class="name_text" />
                       <i class=" re_icon ok"></i>
                       <label class="re_text error">输入出错</label>
                     </div>
                     <div class="info_sex">
                        <label class="la1">性别：</label>
                        <input type="radio" name="sex" value="男" class="sex_radio1" />男
                        <input type="radio" name="sex" value="女" class="sex_radio2" />女
                     </div>
                     <div class="info_phone">
                        <label class="la1">手机号：</label>
                        <input class="phone_text" type="text" />
                        <i class="ph_reicon error"></i>
                        <label class="ph_retext error">手机号被暂用</label>
                     </div>

                     <div class="info_button">
                        <div class="info_change pull_left">修改</div>
                        <div class="info_repassword pull_left">恢复密码</div>
                     </div>
                   </div>
                   <div class="pull_left idv_right">
                   <div class="info_title">管理的班级：</div>
                   <p>共有<label class="class_num">4</label>个班级</p>
                   <table class="class_list" cellspacing="0" cellpadding="0">
                   <tr class="tr1">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">网络工程</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr2">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">计算机应用与科学（专升本）1501</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr1">
                    <td class="td1">1</td>
                    <td class="td2">软件学院</td>
                    <td class="td3">网络工程</td>
                    <td class="td4"><label class="del_la">删除</label></td>
                   </tr>
                   <tr class="tr2">
                    <td class="td1"><i class="add_icon"></i></td>
                    <td class="td2">
                        <select class="depart_sele">
                            <option>会计学院</option>
                            <option>软件学院</option>
                            <option>金融学院</option>
                        </select>
                    </td>
                    <td class="td3">
                        <select class="gread_sele">
                          <option>2014级</option>
                          <option>2015级</option>
                          <option>2014级</option>
                        </select>
                        <select class="class_sele">
                            <option>会计与审计</option>
                            <option>会计学</option>
                            <option>计算机应用与科学（专升本）</option>
                            <option>会计与审计</option>
                            <option>会计学</option>
                        </select>
                    </td>
                    <td class="td4"><label class="add_la">添加</label></td>
                   </tr>
                   </table>
                   </div>
        
        
        
                </div>
            </td>
        </tr>
        </tbody>
 </table>
      
        <tbody class="add_body">
        <tr class="tr1">
            <td class="td1"><i class="add_iocn"></i></td>
            <td class="td2 relative">
                <div class="absolute errdiv name relative hiden">
                    <div class="point_border absolute">
                    </div>
                    <div class="point absolute">
                    </div>
                    <label class="errortext error">这是个错误框</label>
                </div>
                <input class="addname_text" />
            </td>
            <td class="td3">
                <select class="add_sexselect">
                    <option value="0">男</option>
                    <option value="1">女</option>
                </select>
            </td>
            <td class="td4 relative">
                 <div class="absolute phone errdiv error relative hiden">
                     <div class="point_border absolute"></div>
                     <div class="point absolute"></div>
                     <label class="errortext error">这是个错误框</label>
                 </div>
                <input type="text" class="daaphone_text" maxlength="11" />
            </td>
            <td class="td5">0</td>
            <td class="td6"><input type="button" class="add_but" value="添加"/></td>
        </tr>
        </tbody>
        </td>
        </tr>
    
    </table>
    
    
    </div>

    <!--科目设置-->
    <div class="right_condiv lession_mandiv clearfix hiden">
    <h1>科目设置</h1>
     <hr/>
    <div class="lessiontypelist clearfix">
        <p class="lesstype_p">
            <label>1:</label>
            <input class="lesstype_text" type="text" readonly value="计算机类" />
            <input class="savelesschange" type="button" value="保存"/>
            <input class="changelesstype" type="button" value="修改"/></label>
        </p>
        <div class="lessiondiv clearfix hiden ">
            <h3>科目：</h3>
            <br />
            <table class="lessiontable" cellspacing="0" cellpadding="0">
                <tr class="tr1">
                    <td class="td1">1</td>
                    <td class="td2"><input class="full lessionname" type="text" value="C#程序基础" readonly /></td>
                    <td class="td3"><input class="changelession" type="button" value="修改"/></td>
                </tr>
                <tr class="tr2">
                    <td class="td1">1</td>
                    <td class="td2"><input class="full lessionname" type="text" value="C#程序基础" readonly /></td>
                    <td class="td3"><input class="changelession" type="button" value="修改"/></td>
                </tr>
            </table>
            <p>添加：</p>
            <p class="addless-p"><input class="addlession" type="text"/><input class="addlessionbut" type="button" value="添加"/></p>
        </div>
    </div>
    <br/>
    <h4>添加类型</h4>
    <hr />
    <div style="margin-top:20px;" class="clearfix">
        <div class="addiocn pull_left">+</div>
        <div class="addlessstypediv clearfix pull_left hiden">
            <input class="addlesstype_text" type="text"  maxlength="15"/>
            <input class="addlestype_but" type="button" value="添加"/>
        </div>
    </div>
   
    
    </div>
 
 </div>


</div>
</asp:Content>

