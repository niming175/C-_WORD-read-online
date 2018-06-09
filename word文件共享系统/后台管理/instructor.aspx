<%@ Page Title="" Language="C#" MasterPageFile="~/后台管理/bg_manerge.master" AutoEventWireup="true" CodeFile="instructor.aspx.cs" Inherits="word文件共享系统.后台管理.instructor" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>辅导员管理</title>
    <link href="css/instructor.css" rel="stylesheet" type="text/css" />
    <script src="js/instructor.js" type="text/javascript"></script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="inscontent_div">
    <div class="insleft_div pull_left clearfix">
        <div class="left_head clearfix">
            <div class="head_img pull_left">
            </div>
            <div class="head_info pull_left clearfix">
                <div class="hello_text">你好：辅导员</div>
                <div class="time_text">2016年11月14日</div>
                <div class="week_text">星期五</div>
            </div>
        </div>
        <div class="left_menu clearfix">
            <div class="listmenu relative" value="1">我的班级<div class="close_icon absolute"></div></div>
                <div class="great_list clearfix hiden">
                    <div class="list" value="2015">2015级</div>
                    <div class="list" value="2016">2016级</div>
                </div>
            <div class="listmenu" value="2">课程安排</div>
            
            <div class="listmenu" value="3">修改密码</div>
        </div>
    </div>
    <div class="insright_div pull_left clearfix ">
        <!--学生管理-->
        <div class="rightdiv clearfix classstudendiv 1">
            <h2>学生管理</h2>
            <hr />
            <div class="search_div clearfix">
                <input class="search_text" type="text" value="学生学号/姓名" />
                <input class="search_text" type="button" value="搜索"/>
            </div>
            <div class="class_list clearfix">
            <p class="p_text">班级列表：</p>
             <ul class="classlist_li">
                <li>软件学院：网络工程（专升本）1501</li>
                <li>软件学院：网络工程（专升本）1501</li>
                <li>软件学院：网络工程（专升本）1501</li>
                <li>软件学院：网络工程（专升本）1501</li>
                <li>软件学院：网络工程（专升本）1501</li>
             
             </ul>
            
            
            </div>

            <div class="studentlist_div clearfix">
                <div class="clearfix">
                    <div class="classname pull_left">网络工程（专升本）1501名单：</div>
                    <div class="classcode pull_right">班级代码：<label class="coed" classid="null">315810</label></div>
                </div>
                <table class="student_table" cellpadding="0" cellspacing="0">
                    <tr class="t_head">
                        <td class="td0">学号</td>
                        <td class="td1">座号</td>
                        <td class="td2">姓名</td>
                        <td class="td3">性别</td>
                        <td class="td4">操作</td>
                    </tr>
                    <tbody class="student_tbody">
                        <tr class="tr1">
                            <td class="td0">315011101</td>
                            <td class="td1"><div class="student_nola full">01</div><input class="full syudent_no hiden" type="text"/></td>
                            <td class="td2"><input class="student_namela full" type="text" readonly=false value="张三"/></td>
                            <td class="td3"><div class="student_sex full">男</div>
                                <select class="student_sexselect full hiden">
                                    <option value="0" selected>男</option>
                                    <option value="1">女</option>
                                 </select>
                            </td>
                            <td class="td4">
                                <label class="student_change">修改</label>
                                <label class="student_del error">删除</label>
                                <input type="button" class="recove_psw" value="恢复密码"/>
                            </td>
                        </tr>
                        <tr class="tr2">
                            <td class="td0">315011101</td>
                            <td class="td1"><input type="text"  value="01" class="student_nola full" readonly /></td>
                            <td class="td2"><input class="student_namela full" type="text" readonly="" value="张三"/></td>
                            <td class="td3"><div class="student_sex full">男</div>
                                <select class="student_sexselect full hiden">
                                    <option value="0">男</option>
                                    <option value="1">女</option>
                                 </select>
                            </td>
                            <td class="td4">
                                <label class="student_change">修改</label>
                                <label class="student_del error">删除</label>
                                <input type="button" class="recove_psw" value="恢复密码"/>
                            </td>
                        </tr>
                    
                    </tbody>
                    <tr class="add_studenttbody">
                        <td class="td0">添加</td>
                        <td class="td1"><input class="student_notext full" type="text" /></td>
                        <td class="td2"><input class="student_addname full" type="text" /></td>
                        <td class="td3"><select class="sex_select full">
                            <option value="0">男</option>
                            <option value="1">女</option>
                        </select></td>
                        <td class="td4"><input class="aadd_but" type="button" value="添加" /></td>
                    
                    </tr>
                
                
                </table>
            </div>
        
        </div>
        <!--课程安排-->
        <div class="rightdiv clearfix lessman_div hiden 2">
        <h2>课程安排</h2>
        <hr />
        <div class="nianjidiv clearfix"><div class="clearfix pull_left">年级：</div>
            <div class="nianjilistdiv pull_left">
                <label value="100101">2015级</label>
                <label value="100101">2015级</label>
            </div>
        </div>
        <div class="classddiv clearfix">
            <div class="div1 clearfix pull_left">班级:</div>
            <div class="classlistdiv pull_left">
                <ul class="classlistul">
                    <li value="10001" class="classlist">网络工程（专升本）1501</li>
                    <li value="10001" class="classlist">网络工程（专升本）1501</li>
                    <li value="10001" class="classlist">网络工程（专升本）1501</li>
                </ul>
            </div>
        </div>

        <div class="classinfodiv clearfix">班级：<label class="classname">网络工程</label></div>
        <table class="term_table" cellspacing="0">
            <tr class="thead">
                <td class="td1">序号</td>
                <td class="td2">学期</td>
                <td class="td3">开始时间</td>
                <td class="td4">结束时间</td>
                <td class="td5">状态</td>
            </tr>
            <tbody class="tremtbody">
            <tr class="tr1">
                 <td class="td1">1</td>
                <td class="td2">大一上学期</td>
                <td class="td3">2015-09-01</td>
                <td class="td4">2016-01-31</td>
                <td class="td5 error">结束</td>
            </tr>
            <tr class="tr2">
                 <td class="td1">2</td>
                <td class="td2">大一下学期</td>
                <td class="td3">2016-03-01</td>
                <td class="td4">2016-06-31</td>
                <td class="td5 error">结束</td>
            </tr>
            <tr class="tr1">
                 <td class="td1">3</td>
                <td class="td2">大二上学期</td>
                <td class="td3">2016-09-01</td>
                <td class="td4">2017-01-31</td>
                <td class="td5 green">正在进行</td>
            </tr>
            <tr class="tr2">
                 <td class="td1">4</td>
                <td class="td2">大二下学期</td>
                <td class="td3">2017-03-01</td>
                <td class="td4">2017-06-31</td>
                <td class="td5 blue">还未开始</td>
            </tr>
            </tbody>
        </table>
    </div>
        <!--修改密码-->
        <div class="rightdiv clearfix changepsw_div hiden 2">
            <h2>修改密码</h2>
            <hr />

            <div class="oldpsw-div clearfix"><label>旧&nbsp密&nbsp码：</label><input class="oldpsw_input" type="password" maxlength="18"/>
                <label class="error oldpsw_la hiden">error</label></div>
            <div class="newpsw_div clearfix"><label class="la2">新&nbsp密&nbsp码：</label><input type="password" class="newpsw_input" maxlength="18"/>
                <label class="error newpsw_la hiden">error</label>
                </div>
            <div class="confpsw_div clearfix "><label class="la3">确认密码：</label><input class="comfpsw_input" type="password" maxlength="18" />
                <label class="error confrpsw_la hiden">error</label>
            </div>
            <div class="changepswbut_div clearfix"><input class="change_but" type="button" value="确认" />
                   <input class="camcel_but error" type="button" value="取消" />
            </div>
        </div>


    </div>

    

</div>
</asp:Content>
