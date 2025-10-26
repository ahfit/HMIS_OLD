<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Billing_Patient_CreditPayable_Approved, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Patient Credit Payables</span></h2>
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
                    <asp:Label ID="lblRegNo" Text='<%#Bind("Reg_No") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Pay ID">
                <ItemTemplate>
                    <asp:Label ID="lblYearlyNo" Text='<%#Bind("YearlyNo") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Patient">
                <ItemTemplate>
                    <asp:Label ID="lblPatient" Text='<%#Bind("PatientName") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Amount">
                <ItemTemplate>
                    <asp:Label ID="lblAmount" Text='<%#Bind("Amount") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Reg Date">
                <ItemTemplate>
                    <asp:Label ID="lblDescription" Text='<%#Bind("RegDateTime") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Payment Date">
                <ItemTemplate>
                    <asp:Label ID="lblRequestOn" Text='<%#Bind("PaymentDate") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Approve">
                <ItemTemplate>
                   <asp:CheckBox runat="server" id="chkBoxSelect" ToolTip='<%#Bind("Cr_CashBook_ID") %>' ></asp:CheckBox>
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
    </asp:GridView>
    <table style="width:100%">
        <tr>
            <td align="center" width="100%">
                 <asp:Button runat="server" id="btnReceive" Text="Receive" onClick="btnReceive_Click" />
            </td>
        </tr>
    </table>
   
</asp:Content>
