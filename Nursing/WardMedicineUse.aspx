<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/hacims_masterpage.master" CodeFile="WardMedicineUse.aspx.cs" Inherits="WardMedicineUse"  EnableEventValidation="false"%>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


<script src="../css_hacims/ck.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     
     

<asp:SqlDataSource ID="SqlDataSource_Medicine" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                InsertCommand="patient_Use_Medicine_insert" InsertCommandType="StoredProcedure"
                SelectCommand="patient_Assigned_Medicine" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
                      <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_Yearly_No" DefaultValue="" Name="YearlyNo"
                        PropertyName="Value" Type="Int32" />
                      </SelectParameters>
                      <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="Registration_No"
                        PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_Emp_Id" Name="Emp_Id" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_mcode" Name="Medicine_Code" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_Qty" Name="Qty" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_Route" DefaultValue="12" Name="Route_Id"
                        PropertyName="Value" />
                          <asp:ControlParameter ControlID="HiddenFieldStatus" Name="Date_Time" PropertyName="Value" DefaultValue="" />
                          <asp:ControlParameter ControlID="HiddenFieldSample" Name="Date_TimeSpecimen" PropertyName="Value" />
                          <asp:ControlParameter ControlID="HiddenField_Frequency_Sub_ID" Name="Frequency_Sub_ID"
                              PropertyName="Value" Type="Int32" />
                      </InsertParameters>
                                                        </asp:SqlDataSource>

                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="Yearly_NO,Med_Code" DataSourceID="SqlDataSource_select_priscription"
                    EmptyDataText="No Recrod" Width="100%" 
        OnPreRender="GridView3_PreRender" EnableModelValidation="True">
                    <Columns>
                        <asp:TemplateField HeaderText="Medicine" SortExpression="Medicine">
                            <ItemTemplate>
                                 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                  <tr>
                                    <td><asp:Label ID="Label1" runat="server" style="color:#06C;" Text='<%# Bind("Medicine") %>'></asp:Label></td>
                                  </tr>
                                  <tr>
                                    <td>  Prescribed By : <strong><asp:Label ID="lblPrescribedBy" runat ="server" Text='<%# Eval("PrescribedBY") %>' ></asp:Label></strong></td>
                                  </tr>
                                </table>                                     
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Medicine") %>'></asp:Label>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Yearly_NO" HeaderText="Yearly_NO" ReadOnly="True" SortExpression="Yearly_NO"
                            Visible="False" />
                        <asp:BoundField DataField="Med_Code" HeaderText="Med_Code" ReadOnly="True" SortExpression="Med_Code"
                            Visible="False" />
                        <asp:BoundField DataField="days" HeaderText="Days" SortExpression="days" Visible="False" />
                        <asp:TemplateField HeaderText="Route" Visible="False">
                            <ItemTemplate>
                                <asp:DropDownList ID="Route" runat="server" Width="100px" DataSourceID="SqlDataSource_Med_Route" DataTextField="Description" DataValueField="Id">
                                </asp:DropDownList>
                                <asp:HiddenField ID="HiddenField_Med_Code" runat="server" Value='<%# Eval("Med_Code", "{0}") %>' />
                                <asp:SqlDataSource ID="SqlDataSource_Med_Route" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Select_Medicine_Category"
                                    SelectCommandType="StoredProcedure">
                                    <%--<SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Item_Code" PropertyName="Value" />
                                    </SelectParameters>--%>
                                </asp:SqlDataSource>
                                 <%--<asp:HiddenField ID="HiddenFieldCategory" runat="server" Value='<%# Eval("category", "{0}") %>' />--%> 
                                <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("Prescription_Date", "{0}") %>' />
                                
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dosage Details">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DataList ID="DataList_Frequency" runat="server" DataKeyField="Frequency_Sub_Id"
                                    DataSourceID="SqlDataSource_FrequencyDataList" RepeatColumns="10">
                                    <ItemTemplate>
                                       
                                     <div  class="medbg"> 
 <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>' style="display:block; font-family:arial; font-size:9px;" ></asp:Label>
