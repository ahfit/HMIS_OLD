<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Voucher_Receipts_Payments, App_Web_se3xxsm3" title="Voucher Receipts Payments" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>
 



 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      
     <style type="text/css">
         .style1
         {
             width: 100%;
         }
         .style2
         {
             font-size: small;
             font-weight: bold;
         }
     </style>
      
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
 
 
 
 
    <table class="style1">
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right">
                Company :</td>
            <td>
                <asp:DropDownList ID="DropDownList_Companyname" runat="server" 
                    AutoPostBack="True" DataSourceID="SQL_Companyname" 
                    DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id" 
                    Width="196px" Enabled="False">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right">
                Branch :</td>
            <td>
                <asp:DropDownList ID="DropDownList_Branchname" runat="server" 
                    AutoPostBack="True" DataSourceID="SQL_Branchname" 
                    DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id" 
                    Width="198px" Enabled="False">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SQL_Companyname" runat="server" 
           ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" 
           
           SelectCommand="SELECT 0 AS Financial_Company_Id, 'ALL' AS Financial_Company_Name 
UNION 
SELECT Financial_Company_Id, Financial_Company_Name 
FROM Group_Financial_Companies
order by Financial_Company_Name">
       </asp:SqlDataSource>
       <asp:SqlDataSource ID="SQL_Branchname" runat="server" 
           ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" SelectCommand="SELECT     0 AS Company_Branch_Id, 'ALL' AS Company_Branch_Name
UNION
SELECT     Company_Branch_Id, Company_Branch_Name
FROM       Group_Company_Branches
WHERE Convert(varchar,[Financial_Company_Id]) like case @Financial_Company_Id when 0 then '%' else convert(varchar,@Financial_Company_Id) end
">
           <SelectParameters>
               <asp:ControlParameter ControlID="DropDownList_Companyname" 
                   Name="Financial_Company_Id" PropertyName="SelectedValue" Type="Int32" />
           </SelectParameters>
       </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                Expanse :</td>
            <td>
                <asp:DropDownList ID="ddl_Expanse" runat="server" AutoPostBack="True" 
                    DataSourceID="SDS_Expanse" DataTextField="E_Name" DataValueField="E_Code">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SDS_Expanse" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
                    
                    
                    SelectCommand="SELECT Expenditure.E_Code, Expenditure.E_Name FROM Expenditure  WHERE LEFT(E_Code,1)='5'  order by E_Name"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                Expance Date :</td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_PODate" runat="server" Width="200px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
                <asp:HiddenField ID="HF_Expance_Date" runat="server" />
            </td>
        </tr>
        <tr>
                                <td width="30%" align="right">
                                    Cost Center :
                                </td>
                                <td width="50%" align="left">
                                    <asp:DropDownList ID="ddlCostCenter" runat="server" DataTextField="CostCenterName"
                                        Width="257px" DataValueField="CostCenterID">
                                    </asp:DropDownList>
                                </td>
                            </tr>
        <tr>
            <td align="right">
                Amount :</td>
            <td>
                <asp:TextBox ID="TXT_Amount" runat="server" Width="83px"></asp:TextBox>
&nbsp;<span class="style2">Rs. </span>
            </td>
        </tr>
        <tr>
            <td align="right">
                By Employee:</td>
            <td>
                <asp:DropDownList ID="DDL_Employee" runat="server" AutoPostBack="True" 
                    DataSourceID="SDS_Employee" DataTextField="Name" DataValueField="EmpID">
                </asp:DropDownList>
                 <strong>Search :</strong><asp:TextBox ID = "txt_Consultant" runat = "server" AutoPostBack="True" 
                        TabIndex="4" ontextchanged="txt_Consultant_TextChanged"></asp:TextBox>

                 <asp:HiddenField ID ="hf_consultant" runat ="server" value ="%" />
                <asp:SqlDataSource ID="SDS_Employee" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
                    SelectCommand="SELECT     Name, EmpID
FROM         Employee where name like '%'+@name+'%' order by Name ">
                   <SelectParameters>
