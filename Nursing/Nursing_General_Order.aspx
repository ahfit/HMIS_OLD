<%@ Page Language="VB" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage.master" CodeFile="Nursing_General_Order.aspx.vb" Inherits="Nursing_General_Order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<script src="../css_hacims/ck.js" type="text/javascript"></script>
<script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>



</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

                                         
       <table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>

</td>
<td  style="width:auto;" valign="top" >
     
     


<asp:SqlDataSource ID="SqlDataSource_Component" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                            SelectCommand="SELECT Admin_Physician_Order.Phy_Ord_id, Admin_Physician_Order.Phy_Ord_Name, Admin_Physician_Order.Phy_Ord_Unit, Admin_Physician_Order_For_Department.dept_id, Admin_Physician_Order_For_Department.subdept_id FROM Admin_Physician_Order INNER JOIN Admin_Physician_Order_For_Department ON Admin_Physician_Order.Phy_Ord_id = Admin_Physician_Order_For_Department.Phy_Ord_id WHERE (Admin_Physician_Order_For_Department.dept_id = @dept_id) AND (Admin_Physician_Order_For_Department.subdept_id = @subdept_id)" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="dept_id" SessionField="dept_id" />
                        <asp:SessionParameter Name="subdept_id" SessionField="SubdeptId" />
      </SelectParameters>
    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceSave_New_Order" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                        InsertCommand="insert_Physician_Order_From_Doctor" InsertCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="TextBox_New_Order" Name="Phy_Ord_Name" PropertyName="Text"
                                Type="String" />
                            <asp:SessionParameter Name="dept_id" SessionField="Dept_ID" Type="Int32" />
                            <asp:SessionParameter Name="subdept_id" SessionField="SubDeptID" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    
                    <asp:Label ID="Label_Error" runat="server" CssClass="err" ></asp:Label>

                  <asp:GridView ID="GridView_Order" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" Width="100%" DataSourceID="SqlDataSourceGridView">
                   
                      <Columns>
                          <asp:BoundField DataField="Phy_Ord_Name" HeaderText="Physician Order Name" SortExpression="Phy_Ord_Name" />
                          <asp:BoundField DataField="Start_Data_Time" HeaderText="Start Data Time" SortExpression="Start_Data_Time" />
                          <asp:BoundField DataField="For_Every" HeaderText="FulFill After Every" SortExpression="For_Every" />
                          <asp:BoundField DataField="End_Date_Time" HeaderText="End Date Time" SortExpression="End_Date_Time" />
                          <asp:BoundField DataField="Order By" HeaderText="Order By" SortExpression="Order By" />
                          <asp:BoundField DataField="Instruction" HeaderText="Instruction" SortExpression="Instruction" />
                          <asp:TemplateField>
                              <ItemTemplate>
                                  &nbsp;
                                  <table>
                                      <tr>
                                          <td style="width: 100px">
                                              Order :</td>
                                          <td style="width: 100px">
                                              <asp:CheckBox ID="CheckBox_Order" runat="server" /></td>
                                      </tr>
                                      <tr>
                                          <td style="width: 100px">
                                              Status :</td>
                                          <td style="width: 100px">
                                  <asp:RadioButtonList ID="RadioButtonList_Ord_Imp" runat="server" RepeatDirection="Horizontal">
                                      <asp:ListItem Selected="True">Complete</asp:ListItem>
                                      <asp:ListItem>Continue</asp:ListItem>
                                  </asp:RadioButtonList></td>
                                      </tr>
                                      <tr>
                                          <td style="width: 100px">
                                              Remarks :</td>
                                          <td style="width: 100px">
                                  <asp:TextBox ID="TextBox_Remarks" runat="server" TextMode="MultiLine"></asp:TextBox></td>
                                      </tr>
                                  </table>
                                  &nbsp;
                                  <br />
                                  <asp:HiddenField ID="HiddenField_Order_id" runat="server" Value='<%# Eval("Phy_Ord_id") %>' />
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns><RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView> &nbsp;&nbsp;
    <asp:Button ID="Button_Save" runat="server" Text="Save" />
                  <asp:SqlDataSource ID="SqlDataSourceGridView" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                DeleteCommand="DELETE FROM [Patient_Vital_Marked] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Patient_Vital_Marked] ([Vital_Id], [Period], [When_Stop]) VALUES (@Vital_Id, @Period, @When_Stop)"
                UpdateCommand="UPDATE [Patient_Vital_Marked] SET [Vital_Id] = @Vital_Id, [Period] = @Period, [When_Stop] = @When_Stop WHERE [Id] = @Id" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="Select_Patient_Physician_Order" SelectCommandType="StoredProcedure">
                    <DeleteParameters>
                      <asp:Parameter Name="Id" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                      <asp:Parameter Name="Vital_Id" Type="Int32" />
                      <asp:Parameter Name="Period" Type="String" />
                      <asp:Parameter Name="When_Stop" Type="String" />
                      <asp:Parameter Name="Id" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                      <asp:ControlParameter ControlID="HiddenField_vital_id" Name="Vital_Id" PropertyName="Value"
                        Type="Int32" />
                      <asp:ControlParameter ControlID="HiddenField_vital_Period" Name="Period" PropertyName="Value"
                        Type="String" />
                      <asp:ControlParameter ControlID="HiddenField_vital_when_Stope" Name="When_Stop" PropertyName="Value"
                        Type="String" />
                    </InsertParameters>
                      <SelectParameters>
                          <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                          <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" Type="String" />
                      </SelectParameters>
    </asp:SqlDataSource>
    <h2 class="h1"><span>Order Performed</span></h2> 
    <div style="width:100%; height:250px; overflow:auto; overflow-x:hidden;">
    <asp:DataList ID="DataList_Ord_Per" runat="server" DataSourceID="SqlDataSourceSave_Order" Width="100%">
            <ItemTemplate>
            
        <div class="bx_pathology" style="padding:5px; width:96%;">    
            
     <ul style="border-bottom:#666666 dotted 1px; padding-bottom:4px; padding-top:4px; line-height:16px;">   <li>        <strong><asp:Label ID="Label_Name" ToolTip="Order Name" runat="server" Text='<%# Eval("Phy_Ord_Name") %>'></asp:Label></strong> </li>

   <li style="font-size:10px;">             <asp:Label ID="Label_Category" ToolTip="Order Category" runat="server" Text='<%# Eval("Phy_Order_Category") %>'></asp:Label> &nbsp;&nbsp;|&nbsp;&nbsp; 

