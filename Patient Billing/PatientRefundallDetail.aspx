<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="PatientRefundallDetail.aspx.cs" Inherits="Patient_Billing_PatientRefundallDetail" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .left
        {
            display: inline-block;
            width: 49%;
            float: left;
            text-align: right;
        }
        .right
        {
            display: inline-block;
            text-align: right;
            padding-left: 4px;
        }
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Patient Refund Details</span></h2>

            <table class="style1" >
                 <tr>
            <td align="right"><strong>Hospital :</td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
                 <tr>
                    <td align="right">
                <asp:Label ID="Label2"  runat="server" >Date From :</asp:Label>
                    </td>
                    <td>
                <igsch:WebDateChooser Width="202px" runat="server" ID="wdcDateFrom">
                </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                <asp:Label ID="Label3" runat="server">Date To :</asp:Label>
                    </td>
                    <td>
                <igsch:WebDateChooser Width="202px" runat="server" ID="WebDateDateTo">
                </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Refund Type :</td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" runat="server" Width="202px" AutoPostBack="true">
                            <asp:ListItem Value="1">Approved</asp:ListItem>
                            <asp:ListItem Value="0">Cancel</asp:ListItem>
                        
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Reg No :</td>
                    <td>
                        <asp:TextBox ID="txtboxRegNo" runat="server" Width="202px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
                        <asp:Button ID="btnSearch" runat="server" 
                Text="Search" onclick="btnSearch_Click" />
                    </td>
                </tr>
        </table>
    </div>
     <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           
          <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" 
        Height="500px">
    </rsweb:ReportViewer>
</asp:Content>
