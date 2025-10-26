<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="DonorBloodGroup, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

            <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" Visible="false" runat="server" />                                <asp:ImageButton ID="ImageButtonback"  Visible="false"  ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" OnClick="ImageButtonback_Click" />                
                <asp:ImageButton ID="ImageButtonlogin" ImageUrl="images/image_logout_up.gif"  Visible="false"  Width="71" Height="30" runat="server" /> 
                    
                    
                    
                    
                <asp:SqlDataSource ID="SqlDataSource_patinet_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT [Prefix], isnull([PFName],'') [PFName], isnull([PMName],'') [PMName], isnull([PLName],'') [PLName], [Relation], [RFName], [Age], [AgeType] FROM [Patient] WHERE ([RegNo] = (SELECT isnull(Pt_RegNo,'') FROM Blood_Donor_Visit WHERE (Donor_RegNo = @RegNo)))" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                  <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_Donor_Registration_No" Name="RegNo" PropertyName="Value"
                        Type="String" />
                  </SelectParameters>
                </asp:SqlDataSource>
  <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource_patinet_Detail"
                Width="1100%" OnPreRender="FormView1_PreRender">
                  <EditItemTemplate>
                    Prefix:
                    <asp:TextBox ID="PrefixTextBox" runat="server" Text='<%# Bind("Prefix") %>'>
                    </asp:TextBox><br />
                    PFName:
                    <asp:TextBox ID="PFNameTextBox" runat="server" Text='<%# Bind("PFName") %>'>
                    </asp:TextBox><br />
                    PMName:
                    <asp:TextBox ID="PMNameTextBox" runat="server" Text='<%# Bind("PMName") %>'>
                    </asp:TextBox><br />
                    PLName:
                    <asp:TextBox ID="PLNameTextBox" runat="server" Text='<%# Bind("PLName") %>'>
                    </asp:TextBox><br />
                    Relation:
                    <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>'>
                    </asp:TextBox><br />
                    RFName:
                    <asp:TextBox ID="RFNameTextBox" runat="server" Text='<%# Bind("RFName") %>'>
                    </asp:TextBox><br />
                    Age:
                    <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>'>
                    </asp:TextBox><br />
                    AgeType:
                    <asp:TextBox ID="AgeTypeTextBox" runat="server" Text='<%# Bind("AgeType") %>'>
                    </asp:TextBox><br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                        Text="Update">
                    </asp:LinkButton>
                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="Cancel">
                    </asp:LinkButton>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                    Prefix:
                    <asp:TextBox ID="PrefixTextBox" runat="server" Text='<%# Bind("Prefix") %>'>
                    </asp:TextBox><br />
                    PFName:
                    <asp:TextBox ID="PFNameTextBox" runat="server" Text='<%# Bind("PFName") %>'>
                    </asp:TextBox><br />
                    PMName:
                    <asp:TextBox ID="PMNameTextBox" runat="server" Text='<%# Bind("PMName") %>'>
                    </asp:TextBox><br />
                    PLName:
                    <asp:TextBox ID="PLNameTextBox" runat="server" Text='<%# Bind("PLName") %>'>
                    </asp:TextBox><br />
                    Relation:
                    <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>'>
                    </asp:TextBox><br />
                    RFName:
                    <asp:TextBox ID="RFNameTextBox" runat="server" Text='<%# Bind("RFName") %>'>
                    </asp:TextBox><br />
                    Age:
                    <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>'>
                    </asp:TextBox><br />
                    AgeType:
                    <asp:TextBox ID="AgeTypeTextBox" runat="server" Text='<%# Bind("AgeType") %>'>
                    </asp:TextBox><br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                        Text="Insert">
                    </asp:LinkButton>
                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="Cancel">
                    </asp:LinkButton>
                  </InsertItemTemplate>
                  <ItemTemplate>
                    &nbsp;<asp:Label ID="PrefixLabel" runat="server" Font-Bold="True" Font-Names="Tahoma"
                        Font-Size="Smaller" Text='<%# Bind("Prefix") %>'></asp:Label><asp:Label ID="PFNameLabel"
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
                        Font-Size="Smaller" Text='<%# Bind("AgeType") %>'></asp:Label><br />
                  </ItemTemplate>
                </asp:FormView>
                
 
 
 
 <div class="bxmain">
  
          <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                <tr>
                    <td align="right"  width="40%" >
                        Group Name :</td>
                    <td >
                        <asp:DropDownList ID="DropDownList1" runat="server" Css DataSourceID="SqlDataSource_Group_Names"
                            DataTextField="Group_Name" DataValueField="Group_Name" Width="129px">
                        </asp:DropDownList>
                    </td>
            </tr>
                <tr>
                  <td align="right"  >
                  RH Factor :</td>
              <td >
                      <asp:RadioButtonList ID="RadioButtonList1" runat="server" Css
                            RepeatColumns="2" Width="96px">
                            <asp:ListItem>+</asp:ListItem>
                            <asp:ListItem>-</asp:ListItem>
                        </asp:RadioButtonList>                    </td>
</tr>
                <tr>
                  <td align="right"  >
                  Cross Match :</td>
      <td >
                      <asp:RadioButtonList ID="RadioButtonList2" runat="server" Css
                            RepeatColumns="2">
                            <asp:ListItem Value="true">Yes</asp:ListItem>
                            <asp:ListItem Value="false">No</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:SqlDataSource ID="SqlDataSource_Grouping_History" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"
                            SelectCommand="SELECT Donor_Blood_Group_Marked.Group_Name, Donor_Blood_Group_Marked.Rh_Factor, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS Employee, Donor_Blood_Group_Marked.Date_Time FROM Donor_Blood_Group_Marked INNER JOIN Employee ON Donor_Blood_Group_Marked.Emp_Id = Employee.EmpID WHERE (Donor_Blood_Group_Marked.Donor_Registration_No = @Reg_No) AND (Donor_Blood_Group_Marked.Donor_Visit_Id = @Donor_Visit_Id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenField_Donor_Registration_No" Name="Reg_No" PropertyName="Value" />
                                <asp:ControlParameter ControlID="HiddenField_Donor_Visit_No" Name="Donor_Visit_Id"
                                    PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>                    </td>
</tr>
                <tr>
                  <td align="right"  >&nbsp;</td>
                  <td ><asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Save" /></td>
                </tr>
    </table>
 </div>
<br>

 
            
            <br>

             <asp:GridView ID="GridView_Donor_Grouping_Hist" Width="100%" runat="server" DataSourceID="SqlDataSource_Grouping_History">
  </asp:GridView>
            
            <asp:SqlDataSource ID="SqlDataSource_Group_Names" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT [Group_Name] FROM [Blood_Group]" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource_Group" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                InsertCommand="[Donor_Group_Marked]" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>" InsertCommandType="StoredProcedure">
                <InsertParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="Group_Name" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="RadioButtonList1" Name="Rh_Factor" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="HiddenField_emp_Id" Name="Emp_Id" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenField_Donor_Registration_No" Name="Donor_Reg_No"
                        PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_Donor_Visit_No" Name="Donor_Visit_Id"
                        PropertyName="Value" Type="Int32" />
                    <asp:ControlParameter ControlID="RadioButtonList2" Name="CrossMatch" PropertyName="SelectedValue"
                        Type="Boolean" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField_Donor_Registration_No" runat="server" /><asp:HiddenField ID="HiddenField_emp_Id" runat="server" />
            <asp:HiddenField ID="HiddenField_Donor_Visit_No" runat="server" />
       <br>
<br>


 </asp:Content>