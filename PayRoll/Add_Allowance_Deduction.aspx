<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="Add_Allowance_Deduction.aspx.vb" Inherits="PayRoll_Add_Allowance_Deduction" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function ClientItemSelected(sender, e) {
            $get("<%=HFD_F_Head.ClientID %>").value = e.get_value();
   }

    </script>
    <style type="text/css">
        .RowRight {
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <table class="diagnosis_list">
        <tr>
            <td width="50%">&nbsp;</td>
            <td width="50%">&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" align="left">
                <h2><span class="h1" style="font-size: 14px; font-weight: bold; color: blue; line-height: 23px;">ADD / MODIFY ALLOWANCE DEDUCTION </span></h2>
            </td>
        </tr>
        <tr>
            <td align="right" style="line-height: 34px"><strong>Head Name :</strong></td>
            <td align="left">
                <asp:TextBox ID="TXT_Head_Name" runat="server" MaxLength="50" SkinID="captxt" CssClass="input_txt" BackColor="LightPink"></asp:TextBox>
                *
                <asp:RequiredFieldValidator ID="RFV_Name" runat="server" ControlToValidate="TXT_Head_Name" ErrorMessage="Head Name is Compulsory.." ValidationGroup="A"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" style="line-height: 34px"><strong>Variable / Fixed :</strong></td>
            <td align="left">
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True" Value="1">Variable</asp:ListItem>
                    <asp:ListItem Value="0">Fixed</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td align="right" style="line-height: 34px"><strong>Head Abbrivation :</strong></td>
            <td align="left">
                <asp:TextBox ID="TXT_Head_Abb" runat="server" MaxLength="10" CssClass="input_txt"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" style="line-height: 34px"><strong>Head Type :</strong></td>
            <td align="left">
                <asp:RadioButtonList ID="RBL_Head_Type" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                    <asp:ListItem Selected="True">Allowance</asp:ListItem>
                    <asp:ListItem>Deduction</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td align="right" style="line-height: 34px"><strong>Financial Head :</strong></td>
            <td align="left">
                <asp:TextBox ID="TXT_Financial_Head" runat="server" MaxLength="10" BackColor="LightPink" Height="21px"></asp:TextBox>*
                <asp:RequiredFieldValidator ID="RFV_F_Head" runat="server" ControlToValidate="TXT_Financial_Head" ErrorMessage="Financial Head is Compulsory..." ValidationGroup="A"></asp:RequiredFieldValidator>
                <asp:AutoCompleteExtender ID="Auto_Head_Find" runat="server" ServiceMethod="SearchFinacial_Head"
                    MinimumPrefixLength="1" CompletionInterval="100" CompletionSetCount="10"
                    TargetControlID="TXT_Financial_Head" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected">
                </asp:AutoCompleteExtender>
                <asp:HiddenField ID="HFD_F_Head" runat="server" Value="%" />
            </td>
        </tr>

        <tr>
            <td align="right" style="line-height: 34px"><strong>Order :</strong></td>
            <td align="left">
                <asp:TextBox ID="TXT_Order" runat="server" MaxLength="3" TextMode="Number"></asp:TextBox>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right"><strong>Allowances / Deduction Type:</strong></td>
            <td align="left">
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Width="202px" Height="30px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right">&nbsp;</td>
            <td align="left">&nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:Button ID="BTN_Save" runat="server" Text="Save" ValidationGroup="A" />
                <asp:SqlDataSource ID="SDS_Save" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" ProviderName="<%$ ConnectionStrings:PayRoll_ConnectionString.ProviderName %>" InsertCommand="Insert_Allowance_Deduction_Head" InsertCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="TXT_Head_Name" Name="Head_Name" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="TXT_Head_Abb" Name="Abbrivation" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="RBL_Head_Type" Name="Allowance_Deduction" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="HFD_F_Head" Name="Financial_Head" PropertyName="Value" Type="String" />
                        <asp:ControlParameter ControlID="TXT_Order" Name="Sort_Order" PropertyName="Text" Type="Int32" />
                        <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" Type="Int32" />
                        <asp:ControlParameter ControlID="DropDownList1" Name="AllowDed_Type"
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="RadioButtonList1" Name="IsVariable" PropertyName="SelectedValue" Type="Int32" />
                    </InsertParameters>

                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">&nbsp;</td>
            <td align="left">&nbsp;</td>
        </tr>
        <tr>
            <td align="center"><span class="h1" style="font-size: 13px; font-weight: bold; color: blue; line-height: 23px;">ALLOWANCES</span></td>
            <td align="center"><span class="h1" style="font-size: 13px; font-weight: bold; color: blue; line-height: 23px;">DEDUCTIONS</span></td>
        </tr>
        <tr>
            <td align="center" valign="top">
                <asp:GridView ID="GVD_Allowance" runat="server" Width="99%" AutoGenerateColumns="False" DataKeyNames="E_ID" DataSourceID="SDS_Allowance">
                    <Columns>


                        <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/images/icon_delete.png" DeleteImageUrl="~/images/icon_delete.png" EditImageUrl="~/images/icon_edit.png" UpdateImageUrl="~/images/icon_ok.png" />
                        <asp:TemplateField HeaderText="Head Name" SortExpression="Head_Name">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Head_Name")%>' Width="100px"></asp:TextBox>

                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Head_Name") %>'></asp:Label>
                                <asp:HiddenField ID="hfE_ID" runat="server" Value='<%# Bind("E_ID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Abbrivation" SortExpression="Abbrivation">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Abbrivation") %>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Abbrivation") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Financial Code" SortExpression="BI_Report_Head">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("BI_Report_Head")%>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("BI_Report_Head")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sort Order" SortExpression="Sort_Order">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Sort_Order") %>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("Sort_Order") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Financial Head" SortExpression="E_Name">
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("E_Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Add By" SortExpression="Name">

                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                            </ItemTemplate>



                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Exclude" Visible="false">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkApprove" runat="server" AutoPostBack="True" OnCheckedChanged="chkApprove_CheckedChanged" />
                                <asp:HiddenField ID="hfExclusive" runat="server" Value='<%# Eval("ExclusivnessOfAmount") %>' />
                            </ItemTemplate>


                        </asp:TemplateField>




                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SDS_Allowance" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:PayRoll_ConnectionString.ProviderName %>"
                    SelectCommand="Select_Allowance_Deduction_Head" SelectCommandType="StoredProcedure"
                    UpdateCommand="UPDATE Salary_Allowance_Deduction_Setup SET Sort_Order = @Sort_Order, Head_Name = @Head_Name, BI_Report_Head = @BI_Report_Head, Abbrivation = @Abbrivation WHERE (E_ID = @E_ID)"
                    DeleteCommand="UPDATE Salary_Allowance_Deduction_Setup SET Deleted_by = @Deleted_by, Delete_date = GETDATE() WHERE (E_ID = @E_ID)">
                    <DeleteParameters>
                        <asp:Parameter Name="E_ID" />
                        <asp:SessionParameter Name="Deleted_by" SessionField="emp_ID" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Allowance" Name="Allow_Deduction" Type="String" />
                    </SelectParameters>

                    <UpdateParameters>
                        <asp:Parameter Name="Sort_Order" />
                        <asp:Parameter Name="Head_Name" />
                        <asp:Parameter Name="BI_Report_Head" />
                        <asp:Parameter Name="Abbrivation" />
                        <asp:Parameter Name="E_ID" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
            <td align="center" valign="top">
                <asp:GridView ID="GVD_Deduction" runat="server" Width="99%" AutoGenerateColumns="False" DataKeyNames="E_ID" DataSourceID="SDS_Deduction">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/images/icon_delete.png" DeleteImageUrl="~/images/icon_delete.png" EditImageUrl="~/images/icon_edit.png" ShowDeleteButton="False" UpdateImageUrl="~/images/icon_ok.png" />
                        <asp:TemplateField HeaderText="Head Name" SortExpression="Head_Name">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Head_Name")%>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Head_Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Abbrivation" SortExpression="Abbrivation">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Abbrivation") %>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Abbrivation") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Financial Code" SortExpression="BI_Report_Head">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("BI_Report_Head")%>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("BI_Report_Head")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sort Order" SortExpression="Sort_Order">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Sort_Order") %>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("Sort_Order") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Financial Head" SortExpression="E_Name">
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("E_Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Add By" SortExpression="Name">

                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SDS_Deduction" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" ProviderName="<%$ ConnectionStrings:PayRoll_ConnectionString.ProviderName %>" SelectCommand="Select_Allowance_Deduction_Head" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Salary_Allowance_Deduction_Setup SET Sort_Order = @Sort_Order, Head_Name = @Head_Name, BI_Report_Head = @BI_Report_Head, Abbrivation = @Abbrivation WHERE (E_ID = @E_ID)" DeleteCommand="UPDATE Salary_Allowance_Deduction_Setup SET Deleted_by = @Deleted_by, Delete_date = GETDATE() WHERE (E_ID = @E_ID)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Deduction" Name="Allow_Deduction" Type="String" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="E_ID" />
                        <asp:SessionParameter Name="Deleted_by" SessionField="emp_ID" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Sort_Order" />
                        <asp:Parameter Name="Head_Name" />
                        <asp:Parameter Name="BI_Report_Head" />
                        <asp:Parameter Name="Abbrivation" />
                        <asp:Parameter Name="E_ID" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="center">&nbsp;</td>
            <td align="center">&nbsp;</td>
        </tr>
        <tr>
            <td align="center">&nbsp;</td>
            <td align="center">&nbsp;</td>
        </tr>
        <tr>
            <td align="center">&nbsp;</td>
            <td align="center">&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>



</asp:Content>

