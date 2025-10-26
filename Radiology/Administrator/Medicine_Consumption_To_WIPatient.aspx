<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpagePatient.master" inherits="Medicine_Consumption_To_WIPatient, App_Web_42zygch0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:scriptmanager id="ScriptManager1" runat="server">
    </asp:scriptmanager>
    <table width="100%">
        <tr>

            <td width="80%">
                <div class="bxmain">
                  

                    <table width="100%" cellpadding="0" cellspacing="0" class="tbl_form">

                        <tr>
                            <td align="right" width="40%" style="height: 18px">COD No. :</td>
                            <td width="60%" style="height: 18px">
                                <asp:textbox id="TextBox_CODNo" runat="server" cssclass="input_txt"
                                    autopostback="True" enabled="False" readonly="True" width="45%"></asp:textbox>
                            </td>
                        </tr>

                        <tr>
                            <td align="right" width="40%" style="height: 18px">Patient&nbsp; Name :</td>
                            <td width="60%" style="height: 18px">
                                <asp:textbox id="TextBox_PAtient_name" runat="server" width="45%"></asp:textbox>
                            </td>
                        </tr>

                        <tr id="isPatient" runat="server" style="display: none">
                            <td align="right">Select :
                            </td>
                            <td>
                                <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">--%>
                                <contenttemplate>
            
            <asp:RadioButtonList ID="RadioButtonList_Medicine_OF" runat="server" AutoPostBack="True"
                RepeatDirection="Horizontal">
                <asp:ListItem  Value="P">Patient Medicine</asp:ListItem>
                <asp:ListItem Selected="True" Value="D">Department Medicine</asp:ListItem>
            </asp:RadioButtonList> 
            <asp:HiddenField ID = "Hf_Med_Of" runat = "server" value = "D"/>
            <asp:DropDownList ID="DropDownList_Department" runat="server" Width="202px" DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name" DataValueField="Dept_ID" Visible="False">                            </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                SelectCommand="SELECT Dept_ID, Dept_Name FROM Department"></asp:SqlDataSource>
            </contenttemplate>
                                <%-- </asp:UpdatePanel>--%>
                            </td>
                        </tr>

                    </table>
                </div>
            </td>
            <td valign="top">
                <div align="right">
                    <asp:button id="Btn_Medication" runat="server" text="Medication" visible="false" />
                    <asp:Button ID = "Btn_loadWI" runat = "server" Text = "Load Walk In Patient "  />
                </div>
            </td>
        </tr>
    </table>


    <br />
    <%--<asp:UpdatePanel ID="UpdatePanel2" runat="server">
    --%>
    <contenttemplate>
            
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td valign="top" width="33%" style="background:url(../images_hacims/img_dots_ver.png) top right repeat-y;">
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr style = "display:none">
    <td width="20%" align="right">Type :</td>
<td width="80%"> <asp:RadioButtonList ID="RadioButtonList_medkind" runat="server" CssClass="text_boxtitle"
                                RepeatColumns="5" RepeatLayout="Flow">
                                <asp:ListItem Value="i%">INJ</asp:ListItem>
                                <asp:ListItem Value="t%">TAB</asp:ListItem>
                                <asp:ListItem Value="c%">CAP</asp:ListItem>
                                <asp:ListItem Selected="True" Value="%">ANY</asp:ListItem></asp:RadioButtonList></td>
  </tr>
  <tr>
    <td align="right">Name :</td>
<td><asp:TextBox ID="TextBox_specificMedicine" runat="server" CssClass="input_txt" Width="165px"></asp:TextBox>
                                        </td>
  </tr>
  <tr>
    <td align="right">Medicine Code:</td>
<td><asp:TextBox ID="TextBox_Med_Code" runat="server" CssClass="input_txt" 
        Width="165px"></asp:TextBox>
<asp:Button ID="Button1" runat="server" Text="Search" Width="60px"/>
                                        </td>
  </tr>
