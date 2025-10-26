<%@ page title="" language="VB" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="false" inherits="Finance_Advance_Payment, App_Web_se3xxsm3" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %><asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Advance Payment</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form">
            <tr>
                <td align="right" width="40%">
                    For Branch :
                </td>
                <td>
                    <asp:DropDownList ID="DDL_ForBranch" runat="server" DataSourceID="SDS_Branch" DataTextField="Company_Branch_Name"
                        DataValueField="Company_Branch_Id" AutoPostBack="True" ControlToCompare="DDL_ForBranch">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    By Branch :
                </td>
                <td>
                    <asp:DropDownList ID="DDL_Branch" runat="server" DataSourceID="SDS_Branch" DataTextField="Company_Branch_Name"
                        DataValueField="Company_Branch_Id" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="DDL_ForBranch"
                        ControlToValidate="DDL_Branch" SetFocusOnError="True" ValidationGroup="Reeturn"></asp:CompareValidator>
                    <asp:SqlDataSource ID="SDS_Branch" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="SELECT Company_Branch_Id, Company_Branch_Name FROM
 Group_Company_Branches  ">
                      
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Expanse :
                </td>
                <td>
                    <asp:DropDownList ID="ddl_Expanse" runat="server" DataSourceID="SDS_Expanse" DataTextField="E_Name"
                        DataValueField="E_Code">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Expanse" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                        SelectCommand="SELECT E_Code, E_Name FROM Expenditure WHERE (E_Code LIKE '3202003') ORDER BY E_Name">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Expance Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser_PODate" runat="server" Width="200px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HF_Expance_Date" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    Amount :
                </td>
                <td>
                    <asp:TextBox ID="TXT_Amount" runat="server" Width="83px" MaxLength="10" SkinID="number"></asp:TextBox>
                    &nbsp;<span class="style2">Rs.
                        <asp:Label ID="lblBalance" runat="server" Visible="false"></asp:Label></span>
                    <asp:SqlDataSource ID="sdsBalance" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                        SelectCommand="usp_Balance_Branch_wise" SelectCommandType="StoredProcedure" InsertCommand="insert_Advance_Return" CancelSelectOnNullParameter ="false"
                        InsertCommandType="StoredProcedure">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="ddl_Expanse" Name="E_Code" PropertyName="SelectedValue"
                                Type="Decimal" />
                            <asp:ControlParameter ControlID="TXT_Amount" Name="Amount" PropertyName="Text" Type="Int32" />
                            <asp:ControlParameter Name="Emp_ID" Type="Int32" ControlID="DDL_Employee" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="TXT_Description" Name="Description" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="RBL_Am_Type" Name="Payment_Type" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="HF_AC" Name="Account_Ecode" PropertyName="Value"
                                Type="Decimal" />
                            <asp:SessionParameter Name="Add_By_Emp_ID" SessionField="emp_iD" Type="Int32" />
                            <asp:ControlParameter ControlID="DDL_ForBranch" Name="ForCompanyBranchId" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DDL_Branch" Name="Company_Branch_ID" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                            <asp:SessionParameter Name="SubDept_ID" SessionField="subdeptid" Type="Int32" />
                            <asp:ControlParameter ControlID="HF_Expance_Date" Name="ExpanceDate" PropertyName="Value"
                                Type="DateTime" />
                            <%-- <asp:SessionParameter Name="Financial_Company_ID" SessionField="Financial_Company_Id"
                Type="Int32" />--%>
                        </InsertParameters>
                        <SelectParameters>
                            <asp:SessionParameter Name="Company_Branch_Id" SessionField="Company_Branch_Id" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Advance To Employee:
                </td>
                <td>
                    <asp:DropDownList ID="DDL_Employee" runat="server" DataSourceID="SDS_Employee" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>
                    <strong>Search :</strong><asp:TextBox ID = "txt_Consultant" runat = "server" AutoPostBack="True" 
                        TabIndex="4" ontextchanged="txt_Consultant_TextChanged"></asp:TextBox>

                 <asp:HiddenField ID ="hf_consultant" runat ="server" value ="%" />
                    <asp:SqlDataSource ID="SDS_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="SELECT     Name, EmpID
