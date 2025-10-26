<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_TestComponent, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<div class="bxmain">
<table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" >
    
                          <tr>
                            <td width="25%" align="right" >Group Name : </td>
                              <td width="25%">
                                <asp:DropDownList AutoPostBack="True" 
                              DataTextField="TGName" DataValueField="TGID" ID="DropDownListGName" runat="server" DataSourceID="SqlDataSourceGName"> </asp:DropDownList>
</td>
                              <td align="right"  >Sub-Group Name : </td>
                              <td width="25%" align="left" >
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="TSGName" DataValueField="TSGID" ID="DropDownListSGName" runat="server" DataSourceID="SqlDataSourceSGName"> </asp:DropDownList>
</td>
                            </tr>
                          <tr>
                            <td align="right" >Test Name  :</td>
                              <td  ><asp:DropDownList ID="DropDownListTest" runat="server"
                                      AutoPostBack="True"  DataSourceID="SqlDataSourceTest"
                                      DataTextField="TestName" DataValueField="TID" >
                                  </asp:DropDownList>
</td>
                              <td align="right"  >Control Field Type : </td>
                              <td  >
                                  <asp:DropDownList ID="DropDownListType" runat="server"  DataSourceID="SqlDataSourceType" DataTextField="DataTye" DataValueField="DataTye">                                  </asp:DropDownList></td>
                            </tr>
                          <tr>
                            <td align="right" >Component Name :</td>
                              <td ><asp:TextBox ID="TextBoxComponent" runat="server" CssClass="input_txt"  ></asp:TextBox></td>
                              <td align="right"  >Unit :</td>
                              <td  ><asp:DropDownList AutoPostBack="True" 
                            DataTextField="TUnitName" DataValueField="TMUnitID" ID="DropDownListUnit" runat="server" DataSourceID="SqlDataSourceUnit">
                              </asp:DropDownList>                              </td>
                            </tr>
                          <tr>
                            <td align="right" >
                                Tool Tip :                            </td>
                              <td  >
                                  <asp:TextBox ID="TextBoxToolTip" runat="server"  CssClass="input_txt"></asp:TextBox></td>
                              <td align="right"  >
                                  Reference Value for Report (Male) :</td>
                              <td >
                                  <asp:TextBox ID="TextBox_Refrence_Values" runat="server"  CssClass="input_txt" ></asp:TextBox></td>
                          </tr>
    <tr>
        <td align="right" >
            Reference Value for Report (Female) :</td>
        <td >
            <asp:TextBox ID="TextBox_RefVal_Female" runat="server" CssClass="input_txt"  ></asp:TextBox></td>
        <td align="right" >
        </td>
        <td >
            <asp:TextBox ID="TextBox_NewUnits" runat="server" CssClass="input_txt" ></asp:TextBox>
            <asp:Button  ID="Button_NewUnits" runat="server" Text="New Units"  /></td>
    </tr>
                           
                        </table></div>
                        
<br /><div align="center"><asp:Button  ID="SAVE" runat="server" Text="Save" Width="120px" />&nbsp;<asp:Button ID="btn_export" runat="server" Text="Export" />
            </div><br />
     
