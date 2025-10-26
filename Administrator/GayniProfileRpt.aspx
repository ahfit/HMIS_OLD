<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="GayniProfileRpt.aspx.cs" Inherits="Pathology_LabTestSummaryReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="bxmain inner_content" style="width:100%">
           <h2><span>Patient Feedback Summary Report</span></h2>
                <table class="style1" style="margin-left:320px">
                  
                    <tr>
           
                        <td class="style2">
                          MRNo:
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="mrNo" runat="server"></asp:TextBox>
                        </td>
                   </tr>
                
                    <tr>
                        <td class="style2">
                            File No:
                        </td>
                        <td>
                            <asp:TextBox ID="fileNo" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <%--  <tr>
                        <td class="style2">
                            Ending Date :
                        </td>
                        <td>
                            <igsch:WebDateChooser ID="endDate" runat="server" 
                                Width="202px">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                    </tr>--%>
                    <tr>
                      
                        <td></td>
                    <td colspan="2" align="center" style="padding-top:20px">
                        
                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="View Report"  
                             CssClass="btn_1" style="float:right"/>
                      </td>
                    </tr>
    </table>
    </div>
    <div style="width: 100%; margin-top:20px; height:auto">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
       <rsweb:ReportViewer ID="ReportViewer1"  runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>



</asp:Content>

