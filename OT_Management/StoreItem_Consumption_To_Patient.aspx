<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_billing.master" AutoEventWireup="false" CodeFile="StoreItem_Consumption_To_Patient.aspx.vb" Inherits="Pharmacy_StoreItem_Consumption_To_Patient" %>


 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<div class="bxmain">

<table width="100%"  cellpadding="0" cellspacing="0" class="tbl_form">  
 
                    <tr>
                        <td align="right" width="40%" style="height: 18px"  >
                            Hospital Visit # :</td>
                        <td   width="60%" style="height: 18px" >
                      <asp:TextBox ID="TextBox_CODNo" runat="server"  CssClass="input_txt" AutoPostBack="True" Enabled="False" ReadOnly="True"></asp:TextBox>                        </td>
                    </tr>
                    
    <tr>
        <td >
           <div align="left"> <asp:LinkButton ID="LinkButton_AppDate" runat="server" CssClass="report" 
            Width="66px"  OnClick ="LinkButton_AppDate_Click">App.  Report</asp:LinkButton></div><div align="right"> Select :</div>
        </td>
        <td>
            <asp:RadioButtonList ID="RadioButtonList_Medicine_OF" runat="server" AutoPostBack="True"
                RepeatDirection="Horizontal">
                <asp:ListItem Value="P">Patient Medicine</asp:ListItem>
                <asp:ListItem Value="D" Selected="True">Department Medicine</asp:ListItem>
            </asp:RadioButtonList> <asp:DropDownList ID="DropDownList_Department" runat="server" Width="202px" DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name" DataValueField="Dept_ID" Visible="False">                            </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                SelectCommand="SELECT Dept_ID, Dept_Name FROM Department"></asp:SqlDataSource>  
            <br />
            <asp:DropDownList ID="DropDownList_Testbooking" runat="server" Width="325px" 
                DataSourceID="SqlDataSource_TestBooking" DataTextField="TB_Name" 
                DataValueField="TB_ID" Height="26px">                            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource_TestBooking" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>" SelectCommand="SELECT     Test_Booking.TB_ID, Test_Booking.TB_Name
FROM         Test_Booking INNER JOIN
                      Test_Booking_Services ON Test_Booking.TB_ID = Test_Booking_Services.TB_ID
                      where Test_Booking_Services.Main_ID=@Main_Id and Test_Booking.MG_Id=26



">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Main_Id" QueryStringField="Main_Id" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
     
    </table></div>
<br />

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td valign="top" width="33%" style="background:url(../images_hacims/img_dots_ver.png) top right repeat-y;">
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="20%" align="right">Type :</td>
<td width="80%"> <asp:RadioButtonList ID="RadioButtonList_medkind" runat="server" CssClass="text_boxtitle"
                                RepeatColumns="5" RepeatLayout="Flow">
                                <asp:ListItem Value="%" Selected="True">All Items</asp:ListItem>
                                </asp:RadioButtonList></td>
  </tr>
  <tr>
    <td align="right">Name :</td>
<td><asp:TextBox ID="TextBox_specificMedicine" runat="server" CssClass="input_txt" Width="165px"></asp:TextBox>
                                        <asp:Button ID="Button1" runat="server" Text="Search" Width="60px"/></td>
  </tr>
