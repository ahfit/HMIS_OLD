<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_Employee_Status_change, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="diagnosis_list">
        <tr>
            <td align="right"> <strong>Active/De-Active By:</strong>
                </td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    onselectedindexchanged="DropDownList1_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" Width="100%" >
    </asp:GridView>
  <%--  <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ connectionstrings:HRConnectionstring %>"
    SelectCommand="SELECT     ISNULL(Employee.EFName, '') + '' + ISNULL(Employee.EMName, '') + '' + ISNULL(Employee.ELName, '') AS EName, 
                      CASE WHEN Employee.ActiveStatus = 1 THEN 'Active' WHEN Employee.ActiveStatus = 0 THEN 'Deactive' ELSE 'Ex-Employee' END AS ActiveStatus, 
                      ISNULL(enter_by.EFName, '') + '' + ISNULL(enter_by.EMName, '') + '' + ISNULL(enter_by.ELName, '') AS ByEmp
FROM         Employee_Status_Change INNER JOIN
                      Employee AS enter_by ON Employee_Status_Change.ByEmp_ID = enter_by.EmpID LEFT OUTER JOIN
                      Employee ON Employee_Status_Change.Emp_ID = Employee.EmpID
WHERE     (enter_by.EmpID = @EmpID)"
    >
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="EmpID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
</asp:Content>

