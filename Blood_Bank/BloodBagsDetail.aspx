<%@ page language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Blood_Bank_BloodBagsDetails, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style2 {
            font-size: 20px;
            color: #3399FF;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style="width:100%">
            <h2><span style="font-size:medium; ! important "> Blood Product Formation</span></h2>
        <div align="center">
    <asp:DropDownList ID="DropDownList_Bag_Category" runat="server" AutoPostBack="True"
        OnSelectedIndexChanged="DropDownList_Bag_Category_SelectedIndexChanged" Width="182px">
        <asp:ListItem Selected="True" Value="1">Taken From Donors</asp:ListItem>
        <asp:ListItem Value="2">After Product Formation</asp:ListItem>
    </asp:DropDownList>
            </div>
     <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        DataSourceID="SqlDataSource_bags" Height="1px" OnPreRender="GridView1_PreRender"
        OnSelectedIndexChanged="GridView1_SelectedIndexChanged" PageSize="15" Width="100%" DataKeyNames="Donor_Visit_Id,Donor_Registration_No,Assesment_Id">
        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
        <Columns>
            <asp:BoundField DataField="Donor_Registration_No" HeaderText="Donor Reg No" SortExpression="Donor_Registration_No" />
            <asp:BoundField DataField="Bag_No" HeaderText="Bag No" SortExpression="Bag_No" />
            <asp:BoundField DataField="Bag_Name" HeaderText="Bag Type" SortExpression="Bag_Name" />
            <asp:BoundField DataField="Blood_Group" HeaderText="Blood Group" SortExpression="Blood_Group" />
            <asp:BoundField DataField="Collected_At" HeaderText="Collected At" SortExpression="Collected_At" />
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
            <asp:HyperLinkField DataNavigateUrlFields="Donor_Visit_Id,Donor_Registration_No,Assesment_Id"
                DataNavigateUrlFormatString="Blood_Collection.aspx?Donor_Reg_No={1}&amp;Visit_No={0}&amp;Assesment_Id={2}"
                DataTextFormatString="&quot;Product Formation&quot;" Text="Product Formation" />
        </Columns>
        <RowStyle CssClass="GridItem" Height="8px" />
        <HeaderStyle CssClass="GridHeader" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_bags" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Blood_Donation.Bag_No, Blood_Donation.Donor_Registration_No, Blood_Donation.Donor_Visit_Id, Bag_Type.Bag_Name, Blood_Donation.Blood_Group, Blood_Donation.Collected_At, Blood_Donation.Quantity, Blood_Donation.Status, Blood_Donation.Assesment_Id FROM Blood_Donation INNER JOIN Bag_Type ON Blood_Donation.Bag_Type_Id = Bag_Type.Bag_Type_Id WHERE (Blood_Donation.Status = 1)">
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_AfterProduct_Formation" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
        SelectCommand="SELECT Donor_Product_Formation.Product_Formation_Id, Donor_Product_Formation.Donation_Id, Donor_Product_Formation.Product_Qty, Donor_Product_Formation.Formation_DateTime, CONVERT (DATETIME, Donor_Product_Formation.Expiry_DateTime, 103) AS Expiry_DateTime, Donor_Product_Formation.Bag_No, Blood_Component.Component_Name, Bag_Type.Bag_Name FROM Donor_Product_Formation INNER JOIN Blood_Component ON Donor_Product_Formation.Component_Id = Blood_Component.Component_id INNER JOIN Bag_Type ON Donor_Product_Formation.Bag_Type_Id = Bag_Type.Bag_Type_Id">
    </asp:SqlDataSource>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Product_Formation_Id"
        DataSourceID="SqlDataSource_AfterProduct_Formation" OnPreRender="GridView2_PreRender">
        <Columns>
            <asp:BoundField DataField="Bag_No" HeaderText="Bag No" SortExpression="Bag_No" />
            <asp:BoundField DataField="Product_Qty" HeaderText="Qty" SortExpression="Product_Qty" />
            <asp:BoundField DataField="Formation_DateTime" HeaderText="Formation Date Time" SortExpression="Formation_DateTime" />
            <asp:BoundField DataField="Expiry_DateTime" HeaderText="Expiry Date Time" SortExpression="Expiry_DateTime" />
            <asp:BoundField DataField="Component_Name" HeaderText="Component Name" SortExpression="Component_Name" />
            <asp:TemplateField HeaderText="Bag Type" SortExpression="Bag_Name">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Bag_Name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Bag_Name") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField_ExpiryDate" runat="server" Value='<%# Eval("Expiry_DateTime", "{0:G}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Issue">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="" Text="Issue"></asp:HyperLink>
                    <asp:Label ID="Label2" runat="server" ForeColor="Red" Text="Expired" Visible="False"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </div>
</asp:Content>

