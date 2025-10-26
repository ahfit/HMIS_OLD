<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Blood_Bank_Blood_Request, App_Web_ob4gay25" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="blood_wrap" style="width: 100%;">
        <div class="bxmain inner_content" style="width: 100%;">
            <h2><span style="font-size: 25px !important">Blood Request</span></h2><hr>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Id" >
                        <ItemStyle width="10%"/>
                        <ItemTemplate >
                            <asp:Label ID="lblID" runat="server" Text='<% #Bind("Blood_Request_Id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Registration No">
                        <ItemStyle width="25%"/>
                        <ItemTemplate>
                            <asp:Label ID="lblRegNo" runat="server" Text='<% #Bind("Registration_No") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Yearly No" > 
                        <ItemStyle width="10%"/>
                        <ItemTemplate>
                            <asp:Label ID="lblYNo" runat="server" Text='<% #Bind("Yearly_No") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date Time" >
                        <ItemStyle width="10%"/>
                        <ItemTemplate>
                            <asp:Label ID="lblDTime" runat="server" Text='<% #Bind("Data_Time") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bag_Qty" >
                        <ItemTemplate>
                            <asp:Label ID="lblBag_Qty" runat="server" Text='<% #Bind("Bag_Qty") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="When Need">
                        <ItemTemplate>
                            <asp:Label ID="lblWhen_Need" runat="server" Text='<% #Bind("When_Need") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<% #Bind("Status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-Width="15%"/>--%>
                </Columns>
            </asp:GridView>
            
        </div>
    </div>
</asp:Content>

