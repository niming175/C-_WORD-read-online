function createHtml(obj) {
    var htmstr = [];
    htmstr.push(  "<form id='_fileForm' enctype='multipart/form-data'>");
    htmstr.push(  "<table cellspacing=\"0\" cellpadding=\"3\" style=\"margin:0 auto; margin-top:20px;\">");
    htmstr.push(  "<tr>");
    htmstr.push(  "<td class=\"tdt tdl\">请选择文件：</td>");
    htmstr.push(  "<td class=\"tdt tdl\"><input id=\"loadcontrol\" type=\"file\" name=\"filepath\" id=\"filepath\" /></td>");
    htmstr.push(  "<td class=\"tdt tdl tdr\"><input type=\"button\" onclick=\"fileloadon()\" value=\"上传\"/></td>");
    htmstr.push(  "</tr>");
    htmstr.push(  "<tr> <td class=\"tdt tdl tdr\" colspan='3'style='text-align:center;'><div id=\"msg\">&nbsp;</div></td> </tr>");
    htmstr.push(  "<tr> <td class=\"tdt tdl tdr\" style=\" vertical-align:middle;\">图片预览：</td> <td class=\"tdt tdl tdr\" colspan=\"2\"><div style=\"text-align:center;\"></div></td> </tr>");
    htmstr.push(  "</table>")
    htmstr.push(  "</form>");
    obj.html(htmstr.join(""));
}

function fileloadon() {
    $("#_fileForm").submit(function () {
        $("#_fileForm").ajaxSubmit({
            type: "post",
            url: "../ajax/upload.aspx",
            success: function (data1) {
                alert("test");
            },
            error: function (msg) {
                alert("文件上传失败");
            }
        });
        return false;
    });
    $("#_fileForm").submit();
}