<asp:Parameter Name="name" DefaultValue="%" />
</SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                Description :</td>
            <td>
                <asp:TextBox ID="TXT_Description" runat="server" Height="100px" 
                    TextMode="MultiLine" Width="235px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="LabelACNO" runat="server" Text="Account #"></asp:Label>
            </td>
             <td>
                <asp:RadioButtonList ID="RBL_Am_Type" runat="server" AutoPostBack="True" 
                    RepeatDirection="Horizontal">
                    <asp:ListItem Value="ExpenseCash">Cash/Accrued Expense</asp:ListItem>
                    <%--<asp:ListItem Value="BANK">Cheque</asp:ListItem>--%>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="LabelAC" runat="server" Text="Account #" ></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="DDL_AC_NO" runat="server" AutoPostBack="True" 
                    DataSourceID="SDS_Bank_Account" DataTextField="E_Name" 
                    DataValueField="E_Code" >
                </asp:DropDownList>
                <br />
                <asp:HiddenField ID="HF_Branch_Access" runat="server" />
                <asp:HiddenField ID="HF_AC" runat="server" />
                <asp:SqlDataSource ID="SDS_Bank_Account" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
        
        
                    
                    
                    
                    SelectCommand="SELECT Expenditure.E_Name, Expenditure.E_Code FROM Head_Master_Table INNER JOIN Expenditure ON Head_Master_Table.E_Code = Expenditure.E_Code WHERE (Head_Master_Table.Head_Type = @Head_Type)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="RBL_Am_Type" Name="Head_Type" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
    </asp:SqlDataSource>
                </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="BTN_Save" runat="server" Text="Save" />
                <asp:Label ID="LBL_MSG" runat="server" ForeColor="Red"></asp:Label>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:GridView ID="GV_Record" runat="server" Width="100%" 
                    AutoGenerateColumns="False" DataSourceID="SDS_GV" DataKeyNames="id">
                    <Columns>
                        <asp:BoundField DataField="Expanse" HeaderText="Expanse" 
                            SortExpression="Expanse" />
                        <asp:BoundField DataField="Date" HeaderText="Expance Date" 
                           DataFormatString="{0:dd/MM/yyyy}" SortExpression="Date" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" 
                            SortExpression="Amount" />
                        <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" 
                            SortExpression="Name" />
                        <asp:BoundField DataField="Description" HeaderText="Description" 
                            SortExpression="Description" />
                        <asp:BoundField DataField="CostCenterName" HeaderText="Cost Center" SortExpression="CostCenterName" />
                        <asp:BoundField DataField="Payment_Type" HeaderText="Payment Type" 
                            SortExpression="Payment_Type" />
                      
                        <asp:BoundField DataField="Account_No" HeaderText="Account No." 
                            SortExpression="Account_No" />
 <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkViewReport" Text="View Report" ToolTip='<%# Eval("id") %>' runat="server" OnClick="LinkViewReport_Click" ></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                <asp:SqlDataSource ID="SDS_GV" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
                    InsertCommand="insert_expanse_Record" InsertCommandType="StoredProcedure" 
                    
                    SelectCommand="SELECT Expenditure_1.E_Name AS Expanse, Expanse_Record.Amount, Employee.Name, Expanse_Record.Description, Expanse_Record.Payment_Type, Expenditure.E_Name AS Account_No, Expanse_Record.Id, Expanse_Record.ExpenceDate AS Date, Expanse_Record.CostCentre, CostCenter.CostCenterName FROM Expanse_Record INNER JOIN Expenditure AS Expenditure_1 ON Expanse_Record.E_Code = Expenditure_1.E_Code INNER JOIN Employee ON Expanse_Record.Emp_ID = Employee.EmpID LEFT OUTER JOIN CostCenter ON Expanse_Record.CostCentre = CostCenter.CostCenterID LEFT OUTER JOIN Expenditure ON Expanse_Record.Account_Ecode = Expenditure.E_Code WHERE (Expanse_Record.Dept_ID = @Dept_ID) AND (Expanse_Record.Subdept_ID = @SubDeptID)" 
                    DeleteCommand="delete_expanse_Record" DeleteCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="id" Type="Int32" />
                        <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
                        <asp:SessionParameter Name="Financial_Company_ID" 
                            SessionField="financial_company_id" Type="Int32" />
                        <asp:SessionParameter Name="Company_Branch_ID" SessionField="company_branch_id" 
                            Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="ddl_Expanse" Name="E_Code" 
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="TXT_Amount" Name="Amount" PropertyName="Text" 
                            Type="Int32" />
                        <asp:ControlParameter Name="Emp_ID" Type="Int32" ControlID="DDL_Employee" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="TXT_Description" Name="Description" 
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="RBL_Am_Type" Name="Payment_Type" 
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="DDL_AC_NO" Name="Account_Ecode" 
                            PropertyName="SelectedValue" Type="String" />
                        <asp:SessionParameter Name="Add_By_Emp_ID" SessionField="emp_iD" Type="Int32" />
                        <asp:SessionParameter Name="Financial_Company_ID" 
                            SessionField="Financial_company_ID" Type="Int32" />
                        <asp:SessionParameter Name="Company_Branch_ID" SessionField="Company_Branch_ID" 
                            Type="Int32" />
                        <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                        <asp:SessionParameter Name="SubDept_ID" SessionField="subdeptid" Type="Int32" />
                        <asp:ControlParameter ControlID="HF_Expance_Date" Name="ExpanceDate" 
                            PropertyName="Value" Type="DateTime" />
                        <asp:ControlParameter ControlID="ddlCostCenter" Name="CostCentre" PropertyName="SelectedValue" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="Dept_ID" SessionField="Dept_id" />
                        <asp:SessionParameter Name="SubDeptID" SessionField="Subdeptid" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
   
 
 
 
 
</asp:Content>
