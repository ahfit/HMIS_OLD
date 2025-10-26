<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_Disciplinary_action, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
    <%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%">
        <tr>
            <td>
                Warning To Employee
            </td>
            <td>
                <asp:DropDownList ID="ddlWarningToEmployee" runat="server" 
                    DataSourceID="sdsEmployee" DataTextField="Name" DataValueField="EmpID"></asp:DropDownList>
                <asp:SqlDataSource ID="sdsEmployee" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                    SelectCommand="SELECT EmpID, ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name FROM Employee"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Action Type
            </td>
            <td>
                <asp:DropDownList ID="ddlActionType" runat ="server">
                    <asp:ListItem Value="0">Warning</asp:ListItem>
                    <asp:ListItem Value="1">Counseling</asp:ListItem>
                  
                
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                Issue By
            </td>
            <td>
                <asp:DropDownList ID="ddlIssueBy" runat="server" DataSourceID="sdsIssueBy" 
                    DataTextField="Name" DataValueField="EmpID"></asp:DropDownList>
                <asp:SqlDataSource ID="sdsIssueBy" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                    SelectCommand="SELECT ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name, Employee.EmpID FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID WHERE (Department.Dept_ID = 149)">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Record By
            </td>
            <td>
                <asp:DropDownList ID="ddlRecordBy" runat="server" DataSourceID="sdsRecordBy" 
                    DataTextField="Name" DataValueField="EmpID"></asp:DropDownList>
                <asp:SqlDataSource ID="sdsRecordBy" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                    SelectCommand="SELECT EmpID, ISNULL(EFName, '') + + ISNULL(EMName, '') + + ISNULL(ELName, '') AS Name FROM Employee WHERE (EmpID = @empid)">
                    <SelectParameters>
                        <asp:SessionParameter Name="empid" SessionField="emp_id" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Issue Date
                <asp:HiddenField ID="hfldIssueDate" runat="server" />
            </td>
            <td>
                          <igsch:WebDateChooser ID="wdc_IssueDate" Width="250px" runat="server" CssClass="drop_date"
                        Visible="true">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                           
            </td>
            </tr>
            <tr>
                <td>
                    Remarks
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat ="server" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>

              <tr>
                <td>
                    <asp:Button ID="Save" runat ="server" Text="Save" onclick="Save_Click" />
                </td>
                <td>
                 
                    <asp:SqlDataSource ID="sdsinsertemployeeWarning" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                        InsertCommand="INSERT INTO [Disciplinary_action ] (EmpId, issueByID, recordByID, issueDate, Remarks) VALUES (@EmpId, @issueByID, @recordByID, @issueDate, @Remarks)" 
                        ProviderName="<%$ ConnectionStrings:HRConnectionString.ProviderName %>">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="ddlWarningToEmployee" Name="EmpId" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddlIssueBy" Name="issueByID" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddlRecordBy" Name="recordByID" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="hfldIssueDate" Name="issueDate" 
                                PropertyName="Value" />
                            <asp:ControlParameter ControlID="txtRemarks" Name="Remarks" 
                                PropertyName="Text" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                 
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="gvEmployeeWarningInfo" runat="server" Width="100%"></asp:GridView>
                </td>
            </tr>
    </table>
</asp:Content>
