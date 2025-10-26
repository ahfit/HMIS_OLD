<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Billing_Patient_CreditPayable_Requests, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Patient Credit Payable Requests</span></h2>
    </div>
    <asp:GridView ID="GridView1" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:TemplateField HeaderText="Sr.#">
                <ItemTemplate>
                    <%# Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Reg#">
                <ItemTemplate>
                    <asp:Label ID="lblRegNo" Text='<%#Bind("RegNo") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Pay ID">
                <ItemTemplate>
                    <asp:Label ID="lblYearlyNo" Text='<%#Bind("YearlyNo") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Patient">
                <ItemTemplate>
                    <asp:Label ID="lblPatient" Text='<%#Bind("Patient_Name") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Amount">
                <ItemTemplate>
                    <asp:Label ID="lblAmount" Text='<%#Bind("Amount") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Description">
                <ItemTemplate>
                    <asp:Label ID="lblDescription" Text='<%#Bind("Description") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Request On">
                <ItemTemplate>
                    <asp:Label ID="lblRequestOn" Text='<%#Bind("Requested_On") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Request By">
                <ItemTemplate>
                    <asp:Label ID="lblRequestBy" Text='<%#Bind("Request_by") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Approve">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnApprove" Text="Approve" CommandArgument='<%#Bind("Cr_Payable_Id") %>' OnClick="lbtnApprove_Click" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Reject">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnReject" Text="Reject" CommandArgument='<%#Bind("Cr_Payable_Id") %>' OnClick="lbtnReject_Click" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
