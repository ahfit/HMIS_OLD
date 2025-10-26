<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="DonationSummeryReport.cs" Inherits="Finance_DonationSummeryReport" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
 <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span> Donation Summery Report</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
               
                <td align="right" width="50%" valign="top">
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                        <tr>
                            <td align="right" width="40%">From Date : </td>
                            <td width="50%">
                                
                                <igsch:WebDateChooser ID="WebDateChooser_SDate" runat="server"
                                    Width="202px">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>

                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">To Date : </td>
                            <td width="50%">
                                
                                <igsch:WebDateChooser ID="WebDateChooser_EDate" runat="server"
                                    Width="202px">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>

                            </td>
                        </tr>
                     
                        <tr>
                            <td align="right" width="40%">Donation Type : </td>
                            <td align="left" width="60%">
                                <asp:DropDownList ID="ddlExpanse" runat="server"
                                    DataTextField="E_Name" DataValueField="E_Code">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right" width="40%">Received By : </td>
                            <td align="left" width="60%">
                                <asp:DropDownList ID="ddlreceived" runat="server" DataSourceID="SDS_Received"
                                    DataTextField="Name" DataValueField="EmpID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Received" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    SelectCommand="select 0 EmpID, 'All' as Name union select  distinct Employee.EmpID,Employee.Name  from Employee inner join Donation on Donation.EntryBy=Employee.EmpID"></asp:SqlDataSource>
                            </td>
                        </tr>
                         
                        <%--<tr>
                            <td align="right" width="40%">Payment Type : </td>
                            <td align="left" width="60%">
                                <asp:DropDownList ID="ddlPaymentMode" runat="server" AutoPostBack="true" >
                                    <asp:ListItem Text="Cash" Selected="True" Value="Cash">Cash</asp:ListItem>
                                    <asp:ListItem Text="Cheque" Value="Bank">Cheque</asp:ListItem>
                                    <asp:ListItem Text="Online" Value="Online">Online</asp:ListItem>
                                </asp:DropDownList>

                            </td>
                        </tr>--%>
                      
                        
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnreport" runat="server" Text="Show Report" OnClick="btnreport_Click" />
                </td>
            </tr>
        </table>
    </div>
    <br />
     <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           
             <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" >
    </rsweb:ReportViewer>
</asp:Content>

