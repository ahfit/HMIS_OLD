<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_TestComponent, App_Web_42zygch0" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="bxmain">
 

<table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" >
      
                          <tr>
                            <td align="right" valign="middle"  >Group Name : </td>
                              <td valign="middle"  >
                                <asp:DropDownList AutoPostBack="True" 
                              DataTextField="TGName" DataValueField="TGID" ID="DropDownListGName" runat="server" Width="187px" DataSourceID="SqlDataSourceGName"> </asp:DropDownList>
</td>
                              <td colspan="2" align="right" valign="middle"  >Sub-Group Name : </td>
                              <td colspan="2" align="left" valign="middle"  >
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="TSGName" DataValueField="TSGID" ID="DropDownListSGName" runat="server" Width="185px" DataSourceID="SqlDataSourceSGName"> </asp:DropDownList>
</td>
                            </tr>
                          <tr>
                            <td align="right" valign="middle" >Test Name  :</td>
                              <td colspan="2" valign="middle" ><asp:DropDownList ID="DropDownListTest" runat="server"
                                      AutoPostBack="True"  DataSourceID="SqlDataSourceTest"
                                      DataTextField="TestName" DataValueField="TID" Width="187px">
                                  </asp:DropDownList>
</td>
                              <td align="right" valign="middle" >Control Field Type : </td>
                              <td colspan="2" valign="middle" >
                                  <asp:DropDownList ID="DropDownListType" runat="server" Width="185px" DataSourceID="SqlDataSourceType" DataTextField="DataTye" DataValueField="DataTye">                                  </asp:DropDownList></td>
                            </tr>
                          <tr>
                            <td align="right" valign="middle" >Component Name :</td>
                              <td colspan="2" valign="middle" ><asp:TextBox ID="TextBoxComponent" runat="server" CssClass="input_txt" Width="185px" ></asp:TextBox></td>
                              <td align="right" valign="middle" >Unit :</td>
                              <td colspan="2" valign="middle" ><asp:DropDownList AutoPostBack="True" 
                            DataTextField="TUnitName" DataValueField="TMUnitID" ID="DropDownListUnit" runat="server" Width="185px" DataSourceID="SqlDataSourceUnit">
                              </asp:DropDownList>                              </td>
                            </tr>
                          <tr>
                            <td height="6" align="right" >
                                Tool Tip :                            </td>
                              <td colspan="2" >
                                  <asp:TextBox ID="TextBoxToolTip" runat="server" Width="185px" CssClass="input_txt"></asp:TextBox></td>
                              <td align="right" >
                                  
                                  Refrence Values :</td>
                              <td colspan="2">
                                  <asp:TextBox ID="TextBox_Refrence_Values" runat="server" Width="183px" CssClass="input_txt"></asp:TextBox></td>
                          </tr>
    <tr>
        <td align="right" >
            Width :</td>
        <td colspan="2" >
            <asp:TextBox ID="TextBox_width" runat="server" CssClass="input_txt" MaxLength="3"
                Width="185px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_width"
                Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_width"
                Display="Dynamic" ErrorMessage="Invalid Width" ValidationExpression="\d*"></asp:RegularExpressionValidator></td>
        <td align="right" >
            Height :</td>
        <td colspan="2" >
            <asp:TextBox ID="TextBox_Height" runat="server" CssClass="input_txt" MaxLength="3"
                Width="185px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_Height"
                Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox_Height"
                Display="Dynamic" ErrorMessage="Invalid Height" ValidationExpression="\d*"></asp:RegularExpressionValidator></td>
    </tr>
                            <tr>
                                <td height="6" colspan="6" align="center" >                                                                                                
                                <asp:Button CssClass="btn1" ID="SAVE" runat="server" Text="Save" />                                                                </td>
                            </tr> 
                        </table></div>