<asp:Label  ID="Label_Status" ToolTip="Order Status" runat="server" Text='<%# Eval("Imp_Status") %>'></asp:Label></li>
<li  style="font-size:10px;"><asp:Label  ID="Label_Remarks" ToolTip="Order Remarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label></li>
              <li  style="font-size:10px; text-align:right;">  <asp:Label ID="Label_Emp" ToolTip="Employee Name" style="color:#000; font-weight:bold;" runat="server" Text='<%# Eval("[Peformed by]") %>'></asp:Label>&nbsp;&nbsp;|&nbsp;&nbsp; <asp:Label ID="Label_Datetime" ToolTip="Order Date" runat="server" Text='<%# Eval("imp_datetime") %>'></asp:Label></li></ul>
                                    
          </div>                          
                                    
                                    
            </ItemTemplate>
        </asp:DataList>
       </div>  <br />
    &nbsp; &nbsp; &nbsp;<br />
    &nbsp;<asp:SqlDataSource ID="SqlDataSourceSave_Order" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        InsertCommand="Insert_Patient_Physician_Order" InsertCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="Select_Pt_Phy_order_Imp" SelectCommandType="StoredProcedure">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HiddenField_vital_id" Name="Phy_Ord_id" PropertyName="Value"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenField_vital_Period" Name="Period" PropertyName="Value"
                                Type="String" />
                            <asp:SessionParameter Name="Registration_No" SessionField="registrationNo" Type="String" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
                            <asp:SessionParameter Name="Emp_Id" SessionField="emp_id" Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenField_vital_when_Stope" Name="End_Date_Time"
                                PropertyName="Value" Type="DateTime" />
                            <asp:ControlParameter ControlID="HiddenFieldForEvery" Name="For_Every" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="HiddenFieldEnd" Name="End_Time" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="HiddenFieldDescription" Name="Instruction" PropertyName="Value"
                                Type="String" />
                        </InsertParameters>
                      <SelectParameters>
                          <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" Type="String" />
                          <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
                      </SelectParameters>
    </asp:SqlDataSource>
    <br />
                  <asp:HiddenField ID="HiddenField_Registration_No" runat="server" />
                  <asp:HiddenField ID="HiddenField_Yearly_No" runat="server" />
                  <asp:HiddenField ID="HiddenField_Emp_Id" runat="server" />
                  <asp:HiddenField ID="HiddenField_Dept_Id" runat="server" />
                  <asp:HiddenField ID="HiddenField_vital_Period" runat="server" />
                  <asp:HiddenField ID="HiddenField_vital_id" runat="server" />
                  <asp:HiddenField ID="HiddenField_vital_when_Stope" runat="server" />
                    <asp:HiddenField ID="HiddenFieldDescription" runat="server" />
                    <asp:HiddenField ID="HiddenFieldForEvery" runat="server" />
                    <asp:HiddenField ID="HiddenFieldEnd" runat="server" />

 <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" /><asp:BoundField DataField="Period" HeaderText="Period" SortExpression="Period" /><asp:BoundField DataField="When_Stop" HeaderText="When_Stop" SortExpression="When_Stop" /><asp:BoundField DataField="Registration_No" HeaderText="Registration_No" SortExpression="Registration_No"
                        Visible="False" /><RowStyle CssClass="GridItem" Height="8px" /><HeaderStyle CssClass="GridHeader" /><asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />   <br />
<br />

     
</td>
</tr>
</table>            
<asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
  </asp:Content>