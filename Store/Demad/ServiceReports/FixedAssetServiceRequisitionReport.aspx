<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Store/Demad/ServiceReports/FixedAssetServiceRequisitionReport.cs" Inherits="Store_FixedAssetServiceRequisitionReport" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%;">
<h2><span>Fixed Assets Service Requisition Report</span></h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<table style="width: 100%;">
        <tr>
            <td align="right">
                Requisition # :
            </td>
            <td>
                <asp:TextBox ID="txtRequisitionNo" Width="230px" runat="server"></asp:TextBox>
            </td>
            <td align="right">
                Department :
            </td>
            <td>
                <asp:DropDownList ID="ddlDepartment" Width="230px" runat="server" 
                    DataSourceID="sqlDsDepartment" DataTextField="Dept_Name" 
                    DataValueField="Dept_ID" AutoPostBack="True" 
                    onselectedindexchanged="ddlDepartment_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlDsDepartment" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
                    
                    SelectCommand="select 0 as Dept_ID, '---ALL---' Dept_Name Union  SELECT Department.Dept_ID, Department.Dept_Name FROM Department  order by Dept_Name"></asp:SqlDataSource>
            </td>
        </tr>
       
        <tr>
            <td align="right">
                From Date :
            </td>
            <td>
                <igsch:WebDateChooser Width="230px" ID="wdcFromDate" runat="server">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
            <td align="right">
                To Date :
            </td>
            <td>
                <igsch:WebDateChooser Width="230px" ID="wdcToDate" runat="server">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSearchRequisition"  runat="server" Text="Search" OnClick="btnSearchRequisition_Click" />
            </td>
            <td>
            </td>
        </tr>
      
    </table>
    </div>
    <br />

       
<div style="width: 100%; margin-top:20px;">

        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>

   
</asp:Content>