<br />
<asp:SqlDataSource ID="SqlDataSourceGNameSave" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        InsertCommand="INSERT INTO TestComponent(TID, ComponentName, TMUnitID, TGID) VALUES (@TID, @ComponentName, @TMUnitID, @TGID)"
                        ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="DropDownListTest" Name="TID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="TextBoxComponent" Name="ComponentName" PropertyName="Text" />
                                <asp:ControlParameter ControlID="DropDownListUnit" Name="TMUnitID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceUnit" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                                  SelectCommand="SELECT [TMUnitID], [TUnitName] FROM [TestMUnit]" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>"></asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="SELECT DataTye FROM Admin_ASP_Controls">
                            </asp:SqlDataSource>
                              <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                                      ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT TestName, TID FROM Test WHERE (TSGID = @tsgid)">
                                      <SelectParameters>
                                          <asp:ControlParameter ControlID="DropDownListSGName" Name="tsgid" PropertyName="SelectedValue" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceSGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT [TSGID], [TSGName] FROM [TestSubGroup] WHERE ([TGID] = @TGID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>"></asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenFieldGroupName" runat="server" />

<br />
                          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TCID"
                    DataSourceID="SqlDataSourceGrid" CssClass="Grid_1" Width="100%">
<RowStyle CssClass="GridItem"></RowStyle>
<Columns>
<asp:BoundField DataField="TGName" HeaderText="Group Name" ReadOnly="True" SortExpression="TGName" Visible="False"></asp:BoundField>
<asp:BoundField DataField="TSGName" HeaderText="Sub Group Name" ReadOnly="True" SortExpression="TSGName" Visible="False"></asp:BoundField>
<asp:BoundField DataField="TestName" HeaderText="Test Name" ReadOnly="True" SortExpression="TestName"></asp:BoundField>
<asp:BoundField DataField="ComponentName" HeaderText="Component Name" SortExpression="ComponentName">
<ControlStyle Width="75px"></ControlStyle>
</asp:BoundField>
<asp:TemplateField HeaderText="Field Type" SortExpression="e_Field_Type"><EditItemTemplate>
                                        <asp:DropDownList ID="DropDownListType" runat="server" DataSourceID="SqlDataSourceType1"
                                            DataTextField="DataTye" DataValueField="DataTye"
                                            Width="75px">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSourceType1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                                ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT [DataTye] FROM [Admin_ASP_Controls]">
                                        </asp:SqlDataSource>
                                    
</EditItemTemplate>
<ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("e_Field_Type") %>'></asp:Label>
                                    
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Refrence Values" SortExpression="TC_Range_Unit"><EditItemTemplate>
                                        <asp:TextBox ID="TextBox_R_Values" runat="server" Width="75px" Text='<%# Bind("TC_Range_Unit") %>'></asp:TextBox>
                                    
</EditItemTemplate>
<ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("TC_Range_Unit") %>'></asp:Label>
                                    
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Unit" SortExpression="TMUnitID"><EditItemTemplate>
                                        <asp:DropDownList ID="DropDownListUnit" runat="server" DataSourceID="SqlDataSourceUnit1"
                                            DataTextField="TUnitName" DataValueField="TMUnitID" Width="75px" SelectedValue='<%# Bind("TMUnitID") %>'>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSourceUnit1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                                  SelectCommand="SELECT [TMUnitID], [TUnitName] FROM [TestMUnit]" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>">
                                        </asp:SqlDataSource>
                                    
</EditItemTemplate>
<ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("TUnitName") %>'></asp:Label>
                                    
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="TCID" HeaderText="TCID" ReadOnly="True" InsertVisible="False" SortExpression="TCID" Visible="False"></asp:BoundField>
<asp:BoundField DataField="TMUnitID" HeaderText="TMUnitID" SortExpression="TMUnitID" Visible="False"></asp:BoundField>
<asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority">
<ControlStyle Width="50px"></ControlStyle>
</asp:BoundField>
<asp:BoundField DataField="Min_Value" HeaderText="Min_Value" SortExpression="Min_Value">
<ControlStyle Width="75px"></ControlStyle>
</asp:BoundField>
<asp:BoundField DataField="Max_Value" HeaderText="Max_Value" SortExpression="Max_Value">
<ControlStyle Width="75px"></ControlStyle>
</asp:BoundField>
<asp:BoundField DataField="Critical_Values" HeaderText="Critical_Values" SortExpression="Critical_Values">
<ControlStyle Width="100px"></ControlStyle>
</asp:BoundField>
    <asp:BoundField DataField="Height" HeaderText="Height" SortExpression="Height" />
    <asp:BoundField DataField="width" HeaderText="Width" SortExpression="width" />
<asp:TemplateField><EditItemTemplate>
    <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" CommandName="Update"
        ImageUrl="~/images_hacims/icon_ok.gif" /><asp:ImageButton ID="ImageButton4" runat="server"
            CausesValidation="False" CommandName="Cancel" ImageUrl="~/images_hacims/icon_err.gif" />
                                    
</EditItemTemplate>
<ItemTemplate>
    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Edit"
        ImageUrl="~/images_hacims/icon_edit.gif" OnClientClick="return confirmation_edit(this)" /><asp:ImageButton
            ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Delete"
            ImageUrl="~/images_hacims/icon_delete.gif" OnClientClick="return confirmation(this)" />
                                    
</ItemTemplate>
</asp:TemplateField>
</Columns>

<HeaderStyle CssClass="GridHeader"></HeaderStyle>

<AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
</asp:GridView>
                            <asp:HiddenField ID="HiddenFieldCompName" runat="server" />
                            <asp:HiddenField ID="HiddenFieldUnit" runat="server" />
                          <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                    SelectCommand="SELECT TestGroup.TGName, TestSubGroup.TSGName, Test.TestName, TestComponent.ComponentName, TestComponent.TCID, TestMUnit.TUnitName, TestComponent.e_Field_Type, TestMUnit.TMUnitID, TestComponent.TC_Range_Unit, TestComponent.Priority, TestComponent.MaxLength, TestComponent.Min_Value, TestComponent.Max_Value, TestComponent.Critical_Values, TestComponent.Height, TestComponent.width FROM Test INNER JOIN TestSubGroup ON Test.TSGID = TestSubGroup.TSGID INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID INNER JOIN TestComponent ON Test.TID = TestComponent.TID INNER JOIN TestMUnit ON TestComponent.TMUnitID = TestMUnit.TMUnitID WHERE (Test.TGID = @TGID) AND (Test.TSGID = @TSGID) AND (TestComponent.TID = @TID)" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" DeleteCommand="DELETE FROM TestComponent WHERE (TCID = @tcid)" UpdateCommand="UPDATE TestComponent SET ComponentName = @ComponentName, TMUnitID = @TMUnitID, e_Field_Type = @e_Field_Type, TC_Range_Unit = @TC_Range_Unit, Priority = @Priority, MaxLength = @MaxLength, Min_Value = @Min_Value, Max_Value = @Max_Value, Critical_Values = @Critical_Values, Height = @Height, width = @width WHERE (TCID = @TCID)">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListSGName" Name="TSGID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownListTest" Name="TID" PropertyName="SelectedValue" />
                            </SelectParameters>
                              <DeleteParameters>
                                  <asp:ControlParameter ControlID="GridView1" Name="tcid" PropertyName="SelectedValue" />
                              </DeleteParameters>
                              <UpdateParameters>
                                  <asp:ControlParameter ControlID="HiddenFieldCompName" Name="ComponentName" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HiddenFieldUnit" Name="TMUnitID" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="GridView1" Name="TCID" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="HiddenFieldType" Name="e_Field_Type" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HiddenField_R_Values" Name="TC_Range_Unit" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="GridView1" Name="Priority" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="GridView1" Name="MaxLength" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="GridView1" Name="Min_Value" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="GridView1" Name="Max_Value" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="GridView1" Name="Critical_Values" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="GridView1" Name="Height" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="GridView1" Name="width" PropertyName="SelectedValue" />
                              </UpdateParameters>
                          </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldType" runat="server" />
                            <asp:HiddenField ID="HiddenField_R_Values" runat="server" />
<br />
  </asp:Content>