<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Security_Admin_User_Module, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
 
 
                       <asp:Label ID="Label_message" runat="server" ></asp:Label>
                  <div class="bxmain">    
                  
                 <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          
            <tr>
                            <td width="40%"  align="right"  > Module Name :  </td>
                              <td width="60%" >
                                <asp:TextBox  ID="TextBoxModule_Name" runat="server"></asp:TextBox>
                              </td>
                            </tr>
                          <tr>
                            <td align="right"   >Department  Name : </td>
                              <td  >
                                <asp:DropDownList 
                        DataTextField="Dept_Name" DataValueField="Dept_ID" ID="DropDownListDepartmentName" runat="server" Width="202px" DataSourceID="SqlDataSourceDepartment" AutoPostBack="True"> </asp:DropDownList>
                              </td>
                            </tr>
                          <tr>
                            <td align="right"   >&nbsp;</td>
                            <td  ><asp:Button ID="ButtonSave" runat="server"  Text="Save" /></td>
                          </tr>
                          
  </table></div>
  <br>

                 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Module_ID"
            DataSourceID="SqlDataSourceForGridView" Width="100%" >  <FooterStyle CssClass="GridPager" />   
                          <Columns>
                          <asp:BoundField DataField="Module_Name" HeaderText="Module Name" SortExpression="Module_Name" />
                          <asp:BoundField DataField="Dept_Name" HeaderText="Department Name" SortExpression="Dept_Name" />
                          <asp:BoundField DataField="Module_ID" HeaderText="Module_ID" InsertVisible="False"
                    ReadOnly="True" SortExpression="Module_ID" Visible="False" />
                              <asp:TemplateField>
                                  <ItemTemplate>
                                      <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                                          OnClientClick="return confirmation(this)" />
                                  </ItemTemplate>
                              </asp:TemplateField>
                          </Columns><RowStyle CssClass="GridItem"  />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
  </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM Admin_User_Module WHERE (Module_ID = @Module_ID)"
            ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>" SelectCommand="SELECT Admin_User_Module.Module_Name, Department.Dept_Name, Admin_User_Module.Module_ID, Admin_User_Module.Dept_ID FROM Admin_User_Module INNER JOIN Department ON Admin_User_Module.Dept_ID = Department.Dept_ID WHERE (Admin_User_Module.Dept_ID = @Dept_ID)">
                            <DeleteParameters>
                              <asp:ControlParameter ControlID="GridView1" Name="Module_ID" PropertyName="SelectedValue" />
                            </DeleteParameters>
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="DropDownListDepartmentName" Name="Dept_ID" PropertyName="SelectedValue" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                                InsertCommand="INSERT INTO Admin_User_Module(Module_Name, Dept_ID) VALUES (@Module_Name, @Dept_ID)"
                                ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBoxModule_Name" Name="Module_Name" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="DropDownListDepartmentName" Name="Dept_ID" PropertyName="SelectedValue" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenFieldID" runat="server" Value='<%# Bind("ID", "{0}") %>' />
                          <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>" SelectCommand="SELECT Dept_Name, Dept_ID FROM Department">
                          </asp:SqlDataSource> 

                      
 <br>
<br>
<br>

 </asp:Content>
