<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="PatientCounterWiseDiscount.aspx.cs" Inherits="Patient_Billing_PatientCounterWiseDiscount" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
    <div class="bxmain inner_content" style="width:100%; margin-bottom:5px;">
        <h2>
            <span>Discount Type Wise Patient</span>
        </h2>
        <table>
              <tr>
            <td align="right">Hospital :</td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" OnSelectedIndexChanged="ddl_Hospital_SelectedIndexChanged" AutoPostBack="true" >
                    
                </asp:DropDownList> 
            </td>
                  
                    <td align="right">Discount By :</td>
            <td>
                  <asp:DropDownList ID="DropDownDiscountBy" runat="server" Width="202px" OnSelectedIndexChanged="DropDownDiscountBy_SelectedIndexChanged" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
            <tr>
                <td style="width:25%;text-align:right;padding-bottom:5px;">
                    Date From:
                <td style="padding-bottom:5px;width:25%;">
                    <igsch:WebDateChooser Width="200px" ID="startDateChooser" runat="server">
                     <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                <td style="width:25%;text-align:right;padding-bottom:5px;">
                    Date To:
                </td>
                <td style="padding-bottom:5px;width:25%;">
                    <igsch:WebDateChooser Width="200px" ID="endDateChooser" runat="server">
                     <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td style="width:25%;text-align:right;padding-bottom:5px;">
                    Discount Head:
                </td>
                <td style="padding-bottom:5px;">
                    <asp:DropDownList ID="ddlDiscountType" runat="server" >
                    </asp:DropDownList>
                </td>
                <td style="width:25%;text-align:right;padding-bottom:5px;">
                    Department : 
                </td>
                <td style="padding-bottom:5px;width:25%;">
                    <asp:DropDownList ID="ddlDepartment" runat="server" DataTextField="Dept_Name" DataValueField="Dept_ID" ></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width:25%;text-align:right;padding-bottom:5px;">
                    OPD/IPD:</td>
                <td style="padding-bottom:5px;">
                <asp:DropDownList ID="DropDownTypeWise" runat="server">
                <asp:ListItem Selected="True" Value="0">ALL</asp:ListItem>
                    <asp:ListItem Value="OPD">OPD</asp:ListItem>
                    <asp:ListItem Value="IPD">IPD</asp:ListItem>
                </asp:DropDownList>
                </td>
                <td style="width:25%;text-align:right;padding-bottom:5px;">
                    Patient Type :</td>
                <td style="padding-bottom:5px;">
                    <asp:DropDownList ID="DropDownList_PatientType" runat="server">
                    </asp:DropDownList>
                     <td style="text-align:right;padding-bottom:5px;" class="style3">
                         &nbsp;</td>
                <td style="padding-bottom:5px;">
                    &nbsp;</td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="btnReport" Text="Report" runat="server" OnClick="btnReport_Click"/>
                </td>
            </tr>
        </table>
    </div>
    <div style="padding-top:9px;">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
