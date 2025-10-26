<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_RegisterApplicant, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

<style type="text/css">
tr
{
    line-height:2;
    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 100%; margin: aut0;" class="bxmain inner_content">
        <h2>
            <span>Register Applicant</span></h2>
        <table style="width: 100%; margin: auto">
            <tr>
                <td style="width: 45%; text-align: right;" align="right">
                    CNIC # :&nbsp;
                </td>
                <td>
                    <%--<asp:TextBox ID="txtobxCnic" runat="server" CssClass="input_txt"></asp:TextBox>--%>                      
                                <asp:TextBox ID="tbxCNIC" runat="server" MaxLength="13" SkinID="intdata" ></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="mainApp" runat="server" ControlToValidate="tbxCNIC"
                        ErrorMessage="*">*</asp:RequiredFieldValidator>
                </td>
            </tr>
    <%--        <tr>
                <td align="right">
                    Phone # :&nbsp;
                </td>
                <td>
                 
                                
                   <asp:TextBox ID="txtboxPhone" SkinID="intdata"  MaxLength="11" runat="server" CssClass="input_txt"></asp:TextBox> 
                    <span style="color: #ff0000"> </span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="mainApp" runat="server" ControlToValidate="txtboxPhone"
                        ErrorMessage="*">*</asp:RequiredFieldValidator>
                </td>
            </tr>--%>
            <%--<tr>
                <td align="right">
                    Advertisement :&nbsp; </td>
                <td>
                 
                                
                    <asp:DropDownList ID="DDL_Advertizement" runat="server" Width="202px" 
                        AutoPostBack="True" 
                        onselectedindexchanged="DDL_Advertizement_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>--%>
            <%--<tr>
                <td align="right">
                    Post :</td>
                <td>
                 
                                
                    <asp:DropDownList ID="DDL_Posts" runat="server" Width="202px">
                    </asp:DropDownList>
                </td>
            </tr>--%>
            <tr>
                <td style="text-align: center" colspan="2">
                  <span style="padding-top:10px;">  <asp:Button ID="btnGo" runat="server" 
                        Text="Go" ValidationGroup="mainApp" onclick="btnGo_Click" /></span>
                </td>
            </tr>
        </table>
    </div>
    <asp:Panel ID="PanelConfirmPassword" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
              
                <table width="100%">                   
                    <tr>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                       <td>Password:</td>
                        <td>
                            <asp:TextBox  ID="txtPassword" TextMode="Password" runat="server"></asp:TextBox>
                            <asp:Label ID="lblWarning" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                     <tr style="line-height: 3;">
                       
                        <td style="padding-left: 20px; text-align: center" colspan="2"> 
                            <asp:Button ID="Button2" runat="server" Text="Submit" OnClick="Button2_Click" />  
                              <asp:Button ID="Button1" runat="server" Text="Close" OnClick="Button1_Click" />                       
                           
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
