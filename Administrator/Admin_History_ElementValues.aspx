<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_History_ElementValues, App_Web_lwhdjlgh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



 <asp:Label ID="Label_message" runat="server" ></asp:Label>
 <div  class="bxmain">
 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >

                          <tr>
                            <td width="25%" align="right" >Main Group Part  : </td>
                            <td width="25%" ><asp:DropDownList AutoPostBack="True"  DataTextField="MG_Name" DataValueField="MG_Code" ID="DropDownListMGroup" runat="server" Width="180px" DataSourceID="SqlDataSourceMainGroup"> </asp:DropDownList></td>
                            <td width="25%"  align="right" >Element Group   :</td>
                            <td width="25%" ><asp:DropDownList AutoPostBack="True"  DataTextField="e_Name" DataValueField="e_Code" ID="DropDownListEGroup" runat="server"   DataSourceID="SqlDataSourceElementGroup"> </asp:DropDownList></td>
      </tr>
                         <tr>
                            <td align="right"  >Element Value :</td>
                              <td colspan="4" ><asp:TextBox  ID="TextBoxEName" runat="server" Width="178px"></asp:TextBox>

                                </td>
                            </tr>
                         
                          <tr>
                            <td align="right"  ></td>
                            <td colspan="4" ><asp:Button  ID="ButtonSave" runat="server" Text="Save" />                                
                                <asp:Button  ID="ButtonRefresh" runat="server" Text="Refresh" /></td>
                          </tr>
                          
                        </table></div>
<br />
<asp:Label CssClass="err" ID="Label1" runat="server" ></asp:Label>                        
 
 <asp:GridView ID="GridViewElementValues" runat="server" AutoGenerateColumns="False" DataKeyNames="ev_Code" DataSourceID="SqlDataSourceForGrid"
                        Width="100%"  >
                            <FooterStyle CssClass="GridPager" />                          
                            <Columns>
                                <asp:TemplateField>
                                    <EditItemTemplate>
                                 <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif"  ToolTip="Update" /><asp:ImageButton
                                            ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images_hacims/icon_err.gif"  ToolTip="Cancel" />
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif"   ToolTip="Edit"
                                            OnClientClick="return confirmation_edit(this)" /><asp:ImageButton ID="ImageButton2"
                                                runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"   ToolTip="Delete" OnClientClick="return confirmation(this)" /> 
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:BoundField DataField="MG_Name" HeaderText="Main Group" SortExpression="MG_Name" ReadOnly="True" />
                            <asp:BoundField DataField="e_Name" HeaderText="Element Name" SortExpression="e_Name" ReadOnly="True" />
                            <asp:BoundField DataField="ev_Value" HeaderText="Element Value" SortExpression="ev_Value" />
                            <asp:BoundField DataField="ev_Code" HeaderText="ev_Code" InsertVisible="False" ReadOnly="True"
                                SortExpression="ev_Code" Visible="False" />
                                <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView><br />
<br />

                          <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                DeleteCommand="DELETE FROM admin_history_ElementValue WHERE (ev_Code = @ev_Code)"
                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="SELECT admin_History_MainGroup.MG_Name, admin_History_Elements.e_Name, admin_History_ElementValue.ev_Value, admin_History_ElementValue.ev_Code, admin_History_ElementValue.Priority FROM admin_History_MainGroup INNER JOIN admin_History_ElementValue INNER JOIN Admin_History_Elememt_Assign_To_Group ON admin_History_ElementValue.e_Code = Admin_History_Elememt_Assign_To_Group.e_Code AND admin_History_ElementValue.MG_Code = Admin_History_Elememt_Assign_To_Group.MG_Code INNER JOIN admin_History_Elements ON Admin_History_Elememt_Assign_To_Group.e_Code = admin_History_Elements.e_Code ON admin_History_MainGroup.MG_Code = Admin_History_Elememt_Assign_To_Group.MG_Code WHERE (Admin_History_Elememt_Assign_To_Group.MG_Code = @MG_Code) AND (Admin_History_Elememt_Assign_To_Group.e_Code = @e_Code)" UpdateCommand="UPDATE admin_History_ElementValue SET ev_Value = @ev_Value, Priority = @Priority WHERE (ev_Code = @ev_Code)">
                            <DeleteParameters>
                              <asp:ControlParameter ControlID="GridViewElementValues" Name="ev_Code" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListMGroup" Name="MG_Code" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListEGroup" Name="e_Code" PropertyName="SelectedValue" />
                            </SelectParameters>
                              <UpdateParameters>
                                  <asp:ControlParameter ControlID="HiddenFieldElementValue" Name="ev_Value" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="GridViewElementValues" Name="ev_Code" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="HiddenFieldPriority" Name="Priority" PropertyName="Value" />
                              </UpdateParameters>
                          </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldElementValue" runat="server" />
                          <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="SELECT MG_Code, MG_Name FROM admin_History_MainGroup ORDER BY MG_Name"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceElementGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="SELECT admin_History_Elements.e_Code, admin_History_Elements.e_Name, admin_History_Elements.e_Field_Type FROM admin_History_Elements INNER JOIN Admin_History_Elememt_Assign_To_Group ON admin_History_Elements.e_Code = Admin_History_Elememt_Assign_To_Group.e_Code WHERE (Admin_History_Elememt_Assign_To_Group.MG_Code = @MG_Code)">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListMGroup" Name="MG_Code" PropertyName="SelectedValue"
                        Type="Int32" />
                            </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" InsertCommand="Admin_Insert_Phy_exam_Element_Values" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                            <InsertParameters>
                              <asp:ControlParameter ControlID="DropDownListMGroup" Name="MG_Code" PropertyName="SelectedValue"
                        Type="Int32" />
                              <asp:ControlParameter ControlID="DropDownListEGroup" Name="e_Code" PropertyName="SelectedValue"
                        Type="Int32" />
                              <asp:ControlParameter ControlID="TextBoxEName" Name="ev_Value" PropertyName="Text"
                        Type="String" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                       
                            <asp:HiddenField ID="HiddenFieldPriority" runat="server" />
  </asp:Content>