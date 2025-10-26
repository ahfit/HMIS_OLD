<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_Dashboard_Atten_machine, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width = "100%">
    <tr>
        <td align = "right">
            <strong>Machine IP:</strong></td>
        <td>
        <asp:TextBox ID = "txt_IP" runat = "server">
        </asp:TextBox>
        </td>
    </tr>
    <tr>
        <td align = "right">
            <strong>Machine type :</strong></td>
        <td>
            <asp:DropDownList ID="ddl_Type" runat="server">
                <asp:ListItem Value="O">OLD</asp:ListItem>
                <asp:ListItem Value="N">NEW</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>

    <tr>
        <td align = "right">
            <strong>Port No. :
        </strong>
        </td>
        <td>
         <asp:TextBox ID = "txt_port" runat = "server">
        </asp:TextBox> 
        </td>
    </tr>

    <tr>
        <td align = "right">
            <strong>Location :</strong></td>
        <td>
         <asp:TextBox ID = "txt_Machine" runat = "server">
        </asp:TextBox> 
        </td>
    </tr>

    <tr>
        <td>
            &nbsp;</td>
        <td>
        <asp:Button ID = "btn_Save_IP" runat = "server" Text = "Save" />
            <asp:SqlDataSource ID="SDS_Insert_IP" runat="server" 
                 
                DeleteCommand="DELETE FROM Attendence_Machines WHERE (ID_Machine = @ID_Machine)" 
                InsertCommand="INSERT INTO Attendence_Machines(IP_Machine, TYPE, REG_Date, Create_by, Port, Location) VALUES (@IP_Machine, @TYPE, GETDATE(), @Create_by, @Port, @Location)" 
                SelectCommand="SELECT ID_Machine, IP_Machine, Port, CASE WHEN TYPE = 'O' THEN 'Old' ELSE 'New' END AS MAchine_Type, Location FROM Attendence_Machines" 
                
                
                UpdateCommand="UPDATE Attendence_Machines SET IP_Machine = @IP_Machine, TYPE = @TYPE, Port = @Port WHERE (ID_Machine = @ID_Machine)" 
                ConnectionString="<%$ ConnectionStrings:Machine_Attendence_LogsConnectionString %>" 
                
                ProviderName="<%$ ConnectionStrings:Machine_Attendence_LogsConnectionString.ProviderName %>">
                <DeleteParameters>
                    <asp:Parameter Name="ID_Machine" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="txt_IP" Name="IP_Machine" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="ddl_Type" Name="TYPE" 
                        PropertyName="SelectedValue" />
                    <asp:SessionParameter Name="Create_by" SessionField="emp_id" />
                    <asp:ControlParameter ControlID="txt_port" Name="Port" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txt_Machine" Name="Location" 
                        PropertyName="Text" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IP_Machine" />
                    <asp:Parameter Name="TYPE" />
                    <asp:Parameter Name="Port" />
                    <asp:Parameter Name="ID_Machine" />
                </UpdateParameters>
            </asp:SqlDataSource>

            

        </td>
    </tr>



    <tr>
        <td>
            &nbsp;</td>
        <td>
            <asp:SqlDataSource ID="Cleared_Machine_Logs" runat="server" 
                InsertCommand="INSERT INTO Cleared_Logs_Data
                      (Emp_ID, Cleared_Time, Machine_IP)
