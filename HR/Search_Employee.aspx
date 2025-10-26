<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Search_Employee, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
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
<div class="bxmain inner_content">

      <div class="bxmain inner_content" style="text-align:left; width:100%;background-color:transparent; border:none; font-weight:bold;">
<h2><span>Search Employee</span> </h2>
</div>

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
                      DataValueField="Dept_ID" TabIndex="5" CssClass="dropbox" Width="262px" >
        </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right" >Designation :  </td>
    <td><asp:DropDownList ID="DropDownList_desg" runat="server"
                      CssClass="dropbox" DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                      DataValueField="Designation_ID" TabIndex="5" Width="262px" >
        </asp:DropDownList></td>
  </tr>
  
  <tr>
    <td align="right">Employee Name : </td>
    <td><asp:TextBox ID="TextBox_Employee_name" runat="server"  Width="248px"></asp:TextBox></td>
  </tr>
  
  <tr>
    <td align="right">CNIC # : </td>
    <td><igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#" CssClass="input_txt" Width="248px"></igtxt:webmaskedit></td>
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
    <td> </td>
    <td><asp:Button ID="Button_Search" runat="server"  Text="Search" />
        <asp:Label ID="Label1" runat="server"></asp:Label>
      </td>
  </tr>

</table>
</div>


<br />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CssClass="Grid_1" Width="100%" AllowPaging="True" DataKeyNames="EmpID" 
        Height="98px" AllowSorting="True" PageSize="50" EnableModelValidation="True">
        <Columns>
            <asp:TemplateField  HeaderText="#">
                     <ItemTemplate>
                 <%# Container.DataItemIndex + 1 %>   
                         <asp:HiddenField ID="HiddenField_EmpId" runat="server" 
                             Value='<%# Eval("EmpID") %>' />
         </ItemTemplate>

            </asp:TemplateField>
            <asp:ButtonField CommandName="Select" DataTextField="EmployeeName" HeaderText="Employee Name" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="~/hr/convert.aspx?Enter_emp_ID={0}"
                DataTextField="EmployeeName" HeaderText="Employee Name" Visible="False" />
            <asp:BoundField DataField="RelationName" HeaderText="RelationName"  />  
            <asp:BoundField DataField="CNIC" HeaderText="CNIC"  />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date"  />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />
            <asp:BoundField DataField="Dept_Name" HeaderText="Department" />
            <asp:TemplateField HeaderText="Education">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton_Education" runat="server" 
                        onclick="LinkButton_Education_Click">Education</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Certifications">
                <ItemTemplate>
                                       <asp:LinkButton ID="LinkButton_Certification" runat="server" 
                        onclick="LinkButton_Certification_Click">Certifications</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Skills">
                <ItemTemplate>

                    <asp:LinkButton ID="LinkButton_Skill" runat="server" 
                        onclick="LinkButton_Skill_Click">Skills</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Additional Info">
                <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_AdditionalInfo" runat="server" 
                        onclick="LinkButton_AdditionalInfo_Click">Additional Info</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Relationship">
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
            <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandArgument='<%#Container.DataItem("EMPId")%>' 
                        CommandName="DelEmployee" Text="Delete" 
                        onclientclick="return confirmation(this)" onclick="LinkButton1_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkViewDetail" runat="server" CommandArgument='<%# Eval("EmpID") %>'
                        OnClick="lnkViewDetail_Click" Visible="False">View Detail</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <PagerStyle CssClass="GridPager" />
    </asp:GridView>

    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT 0 AS [Designation_ID], ' ---ALL---' AS [Designation_Name] UNION 
SELECT [Designation_ID], [Designation_Name] FROM [Designation]
                      where Designation_ID in(select Desig_ID from AssignedEmployee where Admin_ID=@emp_id)
                      order by [Designation_Name]">
        <SelectParameters>
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="usp_selectDepartment" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" Type="Int32" />
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
<br />
<br />


 


 </asp:Content>