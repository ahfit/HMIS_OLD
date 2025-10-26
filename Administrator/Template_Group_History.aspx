<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Template_Group_History, App_Web_hbh2gz45" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width:98%">
        <h2><span>History Examination of Template</span></h2>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td align="right" width="40%">Template:
                </td>
                <td align="left">
                    <asp:DropDownList runat="server" ID="DDL_Template" DataTextField="Template_Name" DataValueField="Template_Id"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Type:
                </td>
                <td align="left">
                    <asp:RadioButtonList runat="server" ID="RadioHistoryExam">
                        <asp:ListItem Selected="True" Value="1" Text="History" />
                        <asp:ListItem Value="2" Text="Examination" />
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" Text="Search" OnClick="btnSearch_Click" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           
             <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="80%" 
        Height="500px">
    </rsweb:ReportViewer>
    </div>
</asp:Content>
