<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Security_Admin_Employee_Module_pages, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 
 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">




                      <asp:Label ID="Label_message" runat="server" ></asp:Label>
                      
                      
                      
                      
                      <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          
                          <tr>
                            <td width="40%" align="right"   >Department Name :</td>
                              <td width="60%"  ><asp:DropDownList AutoPostBack="True"  DataTextField="Dept_Name" DataValueField="Dept_ID" ID="DropDownListDepartmentName" runat="server" Width="250px" DataSourceID="SqlDataSourceDepartmentName"> </asp:DropDownList></td>
                            </tr>
                          <tr>
                            <td align="right"    >Sub Department Name : </td>
                              <td ><asp:DropDownList AutoPostBack="True"  DataTextField="SubDept_Name" DataValueField="SubDept_Id" ID="DropDownListSubDepartment" runat="server" Width="250px" DataSourceID="SqlDataSourceSubDepartmentName"> </asp:DropDownList>
                              </td>
                            </tr>
                          <tr>
                            <td align="right"   > Employee Name : </td>
                              <td  >
                              <asp:DropDownList AutoPostBack="True"  DataTextField="EmployeeName" DataValueField="EmpID" ID="DropDownListEmployee" runat="server" Width="250px" DataSourceID="SqlDataSourceEMployeeName"> </asp:DropDownList></td>
                            </tr>
                          <tr>
                            <td align="right"    >Module Name :</td>
                              <td ><asp:DropDownList AutoPostBack="True"  DataTextField="Module_Name" DataValueField="Module_ID" ID="DropDownListModuleName" runat="server" Width="250px" DataSourceID="SqlDataSourceModuleName"> </asp:DropDownList></td>
                            </tr>
                          <tr>
                            <td align="right"    >Page Name :</td>
                              <td >
                                  <asp:CheckBoxList ID="CheckBoxListPage" runat="server" DataSourceID="SqlDataSourcePageName"
                                      DataTextField="Page_Name" DataValueField="Page_ID" RepeatColumns="4" RepeatDirection="Horizontal"
                                      Width="650px">
                                  </asp:CheckBoxList>
                                  </td>
                            </tr>
                          <tr>
                            <td align="right"    >&nbsp;</td>
                            <td ><asp:Button ID="ButtonCheckall" runat="server"  Text="CheckAll" />                            
                              <asp:Button ID="ButtonUnCheck" runat="server"  Text="UnCheckAll" />                              
                            <asp:Button ID="ButtonSave" runat="server"  Text="Save"  /></td>
                        </tr>
                          
                            
                          
                        </table>
                      <br>

                          
                          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
            DataSourceID="SqlDataSourceForGridView" Width="100%" > <FooterStyle CssClass="GridPager" />   
                            <Columns>
                            <asp:BoundField DataField="Module_Name" HeaderText="Module Name" SortExpression="Module_Name" />
                            <asp:BoundField DataField="Page_Name" HeaderText="Page Name" SortExpression="Page_Name" />
                            <asp:TemplateField HeaderText="Employee Name" SortExpression="employee_Name">
                              <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("employee_Name") %>'></asp:Label>
                              </EditItemTemplate>
                              <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("employee_Name") %>'></asp:Label>
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("ID", "{0}") %>' />
                              </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                    SortExpression="EmpID" Visible="False" />
                            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                    SortExpression="ID" Visible="False" />
                                <asp:BoundField DataField="Page_URL" HeaderText="URL" SortExpression="Page_URL" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                                            OnClientClick="return confirmation(this)" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns> <RowStyle CssClass="GridItem"  />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
  </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM Admin_Employee_Module_Pages WHERE (ID = @DeleteID)" ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>"
            SelectCommand="SELECT Admin_User_Module.Module_Name, Admin_User_Module_Pages.Page_Name, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS employee_Name, Employee.EmpID, Admin_Employee_Module_Pages.ID, Admin_Employee_Module_Pages.Module_ID, Admin_User_Module_Pages.Page_URL FROM Admin_User_Module INNER JOIN Admin_User_Module_Pages ON Admin_User_Module.Module_ID = Admin_User_Module_Pages.Module_ID INNER JOIN Admin_Employee_Module_Pages ON Admin_User_Module_Pages.Module_ID = Admin_Employee_Module_Pages.Module_ID AND Admin_User_Module_Pages.Page_ID = Admin_Employee_Module_Pages.Page_ID INNER JOIN Employee ON Admin_Employee_Module_Pages.Emp_ID = Employee.EmpID WHERE (Admin_Employee_Module_Pages.Emp_ID = @EmployeeID) AND (Admin_Employee_Module_Pages.Module_ID = @MOdule_ID)">
                            <DeleteParameters>
                              <asp:ControlParameter ControlID="HiddenFieldID" Name="DeleteID" PropertyName="Value" />
                            </DeleteParameters>
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListEmployee" Name="EmployeeID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListModuleName" Name="MOdule_ID" PropertyName="SelectedValue" />
                            </SelectParameters>
  </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceModuleName" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>" ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>" SelectCommand="SELECT [Module_Name], [Module_ID] FROM [Admin_User_Module]"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourcePageName" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>" ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>" SelectCommand="SELECT Page_Name, Page_ID FROM Admin_User_Module_Pages WHERE (Module_ID = @Module_ID)">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListModuleName" Name="Module_ID" PropertyName="SelectedValue" />
                            </SelectParameters>
  </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldPageID" runat="server" />
                          <asp:SqlDataSource ID="SqlDataSourceDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>" ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>" SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department]"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSubDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>" ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>" SelectCommand="SELECT SubDept_Name, SubDept_Id, Dept_Id FROM SubDepartment WHERE (Dept_Id = @Dept_ID)">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListDepartmentName" Name="Dept_ID" PropertyName="SelectedValue" />
                            </SelectParameters>
  </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceEMployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>" ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>" SelectCommand="SELECT EmpID, ISNULL(Prefix, ' ') + ' ' + ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, ' ') + ' ' + ISNULL(ELName, ' ') AS EmployeeName FROM Employee WHERE (DeptID = @Dept_ID) AND (SubDeptId = @SubDept_ID)">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListDepartmentName" Name="Dept_ID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDept_ID" PropertyName="SelectedValue" />
                            </SelectParameters>
  </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSaveINfo" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            InsertCommand="INSERT INTO Admin_Employee_Module_Pages(Emp_ID, Module_ID, Page_ID) VALUES (@Emp_ID, @Module_ID, @Page_ID)"
            ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>">
                            <InsertParameters>
                              <asp:ControlParameter ControlID="DropDownListEmployee" Name="Emp_ID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListModuleName" Name="Module_ID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="HiddenFieldPageID" Name="Page_ID" PropertyName="Value" />
                            </InsertParameters>
  </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenFieldID" runat="server" Value='<%# Bind("ID", "{0}") %>' /> 
                      

                      <br>
<br>

                      
</asp:Content>
