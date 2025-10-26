<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="BloodGroup, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <asp:SqlDataSource ID="SqlDataSource_patinet_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT Prefix, PFName, PMName, PLName, Relation, RFName, Age, AgeType FROM Patient WHERE (RegNo = @RegNo)" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
              <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="RegNo" PropertyName="Value"
                        Type="String" />
              </SelectParameters>
  </asp:SqlDataSource>
              <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource_patinet_Detail" CssClass="Grid_1"
                Width="100%" OnPreRender="FormView1_PreRender">
                <EditItemTemplate> Prefix:
                  <asp:TextBox ID="PrefixTextBox" runat="server" Text='<%# Bind("Prefix") %>'> </asp:TextBox>
                  <br />
                  PFName:
                  <asp:TextBox ID="PFNameTextBox" runat="server" Text='<%# Bind("PFName") %>'> </asp:TextBox>
                  <br />
                  PMName:
                  <asp:TextBox ID="PMNameTextBox" runat="server" Text='<%# Bind("PMName") %>'> </asp:TextBox>
                  <br />
                  PLName:
                  <asp:TextBox ID="PLNameTextBox" runat="server" Text='<%# Bind("PLName") %>'> </asp:TextBox>
                  <br />
                  Relation:
                  <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>'> </asp:TextBox>
                  <br />
                  RFName:
                  <asp:TextBox ID="RFNameTextBox" runat="server" Text='<%# Bind("RFName") %>'> </asp:TextBox>
                  <br />
                  Age:
                  <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>'> </asp:TextBox>
                  <br />
                  AgeType:
                  <asp:TextBox ID="AgeTypeTextBox" runat="server" Text='<%# Bind("AgeType") %>'> </asp:TextBox>
                  <br />
                  <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                        Text="Update"> </asp:LinkButton>
                  <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="Cancel"> </asp:LinkButton>
                </EditItemTemplate>
                <InsertItemTemplate> Prefix:
                  <asp:TextBox ID="PrefixTextBox" runat="server" Text='<%# Bind("Prefix") %>'> </asp:TextBox>
                  <br />
                  PFName:
                  <asp:TextBox ID="PFNameTextBox" runat="server" Text='<%# Bind("PFName") %>'> </asp:TextBox>
                  <br />
                  PMName:
                  <asp:TextBox ID="PMNameTextBox" runat="server" Text='<%# Bind("PMName") %>'> </asp:TextBox>
                  <br />
                  PLName:
                  <asp:TextBox ID="PLNameTextBox" runat="server" Text='<%# Bind("PLName") %>'> </asp:TextBox>
                  <br />
                  Relation:
                  <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>'> </asp:TextBox>
                  <br />
                  RFName:
                  <asp:TextBox ID="RFNameTextBox" runat="server" Text='<%# Bind("RFName") %>'> </asp:TextBox>
                  <br />
                  Age:
                  <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>'> </asp:TextBox>
                  <br />
                  AgeType:
                  <asp:TextBox ID="AgeTypeTextBox" runat="server" Text='<%# Bind("AgeType") %>'> </asp:TextBox>
                  <br />
                  <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                        Text="Insert"> </asp:LinkButton>
                  <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="Cancel"> </asp:LinkButton>
                </InsertItemTemplate>
                <ItemTemplate>  
                    <asp:Label ID="PrefixLabel" runat="server" Font-Bold="True" Font-Names="Tahoma"
                        Font-Size="Smaller" Text='<%# Bind("Prefix") %>'></asp:Label>
                  <asp:Label ID="PFNameLabel"
                            runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="Smaller" Text='<%# Bind("PFName") %>'></asp:Label>
                    <asp:Label ID="PMNameLabel" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="Smaller"
                        Text='<%# Bind("PMName") %>'></asp:Label>
                    <asp:Label ID="PLNameLabel" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="Smaller"
                        Text='<%# Bind("PLName") %>'></asp:Label>
                    <asp:Label ID="RelationLabel" runat="server" Font-Bold="True" Font-Names="Tahoma"
                        Font-Size="Smaller" ForeColor="#0000C0" Text='<%# Bind("Relation") %>'></asp:Label>
                    <asp:Label ID="RFNameLabel" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="Smaller"
                        Text='<%# Bind("RFName") %>'></asp:Label>
                    <asp:Label ID="AgeLabel" runat="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="Smaller"
                        Text='<%# Bind("Age") %>'></asp:Label>
                    <asp:Label ID="AgeTypeLabel" runat="server" Font-Bold="True" Font-Names="Tahoma"
                        Font-Size="Smaller" Text='<%# Bind("AgeType") %>'></asp:Label>
                 
                </ItemTemplate>
              </asp:FormView> 
              <br>

                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="Grid_1" DataSourceID="SqlDataSource1" Width="100%">
                    
                    <Columns>
                        <asp:BoundField DataField="Component_Name" HeaderText="Component Name" SortExpression="Component_Name" />
                        <asp:BoundField DataField="Potency" HeaderText="PINTS" SortExpression="Potency" />
                    </Columns>
                  <RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

                </asp:GridView>
            <br>

              <asp:SqlDataSource ID="SqlDataSource_Group_Names" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT [Group_Name] FROM [Blood_Group]" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"></asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSource_Group" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                InsertCommand="BloodBank_Group_Marked" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                <InsertParameters>
                  <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="Registration_No"
                        PropertyName="Value" Type="String" />
                  <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value"
                        Type="Int32" />
                  <asp:ControlParameter ControlID="DropDownList1" Name="Group_Name" PropertyName="SelectedValue"
                        Type="String" />
                  <asp:ControlParameter ControlID="RadioButtonList1" Name="Rh_Factor" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:SessionParameter Name="Emp_Id" SessionField="Emp_Id" Type="Int32" />
                </InsertParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_Registration_No" runat="server" />
              <asp:HiddenField ID="HiddenField_Blood_Request_Id" runat="server" />
              <asp:HiddenField ID="HiddenField_Yearly_No" runat="server" />
 <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT Blood_Component.Component_Name, Blood_Component_Marked.Potency&#13;&#10;FROM         Blood_Component_Marked INNER JOIN&#13;&#10;                      Blood_Component ON Blood_Component_Marked.Component_id = Blood_Component.Component_id&#13;&#10;WHERE     (Blood_Component_Marked.Blood_Request_Id = @Blood_Request_Id)" >
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Blood_Request_Id"
                            PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
          <div class="bxmain">
          <table width="100%" border="0" cellpadding="0" cellspacing="0"  class="tbl_form">
           
               
              <tr>
                <td align="right" width="40%"  >Group Name : </td>
                        <td width="60%"> 
                          <asp:DropDownList ID="DropDownList1" runat="server"  DataSourceID="SqlDataSource_Group_Names"
                            DataTextField="Group_Name" DataValueField="Group_Name" Width="129px"> </asp:DropDownList>
                
                      
                  <asp:GridView ID="GridView_Grouping_Hist" runat="server" AutoGenerateColumns="False"
                          DataSourceID="SqlDatasource_Grouping_Hist">
                          <Columns>
                              <asp:BoundField DataField="Group_Name" HeaderText="ABO Group" SortExpression="Group_Name" />
                              <asp:BoundField DataField="Rh_Factor" HeaderText="Rh Factor" SortExpression="Rh_Factor" />
                              <asp:BoundField DataField="Employee" HeaderText="Employee" ReadOnly="True" SortExpression="Employee" />
                              <asp:BoundField DataField="Date_Time" HeaderText="Date Time" SortExpression="Date_Time" />
                          </Columns><RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

              </asp:GridView>
                      <asp:SqlDataSource ID="SqlDatasource_Grouping_Hist" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                          ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"
                          SelectCommand="SELECT Blood_Group_Marked.Group_Name, Blood_Group_Marked.Rh_Factor, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS Employee, Blood_Group_Marked.Date_Time FROM Blood_Group_Marked INNER JOIN Employee ON Blood_Group_Marked.Emp_Id = Employee.EmpID WHERE (Blood_Group_Marked.Registration_No = @Reg_No)">
                          <SelectParameters>
                              <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="Reg_No" PropertyName="Value" />
                          </SelectParameters>
                      </asp:SqlDataSource>
                </td>
            </tr>
              <tr>
                <td  align="right" valign="middle">RH Factor  :</td>
      <td > 
                          <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
                            RepeatColumns="2" Width="96px">
                            <asp:ListItem>+</asp:ListItem>
                            <asp:ListItem>-</asp:ListItem>
                          </asp:RadioButtonList>
                    </td>
            </tr>
              <tr>
                <td valign="top">&nbsp;</td>
          <td valign="middle"> 
                      <asp:Button ID="Button1" runat="server" OnClick="Button1_Click"  Text="Save"    />
                    </td>
            </tr>
              
              
              
              
              
              
              
              
              
              
  </table></div><br>

          
          
          

</asp:Content>