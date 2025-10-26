<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Billing_UpdateConsultantServices, App_Web_asx2a3aw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



<script type ="text/javascript" >
function resetform() {document.form1.reset(); document.form1.TextBoxYearlyNo.focus(); }
function enablelist(a)
{
if(a.checked==true)
{
document.getElementById ("dropdownlistDiagnosis").disabled =false;
}
else
{
document.getElementById ("dropdownlistDiagnosis").disabled =true;
}

}
</script>

 <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
<link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
<script src="../css_hacims/ck.js" type="text/javascript"></script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><div class="bx_rad" style="width:100%;">
<ul id="tp1">
<li><strong>&nbsp;Search</strong></li><li>

 
              
              <asp:Panel ID="Panel2" runat="server" Width="100%"></asp:Panel>

<br />

 
<div align="center"><asp:Button  ID="Button1" runat="server" Text="Search" /></div></li>
      
</ul></div></td>
  </tr>
  <tr>
    <td valign="top">



 
<asp:Label CssClass="err"  ID="Label1" runat="server" ></asp:Label><br/>
 <div style="width:100%; overflow:auto;">
<asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                 Width="100%"  >
            
              <Columns>
                  <asp:ButtonField CommandName="Cencel" Text="Cencel" Visible="False" />
                  <asp:ButtonField CommandName="Editrecord" Text="Edit" Visible="False" />
                  <asp:ButtonField CommandName="Examine" Text="Examine" Visible="False" />
                  <asp:ButtonField CommandName="Transfer" Text="Update Consultant & Services" />
                  <asp:ButtonField CommandName="Operation" Text="Schedule For Operation" Visible="False" />
                  <asp:ButtonField CommandName="AddLetter" Text="Add Letter" Visible="false" />
              </Columns><RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

            </asp:GridView></div>
            
        &nbsp;</td>
  </tr>
</table>

    
            
<asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"> </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT [Diagnosis] FROM [Diagnosis]"></asp:SqlDataSource>


<br />
<br /><script type="text/javascript">

var cookies = Spry.Utils.Cookie("read","tabbedpanels");

 if (cookies == "true") { 
var tp1 = new Spry.Widget.CollapsiblePanel("tp1",{ contentIsOpen: true } );
} else { 
var tp1 = new Spry.Widget.CollapsiblePanel("tp1",{ contentIsOpen: false } );
 } 

Spry.Utils.addUnLoadListener(function(){
    
 Spry.Utils.Cookie("create","tabbedpanels",tp1.isOpen());
	
});

 
</script>
<br />
<asp:Panel ID="pnlTransfer" runat="server" CssClass="lightbox" Visible="False">
    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
        <tr>
            <td style="width:25%; text-align:right; " >
                Specilazitation / Department : </td>
                        <td style="width:25%; text-align:left;"><asp:DropDownList AccessKey="d" ID="DDLDepartment" runat="server" TabIndex="-1" AutoPostBack="True"
                                     DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                                    DataValueField="Dept_ID" Width="140px" Visible="false">
                                    <asp:ListItem Value="6">Emergency</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="DropDownList2" TabIndex="22" runat="server"  DataSourceID="SqlDataSource_SubDept"
                                    Width="200px" Height="32px" DataTextField="SubDept_Name" 
                                DataValueField="SubDept_Id" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT Department.Dept_Name, Department.Dept_ID FROM Reception_Dept INNER JOIN Department ON Reception_Dept.Dept_Id = Department.Dept_ID WHERE (Reception_Dept.Reception_Status = 1)">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand=" SELECT DISTINCT SubDepartment.SubDept_Name, SubDepartment.SubDept_Id FROM SubDepartment WHERE SubDepartment.SubDept_Type = 1 And SubDepartment.Dept_Id in (select Dept_Id from Week_Day_Department where Week_Day_Id = DATEPART(dw,getdate())) ORDER BY SubDepartment.SubDept_Name ">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLDepartment" Name="Dept_Id" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
                                </td>
                                <td style="width:25%; text-align:right;">From Doctor : </td>
                                <td style="width:25%; text-align:left;">
                                <asp:DropDownList ID="ddlConsultant" runat="server" Width="200px" 
                                        DataSourceID="sqlDs_Consultant" DataTextField="Name" 
                                        DataValueField="EmpID" AutoPostBack="True"></asp:DropDownList>
                                <asp:SqlDataSource ID="sqlDs_Consultant" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT EmpID,ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM Employee 
WHERE   (ActiveStatus = 1) AND (SubDeptId = @SubDeptId)
ORDER BY Name,EmpID">
    
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList2" Name="SubDeptId" 
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
    
                </asp:SqlDataSource>
                                 </td>
                    </tr>
                     <tr>
                        <td valign="middle"  style="width:25%; text-align:right;">To Doctor : </td>
                        <td style="width:25%; text-align:left;">
                            <asp:DropDownList ID="DDL_ToConsult" runat="server" Width="200px"  
                                        DataSourceID="sqlDs_ToConsultant" DataTextField="Name" 
                                        DataValueField="EmpID" AutoPostBack="True"></asp:DropDownList>
                         <%--   <asp:DropDownList ID="DropDownListDiagnosis" runat="server" DataSourceID="SqlDataSourceDiagnosis"
                                    DataTextField="Diagnosis" DataValueField="Diagnosis" 
                                    Width="200px">
                                </asp:DropDownList>--%>
                                
                                
                        </td>
                        

                            
                            <asp:SqlDataSource ID="sqlDs_ToConsultant" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT EmpID,ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name 
FROM Employee Where ActiveStatus=1 AND Is_Consultant=1
ORDER BY Name,EmpID">
    
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList2" Name="SubDeptId" 
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
    
                </asp:SqlDataSource>
                         </td>
                    </tr>
                     <tr>
                        <td valign="top" style="text-align:right; width:25%;" >
                            Comments : 
                        </td>
                        <td colspan="3" style="text-align:left; width:75%;" >
                            <asp:TextBox ID="txtComments" runat="server" Width="595px" Height="200px" 
                                TextMode="MultiLine"></asp:TextBox>
                        </td>
                     </tr>   
         
            
        
        <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnUpdateConsultant_Services" runat="server" Text="Update Consultant & Services" Width="180px" />
                <asp:Button ID="btnReturn" runat="server" Text="Return" />
            </td>
        </tr>
    </table>
</asp:Panel>

    <asp:SqlDataSource ID="sdsUpdatePayment" runat="server"
    ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
    UpdateCommand="usp_Update_Consultant_Service" 
        UpdateCommandType="StoredProcedure" CancelSelectOnNullParameter="False" InsertCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ReferFrom" Type="String" />
            <asp:Parameter Name="DoctorID" Type="Int32" />
            <asp:Parameter Name="PayID" Type="Decimal" />
            <asp:Parameter Name="ToDoctorID" Type="Int32" />
           
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hdfPayID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
    UpdateCommand="UPDATE Payment SET DoctorID =@DoctorID Where PayID=@PayID " 
    >
        <UpdateParameters>
            <asp:SessionParameter Name="DoctorID" SessionField="Emp_ID" />
            <asp:Parameter Name="PayID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_TokenNo" runat="server"
    ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" UpdateCommandType="StoredProcedure" 
    >
    </asp:SqlDataSource>
  </asp:Content>