<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EvaluationFactors.aspx.cs" Inherits="HR_EvaluationFactors" %>

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

            <span style="font-size: 16px ! important">Add Appraisal Name</span></h2>

        <table class="table-form" align="center">
            <tr>
                <td class="AmountAlign">
                    <asp:Label runat="server" ID="lblfactor" Text="Factor" >Factor :</asp:Label>
                    <%--<span class="CollapsiblePanelTabHover"allign="right">Factor</span></td>--%>
                <td style="width: 55%">
                    <asp:TextBox ID="TextBoxName" onkeypress="return Alphabets(event,this);" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxName" ErrorMessage="Please Enter Required Value"></asp:RequiredFieldValidator>
                </td>
            </tr>
              <tr>
                <td width="20%" align="right">Type :  </td>
                <td class="radio-Type">
                    <asp:RadioButtonList runat="server" ID="rbType" AutoPostBack="true" OnSelectedIndexChanged="rbType_SelectedIndexChanged" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Probation" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Appraisal" Value="4"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
           <%--   <tr>
                <td width="20%" align="right">Heading :  </td>
                <td>
                    <asp:DropDownList ID="ddlHeading" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlHeading_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
             --%>
            <tr>
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
                    <asp:TemplateField  HeaderText="Name">
                       
                        <ItemTemplate>
                            <asp:Label ID="lblname" runat="server" Text='<%# Eval("Name") %>'></asp:Label>

                        </ItemTemplate>

                    
                    </asp:TemplateField>
                    <asp:TemplateField  HeaderText="Type">
                       
                        <ItemTemplate>
                            <asp:Label ID="lbltypes" runat="server" Text='<%# Eval("types") %>'></asp:Label>

                        </ItemTemplate>

                    
                    </asp:TemplateField>
                   

                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:LinkButton ID="btn_Delete" Text="Delete" CommandArgument='<%#Eval("FactorId")%>' ValidationGroup="none" runat="server" OnClick="btn_Delete_Click">
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

