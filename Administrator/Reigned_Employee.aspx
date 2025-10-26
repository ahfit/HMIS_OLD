<%@ page language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Administrator_Reigned_Employee, App_Web_0xn5azrs" title="Untitled Page" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .tableWidth{width:100%}
         .tdalign{text-align:right}       
    .bxmain
    {
        
        width:100%;
    }
    
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain">
<table class="tableWidth">
    <tr>
        <td align ="right">Hospital</td>
        <td><asp:DropDownList ID="ddlHospital" runat = "server" DataSourceID="sdsHospital" DataTextField="Hospital_Name" 
           DataValueField="Hospital_ID" AutoPostBack="True" Width="262px"></asp:DropDownList></td>
        <asp:SqlDataSource ID ="sdsHospital" runat="server"  ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
        
        SelectCommand="SELECT 0 as [Hospital_ID] , 'all' as [Hospital_Name] union SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"
        
        ></asp:SqlDataSource>
        </tr>
        <tr>
        
        <td class ="tdalign">
            
            Department:
        </td>
        <td>
            <asp:DropDownList ID="ddlDept" runat= "server" DataSourceID="sdsDept" 
                DataTextField="Dept_Name" DataValueField="Dept_ID" AutoPostBack="true"></asp:DropDownList>
            <asp:SqlDataSource ID="sdsDept" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                SelectCommand="SELECT     0 as Dept_ID, ' All ' as Dept_Name, 0 as Hospital_ID union SELECT     Department.Dept_ID, Department.Dept_Name, Department.Hospital_ID
                                FROM         Department INNER JOIN
                                Hospital ON Department.Hospital_ID = Hospital.Hospital_ID
                                WHERE     (@Hospital_ID=0 or Department.Hospital_ID = @Hospital_ID) order by Dept_Name">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class ="tdalign">
               Sub Department: 
        </td>
        <td>
              <asp:DropDownList ID ="ddlSubDept" runat="server" DataSourceID="sdsSubDept" 
                  DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                  AutoPostBack="True"></asp:DropDownList>
              <asp:SqlDataSource ID="sdsSubDept" runat ="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                SelectCommand="SELECT 0 as SubDept_Id, ' All 'SubDept_Name union SELECT  SubDepartment.SubDept_Id, SubDepartment.SubDept_Name
                               FROM   SubDepartment INNER JOIN Department 
                               ON SubDepartment.Dept_Id = Department.Dept_ID
                               WHERE     ( @Dept_Id=0 or SubDepartment.Dept_Id =@Dept_Id)
                               and   (@Hospital_ID=0 or Department.Hospital_ID = @Hospital_ID) 
                                order by SubDept_Name">
                  <SelectParameters>
                      <asp:ControlParameter ControlID="ddlDept" Name="Dept_Id" 
                          PropertyName="SelectedValue" />
                      <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                          PropertyName="SelectedValue" />
                  </SelectParameters>
              </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class ="tdalign">
               Employee No.</td>
        <td>
              <asp:TextBox ID="TextBox_EmpID" runat="server" AutoPostBack="True"></asp:TextBox>
        </td>
    </tr>
  
    
    <tr>
        <td class ="tdalign">
               <%--Login Name:--%>
               Employee Name :</td>
        <td>
              <asp:TextBox ID="TextBox_EmpName" runat="server" AutoPostBack="True"></asp:TextBox>
              <asp:DropDownList ID ="ddlLoginName" runat="server" DataSourceID="sdsLoginName" 
                  DataTextField="UserName" DataValueField="EmpID" AutoPostBack="True" Visible="false"></asp:DropDownList>
              <asp:SqlDataSource ID="sdsLoginName" runat="server" 
                  ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" SelectCommand="SELECT Login.UserName, Employee.EmpID, Employee.SubDeptId FROM Login INNER JOIN Employee ON Login.EmpID = Employee.EmpID WHERE (Employee.SubDeptId = @SubDeptId)"
                                        
              >
                  <SelectParameters>
                      <asp:ControlParameter ControlID="ddlSubDept" Name="SubDeptId" 
                          PropertyName="SelectedValue" />
                  </SelectParameters>
              </asp:SqlDataSource>
              <asp:Label ID="lblFirstName" runat="server" Text=""></asp:Label>
              <asp:Label ID="lblMiddleName" runat="server" Text=""></asp:Label>
              <asp:Label ID="lblLastName" runat="server" Text=""></asp:Label>
        </td>
    </tr>
  
    
    <tr>
        <td>
        
        </td>
        <td>
            <asp:Button ID="btn_export" runat="server" Text="Export" />
        </td>
    
    </tr>
    <tr>
        <td colspan="2">
          
        </td>
        
    </tr>

