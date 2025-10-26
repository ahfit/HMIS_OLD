<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Revise_Budget_Detail.aspx.cs" Inherits="Revise_Budget_Detail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div  >
<div class="bxmain inner_content"  style="width:100%;">
<h2><span>Add Revised Budget Detail</span></h2>
<table cellpadding="0" cellspacing="0" width="100%" class="tbl_form" >
                        <tr>
                            <td width="40%" align="right" >
                                Level I Name :</td>
                            <td width="60%">
                              <asp:DropDownList ID="DropDownList_Sub_EH_Name" runat="server" AutoPostBack="True"
                                    DataSourceID="SqlDataSource_EH" DataTextField="EH_Name" DataValueField="EH_Code"
                                    Width="252px" OnSelectedIndexChanged="DropDownList_Sub_EH_Name_SelectedIndexChanged" >
                          </asp:DropDownList></td>
      </tr>
                        <tr>
                            <td align="right" >
                                Level II Name :</td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Sub_ESH_name" runat="server" AutoPostBack="True"
                                    DataSourceID="SqlDataSource_sub_ESH" DataTextField="ESH_Name" DataValueField="ESH_Code"
                                    Width="252px" OnSelectedIndexChanged ="DropDownList_Sub_ESH_name_SelectedIndexChanged">
                                </asp:DropDownList></td>
                         </tr>
                         <tr>
                             <td align="center" colspan="2" >
                                <a href ="Budget.aspx"  class = "btn_hacims">Return</a>
                                </td>
                         </tr>
                        
                    </table></div><br />

                                <asp:SqlDataSource ID="SqlDataSource_expenditure" 
        runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    DeleteCommand="DELETE FROM [Expenditure] WHERE [E_ID] = @E_ID"
                                    SelectCommand="[Select_Revise_Budget_Detail]" 
        SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="B_ID" QueryStringField="B_ID" />
                                        <asp:ControlParameter ControlID="DropDownList_Sub_ESH_name" Name="ESH_Code" PropertyName="SelectedValue"
                                            Type="String" />
                                        <asp:QueryStringParameter Name="Financial_Company_Id" QueryStringField="Financial_Company_Id" 
                                            Type="Int32" />
                                            <asp:QueryStringParameter Name="Company_Branch_Id" QueryStringField="Company_Branch_Id" 
                                            Type="Int32" />
                                        <asp:QueryStringParameter Name="Start" QueryStringField="Date_Start" 
                                            Type="String" />
                                        <asp:QueryStringParameter Name="End" QueryStringField="Date_End" 
                                            Type="String" />
                                    </SelectParameters>
                                    <DeleteParameters>
                                        <asp:Parameter Name="E_ID" />
                                    </DeleteParameters>
                                </asp:SqlDataSource>
                                <asp:GridView ID="GridView2" runat="server" 
        AutoGenerateColumns="False" CssClass="Grid_2"
                                    DataKeyNames="E_ID" 
        DataSourceID="SqlDataSource_expenditure" Width="100%" 
        OnSelectedIndexChanged="GridView2_SelectedIndexChanged" 
        onprerender="GridView2_PreRender" EmptyDataText="No Record(s) Found">
                                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                    <RowStyle CssClass="GridItem" />
                                    <Columns>
                                        <asp:BoundField DataField="E_ID" HeaderText="E_ID" InsertVisible="False" 
                                            ReadOnly="True" SortExpression="E_ID" />
                                        <asp:BoundField DataField="E_Code" HeaderText="Code" SortExpression="E_Code" />
                                        <asp:BoundField DataField="E_Name" HeaderText="Name" SortExpression="E_Name" />
                                        <asp:TemplateField HeaderText="Original Budget">
                                            <ItemTemplate>
                                                <asp:TextBox ID="TextBox_Estimated_Amount" Width="80px" runat="server" TextMode = "Number" min ="0" SkinID = "intdata"
                                                    Enabled="False" Text='<%# Bind("Estimated_Amount") %>'></asp:TextBox><br />
                                                <asp:HiddenField ID="HiddenField_E_Code" runat="server" Value='<%# Eval("E_ID", "{0}") %>' />
                                                <br />
                                                <asp:HiddenField ID="HiddenField_E_name" runat="server" 
                                                    Value='<%# Eval("E_Name") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Revise Budget">
                                            <ItemTemplate>
                                                <asp:TextBox ID="TextBox_Revise_Amount" Width="80px" runat="server" TextMode = "Number" min ="0" SkinID = "intdata"
                                                    Text='<%# Bind("Revise_Amount") %>'></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="expense" HeaderText="expense" 
                                            SortExpression="expense" Visible="False" />
                                        <asp:TemplateField HeaderText="Final Budget" Visible="False">
                                            <ItemTemplate>
                                                <asp:TextBox ID="TextBox_Actual_Amount" Width="80px" runat="server"  TextMode = "Number" min ="0" SkinID = "intdata"
                                                    Text='<%# Bind("Actual_Amount") %>'></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description">
                                            <ItemTemplate>
                                                <asp:TextBox ID="TextBox_Description" Width="80px" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:HiddenField ID="HiddenField_E_Code" runat="server" />
                                <asp:HiddenField ID="HiddenField_E_ID" 
        runat="server" />
                               <br />

