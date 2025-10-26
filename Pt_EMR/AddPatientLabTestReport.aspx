<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="AddPatientLabTestReport.aspx.vb" Inherits="Pt_EMR_AddPatientLabTestReport" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
      
       <div class="bxmain inner_content">
                 <h2><span>Patient Lab History Report</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" style="margin-left:320px">
          <tr>
                <td align="right">
                   Mr # :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Reg" runat="server"></asp:TextBox>
                </td>
               
            </tr>
            <tr>
                  <td align="right">
                  
                </td>
               <td>
                    <asp:Button ID="btnReport" runat="server" Text="Show Report" onclick="btnReport_Click1" />
                </td>
            </tr>
         </table>
    </div>

      <asp:Panel ID="pnlReport" runat="server" Visible="false">
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
    </asp:Panel>
    <asp:SqlDataSource ID="SqlDataSource_Save_Info" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Insert_Admin_Services" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
        
            <asp:ControlParameter ControlID="TextBox_Reg" DefaultValue="" Name="S_Amount"
                PropertyName="Text" Type="Int32" />
           
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>

