<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="audit_GeneralLedger, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
   <%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../css/AppMessage.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 
 <asp:Panel ID="pnlMsg" runat="server">
    <asp:Label ID="lblMessage" runat="server" CssClass="lblErrorSpan" Text=""></asp:Label>
</asp:Panel>

<div class="bxmain inner_content" style="width:100%;">
    <h2><span>General Ledger</span></h2>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right" width="40%"> Select Company : </td>
    <td width="60%">
                <asp:DropDownList ID="DropDownList_Companyname" runat="server" 
                    AutoPostBack="True" DataSourceID="SQL_Companyname" 
                    DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id" 
                  >
                </asp:DropDownList>
            </td>
  </tr>
  <tr>
    <td align="right" width="40%"> Select Branch : </td>
    <td width="60%">
                <asp:DropDownList ID="DropDownList_Branchname" runat="server" 
                    AutoPostBack="True" DataSourceID="SQL_Branchname" 
                    DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id" 
                  >
                </asp:DropDownList>
            </td>
  </tr>
  <tr>
    <td align="right" width="40%"> Level I : </td>
    <td width="60%"><asp:DropDownList ID="DropDownList_Sub_EH_Name" runat="server" AutoPostBack="True"
            CssClass="dropbox" DataSourceID="SqlDataSource_EH" DataTextField="EH_Name" DataValueField="EH_Code"
            >
        </asp:DropDownList></td>
  </tr>
  
  <tr>
    <td align="right"> Level IV : </td>
    <td><asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_expenditure"
            DataTextField="E_Name" DataValueField="E_Code"  >
        </asp:DropDownList></td>
  </tr>
  
  <tr>
    <td align="right">From :</td>
    <td><igsch:webdatechooser id="WebDateChooserSdate" runat="server" value="2010-06-18" Width="181px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
        </igsch:webdatechooser></td>
  </tr>
  <tr>
    <td align="right">To :</td>
    <td><igsch:webdatechooser id="WebDateChooserEDate" runat="server" value="2010-06-18" Width="181px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:webdatechooser></td>
  </tr>
  <tr>
    <td align="right"> </td>
    <td><asp:Button ID="Button1" runat="server" Text="Search"  />    
      <asp:Button ID="Btn_Print" runat="server" Text="Print" Visible="false" />
        <asp:Label ID="Lbl_mg" runat="server"></asp:Label>
      </td>
  </tr>
  
</table>

</div>

<br />
        <asp:SqlDataSource ID="SqlDataSource_sub_ESH" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            
            SelectCommand="SELECT [ESH_Code], [ESH_Name], [EH_Code] FROM [Expenditure_Sub_Heading] WHERE ([EH_Code] = @EH_Code)" 
            ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_Sub_EH_Name" Name="EH_Code" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Companyname" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" 
        
        SelectCommand="SELECT 0 AS Financial_Company_Id, 'ALL' AS Financial_Company_Name UNION SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies WHERE (Financial_Company_Id IN (SELECT Financial_Company_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_ID)))">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Branchname" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" 
        SelectCommand="SELECT 0 AS Company_Branch_Id, 'ALL' AS Company_Branch_Name UNION SELECT Company_Branch_Id, Company_Branch_Name FROM Group_Company_Branches WHERE (Company_Branch_Id IN (SELECT Company_Branch_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_ID))) AND (CONVERT (varchar, Financial_Company_Id) LIKE CASE @Financial_Company_Id WHEN 0 THEN '%' ELSE CONVERT (varchar , @Financial_Company_Id) END)">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
            <asp:ControlParameter ControlID="DropDownList_Companyname" 
                Name="Financial_Company_Id" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_expenditure" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            DeleteCommand="DELETE FROM [Expenditure] WHERE [E_Code] = @E_Code" InsertCommand="INSERT INTO [Expenditure] ([E_Code], [E_Name], [ESH_Code]) VALUES (@E_Code, @E_Name, @ESH_Code)"
            SelectCommand="Select E.E_Code,E.E_Code+' - '+E.E_Name E_Name
                            From Expenditure_Sub_Heading ESH
                            Inner Join Expenditure E On ESH.ESH_Code=E.ESH_Code
                            Where ESH.EH_Code=@EH_Code"
            UpdateCommand="UPDATE [Expenditure] SET [E_Name] = @E_Name, [ESH_Code] = @ESH_Code WHERE [E_Code] = @E_Code" 
            ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>">
            <DeleteParameters>
                <asp:Parameter Name="E_Code" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="E_Name" Type="String" />
                <asp:Parameter Name="ESH_Code" Type="String" />
                <asp:Parameter Name="E_Code" Type="String" />
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_Sub_EH_Name" Name="EH_Code" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox_E_Code" Name="E_Code" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_E_Name" Name="E_Name" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList_Sub_ESH_name" Name="ESH_Code" PropertyName="SelectedValue"
                    Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
  
        <asp:SqlDataSource ID="SqlDataSource_EH" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
            DeleteCommand="DELETE FROM [Expenditure_Heading] WHERE [EH_Code] = @EH_Code"
            InsertCommand="INSERT INTO [Expenditure_Heading] ([EH_Code], [EH_Name]) VALUES (@EH_Code, @EH_Name)"
            SelectCommand="SELECT [EH_Code], [EH_Code]+' - '+[EH_Name] [EH_Name] FROM [Expenditure_Heading]" 
            UpdateCommand="UPDATE [Expenditure_Heading] SET [EH_Name] = @EH_Name WHERE [EH_Code] = @EH_Code" 
            ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>">
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
      

        <asp:HiddenField ID="HiddenFieldEdate" runat="server" />
        <asp:HiddenField ID="HiddenFieldSdate" runat="server" />
      
      <br />
   
     
     
