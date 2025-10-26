<%@ page language="VB" autoeventwireup="false" inherits="Calender_Add_Attendies, App_Web_ppbttiod" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

  <link rel="stylesheet" href="css/page.css" type="text/css"  media="screen, projection">

<link rel="stylesheet" href="images/sheet_form.css" type="text/css"  media="screen, projection">
<style type="text/css">

body{background-image:none;}

</style>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
      <tr>
                <td width="114" align="right" ><strong> Department&nbsp;:</strong></td>
<td width="169" >
                    <asp:DropDownList AutoPostBack="True" CssClass="dropbox" DataTextField="Dept_Name" DataValueField="Dept_ID" ID="DropDownList_Department" runat="server" Width="206px" DataSourceID="SqlDataSource_Department">                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right" ><strong> Sub Department&nbsp;:&nbsp;</strong></td>
          <td >
                    <asp:DropDownList AutoPostBack="True" CssClass="dropbox" DataTextField="SubDept_Name" DataValueField="SubDept_Id" ID="DropDownList_SubDepartment" runat="server" Width="205px" DataSourceID="SqlDataSource_SubDepartment">                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right" ><strong> Employees&nbsp;:&nbsp;</strong></td>
          <td >
                    <asp:CheckBoxList CssClass="txt_normal" DataTextField="Name" DataValueField="EmpID" ID="CheckBoxList_Employee" RepeatColumns="2" RepeatDirection="Horizontal" runat="server" Width="309px" DataSourceID="SqlDataSource_Employee">                    </asp:CheckBoxList></td>
            </tr>
            <tr>
                <td >                </td>
                <td >
                    <asp:Button CssClass="btn2" ID="Button1" runat="server" Text="Save" />
                    <asp:Button CssClass="btn1" ID="Button2" runat="server" Text="Back" />
                    <asp:Button CssClass="btn2" ID="Button3" runat="server" Text="Add Attendies" /></td>
            </tr>
        </table>
    
    </div>
        <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT Dept_ID, Dept_Name FROM Department"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_SubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT SubDept_Name, SubDept_Id, Dept_Id FROM SubDepartment WHERE (Dept_Id = @Dept_Id)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_Id" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name, EmpID, DeptID, SubDeptId FROM Employee WHERE (DeptID = @DeptID) AND (SubDeptId = @SubDeptId)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_Department" Name="DeptID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:HiddenField ID="HiddenField1" runat="server" />

    </form>
</body>
</html>
