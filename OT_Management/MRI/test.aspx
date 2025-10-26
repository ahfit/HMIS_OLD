<%@ Page Language="VB" AutoEventWireup="false" CodeFile="test.aspx.vb" Inherits="test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
    <script type="text/javascript" language="javascript" >
    function mouseclick()
    {
    alert("Mouse is Click");
    window.status = event.screenX;
    alert(event.screenX);
  
    }
        function mou()
    {
   // alert("Mouse is Click");
    window.status = event.screenX + "," + event.screenY;
   // alert(event.screenX);
  
    }
    </script>
</head>
<body>
    <form id="form1" runat="server" onmousemove = "mou()">
    <div style="width: 948px; height: 412px">
        <input id="Submit1" type="submit" value="submit" onmousemove ="mouseclick()" onmousedown="mouseclick()" ondblclick="mouseclick()"/>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ImageDBConnectionString %>"
            SelectCommand="SELECT [ImageSN], [ShotDate], [ShotTime], [ShotProc], [Label], [Comment], [FName], [DiskNo], [ImageID], [ImageNo], [ImageType], [ImageSize], [Mode], [Device] FROM [tblLocalImage]">
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="FName,DiskNo"
            DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="ImageSN" HeaderText="ImageSN" SortExpression="ImageSN" />
                <asp:BoundField DataField="ShotDate" HeaderText="ShotDate" SortExpression="ShotDate" />
                <asp:BoundField DataField="ShotTime" HeaderText="ShotTime" SortExpression="ShotTime" />
                <asp:BoundField DataField="ShotProc" HeaderText="ShotProc" SortExpression="ShotProc" />
                <asp:BoundField DataField="Label" HeaderText="Label" SortExpression="Label" />
                <asp:BoundField DataField="Comment" HeaderText="Comment" SortExpression="Comment" />
                <asp:BoundField DataField="FName" HeaderText="FName" ReadOnly="True" SortExpression="FName" />
                <asp:BoundField DataField="DiskNo" HeaderText="DiskNo" ReadOnly="True" SortExpression="DiskNo" />
                <asp:BoundField DataField="ImageID" HeaderText="ImageID" SortExpression="ImageID" />
                <asp:BoundField DataField="ImageNo" HeaderText="ImageNo" SortExpression="ImageNo" />
                <asp:BoundField DataField="ImageType" HeaderText="ImageType" SortExpression="ImageType" />
                <asp:BoundField DataField="ImageSize" HeaderText="ImageSize" SortExpression="ImageSize" />
                <asp:BoundField DataField="Mode" HeaderText="Mode" SortExpression="Mode" />
                <asp:BoundField DataField="Device" HeaderText="Device" SortExpression="Device" />
            </Columns>
        </asp:GridView>
    </div>
    </form>
</body>
</html>
