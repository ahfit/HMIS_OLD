<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EmployeeTransferHistory.aspx.cs" Inherits="HR_EmployeeTransferHistory" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span>Employee Transfer History
            </span>
        </h2>
        <table>
            <tr>
                <td style="width: 74% !important; text-align: right">
                    <strong>Select Campus :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Company" runat="server" CssClass="drop_down"
                       DataSourceID="SDS_Company" DataTextField="Hospital_Name"
                        DataValueField="Hospital_ID"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Company" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>




                </td>
            </tr>
            <tr>
               <td style="width: 74% !important; text-align: right">
                    <strong>Select Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Branch" runat="server"
                        DataSourceID="SDS_Branch" DataTextField="Dept_Name"  CssClass="drop_down"
                        DataValueField="Dept_ID" AutoPostBack="True">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="
SELECT     Dept_ID, Dept_Name
FROM         Department
where Hospital_ID = @HospitalID
ORDER BY Dept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>




                </td>
            </tr>
            
            <tr>
                <td style="width: 74% !important; text-align: right">
                    <strong>Select Employee :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Sold_By" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Employee" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>

                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="
SELECT     EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee
WHERE     (@DeptID =0 or DeptID = @DeptID) and ActiveStatus='true'"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="DeptID"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>




                </td>
            </tr>
            <tr style="display:none">
                <td align="right" class="style1"><strong>From Date:</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_StartDate" runat="server"  CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
                </td>
            </tr>

            <tr style="display:none">
                <td align="right" class="style1"><strong>To Date:</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_EndDate" runat="server"  CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                </td>
            </tr>
        </table>
        <div style="text-align: center; margin-top: .5%">
            <asp:Button ID="btnSearch" Text="Search" runat="server" OnClick="btnSearch_Click" />
        </div>
    </div>
    <div style="width: 100%">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>

</asp:Content>