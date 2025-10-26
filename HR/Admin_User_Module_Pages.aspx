<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Security_Admin_User_Module_Pages, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 
<asp:Label ID="Label_message" runat="server" ></asp:Label> 
                
         <div class="bxmain">       
                
 <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                           
                          <tr>
                            <td height="25" align="right"  > Module Name : </td>
                              <td >
                                <asp:DropDownList AutoPostBack="True" 
                        DataTextField="Module_Name" DataValueField="Module_ID" ID="DropDownListModuleName" runat="server" Width="202px" DataSourceID="SqlDataSourceModule"> </asp:DropDownList>
                              </td>
                            </tr>
                          <tr>
                            <td height="25" align="right"  >Page Name :</td>
                            <td >
                              <asp:TextBox  ID="TextBoxPageName" runat="server"></asp:TextBox>
                            </td>
                          </tr>
                          <tr>
                            <td height="25" align="right"  >Page URL :</td>
                              <td >
                                <asp:TextBox  ID="TextBoxPageURL" runat="server"></asp:TextBox>
                              </td>
                            </tr>
                          <tr>
                            <td height="25" align="right"  >&nbsp;</td>
                            <td ><asp:Button ID="ButtonSave" runat="server"   Text="Save"   /></td>
                          </tr>
                         
                        
                          
                        </table> 
                        
                     </div>
         <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Page_ID"
            DataSourceID="SqlDataSourceForGridView" Width="100%" >  <FooterStyle CssClass="GridPager" /> 
                            <Columns>
                            <asp:BoundField DataField="Module_Name" HeaderText="Module Name" SortExpression="Module_Name" />
                            <asp:BoundField DataField="Page_Name" HeaderText="Page Name" SortExpression="Page_Name" />
                            <asp:BoundField DataField="Page_URL" HeaderText="Page URL" SortExpression="Page_URL" />
                            <asp:BoundField DataField="Page_ID" HeaderText="Page_ID" InsertVisible="False" ReadOnly="True"
                    SortExpression="Page_ID" Visible="False" />
                                <asp:TemplateField>
                                    <ItemTemplate>

                                      <script src="../Validate.js" type="text/javascript"></script>

                                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                                            OnClientClick="return confirmation(this)" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns><RowStyle CssClass="GridItem"  />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
  </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM Admin_User_Module_Pages WHERE (Page_ID = @page_ID)"
            ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>" SelectCommand="SELECT     Admin_User_Module.Module_Name, Admin_User_Module_Pages.Page_Name, Admin_User_Module_Pages.Page_URL, 
                      Admin_User_Module_Pages.Page_ID
FROM         Admin_User_Module INNER JOIN
                      Admin_User_Module_Pages ON Admin_User_Module.Module_ID = Admin_User_Module_Pages.Module_ID
where Admin_User_Module_Pages.Module_ID = @Module_ID">
                            <DeleteParameters>
                              <asp:ControlParameter ControlID="GridView1" Name="page_ID" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListModuleName" Name="Module_ID" PropertyName="SelectedValue" />
                            </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenFieldID" runat="server" Value='<%# Bind("ID", "{0}") %>' />
                        
                          <asp:SqlDataSource ID="SqlDataSourceModule" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            InsertCommand="INSERT INTO Admin_User_Module_Pages(Module_ID, Page_Name, Page_URL) VALUES (@Module_ID, @Page_Name, @Page_URL)"
            ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>" SelectCommand="SELECT Module_Name, Module_ID FROM Admin_User_Module">
                            <InsertParameters>
                              <asp:ControlParameter ControlID="DropDownListModuleName" Name="Module_ID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="TextBoxPageName" Name="Page_Name" PropertyName="Text" />
                              <asp:ControlParameter ControlID="TextBoxPageURL" Name="Page_URL" PropertyName="Text" />
                            </InsertParameters>
                          </asp:SqlDataSource> 
                      

                      

                      
                       <br>
<br>
<br>
<br>

                
                
</asp:Content>

          
          
         