</table>

    
    
    
    
    
   
 <br />
      <asp:GridView ID="GridViewMedicine" runat="server" AutoGenerateColumns="False" 
                                 Width="98%" 
            AllowPaging="True" PageSize="50">
                                <Columns>
                                    <asp:BoundField DataField="MedCode" HeaderText="MedCode" ReadOnly="True" SortExpression="MedCode"
                                        Visible="False" />
                                    <asp:ButtonField DataTextField="Medicine Name" HeaderText="Medicine Name" CommandName="Select" SortExpression="Medicine Name" />
                                    <asp:BoundField DataField="Medicine Name" HeaderText="Medicine Name" SortExpression="Medicine Name"
                                        Visible="False" />
                                   <%-- <asp:BoundField DataField="Stock" HeaderText="Stock" SortExpression="Stock" />--%>
                                    <asp:TemplateField HeaderText="Quantity">
                                        <ItemTemplate>
                                            <asp:TextBox ID="TextBox_Qty" runat="server" Text='<%# Bind("Default_Qty", "{0}") %>' CssClass="input_txt" Width="50px"></asp:TextBox>
                                            <asp:HiddenField ID="HiddenField_RetailPrice" runat="server" 
                                                Value='<%# Eval("Retail_Unit_Price", "{0}") %>' />
                                            <asp:HiddenField ID="HiddenFieldMedCode" runat="server" Value='<%# Eval("MedCode", "{0}") %>' />
                                            <asp:HiddenField ID="HiddenField_s_ID" runat="server" value = "25812"/>
                                            <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Batch No.">
                                        <ItemTemplate>
                                            <asp:TextBox ID="TextBoxBatchNo" runat="server" CssClass="input_txt" Width="121px" Visible="False"></asp:TextBox>
                                            <br /><asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceBatch"
                                                DataTextField="BatchNo" DataValueField="BatchNo" Width="128px">
                                            </asp:DropDownList>
                                            <asp:HiddenField ID="HiddenField3" runat="server" Value='<%# Eval("MedCode", "{0}") %>' />
                                            <asp:HiddenField ID="HiddenField_MedName" runat="server" Value='<%# Eval("[Medicine Name]") %>' />
                                            <asp:SqlDataSource ID="SqlDataSourceBatch" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT ISNULL(Store_Item_Received_Sub.BatchNo, 'Nil') AS BatchNo
FROM         Store_Item_Received_Main INNER JOIN
                      Store_Item_Received_Sub ON Store_Item_Received_Main.Store_Receive_Main_ID = Store_Item_Received_Sub.Store_Receive_Main_ID
