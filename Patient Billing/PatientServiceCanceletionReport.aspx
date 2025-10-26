<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="PatientServiceCanceletionReport.aspx.cs" Inherits="Patient_Billing_PatientServiceCanceletionReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 38%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 100%" class="bxmain inner_content">
        <h2>
            <span>Patient Service Canceletion Report</span></h2>
        <table>
             <tr>
         <td align="right" style="width: 10%;">
                Hospital:   
            </td>
            <td style="width: 20%;">
              
    <asp:DropDownList ID="ddHospital" runat="server" DataSourceID="SDS_Hospital" 
                DataTextField="Hospital_Name" DataValueField="Hospital_ID" >
            </asp:DropDownList>
                 <asp:SqlDataSource ID = "SDS_Hospital" runat = "server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource> 

            </td>
            <td align="right" style="width: 10%;">
                Department:
            </td>
            <td style="width: 20%;">
                <asp:DropDownList ID="ddlDepartment" runat="server">
                </asp:DropDownList>
            </td>
            <td align="right" style="width: 10%;">
                Patient Category:
            </td>
            <td style="width: 20%;">
                <asp:DropDownList ID="ddlPatientType" runat="server">
                </asp:DropDownList>
            </td>
            </tr>
        <tr>
            <td align="right" style="width: 10%;">
                Patient Type
            </td>
            <td style="width: 20%;">
                <asp:DropDownList ID="ddlOPDIPD" runat="server">
                        <asp:ListItem Value="All" Text="All" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="OPD" Text="OPD"></asp:ListItem>
                        <asp:ListItem Value="IPD" Text="IPD"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="right">
                From Date:
            </td>
            <td>
              
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
            </td>
            <td align="right">
                To Date:
            </td>
            <td>
               
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
            </td>
            
          
        </tr>
            
            <tr>
                <td colspan="6" align="center">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" ShowToolBar="true"
            Height="650px">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
