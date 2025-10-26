<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="CashReportCategoryWise.aspx.cs" Inherits="Patient_Billing_CashReportCategoryWise" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
            
    <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Cash Counter Receipt List</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>             
                <td align="right" style="width: 10%;">
                    <b>From Date : </b>
                </td>
                <td style="width: 10%;">
     
                    <asp:TextBox runat="server" ID="wdcStartDate" TextMode="Date" />
                </td>
                <td align="right" style="width: 10%;">
                    <b>To Date : </b>
                </td>
                <td style="width: 10%;">

                    <asp:TextBox runat="server" ID="wdcEndDate" TextMode="Date" />
                </td>
                
            </tr>    
            <tr>
                <td align="right" style="width: 10%;">
                  <b>  Select Shift :</b>
                </td>
                <td style="width: 10%;">
     
                     <asp:DropDownList ID="DDL_Shift" runat="server" >
                <asp:ListItem Value="0">All</asp:ListItem>
                <asp:ListItem Value="1">Morning</asp:ListItem>
                <asp:ListItem Value="2">Evening</asp:ListItem>
                <asp:ListItem Value="3">Night</asp:ListItem>
            </asp:DropDownList>
                </td>
                <td align="right" style="width: 10%;">
                    <b>Select Hospital : </b>
                </td>
                <td style="width: 10%;">

                     <asp:DropDownList ID="DDL_Hospital" runat="server" DataSourceID="SDS_Hospital" 
                DataTextField="Hospital_Name" DataValueField="Hospital_ID">
            </asp:DropDownList>
            <asp:SqlDataSource ID = "SDS_Hospital" runat = "server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="SELECT  0 [Hospital_ID], ' All' as [Hospital_Name] Union SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                </td>

            </tr>
             <tr>
        <td align="right" style="width: 10%;">
           <b> Counter Type :</b>

        </td>
        <td width = "50%" >
            <asp:DropDownList ID="DDL_CounterType" runat="server">
            </asp:DropDownList>
            
        </td>
    </tr>        
            <tr>
                 <td align="center" colspan="4">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100px" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
    <asp:ScriptManager ID="manager" runat="server"></asp:ScriptManager>


</asp:Content>

