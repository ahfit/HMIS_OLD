<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Pathology_AddLabConsultant, App_Web_dwve4450" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 100%;
        }

        .style2 {
            width: 386px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Consultant Pathology Reports</span></h2>

        <table class="style1">
            <tr>
                <td align="right" class="style2">
                    <b>Doctor Name :</b></td>
                <td>
                    <asp:TextBox ID="txtDocName" runat="server" Width="202px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style2">
                    <strong>Doctor Qualification :</strong></td>
                <td>
                    <asp:TextBox ID="txtQuali" Height="70px" TextMode="MultiLine" runat="server" Width="202px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style2">
                    <strong>Doctor Designation :</strong></td>
                <td>
                    <asp:TextBox ID="txtDesignation" runat="server" Width="202px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">&nbsp;</td>
                <td>
                    <asp:Button ID="btn_AddConsultant" runat="server" Text="Add Consultant" Width="202px"
                        OnClick="btn_AddConsultant_Click" />
                    <asp:Label ID="lblmg" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <%--<td colspan="1" style="width:20px"></td>--%>
                <td align="center" colspan="2">&nbsp;</td>
            </tr>

        </table>
    </div>
</asp:Content>

