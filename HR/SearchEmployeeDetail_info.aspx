<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="SearchEmployeeDetail_info.aspx.vb" Inherits="HR_SearchEmployeeDetail_info" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    


      <script type="text/javascript">
        function ValidateAlpha(evt) {
            var keyCode = (evt.which) ? evt.which : evt.keyCode
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32)

                return false;
            return true;
        }

        function isNumberKey(evt) {
            FormatMobileNumber();
            var charCode = (evt.which) ? evt.which : evt.keyCode
            return !(charCode > 31 && (charCode < 48 || charCode > 57));

        }



    </script>
    <script type="text/javascript">

        function FormatMobileNumber() {
             var txt = document.getElementById("<%=TextBox_Phone.ClientID%>");
            
            if (txt.value.length == 4)
            {
                txt.value = txt.value + "-";
            }
            

        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    

<%--    <script src="validate.js" type="text/javascript"></script>

 
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment" Visible="False"></asp:Label>
 <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label>
<div class="bxmain inner_content" style="width:100%;padding-right: 4em;">
    <div class="heading" style="margin-right: -4em;"><h2 style="font-family: unset; margin-left: 1em; font-weight: 900;"><span>Employee Search Detail Info</span></h2>
        </div>--%>
    <script src="validate.js" type="text/javascript"></script>
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" >
 </asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment" Visible="False"></asp:Label>
 <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label>
<div class="bxmain">
 <div class="bxmain inner_content" >
 <h2><span>Employee Search Detail Infos</span> </h2>

<table class="table" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right">Hospital:</td>

   <td><asp:DropDownList ID="ddlHospital" runat="server" CssClass="dropbox" 
           Width="262px" DataSourceID="sdsHospital" DataTextField="Hospital_Name" 
           DataValueField="Hospital_ID" AutoPostBack="True" ></asp:DropDownList>
    <asp:SqlDataSource ID="sdsHospital" runat="server" 
           ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
           SelectCommand=" SELECT distinct    Hospital.Hospital_ID, Hospital.Hospital_Name
FROM         Hospital">
        <SelectParameters>
            <asp:SessionParameter Name="Admin_ID" SessionField="emp_id" />
        </SelectParameters>
       </asp:SqlDataSource>
   </td>
        <td align="right">Employee Name :</td>
    <td><asp:TextBox ID="TextBox_Employee_name" Style=" width: 260px; height: 25px;"
         runat="server"   onkeypress="return ValidateAlpha(event)"></asp:TextBox></td>
  </tr>
    
  <tr>

    <td align="right" >Department : </td>
    <td> <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
					 DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID"  CssClass="dropbox" Width="262px" 
            AutoPostBack="True" >
        </asp:DropDownList></td>
       <td align="right">CNIC&nbsp;#&nbsp;: </td>
    <td>
        <igtxt:webmaskedit id="TextBox_CNIC" Style=" width: 260px; height: 25px;" 
            runat="server" inputmask="#####-#######-#" CssClass="input_txt"></igtxt:webmaskedit>
       <%-- <asp:TextBox ID="TextBox_CNIC" runat="server" CssClass="input_txt" Width="248px"/>
        --%>
        </td>
  </tr>
    <tr>
    <td align="right" >Designation :  </td>
    <td><asp:DropDownList ID="ddl_DesgMain" runat="server"
                      CssClass="dropbox" DataSourceID="SqlDataSource_desgMain" DataTextField="MainDesignationName"
                      DataValueField="MainDesignation_ID" TabIndex="5" Width="262px"
          AutoPostBack="true" OnSelectedIndexChanged="ddl_DesgMain_SelectedIndexChanged"> 
        </asp:DropDownList></td>
         <td align="right">Mobile : </td>
    <td>
        <asp:TextBox ID="TextBox_Phone" runat="server" Style=" width: 260px; height: 25px;"
             CssClass="input_txt" Width="248px"  MaxLength="12" onkeypress="return isNumberKey(event)" ></asp:TextBox>
        </td>
  </tr>
  <tr>
    <td align="right" >Sub Designation :  </td>
    <td><asp:DropDownList ID="DropDownList_desg" runat="server"
                      CssClass="dropbox" DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                      DataValueField="Designation_ID" TabIndex="5" Width="262px" >
        </asp:DropDownList></td>

       <td align="right">Joining Date : </td>
    <td>
        <igsch:webdatechooser id="wdc_JoiningDate" runat="server" width="210px">
               <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
        </igsch:webdatechooser>  
        <%--<asp:TextBox ID="TextBox_JoiningDate" Style=" width: 260px; height: 25px;" runat="server" CssClass="input_txt" Width="248px" TextMode="Date"></asp:TextBox>--%>
        </td>
  </tr>
  
 
  
  <tr style="display:none">
    <td align="right">Emp No :</td>
    <td>
        <asp:TextBox ID="TextBox_Employee_EmpNO" Style=" width: 260px; height: 25px;" runat="server"  ></asp:TextBox>
        
        
        </td>
  </tr>
  <tr>
    <td align="right">Employee Type :</td>
    <td>
        <asp:RadioButtonList ID="RBL_Employee_Type" runat="server" 
            DataSourceID="SqlDataSource_Emp_Type" DataTextField="Type" 
            DataValueField="Employee_Type_ID" RepeatDirection="Horizontal">
        </asp:RadioButtonList>
      </td>
      <td>&nbsp;</td>
        <td>&nbsp;</td>
  </tr>

    
  

  
  <tr>
       
    <td align="right" > 
        <asp:HyperLink ID="hp_EmpList" Visible="false" Style=" text-decoration:none;   margin-right: -19em; padding: 4px 1em;" runat ="server" NavigateUrl="~/hr/EmployeeList.aspx" Target ="_blank"  CssClass="btn_hacims">Employee Status</asp:HyperLink> 
    <%--<asp:HyperLink ID="HyperLink1" runat ="server" NavigateUrl="~/hr/EmployeeTypeList.aspx" Target ="_blank"  CssClass="btn_hacims">Search by Joining date</asp:HyperLink>--%>
  </td>
      <td> &nbsp; <asp:HyperLink ID="HyperLink2" Visible="false" Style="text-decoration:none; margin-left: 19em;padding: 4px 1em;"  runat ="server" NavigateUrl="~/hr/ContractExpiryDetail.aspx" Target ="_blank"  CssClass="btn_hacims">EmpContract Detail</asp:HyperLink>
    
    
    </td>
     
    <td><asp:Button ID="Button_Search" Style="    margin-left: -15em;"  runat="server"  Text="Search" />
        </td><td>    <asp:Button ID="btn_export" Style="    margin-left: -17em;"  runat="server" Text="Export" />
              &nbsp;  <asp:Label ID="Label1" runat="server"></asp:Label>
       
      </td>
  </tr>

</table>
</div>
</div>

<br />
    <div style="width:100%; overflow-y:scroll">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" 
        CssClass="Grid_1" Width="100%" DataKeyNames="EmpID" 
        Height="98px"  PageSize="50" AllowSorting="false" EnableModelValidation="True"
        OnDataBound="GridView1_DataBound" ShowHeader="true"  HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Larger" >
        <Columns>
            <asp:TemplateField HeaderText="Sr#.">
     <itemtemplate>
          <%#Container.DataItemIndex + 1 %>                                                    
     </itemtemplate>
</asp:TemplateField>
               <%-- <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Certification.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID" HeaderText="Ac. Improvement" Target="_blank" 
                Text="certification" />
--%>



             <%--  <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Promotion_track.aspx?empid={0}" 
               DataNavigateUrlFields="EmpID" HeaderText="Promotion Track" Target="_blank" Text="edit" />--%>

<%--            <asp:TemplateField  HeaderText="#">
                     <ItemTemplate>
                 <%# Container.DataItemIndex + 1 %>   
                         <asp:HiddenField ID="HiddenField_EmpId" runat="server" 
                             Value='<%# Eval("EmpID") %>' />
         </ItemTemplate>

            </asp:TemplateField>

            <asp:BoundField DataField="Empid" HeaderText="Emp ID" SortExpression="Empid" />

             <asp:BoundField DataField="Emp_No" HeaderText="Emp No" Visible="false" />
            <asp:ButtonField CommandName="Select" DataTextField="EmployeeName" HeaderText="Emp Name" Visible="false"  SortExpression="EmployeeName"  />

            <asp:ButtonField  DataTextField="EmployeeName" HeaderText="Employee Name" Visible="true" SortExpression="EmployeeName" />
            
            <asp:BoundField DataField="FatherName" HeaderText="Father Name" SortExpression="FatherName" Visible="true" />
             <asp:BoundField DataField="Mobile_Number" HeaderText="Mobile No" SortExpression="Mobile_Number" />
            <asp:BoundField DataField="EmgMobileNo" HeaderText="Emergency Mobile No" SortExpression="EmgMobileNo" />
            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
            <asp:BoundField DataField="DateOfBirth" HeaderText="Date Of Birth" SortExpression="DateOfBirth" />
            <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
             <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name"/>
            <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
            <asp:BoundField DataField="DegreeName" HeaderText="Degree Name" SortExpression="DegreeName" />
            <asp:BoundField DataField="ContractDate" HeaderText="Contract start Date" SortExpression="ContractDate" />
            <asp:BoundField DataField="ContractExpDate" HeaderText="Contract End Date" SortExpression="ContractExpDate" />
            <asp:BoundField DataField="EOBI" HeaderText="EOBI #" SortExpression="EOBI" />
            <asp:BoundField DataField="SESSI" HeaderText="SESSI #" SortExpression="SESSI" />
            <asp:BoundField DataField="Insuranceplans" HeaderText="Insurance Plans" SortExpression="Insuranceplans" />
            <asp:BoundField DataField="YearofExperienceintki" HeaderText="Experience In TKI" SortExpression="YearofExperienceintki" />
           <asp:BoundField DataField="ExperienceOutsideTKI" HeaderText="Experience Outside TKI" SortExpression="ExperienceOutsideTKI" />
            <asp:BoundField DataField="TotalExperience" HeaderText="Total Experience(InOut TKI)" SortExpression="TotalExperience" />
             <asp:BoundField DataField="RotationType" HeaderText="Employee Type" SortExpression="RotationType" />
            <asp:BoundField DataField="ReportingTo" HeaderText="Reporting To HOD" SortExpression="ReportingTo" />
            <asp:BoundField DataField="CurrentSalary" HeaderText="Current Salary" SortExpression="CurrentSalary" />
            <asp:BoundField DataField="CopletionDate" HeaderText="Completion Date" SortExpression="CopletionDate" />
            <asp:BoundField DataField="Account_Number" HeaderText="Account Number" SortExpression="Account_Number" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" Visible="false"/>
             <asp:BoundField DataField="SubDept_Name" HeaderText="SubDepartment" Visible="false" />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" Visible="false" />
            <asp:BoundField DataField="Entry_Date" HeaderText="Employee Entry Date" SortExpression="Entry_Date" Visible="false"/>  
             <asp:BoundField DataField="ActiveStatus" HeaderText="Status" Visible="false"/>--%>

           <%--<%-- <asp:TemplateField HeaderText="Education" Visible="false">
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

              <asp:TemplateField HeaderText="Delete" Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandArgument='<%#Container.DataItem("EMPId")%>' 
                        CommandName="DelEmployee" Text="Delete" 
                        onclientclick="return confirmation(this)" onclick="LinkButton1_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            --%>
           
               

  
               


        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <PagerStyle CssClass="GridPager" />
    </asp:GridView>
    </div>
    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
     <asp:SqlDataSource ID="SqlDataSource_desgMain" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        
        
        SelectCommand="select 0 as MainDesignation_ID,'--ALL--' as MainDesignationName union   select MainDesignation_ID,MainDesignationName from Main_Designation">
        <SelectParameters>
          <%--  <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_Id" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" />--%>
            
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"  
        SelectCommand="select  0 as Designation_ID, '--ALL--' as Designation_Name , 0 as Designation_Main_Id  union 
                SELECT   distinct    Designation.Designation_ID, Designation.Designation_Name,Designation.Designation_Main_Id
                FROM   Designation where (Designation_Main_Id= @Designation_Main_Id or @Designation_Main_Id=0)" >
        
       <%-- SelectCommand="select  0 as Designation_ID, '---ALL---' as Designation_Name union 
SELECT   distinct    Designation.Designation_ID, Designation.Designation_Name
FROM       Employee INNER JOIN
                     
                      Department ON Employee.DeptID = Department.Dept_ID inner join
                      Designation ON Employee.DesignationID = Designation.Designation_ID
WHERE    (Employee.DeptID=@Dept_Id or  @Dept_Id=0) and (Department.Hospital_ID = @Hospital_ID or @Hospital_ID = 0)"--%>
       
        <%--<SelectParameters>
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_Id" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" />
            
        </SelectParameters>--%>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_DesgMain" Name="Designation_Main_Id" 
                PropertyName="SelectedValue" />
            
            
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>">
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
        SelectCommand="Select 0 as Employee_Type_ID,'All' as Type from Employee_Type union SELECT Employee_Type_ID, Type FROM Employee_Type where (Employee_Type.Is_Deleted is Null)">
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