﻿<%@ Page Title="" Language="C#" MasterPageFile="~/母板页/页眉登录.master" AutoEventWireup="true" CodeFile="user_register.aspx.cs" Inherits="page_user_register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript" src="../js/user_register.js"></script>
<link rel="stylesheet" type="text/css" href="../css/user_register.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="content_div clearfix">

   <div class="register_div clearfix ">
      <div class="register_table pull_left">
         <div class="register_head">
            欢迎注册，如果您已有账户，可以点击<a href="../index/index.html" type="_blank">登录</a>
         </div>
         <table class="table">
             <tr>
               <td class="td_text">手&nbsp&nbsp&nbsp&nbsp机:</td>
               <td class="td_box"><input type="text" class="phone textbox" maxLength="11"></td>
               <td class="td_remark"><div class="ok_icon inblock phone hiden"></div><label class="lb_remark phone">输入11位手机号</label></td>
            </tr>
            <tr>
               <td class="td_text">昵&nbsp&nbsp&nbsp&nbsp称:</td>
               <td class="td_box"><input type="text" class="username textbox" maxLength="10"></td>
               <td class="td_remark"><div class="ok_icon inblock user_name hiden"></div><label class="lb_remark username">昵称最大为十个字符</label></td>
            </tr>
            <tr>
               <td class="td_text">姓&nbsp&nbsp&nbsp&nbsp名:</td>
               <td class="td_box"><input type="text" class="real_username textbox" maxLength="4"></td>
               <td class="td_remark"><div class="ok_icon inblock real_name hiden"></div><label class="lb_remark  real_name">请输入真实姓名</label></td>
            </tr>
             <tr>
               <td class="td_text">设置密码:</td>
               <td class="td_box"><input type="password" class="password textbox" maxLength="18"></td>
               <td class="td_remark"><div class="ok_icon inblock password hiden"></div><label class="lb_remark password">密码为6-18个字符</label></td>
            </tr>
             <tr>
               <td class="td_text">确认密码:</td>
               <td class="td_box"><input type="password" class="confirm_password  textbox" maxLength="18"></td>
               <td class="td_remark"><div class="ok_icon inblock confirm_password hiden"></div><label class="lb_remark confirm_password"></label></td>
            </tr>
            
            <tr>
               <td class="td_text">班&nbsp&nbsp&nbsp&nbsp级:</td>
               <td class="td_box"><select class="select department">
                                    <option>电科学院</option>
                                  </select>
                                  <select class="select grade">
                                    <option>信息管理</option>
                                  </select>
                                </td>
               <td class="td_remark"><label class="lb_remark"></label></td>
            </tr>
            <tr>
               <td class="td_text"></td>
               <td class="td_box">
               <div class="td_div" >
                  <div class="check_div pull_left"><input type="checkbox" class="checkbox" ></div>
                  <div class="pull_left agree_text">同意</div>
                  <div class="pull_left label">《网站服务协议》</div>
               </div>
                  </td>
               <td class="td_remark"><label class="lb_remark agree_box hiden">您未同意服务协议</label></td>
            </tr>
            <tr class="tr_button">
               <td></td>
               <td><input type="button" class="re_button" value="立即注册"/></td>
               <td></td>
            </tr>
         </table>
      </div>

      <div class="pull_left protocol_div hiden">
       <div class="pro_head relative">
         <div class="head_text">用户服务协议</div>
         <div class="head_close absolute">X</div>
      </div>
      <div class="content">
         <section class="agreement ">
   


      <h2>《平台服务协议》</h2>
      <article>
        <h4>一、总则</h4>
        <p>1、为了保护网络信息安全，保障公民、法人和其他组织的合法权益，维护国家安全和社会公共利益，根据国家法律法规以及全国人大常委会的相关规定，北京搜狐互联网信息服务有限公司（以下简称“搜狐”）制定并按照本协议提供网络服务。用户应当充分阅读并同意本协议的全部条款并按照页面上的提示完成全部的注册程序（未成年人应与法定监护人共同完成）。用户在注册过程中点击“同意”按钮即表示用户完全接受本协议项下的全部条款，用户选择访问或使用搜狐有关服务，将视为同意接受本协议全部条款的约束。</p>
        <p>2、除非另有明确规定，搜狐所推出的新产品、新功能和新服务，均无条件的适用本协议。</p>
        <p>3、搜狐保留在任何时候修改本协议条款的权利，且无需另行通知。用户在使用服务时应关注并遵守。</p>
        <p>4、用户在使用搜狐提供的各项服务之前，应仔细阅读本协议。如果您不同意本协议或搜狐的修改，可以主动取消搜狐提供的服务；如果您继续使用搜狐服务，则视为您已经接受本协议全部内容，包括搜狐对本协议所做的任何修改。</p>
        <p>5、用户无论通过何种方式使用搜狐服务，均受本协议约束。</p>
        <h4>二、用户账号</h4>
        <p>1、用户可以通过在本网站注册账号使用搜狐提供的各项服务。用户注册成功后，搜狐将给予用户一个账号及相应的密码，在搜狐审核通过后，每个账号对应一个唯一的名字（或昵称、用户名）。搜狐账号（包括名字、昵称、用户名等）的所有权归搜狐，用户完成申请注册手续后，获得搜狐账号的使用权，但仅限为个人而非商业目的使用。</p>
        <p>2、用户自行保管其账号和密码。用户账号、密码使用权仅属于初始申请注册人，禁止赠与、借用、租用、转让或者售卖。</p>
        <p>3、用户应提供完整、真实、准确和最新的个人资料，该资料对于使用搜狐的服务以及找回丢失的搜狐账号和密码至关重要。如因注册信息不真实而引起的问题由用户本人承担，搜狐不负任何责任并有权暂停或终止用户的账号。</p>
        <p>4、用户账号和密码遭到他人非法使用或发生其他任何安全问题，用户应当立即通知搜狐。因黑客行为或用户的过错导致账号、密码被他人非法使用，搜狐不承担任何责任。</p>
        <p>5、如果搜狐邮箱用户 90天未经任何形式（WEB/POP3/SMTP）使用自己的邮箱，搜狐邮件系统将认为信箱内的信件为过期信件，将自动清除; 搜狐邮箱用户的“回收站”文件夹内信件系统将会不定期清除，“已发送邮件”文件夹内信件系统将至少保留30天，30天后将不定期删除。用户如在此些文件夹中有重要信件，请在邮箱中自建文件夹将邮件移动到新建的文件夹当中。</p>
        <p>6、任何组织或者个人注册搜狐微博账号，制作、复制、发布、传播信息内容的，应当使用真实身份信息，不得以虚假、冒用的居民身份信息、企业注册信息、组织机构代码信息进行注册。</p>
        <p>7、搜狐将建立健全微博用户信息安全管理制度，按照搜狐保护隐私权政策保障用户信息安全。</p>
        <h4>三、使用规则</h4>
        <p>1、用户对以其账号发生的或通过其账号发生的一切活动和事件（包括但不限于用户发表的任何内容以及由此产生的任何结果）负全部法律责任。</p>
        <p>2、用户在使用搜狐服务时，必须遵守中华人民共和国相关法律法规的规定，用户应同意将不会利用搜狐服务进行任何违法或不正当的活动，包括但不限于下列行为：</p>
        <p>(1) 上载、下载、张贴、以电子邮件发送、传输、存储或以其他方式提供任何非法、有害、胁迫、骚扰、侵权、中伤、粗俗、猥亵、诽谤、淫秽、暴力、侵害他人隐私、种族歧视或其他令人不快的包括但不限于资讯、资料、文字、软件、音乐、照片、图形、信息或其他资料（以下简称内容）。</p>
        <p>(2) 以任何方式危害未成年人。</p>
        <p>(3) 冒充任何人或机构，或以虚伪不实的方式谎称或使人误认为与任何人或任何机构有关。</p>
        <p>(4) 伪造标题或以其他方式操控识别资料，使他人产生误解。</p>
        <p>(5) 上载、张贴、发送电子邮件或以其他方式传送无权传送的内容。</p>
        <p>(6) 侵犯他人著作权或其他知识产权，或违反保密、雇佣或不披露协议披露他人商业秘密或保密信息。</p>
        <p>(7) 张贴、发送、传输或以其他方式提供任何未经收件人请求或授权的电子邮件信息、广告、促销资料、垃圾邮件等，包括但不限于大批量的商业广告和信息公告。</p>
        <p>(8) 上载、张贴、以电子邮件发送、传输、存储或以其他方式提供包含病毒或包含旨在危害、干扰、破坏或限制有关服务（或其任何部分）或任何其他计算机软件、硬件或通讯设备之正常运行的任何其他计算机代码、文档或程序的任何资料。</p>
        <p>(9) 干扰或破坏有关服务，或与有关服务连接的任何服务器或网络，或与有关服务连接之网络的任何政策、要求或规定。</p>
        <p>(10)采集并存储涉及有关服务任何其他用户的个人信息，以用于任何上述被禁止的活动。</p>
        <p>(11)故意或非故意违反任何相关的中国法律、法规、规章、条例等其他具有法律效力的规范。</p>
        <p>3、搜狐提供需要用户支付一定的费用的收费服务。对此，搜狐会在用户使用前明示，只有用户根据提示确认其愿意支付相关费用，用户才能使用该等收费网络服务。如用户拒绝支付相关费用，则搜狐有权不向用户提供该等收费网络服务。</p>
        <p>4、用户为使用搜狐服务，须自行配备进入国际互联网所必需的设备，包括电脑、手机及其他与接入互联网或移动网有关的装置，并自行支付与此服务有关的费用。</p>
        <p>5、用户同意搜狐有权在提供网络服务过程中以各种方式投放各种商业性广告或其他任何类型的商业信息。</p>
        <h4>四、知识产权</h4>
        <p>1、搜狐服务中包含的任何文字、图表、音频、视频或软件（包括但不限于软件中包含的图表、动画、音频、视频、界面实际、数据和程序、代码、文档）等信息或材料均受著作权法、商标法或其它法律法规的保护，未经相关权利人书面同意，用户不得以任何方式使用该等信息或材料，但出于使用搜狐服务目的而使用的除外。</p>
        <p>2、本协议未授予用户使用搜狐任何商标、服务标记、标识、域名和其他显著品牌特征的权利。</p>
        <p>3、除本协议明确允许的以外，用户不得以任何形式或任何方式对搜狐服务部分或全部内容进行修改、出租、租赁、出借、出售、分发、复制、创作衍生品或用于任何商业用途。</p>
        <p>4、用户在搜狐上发布的信息不得侵犯任何第三人的知识产权，未经相关权利人之事先书面同意，用户不得以任何方式上传、发布、修改、传播或复制任何受著作权保护的材料、商标或属于其他人的专有信息。</p>
        <p>5、用户同意，对于其上传到本网站的任何内容，搜狐在全世界范围内不限形式和载体地享有永久的、不可撤销的、免费的、非独家的使用权和转授权的权利，包括但不限于修改、复制、发行、展览、改编、汇编、出版、翻译、信息网络传播、广播、表演和再创作及著作权法等法律法规确定的其他权利，用户特别授权搜狐以自己名义单独对第三方的侵权行为提起诉讼并获得全额赔偿。搜狐无须为此向用户给予任何报酬或承担任何义务，也无须另行通知。</p>
        <p>6、若您认为您的知识产权或其他合法权益被侵犯，请向搜狐提供以下资料：</p>
        <p>(1)对涉嫌侵权内容拥有知识产权或其他合法权益的权属证明；</p>
        <p>(2) 权利人具体的主体资质和联络信息，包括个人的姓名、身份证或护照复印件、单位的营业执照复印件或者其他资质证明复印件、通信地址及电话号码等；</p>
        <p>(3) 涉嫌侵权内容在本网站上的位置；</p>
        <p>(4) 对侵权情况的详细描述；</p>
        <p>(5)在权利通知中加入如下关于通知内容真实性的声明：“由以上操作所引起的一切后果，与搜狐无关，由我本人/公司承担。”在签字或加盖公章后，请将上述权利通知书发往以下地址：北京市海淀区中关村东路1号院搜狐网络大厦15层法律部收，也可发往以下邮箱：webmaster@vip.sohu.com。</p>
        <p>7、搜狐在收到权利人的通知书后，可依其合理判断，删除该等侵犯他人知识产权或其他合法权益的内容。</p>
        <h4>五、隐私权</h4>
        <p>1、保护用户的隐私是搜狐的一项基本政策。</p>
        <p>2、适用于用户的隐私政策参见&nbsp;<a href="http://corp.sohu.com/s2007/privacy/">http://corp.sohu.com/s2007/privacy/</a>。</p>
        <h4>六、免责声明</h4>
        <p>1、鉴于网络服务的特殊性，搜狐不保证网络服务的及时性、安全性和准确性，用户同意搜狐有权不经事先通知，随时变更、中断或终止部分或全部的网络服务而无论同意与否，搜狐对用户和任何第三人均无需承担任何责任。</p>
        <p>2、对于经由搜狐服务而传送的内容，搜狐不保证前述内容的正确性、完整性或品质。用户在接受有关服务时，有可能会接触到令人不快、不适当或令人厌恶的内容。在任何情况下，搜狐均不对任何内容负责，包括但不限于任何内容发生任何错误或纰漏以及衍生的任何损失或损害。搜狐有权（但无义务）自行拒绝或删除经由本服务提供的任何内容。用户使用上述内容，应自行承担风险。</p>
        <p>3、用户可通过搜狐有关网络服务获得第三方的某些内容，或者搜狐可能为方便用户而提供通往第三方网站的链接，但搜狐不负责检查或评估任何该等第三方材料、产品、服务或网站内容的准确性，并且，搜狐对此不作保证、不承担任何责任、也不负有任何义务。用户对此自行加以判断，并承担因使用该等内容而引起的所有风险，包括但不限于因对内容的正确性、完整性或实用性的依赖而产生的风险。</p>
        <p>4、用户经由搜狐服务与广告商进行通讯联系或商业往来或参与促销活动，完全属于用户与广告商之间的行为，与搜狐没有任何关系，若因商业行为所产生之任何损害或损失，搜狐不承担任何责任。</p>
        <p>5、用户明确同意其使用搜狐服务所存在的风险及其后果将完全由其自己承担，搜狐对用户不承担任何责任。如因用户违反有关法律、法规或本协议项下的任何条款而给搜狐或任何其他第三人造成损失，用户同意承担由此造成的损害赔偿责任。</p>
        <h4>七、其他</h4>
        <p>1、本协议的版权归搜狐所有，搜狐保留对本协议的一切解释和修改权利。</p>
        <p>2、本协议的订立、执行和争议的解决均应适用中华人民共和国法律。如双方就本协议内容或其执行发生任何争议，双方应尽量友好协商解决；协商不成时，任何一方均可向搜狐所在地有管辖权的人民法院提起诉讼。</p>
        <p>3、搜狐未行使本协议的任何权利或规定，不构成对前述权利之放弃。</p>
        <p>4、如本协议中的任何条款完全或部分无效，本协议的其余条款仍有效并且有约束力。</p>
        <p>5、若您对本协议有任何意见，欢迎垂询搜狐客服中心 webmaster@vip.sohu.com。</p>
      </article>
      <div class="clearfix"></div>
      <div class="mg-top-15">
       
      </div>
         </section>
      </div>





      </div>

   </div>
</div>
</asp:Content>

