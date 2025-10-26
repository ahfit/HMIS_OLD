<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EvaluationFactorsDetail.aspx.cs" Inherits="HR_EvaluationFactorsDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="bxmain inner_content" style="float: left; width: 100%;">
        <h2>
            <span style="font-size: 16px ! important">Evaluation Factors Detail</span></h2>
        <table class="table-form" align="center">
            <tr>
                <td class="AmountAlign"><span class="CollapsiblePanelTabHover"> Create Evaluation Factor </span>:</td>
                <td style="width: 55%">
                    <asp:DropDownList ID="ddlHeading" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlHeading_SelectedIndexChanged"></asp:DropDownList>

                </td>
            </tr>
            <tr>
                <td class="AmountAlign"><span class="CollapsiblePanelTabHover">Detail</span>:</td>
                <td>
                    <asp:TextBox ID="Txtdetail" runat="server"></asp:TextBox>
                </td>

            </tr>
             <tr>
                <td class="AmountAlign"><span class="CollapsiblePanelTabHover">Marks</span>:</td>
                <td>
                    <asp:TextBox ID="txtmarks" runat="server" type="number" ></asp:TextBox>
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
                            <asp:Label ID="lblName" runat="server" Text='<%#Eval("Name")%>'></asp:Label>

                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Type">

                        <ItemTemplate>
                            <asp:Label ID="lblTypes" runat="server" Text='<%#Eval("types")%>'></asp:Label>

                        </ItemTemplate>
                    </asp:TemplateField>

                           <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Detail">

                        <ItemTemplate>
                            <asp:Label ID="lblDetail" runat="server" Text='<%#Eval("Detail")%>'></asp:Label>

                        </ItemTemplate>
                    </asp:TemplateField>
                       <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Marks">

                        <ItemTemplate>
                            <asp:Label ID="lblMarks" runat="server" Text='<%#Eval("marks")%>'></asp:Label>

                        </ItemTemplate>
                    </asp:TemplateField>
                    

                 
                   <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Delete">
                        <ItemTemplate>
                            <asp:LinkButton ID="btn_Delete" Text="Delete" CommandArgument='<%#Eval("FactorDetailId")%>' ValidationGroup="none"  runat="server" OnClick="btn_Delete_Click">
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
             
                </Columns>

            </asp:GridView>





        </table>




    </div>


    </asp:Content>

