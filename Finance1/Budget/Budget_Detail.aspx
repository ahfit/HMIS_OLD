<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Budget_Detail.aspx.cs" Inherits="Budget_Detail" %>

 

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div  >
<div class="bxmain inner_content" style="width:100%;">
<h2><span>Add Budget Details</span></h2>
<table cellpadding="0" cellspacing="0" width="100%" class="tbl_form" >
                        <tr>
                            <td width="39%" align="right" >
                                Budget Type:</td>
                            <td width="61%">
                              <asp:DropDownList ID="DropDownList_Em_Name" runat="server" AutoPostBack="True"
                                    DataSourceID="SqlDataSource_EM" DataTextField="EM_Name" DataValueField="EM_Code"
                                    Width="252px" OnSelectedIndexChanged="DropDownList_Sub_EH_Name_SelectedIndexChanged" >
                          </asp:DropDownList></td>
      </tr>
                        <tr>
                            <td width="39%" align="right" >
                                Level II :</td>
                            <td width="61%">
                              <asp:DropDownList ID="DropDownList_Sub_EH_Name" runat="server" AutoPostBack="True"
                                    DataSourceID="SqlDataSource_EH" DataTextField="EH_Name" DataValueField="EH_Code"
                                    Width="252px" OnSelectedIndexChanged="DropDownList_Sub_EH_Name_SelectedIndexChanged" >
                          </asp:DropDownList></td>
      </tr>
                        <tr>
                            <td align="right" >
                                Level III :</td>
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

                                <asp:SqlDataSource ID="SqlDataSource_expenditure" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    DeleteCommand="DELETE FROM [Expenditure] WHERE [E_ID] = @E_ID"
                                    SelectCommand="pro_budget_detail" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenField_date" Name="Date_End" PropertyName="Value" />
                                        <asp:QueryStringParameter Name="B_ID" QueryStringField="B_ID" />
                                        <asp:ControlParameter ControlID="DropDownList_Sub_ESH_name" Name="ESH_Code" PropertyName="SelectedValue"
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
        onprerender="GridView2_PreRender">
                                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                    <RowStyle CssClass="GridItem" />
                                    <Columns>
                                        <asp:BoundField DataField="E_code" HeaderText="E_code" InsertVisible="False" 
                                            ReadOnly="True" SortExpression="E_ID" />
                                        <asp:BoundField DataField="E_Code" HeaderText="Code" SortExpression="E_Code" />
                                        <asp:BoundField DataField="E_Name" HeaderText="Name" SortExpression="E_Name" />
                                        <asp:BoundField DataField="Actual_Amount" HeaderText="Last Year Actual Amount" SortExpression="Actual_Amount" />
                                        <asp:TemplateField HeaderText="Original Budget">
                                            <ItemTemplate>
                                                <asp:TextBox ID="TextBox_Estimated_Amount" Width="80px" runat="server" TextMode ="Number" SkinID ="intdata"  min ="0"></asp:TextBox><br />
                                                <asp:HiddenField ID="HiddenField_E_Code" runat="server" Value='<%# Eval("E_ID", "{0}") %>' />
                                                <asp:HiddenField ID="HiddenField_E_Name" runat="server" Value='<%# Eval("E_Name") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Monthly Limit">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtMonthlyLimit" Width="80px" runat="server" TextMode ="Number" SkinID ="intdata"  min ="0"></asp:TextBox><br />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Final Approved Budget" Visible="false">
                                            <ItemTemplate>
                                                <asp:TextBox ID="TextBox_Revise_Amount" Width="80px" runat="server"   TextMode ="Number" SkinID ="intdata" min ="0"
                                                    AutoPostBack="True" ontextchanged="TextBox_Revise_Amount_TextChanged"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Final Budget" Visible="false">
                                            <ItemTemplate>
                                                <asp:TextBox ID="TextBox_Actual_Amount" Width="80px" runat="server" 
                                                    Visible="False"></asp:TextBox>
                                                <asp:Label ID="Label_Final_Budget" runat="server" 
                                                    Text='<%# Eval("Actual_Amount") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description">
                                            <ItemTemplate>
                                                <asp:TextBox ID="TextBox_Description" Width="200px" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Forcasting" Visible="false">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkAddDepartmentTal" runat="server" Text="Add budget Forcasting" OnClick="lnkAddDepartmentTal_Click"
                                                      ToolTip ='<%# Eval("E_Code") %>' ></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField></asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:HiddenField ID="HiddenField_E_Code" runat="server" />
                                <asp:HiddenField ID="HiddenField_E_ID" 
        runat="server" />
                               <br />

<div align="center">
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Save" 
        style="height: 26px" />&nbsp;</div><br />

                                <asp:SqlDataSource ID="SqlDataSource_sub_ESH" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    SelectCommand="SELECT [ESH_Code], [ESH_Name]+'( '+ESH_Code+' )' as ESH_Name FROM [Expenditure_Sub_Heading] WHERE ([EH_Code] = @EH_Code)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Sub_EH_Name" Name="EH_Code" PropertyName="SelectedValue"
                                            Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_EH" 
        runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    DeleteCommand="DELETE FROM [Expenditure_Heading] WHERE [EH_Code] = @EH_Code"
                                    InsertCommand="INSERT INTO [Expenditure_Heading] ([EH_Code], [EH_Name]) VALUES (@EH_Code, @EH_Name)"
                                    
        SelectCommand="SELECT EH_Code, '( '+EH_Code+' )'+EH_Name as EH_Name FROM Expenditure_Heading 
WHERE (EM_Code = @EM_Code )" 
        
        
        
        UpdateCommand="UPDATE [Expenditure_Heading] SET [EH_Name] = @EH_Name WHERE [EH_Code] = @EH_Code">
                                    <DeleteParameters>
                                        <asp:Parameter Name="EH_Code" Type="String" />
                                    </DeleteParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Em_Name" Name="EM_Code" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="EH_Name" Type="String" />
                                        <asp:Parameter Name="EH_Code" Type="String" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="EH_Code" Type="String" />
                                        <asp:Parameter Name="EH_Name" Type="String" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_EM" 
        runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    
        SelectCommand="SELECT EM_Code, EM_Name FROM Expenditure_Main WHERE (EM_Name LIKE '%ASSETS%') 
                                    OR (EM_Name LIKE '%REVENUE%') OR (EM_Name LIKE '%expe%')">
                                    <DeleteParameters>
                                        <asp:Parameter Name="EH_Code" Type="String" />
                                    </DeleteParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_Budget_Detail" 
        runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    DeleteCommand="DELETE FROM [Budget_Detail] WHERE [B_ID] = @B_ID AND [E_ID] = @E_ID"
                                    InsertCommand="[insert_pro_budget_detail]"
                                    
        SelectCommand="SELECT [B_ID], [E_ID], isnull([Estimated_Amount],0) Estimated_Amount, isnull([Revise_Amount],0) Revise_Amount, isnull([Actual_Amount],0) Actual_Amount, isnull([Description],'') Description FROM [Budget_Detail]" 
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
                                        <asp:Parameter Name="E_Name" Type="String" />
                                       <asp:Parameter Name="MonthlyLimit" Type="Decimal" />
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