</table>

    
    
    
    
    
   
 <br />
      <asp:GridView ID="GridViewMedicine" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="SqlDataSourceGridMedicine" Width="98%" 
            EnableModelValidation="True">
                                <Columns>
                                    <asp:BoundField DataField="MedCode" HeaderText="MedCode" ReadOnly="True" SortExpression="MedCode"
                                        Visible="False" />
                                    <asp:ButtonField DataTextField="Medicine Name" HeaderText="Medicine Name" CommandName="Select" SortExpression="Medicine Name" />
                                    <asp:BoundField DataField="Medicine Name" HeaderText="Medicine Name" SortExpression="Medicine Name"
                                        Visible="False" />
                                    <asp:BoundField DataField="Stock" HeaderText="Stock" SortExpression="Stock" 
                                        Visible="False" />
                                    <asp:TemplateField HeaderText="Quantity">
                                        <ItemTemplate>
                                            <asp:TextBox ID="TextBox_Qty" runat="server" Text='<%# Bind("Default_Qty", "{0}") %>' CssClass="input_txt" Width="50px"></asp:TextBox>
                                            <asp:HiddenField ID="HiddenFieldMedCode" runat="server" Value='<%# Eval("MedCode", "{0}") %>' />
                                            <asp:HiddenField ID="HiddenField_s_ID" runat="server" />
                                            <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Batch No." Visible="False">
                                        <ItemTemplate>
                                            <asp:TextBox ID="TextBoxBatchNo" runat="server" CssClass="input_txt" Width="121px" Visible="False"></asp:TextBox>&nbsp;
                                            <br />
                                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceBatch"
                                                DataTextField="BatchNo" DataValueField="BatchNo" Width="128px">
                                            </asp:DropDownList><br />
                                            <asp:HiddenField ID="HiddenField3" runat="server" Value='<%# Eval("MedCode", "{0}") %>' />
                                            <asp:HiddenField ID="HiddenField_MedName" runat="server" Value='<%# Eval("[Medicine Name]") %>' />
                                            <asp:SqlDataSource ID="SqlDataSourceBatch" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT ISNULL(Store_Item_Received_Sub.BatchNo, 'Nil') AS BatchNo&#13;&#10;FROM         Store_Item_Received_Main INNER JOIN&#13;&#10;                      Store_Item_Received_Sub ON Store_Item_Received_Main.Store_Receive_Main_ID = Store_Item_Received_Sub.Store_Receive_Main_ID&#13;&#10;WHERE     (Store_Item_Received_Main.Receive_Dept_Id =@Dept_Id) AND (Store_Item_Received_Main.Receive_Sub_dept_Id = @Sub_dept_Id) AND &#13;&#10;                      (Store_Item_Received_Sub.Item_Code = @Item_Code)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="HiddenField3" Name="Item_Code" PropertyName="Value" />
                                                    <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />
                                                    <asp:SessionParameter Name="Sub_dept_Id" SessionField="SubDeptId" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Retail Price" SortExpression="Retail_Unit_Price" 
                                        Visible="False">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Retail_Unit_Price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            &nbsp;<asp:TextBox ID="TextBox_RetailPrice" runat="server" Text='<%# Bind("Retail_Unit_Price") %>' Width="50px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                        
                            <asp:HiddenField ID="HiddenField_Qty" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSourceGridMedicine" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                                SelectCommand="[Select_Medicine_For_Patient_Consumption]" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="TextBox_specificMedicine" DefaultValue="%" Name="mgname"
                                        PropertyName="Text" Type="String" />
                                    <asp:ControlParameter ControlID="RadioButtonList_medkind" DefaultValue="%" Name="medkind"
                                        PropertyName="SelectedValue" Type="String" />
                                    <asp:ControlParameter ControlID="RadioButtonList_Medicine_OF" DefaultValue="" Name="Medicine_OF"
                                        PropertyName="SelectedValue" Type="String" />
                                    <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" Type="Int32" />
                                    <asp:ControlParameter ControlID="TextBox_CODNo" Name="yearly_No" PropertyName="Text"
                                        Type="Decimal" />
                                    <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" Type="String" />
                                    <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" Type="Int32" />
                                </SelectParameters>
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="INSERT INTO Patient_Services(RegNo, YearlyNo, sdatetime, empid, S_ID, Amount, Payment_Status, SubDept_ID, Dept_ID) VALUES (@RegNo, @YearlyNo, getdate(), @empid, @S_ID, @Amount, 0, @SubDept_ID, @Dept_ID)"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_Reg_No" Name="RegNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="TextBox_CODNo" Name="YearlyNo" PropertyName="Text" />
            <asp:SessionParameter Name="empid" SessionField="emp_ID" />
            <asp:ControlParameter ControlID="HiddenField_s_ID" Name="S_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_amount" Name="Amount" PropertyName="Value" />
            <asp:SessionParameter Name="SubDept_ID" SessionField="subdeptID" />
            <asp:SessionParameter Name="Dept_ID" SessionField="dept_ID" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_s_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
    <asp:HiddenField ID="HiddenField_amount" runat="server" /></td>
    <td valign="top" width="33%" style="background:url(../images_hacims/img_dots_ver.png) top right repeat-y;">
        <asp:GridView ID="GridView_TemP_Test" runat="server" CssClass="tbl_2" ShowFooter="True"
            Width="96%" Style="margin-left:10px;" Height="127px">
            <RowStyle CssClass="GridItem" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <Columns>
                <asp:ButtonField CommandName="Select" Text="Delete" />
            </Columns>
            <FooterStyle CssClass="GridHeader" />
        </asp:GridView>
        <br />
   <div align="center">  <asp:Button ID="Button_Consumption" runat="server" 
           Text="Save" Width="58px" />  
       <asp:Button ID="Button_Final" runat="server" 
           Text="Refer for Reporting" Width="136px" /> 
                  <asp:SqlDataSource ID="SqlDataSource_Update_Status" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                      
           ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" 
           UpdateCommand="Update_Patient_Test_StatusConsumption" 
           UpdateCommandType="StoredProcedure">
                      <UpdateParameters>
                          <asp:Parameter DefaultValue="1" Name="Status" />
                          <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
                          <asp:QueryStringParameter Name="RegNo" QueryStringField="Reg_No" />
                          <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
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
    </asp:SqlDataSource></td>
    <td valign="top" width="33%">
        <br />

