<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="TestGroup, App_Web_42zygch0" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 <asp:Label ID="Label_message" runat="server" ></asp:Label>
<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form"  >
                         
                          <tr>
                            <td align="right"  width="40%"  > Group Name : </td>
                            <td >
                              <asp:TextBox ID="TextBoxGName" runat="server"    ></asp:TextBox>
                            </td>
</tr>                            <tr>
                            <td    align="right" valign="middle"  > Fee : </td>
                            <td      ><asp:TextBox ID="TextBoxFee" runat="server"  Width="100px" ></asp:TextBox>
                                                            </td>
      </tr>
      <tr><td></td><td><asp:Button CssClass="btn1" ID="Save" runat="server" Text="Save" /></td></tr>
                        </table></div><br />
  
<br />
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TGID"
                    DataSourceID="SqlDataSource1" Width="100%" CssClass="Grid_1" AllowPaging="True">
<RowStyle CssClass="GridItem"></RowStyle>
<Columns>
<asp:BoundField DataField="TGID" HeaderText="TGID" ReadOnly="True" InsertVisible="False" SortExpression="TGID"></asp:BoundField>
<asp:BoundField DataField="TGName" HeaderText="TGName" SortExpression="TGName"></asp:BoundField>
    <asp:TemplateField HeaderText="Fee" SortExpression="Fee">
        <EditItemTemplate>
            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Fee") %>'></asp:TextBox>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:Label ID="lblTotal" runat="server"></asp:Label>
        </FooterTemplate>
        <ItemTemplate>
            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Fee") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
<asp:BoundField DataField="Gender_ID" HeaderText="Gender_ID" SortExpression="Gender_ID"></asp:BoundField>
<asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority"></asp:BoundField>
<asp:BoundField DataField="SampleTake" HeaderText="SampleTake" SortExpression="SampleTake"></asp:BoundField>
<asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category"></asp:BoundField>
</Columns>

<PagerStyle  CssClass="GridPager"></PagerStyle>

<HeaderStyle CssClass="GridHeader"></HeaderStyle>

<AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
</asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                    DeleteCommand="DELETE FROM [TestGroup] WHERE [TGID] = @TGID" InsertCommand="INSERT INTO [TestGroup] ([TGName], [Fee]) VALUES (@TGName, @Fee)"
                    SelectCommand="SELECT * FROM [TestGroup]" UpdateCommand="UPDATE [TestGroup] SET [TGName] = @TGName, [Fee] = @Fee WHERE [TGID] = @TGID" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>">
                            <DeleteParameters>
                              <asp:Parameter Name="TGID" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                              <asp:Parameter Name="TGName" Type="String" />
                              <asp:Parameter Name="Fee" Type="Int32" />
                              <asp:Parameter Name="TGID" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                              <asp:Parameter Name="TGName" Type="String" />
                              <asp:Parameter Name="Fee" Type="Int32" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                              <asp:SqlDataSource ID="SqlDataSourceTestGroupSave" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                              InsertCommand="INSERT INTO TestGroup(TGName, Fee) VALUES (@TGName, @Fee)" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBoxGName" Name="TGName" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="TextBoxFee" Name="Fee" PropertyName="Text" />
                                </InsertParameters>
                              </asp:SqlDataSource>
                                                        
<br />
  </asp:Content>