WHERE   
--  (Store_Item_Received_Main.Receive_Dept_Id =@Dept_Id) AND --(Store_Item_Received_Main.Receive_Sub_dept_Id = @Sub_dept_Id) AND 
                      (Store_Item_Received_Sub.Item_Code = @Item_Code)" CancelSelectOnNullParameter="False">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="HiddenField3" Name="Item_Code" PropertyName="Value" />
                                                    <%--<asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />
                                                    <asp:SessionParameter Name="Sub_dept_Id" SessionField="SubDeptId" />--%>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Retail Price" SortExpression="Retail_Unit_Price">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Retail_Unit_Price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            &nbsp;<asp:TextBox ID="TextBox_RetailPrice" runat="server" Text='<%# Bind("Retail_Unit_Price") %>' Width="50px"></asp:TextBox>
                                            <br />
                                            <br />
                                           
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                            <asp:HiddenField ID="Hf_deptid" runat="server" />
                            <asp:HiddenField ID="Hf_Subdeptid" runat="server" />
                            <asp:HiddenField ID="HiddenField_Qty" runat="server" />
                            <asp:SqlDataSource ID="SDS_Consumption_Voucher" 
            runat="server" 
            ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
            InsertCommand="[JV_ItemConsumption_Voucher]" 
            InsertCommandType="StoredProcedure" 
            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:Parameter Name="Consumption_Id" Type="Decimal" />
                                    <asp:Parameter Name="IB_ID" Type="String" />
                                    <asp:Parameter Name="By_Emp_Id" Type="Int32" />
                                    <asp:Parameter Name="Designation_Id" Type="Int32" />
                                    <asp:Parameter Name="SubDept_Id" Type="Decimal" />
                                    <asp:Parameter Name="Dept_Id" Type="Decimal" />
                                    <asp:Parameter Name="Company_Id" Type="Decimal" />
                                </InsertParameters>
        </asp:SqlDataSource>
                            
                            <asp:HiddenField ID="HiddenField_MedCode" runat="server" />
                            <asp:HiddenField ID="HiddenField_MainId" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSourceInsertMain" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                InsertCommand="Store_Item_Issue_To_Patient_Main" InsertCommandType="StoredProcedure"
                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBox_CODNo" Name="YearlyNo" PropertyName="Text"
                                        Type="Decimal" />
                                    <asp:SessionParameter Name="ShiftID" SessionField="ShiftID" Type="Int32" />
                                    <asp:SessionParameter Name="Issue_By_Dept_ID" SessionField="Dept_id" Type="Int32" />
                                    <asp:SessionParameter Name="Issue_By" SessionField="Emp_id" Type="Int32" />
                                    <asp:SessionParameter Name="Issue_By_Sub_Dept_ID" SessionField="SubDeptId" Type="Int32" />
                                    <asp:ControlParameter ControlID="DropDownList_Department" Name="Issue_To_Dept_Id"
                                        PropertyName="SelectedValue" Type="Int32" />
                                    <asp:Parameter Direction="InputOutput" Name="Issue_By_Main_Id" Type="Int32" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceInsertSub" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                InsertCommand="Insert_Store_Item_Issue_Sub" InsertCommandType="StoredProcedure"
                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="HiddenField_MedCode" Name="Item_Code" PropertyName="Value"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="HiddenField_Qty" Name="Item_Qty" PropertyName="Value"
                                        Type="Int32" />
                                    <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" Type="Int32" />
                                    <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" Type="Int32" />
                                    <asp:ControlParameter ControlID="HiddenFieldBatchNo" Name="BatchNo" PropertyName="Value"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="HiddenField_MainId" Name="Store_Item_Issue_Id" PropertyName="Value"
                                        Type="Decimal" />
                                </InsertParameters>
                            </asp:SqlDataSource>                        
    <asp:HiddenField ID="HiddenFieldBatchNo" runat="server" />
    <asp:SqlDataSource ID="SDS_RECORD" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
        InsertCommand="Insert_medicine_consp_billing"
        UpdateCommand="UPDATE Patient_Services SET Payment_Status = 1 WHERE (ID = @ID); Update Advance_Payment SET Payment_Status=1 Where YearlyNo=@YearlyNo"
        ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>" 
            InsertCommandType="StoredProcedure">
        <InsertParameters>
              <asp:SessionParameter Name="deptid" SessionField="dept_id" Type="Int32" />
              <asp:SessionParameter Name="Subdeptid" SessionField="subdeptid" Type="Int32" />
              <asp:SessionParameter Name="ShiftID" SessionField="shiftid" Type="Int32" />
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="yearlyNo" />
            <asp:Parameter Name="XML_Sub" Type="String" />
            <asp:Parameter Name="Patient_Type_Id" Type="Int32" DefaultValue="11" />
            <asp:Parameter Name="IPD_OPD" Type="String" DefaultValue="opd" />
            <asp:Parameter Name="Billing_Party_Id" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Payment_Status" Type="Boolean" DefaultValue="false" />
            <asp:Parameter Name="Doctor_ID" Type="Int32" DefaultValue="0" />
<asp:SessionParameter SessionField="hospitalid" Name="Hospital_Id" DefaultValue="" 
                  Type="Int32"></asp:SessionParameter>
            <asp:Parameter Name="S_ID" Type="Int32"  DefaultValue="547"/>
            <asp:Parameter Name="total_Amount" Type="Decimal" />
              <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
              <asp:Parameter Name="Patient_name" Type="String" />
              <asp:Parameter Direction="InputOutput" Name="Consumption_Id" Type="Int32" />
        </InsertParameters>
       
        <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenFieldID" Name="ID" PropertyName="Value" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    </UpdateParameters>
        
    </asp:SqlDataSource>
    <%--<InsertParameters>
            <asp:SessionParameter Name="RegNo" SessionField="regNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="yearlyNo" />
          
            <asp:ControlParameter ControlID="HiddenField_s_ID" Name="S_ID" 
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_amount" Name="Amount" PropertyName="Value" />
            <asp:SessionParameter Name="SubDept_ID" SessionField="subdeptID" />
            <asp:SessionParameter Name="Dept_ID" SessionField="dept_ID" />
        </InsertParameters>--%>
    <asp:HiddenField ID="HiddenField_s_ID" runat="server"  Value = "25812"/>
    <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
    <asp:HiddenField ID="HiddenField_amount" runat="server" />
    <asp:HiddenField ID="HF_Emp_subdept" runat="server" />
    <asp:HiddenField ID="HF_Emp_dept" runat="server" />
    <asp:HiddenField ID="HiddenField_smpID" runat="server" />
         <asp:HiddenField ID="HF_PS_ID" runat="server" />
         <asp:HiddenField ID="HF_Pay_MainId" runat="server" />
                  <asp:HiddenField ID="HF_Yearly_no" runat="server" />
