<%@ Page Language="VB" AutoEventWireup="false"  MasterPageFile="~/hacims_masterpage.master" CodeFile="Pt_Physician_Order.aspx.vb" Inherits="Pt_EMR_Pt_Physician_Order" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="../css_hacims/ck.js" type="text/javascript"></script>

  <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" class="leftnav"><asp:Label ID="LabelSideMenu" runat="server"></asp:Label><asp:Panel
        ID="Panel1" runat="server"  Visible="False">
    </asp:Panel></td>
    <td style="width:auto;" valign="top">
    
   <div class="bxmain"> 
       <asp:ScriptManager id="ScriptManager1" runat="server">
                <services>
                    <asp:ServiceReference Path="../autocomplete.asmx" />
             </services>
       </asp:ScriptManager>
       <cc1:autocompleteextender id="AutoComplete_Order" runat="server"
           completioninterval="10" completionsetcount="12" enablecaching="true" minimumprefixlength="3"
           servicemethod="GetPhysicianOrderComplete" servicepath="../AutoComplete.asmx" targetcontrolid="TextBox_New_Order">
              </cc1:autocompleteextender>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  
  <tr>
    <td align="right"><strong>New Order : &nbsp;</strong></td>
    <td><asp:TextBox CssClass="input_txt" ID="TextBox_New_Order" runat="server" Width="316px"></asp:TextBox>&nbsp;Repeat
        &nbsp;<asp:TextBox ID="TextBox_Repeat" runat="server" Width="16px">1</asp:TextBox>
        <asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1" /></td>
  </tr>
</table></div><br />
        
        
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="70%">
    
    
<h2 class="h1" style="width:98%;"><span>Physician Order</span></h2>   
                  <div style="width:100%; height:250px; overflow:auto; overflow-x:hidden;">                    
<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" Width="98%" DataSourceID="SqlDataSourceGridView">
                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />      
                    <RowStyle CssClass="GridItem"  />
                    <HeaderStyle CssClass="GridHeader" />      
                      <Columns>
                          <asp:BoundField DataField="Phy_Ord_Name" HeaderText="Physician Order Name" SortExpression="Phy_Ord_Name" />
                          <asp:BoundField DataField="Instruction" HeaderText="Instruction" SortExpression="Instruction" />
                          <asp:BoundField DataField="Start_Data_Time" HeaderText="Start Data Time" SortExpression="Start_Data_Time" />
                          <asp:BoundField DataField="For_Every" HeaderText="FulFill After Every" SortExpression="For_Every" />
                          <asp:BoundField DataField="Order By" HeaderText="Order By" SortExpression="Order By" />
                          <asp:BoundField DataField="End_Date_Time" HeaderText="End Date Time" SortExpression="End_Date_Time" />
                          <asp:BoundField DataField="Phy_Order_Category" HeaderText="Category" SortExpression="Phy_Order_Category" />
                      </Columns>
    </asp:GridView>
            </div> 
              </td>
    <td valign="top">  
    <h2 class="h1"><span>Order Performed</span></h2> 
    <div style="width:100%; height:250px; overflow:auto; overflow-x:hidden;">
    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSourceSave_Order" Width="100%">
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
       </div> 
        
         </td>
  </tr>
</table>
   
        


             
       
        
        
     <h2 class="h1"><span>Select Order</span></h2>   
     
     <div style="width:100%;">           <asp:GridView ID="GridView_Order" runat="server" AutoGenerateColumns="False" DataKeyNames="Phy_Ord_id"
                    DataSourceID="SqlDataSource_Component" PageSize="15" Width="100%">
                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                    <Columns>
                        <asp:BoundField DataField="Phy_Ord_id" HeaderText="Phy_Ord_id" InsertVisible="False"
                            ReadOnly="True" SortExpression="Phy_Ord_id" Visible="False" />
                        <asp:BoundField DataField="Phy_Ord_Name" HeaderText="Order" SortExpression="Phy_Ord_Name" />
                        <asp:BoundField DataField="Phy_Ord_Unit" HeaderText="Unit" SortExpression="Phy_Ord_Unit" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                Every
                                <asp:TextBox ID="TextBox_Period" runat="server" Visible="False" Width="34px">0</asp:TextBox>&nbsp;
                                <asp:DropDownList ID="DropDownList_period" runat="server" Visible="False" Width="52px">
                                    <asp:ListItem Value="1">Min</asp:ListItem>
                                    <asp:ListItem Value="60">Hr</asp:ListItem>
                                    <asp:ListItem Value="3600">Day</asp:ListItem>
                                </asp:DropDownList>
                                For
                                <asp:TextBox ID="TextBox_stop" runat="server" Visible="False" Width="34px"></asp:TextBox>&nbsp;
                                <asp:DropDownList ID="DropDownList_stop" runat="server" Width="52px">
                                    <asp:ListItem Value="1">Min</asp:ListItem>
                                    <asp:ListItem Value="60">Hr</asp:ListItem>
                                    <asp:ListItem Value="3600">Day</asp:ListItem>
                                </asp:DropDownList>
                                Instruction
                                <asp:TextBox ID="TextBox_Instr" runat="server" Width="150px"></asp:TextBox>
                                <asp:HiddenField ID="HiddenField_Order_id" runat="server" Value='<%# Eval("Phy_Ord_id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Select">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox_Select_Order" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <PagerStyle CssClass="GridPager" />
                </asp:GridView> </div>
                
                
                
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                    SelectCommand="SELECT_Phy_ORD_BY_Cat" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="dept_id" SessionField="dept_id" />
                        <asp:SessionParameter Name="subdept_id" SessionField="SubdeptId" />
                        <asp:Parameter DefaultValue="2" Name="Cat" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />

      <div align="center"> <asp:Button ID="Button1" runat="server" Text="Save" />  </div>

<asp:SqlDataSource ID="SqlDataSource_Component" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                            SelectCommand="SELECT Admin_Physician_Order.Phy_Ord_id, Admin_Physician_Order.Phy_Ord_Name, Admin_Physician_Order.Phy_Ord_Unit, Admin_Physician_Order_For_Department.dept_id, Admin_Physician_Order_For_Department.subdept_id FROM Admin_Physician_Order INNER JOIN Admin_Physician_Order_For_Department ON Admin_Physician_Order.Phy_Ord_id = Admin_Physician_Order_For_Department.Phy_Ord_id WHERE (Admin_Physician_Order_For_Department.dept_id = @dept_id) AND (Admin_Physician_Order_For_Department.subdept_id = @subdept_id)" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="dept_id" SessionField="dept_id" />
                        <asp:SessionParameter Name="subdept_id" SessionField="SubdeptId" />
      </SelectParameters>
    </asp:SqlDataSource>
        &nbsp;
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
                    
                    <asp:Label ID="Label_Error" runat="server" CssClass="err" ></asp:Label><br />

                  <br />

                  <asp:SqlDataSource ID="SqlDataSourceSave_Order" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
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
                          <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNO" Type="String" />
                          <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
                      </SelectParameters>
    </asp:SqlDataSource>
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
                          <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Decimal" />
                          <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNO" Type="String" />
                      </SelectParameters>
    </asp:SqlDataSource>
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
        <asp:SqlDataSource ID="SqlDataSource_Comp_Order" runat="server"></asp:SqlDataSource>


            </td>
  </tr>
</table>

 
<asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>
    
    
     </asp:Content>
 