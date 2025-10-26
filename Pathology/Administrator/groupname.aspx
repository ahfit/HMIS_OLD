<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="GroupName, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>




 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<asp:Label ID="Label_message" runat="server" ></asp:Label>
<div class="bxmain">

<table border="0" cellpadding="0" cellspacing="0" class="tbl_form" >
                         
                          <tr>
                            <td align="right" width="25%"  >Group Name :&nbsp;</td>
                            <td   width="25%">
                            <asp:DropDownList AutoPostBack="True" 
                              DataTextField="TGName" DataValueField="TGID" ID="DropDownListGName" runat="server"  DataSourceID="SqlDataSourceGName"> </asp:DropDownList></td>
                            <td width="25%" align="right" >Sub-Group Name :&nbsp; </td>
                            <td  align="left" width="25%">
                            <asp:DropDownList AutoPostBack="True" 
                            DataTextField="TSGName" DataValueField="TSGID" ID="DropDownListSGName" runat="server"  DataSourceID="SqlDataSourceSGName"> </asp:DropDownList></td>
      </tr>
                          <tr>
                            <td  align="right" >Test Name  :&nbsp;</td>
                            <td  >
                              <asp:TextBox ID="TextBoxTName" runat="server" CssClass="input_txt"  ></asp:TextBox></td>
                            <td  align="right" >Medical Name  :&nbsp;</td>
                            <td ><asp:TextBox ID="TextBoxMName" runat="server" CssClass="input_txt" ></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td  align="right" >Standard Name  :&nbsp;</td>
                            <td  ><asp:TextBox ID="TextBoxSName" runat="server" CssClass="input_txt"  ></asp:TextBox></td>
                            <td align="right" >Fee  :&nbsp;</td>
                            <td ><asp:TextBox ID="TextBoxFee" runat="server" CssClass="input_txt"></asp:TextBox>                              </td>
                          </tr> 
                        </table></div><br />
<div align="center"><asp:Button  ID="SAVE" runat="server" Text="Save" /></div>
<br />
<asp:SqlDataSource ID="SqlDataSourceGNameSave" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                        InsertCommand="INSERT INTO Test(TGID, TestName, Fee, TSGID, MedicalName, StandardName) VALUES (@TGID, @TestName, @Fee, @TSGID, @MedicalName, @StandardName)"
                        ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" UpdateCommand="UPDATE    Test&#13;&#10;SET              TGID = @TGID, TestName = @TestName, Fee = @Fee, TSGID = @TSGID, MedicalName = @MedicalName, StandardName = @StandardName&#13;&#10;WHERE     (TID = @TID)">
                            <InsertParameters>
                              <asp:SessionParameter Name="TGID" SessionField="TestTGID" />
                                <asp:ControlParameter ControlID="TextBoxTName" Name="TestName" PropertyName="Text" />
                                <asp:ControlParameter ControlID="TextBoxFee" Name="Fee" PropertyName="Text" />
                              <asp:SessionParameter Name="TSGID" SessionField="testTSGID" />
                                <asp:ControlParameter ControlID="TextBoxMName" Name="MedicalName" PropertyName="Text" />
                                <asp:ControlParameter ControlID="TextBoxSName" Name="StandardName" PropertyName="Text" />
                            </InsertParameters>
    <UpdateParameters>
        <asp:SessionParameter Name="TGID" SessionField="TestTGID" />
        <asp:ControlParameter ControlID="TextBoxTName" Name="TestName" PropertyName="Text" />
        <asp:ControlParameter ControlID="TextBoxFee" Name="Fee" PropertyName="Text" />
        <asp:SessionParameter Name="TSGID" SessionField="testTSGID" />
        <asp:ControlParameter ControlID="TextBoxMName" Name="MedicalName" PropertyName="Text" />
        <asp:ControlParameter ControlID="TextBoxSName" Name="StandardName" PropertyName="Text" />
        <asp:ControlParameter ControlID="HiddenField_TID" Name="TID" PropertyName="Value" />
    </UpdateParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                        SelectCommand="SELECT [TSGName], [TSGID] FROM [TestSubGroup] WHERE ([TGID] = @TGID)" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue"
                                Type="Int32" />
                            </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                        SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>"></asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenFieldGroupName" runat="server" />

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TID"
                    DataSourceID="SqlDataSourceGrid" AllowPaging="True"  Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="TID" InsertVisible="False" SortExpression="TID">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TID") %>' Visible="False"></asp:TextBox>
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("TID", "{0}") %>' />
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("TID") %>'></asp:Label>
                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:BoundField DataField="TGName" HeaderText="Test Group Name" SortExpression="TGName" ReadOnly="True" />
                            <asp:BoundField DataField="TSGName" HeaderText="Sub Group Name" SortExpression="TSGName" ReadOnly="True" />
                                <asp:TemplateField HeaderText="Test Name" SortExpression="TestName">
                                    <EditItemTemplate>
                                       <asp:TextBox ID="TextBox_TName" runat="server" Text='<%# Eval("TestName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("TestName") %>'></asp:Label>
                                        <asp:HiddenField ID="HF_Medical_Name" runat="server" Value='<%# Eval("MedicalName") %>' />
                                        <asp:HiddenField ID="HF_Standard_Name" runat="server" Value='<%# Eval("StandardName") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:BoundField DataField="E_Field_Type" HeaderText="Control Type" SortExpression="E_Field_Type" ReadOnly="True" />
                                <asp:TemplateField HeaderText="Fee" SortExpression="Fee">
                                <ItemStyle  CssClass="toright"/>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Fee") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Fee") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField>
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Update">Update</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Cancel">Cancel</asp:LinkButton>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" OnClientClick="return confirmation_edit(this)">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Delete" OnClientClick="return confirmation(this)">Delete</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView>
    <asp:HiddenField ID="HiddenField_TName" runat="server" />
    <br />
<br />

<asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                    SelectCommand="SELECT TestGroup.TGName, TestSubGroup.TSGName, Test.TestName, TestSubGroup.E_Field_Type, Test.Fee, Test.TID, Test.MedicalName, Test.StandardName FROM Test INNER JOIN TestSubGroup ON Test.TSGID = TestSubGroup.TSGID INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID WHERE (Test.TGID = @TGID) AND (Test.TSGID = @TSGID)" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" DeleteCommand="DELETE FROM Test WHERE (TID = @TID)" UpdateCommand="UPDATE Test SET Fee = @Fee, TestName = @TestName WHERE (TID = @TID) ">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListGName" Name="TGID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListSGName" Name="TSGID" PropertyName="SelectedValue" />
                            </SelectParameters>
                            <DeleteParameters>
                              <asp:ControlParameter ControlID="GridView1" Name="TID" PropertyName="SelectedValue" />
                            </DeleteParameters>
                              <UpdateParameters>
                                  <asp:ControlParameter ControlID="HiddenFieldTestFee" Name="Fee" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HiddenField2" Name="TID" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HiddenField_TName" Name="TestName" PropertyName="Value" />
                              </UpdateParameters>
                          </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldTestFee" runat="server" />
                            <asp:HiddenField ID="HiddenField2" runat="server" />
    <asp:HiddenField ID="HiddenField_TID" runat="server" />
                       <br />
<br />
  </asp:Content>