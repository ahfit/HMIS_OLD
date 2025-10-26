<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Search_Employee_PayRoll" CodeFile="Search_Employee_PayRoll.aspx.vb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <style type="text/css">

     .tbl_pinfo td {
     font-weight:bold
     
     }
 </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <script src="validate.js" type="text/javascript"></script>

 
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment" Visible="False"></asp:Label>
 <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label>
<div style="width:100%" class="bxmain inner_content"><h2><span>Allowances and Deduction</span></h2>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_pinfo">
    <tr>
        <td align="right">
                    Hospital :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Hospital" runat="server" DataSourceID="SqlDataSource_Hospital"
                        DataTextField="Hospital_Name" DataValueField="Hospital_ID" AutoPostBack="True" Width="262px" 
                        onselectedindexchanged="DropDownList_Hospital_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT     Hospital_ID, Hospital_Name FROM         BasicDataInfo.dbo.Hospital">
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
    <td><asp:TextBox ID="TextBox_Employee_name" runat="server" Width="262px"></asp:TextBox></td>
  </tr>
  
  <tr>
    <td align="right">CNIC # : </td>
    <td><igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#" CssClass="input_txt" Width="262px"></igtxt:webmaskedit></td>
  </tr>
  
  <tr>
    <td align="right">Employee Type : </td>
    <td>
        <asp:RadioButtonList ID="RBL_Employee_Type" runat="server" 
             DataTextField="Type" 
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
        Height="98px" AllowSorting="True" PageSize="50">
        <Columns>
            <asp:TemplateField  HeaderText="#">
                     <ItemTemplate>
                 <%# Container.DataItemIndex + 1 %>   
                         <asp:HiddenField ID="HiddenField_EmpId" runat="server" 
                             Value='<%# Eval("EmpID") %>' />
         </ItemTemplate>

            </asp:TemplateField>
            <asp:ButtonField CommandName="Select" DataTextField="EmployeeName" HeaderText="Employee Name" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="~/hr/Employee_Basic_info_edit.aspx?Enter_emp_ID={0}"
                DataTextField="EmployeeName" HeaderText="Employee Name" Visible="False" />
            <asp:BoundField DataField="RelationName" HeaderText="RelationName"   />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC"   />
            <asp:BoundField DataField="Dept_Name" HeaderText="Department" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date"  />                        
            
            
             <asp:HyperLinkField DataNavigateUrlFields="EmpID,PayScale"
                 target="_blank" 
                DataNavigateUrlFormatString="../PayRoll/EmployeeAllowancesDeductionsSetup.aspx?EmpId={0}&amp;ScaleID={1}" 
                Text="Allowances &amp; Deductions" />

            <asp:HyperLinkField Visible="false" DataNavigateUrlFields="EmpID,PayScale" 
                DataNavigateUrlFormatString="../PayRoll/EmployeeIncrement.aspx?EmpId={0}&amp;ScaleID={1}" 
                Text="Increment" />

        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <PagerStyle CssClass="GridPager" />
    </asp:GridView>

    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation] order by Designation_Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] where @HospitalId  = 0  or Hospital_ID = @HospitalId ORDER BY [Dept_Name]">
        <SelectParameters>
             <asp:ControlParameter ControlID="DropDownList_Hospital" DefaultValue="0" 
                                Name="HospitalId" PropertyName="SelectedValue" />
        </SelectParameters>
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
<br />


 


 </asp:Content>