<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>验证码</title>
</head>
<script src="js/jquery-3.3.1.js" type="text/javascript"></script>
<script type="text/javascript">
    function reloadCheckImg() {
        $("img").attr("src", "imgs.jsp?t=" + (new Date().getTime()));
    }

    $(document).ready(function () {
        $("#checkcodeID").blur(function () {
            var $checkcode = $("#checkcodeID").val();
            //验证码的校验:文本框中输入的值 发送值服务端
            //服务端： 获取文本框输入的值 ，和真实验证码图片中的值对比，并返回验证结果
            $.post(
                "CheckCodeServlet",//服务器地址
                "checkcode=" + $checkcode,
                function (result) {//图片地址
                    var resultHtml = $("<img src='" + result + "' height='15px' width='15px'/>")
                    $("#tip").html(resultHtml);
                }
            )

        });
    });
</script>
<body>
<form action="">
    验证码:
    <input type="text" name="checkcode" id="checkcodeID" size="4">

    <%--验证码--%>
    <a href="javascript:reloadCheckImg();"><img src="imgs.jsp"></a>
    <span id="tip"></span>
</form>
</body>
</html>