<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_Add_Unit, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="bxmain inner_content" style="width:100%;">
<h2><span>Add Unit</span></h2>
    <table width="100%">
        <tr>
            
            <td align="right" width="50%">
                Unit Name :
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtUnitName"></asp:TextBox>
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
    <div>
     <asp:GridView ID="gvUnit" runat="server" AllowPaging="True" Width="100%"
        PageSize="20" AutoGenerateColumns="False"   DataSourceID="sdsMedicineUnit">
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    Serial No.</HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSRNO" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="unit" HeaderText="Unit Name"  />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsMedicineUnit" runat="server" ConnectionString="<%$ ConnectionStrings:Pharmacy_ConnectionString %>"
        SelectCommand="select * from Medicine_Unit order by unit desc">
    </asp:SqlDataSource>
</div>
</asp:Content>

