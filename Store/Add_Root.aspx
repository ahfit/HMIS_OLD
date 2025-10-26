<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_Add_Root, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div class="bxmain inner_content" style="width:100%;">
<h2><span>Add Root</span></h2>
    <table width="100%">
        <tr>
            
            <td align="right" width="50%">
                Root Name :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtManufacturerName"></asp:TextBox>
                <asp:Label ID="lblText" runat="server"></asp:Label>
            </td>
            
        </tr>
        
        <tr>
            
            <td colspan="2" align="center">
               
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
            </td>
           
        </tr>
    </table>
    </div>
    <br />
    <asp:GridView ID="gvAllManufacturer" runat="server" AllowPaging="True" Width="100%"
        PageSize="20" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="sdsAllManufacturer">
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    Serial No.</HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSRNO" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Id" HeaderText="Manufacturer_Id" Visible="false"
                InsertVisible="False" ReadOnly="True" SortExpression="Manufacturer_Id" />
            <asp:BoundField DataField="Description" HeaderText="Root Name" SortExpression="Manufacturer_Name" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsAllManufacturer" runat="server" ConnectionString="<%$ ConnectionStrings:Pharmacy_ConnectionString %>"
        SelectCommand="SELECT Id, Description FROM Medicine_Route">
    </asp:SqlDataSource>
</asp:Content>
