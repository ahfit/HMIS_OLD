<%@ Page Title="" Language="C#" EnableTheming="false" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EmployeeGenericTemplateReport.aspx.cs" Inherits="HR_EmployeeGenericTemplateReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function printDiv() {

            var divToPrint = document.getElementById('DivIdToPrint');

            var newWin = window.open('', 'Print-Window');

            newWin.document.open();

            newWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');

            newWin.document.close();

            setTimeout(function () { newWin.close(); }, 10);

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type='button' id='btn' value='Print' onclick='printDiv();' />
    <div id="DivIdToPrint">

    <table width="100%" class="table-condensed" cellpadding="10px" cellspacing="3px" id="tbl">
        <tr>
            <td align="right">
                <asp:Label ID="lblDate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblReferenceNo" runat="server"></asp:Label>
                
            </td>
            
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label1" Text="To ," Font-Bold="true" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblName" Font-Bold="true" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblDesignation" Font-Bold="true" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblDepartment" Font-Bold="true" runat="server"></asp:Label>
            </td>
        </tr>
         <tr>
            <td align="center">
                <asp:Label Font-Underline="true" ID="lblTemplateName"  Font-Bold="true" runat="server"></asp:Label>
            </td>
        </tr>
         <tr>
            <td>
                <asp:Label ID="lblSalutation"  Font-Bold="true" runat="server"></asp:Label>
            </td>
        </tr>
         <tr>
            <td class="table">
                 <asp:PlaceHolder  ID="placeholder" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
    </table>
    </div>

    <br />
    <br />








   


    <%--<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
       
    </rsweb:ReportViewer>--%>
</asp:Content>
