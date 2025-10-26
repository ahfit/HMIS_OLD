<%@ Page Language="VB" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="false" CodeFile="Sample_Slip.aspx.vb" Inherits="Pathology_Sample_Slip"  %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
        ToolPanelView="None" PrintMode="ActiveX" />
</asp:Content>

