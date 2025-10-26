<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Employee_Type_Leave, App_Web_gxw3jji3" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
function backto()
{
history.go(-1);
}
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<div class="bxmain">
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form" >
            <tr>
    <td align="right" width="40%" >
                                Leave Type :</td>
                            <td width="60%" >
                                <asp:DropDownList ID="DropDownList_Leave_Name" runat="server" 
                                    DataSourceID="SqlDataSource_Leave_Type" DataTextField="Leave_Type_Name" 
                                    DataValueField="Leave_Type_Id" Width="199px">
                                </asp:DropDownList>
                            </td>
          </tr>
                        <tr>
                            <td align="right" >
                                Employee Type :</td>
                            <td >
                                <asp:CheckBoxList ID="CheckBoxList_Employee_Type" runat="server" 
                                    DataSourceID="SqlDataSource_Employee_Type" DataTextField="Type" 
                                    DataValueField="Employee_Type_ID">
                                </asp:CheckBoxList>
                            </td>
                        </tr>
            <tr>
              <td align="right" ></td>
              <td>
                  <asp:Button ID="Button_Save" runat="server" Text="Save" />
                    </td>
            </tr>
      </table>
</div>

<br />

                    <asp:SqlDataSource ID="SqlDataSource_Leave_Type" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>" 
                
                SelectCommand="SELECT [Leave_Type_Id], [Leave_Type_Name] FROM [Leave_Types]">
            </asp:SqlDataSource>

                    <asp:SqlDataSource ID="SqlDataSource_Employee_Type" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>" 
                SelectCommand="SELECT [Employee_Type_ID], [Type] FROM [Employee_Type]">
            </asp:SqlDataSource>

                    <asp:SqlDataSource ID="SqlDataSource_Employee_Type_Leave" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>" 
                DeleteCommand="DELETE FROM [Employee_Type_Leave] WHERE [Employee_Type_id] = @Employee_Type_id AND [Leave_Type_id] = @Leave_Type_id" 
                InsertCommand="INSERT INTO [Employee_Type_Leave] ([Employee_Type_id], [Leave_Type_id]) VALUES (@Employee_Type_id, @Leave_Type_id)" 
                
                
                SelectCommand="SELECT Employee_Type_Leave.Employee_Type_id, Employee_Type_Leave.Leave_Type_id, Leave_Types.Leave_Type_Name, Employee_Type.Type FROM Employee_Type_Leave INNER JOIN Leave_Types ON Employee_Type_Leave.Leave_Type_id = Leave_Types.Leave_Type_Id INNER JOIN Employee_Type ON Employee_Type_Leave.Employee_Type_id = Employee_Type.Employee_Type_ID" 
                UpdateCommand="UPDATE Employee_Type_Leave SET Employee_Type_id = @Employee_Type_id, Leave_Type_id = @Leave_Type_id">
                        <DeleteParameters>
                            <asp:Parameter Name="Employee_Type_id" Type="Int32" />
                            <asp:Parameter Name="Leave_Type_id" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Employee_Type_id" />
                            <asp:Parameter Name="Leave_Type_id" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HiddenField_Employee_type" 
                                Name="Employee_Type_id" PropertyName="Value" Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_Leave_Name" Name="Leave_Type_id" 
                                PropertyName="SelectedValue" Type="Int32" />
                        </InsertParameters>
            </asp:SqlDataSource>

                    <asp:HiddenField ID="HiddenField_Employee_type" runat="server" />

                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="Employee_Type_id,Leave_Type_id" 
                DataSourceID="SqlDataSource_Employee_Type_Leave" Width="100%" 
                AllowPaging="True">
                        <Columns>
                            <asp:TemplateField HeaderText="Leave Name" SortExpression="Leave_Type_Name">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList_Leave_Name" runat="server" 
                                        DataSourceID="SqlDataSource_Leave_Type" DataTextField="Leave_Type_Name" 
                                        DataValueField="Leave_Type_Id" 
                                        SelectedValue='<%# Bind("Leave_Type_id", "{0}") %>' Width="199px">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Leave_Type_Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Employee Type" SortExpression="Type">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList1" runat="server" 
                                        DataSourceID="SqlDataSource_Employee_Type" DataTextField="Type" 
                                        DataValueField="Employee_Type_ID" 
                                        SelectedValue='<%# Bind("Employee_Type_id", "{0}") %>' Width="200px">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Type") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowDeleteButton="True" />
                        </Columns>
                        <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
            <br />

    </asp:Content>