<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="HR_EmployeeContractExpiry, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table>
    <tr>
        <td>
            <asp:Button ID="btnContractExpiry" runat="server" 
                onclick="btnContractExpiry_Click" />
        <td>
            <asp:Button id="btnContractPreExpiry" runat="server" 
                onclick="btnContractPreExpiry_Click" />
         </td>
        
        </td>
        <asp:HiddenField ID="hfldContractExpiry" runat="server" />
        <td></td>
    </tr>

<tr>
        <td></td>
        <td></td>
    </tr>


<tr>
        <td></td>
        <td></td>
    </tr>



</table>


</asp:Content>

