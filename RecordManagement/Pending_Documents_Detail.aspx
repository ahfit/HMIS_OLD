<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="~/RecordManagement/Pending_Documents_Detail.aspx.cs" AutoEventWireup="true" Inherits="RecordManagement_Pending_Documents_Detail" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="rview1" runat="server"></asp:ScriptManager>

    <%--<div class="bxmain PageHeading">
    
    Pending Document Detail
    
</div>--%>

    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span style="font-size: 20px ! important">Pending Document Detail</span></h2>
        <div class="bxmain" style="margin-left: 200px ! important">
            <table width="100%" cellpadding="0" cellspacing="0" class="tbl_form">


                <tr>
                    <td width="100px" align="right" valign="top">From Date</td>
                    <td width="10px" valign="top">:</td>
                    <td width="290px">
                        <igsch:WebDateChooser ID="WebDateChooser_DateFrom" runat="server"
                            Width="290px">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td width="100px" align="right" valign="top">To Date</td>
                    <td width="10px" valign="top">:</td>
                    <td width="290px">
                        <igsch:WebDateChooser ID="WebDateChooser_DateTo" runat="server"
                            Width="290px">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td width="100px" align="right" valign="top">Department Name</td>
                    <td width="10px" valign="top">:</td>
                    <td width="290px">
                        <asp:DropDownList ID="ddlSubDeptName" runat="server" Width="290px" DataSourceID="Sql_SubDept"
                            DataTextField="SubDept_Name" DataValueField="SubDept_Id" AppendDataBoundItems="true">
                            <asp:ListItem Text=" --- All --- " Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <tr>
                            <td width="100px" align="right" valign="top">Employee Name</td>
                            <td width="10px" valign="top">:</td>
                            <td width="290px">
                                <asp:DropDownList ID="ddlEmployeeName" runat="server" Width="290px" DataSourceID="Sql_EmployeeName"
                                    DataTextField="Employee_Name" DataValueField="EmpID" AppendDataBoundItems="true">
                                    <asp:ListItem Text=" --- All --- " Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="3" style="padding-left: 322px;">
                                <asp:Button ID="btnGrid" Text="View Grid" runat="server" OnClick="btnGrid_Click" />
                                <asp:Button ID="btnReport" Text="View Report" runat="server"
                                    OnClick="btnReport_Click" />

                            </td>
                        </tr>
            </table>



            <asp:SqlDataSource ID="Sql_PendingDocumentDetail" runat="server" ConnectionString="<%$ ConnectionStrings:Record_ManagementConnectionString %>"
                SelectCommand="usp_Pending_Documents_Detail" SelectCommandType="StoredProcedure">

                <SelectParameters>
                    <asp:Parameter Name="EmpID" Type="Int32" />
                    <asp:Parameter Name="SubDeptId" Type="Int32" />
                    <asp:Parameter Name="StartDate" Type="DateTime" />
                    <asp:Parameter Name="EndDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="Sql_EmployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                SelectCommand="SELECT isnull(Prefix,'') + ' ' + Isnull(EFName,'') + ' ' + IsNull(ELName,'') Employee_Name, EmpID From Employee"></asp:SqlDataSource>
            <asp:SqlDataSource ID="Sql_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                SelectCommand="SELECT SubDept_Id,SubDept_Name From SubDepartment"></asp:SqlDataSource>
        </div>
    </div><hr />
    <table width="100%">
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="false" Visible="false"
                    DataSourceID="Sql_PendingDocumentDetail">
                    <Columns>
                        <asp:BoundField DataField="Employee_Name" HeaderText="Issued To Employee" />
                        <asp:BoundField DataField="SubDept_Name" HeaderText="Department Name" />
                        <asp:BoundField DataField="FileNo" HeaderText="File No." />
                        <asp:BoundField DataField="Issue_Date" HeaderText="Issue Date" />
                    </Columns>

                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="false" Width="100%">
                </rsweb:ReportViewer>
            </td>
        </tr>
    </table>

</asp:Content>

