<%@ page language="C#" autoeventwireup="true" inherits="WebMethod, App_Web_2pjbo4ez" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.9.1.js"></script>

    <%--<script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: "WebMethod.aspx/GetData",
                type: "POST",
                data: {},
                dataType: "json",
                contentType: "application/json",
                success: function (data) {                    
                    var result = data.d;
                    alert('helo');
                }
            });

            //$.post("WebMethod.aspx/GetData").done(function (data, textStatus, jqXHR) {
            //    debugger;
            //}).fail(function (jqXHR, textStatus, errorThrown) {
            //    alert(textStatus);
            //});
        });
        


    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            hello
        </div>
    </form>
</body>
</html>
