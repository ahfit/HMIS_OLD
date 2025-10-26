<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Blood_Bank_Donnors_Particulars_Rpt, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="cr" %>
 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
 <div class="bxmain">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
         <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
            <tr>
                <td align="right" width="40%" >
                    Previous Assesment :</td>
                <td >
                    <asp:DataList ID="DataList_PrevAssesment" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="DataList_PrevAssesment_SelectedIndexChanged">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton_Assement" runat="server" CommandName="select" OnClick="LinkButton_Assement_Click"
                                Text='<%# Eval("Asses_Datetime") %>'></asp:LinkButton>&nbsp;
                            <asp:HiddenField ID="HiddenField_Assesment_Id" runat="server" Value='<%# Eval("Assesment_Id") %>' />
                        </ItemTemplate>
                    </asp:DataList></td>
            </tr>
        </table>
        <asp:HiddenField ID="HiddenField_D_Reg_No" runat="server" />
     <asp:HiddenField ID="HiddenField_VisitNo" runat="server" />
    
    </div>
        <asp:HiddenField ID="HiddenField_AssesmentID" runat="server" />
        <br />
        <div class="rpt_pos">
       
        </div>
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server"></rsweb:ReportViewer>
    </div>
        <br />

     </asp:Content>