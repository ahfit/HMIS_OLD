<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AttendanceDetailDaily.aspx.cs" Inherits="Machine_Attendance_AttendanceDetailDaily" MasterPageFile="~/hacims_masterpage_admin.master" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Daily Detail Attendance Report</span></h2>

        <table class="tbl_form">
            <tr>
                <td align="right">
                    <strong>Hospital :</strong> </td>
                <td>
                    <asp:DropDownList ID="DDL_Company" Enabled="false" runat="server" CssClass="drop_down"
                        DataSourceID="SDS_Company" DataTextField="Hospital_Name"
                        DataValueField="Hospital_ID"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Company" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>




                </td>

                <td align="right">
                    <strong> Department :</strong></td>
                <td>
                    <asp:DropDownList ID="DDL_Branch" OnSelectedIndexChanged="DDL_Branch_SelectedIndexChanged" runat="server"
                        DataTextField="SubDept_Name" CssClass="drop_down"
                        DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>





                </td>

                <td align="right"><strong>From Date:</strong></td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
                </td>
                 <td align="right"><strong>To Date:</strong></td>
                <td>
                    <igsch:WebDateChooser ID="ToDate" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                </td>

                <td align="right">
                    <strong>Select Employee :</strong></td>
                <td>
                    <asp:DropDownList ID="DDL_Sold_By" runat="server"
                        CssClass="drop_down" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>

                </td>
                <td>
                    <asp:Button ID="btn_Report" runat="server" CssClass="btn_hacims" Text="View Report" OnClick="btn_Report_Click" />
                </td>
            </tr>
        </table>
    </div>


    <input style="visibility: hidden" type="button" value="print" onclick="printSpecial()" id="btn_print" autofocus="autofocus" onload="Set_focus()" />
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
    </rsweb:ReportViewer>

</asp:Content>

