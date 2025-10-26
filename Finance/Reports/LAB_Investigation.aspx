<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="LAB_Investigation.aspx.cs" Inherits="Finance_Reports_LAB_Investigation"  %>
<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="cr" %>--%>
<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="cr" %>


<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="bxmain">
      <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
        <tr>
            <td align="right" >
                Select Hospital :</td>
            <td colspan="2" >
                <asp:DropDownList ID="DropDownList_HospitalId" runat="server" DataSourceID="SqlDataSource_Hospital_Id"
                    DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="88%">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_Hospital_Id" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="SELECT Hospital_ID, Hospital_Name +  '( ' + Hospital_Abb + ' ) '  AS Hospital_Name FROM Hospital ORDER BY Hospital_Name">
                </asp:SqlDataSource>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" >
          Select Date :</td>
            <td >
                <igsch:WebDateChooser ID="WebDateChooser1" runat="server">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" /></td>
            <td ><asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" />
            </td>
        </tr>
    </table>
  </div>
      
      <br />
<div class="rpt_pos">
                <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
                    
  </div>
        
</asp:Content>

