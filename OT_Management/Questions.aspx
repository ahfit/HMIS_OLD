<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Questions.aspx.cs" Inherits="OT_Management_Questions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="bxmain inner_content" style="float: left; width: 100%;">
        <h2>
            <span style="font-size: 16px ! important">Assesment / Checklist Questions</span></h2>
        <table class="table-form" align="center">
            <tr>
                <td class="AmountAlign"><span class="CollapsiblePanelTabHover">Type</span>:</td>
                <td style="width: 55%">
                    <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                         <asp:ListItem Text="Doctor Assesment" Value="Doctor Assesment"></asp:ListItem>
                        <asp:ListItem Text="Anesthetist  Assesment" Value="Anesthetist Assesment"></asp:ListItem>
                         <asp:ListItem Text="Nursing Pre-OP Checklist" Value="Nursing Pr-OP Checklist"></asp:ListItem>
                    </asp:DropDownList>
                   
                </td>
            </tr>
             <tr>
                <td class="AmountAlign"><span class="CollapsiblePanelTabHover">Heading</span>:</td>
                <td style="width: 55%">
                    <asp:DropDownList ID="ddlHeading" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlHeading_SelectedIndexChanged"></asp:DropDownList>

                </td>
            </tr>
            <tr>
                <td class="AmountAlign"><span class="CollapsiblePanelTabHover">Question</span>:</td>
                <td>
                    <asp:TextBox ID="Txtdetail" runat="server"></asp:TextBox>
                </td>

            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btnsave2" OnClick="btnsave2_Click1" runat="server" Text="Save" />


                </td>
            </tr>


            <asp:GridView ID="gridsDetails" runat="server" AutoGenerateColumns="false">
                <Columns>

                           <asp:TemplateField HeaderStyle-Width="30px" HeaderText="SR #">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>

            
                    <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Heading">

                        <ItemTemplate>
                            <asp:Label ID="lbldetail" runat="server" Text='<%#Eval("Name")%>'></asp:Label>

                        </ItemTemplate>
                    </asp:TemplateField>

                           <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Detail">

                        <ItemTemplate>
                            <asp:Label ID="lblheading" runat="server" Text='<%#Eval("Details")%>'></asp:Label>

                        </ItemTemplate>
                    </asp:TemplateField>

                 
                   <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Delete">
                        <ItemTemplate>
                            <asp:LinkButton ID="btn_Delete" Text="Delete" CommandArgument='<%#Eval("QuestionId")%>' ValidationGroup="none"  runat="server" OnClick="btn_Delete_Click">
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
             
                </Columns>

            </asp:GridView>





        </table>




    </div>


    </asp:Content>

