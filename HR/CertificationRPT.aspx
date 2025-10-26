<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_CertificationRPT, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td>
                Start Date:
            </td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooserSdate" runat="server" Value="2004-06-18">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                   
                </igsch:WebDateChooser>
                 <asp:HiddenField ID="hdfsdate" runat="server" />
                <br />
                 <asp:HiddenField ID="hdfEDate" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                End Date:
            </td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooserEdate" runat="server" 
                    Value="2014-06-18">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                   
                </igsch:WebDateChooser>
            </td>
        </tr>

        <tr>
            <td>
                    
                    <asp:RadioButtonList ID="RadioButtonPMDC" runat="server" AutoPostBack="True" 
                        RepeatDirection="Horizontal" 
                        onselectedindexchanged="RadioButtonPMDC_SelectedIndexChanged">
                    <asp:ListItem Value="pmdc" Selected="True" >PMDC</asp:ListItem>
                    <asp:ListItem Value="pnc" >PNC</asp:ListItem>
                    
                    </asp:RadioButtonList>         
            </td>
            <td>
            
            
            </td>
        
        </tr>
        
       <tr>
           
        <td>
            <asp:RadioButtonList ID="RadioButtonListCheckStatus" runat="server" 
                Width="142px" RepeatDirection="Horizontal" AutoPostBack="True" 
                onselectedindexchanged="RadioButtonListCheckStatus_SelectedIndexChanged">
                <asp:ListItem Value="0" Selected="True">Pre Expiry</asp:ListItem>
                <asp:ListItem Value="1">Expired</asp:ListItem>
            
            
            </asp:RadioButtonList>
            
        </td>
        <td>
        
        
        
        </td>
       </tr>
        <tr>
            <td></td>
            <td><ASP:Button ID ="btnShowRPT" runat ="server"  Text="Show Report" 
                    onclick="btnShowRPT_Click"/>
                    
                    </td>
            
        
        </tr>
    </table>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
</asp:Content>
