<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Employee_View_Designation_wise, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
 <script type="text/javascript">
		$(document).ready(main);
		function main()
		{
			$("#floatgrid").makeFloat({x:"current",y:"current"});
		}		
	</script>
 
 
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server" Visible="false"  Text="Label_SubDepartment"></asp:Label> <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label> 


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="30%" style="border-right:#CCC solid 1px;"> <asp:TreeView ID="TreeView1" runat="server"></asp:TreeView> </td>
    <td valign="top" width="70%"> 
    
    <div id="floatgrid">
    
    <div  style="margin-left:10px;"  > <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="EmpID"
            DataSourceID="SqlDataSource_Emp_Desg_Wise" Width="100%" >
            <Columns>
                <asp:ButtonField CommandName="Select" DataTextField="Employee Name" HeaderText="Employee Name" />
                <asp:BoundField DataField="Employee Name" HeaderText="Employee Name" ReadOnly="True"
                    SortExpression="Employee Name" />
                <asp:BoundField DataField="Date Of Birth" HeaderText="Date Of Birth" SortExpression="Date Of Birth" />
                <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
                <asp:BoundField DataField="JoinDate" HeaderText="Join Date" SortExpression="JoinDate" />
            </Columns>
        </asp:GridView></div>
      </div>  
        
        
        </td>
  </tr>
</table>



 
 
 
 
 
<asp:SqlDataSource ID="SqlDataSource_Emp_Desg_Wise" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT EmpID, ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name], CONVERT (varchar, DateOfBirth, 103) AS [Date Of Birth], CNIC, CONVERT (varchar,JoinDate,103) as JoinDate FROM Employee WHERE (DeptID = @Dept_ID) AND (DesignationID like @Designation_ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_Dept_ID" Name="Dept_ID" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Desg_ID" Name="Designation_ID" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
       
       
      
        <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
        <asp:HiddenField ID="HiddenField_Desg_ID" runat="server" />
        
<br />
        
        

  </asp:Content>