<asp:HiddenField ID="HiddenFieldAmount" runat="server" />

                <asp:SqlDataSource ID="SDS_CashBook_Entry" runat="server"  ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    
                    
                    ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" 
                    InsertCommand="Ins_Pat_serv_and_Pay_WIP" 
                    InsertCommandType="StoredProcedure" >
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenField_amount" Name="Amount" 
                            PropertyName="Value" Type="Int32" DefaultValue="" />
                        <asp:Parameter  Direction="InputOutput" Name="Main_ID_Out" 
                            Type="Decimal" />
                        <asp:Parameter DefaultValue="11" Name="Patient_Type_Id" Type="Int32" />
                        <asp:Parameter DefaultValue="opd" Name="IPD_OPD" Type="String" />
                        <asp:Parameter DefaultValue="0" Name="Billing_Party_Id" Type="Decimal" />
                        <asp:Parameter DefaultValue="false" Name="Payment_Status" Type="Boolean" />
                        <asp:SessionParameter DefaultValue="" Name="SubDept_ID" SessionField="subdeptid" 
                            Type="Int32" />
                        <asp:SessionParameter Name="Dept_ID" 
                            SessionField="dept_id" Type="Int32" />
                        <asp:Parameter DefaultValue="0" Name="Doctor_ID" Type="Int32" />
                        <asp:SessionParameter Name="Hospital_Id" SessionField="hospitalid" Type="Int32" 
                            DefaultValue="" />
                        <asp:SessionParameter DefaultValue="" 
                            Name="RegNo" SessionField="RegistrationNo" Type="String" />
                            <asp:SessionParameter DefaultValue="" 
                            Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                     <%--   <asp:QueryStringParameter Name="YearlyNo" QueryStringField="yearlyNo" 
                            Type="Decimal" />--%>
                        <asp:SessionParameter Name="empid" SessionField="emp_id" Type="Int32" />
                        <asp:Parameter DefaultValue="1522" 
                            Name="S_ID" Type="Int32" />
                    </InsertParameters>
                    
                </asp:SqlDataSource>

    </td>
    
    <td valign="top" width="41%" style="background:url(../images_hacims/img_dots_ver.png) top right repeat-y;">
        
        <br /><asp:GridView ID="GridView_TemP_Test" runat="server" ShowFooter="True"
            Width="96%" Style="margin-left:10px;" AutoGenerateColumns="False">
            <RowStyle CssClass="GridItem" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <Columns>
                <asp:ButtonField CommandName="Select" Text="Delete" />
                
                <asp:TemplateField HeaderText="Code">
                    <ItemTemplate>
                        <asp:Label ID="lbl_CODE" runat="server" Text='<%# Bind("Medcode") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Medicine">
                    <ItemTemplate>
                        <asp:Label ID="lbl_med" runat="server" Text='<%# Bind("MedName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Batch No.">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Batch" runat="server" Text='<%# Bind("BatchNO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Qty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Rate">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Rate" runat="server" Text='<%# Bind("Rate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total">
                    <ItemTemplate>
                        <asp:Label ID="lbl_total" runat="server" Text='<%# Bind("Total") %>'></asp:Label>
                        <asp:HiddenField ID="hf_datetime" runat="server" Value = '<%# Bind("Date_Time") %>' />
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lbl_totalSum" runat="server" Font-Bold="True" />
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle CssClass="GridHeader" />
        </asp:GridView>
   <div align="center">  <asp:Button ID="Btn_Bill" runat="server" Text="Add to Bill" 
           Visible = "false" Enabled="true" /> 
    <asp:Button ID="Button_Consumption" runat="server" Text="Issue" 
           onclientclick="javascript: return confirm('Are you sure you want to Save and print?')" /> 
    <br />
    <asp:Label ID = "lbl_Message" runat = "server" ForeColor = "Red"></asp:Label>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="Delete_Issue_Item_To_Patient" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
        SelectCommand="SELECT Store_Item_Issue_Main.YearlyNo AS [COD No.], CONVERT (varchar, Store_Item_Issue_Main.Issue_Date, 107) AS Date, CONVERT (varchar, Store_Item_Issue_Main.Issue_Date, 108) AS Time, ISNULL(Store_Items.Item_Name, '') + ' ' + ISNULL(Store_Items.Unit, '') + ' ' + ISNULL(Store_Items.Potency, '') AS [Medicine Name], Store_Item_Issue_Sub.Item_Qty, Store_Item_Issue_Sub.ID, ISNULL(Store_Items.Retail_Unit_Price, 0) AS Retail_Unit_Price FROM Store_Item_Issue_Main INNER JOIN Store_Item_Issue_Sub ON Store_Item_Issue_Main.Store_Item_Issue_Id = Store_Item_Issue_Sub.Store_Item_Issue_Id INNER JOIN Store_Items ON Store_Item_Issue_Sub.Item_Code = Store_Items.Item_Code WHERE (Store_Item_Issue_Main.YearlyNo = @yearlyNo)" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridViewMedicineIssue" Name="ID" PropertyName="SelectedValue"
                Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox_CODNo" Name="yearlyNo" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="SqlDataSourceCounterClose" runat="server" 
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
            InsertCommand="Insert_Counter_Close_Sub" InsertCommandType="StoredProcedure" 
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:Parameter DefaultValue="0" Name="Main_Id" />
                <asp:ControlParameter ControlID="HiddenField_amount" Name="Amount" 
                    PropertyName="Value" />
                <asp:Parameter DefaultValue="Bill" Name="Amount_Type" />
                <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />
                <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
                <asp:SessionParameter DefaultValue="" Name="Reg_No" SessionField="RegistrationNo" />
                <asp:SessionParameter Name="YearlyNo" SessionField="yearlyNo" />
                <asp:Parameter DefaultValue="medication" Name="PaymentCategory" />
                <asp:SessionParameter Name="EMP_ID" SessionField="emp_id" Type="Int32" />
                <asp:ControlParameter ControlID="HiddenField_smpID" Name="SMP_ID" 
                    PropertyName="Value" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
      </td>
    <td valign="top" width="25%">
        <%-- <asp:BoundField DataField="Stock" HeaderText="Stock" SortExpression="Stock" />--%>
        <asp:GridView ID="DataList_Patient_Consumption" runat = "server" 
        
            DataSourceID = "SqlDataSource_Patient_Consumption" 
            DataKeyField="Consumption_Id" AutoGenerateColumns="False" 
            DataKeyNames="Consumption_Id" ShowFooter="True">
            <Columns>
        
                <asp:TemplateField >
                <ItemTemplate>
                <%# Container.DataItemIndex + 1%>
                </itemtemplate>

                </asp:TemplateField>
        
                <asp:BoundField DataField="Consumption_Id" HeaderText="Slip No." 
                    InsertVisible="False" ReadOnly="True" SortExpression="Consumption_Id" />
                <asp:BoundField DataField="Item_Name" HeaderText="Medicine" 
                    SortExpression="Item_Name" />
                <asp:BoundField DataField="Consumed_QTY" HeaderText="Qty" 
                    SortExpression="Consumed_QTY" />
                <asp:TemplateField HeaderText="Amount" Visible="false">
                
                    <ItemTemplate>
                        <asp:Label ID = "Lbl_Amount" runat = "server" 
                            Text='<%# Eval("ptcharege", "{0:#,#}") %>'></asp:Label>
                    </ItemTemplate>
                
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="Consumption_Id" 
                    DataNavigateUrlFormatString="~/pharmacy/Consumed_Medicine_Report.aspx?C_ID={0}" 
                    HeaderText="Report" Target="_blank" Text="Print" />
            </Columns>
        </asp:GridView>
        <br />