FROM         Employee where name like '%'+@name+'%'">
<SelectParameters>
<asp:Parameter Name="name" DefaultValue="%" />
</SelectParameters>
                   
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Description :
                </td>
                <td>
                    <asp:TextBox ID="TXT_Description" runat="server" Height="100px" TextMode="MultiLine"
                        Width="235px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="LabelACNO" runat="server" Text="Account #"></asp:Label>
                </td>
                <td>
                    <asp:RadioButtonList ID="RBL_Am_Type" runat="server" AutoPostBack="True" RepeatDirection="Horizontal">
                    <asp:ListItem>Cash</asp:ListItem>
                    <asp:ListItem Value="BANK">Cheque</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="LabelAC" runat="server" Text="Account #" Visible="False"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="DDL_AC_NO" runat="server" DataSourceID="SDS_Bank_Account" DataTextField="Account_No"
                        DataValueField="E_Code" Visible="False">
                    </asp:DropDownList>
                    <br />
                    <asp:HiddenField ID="HF_Branch_Access" runat="server" />
                    <asp:HiddenField ID="HF_AC" runat="server" />
                    <asp:SqlDataSource ID="SDS_Bank_Account" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
        
        
                    
                    
                    
                    SelectCommand="SELECT Expenditure.E_Name as Account_No, Expenditure.E_Code FROM Head_Master_Table INNER JOIN Expenditure ON Head_Master_Table.E_Code = Expenditure.E_Code WHERE (Head_Master_Table.Head_Type = @Head_Type)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="RBL_Am_Type" Name="Head_Type" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="BTN_Save" runat="server" Text="Save" />
                    <asp:Label ID="LBL_MSG" runat="server" ForeColor="Red"></asp:Label>
                    <asp:Button ID="btnReturnAdvance" runat="server" Text="Return Advance" ValidationGroup="Reeturn" />
                    <br />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:GridView ID="GV_Record" runat="server" Width="100%" AutoGenerateColumns="False"
        DataSourceID="SDS_GV" EnableModelValidation="True" DataKeyNames="id" AllowPaging="True"
        PageSize="50" ShowFooter="True">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Delete"
                        ImageUrl="~/images/deletebtn.png" Width="10px" OnClientClick='return confirm("Do you want to delete this Expense ?");'
                        Text="Delete" />
                    <asp:HiddenField ID="Hf_Amount" runat="server" Value='<%# Eval("Amount") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Expanse" HeaderText="Expanse" SortExpression="Expanse" />
            <asp:BoundField DataField="Date" HeaderText="Expance Date" DataFormatString="{0:dd/MM/yyyy}"
                SortExpression="Date" />
            <asp:TemplateField HeaderText="Amount">
                <ItemTemplate>
                    <asp:Label ID="lbl_amount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <div style="padding: 0 0 5px 0">
                        <strong>Current Total :
                            <asp:Label ID="lblPageTotal" runat="server" Text="0" />
                            Rs.</strong></div>
                    <div>
                        <strong>All Total :
                            <asp:Label ID="lblGrandTotal" runat="server" Text="0" />
                            Rs.</strong></div>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" Visible="False" />
            <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="Payment_Type" HeaderText="Payment Type" SortExpression="Payment_Type" />
            <asp:BoundField DataField="Account_No" HeaderText="Account No." SortExpression="Account_No" />
        </Columns>
    </asp:GridView>
    <%--(dbo.Expanse_Record.[Date] between @Start_Date and @End_Date)--%>
    <asp:SqlDataSource ID="SDS_GV" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" CancelSelectOnNullParameter = "False"
        InsertCommand="insert_Advance_Record" InsertCommandType="StoredProcedure" SelectCommand="                      
SELECT     Expenditure_1.E_Name AS Expanse, Advance_Record.Amount, Employee.Name, Advance_Record.Description, Advance_Record.Payment_Type, 
                      Expenditure.E_Name AS Account_No, Advance_Record.Id, Advance_Record.Date
FROM         Advance_Record INNER JOIN
                      Expenditure AS Expenditure_1 ON Advance_Record.E_Code = Expenditure_1.E_Code INNER JOIN
                      Employee ON Advance_Record.Emp_ID = Employee.EmpID LEFT OUTER JOIN
                      Expenditure ON Advance_Record.Account_Ecode = Expenditure.E_Code
WHERE (dbo.Advance_Record.Dept_ID = @Dept_ID) AND (Advance_Record.Subdept_ID=@SubDeptID)
 Order By [Date] Desc" DeleteCommand="delete_Advance_Record" 
        DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
            <asp:SessionParameter Name="Financial_Company_ID" SessionField="Financial_Company_Id"
                Type="Int32" />
            <asp:SessionParameter Name="Company_Branch_ID" SessionField="Company_Branch_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="ddl_Expanse" Name="E_Code" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_Amount" Name="Amount" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter Name="Emp_ID" Type="Int32" ControlID="DDL_Employee" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TXT_Description" Name="Description" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="RBL_Am_Type" Name="Payment_Type" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="HF_AC" Name="Account_Ecode" PropertyName="Value"
                Type="String" />
            <asp:SessionParameter Name="Add_By_Emp_ID" SessionField="emp_iD" Type="Int32" />
            <asp:ControlParameter ControlID="DDL_ForBranch" Name="ForCompanyBranchId" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DDL_Branch" Name="Company_Branch_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
            <asp:SessionParameter Name="SubDept_ID" SessionField="subdeptid" Type="Int32" />
            <asp:ControlParameter ControlID="HF_Expance_Date" Name="ExpanceDate" PropertyName="Value"
                Type="DateTime" />
            <%-- <asp:SessionParameter Name="Financial_Company_ID" SessionField="Financial_Company_Id"
                Type="Int32" />--%>
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="Dept_ID" SessionField="Dept_id" />
            <asp:SessionParameter Name="SubDeptID" SessionField="Subdeptid" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
