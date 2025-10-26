<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_HR_Assign_Employee, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <style type="text/css">
   .style1
        {
            text-align: right;
            font-weight: bold;
            font-size: 11px;
            width: 80px;
        }
   </style>

    <div class="bxmain inner_content" style="text-align:left; width:100%;color:#f67f2e; background-color:transparent; border:none; font-weight:bold;">
<h3><span>HR Assign Empoyee </span> </h3> </div>
    <table class="diagnosis_list">
        <tr>
            <td align="Right" width="49%">
                Admin Employee</td>
            <td width="2%">
                :</td>
            <td width="49%">
                <asp:DropDownList ID="DropDownList_Admin_EMP" runat="server" 
                    DataSourceID="SqlDataSource_admin" DataTextField="EFName" 
                    DataValueField="EmpID" AutoPostBack="True" >
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_admin" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    SelectCommand="SELECT     Employee.EmpID, Employee.EFName
FROM         Employee INNER JOIN
                      Department ON Employee.DeptID = Department.Dept_ID
WHERE     (Employee.DeptID = '149')">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="Right">
                Department</td>
            <td>
                :</td>
            <td>
                <asp:DropDownList ID="DropDownList_Dept" runat="server" 
                    DataSourceID="SqlDataSource_dept" DataTextField="Dept_Name" 
                    DataValueField="Dept_ID" AutoPostBack="True">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_dept" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    SelectCommand="select 0 as Dept_ID,'---ALL---' as Dept_Name union select Dept_ID,Dept_Name from Department"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="Right">
                Designation</td>
            <td>
                :</td>
            <td>
                <asp:DropDownList ID="DropDownList_Desig" runat="server" 
                    DataSourceID="SqlDataSource_desig" DataTextField="Designation_Name" 
                    DataValueField="Designation_ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_desig" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    SelectCommand="select 0 as Designation_ID, '---ALL---' as Designation_Name union 
SELECT   Designation.Designation_ID  ,Designation.Designation_Name
FROM         Employee INNER JOIN
                      Designation ON Employee.DesignationID = Designation.Designation_ID
