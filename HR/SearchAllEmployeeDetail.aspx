<%@ page title="" language="VB" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="false" inherits="HR_SearchAllEmployeeDetail, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <script src="validate.js" type="text/javascript"></script>

 
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment" Visible="False"></asp:Label>
 <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label>
<div class="bxmain">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right">Hospital:</td>

   <td><asp:DropDownList ID="ddlHospital" runat="server" CssClass="dropbox" 
           Width="262px" DataSourceID="sdsHospital" DataTextField="Hospital_Name" 
           DataValueField="Hospital_ID" AutoPostBack="True" ></asp:DropDownList>
    <asp:SqlDataSource ID="sdsHospital" runat="server" 
           ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
           SelectCommand="SELECT 0 AS Hospital_ID, 'ALL' AS Hospital_Name UNION 
 SELECT distinct    Hospital.Hospital_ID, Hospital.Hospital_Name
FROM         Hospital INNER JOIN
                      AssignedEmployee ON Hospital.Hospital_ID = AssignedEmployee.Hospital_ID
WHERE     (AssignedEmployee.Admin_ID = @Admin_ID)">
        <SelectParameters>
            <asp:SessionParameter Name="Admin_ID" SessionField="emp_id" />
        </SelectParameters>
       </asp:SqlDataSource>
   
   </td>
  </tr>
    
  <tr>

    <td align="right" width="40%">Department : </td>
    <td width="60%"> <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
					 DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID"  CssClass="dropbox" Width="262px" 
            AutoPostBack="True" >
        </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right" >Designation :  </td>
    <td><asp:DropDownList ID="DropDownList_desg" runat="server"
                      CssClass="dropbox" DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                      DataValueField="Designation_ID" TabIndex="5" Width="262px"  AutoPostBack="true">
        </asp:DropDownList></td>
  </tr>
  
  <tr>
    <td align="right">Employee Name : </td>
    <td><asp:TextBox ID="TextBox_Employee_name" runat="server"  Width="248px"></asp:TextBox></td>
  </tr>
  
  <tr>
    <td align="right">CNIC # : </td>
    <td>
        <igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#" CssClass="input_txt" Width="248px"></igtxt:webmaskedit>
       <%-- <asp:TextBox ID="TextBox_CNIC" runat="server" CssClass="input_txt" Width="248px"/>
        --%>
        
        
        </td>
  </tr>
  
  <tr>
    <td align="right">Emp No :</td>
    <td>
        <asp:TextBox ID="TextBox_Employee_EmpNO" runat="server"  Width="248px"></asp:TextBox>
        
        
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
    <td align="right" > <asp:HyperLink ID="hp_EmpList" runat ="server" NavigateUrl="~/hr/EmployeeList.aspx" Target ="_blank"  CssClass="btn_hacims">Employee Status</asp:HyperLink> 
    <%--<asp:HyperLink ID="HyperLink1" runat ="server" NavigateUrl="~/hr/EmployeeTypeList.aspx" Target ="_blank"  CssClass="btn_hacims">Search by Joining date</asp:HyperLink>--%>
    <asp:HyperLink ID="HyperLink2" runat ="server" NavigateUrl="~/hr/ContractExpiryDetail.aspx" Target ="_blank"  CssClass="btn_hacims">EmpContract Detail</asp:HyperLink>
    
    
    </td>
    <td><asp:Button ID="Button_Search" runat="server"  Text="Search" />
        &nbsp;
            <asp:Button ID="btn_export" runat="server" Text="Export" />
        <asp:Label ID="Label1" runat="server"></asp:Label>
       
      </td>
  </tr>

</table>
</div>