<div align="center">
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Save" />&nbsp;</div><br />

                                <asp:SqlDataSource ID="SqlDataSource_sub_ESH" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    SelectCommand="SELECT [ESH_Code], [ESH_Name], [EH_Code] FROM [Expenditure_Sub_Heading] WHERE ([EH_Code] = @EH_Code)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Sub_EH_Name" Name="EH_Code" PropertyName="SelectedValue"
                                            Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_EH" 
        runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    DeleteCommand="DELETE FROM [Expenditure_Heading] WHERE [EH_Code] = @EH_Code"
                                    InsertCommand="INSERT INTO [Expenditure_Heading] ([EH_Code], [EH_Name]) VALUES (@EH_Code, @EH_Name)"
                                    
        SelectCommand="SELECT EH_Code, '( '+EH_Code+' )' +EH_Name as EH_Name FROM Expenditure_Heading  --WHERE (EM_Code = '6')" 
        
        
        UpdateCommand="UPDATE [Expenditure_Heading] SET [EH_Name] = @EH_Name WHERE [EH_Code] = @EH_Code">
                                    <DeleteParameters>
                                        <asp:Parameter Name="EH_Code" Type="String" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="EH_Name" Type="String" />
                                        <asp:Parameter Name="EH_Code" Type="String" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="EH_Code" Type="String" />
                                        <asp:Parameter Name="EH_Name" Type="String" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_Budget_Detail" 
        runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    DeleteCommand="DELETE FROM [Budget_Detail] WHERE [B_ID] = @B_ID AND [E_ID] = @E_ID"
                                    InsertCommand="[insert_pro_budget_detail]"
                                    
        SelectCommand="SELECT EH_Code, EH_Name FROM Expenditure_Heading --WHERE (EM_Code = '6')" 
        InsertCommandType="StoredProcedure">
                                    <DeleteParameters>
                                        <asp:Parameter Name="B_ID" Type="Int32" />
                                        <asp:Parameter Name="E_ID" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:QueryStringParameter Name="B_ID" QueryStringField="B_ID" Type="Int32" />
                                        <asp:ControlParameter ControlID="HiddenField_E_ID" Name="E_ID" 
                                            PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenField_Estimated_Amount" Name="Estimated_Amount"
                                            PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenField_Revise_Amount" Name="Revise_Amount"
                                            PropertyName="Value" Type="Decimal" />
                                        <asp:ControlParameter ControlID="HiddenField_Actual_Amount" Name="Actual_Amount"
                                            PropertyName="Value" Type="Decimal" />
                                        <asp:ControlParameter ControlID="HiddenField_Actual_Amount" Name="Amount_In_Hands"
                                            PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenField_Description" Name="Description" PropertyName="Value"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_E_Code" Name="E_Code" 
                                            PropertyName="Value" Type="String" />
                                        <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" Type="Int32" />
                                        <asp:Parameter DefaultValue="" Name="E_Name" Type="String" />
                                        <asp:Parameter DefaultValue="Revised" Name="Type" Type="String" />
                                        <asp:Parameter DefaultValue="0" Name="MonthlyLimit" Type="Double" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <br />
                                <asp:HiddenField ID="HiddenField_Estimated_Amount" runat="server" />
                                <asp:HiddenField ID="HiddenField_Revise_Amount" runat="server" />
                                <asp:HiddenField ID="HiddenField_Actual_Amount" runat="server" />
                                <asp:HiddenField ID="HiddenField_Description" runat="server" />
                                <asp:HiddenField ID="HiddenField_date" runat="server" /><br />
<br />


</div>



</asp:Content>