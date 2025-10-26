<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_ManageEmployeeDeptDesig, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script src="validate.js" type="text/javascript"></script>

 
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
 <asp:Label ID="LabelDoctorName"   runat="server" Visible="false" ></asp:Label>

    <asp:Label ID="Label_SubDepartment"  runat="server"  Visible="False"></asp:Label>
 <asp:Label ID="Label_Department" runat="server"  Visible="false" ></asp:Label>
 <div align="center" width="100%">

    <div class="bxmain inner_content" style="text-align:left; width:100%;color:#f67f2e; background-color:transparent; border:none; font-weight:bold;">
<h3><span>Manage Employee Department </span> </h3> </div>

<div class="bxmain inner_content">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" 
        align="center">


       <tr>
    <td align="right" width="40%">Hospital  : </td>
    <td width="60%"> <asp:DropDownList ID="DropdownlistHospital" runat="server"
					 DataSourceID="SqlDataSourceHospital" DataTextField="Hospital_Name"
                      DataValueField="Hospital_ID" TabIndex="5" CssClass="dropbox" 
            Width="262px" AutoPostBack="True" >
        </asp:DropDownList></td>
  </tr>


  <tr>
    <td align="right" width="40%">Department : </td>
    <td width="60%"> <asp:DropDownList ID="Dropdownlistdepartment" runat="server" Enabled="true"
					 DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID" TabIndex="5" CssClass="dropbox" 
            Width="262px" AutoPostBack="True" >
        </asp:DropDownList></td>
  </tr>







  <tr>
    <td align="right" >Designation :  </td>
    <td><asp:DropDownList ID="DropDownList_desg" runat="server"
                      CssClass="dropbox" DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                      DataValueField="Designation_ID" TabIndex="5" Width="262px" 
            AutoPostBack="True" >
        </asp:DropDownList></td>
  </tr>
  
  <tr>
    <td align="right">Employee Name : </td>
    <td><asp:TextBox ID="TextBox_Employee_name" runat="server"  Width="263px"></asp:TextBox></td>
  </tr>
  
  <tr>
    <td align="right">CNIC # : </td>
    <td><igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#" CssClass="input_txt" Width="263px"></igtxt:webmaskedit></td>
  </tr>
  
    <tr>
        <td align="right">
            Emp No :</td>
        <td>
            <asp:TextBox ID="TextBox_EmpNo" runat="server"></asp:TextBox>
        </td>
    </tr>
  
  <tr>
    <td align="right">Employee Type : </td>
    <td>
        <asp:RadioButtonList ID="RBL_Employee_Type" runat="server" 
            DataSourceID="SqlDataSource_Emp_Type" DataTextField="Type" 
            DataValueField="Employee_Type_ID" RepeatDirection="Horizontal">
        </asp:RadioButtonList>
      </td>
  </tr>
  
  <tr>
    <td align="right" > 
    
    </td>
    <td><asp:Button ID="Button_Search" runat="server"  Text="Search" />
        <asp:Label ID="Label1" runat="server"></asp:Label>
       
        <asp:Button ID="Button_exel" runat="server"  Text="Export to execl" />
       
      </td>
  </tr>

</table>
</div>

 </div>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
    <ProgressTemplate>s
        <asp:Image ID="Progress" runat="server" ImageUrl="~/images_hacims/Progress.gif" 
            Height="73px" Width="75px" />
    </ProgressTemplate>
        
    </asp:UpdateProgress>