<div align="center">   <asp:HyperLink ID = "HYLK_Print" Target = "_blank" 
        NavigateUrl = "~/Pharmacy/Consumed_Medicine_Rpt.aspx" runat ="server" visible="false"
        Font-Underline="False" CssClass="btn_hacims" >Print Report</asp:HyperLink>
     <asp:Button ID="Button_Print" runat="server" Text="Print Report" Visible = "false" /></div>  <br />
        <asp:SqlDataSource ID="SqlDataSource_Patient_Consumption" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT     CONVERT(varchar, StoreItem_Consumption_Main.Consumed_Date, 103) AS Consumed_Date, StoreItems_Consumption_Detail.Item_Code, 
                      ISNULL(Store_Items.Drug_Category + ' ', '') + ISNULL(Store_Items.Item_Name + '', '') + ISNULL(Store_Items.Potency + '', '') + ISNULL(Store_Items.Unit + '', '') 
                      AS Item_Name, SUM(StoreItems_Consumption_Detail.Consumed_QTY) AS Consumed_QTY, StoreItem_Consumption_Main.Consumption_Id, 
                      StoreItems_Consumption_Detail.Consume_Amount, sum(StoreItems_Consumption_Detail.Pt_Charge_Consumption) as ptcharege
FROM         StoreItem_Consumption_Main INNER JOIN
                      StoreItems_Consumption_Detail ON StoreItem_Consumption_Main.Consumption_Id = StoreItems_Consumption_Detail.Consumption_Id INNER JOIN
                      Store_Items ON StoreItems_Consumption_Detail.Item_Code = Store_Items.Item_Code
