<%@ page language="VB" autoeventwireup="false" inherits="Transfer_In_Form, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="width: 462px">
            <tr>
                <td style="width: 100px">
                    Date From</td>
                <td style="width: 100px">
                    <igsch:WebDateChooser ID="WebDateChooser_date_from" runat="server">
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    Date To</td>
                <td style="width: 100px">
                    <igsch:WebDateChooser ID="WebDateChooser_date_to" runat="server">
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <asp:RadioButtonList ID="RadioButtonList_status" runat="server" RepeatDirection="Horizontal"
                        Width="284px">
                        <asp:ListItem>Transfer In</asp:ListItem>
                        <asp:ListItem>Transfer Out</asp:ListItem>
                        <asp:ListItem>Incentive</asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <asp:Button ID="Button_Report" runat="server" Text="View Report" /></td>
            </tr>
        </table>
    
    </div>
        <br />
        <br />
        <table style="width: 462px">
            <tr>
                <td style="width: 100px">
                    Employee Name</td>
                <td style="width: 100px">
                    &nbsp;<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_employee"
                        DataTextField="Employee  Name" DataValueField="EmpID" Width="210px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    &nbsp;<asp:SqlDataSource ID="SqlDataSource_employee" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                        SelectCommand="SELECT [EmpID], isnull([EFName],'')+' '+ isnull([EMName],'')+' '+ isnull([ELName],'') as [Employee  Name] FROM [Employee]&#13;&#10;&#13;&#10;order by isnull([EFName],'')+' '+ isnull([EMName],'')+' '+ isnull([ELName],'')">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <asp:Button ID="Button1" runat="server" Text="View Report" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