<table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td align="right" >
                    <strong>
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Blue" Text="Opening Balance"
                        Visible="False"></asp:Label>
                </strong></td>
                <td >
            <asp:Label ID="lbl_Dr" runat="server" Font-Bold="True" Text=" Dr : " Visible="False"></asp:Label><asp:Label
                        ID="lblOBDr" runat="server" Font-Bold="True" ForeColor="Black" Text="0" Visible="False"></asp:Label></td>
                <td >
                    <asp:Label ID="lbl_Cr" runat="server" Font-Bold="True" Text=" Cr : " Visible="False"></asp:Label><asp:Label
                        ID="lblOBCr" runat="server" Font-Bold="True" ForeColor="Black" Text="0" Visible="False"></asp:Label></td>
            </tr>
           
                 
        </table><br />


        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceforGrid"
            Visible="False" Width="100%" ShowFooter="True" EmptyDataText="No Record Found."
        EnableModelValidation="True" DataKeyNames="Voucher_Trans_Id" >
            <Columns>
                <asp:TemplateField HeaderText="S No">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
                <ItemStyle Width="30px" />
            </asp:TemplateField>
                <asp:BoundField DataField="For_Date" HeaderText="Date" SortExpression="For_Date" ItemStyle-Width="75px" />
                <asp:BoundField DataField="VoucherNo" HeaderText="Voucher #" SortExpression="VocherNo" ItemStyle-Width="125px" />
                <asp:BoundField DataField="E_code" HeaderText="Code" SortExpression="E_code" />
                
                <asp:BoundField DataField="E_Name" HeaderText="Account Head" SortExpression="E_Name" />
                <asp:BoundField DataField="CostCenterName" HeaderText="Cost Center" SortExpression="CostCenterName" />
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                <asp:TemplateField HeaderText="Dr" ItemStyle-CssClass="AmountAlign" SortExpression="Dr">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Dr") %>'></asp:Label>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblDr" runat="server" Font-Bold="True" Text="0"></asp:Label>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="LabelDr" runat="server" Text='<%# Eval("Dr","{0:#,#}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cr" ItemStyle-CssClass="AmountAlign" SortExpression="Cr">
                    <EditItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Cr") %>'></asp:Label>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblCr" runat="server" Font-Bold="True" Text="0"></asp:Label>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="LabelCr" runat="server" Text='<%# Eval("Cr","{0:#,#}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Balance" ItemStyle-CssClass="AmountAlign">
                    <ItemTemplate>
                        <asp:Label ID="lblbal" runat="server" Text="Label"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField HeaderText="Print Voucher" SelectText="Print Voucher" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Center"
                    ShowSelectButton="True" />
                <%--<asp:BoundField DataField="Adjusted_Account_Head" HeaderText="" />--%>
                <asp:TemplateField HeaderText="Adjusted Account" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="ltrAdjAccount" runat="server" Text='<%# Bind("Adjusted_Account_Head") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns><AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
              
         

<br />

         

        <asp:SqlDataSource ID="SqlDataSourceforGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            SelectCommand="Select_General_Voucher_Search" 
            
        
        
        
        
        ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>" 
        SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenFieldSdate" Name="S_Date" 
                    PropertyName="Value" Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenFieldEdate" Name="E_Date" 
                    PropertyName="Value" Type="DateTime" />
                <asp:ControlParameter ControlID="DropDownList1" Name="E_Code" 
                    PropertyName="SelectedValue" Type="String" />
                <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_Companyname" 
                    Name="Financial_Company_Id" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_Branchname" 
                    Name="Company_Branch_ID" PropertyName="SelectedValue" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="partyID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
       <br />
<br />
<br />
 
 
    

</asp:Content>

 