<br />

    <asp:HiddenField ID="tempEmpID" runat="server" />

    <asp:HiddenField ID="tempEmpNo" runat="server" />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CssClass="Grid_1" Width="100%" AllowPaging="True" DataKeyNames="EmpID" 
        Height="98px"  PageSize="100" DataSourceID="SqlDataSourceGrid">
        <Columns>
            <asp:TemplateField  HeaderText="#">
                     <ItemTemplate>
                 <%# Container.DataItemIndex + 1 %>  
                         
                           <%--<asp:HiddenField ID="hf_HospitalID" runat="server" Value='<%#Eval("Hospital_ID")%>' />--%>
                         <asp:HiddenField ID="HiddenField_EmpId" runat="server"  Value='<%# Eval("EmpID") %>' />
                             <asp:HiddenField ID="hfld_DesigId" runat="server" Value='<%#Eval("DesignationID") %>' />
                             <asp:HiddenField ID="hfld_DeptID" runat="server"  Value='<%#Eval("DeptID") %>' />
                         
                             <asp:HiddenField ID="hfld_SubDeptId" runat="server" Value='<%#Eval("SubDeptId") %>' />
                             <asp:HiddenField ID="hf_DeptName" runat="server"  Value='<%#Eval("Dept_Name")%>' />
                             <asp:HiddenField ID="hf_subDeptName" runat="server"  Value='<%#Eval("SubDept_Name")%>' />

                             <asp:HiddenField ID="hf_SubDept" runat="server" Value='<%#Eval("SubDeptId") %>' />

                           
                             <asp:HiddenField ID="hfld_Shift_id" runat="server"   Value='<%# Eval("Shift_ID") %>' />
                         <asp:HiddenField ID="hf_Shift" runat="server"   Value='<%# Eval("Shift") %>' />

                         <asp:HiddenField ID="hf_EmpNo" runat="server"   Value='<%# Eval("Emp_No")%>' />
                             
         </ItemTemplate>
         </asp:TemplateField>
            <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName" 
                ReadOnly="True" SortExpression="EmployeeName" />
            <asp:BoundField DataField="RelationName" HeaderText="RelationName" 
                ReadOnly="True" SortExpression="RelationName" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" 
                ReadOnly="True" SortExpression="EmpID" />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" ReadOnly="True" 
                SortExpression="Join Date" />
            <asp:BoundField DataField="Min_PayScale" HeaderText="Min_PayScale" Visible="false"
                SortExpression="Min_PayScale" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation_Name" 
                SortExpression="Designation_Name" />
           
            
             <asp:BoundField DataField="Dept_Name" HeaderText="Dept_Name" ReadOnly="True" 
                SortExpression="Dept_Name" />
            <asp:BoundField DataField="Emp_No" Visible="false" HeaderText="Emp_No" 
                SortExpression="Emp_No" />



            <asp:BoundField DataField="DesignationID" Visible="false" HeaderText="DesignationID" 
                SortExpression="DesignationID" />
            <asp:BoundField DataField="DeptID" HeaderText="DeptID"  Visible="false"
                SortExpression="DeptID" />
            <asp:BoundField DataField="SubDeptId" HeaderText="SubDeptId" Visible="false" 
                SortExpression="SubDeptId" />
               



             
              <asp:TemplateField HeaderText="Shift Name">
                <ItemTemplate>

              <asp:DropDownList ID="ddl_shift" runat="server" width = "80px" 
                        DataSourceID="sqlDs_Shift" DataTextField="Shift" DataValueField="Shift_ID">
                    
                    </asp:DropDownList>
                     </ItemTemplate>
            </asp:TemplateField>
                
           
            <asp:TemplateField HeaderText="Emp No">
                <ItemTemplate>
                    <asp:TextBox ID="Txt_Emo_No" runat="server" width ="50px" 
                        Text='<%# Bind("Emp_No") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnSave" runat="server" Text="Change Department" OnClick="btnSaveEmployee_Click" 
                            CommandArgument='<%#Eval("EmpID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <PagerStyle CssClass="GridPager" />
    </asp:GridView>

    


    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT Designation_ID, Designation_Name FROM Designation">
        <SelectParameters>
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDs_Design" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand=" SELECT Designation_ID, Designation_Name FROM Designation">
            <SelectParameters>
                <asp:SessionParameter Name="emp_id" SessionField="emp_id" />
            </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
        SelectCommand="usp_SearchEmployee" SelectCommandType="StoredProcedure">
        <SelectParameters>

            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" 
                PropertyName="SelectedValue" Type="Int32" />

           
            <asp:ControlParameter ControlID="DropDownList_desg" Name="DesignationID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_CNIC" Name="CNIC" 
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="TextBox_Employee_name" Name="Name" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="RBL_Employee_Type" Name="Emp_Type" 
                PropertyName="SelectedValue" Type="String" />
               
            <asp:ControlParameter ControlID="TextBox_EmpNo" Name="Emp_No" 
                PropertyName="Text" Type="Int32" />
               
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
               
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     Department.Dept_Name + ' ( ' + Hospital.Hospital_Abb + ' ) ' Dept_Name, Department.Dept_ID 
FROM         Department Left Outer JOIN
                      Hospital ON Department.Hospital_ID = Hospital.Hospital_ID 
                          where  Department.Hospital_ID=@Hosp_ID                ">
          <SelectParameters>
            
            <asp:ControlParameter ControlID="DropdownlistHospital" Name="Hosp_ID" Type="Int32" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

      <asp:Panel ID="panel" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox"> 
            
           <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2> <span>Manage Department   </span></h2>
              
              
                  <table style="margin:10px; line-height:2">

                         <tr  >
                        <td >
                            <asp:Label ID="lblDept" runat="server"  Text="Deparment Name" ></asp:Label>
                        </td>
                    <td style="padding-left:25px"  >
                  <asp:Label ID="lblDeptName"  runat="server"></asp:Label>
                    </td>
                    </tr>
                       
                    <tr   > 
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Sub Department"></asp:Label>
                        </td>
                    <td style="padding-left:25px" >
                  <asp:Label ID="lblSubDep" Text="" runat="server"></asp:Label>
                    </td>
                    </tr> 

                    <tr > 
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Shift Name"></asp:Label>
                        </td>
                    <td style="padding-left:25px" >
                  <asp:Label ID="lblShift" Text="" runat="server"></asp:Label>
                    </td>
                    </tr>



                    <tr>
                        <td>
                            Department 
                        </td>
                         
                        <td style="padding-left:25px">
                        
                        <asp:DropDownList ID="ddlDepartment" runat="server" DataSourceID="sqlDs_Dept" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" 
                            DataTextField="Dept_Name" DataValueField="Dept_ID" AutoPostBack="True"  >
                            
                        </asp:DropDownList>  </td>  </tr> 
                       <tr>
                        <td>
                            Sub Department 
                        </td>
                      
                        <td style="padding-left:25px">
                                <asp:DropDownList ID="ddlsubDepartment" runat="server" DataSourceID="sqlDs_SubDept" 
                            DataTextField="SubDept_Name" DataValueField="SubDept_Id" >
                            
                        </asp:DropDownList>
                            </td>  </tr>
                       
                   
                    <tr>
                         <td>
                            Designation Name
                        </td>
                        <td style="padding-left:25px">
                              <asp:DropDownList ID="ddlDesig" runat="server" DataValueField="Designation_ID" 
                            DataTextField="Designation_Name" DataSourceID="sqlDs_Design" ></asp:DropDownList>
                        </td>
                    </tr>



                     <tr>
                         <td>
                           Shift Name
                        </td>
                        <td style="padding-left:25px">
                   
                    <asp:DropDownList ID="ddl_hfshift" runat="server" width = "80px" 
                        DataSourceID="sqlDs_Shift" DataTextField="Shift" DataValueField="Shift_ID">
                    
                    </asp:DropDownList>
                </td>
                    </tr>

                      <tr>
                        <td>
                            Reason 
                        </td>
                      
                        <td style="padding-left:25px">
                                <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Height="100"></asp:TextBox>
                            
                        
                            </td>  </tr>


                      <tr  >
                        <td >
                            <asp:Label ID="Label4" runat="server"  Text="Employee Number" ></asp:Label>
                        </td>
                    <td style="padding-left:25px"  >
                  <asp:Label ID="lbl_empNo"  runat="server"></asp:Label>
                    </td>
                    </tr>



                      <tr>

                     <td align="right">
                              <asp:Button ID="savebtnPanel" Text="Save" runat="server"  OnClick="savebtnPanel_Click" />
                          
                     
                            <asp:Label ID="lblSave" runat="server" ForeColor="Green" Text="Save Successfully..." Visible="false"></asp:Label>
                        
                     </td>
                          <td >

                          </td>

                          <td>
                              <asp:Button ID="closebtnPanel" Text="Close" runat="server" OnClick="closebtnPanel_Click" />
                          </td>


                      </tr>



                    </table>
                </div>
            </div>
            </asp:Panel>
                       

   <asp:SqlDataSource ID="SqlDataSourceHospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="select Hospital_ID, Hospital_Name from Hospital">
      
    </asp:SqlDataSource>
   


    <asp:SqlDataSource ID="sqlDs_Dept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="SELECT     Department.Dept_Name + ' ( ' + Hospital.Hospital_Abb + ' ) ' Dept_Name, Department.Dept_ID 
