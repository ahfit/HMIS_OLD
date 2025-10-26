<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Budget_TransferHead.aspx.cs" Inherits="Budget_TransferHead" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:scriptmanager runat="server"></asp:scriptmanager>


         <div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" style="padding-top:25px">

       <tr>
           <td  align="right" width="40%">  Budget Year:   </td>
           
           <td style="width:70px">
                <asp:DropDownList ID="ddlBudget" AutoPostBack="true" OnSelectedIndexChanged="ddlBudget_SelectedIndexChanged" runat="server" >

            </asp:DropDownList>
           </td>
       </tr>
            </table>

      
          
        </div>
    <div style="margin-top:30px">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width ="100%"></rsweb:ReportViewer>
    </div>

</asp:Content>

