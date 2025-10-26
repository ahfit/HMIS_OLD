<%@ Page Language="VB" AutoEventWireup="false" CodeFile="View_Work_List.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Pathology_View_Work_List" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<div class="bxmain">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right" width="40%">Main Group :</td>
    <td width="60%"><asp:DropDownList ID="DropDownListMain" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceMainGroup"
                    DataTextField="TGName" DataValueField="TGID" Width="250px">
        </asp:DropDownList></td>
  </tr>
</table>
</div>
<br />


<asp:GridView ID="GridView_WorkingList" runat="server" CssClass="Grid_1" EmptyDataText="                          " Font-Size="Larger" Width="100%">
        <RowStyle BorderStyle="Solid" Font-Size="Larger" />

    </asp:GridView>

 <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_OT_ConnectionString  %>"
                    ProviderName="<%$ ConnectionStrings:Admin_OT_ConnectionString .ProviderName %>" SelectCommand="SELECT TGID, TGName FROM TestGroup">
                </asp:SqlDataSource>
<br />
<br />


  </asp:Content>