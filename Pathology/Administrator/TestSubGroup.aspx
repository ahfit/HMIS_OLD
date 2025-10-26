<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="TestSubGroup, App_Web_zvadaqir" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">




 
<asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label>

<div class="bxmain">
<table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" >
                      
                          <tr>
                            <td align="right" width="40%"  > Group Name :&nbsp; </td>
                              <td width="60%" ><asp:DropDownList  DataTextField="TGName"
                              DataValueField="TGID" ID="GName" runat="server"  DataSourceID="SqlDataSourceGName" AutoPostBack="True"> </asp:DropDownList></td>
                            </tr><tr>  <td  align="right" >Sub-Group Name :&nbsp; </td>
                          
                        <td>
                          <asp:TextBox ID="TxtSGName" runat="server" CssClass="input_txt"  ></asp:TextBox></td>
      
                           </tr><tr> <td  align="right" >Fee :&nbsp;</td>
                              <td ><asp:TextBox ID="txtFee" runat="server" CssClass="input_txt" ></asp:TextBox>
                                </td>
                            </tr>
                           <tr>
                             <td  align="right" >&nbsp;</td>
                             <td ><asp:Button CssClass="btn1" ID="update" runat="server" Text="Save"/>                             
                             <asp:Label CssClass="err" ForeColor="White" ID="Label1" runat="server"></asp:Label></td>
                           </tr> 
                        </table></div>
<br />


<asp:SqlDataSource ID="SqlDataSourceGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                              SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceTSGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                              InsertCommand="INSERT INTO TestSubGroup(TSGName, Fee, TGID) VALUES (@TSGName, @Fee, @TGID)"
                              ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT TestSubGroup.TSGID, TestSubGroup.TSGName, TestSubGroup.Fee, TestGroup.TGName FROM TestSubGroup LEFT OUTER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID" DeleteCommand="DELETE FROM TestSubGroup WHERE (TSGID = @TSGID)" UpdateCommand="UPDATE TestSubGroup SET TSGName = @TSGName, Fee = @Fee, TGID = @TGID WHERE (TSGID = @TSGID)">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="TxtSGName" Name="TSGName" PropertyName="Text" />
                                <asp:ControlParameter ControlID="txtFee" Name="Fee" PropertyName="Text" />
                              <asp:SessionParameter Name="TGID" SessionField="TGID" />
                            </InsertParameters>
                            <DeleteParameters>
                              <asp:SessionParameter Name="TSGID" SessionField="TSGID" />
                            </DeleteParameters>
                            <UpdateParameters>
                              <asp:FormParameter FormField="txtSGName" Name="TSGName" />
                              <asp:FormParameter FormField="txtfee" Name="Fee" />
                              <asp:FormParameter FormField="GName" Name="TGID" />
                              <asp:SessionParameter Name="TSGID" SessionField="TSGID" />
                            </UpdateParameters>
                          </asp:SqlDataSource>


                          <asp:GridView ID="GridViewTestSubGroup" runat="server" AutoGenerateColumns="False" DataKeyNames="TSGID"
                    DataSourceID="SqlDataSourceTestSubGroup" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="Test Group" SortExpression="TGName">
                                    <EditItemTemplate>
                                        <asp:DropDownList  DataTextField="TGName"
                              DataValueField="TGID" ID="GName" runat="server"  DataSourceID="SqlDataSourceGName" AutoPostBack="True" SelectedValue='<%# Bind("TGID", "{0}") %>' Width="118px">
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("TGName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:BoundField DataField="TSGID" HeaderText="Test Sub Group ID" InsertVisible="False" ReadOnly="True"
                            SortExpression="TSGID" />
                            <asp:BoundField DataField="TSGName" HeaderText="Test SubGroup Name" SortExpression="TSGName" />
                            <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" >
                            <ItemStyle  CssClass="toright"/>
                            </asp:BoundField>
                                <asp:BoundField DataField="TGID" HeaderText="TGID" SortExpression="TGID" Visible="False" />
                                <asp:TemplateField>
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Update">Update</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Cancel">Cancel</asp:LinkButton>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edit" OnClientClick="return confirmation_edit(this)">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Delete" OnClientClick="return confirmation(this)">Delete</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSourceTestSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                    DeleteCommand="DELETE FROM [TestSubGroup] WHERE [TSGID] = @TSGID" InsertCommand="INSERT INTO [TestSubGroup] ([TSGName], [Fee], [TGID]) VALUES (@TSGName, @Fee, @TGID)"
                    SelectCommand="SELECT TestSubGroup.TSGID, TestSubGroup.TSGName, TestSubGroup.Fee, TestGroup.TGName, TestSubGroup.TGID FROM TestSubGroup INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID WHERE (TestSubGroup.TGID = @TGID)" UpdateCommand="UPDATE [TestSubGroup] SET [TSGName] = @TSGName, [Fee] = @Fee, [TGID] = @TGID WHERE [TSGID] = @TSGID" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>">
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="GridViewTestSubGroup" Name="TSGID" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                              <asp:Parameter Name="TSGName" Type="String" />
                              <asp:Parameter Name="Fee" Type="Int32" />
                              <asp:Parameter Name="TGID" Type="Int32" />
                              <asp:Parameter Name="TSGID" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                              <asp:Parameter Name="TSGName" Type="String" />
                              <asp:Parameter Name="Fee" Type="Int32" />
                              <asp:Parameter Name="TGID" Type="Int32" />
                            </InsertParameters>
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="GName" Name="TGID" PropertyName="SelectedValue" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          

  </asp:Content>