</table>


<table  class="tableWidth">
    <tr>
        <td colspan="2">
              <asp:GridView ID="GridView1" runat="server" DataSourceID="sqlDs_EmployeeList"
          AutoGenerateColumns="False" Width="100%" PageSize="50" >
        <Columns>
        <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton Enabled="false" ID="lnkBtnActivateDeactivate" OnClick="lnkBtnActivateDeactivate_Click" 
                        runat="Server" Text='<%# Eval("ActiveStatus") %>' CommandArgument='<%# Eval("EmpID") %>'
                    ></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" Visible="true" />
            <asp:BoundField DataField="Emp_No" HeaderText="EmpNo" Visible="true" />
            
            <asp:BoundField DataField="EFName" HeaderText="Emp Name" />
            <asp:BoundField DataField="EMName" HeaderText="Middle Name" Visible="false"/>
            <asp:BoundField DataField="ELName" HeaderText="Last Name"  Visible="false"/>
            <asp:BoundField DataField="Dept_Name" HeaderText="Dept Name" Visible="true" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="SubDept Name" Visible="true" />
            <asp:BoundField DataField="UserName" HeaderText="User Name" />
            <asp:BoundField DataField="Prefix" HeaderText="Title" Visible="false" />
            
            <asp:BoundField DataField="JoinDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Joining Date" />
            <asp:BoundField DataField="RsgnDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Resign Date" />
            <asp:BoundField DataField="CNIC" HeaderText="C.N.I.C"  Visible="false"/>
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />
            <asp:BoundField DataField="HPhoneNo" HeaderText="Home Phone" Visible="false"/>
            <asp:BoundField DataField="OphoneNo" HeaderText="Office Phone" Visible="false"/>
            <asp:BoundField DataField="OfficeAdd" HeaderText="Office Address" Visible="false"/>
            <asp:BoundField DataField="HomeAdd" HeaderText="Home Address" Visible="false"/>
            <asp:CheckBoxField DataField="ActiveStatus" ReadOnly="true" HeaderText="Active" Visible="false"/>
        </Columns>
    </asp:GridView>
    
    <asp:SqlDataSource 
        ID="sqlDs_EmployeeList" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
        SelectCommand="usp_Get_Reigned_EmployeeList" 
        SelectCommandType="StoredProcedure"
        UpdateCommand="usp_UpdateEmployeeActiveStatus"
        UpdateCommandType="StoredProcedure" CancelSelectOnNullParameter="False"
        >
        
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlSubDept" Name="SubDeptId" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddlDept" Name="DeptID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddlHospital" Name="hospitalID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_EmpName" Name="Emp_Name" 
                PropertyName="Text" Type="String" DefaultValue="%" />
            <asp:ControlParameter ControlID="TextBox_EmpID" Name="empID" 
                PropertyName="Text" Type="Int32" />
        </SelectParameters>
        
        <UpdateParameters>
            <asp:ControlParameter ControlID="hf_emp_id" DefaultValue="0" Name="EmpID" 
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HF_Status" DefaultValue="1" Name="Status" 
                PropertyName="Value" Type="Boolean" />
            <asp:SessionParameter DefaultValue="" Name="ByEmp_ID" SessionField="emp_id" 
                Type="String" />
        </UpdateParameters>
        
    </asp:SqlDataSource>
    <asp:HiddenField runat="server" id = "hf_emp_id"></asp:HiddenField>
    <asp:HiddenField runat="server" id = "HF_Status"></asp:HiddenField>
        </td>
    </tr>

</table>
    </div>

</asp:Content>