WHERE     (@DeptID = 0 or Employee.DeptID = @DeptID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList_Dept" Name="DeptID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="Right">
                EmpNO</td>
            <td>
                :</td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server" AutoPostBack="True"></asp:TextBox>
                <asp:HiddenField ID="HiddenField1" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="Right">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="Btn_Search" runat="server" Text="Search" 
                    onclick="Btn_Search_Click" />
                <asp:Button ID="Btn_Save" runat="server" Text="Insert" 
                    onclick="Btn_Save_Click" />
            </td>
        </tr>
        <tr>
            <td align="Right">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        
        <tr>
            
            <td align="Right" colspan="3">
           
                <table width="100%">

                <tr><td width="50%">
                    <div align="left" class="bxmain_1" 
                        style="margin-bottom:10px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: normal; font-style: oblique; font-variant: normal; text-transform: none; color: #000000;" 
                        width="100%">
                        <h1>
                            <strong>Select Employees </strong>
                        </h1>
                    </div>
                    </td>
                
                
                
         
                <tr><td width="50%">
                 
                <asp:GridView ID="GridView_Slect_emp" runat="server" 
                    DataSourceID="SqlDataSource1" EnableModelValidation="True" 
                    AutoGenerateColumns="False" DataKeyNames="EmpID">
                     <Columns><asp:TemplateField HeaderText="Sr#">
      <ItemTemplate>
         <%# Container.DataItemIndex + 1 %>
      </ItemTemplate>
  </asp:TemplateField>
</Columns>
                    <Columns>

                        <asp:BoundField DataField="EmpID" HeaderText="EmpID" ReadOnly="True" 
                            SortExpression="EmpID" />
                        <asp:BoundField DataField="EFName" HeaderText="EFName" 
                            SortExpression="EFName" />
                        <asp:BoundField DataField="EMName" HeaderText="EMName" 
                            SortExpression="EMName" Visible="False" />
                        <asp:BoundField DataField="ELName" HeaderText="ELName" 
                            SortExpression="ELName" Visible="False" />
                        <asp:BoundField DataField="JoinDate" HeaderText="JoinDate" 
                            SortExpression="JoinDate" />
                        <asp:BoundField DataField="Dept_Name" HeaderText="Dept_Name" 
                            SortExpression="Dept_Name" />
                        <asp:BoundField DataField="Designation_Name" HeaderText="Designation_Name" 
                            SortExpression="Designation_Name" />
                        <asp:TemplateField HeaderText="Check">
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenField_EMPID" runat="server" 
                                    Value='<%# Eval("EmpID") %>' />
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                            </EditItemTemplate>
                            <HeaderTemplate>
                                <asp:CheckBox ID="CheckBox2" runat="server" 
                                    oncheckedchanged="CheckBox2_CheckedChanged" AutoPostBack="True" />
                            </HeaderTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView></td>
                
                
                
            
                <td width="50%" align="left" valign="top">
                
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="Ass_EMPID" DataSourceID="SqlDataSource2" 
                    EnableModelValidation="True">
                    <Columns>
                     <asp:TemplateField HeaderText="Sr#">
      <ItemTemplate>
         <%# Container.DataItemIndex + 1 %>
      </ItemTemplate>
  </asp:TemplateField>
</Columns>
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="Admin_ID" HeaderText="Admin Name" 
                            SortExpression="Admin_ID" />
                        <asp:BoundField DataField="Expr1" HeaderText="Emp Name" ReadOnly="True" 
                            SortExpression="Expr1" />
                        <asp:BoundField DataField="DeptID" HeaderText="DeptID" SortExpression="DeptID" 
                            Visible="False" />
                        <asp:BoundField DataField="DesignationID" HeaderText="DesignationID" 
                            SortExpression="DesignationID" Visible="False" />
                        <asp:BoundField DataField="Dept_Name" HeaderText="Department Name" 
                            SortExpression="Dept_Name" />
                        <asp:BoundField DataField="Designation_Name" HeaderText="Designation Name" 
                            SortExpression="Designation_Name" />
                        <asp:BoundField DataField="Ass_EMPID" HeaderText="Ass_EMPID" 
                            SortExpression="Ass_EMPID" Visible="False" />
                    </Columns>
                </asp:GridView></td></tr>
                </table>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                    DeleteCommand="DELETE FROM AssignedEMPLoYEE WHERE (Ass_EMPID = @Ass_EMPID)" 
                    ProviderName="<%$ ConnectionStrings:HRConnectionString.ProviderName %>" 
                    
                    SelectCommand="SELECT ISNULL(Employee.EFName, '') + '' + ISNULL(Employee.EMName, '') + '' + ISNULL(Employee.ELName, '') AS Expr1, Employee.DeptID, Employee.DesignationID, Designation.Designation_Name, Department.Dept_Name, AssignedEMPLoYEE.Ass_EMPID, Employee_1.EFName as admin_id FROM AssignedEMPLoYEE INNER JOIN Employee ON AssignedEMPLoYEE.Ass_EMPID = Employee.EmpID INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID INNER JOIN Employee AS Employee_1 ON AssignedEMPLoYEE.Admin_ID = Employee_1.EmpID WHERE (AssignedEMPLoYEE.Admin_ID = @Admin_ID)" 
                    ondeleted="SqlDataSource2_Deleted">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList_Admin_EMP" Name="Admin_ID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Update" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    
                    
                    
                    
                    ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" SelectCommand="SELECT     Employee.EmpID, Employee.EFName, Employee.EMName, Employee.ELName, Employee.JoinDate, Department.Dept_Name, Designation.Designation_Name
FROM         Employee INNER JOIN
                      Department ON Employee.DeptID = Department.Dept_ID INNER JOIN
                      Designation ON Employee.DesignationID = Designation.Designation_ID
WHERE     (Employee.EmpID like @EmpID)
 and (@Dept_ID =0 or  Department.Dept_ID = @Dept_ID)
 and (@Designation_ID =0 or Designation.Designation_ID=@Designation_ID) and (EmpID not in (select AE.Ass_EMPID from HR.dbo.[AssignedEMPLoYEE] as AE))" 
                    
                    
                    InsertCommand="INSERT INTO hr.dbo.[AssignedEMPLoYEE] (Admin_ID, Ass_EMPID) VALUES (@Admin_ID,@Ass_EMPID)">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="DropDownList_Admin_EMP" Name="Admin_ID" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HiddenField_Update" Name="Ass_EMPID" 
                            PropertyName="Value" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField1"  Name="EmpID" 
                            PropertyName="Value" DefaultValue="" />
                        <asp:ControlParameter ControlID="DropDownList_Dept" Name="Dept_ID" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList_Desig" Name="Designation_ID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