FROM         Department Left Outer JOIN
                      Hospital ON Department.Hospital_ID = Hospital.Hospital_ID ORDER BY [Dept_Name]">
        
    </asp:SqlDataSource>


       <asp:SqlDataSource ID="sqlDs_SubDept" runat="server"  ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="select SubDept_Id, SubDept_Name from SubDepartment where Dept_Id=@deptID">
        <SelectParameters>
            
            <asp:ControlParameter ControlID="ddlDepartment" Name="deptID" Type="Int32" PropertyName="SelectedValue" />
        </SelectParameters>
        
    </asp:SqlDataSource>





    <asp:SqlDataSource ID="SqlDataSource_Emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select 0 as Employee_Type_ID,'All' as Type from Employee_Type
union
SELECT Employee_Type_ID, Type FROM Employee_Type">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_BPS" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" SelectCommand="SELECT DISTINCT Min_PayScale FROM Designation"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpDelStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]" 
        UpdateCommand="UPDATE Employee SET Is_Deleted = 1 WHERE (EmpID = @EmpID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="EmpID" 
                PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
    <asp:SqlDataSource ID="sqlDs_Shift" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" 
        
        SelectCommand=" SELECT 0 as Shift_ID, '' as Shift union SELECT Shift_ID, Shift FROM Shift">
    </asp:SqlDataSource>
<br />
<br />
   <%-- update  hr.dbo.AssignedEmployee 
set Desig_Id=@DesignationID ,Dept_ID=@DeptID
WHERE (Ass_EMPID = @EmpID);

UPDATE    AssignedEmployee
SET              Hospital_ID = Department.Hospital_ID
FROM         AssignedEmployee INNER JOIN
                      Department ON AssignedEmployee.Dept_ID = Department.Dept_ID
                     WHERE (Ass_EMPID = @EmpID);--%>

 <asp:SqlDataSource ID="sqlDs_UpdateEmp" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
        ProviderName="<%$ ConnectionStrings:HRConnectionString.ProviderName %>"
        
      

     UpdateCommand="usp_UpdateEmployeeDepartment" UpdateCommandType="StoredProcedure">


        <UpdateParameters>
            <asp:Parameter Name="EmpID" />
            <asp:Parameter Name="DeptID" />
            <asp:Parameter Name="DesignationID" />
          
            <asp:Parameter Name="SubDeptId" />
            <asp:Parameter Name="Shift_Id" />
            <asp:SessionParameter Name="TransferId" SessionField="emp_id"/>
            <asp:ControlParameter ControlID="txtReason" Name="Reason" PropertyName="Text"/>
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>

