<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Word=Microsoft.Office.Interop.Word"%>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        
        /*
         * type:1   word
         * type:2   jpg
         * type3    task file
         */
        HttpFileCollection files = Request.Files;
        string type = Request["type"].ToString();


        string 文档根目录 = null;
        string 网页根目录 = null;
        string 文档相对路径 = null;
        string 网页相对路径 = null;
        if (type == "1")
        {
            文档根目录 = "~/data/doc/";
            网页根目录 = "~/data/html/";
            文档相对路径 = "../data/doc/";
            网页相对路径 = "../data/html/";

        }
        if (type == "3")
        {
            文档根目录 = "~/data/task_doc/";
            网页根目录 = "~/data/task_html/";
            文档相对路径 = "../data/task_doc/";
            网页相对路径 = "../data/task_html/";

        }

        if (files != null && files.Count > 0 && 文档根目录!=null)
        {
            HttpPostedFile file = files[0];
            string filetype = file.ContentType.ToLower();
            if (!filetype.Contains("word"))
            {
                Response.Write("{'static':'error','message':'不是正确的word文件！'}");
                return;
            }
            else
            {
                string tmpPath = Server.MapPath(文档根目录); //服务端地址
                string htmlpath = Server.MapPath(网页根目录);//服务端网页保存地址

                string fileName = Path.GetFileName(file.FileName);//获取文件的文件名
                string ext = System.IO.Path.GetExtension(fileName);//获取文件名后缀
                DateTime da = new DateTime();
                da = DateTime.Now;

                //按文件的日期归档
                string path = da.ToString("yyyy") + "/" + da.ToString("MM") + "/" + da.ToString("dd") + "/";
                //检查文件是否存在，不存在就创建
                string fullpath = tmpPath + path;
                if (!System.IO.Directory.Exists(fullpath))
                {
                    Directory.CreateDirectory(fullpath);
                }
                string docpathname = 文档相对路径 + path + da.ToString("HHmmss") + ext;//对文件重命名
                string pathfileName = path + fileName; //  /2016/04/28/152400.doc
                fileName = Server.MapPath(docpathname);
                try
                {
                    file.SaveAs(fileName);//保存文件

                    /*
                     * 对保存好的word另存为word文件
                     */
                    Word.ApplicationClass word = new Word.ApplicationClass();
                    Type wordType = word.GetType();
                    Word.Documents docs = word.Documents;
                    // 打开文件
                    Type docsType = docs.GetType();

                    object filename1 = Server.MapPath(docpathname);
                    Word.Document doc = (Word.Document)docsType.InvokeMember("Open",
                    System.Reflection.BindingFlags.InvokeMethod, null, docs, new Object[] { filename1, true, true });


                    /*检查网页保存的地址是否存在*/
                    string htmlfullpath = htmlpath + path;
                    if (!System.IO.Directory.Exists(htmlfullpath))
                    {
                        Directory.CreateDirectory(htmlfullpath);
                    }

                    // 转换格式，另存为
                    Type docType = doc.GetType();
                    string pathhtmlname = 网页相对路径 + path + da.ToString("HHmmss") + ".html";

                    object saveFileName = Server.MapPath(pathhtmlname);
                    docType.InvokeMember("SaveAs", System.Reflection.BindingFlags.InvokeMethod,
                     null, doc, new object[] { saveFileName, Word.WdSaveFormat.wdFormatHTML });
                    // 退出 Word
                    wordType.InvokeMember("Quit", System.Reflection.BindingFlags.InvokeMethod,
                     null, word, null);

                    Response.Write("{'static':'success','文档位置':'" + docpathname + "','网页位置':'" + pathhtmlname + "'}");
                }
                catch
                {
                    Response.Write("{'static':'error','message':'未知错误！'}");
                    Response.End();
                }
            }
        }
        else
        {
            Response.Write("{'static':'error','message':'你未选择文件！'}");
            Response.End();
        }
    }
    
    
</script>