<br />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CssClass="Grid_1" Width="100%" DataKeyNames="EmpID" 
        Height="98px"  PageSize="50">
        <Columns>
            <asp:TemplateField  HeaderText="#">
                     <ItemTemplate>
                 <%# Container.DataItemIndex + 1 %>   
                         <asp:HiddenField ID="HiddenField_EmpId" runat="server" 
                             Value='<%# Eval("EmpID") %>' />
         </ItemTemplate>

            </asp:TemplateField>
            <asp:BoundField DataField="Empid" HeaderText="Emp ID" />
             <asp:BoundField DataField="Emp_No" HeaderText="Emp No" />
            <asp:ButtonField CommandName="Select" DataTextField="EmployeeName" HeaderText="Emp Name" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="~/hr/convert.aspx?Enter_emp_ID={0}"
                DataTextField="EmployeeName" HeaderText="Employee Name" Visible="False" />
            <asp:BoundField DataField="RelationName" HeaderText="RelationName" SortExpression="RelationName" Visible="false" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" Visible="false" />
            
            <asp:BoundField DataField="Dept_Name" HeaderText="Department" />
             <asp:BoundField DataField="SubDept_Name" HeaderText="SubDepartment" />
             <asp:BoundField DataField="Designation_Name" HeaderText="Designation"/>
            <asp:TemplateField HeaderText="Education" Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton_Education" runat="server" 
                        onclick="LinkButton_Education_Click" >Education</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Certifications" Visible="false">
                <ItemTemplate>
                                       <asp:LinkButton ID="LinkButton_Certification" runat="server" 
                        onclick="LinkButton_Certification_Click">Certifications</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Skills" Visible="false">
                <ItemTemplate>

                    <asp:LinkButton ID="LinkButton_Skill" runat="server" 
                        onclick="LinkButton_Skill_Click">Skills</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Additional Info" Visible="false">
                <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_AdditionalInfo" runat="server" 
                        onclick="LinkButton_AdditionalInfo_Click">Additional Info</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Relationship" Visible="false">
                <ItemTemplate>
                    
                    <asp:LinkButton ID="LinkButton_Relationship" runat="server" 
                        onclick="LinkButton_Relationship_Click">Relationship</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Documents" Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton_Documents" runat="server" 
                        onclick="LinkButton_Documents_Click">Documents</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Delete" Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandArgument='<%#Container.DataItem("EMPId")%>' 
                        CommandName="DelEmployee" Text="Delete" 
                        onclientclick="return confirmation(this)" onclick="LinkButton1_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkViewDetail" runat="server" CommandArgument='<%# Eval("EmpID") %>'
                        OnClick="lnkViewDetail_Click">View Detail</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnEmpBenifit" runat ="server" 
                        CommandArgument='<%#Eval("EmpID") %>' onclick="lbtnEmpBenifit_Click">Benifit</asp:LinkButton>
                </ItemTemplate>
            
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Card" Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnGenrateID" runat="server" 
                        CommandArgument='<%# Eval("empid") %>' onclick="lbtnGenrateID_Click">Genrate</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Employee_Confirmation.aspx?empid={0}" 
                HeaderText="Emp Confirmation " Target="_blank" Text="Confirmation" 
                DataNavigateUrlFields="EmpID" Visible="false" />

            <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Resignation.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID"  HeaderText="Resignation" Target="_blank" 
                Text="Resignation" Visible="false" />

            <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Employee_Contract.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID" HeaderText="Contract" Target="_blank" Text="Contract" Visible="false" />

                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Acadmic_improvement.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID" HeaderText="Ac.Improvement" Target="_blank" 
                Text="Ac.Improvement" Visible="false"
                 />
               <%-- <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Certification.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID" HeaderText="Ac. Improvement" Target="_blank" 
                Text="certification" />
--%>

               <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Professional_improvement.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID" HeaderText="Pro.Improvement" Target="_blank" 
                Text="Pro.Improvement" Visible="false" />



             <%--  <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Promotion_track.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID" HeaderText="Promotion Track" Target="_blank" Text="edit" />--%>

               <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/EmployeeJobHistory.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID" HeaderText="Job History" Target="_blank" Text="JOB History" />

               <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/EmployeeFileLabel.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID" HeaderText="File label" Target="_blank" Text="File Label"  Visible="false"/>

                 <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/EmployeeSummeryRpt.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID" HeaderText="Emp Summary" Target="_blank" Text="Emp Summery" />

                 
               


            <asp:HyperLinkField DataNavigateUrlFields="EmpID" 
                DataNavigateUrlFormatString="~/hr/HR_Performa.aspx?empid={0}" 
                HeaderText="Emp ACR" Target="_blank" Text="Emp ACR" />

                 
               


        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <PagerStyle CssClass="GridPager" />
    </asp:GridView>

    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        
        
        SelectCommand="select  0 as Designation_ID, '---ALL---' as Designation_Name union 
SELECT   distinct    Designation.Designation_ID, Designation.Designation_Name
FROM       AssignedEmployee INNER JOIN
                      Employee ON AssignedEmployee.Desig_ID = Employee.DesignationID LEFT OUTER JOIN
                      Department ON Employee.DeptID = Department.Dept_ID RIGHT OUTER JOIN
                      Designation ON Employee.DesignationID = Designation.Designation_ID
WHERE     (AssignedEmployee.Admin_ID = @Admin_ID) AND(Employee.DeptID=@Dept_Id or  @Dept_Id=0) and (Department.Hospital_ID = @Hospital_ID or @Hospital_ID = 0)">
        <SelectParameters>
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_Id" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" />
            <asp:SessionParameter Name="Admin_ID" SessionField="emp_Id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="usp_selectDepartment" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" />
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select 0 as Employee_Type_ID,'All' as Type from Employee_Type union SELECT Employee_Type_ID, Type FROM Employee_Type">
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
<br />
<br />


 


 </asp:Content>