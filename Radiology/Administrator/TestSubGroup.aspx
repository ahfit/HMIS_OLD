<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="TestSubGroup, App_Web_42zygch0" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 

 <asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label><br />

<div class="bxmain">
<table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" >
                          
                          <tr>
                            <td align="right" valign="middle" style="height: 18px" >Group Name : </td>
                              <td width="35%" valign="middle" style="height: 18px"><asp:DropDownList  DataTextField="TGName"
                              DataValueField="TGID" ID="DropDownList_Group" runat="server" Width="200px" DataSourceID="SqlDataSourceGName" AutoPostBack="True"> </asp:DropDownList></td>
                            <td width="15%" align="right" valign="middle" style="height: 18px">Sub-Group Name : </td>
                        <td width="35%" align="left" valign="middle" style="height: 18px">
                          <asp:TextBox ID="TextBox_SGName" runat="server" CssClass="input_txt" Width="146px" ></asp:TextBox></td>
      </tr>
                          <tr>
                            <td  align="right" valign="middle">Fee :</td>
                              <td colspan="4" valign="middle"><asp:TextBox ID="TextBox_Fee" runat="server" CssClass="input_txt" Width="146px" ></asp:TextBox>
                                </td>
                            </tr> 
                        </table></div><br />
<div align="center"><asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Save"/>                                                                
                                <asp:Label CssClass="err" ForeColor="White" ID="Label1" runat="server"></asp:Label></div>

<asp:SqlDataSource ID="SqlDataSourceGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                              SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceTSGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                              InsertCommand="INSERT INTO TestSubGroup(TSGName, Fee, TGID) VALUES (@TSGName, @Fee, @TGID)"
                              ProviderName="System.Data.SqlClient" SelectCommand="SELECT TestSubGroup.TSGID, TestSubGroup.TSGName, TestSubGroup.Fee, TestGroup.TGName FROM TestSubGroup LEFT OUTER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID" DeleteCommand="DELETE FROM TestSubGroup WHERE (TSGID = @TSGID)" UpdateCommand="UPDATE TestSubGroup SET TSGName = @TSGName, Fee = @Fee, TGID = @TGID WHERE (TSGID = @TSGID)">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="TextBox_SGName" Name="TSGName" PropertyName="Text" />
                                <asp:ControlParameter ControlID="TextBox_Fee" Name="Fee" PropertyName="Text" />
                                <asp:ControlParameter ControlID="DropDownList_Group" Name="TGID" PropertyName="SelectedValue" />
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
<br />

                          <asp:GridView ID="GridViewTestSubGroup" runat="server" AutoGenerateColumns="False" DataKeyNames="TSGID"
                    DataSourceID="SqlDataSourceTestSubGroup" Width="100%" CssClass="Grid_1" AllowPaging="True">
                            <Columns>
                            <asp:BoundField DataField="TGName" HeaderText="Test Group" SortExpression="TGName" />
                            <asp:BoundField DataField="TSGID" HeaderText="Test Sub Group ID" InsertVisible="False" ReadOnly="True"
                            SortExpression="TSGID" />
                            <asp:BoundField DataField="TSGName" HeaderText="Test SubGroup Name" SortExpression="TSGName" />
                            <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" />
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
                          <asp:SqlDataSource ID="SqlDataSourceTestSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                    DeleteCommand="DELETE FROM [TestSubGroup] WHERE [TSGID] = @TSGID"
                    SelectCommand="SELECT TestSubGroup.TSGID, TestSubGroup.TSGName, TestSubGroup.Fee, TestGroup.TGName, TestSubGroup.TGID FROM TestSubGroup INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID WHERE (TestSubGroup.TGID = @TGID)" UpdateCommand="UPDATE [TestSubGroup] SET [TSGName] = @TSGName, [Fee] = @Fee Where [TSGID] = @TSGID &#13;&#10;&#13;&#10;&#13;&#10;&#13;&#10;" ProviderName="System.Data.SqlClient"><SelectParameters>
<asp:ControlParameter ControlID="DropDownList_Group" PropertyName="SelectedValue" Name="TGID"></asp:ControlParameter>
</SelectParameters>
<DeleteParameters>
<asp:ControlParameter ControlID="GridViewTestSubGroup" PropertyName="SelectedValue" Name="TSGID" Type="Int32"></asp:ControlParameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="TSGName" Type="String"></asp:Parameter>
<asp:Parameter Name="Fee" Type="Int32"></asp:Parameter>
<asp:Parameter Name="TGID" Type="Int32"></asp:Parameter>
<asp:Parameter Name="TSGID" Type="Int32"></asp:Parameter>
</UpdateParameters>
</asp:SqlDataSource>
                          

<br />
<br />


  </asp:Content>