<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="~/RecordManagement/Document_Issued_Details.aspx.cs" AutoEventWireup="true" Inherits="RecordManagement_Document_Issued_Details" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
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
    Document Issue Summary   
</div>--%>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span style="font-size: 20px ! important">Document Issue Summary</span></h2>
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
                            <asp:ListItem Text=" ---  All --- " Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="padding-left: 322px;">
                        <asp:Button ID="btnGrid" Text="View Grid" runat="server" OnClick="btnGrid_Click" />
                        <asp:Button ID="btnReport" Text="View Report" runat="server" OnClick="btnReport_Click" />

                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="Sql_DocumentIssueDeatils" runat="server" ConnectionString="<%$ ConnectionStrings:Record_ManagementConnectionString %>"
                SelectCommand="usp_Documents_Issued_Details" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="SubDept_Id" Type="Int32" />
                    <asp:Parameter Name="StartDate" Type="DateTime" />
                    <asp:Parameter Name="EndDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="Sql_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                SelectCommand="SELECT SubDept_Id,SubDept_Name From SubDepartment"></asp:SqlDataSource>
        </div>
    </div><hr />
    <table width="100%">
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" Width="100%"
                    AutoGenerateColumns="False" Visible="False"
                    DataSourceID="Sql_DocumentIssueDeatils" EnableModelValidation="True">
                    <Columns>
                        <asp:BoundField DataField="SubDept_Name" HeaderText="Department Name" />
                        <asp:BoundField DataField="Files_Issued" HeaderText="Files Issued" />
                        <asp:BoundField DataField="Date_time" HeaderText="Date_time"
                            SortExpression="Date_time" />
                        <asp:BoundField DataField="Patient_Record_File_Id"
                            HeaderText="Patient_Record_File_Id" SortExpression="Patient_Record_File_Id" />
                        <asp:BoundField DataField="Issue_Date" HeaderText="Issue_Date"
                            SortExpression="Issue_Date" />
                        <asp:BoundField DataField="Issued_To" HeaderText="Issued_To"
                            SortExpression="Issued_To" />
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