<div align="center">        
        <asp:GridView ID="GridView_Consumed" runat="server" CssClass="tbl_2" ShowFooter="True"
            Width="113%" Style="margin-left:10px;" AutoGenerateColumns="False" 
        DataKeyNames="Consumption_Id" DataSourceID="SqlDataSource_Patient_Consumption" 
        EnableModelValidation="True">
            <RowStyle CssClass="GridItem" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <Columns>
                <asp:BoundField DataField="Consumed_Date" HeaderText="Date" ReadOnly="True" 
                    SortExpression="Consumed_Date" />
                <asp:BoundField DataField="Item_Code" HeaderText="Item_Code" 
                    SortExpression="Item_Code" Visible="False" />
                <asp:BoundField DataField="Item_Name" HeaderText="Item Name" ReadOnly="True" 
                    SortExpression="Item_Name" />
                <asp:BoundField DataField="Consumed_QTY" HeaderText="QTY" ReadOnly="True" 
                    SortExpression="Consumed_QTY" />
                <asp:BoundField DataField="Consumption_Id" HeaderText="Consumption_Id" 
                    InsertVisible="False" ReadOnly="True" SortExpression="Consumption_Id" 
                    Visible="False" />
                <asp:BoundField DataField="Consume_Amount" HeaderText="Consume_Amount" 
                    SortExpression="Consume_Amount" Visible="False" />
                <asp:BoundField DataField="ptcharege" HeaderText="ptcharege" ReadOnly="True" 
                    SortExpression="ptcharege" Visible="False" />
            </Columns>
            <FooterStyle CssClass="GridHeader" />
        </asp:GridView>
    <asp:Button ID="Button_Print" runat="server" Text="Print Report" /></div>  <br />
        <asp:SqlDataSource ID="SqlDataSource_Patient_Consumption" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT     CONVERT(varchar, StoreItem_Consumption_Main.Consumed_Date, 103) AS Consumed_Date, StoreItems_Consumption_Detail.Item_Code, &#13;&#10;                      ISNULL(Store_Items.Drug_Category + ' ', '') + ISNULL(Store_Items.Item_Name + '', '') + ISNULL(Store_Items.Potency + '', '') + ISNULL(Store_Items.Unit + '', '') &#13;&#10;                      AS Item_Name, SUM(StoreItems_Consumption_Detail.Consumed_QTY) AS Consumed_QTY, StoreItem_Consumption_Main.Consumption_Id, &#13;&#10;                      StoreItems_Consumption_Detail.Consume_Amount, sum(StoreItems_Consumption_Detail.Pt_Charge_Consumption) as ptcharege&#13;&#10;FROM         StoreItem_Consumption_Main INNER JOIN&#13;&#10;                      StoreItems_Consumption_Detail ON StoreItem_Consumption_Main.Consumption_Id = StoreItems_Consumption_Detail.Consumption_Id INNER JOIN&#13;&#10;                      Store_Items ON StoreItems_Consumption_Detail.Item_Code = Store_Items.Item_Code&#13;&#10;WHERE     (StoreItem_Consumption_Main.Shift_Id = @Shift_Id) AND (StoreItem_Consumption_Main.Dept_iD = @Dept_iD) AND &#13;&#10;                      (StoreItem_Consumption_Main.SubDept_Id = @SubDept_Id) AND (StoreItem_Consumption_Main.Yearly_No = @Yearly_No)&#13;&#10;GROUP BY StoreItem_Consumption_Main.Yearly_No, StoreItem_Consumption_Main.Consumed_Date, StoreItem_Consumption_Main.Consumption_Id, &#13;&#10;                      StoreItems_Consumption_Detail.Item_Code, ISNULL(Store_Items.Drug_Category + ' ', '') + ISNULL(Store_Items.Item_Name + '', '') + ISNULL(Store_Items.Potency + '', &#13;&#10;                      '') + ISNULL(Store_Items.Unit + '', ''), StoreItems_Consumption_Detail.Consume_Amount&#13;&#10;&#13;&#10;">
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
</table>

<br />
<br />
<br />





  </asp:Content>