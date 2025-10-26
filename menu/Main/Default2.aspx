<%@ page language="VB" autoeventwireup="false" inherits="Default2, App_Web_ppbttiod" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebNavigator.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebNavigator" TagPrefix="ignav" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        &nbsp;<br />
        &nbsp;&nbsp;
        <table border="0" cellpadding="0" cellspacing="0"  
             width="100%">
            <!--DWLayoutTable-->
            <tr>
                <td style="width: 338px">
                </td>
                <td width="681">
                </td>
            </tr>
            <tr>
                <td align="right"  style="width: 338px; height: 25px" valign="middle">
                    <span style="width: 148px">&nbsp;Department :&nbsp;</span></td>
                <td style="height: 25px" valign="middle">
                    <asp:DropDownList ID="DropDownList_New_Dept" runat="server" AutoPostBack="True" Css
                        DataSourceID="SqlDataSource_Dept" DataTextField="Dept_Name" DataValueField="Dept_ID"
                        Width="250px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right"  style="width: 338px; height: 25px" valign="middle">
                    Sub Department :&nbsp;</td>
                <td style="height: 25px" valign="middle">
                    <asp:DropDownList ID="DropDownList_New_SubDept" runat="server" AutoPostBack="True"
                        Css DataSourceID="SqlDataSource_Sub_Dept" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" Width="250px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right"  style="width: 338px; height: 25px" valign="middle">
                    Designtion :&nbsp;
                </td>
                <td style="height: 25px" valign="middle">
                    <asp:DropDownList ID="DropDownListDesignation" runat="server" AutoPostBack="True"
                        Css DataSourceID="SqlDataSourceEDesignation" DataTextField="Designation_Name"
                        DataValueField="Designation_ID" Width="250px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td style="width: 338px" valign="middle">
                    <span style="width: 148px">&nbsp;&nbsp;</span></td>
                <td valign="middle">
                    <asp:SqlDataSource ID="SqlDataSource_Dept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT [Dept_ID], [Dept_Name] FROM [Department] order by [Dept_Name]">
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_Sub_Dept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="Select_SubDept" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_New_Dept" Name="Dept_Id" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceEDesignation" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT Designation_Name, Designation_ID, Min_PayScale FROM Designation ORDER BY Min_PayScale desc,Designation_Name">
                    </asp:SqlDataSource>
                    <br style="line-height: 8pt" />
                    <asp:Button ID="ButtonSave" runat="server" CssClass="bt1up" Text="Show" />
                </td>
            </tr>
            <tr>
                <td  colspan="2" rowspan="7" valign="middle">
                    &nbsp;
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
        </table>
        <asp:GridView ID="GridViewMainPage" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSourceGrid">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                    SortExpression="EmpID" />
                <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName" ReadOnly="True"
                    SortExpression="EmployeeName" />
                <asp:BoundField DataField="UserName" HeaderText="UserName" ReadOnly="True" SortExpression="UserName" />
                <asp:BoundField DataField="Password" HeaderText="Password" ReadOnly="True" SortExpression="Password" />
                <asp:TemplateField HeaderText="MainPage" SortExpression="MainPage">
                    <EditItemTemplate>
                        &nbsp;<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourcePage"
                            DataTextField="MainPage" DataValueField="MainPage_ID" SelectedValue='<%# Bind("MainPage_ID", "{0}") %>'
                            Width="193px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourcePage" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>" SelectCommand="SELECT MainPage_ID, MainPage FROM MainPages">
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("MainPage") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="MainPage_URL" HeaderText="MainPage_URL" ReadOnly="True"
                    SortExpression="MainPage_URL" />
                <asp:BoundField DataField="Dept_Name" HeaderText="Dept_Name" ReadOnly="True" SortExpression="Dept_Name" />
                <asp:BoundField DataField="SubDept_Name" HeaderText="SubDept_Name" ReadOnly="True"
                    SortExpression="SubDept_Name" />
                <asp:BoundField DataField="Designation_Name" HeaderText="Designation_Name" ReadOnly="True"
                    SortExpression="Designation_Name" />
                <asp:BoundField DataField="MainPage_ID" HeaderText="MainPage_ID" InsertVisible="False"
                    ReadOnly="True" SortExpression="MainPage_ID" />
            </Columns>
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>" SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS EmployeeName, Login.UserName, Login.Password, MainPages.MainPage, MainPages.MainPage_URL, Department.Dept_Name, SubDepartment.SubDept_Name, Designation.Designation_Name, MainPages.MainPage_ID FROM Login INNER JOIN MainPages ON Login.MainPage_Id = MainPages.MainPage_ID INNER JOIN Employee ON Login.EmpID = Employee.EmpID INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN SubDepartment ON Employee.SubDeptId = SubDepartment.SubDept_Id INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.DeptID = @Dept) AND (Employee.SubDeptId = @SubDept) AND (Employee.ActiveStatus = 1) ORDER BY EmployeeName"
            UpdateCommand="Update_Employee_Main_Page" UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:ControlParameter ControlID="HiddenField1" Name="MainPage_Id" PropertyName="Value"
                    Type="Int32" />
                <asp:ControlParameter ControlID="HiddenField2" Name="EmpID" PropertyName="Value"
                    Type="Int32" />
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_New_Dept" Name="Dept" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_New_SubDept" Name="SubDept" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        </div>
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:HiddenField ID="HiddenField2" runat="server" />
    </form>
</body>
</html>
