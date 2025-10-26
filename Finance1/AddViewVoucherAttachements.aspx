<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AddViewVoucherAttachements.aspx.cs" Inherits="Finance_AddViewVoucherAttachements" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style="width:100%;">
        <h2><span>Add / View Attachment(s)</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="40%">
                    File : 
                </td>
                <td align="left" width="60%">
                    <asp:FileUpload ID="fuVoucher" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSaveAttachment" runat="server" Text="Save" OnClientClick="return confirm('Are you sure you want to Save');"
                         OnClick="btnSaveAttachment_Click" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Label ID="lblMsg" runat="server" Visible="false" Font-Bold="true"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top:10px;">
        <asp:GridView ID="gvAttachments" runat="server" AutoGenerateColumns="false"
              EmptyDataText="No Record(s) Found" CssClass="Grid_1">
            <Columns>
                 <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="imgDelete" runat="server" CommandArgument='<%# Eval("ID") %>' OnClick="imgDelete_Click"
                         ImageUrl="~/images/deletebtn.png" OnClientClick='return confirm("Do you want to delete this attachment ?");'  />
                        <asp:HiddenField ID="hdfFileName" runat="server" Value='<%# Eval("FileName") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sr. #">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:BoundField DataField="EntryDate" HeaderText="Entry Date" />
                <asp:BoundField DataField="EntryBY" HeaderText="Entry By" />
                <asp:BoundField DataField="FileName" HeaderText="File Name" />
                <asp:HyperLinkField DataNavigateUrlFields="FileName" DataNavigateUrlFormatString="~/VoucherAttachments/{0}" Text="View / Download" Target="_blank"/>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

