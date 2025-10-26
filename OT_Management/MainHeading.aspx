<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="MainHeading.aspx.cs" Inherits="OT_Management_MainHeading" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function Alphabets() {
            var ch = String.fromCharCode(event.keyCode);
            var filter = /[a-zA-Z ]/;
            if (!filter.test(ch)) {
                event.returnValue = false;
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="float: left; width: 100%;">
        <h2>

            <span style="font-size: 16px ! important">Assesment / Checklist Heading</span></h2>

        <table class="table-form" align="center">
            <tr>
                <td class="AmountAlign"><span class="CollapsiblePanelTabHover">Heading</span>:</td>
                <td style="width: 55%">
                    <asp:TextBox ID="TextBoxName" onkeypress="return Alphabets(event,this);" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxName" ErrorMessage="Please Enter Required Value"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="AmountAlign"><span class="CollapsiblePanelTabHover">Type</span>:</td>
                <td style="width: 55%">
                 <asp:DropDownList runat="server" ID="ddlType" >
                     <asp:ListItem Text="Doctor Assesment" Value="Doctor Assesment"></asp:ListItem>
                     <asp:ListItem Text="Anesthetist  Assesment" Value="Anesthetist Assesment"></asp:ListItem>                     
                     <asp:ListItem Text="Nursing Pre-OP Checklist" Value="Nursing Pr-OP Checklist"></asp:ListItem>
                 </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="SaveButton" OnClick="SaveButton_Click" runat="server" Text="Save" />
                    <asp:HiddenField ID="hdfsave" runat="server"></asp:HiddenField>
                </td>
            </tr>


        </table>

        <div style="width: 60%; margin:0 auto;">
            <asp:GridView ID="gridFactor"  AutoGenerateColumns="false" runat="server" >
                <Columns>
                   
                    <asp:TemplateField  HeaderText="SR #">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField  HeaderText="Type">
                       
                        <ItemTemplate>
                            <asp:Label ID="lblType" runat="server" Text='<%# Eval("Type") %>'></asp:Label>

                        </ItemTemplate>

                    
                    </asp:TemplateField>

                    <asp:TemplateField  HeaderText="Name">
                       
                        <ItemTemplate>
                            <asp:Label ID="lblname" runat="server" Text='<%# Eval("Name") %>'></asp:Label>

                        </ItemTemplate>

                    
                    </asp:TemplateField>

                   

                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:LinkButton ID="btn_Delete" Text="Delete" CommandArgument='<%#Eval("HeadingId")%>' ValidationGroup="none" runat="server" OnClick="btn_Delete_Click">
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