<asp:SqlDataSource ID="SqlDataSourceGNameSave" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                        InsertCommand="INSERT INTO TestComponent(TID, ComponentName, TMUnitID, TGID) VALUES (@TID, @ComponentName, @TMUnitID, @TGID)"
                        ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="DropDownListTest" Name="TID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="TextBoxComponent" Name="ComponentName" PropertyName="Text" />
                                <asp:ControlParameter ControlID="DropDownListUnit" Name="TMUnitID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceUnit" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                                  SelectCommand="SELECT [TMUnitID], [TUnitName] FROM [TestMUnit] order by [TUnitName]  asc" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" InsertCommand="INSERT INTO TestMUnit(TUnitName) VALUES (@TUnitName)">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBox_NewUnits" Name="TUnitName" PropertyName="Text" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="SELECT DataTye FROM Admin_ASP_Controls">
                            </asp:SqlDataSource>
                              <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                                      ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT TestName, TID FROM Test WHERE (TSGID = @tsgid)">
                                      <SelectParameters>
                                          <asp:ControlParameter ControlID="DropDownListSGName" Name="tsgid" PropertyName="SelectedValue" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceSGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                        ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT [TSGID], [TSGName] FROM [TestSubGroup] WHERE ([TGID] = @TGID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                        SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>"></asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenFieldGroupName" runat="server" />

                          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TCID" Width="100%"
                    DataSourceID="SqlDataSourceGrid" PageSize="200"><Columns>
<asp:BoundField DataField="TGName" HeaderText="Group Name" ReadOnly="True" SortExpression="TGName">
<ControlStyle Width="100px"></ControlStyle>

<ItemStyle Width="100px"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="TSGName" HeaderText="Sub Group Name" ReadOnly="True" SortExpression="TSGName">
<ControlStyle Width="100px"></ControlStyle>
</asp:BoundField>
                                  <asp:BoundField DataField="TID" HeaderText="TID" InsertVisible="False" 
                                      SortExpression="TID" />
<asp:BoundField DataField="TestName" HeaderText="Test Name" ReadOnly="True" SortExpression="TestName">
<ControlStyle Width="100px"></ControlStyle>
</asp:BoundField>
<asp:BoundField DataField="TCID" HeaderText="TCID" ReadOnly="True" InsertVisible="False" SortExpression="TCID">
<ControlStyle Height="50px"></ControlStyle>
</asp:BoundField>
<asp:BoundField DataField="ComponentName" HeaderText="Component Name" SortExpression="ComponentName">
<ControlStyle Width="100px"></ControlStyle>
</asp:BoundField>
<asp:TemplateField HeaderText="Field Type" SortExpression="e_Field_Type"><EditItemTemplate>
                                        <asp:DropDownList ID="DropDownListType" runat="server" DataSourceID="SqlDataSourceType1"
                                            DataTextField="DataTye" DataValueField="DataTye"
                                            Width="144px" SelectedValue='<%# Bind("e_Field_Type") %>'>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSourceType1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                                ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT [DataTye] FROM [Admin_ASP_Controls]">
                                        </asp:SqlDataSource>
                                    
</EditItemTemplate>
<ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("e_Field_Type") %>'></asp:Label>
                                    
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Refrence Values Male" SortExpression="TC_Range_Unit"><EditItemTemplate>
                                        <asp:TextBox ID="TextBox_R_Values" runat="server" Width="160px" Text='<%# Bind("TC_Range_Unit") %>' TextMode="MultiLine"></asp:TextBox>
                                    
</EditItemTemplate>
<ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("TC_Range_Unit") %>'></asp:Label>
                                    
</ItemTemplate>

<ControlStyle Width="50px"></ControlStyle>
</asp:TemplateField>
                        <asp:TemplateField HeaderText="Refrence Value Female" SortExpression="TC_Range_Unit_Female">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TC_Range_Unit_Female") %>'
                                    TextMode="MultiLine"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("TC_Range_Unit_Female") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
<asp:TemplateField HeaderText="Unit" SortExpression="TMUnitID"><EditItemTemplate>
                                        <asp:DropDownList ID="DropDownListUnit" runat="server" DataSourceID="SqlDataSourceUnit1"
                                            DataTextField="TUnitName" DataValueField="TMUnitID" Width="176px" SelectedValue='<%# Bind("TMUnitID") %>'>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSourceUnit1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                                  SelectCommand="SELECT [TMUnitID], [TUnitName] FROM [TestMUnit]" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>">
                                        </asp:SqlDataSource>
                                    
</EditItemTemplate>
<ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("TUnitName") %>'></asp:Label>
                                    
</ItemTemplate>

<ControlStyle Width="50px"></ControlStyle>
</asp:TemplateField>
<asp:BoundField DataField="TMUnitID" HeaderText="TMUnitID" SortExpression="TMUnitID" Visible="False"></asp:BoundField>
<asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority">
<ControlStyle Width="50px"></ControlStyle>
</asp:BoundField>
<asp:BoundField DataField="Min_Value" HeaderText="Min_Value" SortExpression="Min_Value" Visible="False">
<ControlStyle Width="50px"></ControlStyle>
</asp:BoundField>
<asp:BoundField DataField="Max_Value" HeaderText="Max_Value" SortExpression="Max_Value" Visible="False">
<ControlStyle Width="50px"></ControlStyle>
</asp:BoundField>
<asp:BoundField DataField="Critical_Values" HeaderText="Critical_Values" SortExpression="Critical_Values" Visible="False">
<ControlStyle Width="75px"></ControlStyle>
</asp:BoundField>
<asp:TemplateField><EditItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Update">Update</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Cancel">Cancel</asp:LinkButton>
                                    
</EditItemTemplate>
<ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edit" OnClientClick="return confirmation_edit(this)">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Delete" Visible="false" OnClientClick="return confirmation(this)">Delete</asp:LinkButton>
                                    
</ItemTemplate>
</asp:TemplateField>
</Columns>

 <RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

</asp:GridView>
                            <asp:HiddenField ID="HiddenFieldCompName" runat="server" />
                            <asp:HiddenField ID="HiddenFieldUnit" runat="server" />
                          <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                    
        SelectCommand="SELECT TestGroup.TGName, TestSubGroup.TSGName, Test.TestName, TestComponent.ComponentName, TestComponent.TCID, TestMUnit.TUnitName, TestComponent.e_Field_Type, TestMUnit.TMUnitID, TestComponent.TC_Range_Unit, TestComponent.Priority, TestComponent.MaxLength, TestComponent.Min_Value, TestComponent.Max_Value, TestComponent.Critical_Values, TestComponent.TC_Range_Unit_Female, Test.TID FROM Test INNER JOIN TestSubGroup ON Test.TSGID = TestSubGroup.TSGID INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID INNER JOIN TestComponent ON Test.TID = TestComponent.TID INNER JOIN TestMUnit ON TestComponent.TMUnitID = TestMUnit.TMUnitID WHERE (Test.TGID = @TGID) ORDER BY TestSubGroup.TSGName, Test.TestName" 
        ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" 
        DeleteCommand="DELETE FROM TestComponent WHERE (TCID = @tcid)" 
        UpdateCommand="UPDATE TestComponent SET ComponentName = @ComponentName, TMUnitID = @TMUnitID, e_Field_Type = @e_Field_Type, TC_Range_Unit = @TC_Range_Unit, Priority = @Priority, MaxLength = @MaxLength, Min_Value = @Min_Value, Max_Value = @Max_Value, Critical_Values = @Critical_Values,TC_Range_Unit_Female=@TC_Range_Unit_Female                  WHERE (TCID = @TCID)">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue" />
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
                                  <asp:ControlParameter ControlID="GridView1" Name="TC_Range_Unit_Female" PropertyName="SelectedValue" />
                              </UpdateParameters>
                          </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldType" runat="server" />
                            <asp:HiddenField ID="HiddenField_R_Values" runat="server" />
<br />
<br />

  </asp:Content>