WHERE     (StoreItem_Consumption_Main.Shift_Id = @Shift_Id) AND (StoreItem_Consumption_Main.Dept_iD = @Dept_iD) AND 
                      (StoreItem_Consumption_Main.SubDept_Id = @SubDept_Id) AND (StoreItem_Consumption_Main.Yearly_No = @Yearly_No) and (Convert(varchar,StoreItem_Consumption_Main.Consumed_Date,112) = Convert(varchar,getdate(),112))
GROUP BY StoreItem_Consumption_Main.Yearly_No, StoreItem_Consumption_Main.Consumed_Date, StoreItem_Consumption_Main.Consumption_Id, 
                      StoreItems_Consumption_Detail.Item_Code, ISNULL(Store_Items.Drug_Category + ' ', '') + ISNULL(Store_Items.Item_Name + '', '') + ISNULL(Store_Items.Potency + '', 
                      '') + ISNULL(Store_Items.Unit + '', ''), StoreItems_Consumption_Detail.Consume_Amount

">
            <SelectParameters>
                <asp:SessionParameter Name="Shift_Id" SessionField="ShiftID" />
                <asp:SessionParameter Name="Dept_iD" SessionField="dept_id" />
                <asp:SessionParameter Name="SubDept_Id" SessionField="subdeptID" />
                <asp:ControlParameter ControlID="TextBox_CODNo" Name="Yearly_No" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_Min_Alert" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                SelectCommand="[Store_Item_Available_Stock]" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                                <SelectParameters>
                                    <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptId" Type="Int32" />
                                    <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" Type="Int32" />
                                    <asp:SessionParameter Name="ShiftID" SessionField="ShiftID" Type="Int32" />
                                    <asp:ControlParameter ControlID="RadioButtonList_Medicine_OF" Name="Medicine_OF"
                                        PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>   </td>
  </tr>
  <tr>
  <td colspan = "3" align ="center">

      <asp:Panel ID="Pnl_Medication" runat="server"  Visible ="false" >
      <%--CssClass = "lightbox"--%>
      <table>
              <tr>
                      
              <td>
          </td>
              <td>
              <asp:Button ID = "Btn_Close" runat = "server" Text = "Close" />
              </td>
          </tr>
          <tr>
              <td colspan = "2">

                  <asp:DataList ID="DataList_ConfirmedPrescriptions" runat="server" 
                      DataKeyField="priscription_id" 
                      DataSourceID="SqlDataSource_Confirmed_Prescriptions" style="margin-left:15px;" 
                      Width="90%">
                      <ItemTemplate>
                          <ul class="medication">
                              <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;">
                                  <strong class="mname"><%# Eval("[Medicine Name]") %></strong><%#Eval("Para")%>
                              </li>
                              <li style="text-align :right;"><%#Eval("para_Urdu")%>
                                  </l </ul="">
                                  <asp:HiddenField ID="HiddenField_PrescriptionID0" runat="server" 
                                      Value='<%# Eval("priscription_id") %>' />
                              </li>
                          </ul>
                      </ItemTemplate>
                  </asp:DataList>
                  <asp:SqlDataSource ID="SqlDataSource_Confirmed_Prescriptions" runat="server" 
                      ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>" 
                      DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)" 
                      SelectCommand="Select_Med_Presc_Urdu" SelectCommandType="StoredProcedure">
                      <SelectParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="registrationno" 
                              Type="String" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                      </SelectParameters>
                      <DeleteParameters>
                          <asp:ControlParameter Name="priscription_id" Type="String" />
                      </DeleteParameters>
                  </asp:SqlDataSource>

              </td>
          </tr>
      </table>
      </asp:Panel>

  </td>
  </tr>
</table>

<br />
<br />
<br />

</contenttemplate>
    <%--CssClass = "lightbox"--%>
</asp:Content>
