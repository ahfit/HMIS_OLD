<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="BirthAndDeathReport.aspx.cs" Inherits="DoctorShare_BirthAndDeathReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 100%;
        }

        .style2 {
            width: 386px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
        <div class="bxmain inner_content" style="width: 100%">
            <h2><span>Patient Status Report</span></h2>

            <table class="style1">
                <tr>
                    <td width="40%" align="right">Start Date
                    </td>
                    <td width="60%" align="left">
                        <asp:TextBox runat="server" ID="txtSDate" TextMode="Date" />
                    </td>
                </tr>
                <tr>
                    <td width="40%" align="right">End Date
                    </td>
                    <td width="60%" align="left">
                        <asp:TextBox runat="server" ID="txtEDate" TextMode="Date" />
                    </td>
                </tr>
                <tr>
                    <td width="40%" align="right">Reg No
                    </td>
                    <td width="60%" align="left">
                        <asp:TextBox runat="server" ID="regno" />
                    </td>
                </tr>
                <tr>
                    <td width="40%" align="right">Status
                    </td>
                    <td width="60%" align="left">
                        <asp:DropDownList ID="ddl_Status" runat="server">
                            <asp:ListItem Value="All">All</asp:ListItem>
                            <asp:ListItem Value="1">Alive</asp:ListItem>
                            <asp:ListItem Value="2">Death</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>

                <tr>

                    <td colspan="2" align="center">
                        <asp:Button ID="btnReport" runat="server" Text="Report" OnClick="btnReport_Click" />
                    </td>
                </tr>
            </table>
        </div>
    
     <div style="width:100%">
        
         <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">

         </rsweb:ReportViewer>
    </div>
</asp:Content>
