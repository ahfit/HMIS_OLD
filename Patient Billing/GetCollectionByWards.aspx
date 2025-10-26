<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Patient_Billing_GetCollectionByWards, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
 <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           <div style="width:100%;" class="main_Wrapper bxmain inner_content">
        <h2>
            <span>Hospital Ward Collection Report </span></h2>
            <table class="diagnosis_list">
        <tr>
            <td align="right">
                <strong>From Date :</strong></td>
            <td>
                     <igsch:WebDateChooser ID="Wdc_start" runat="server" 
                        Width="122px">
                        
                    </igsch:WebDateChooser>
                     <asp:HiddenField ID="HiddenFieldStartDate" runat="server" />
                   
                </td>
        </tr>
        <tr>
            <td align="right">
                <strong>To Date :</strong></td>
            <td>
                     
                     <igsch:WebDateChooser ID="wdc_End_date" runat="server"
                        Width="122px">
                      
                       
                    </igsch:WebDateChooser>
                       <asp:HiddenField ID="HiddenFieldEndDate" runat="server" />
                     
                    </td>
        </tr>
         <tr>
            <td align="right">
                <strong>Department :</strong></td>
            <td>
                     
<asp:DropDownList ID="ddlSubDept" runat="server" ></asp:DropDownList>                                                                                                     
                    </td>
        </tr>
        <tr>
            <td align="right">
                <strong>Ward :</strong></td>
            <td>
                     
<asp:DropDownList ID="ddlWard" runat="server" ></asp:DropDownList>                     
                    </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_viewreport" runat="server" Text="View Report" 
                    onclick="btn_viewreport_Click" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
           </div>
             <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" >
    </rsweb:ReportViewer>
    

   


</asp:Content>