<asp:TextBox ID="TextBox_dosage2" runat="server" Enabled='<%# Eval("txtEnDis") %>' Text='<%# Eval("Dosage") %>' Width="30px" style="height:12px; display:inline;" ReadOnly="True"></asp:TextBox>
<asp:CheckBox ID="CheckBox_Insert" runat="server" Enabled='<%# Eval("txtEnDis") %>' Checked='<%# Eval("txtEnDis") %>' /> 
<asp:HiddenField ID="HF_F_S_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                               
      </div>                                         
                                               
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="SqlDataSource_FrequencyDataList" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    SelectCommand="[Select_Patient_DetailFrequency_For_Insertion]" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Frequency_ID" Name="id" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenField_Prescription_ID" Name="Prescription_Id"
                                            PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_Frequency_ID" runat="server" Value='<%# Eval("Frequency_ID") %>' />
                                <asp:HiddenField ID="HiddenField_Prescription_ID" runat="server" Value='<%# Eval("priscription_id") %>' />
                                <asp:HiddenField ID="HiddenField_Mcode" runat="server" Value='<%# Eval("Med_Code", "{0}") %>' />
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("priscription_id") %>' Visible="False"></asp:Label>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Frequency_ID") %>' Visible="False"></asp:Label> 
                                
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Stock">
                            <ItemTemplate>
                                <asp:Label ID="Label_Stock" runat="server" Text='<%# Eval("stock") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Requested Qty" SortExpression="Demand Qty">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("[Demand Qty]") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label_RequestedQty" runat="server" Text='<%# Bind("[Demand Qty]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Recived Qty" SortExpression="Recived Qty">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("[Recived Qty]") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label_ReceivedQty" runat="server" Text='<%# Bind("[Recived Qty]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hospital Medicine">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox_Hospital" runat="server" Text="Hospital Medicine" />
                                <asp:TextBox ID = "TXT_item_qty" runat ="server" text = "0" ></asp:TextBox>
                                <asp:HiddenField ID = "HF_Item_Code" runat = "server" Value = '<%# Bind("[Med_Code]") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns><RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
                  
                    <HeaderStyle CssClass="GridHeader" />
                   
                </asp:GridView>
                
                
                <asp:SqlDataSource ID="SqlDataSourceUpdatePrescription" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    UpdateCommand="[patient_Prescription_Update]" UpdateCommandType="StoredProcedure">
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="Registration_No"
                            PropertyName="Value" Type="String" />
                        <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenField_mcode" Name="Medicine_Code" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="HiddenFieldSample" Name="date_time" PropertyName="Value"
                            Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_Qty" runat="server" /><asp:HiddenField ID="HiddenField_Frequency_Sub_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_mcode" runat="server" />
              <asp:HiddenField ID="HiddenField_DAte" runat="server" />

                
                <asp:SqlDataSource ID="SqlDataSource_select_priscription" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    DeleteCommand="DELETE FROM [Patient_Priscription_Detail] WHERE [Yearly_NO] = @Yearly_NO AND [Med_Code] = @Med_Code"
                    InsertCommand="INSERT INTO [Patient_Priscription_Detail] ([Yearly_NO], [Med_Code], [Registration_NO], [Dosage], [Route_ID], [Dilution], [Duration], [Meal], [Frequency_ID], [date]) VALUES (@Yearly_NO, @Med_Code, @Registration_NO, @Dosage, @Route_ID, @Dilution, @Duration, @Meal, @Frequency_ID, @date)"
                    SelectCommand="medicine_select_report" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE [Patient_Priscription_Detail] SET [Registration_NO] = @Registration_NO, [Dosage] = @Dosage, [Route_ID] = @Route_ID, [Dilution] = @Dilution, [Duration] = @Duration, [Meal] = @Meal, [Frequency_ID] = @Frequency_ID, [date] = @date WHERE [Yearly_NO] = @Yearly_NO AND [Med_Code] = @Med_Code" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
                    <DeleteParameters>
                        <asp:Parameter Name="Yearly_NO" Type="Int32" />
                        <asp:Parameter Name="Med_Code" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Registration_NO" Type="String" />
                        <asp:Parameter Name="Dosage" Type="String" />
                        <asp:Parameter Name="Route_ID" Type="Int32" />
                        <asp:Parameter Name="Dilution" Type="String" />
                        <asp:Parameter Name="Duration" Type="String" />
                        <asp:Parameter Name="Meal" Type="String" />
                        <asp:Parameter Name="Frequency_ID" Type="Int32" />
                        <asp:Parameter Name="date" Type="DateTime" />
                        <asp:Parameter Name="Yearly_NO" Type="Int32" />
                        <asp:Parameter Name="Med_Code" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="Registration_NO" SessionField="registrationNo" Size="200"
                            Type="String" />
                        <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" Type="Decimal" />
                        <asp:SessionParameter Name="From_Sub_Dept_ID" SessionField="subdeptid" Type="Int32" />
                        <asp:SessionParameter Name="From_Dept_ID" SessionField="dept_id" Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Yearly_NO" Type="Int32" />
                        <asp:Parameter Name="Med_Code" Type="String" />
                        <asp:Parameter Name="Registration_NO" Type="String" />
                        <asp:Parameter Name="Dosage" Type="String" />
                        <asp:Parameter Name="Route_ID" Type="Int32" />
                        <asp:Parameter Name="Dilution" Type="String" />
                        <asp:Parameter Name="Duration" Type="String" />
                        <asp:Parameter Name="Meal" Type="String" />
                        <asp:Parameter Name="Frequency_ID" Type="Int32" />
                        <asp:Parameter Name="date" Type="DateTime" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldStatus" runat="server" />
                <asp:HiddenField ID="HiddenFieldSample" runat="server" />
              <asp:HiddenField ID="HiddenField_Yearly_No" runat="server" />
              <asp:HiddenField ID="HiddenField_Emp_Id" runat="server" />
              <asp:HiddenField ID="HiddenField_Registration_No" runat="server" />
              <asp:HiddenField ID="HiddenField_Route" runat="server" />

            <asp:Label ID="Label_Error" runat="server" ForeColor="Red"></asp:Label><br />
           