VALUES     (@Emp_ID,GETDATE(),@Machine_IP)" 
                ConnectionString="<%$ ConnectionStrings:Machine_Attendence_LogsConnectionString %>" 
                
                ProviderName="<%$ ConnectionStrings:Machine_Attendence_LogsConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
                    <asp:Parameter Name="Cleared_Time" />
                    <asp:ControlParameter ControlID="lbl_IP" Name="Machine_IP" 
                        PropertyName="Text" />
                </InsertParameters>
            </asp:SqlDataSource>

            

        </td>
    </tr>



    <tr>
        <td  colspan = "2" align ="center">
            
           <asp:GridView ID = "gdv_Show_IP" runat ="server" AutoGenerateColumns="False" width = "100%"
                DataSourceID="SDS_Insert_IP" DataKeyNames="ID_Machine">
               <Columns>
                   <asp:CommandField ShowDeleteButton="True" />
                   <%--<asp:BoundField DataField="IP_Machine" HeaderText="Machine IP" />--%>
                  <asp:TemplateField HeaderText="Machine IP">
                       <ItemTemplate>
                           <asp:LinkButton ID="lnk_btn" runat="server" 
                               CommandArgument='<%# Eval("Port") %>' onclick="lnk_btn_Click" 
                               Text='<%# Eval("IP_Machine") %>'></asp:LinkButton>
                           <br />
                           <asp:HiddenField ID="hd_type" runat="server" Value='<%# Eval("MAchine_Type") %>' />
                       </ItemTemplate>
                   </asp:TemplateField>
                   <asp:BoundField DataField="Port" HeaderText="Port" SortExpression="Port" />
                   <asp:BoundField DataField="MAchine_Type" HeaderText="Machine Type" 
                       ReadOnly="True" SortExpression="MAchine_Type" />
                          <asp:BoundField DataField="Location" HeaderText="Location" 
                       ReadOnly="True" SortExpression="Location" />
                   
               </Columns>
           </asp:GridView> 
            
            </td>
       
    </tr>



    <tr>
        <td  colspan = "2" align ="center">
            
            &nbsp;</td>
       
    </tr>



    <tr>
        <td  colspan = "2" align ="center">
            
            
            <asp:Panel ID = "PNL_Device" runat = "server">
            <div width = "100%" align = "left" class = "bxmain">
            <table width ="100%" align ="center">
            <tr >
                <td colspan = "3" align = "center">
                    <strong> <h2>
                    <asp:Label ID = "lbl_IP" ForeColor ="Red" runat = "server"></asp:Label> 
                    Connected Successfully...

                    </h2></strong>
                </td>
            </tr>
                <tr>
                    <td align="center" colspan="3">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="center" colspan="3">
                        <strong><h3>
                       <asp:Label ID = "LBL_RECORD"  runat = "server"></asp:Label>
                        </h3></strong></td>
                </tr>
                <tr>
                    <td align="center" colspan="3">
                       <asp:HiddenField ID = "hdf_Type" runat = "server" />
                        <strong>
                        <asp:Label ID="lbl_MSG" runat="server" ForeColor="Red"></asp:Label>
                        </strong>
                       <asp:HiddenField ID = "hdf_Port" runat = "server" />
                       </td>
                </tr>
            <tr>
                <td width = "33%" align ="Center">
                <asp:Button ID = "btn_Import" runat = "server" Text = "Load Record(s)" />
                    <strong>
                    <br />
                    <asp:Label runat="server" ForeColor="Red" ID = "lbl_IR_MSG"></asp:Label>
                    </strong>
                </td>
                <td>
                <asp:Button ID = "btn_Clear" runat = "server" Text = "Clear Machine Record" />
                    <strong>
                    <br />
                    <asp:Label ID="lbl_CR_MSG" runat="server" ForeColor="Red"></asp:Label>
                    </strong>
                </td>
                <td width = "33%" align ="left">
                <asp:Button ID = "Btn_Disconnect" runat = "server" Text = "Return" />
                </td>
            </tr>
                <tr>
                    <td align="Center" width="33%">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td align="Center" width="33%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="right" width="33%">
                        Employee No :
                    </td>
                    <td>
                        <asp:TextBox ID="txt_emp_no" runat="server" AutoPostBack="True" Width="74px"></asp:TextBox>
                        <asp:HiddenField ID="HFD_emp_no" runat="server" Value="%" />
                    </td>
                    <td align="Center" width="33%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="Center" width="33%">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td align="Center" width="33%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="Center" colspan="3" width="33%">
                        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" 
                            AllowPaging="True" Width="100%" AutoGenerateColumns="False" 
                            AllowSorting="True" PageSize="100">
                            <Columns>
                                <asp:BoundField DataField="EnrollNumber" HeaderText="Emp #" 
                                    SortExpression="EnrollNumber" />
                                <asp:BoundField DataField="Dept_Name" HeaderText="Department Name" 
                                    SortExpression="Dept_Name" />
                                <asp:BoundField DataField="NAME" HeaderText="NAME" SortExpression="NAME" />
                                <asp:BoundField DataField="A_Date" HeaderText="Date" 
                                    SortExpression="A_Date" />
                                <asp:BoundField DataField="A_Time" HeaderText="Attendance Time" 
                                    SortExpression="A_Time" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Machine_Attendence_LogsConnectionString %>" 
                        SelectCommand="SELECT DISTINCT Attendence_Machines_LOG.EnrollNumber, Attendence_Machines_LOG.InOutMode, Employee.NAME, CONVERT (varchar, Attendence_Machines_LOG.A_Date, 103) AS A_Date, Attendence_Machines_LOG.A_Time, Department.Dept_Name, SubDepartment.SubDept_Name FROM Department INNER JOIN Employee ON Department.Dept_ID = Employee.DeptID INNER JOIN SubDepartment ON Employee.SubDeptId = SubDepartment.SubDept_Id RIGHT OUTER JOIN Attendence_Machines_LOG ON Employee.Emp_No = Attendence_Machines_LOG.EnrollNumber WHERE (Attendence_Machines_LOG.Machine_IP = @Machine_IP) AND (Employee.EmpID LIKE @EmpID)" 
                        >
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lbl_IP" Name="Machine_IP" 
                                    PropertyName="Text" />
                                <asp:ControlParameter ControlID="HFD_emp_no" Name="EmpID" 
                                    PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID ="hf_Status" runat ="server" Value = "0" />
                    </td>
                </tr>
                <tr>
                    <td align="Center" width="33%">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td align="Center" width="33%">
                        &nbsp;</td>
                </tr>
            </table>
            </div>
            </asp:Panel>

            </td>
       
    </tr>



</table>
</asp:Content>

