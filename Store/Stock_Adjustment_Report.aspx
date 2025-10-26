<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Stock_Adjustment_Report.aspx.cs" Inherits="Store_Stock_Adjustment_Report" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
           <tr>
                <td align="right" width="40%">Department :</td>
                <td align="left" width="60%">
                    
                    <asp:DropDownList ID="ddlDepartment" DataTextField="SubDept_Name" DataValueField="SubDept_Id"  runat="server" Width="256px"></asp:DropDownList>
                </td>
            </tr>
        <tr>
            <td align="right" width="40%">Start Date:
            </td>
            <td width="60%">
                <asp:TextBox ID="startDate" runat="server" TextMode="Date"  Width="256px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" width="40%" class="style1">End Date:
            </td>
            <td width="60%" class="style1">
               
                <asp:TextBox ID="endDate" runat="server" TextMode="Date"  Width="256px"></asp:TextBox>

            </td>
      
        </tr>
        <tr>

            <td colspan="2" align="center">
                <asp:Button ID="btnSearch" runat="server" Text="View Report"
                    OnClick="btnSearch_Click" />
              
            </td>
        </tr>
    </table>


    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"></rsweb:ReportViewer>


</asp:Content>