<asp:SqlDataSource ID="SqlDataSource_medicine_usage" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                SelectCommand="patient_Use_Medicine" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
  <SelectParameters>
      <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_day" runat="server" />
    
 
    <asp:HiddenField ID="HiddenField_startdate" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Medicine_Main" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="DELETE FROM Store_Indent_Book_Main WHERE (IB_ID = @IB_ID)&#13;&#10;"
        InsertCommand="Insert_Indent_Book_Main" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_YearlyCounter" Name="Yearly_Counter"
                PropertyName="Value" Type="Int32" />
            <asp:SessionParameter Name="From_Dept_ID" SessionField="Dept_id" Type="Int32" />
            <asp:SessionParameter Name="From_Sub_Dept_ID" SessionField="SubDeptID" Type="Int32" />
            <asp:Parameter DefaultValue="47" Name="To_Sub_Dept_ID" Type="Int32" />
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
            <asp:SessionParameter Name="ShiftID" SessionField="ShiftID" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Reg_no" Name="Reg_No" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="Yearly_No" PropertyName="Value"
                Type="Decimal" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Medicine_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
        DeleteCommand="Delete_Pharmacy_Requisition" DeleteCommandType="StoredProcedure"
        InsertCommand="Insert_Indent_Book_Sub" InsertCommandType="StoredProcedure" SelectCommand="Select_Store_Items_Order"
        SelectCommandType="StoredProcedure" UpdateCommand="medicine_order_Update" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Item_Code" PropertyName="Value"
                Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Med_Code" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Qty" Name="Med_Qty" PropertyName="Value" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Item_Code" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_RO_Qty" DefaultValue="" Name="Item_Qty"
                PropertyName="Value" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
   
     
    <asp:SqlDataSource ID="SqlDataSource_Store_Item_Consumption_Main" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" InsertCommand="[Insert_StoreITemConsumption_Main_Patient]" InsertCommandType="StoredProcedure" OnInserted="SqlDataSource_Store_Item_Consumption_Main_Inserted">
        <InsertParameters>
            <asp:SessionParameter Name="Consumed_By" SessionField="Emp_Id" Type="Int32" />
            <asp:SessionParameter Name="Dept_iD" SessionField="dept_id" Type="Int32" />
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" Type="Int32" />
            <asp:SessionParameter Name="Reg_No" SessionField="registrationno" Type="String" />
            <asp:SessionParameter Name="Shift_Id" SessionField="ShiftID" Type="Int32" />
            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Decimal" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Consumption_Id" Name="ConsumptionId"
                PropertyName="Value" Type="Decimal" />
            <asp:Parameter Direction="InputOutput" Name="Consumption_Id" Type="Decimal" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Consumption_Id" runat="server" />
    <asp:SqlDataSource ID="SDS_Gen_Requisition" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                InsertCommand="Auto_Requisition_By_Nurse" InsertCommandType="StoredProcedure"
                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:SessionParameter Name="Registration_NO" SessionField="RegistrationNo" />
                                    <asp:SessionParameter DefaultValue="" Name="Yearly_NO" SessionField="YearlyNo" />
                                    <asp:SessionParameter DefaultValue="" Name="Dept_id" SessionField="Dept_id" />
                                    <asp:SessionParameter Name="subdeptid" SessionField="Subdeptid" />
                                    <asp:SessionParameter Name="ShiftID" SessionField="Shiftid" />
                                    <asp:SessionParameter Name="Emp_id" SessionField="Emp_id" />
                                    <asp:Parameter Name ="Issue_Item" DbType ="String"/>
                                </InsertParameters>
                            </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Store_Item_Consumption_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" InsertCommand="[Insert_StoreITemConsumption_Sub_Patient]" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_mcode" Name="Item_Code" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Consumption_Id" Name="Consumption_Id"
                PropertyName="Value" Type="Decimal" />
            <asp:SessionParameter Name="Registration_NO" SessionField="registrationno" Type="String" />
            <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenField_Qty" Name="Qty" PropertyName="Value"
                Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
     
    <asp:SqlDataSource ID="SqlDataSource_UpdateStock" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" InsertCommand="[Update_Stock_For_Patient]" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:SessionParameter Name="From_Dept_ID" SessionField="dept_id" Type="Int32" />
            <asp:SessionParameter Name="From_Sub_Dept_ID" SessionField="subdeptid" Type="Int32" />
            <asp:SessionParameter Name="Reg_No" SessionField="registrationno" Type="String" />
            <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" Type="Decimal" />
            <asp:SessionParameter Name="Receive_Emp_Id" SessionField="emp_id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Submit" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="DELETE FROM Store_Indent_Book_Sub WHERE (IB_ID = @IB_ID) AND (Item_Code = @Med_Code)"
        InsertCommand="INSERT INTO Medicine_Request_Track(IB_ID, By_Emp_ID, By_Dept_ID, Date_Time, Request_Status) VALUES (@IB_ID, @By_Emp_ID, @By_Dept_ID, GETDATE(), 0)"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Med_Code" PropertyName="Value" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="By_Emp_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Dept_ID" Name="By_Dept_ID" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceApprove" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="medicine_order_approve" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" DefaultValue="" Name="IB_ID"
                PropertyName="Value" />
            <asp:Parameter DefaultValue="1" Name="Status" />
            <asp:SessionParameter DefaultValue="" Name="Emp_ID" SessionField="emp_id" />
            <asp:SessionParameter DefaultValue="" Name="By_Dept_ID" SessionField="dept_id" />
            <asp:ControlParameter ControlID="HiddenField_Dept_ID" Name="For_Dept_ID" PropertyName="Value"
                Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Med_Code" runat="server" />
    <asp:HiddenField ID="HiddenField_RO_Qty" runat="server" />
    <asp:HiddenField ID="HiddenField_enddate" runat="server" />
    <asp:HiddenField ID="HiddenField_counter" runat="server" />
    <asp:HiddenField ID="HiddenField_YearlyCounter" runat="server" />
    <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Reg_no" runat="server" />
    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
    <br />
   <div align="center"> <asp:Button ID="Button_Save" runat="server" OnClick="Button1_Click" Text="Save"  />   
                      
   <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Cancel" Visible="False"  /> 
       <asp:Button ID="Button_GenerateOrder" runat="server" OnClick="Button_GenerateOrder_Click"
           Text="Generate Order" />
       <asp:Button ID="Button_UpdateStock" runat="server" OnClick="Button_UpdateStock_Click"
           Text="Update Stock" />
   </div>
  <div align="right">
                                &nbsp;<asp:Button Visible="false" ID="Btn_Requisition" runat="server" 
                                    Text="Generate Requisition" onclick="Btn_Requisition_Click" />
                                <asp:Label ID="lbl_Req_MSG" runat="server" ForeColor="Red"></asp:Label><br />
                                </div>  
   
   <br />
   
   
            <asp:GridView ID="GridView2" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" DataSourceID="SqlDataSource_medicine_usage"

                PageSize="30" Width="100%"  EnableViewState="False">
              <Columns>
                <asp:BoundField DataField="Medicine" HeaderText="Medicine" ReadOnly="True" SortExpression="Medicine" />
                <asp:BoundField DataField="Route" HeaderText="Route" ReadOnly="True" SortExpression="Route" />
                <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" Visible="False" />
                  <asp:BoundField DataField="Date Specimen" HeaderText="Date Specimen" SortExpression="Date Specimen" />
                  <asp:BoundField DataField="Employee" HeaderText="Employee" SortExpression="Employee" />
                </Columns> <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />

              
                                    </asp:GridView><br />     
     <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
        <tr>
            <td  width="40%" align="right">
                <strong>Select Start Time :</strong></td>
            <td  >
                <igsch:WebDateChooser ID="WebDateChooser_StartDate" runat="server" OnValueChanged="WebDateChooser_StartDate_ValueChanged" CssClass="drop_date" Width="202px">
                    <AutoPostBack ValueChanged="True" />
                </igsch:WebDateChooser>
             
             
             
               <div style="position:absolute; margin-top:-27px; margin-left:210px;"> <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="report">Detail Report</asp:LinkButton></div>
               
               
               
            </td>
        </tr>
         <tr>
             <td align="center" colspan="2">
                 <asp:Button ID="btn_doctorview" runat="server" OnClick="btn_doctorview_Click" Text="physician Page" Visible="False" /></td>
         </tr>
    </table>
    <br/>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"> 

   
    <asp:GridView ID="GridView_PMUS" runat="server" AutoGenerateColumns="False" 
            Width="100%" SkinId="tbl_medication" 
            onprerender="GridView_PMUS_PreRender" >
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                  <table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" class="tbl_form"   >
                        <tr>
                            <td width="50%" height="100%"      >
                                <strong><asp:Label ID="Label_Medicine" runat="server" Text='<%# Eval("MGName") %>'></asp:Label></strong></td>
                            <td width="50%"  >
                                <asp:Label ID="Label_Frequency" runat="server" Text='<%# Eval("Frequency") %>'></asp:Label> </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="HF_MedCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                    <asp:HiddenField ID="HF_Prescription_id" runat="server" Value='<%# Eval("priscription_id") %>' />
                </ItemTemplate>
                <HeaderTemplate>
                     <table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" class="tbl_form"    >
                        <tr>
                            <td  width="50%" height="100%"  align="center"  >
                                <strong>Medicine</strong></td>
                            <td  width="50%" align="center" >
                                <strong>Frequency</strong></td>
                        </tr>
                    </table>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:DataList ID="DataList_Frequency" runat="server" DataSourceID="SqlDataSource_Freq_Det" Width="100%">
                        <ItemTemplate>
                             <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   >
                                <tr>
                                    <td width="50%" align="center"  style="border:0;"  >
                                        <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList><asp:SqlDataSource ID="SqlDataSource_Freq_Det" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="SELECT distinct     Medicine_Frequency_Detail.Frequency, PT_Prescription_Frequency_Detail.Dosage&#13;&#10;FROM         PT_Prescription_Frequency_Detail INNER JOIN&#13;&#10;                      Medicine_Frequency_Detail ON PT_Prescription_Frequency_Detail.Frequency_Sub_Id = Medicine_Frequency_Detail.Frequency_Sub_Id INNER JOIN&#13;&#10;                      Pt_Prescription_Detail ON PT_Prescription_Frequency_Detail.Prescription_Id = Pt_Prescription_Detail.priscription_id LEFT OUTER JOIN&#13;&#10;                      PrescriptedMedicineNotGivenDescritpion ON Pt_Prescription_Detail.priscription_id = PrescriptedMedicineNotGivenDescritpion.Prescription_ID AND &#13;&#10;                      Medicine_Frequency_Detail.Frequency_Sub_Id = PrescriptedMedicineNotGivenDescritpion.Frequency_Sub_Id AND &#13;&#10;                      Pt_Prescription_Detail.Med_Code = PrescriptedMedicineNotGivenDescritpion.MedCode LEFT OUTER JOIN&#13;&#10;                          (SELECT     Medicine_Code, Date_Time, Qty, Route_Id, Date_TimeSpecimen, ID, Frequency_Sub_ID&#13;&#10;                            FROM          Medicine_Usage_By_Patient&#13;&#10;                            WHERE      (CONVERT(varchar, Date_Time, 103) = CONVERT(varchar, CONVERT(datetime, @date), 103)) AND (Registration_No = @Registration_No) AND &#13;&#10;                                                   (Yearly_No = @Yearly_No) AND (Medicine_Code = @Medicine_Code)) AS Medicine_Usage ON &#13;&#10;                      Medicine_Usage.Medicine_Code = Pt_Prescription_Detail.Med_Code&#13;&#10;WHERE     (Pt_Prescription_Detail.Med_Code = @Medicine_Code) AND (PT_Prescription_Frequency_Detail.Prescription_Id = @Prescription_Id)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_Date1" Name="date" PropertyName="Value" />
                            <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                            <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   >
                        <tr>
                            <td width="50%" align="center" >
                                <strong>Prescribed Hr. of Admin.</strong></td>
                        </tr>
                    </table>
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
            <HeaderTemplate>
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   >
                    <tr>
                        <td colspan="2" align="center"  >
                  <strong>  <asp:Label ID="Label_HeaderDate1" runat="server"></asp:Label></strong></td>
                    </tr>
                    <tr>
                        <td  width="50%" align="center">
                            Time</td>
                        <td width="50%" align="center">
                            Initial</td>
                    </tr>
                </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:DataList ID="DataList_Day1" runat="server" DataSourceID="SqlDataSource_Day1" OnSelectedIndexChanged="DataList_Day1_SelectedIndexChanged" Width="100%" CssClass="bgcol_1"  >
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   >
                                <tr>
                                    <td width="50%"  style="border:0; border-right:#d5d2cd solid 1px;"   >
                                         <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="add_icon" style="font-size:9px; padding-right:2px;" ToolTip="Add Detail" CommandName="Select" Visible='<%# Eval("en_Dis") %>'>Reason</asp:LinkButton></td>
                                    <td  width="50%"   style="border:0;"   >
                                        
                                        <asp:Label ID="Label_initial" CssClass="inicolor" runat="server" Text='<%# Eval("initial") %>'></asp:Label>
                                        <asp:Label ID="DescriptionLabel"  CssClass="recolor" runat="server" Text='<%# Eval("Description") %>'></asp:Label></td>
                                </tr>
                            </table>
                            <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                            <asp:HiddenField ID="HF_MCode" runat="server" 
                                Value='<%# Eval("Medicine_Code") %>' />
                            <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                            
                        </ItemTemplate>
                    </asp:DataList><asp:SqlDataSource ID="SqlDataSource_Day1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="Select_Patient_Medicine_Usage_Summary_Sub" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_Date1" Name="date" PropertyName="Value" />
                            <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                            <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Date1" runat="server" Value='<%# Eval("date1") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
            <HeaderTemplate>
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   >
                    <tr>
                        <td colspan="2" align="center"  >
                  <strong>  <asp:Label ID="Label_HeaderDate2" runat="server"></asp:Label></strong></td>
                    </tr>
                    <tr>
                        <td  width="50%" align="center">
                            Time</td>
                        <td  width="50%" align="center">
                            Initial</td>
                    </tr>
                </table>
                </HeaderTemplate>
                <ItemTemplate><asp:DataList ID="DataList_Day2" runat="server" DataSourceID="SqlDataSource_Day2" Width="100%" OnSelectedIndexChanged="DataList_Day2_SelectedIndexChanged" CssClass="bgcol_2" >
                    <ItemTemplate>
                         <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   >
                            <tr>
                                <td width="50%"   style="border:0; border-right:#d5d2cd solid 1px;"  >
                                    <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="add_icon" style="font-size:9px; padding-right:2px;" ToolTip="Add Detail" CommandName="Select" Visible='<%# Eval("en_Dis") %>'>Reason</asp:LinkButton></td>
                                <td width="50%"   style="border:0;"   >
                                  
                                        <asp:Label ID="Label_initial" CssClass="inicolor" runat="server" Text='<%# Eval("initial") %>'></asp:Label>
                                    <asp:Label ID="DescriptionLabel" CssClass="recolor" runat="server" Text='<%# Eval("Description") %>'></asp:Label></td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                        <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                        <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                       
                    </ItemTemplate>
                </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource_Day2" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_Date2" Name="date" PropertyName="Value" />
                            <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                            <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Date2" runat="server" Value='<%# Eval("date2") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
            <HeaderTemplate>
               <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   >
                    <tr>
                        <td colspan="2" align="center"  >
                    <strong><asp:Label ID="Label_HeaderDate3" runat="server"></asp:Label></strong></td>
                    </tr>
                    <tr>
                        <td  width="50%" align="center">
                            Time</td>
                        <td width="50%" align="center">
                            Initial</td>
                    </tr>
                </table>
                </HeaderTemplate>
                <ItemTemplate>
                
                
                <asp:DataList ID="DataList_Day3" runat="server" Width="100%" DataSourceID="SqlDataSource_Day3" OnSelectedIndexChanged="DataList_Day3_SelectedIndexChanged" CssClass="bgcol_3">
                    <ItemTemplate>
                         <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"  >
                            <tr>
                                <td width="50%"  style="border:0; border-right:#d5d2cd solid 1px;"   >
                                 <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="add_icon" style="font-size:9px; padding-right:2px;" ToolTip="Add Detail" CommandName="Select" Visible='<%# Eval("en_Dis") %>'>Reason</asp:LinkButton></td>
                                <td width="50%" style="border:0;"   >
                                  
                                        <asp:Label ID="Label_initial" CssClass="inicolor" runat="server" Text='<%# Eval("initial") %>'></asp:Label>
                                    <asp:Label ID="DescriptionLabel"  CssClass="recolor" runat="server" Text='<%# Eval("Description") %>'></asp:Label></td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                        <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                        <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                   
                    </ItemTemplate>
                </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource_Day3" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_Date3" Name="date" PropertyName="Value" />
                            <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                            <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Date3" runat="server" Value='<%# Eval("date3") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
            <HeaderTemplate>
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   >
                    <tr>
                        <td colspan="2" align="center"  >
                    <strong><asp:Label ID="Label_HeaderDate4" runat="server"></asp:Label></strong></td>
                    </tr>
                    <tr>
                        <td  width="50%" align="center">
                            Time</td>
                        <td  width="50" align="center">
                            Initial</td>
                    </tr>
                </table>
                </HeaderTemplate>
                <ItemTemplate>
                
                <asp:DataList ID="DataList_Day4" runat="server" Width="100%" DataSourceID="SqlDataSource_Day4" OnSelectedIndexChanged="DataList_Day4_SelectedIndexChanged" CssClass="bgcol_4">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   >
                            <tr>
                                <td width="50%"  style="border:0; border-right:#d5d2cd solid 1px;"  >
                                    <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="add_icon" style="font-size:9px; padding-right:2px;" ToolTip="Add Detail" CommandName="Select" Visible='<%# Eval("en_Dis") %>'>Reason</asp:LinkButton></td>
                                <td width="50%"  style="border:0;"  >
                                   
                                        <asp:Label ID="Label_initial" CssClass="inicolor" runat="server" Text='<%# Eval("initial") %>'></asp:Label>
                                    <asp:Label ID="DescriptionLabel"  CssClass="recolor" runat="server" Text='<%# Eval("Description") %>'></asp:Label></td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                        <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                        <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                        
                    </ItemTemplate>
                </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource_Day4" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_Date4" Name="date" PropertyName="Value" />
                            <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                            <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Date4" runat="server" Value='<%# Eval("date4") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
            <HeaderTemplate>
               <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   >
                    <tr>
                        <td colspan="2"  align="center" >
                   <strong> <asp:Label ID="Label_HeaderDate5" runat="server"></asp:Label></strong></td>
                    </tr>
                    <tr>
                        <td  align="center" width="50%">
                            Time</td>
                        <td  align="center" width="50%">
                            Initial</td>
                    </tr>
                </table>
                </HeaderTemplate>
                <ItemTemplate>
                
                
                <asp:DataList ID="DataList_Day5" runat="server" Width="100%" DataSourceID="SqlDataSource_Day5" OnSelectedIndexChanged="DataList_Day5_SelectedIndexChanged" CssClass="bgcol_5">
                    <ItemTemplate>
                         <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                            <tr>
                                <td width="50%"  style="border:0; border-right:#d5d2cd solid 1px;"   >
                                  <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="add_icon" style="font-size:9px; padding-right:2px;" ToolTip="Add Detail" CommandName="Select" Visible='<%# Eval("en_Dis") %>'>Reason</asp:LinkButton></td>
                                <td width="50%"  style="border:0;"   >
                                   
                                        <asp:Label ID="Label_initial" CssClass="inicolor" runat="server" Text='<%# Eval("initial") %>'></asp:Label>
                                    <asp:Label ID="DescriptionLabel"  CssClass="recolor" runat="server" Text='<%# Eval("Description") %>'></asp:Label></td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                        <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                        <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                    
                    </ItemTemplate>
                </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource_Day5" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_Date5" Name="date" PropertyName="Value" />
                            <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                            <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Date5" runat="server" Value='<%# Eval("date5") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
            <HeaderTemplate>
               <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"  >
                    <tr>
                        <td colspan="2" align="center"  >
                    <strong><asp:Label ID="Label_HeaderDate6" runat="server"></asp:Label></strong></td>
                    </tr>
                    <tr>
                        <td  width="50%" align="center">
                            Time</td>
                        <td  width="50%" align="center">
                            Initial</td>
                    </tr>
                </table>
                </HeaderTemplate>
                <ItemTemplate>
                
                
                <asp:DataList ID="DataList_Day6" runat="server" Width="100%" DataSourceID="SqlDataSource_Day6" OnSelectedIndexChanged="DataList_Day6_SelectedIndexChanged" CssClass="bgcol_6">
                    <ItemTemplate>
                          <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                            <tr>
                                <td width="50%"  style="border:0; border-right:#d5d2cd solid 1px;"   >
                                    <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                    <asp:LinkButton ID="LinkButton1" runat="server"  CssClass="add_icon" style="font-size:9px; padding-right:2px;" ToolTip="Add Detail" CommandName="Select" Visible='<%# Eval("en_Dis") %>'>Reason</asp:LinkButton></td>
                                <td width="50%"  style="border:0;"   >
                                     
                                        <asp:Label ID="Label_initial" CssClass="inicolor" runat="server" Text='<%# Eval("initial") %>'></asp:Label>
                                    <asp:Label ID="DescriptionLabel"  CssClass="recolor" runat="server" Text='<%# Eval("Description") %>'></asp:Label></td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                        <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                        <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                      
                    </ItemTemplate>
                </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource_Day6" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_Date6" Name="date" PropertyName="Value" />
                            <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                            <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Date6" runat="server" Value='<%# Eval("date6") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"  >
                        <tr>
                            <td colspan="2"  align="center" >
                   <strong> <asp:Label ID="Label_HeaderDate7" runat="server"></asp:Label></strong></td>
                        </tr>
                        <tr>
                            <td  width="50%" align="center">
                                Time</td>
                            <td  align="center" width="50%">
                                Initial</td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                
                <asp:DataList ID="DataList_Day7" runat="server" Width="100%" DataSourceID="SqlDataSource_Day7" OnSelectedIndexChanged="DataList_Day7_SelectedIndexChanged" CssClass="bgcol_7">
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                            <tr>
                                <td width="50%"  style="border:0; border-right:#d5d2cd solid 1px;"   >
                                    <asp:Label ID="Date_TimeLabel" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="add_icon" style="font-size:9px; padding-right:2px;" ToolTip="Add Detail" CommandName="Select" Visible='<%# Eval("en_Dis") %>'>Reason</asp:LinkButton></td>
                                <td width="50%"  style="border:0;"   >
                                     
                                        <asp:Label ID="Label_initial" CssClass="inicolor" runat="server" Text='<%# Eval("initial") %>'></asp:Label>
                                    <asp:Label ID="DescriptionLabel"  CssClass="recolor" runat="server" Text='<%# Eval("Description") %>'></asp:Label></td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="HF_FrequencyID" runat="server" Value='<%# Eval("Frequency_Id") %>' />
                        <asp:HiddenField ID="HF_MCode" runat="server" Value='<%# Eval("Med_Code") %>' />
                        <asp:HiddenField ID="HF_Frequency_Sub_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                        
                    </ItemTemplate>
                </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource_Day7" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="[Select_Patient_Medicine_Usage_Summary_Sub]" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_Date7" Name="date" PropertyName="Value" />
                            <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                            <asp:ControlParameter ControlID="HF_MedCode" Name="Medicine_Code" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HF_Prescription_id" Name="Prescription_Id" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Date7" runat="server" Value='<%# Eval("date7") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns><RowStyle CssClass="GridItem" />
 
     
 
 
<AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    
    
    </td>
  </tr>
</table>
    <br />
    
    
    <asp:Panel ID="Panel_Description" runat="server" Visible="False" Width="100%" CssClass="lightbox_bg">
    <div  class="lightbox" style="height:100px;"  >
       
       
       <div class="bxmain"> 
       
       <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="40%" align="right">Select Reason :</td>
    <td><asp:DropDownList ID="DropDownList_Reason" runat="server" Width="300px">
        <asp:ListItem>Reason1</asp:ListItem>
        <asp:ListItem>Reason2</asp:ListItem>
    </asp:DropDownList></td>
  </tr>
</table>

       
       
        </div>
   
   <br />
        
       <div align="center" > <asp:Button ID="Button_Panel_Save" runat="server" OnClick="Button_Save_Click" Text="Save" /> <asp:Button ID="Button_cancel" runat="server" OnClick="Button_Cancel_Click" Text="Cancel" /></div><br />
    <asp:HiddenField ID="HiddenField_PrescriptionID_1" runat="server" />
    <asp:HiddenField ID="HiddenField_DoseUseDate_1" runat="server" />
    <asp:HiddenField ID="HiddenField_FrequencySubID_1" runat="server" />
    <asp:HiddenField ID="HiddenField_MedCode_1" runat="server" />
    <asp:HiddenField ID="HiddenField_En_Dis" runat="server" />
    </div>
    </asp:Panel>
    
    
    
    
    <asp:SqlDataSource ID="SqlDataSource_PMUS_1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="Select_Patient_Medicine_Usage_Summary" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="Registration_NO" SessionField="registrationNo" Type="String" />
            <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>
     
    <asp:SqlDataSource ID="SqlDataSource_PMUS" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="[Select_Patient_Medicine_Usage_Summary]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="Registration_NO" SessionField="registrationNo" Type="String" />
            <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>
</td>
</tr>
     <tr>
         <td class="leftnav" valign="top">
         </td>
         <td style="width: auto" valign="top">
         </td>
     </tr>
</table>  
<asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
 </asp:Content>