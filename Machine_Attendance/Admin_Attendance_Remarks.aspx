<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Admin_Attendance_Remarks, App_Web_mrdzezyb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <style type="text/css">
 .lightbox {height:430px; }
  
 </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



 
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />    
<%--    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            
            
            
            <asp:Panel ID="Panel1" runat="server" Width="100%">
           
 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment" Visible="False"></asp:Label>
 <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label>
 <div class="bxmain">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right" width="40%">Department :</td>
    <td width="60%"> <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
					 DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID" TabIndex="5" Width="260px"   >
        </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right" >Designation : </td>
    <td><asp:DropDownList ID="DropDownList_desg" runat="server"
                     DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                      DataValueField="Designation_ID" TabIndex="5" Width="260px" >
        </asp:DropDownList></td>
  </tr>
  
  <tr>
    <td align="right">Employee Name :</td>
    <td><asp:TextBox ID="TextBox_Employee_name" runat="server"  Width="248px"></asp:TextBox></td>
  </tr>
  
  <tr>
    <td align="right">CNIC # :</td>
    <td><igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#" CssClass="input_txt" Width="248px"></igtxt:webmaskedit></td>
  </tr>
  
  <tr>
    <td align="right">Employee Type : </td>
    <td>
        <asp:RadioButtonList ID="RBL_Employee_Type" runat="server" 
            DataSourceID="SqlDataSource_Emp_Type" DataTextField="Type" 
            DataValueField="Employee_Type_ID" RepeatDirection="Horizontal" RepeatLayout="Flow">
        </asp:RadioButtonList>
      </td>
  </tr>
  
  <tr>
    <td></td>
    <td><asp:Button ID="Button_Search" runat="server"   Text="Search" />
        <asp:Label ID="Label1" runat="server"></asp:Label>
      </td>
  </tr>

</table>
</div>
<br />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" Width="100%" AllowPaging="True" DataKeyNames="EmpID" Height="98px" AllowSorting="True" PageSize="50">
        <Columns>
            <asp:TemplateField  HeaderText="#">
                     <ItemTemplate>
                 <%# Container.DataItemIndex + 1 %>   
         </ItemTemplate>

            </asp:TemplateField>
            <asp:TemplateField HeaderText="Employee Name" ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" onclick="LinkButton1_Click" 
                        Text='<%# Eval("EmployeeName") %>'></asp:LinkButton>
                    <asp:HiddenField ID="H_EmpId" runat="server" Value='<%# Eval("EmpID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="~/hr/convert.aspx?Enter_emp_ID={0}"
                DataTextField="EmployeeName" HeaderText="Employee Name" Visible="False" />
            <asp:BoundField DataField="RelationName" HeaderText="RelationName" SortExpression="RelationName" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />
            <asp:BoundField DataField="Dept_Name" HeaderText="Department" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <PagerStyle CssClass="GridPager" />
    </asp:GridView>

 </asp:Panel>
 
 
 
            <asp:Panel ID="pnlPopUp" runat="server" Visible="False" Width="100%" CssClass="lightbox_bg">
<div class="lightbox">
          <div style="height:420px; overflow:auto; overflow-x:hidden; width:100%;">
         
  <asp:ImageButton runat="server" ImageUrl="~/images/deletebtn.png" style="float:right; margin-right:10px;" ID="Button1" ></asp:ImageButton>  
           <br />

     <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">  
    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/PictureFrame.png" 
                    Width="85px" Height="100px" />
    
   </td>
    <td align="center" valign="top"  width="90%">
                    
               <asp:DataList ID="DataList1" runat="server" DataKeyField="EmpID" 
                    DataSourceID="SqlDataSource1" Width="98%">
                    <ItemTemplate>
                       <table  cellspacing="0" cellpadding="0" border="0" class="Grid_2" width="98%">
                            <tr>
                                <td align="right" >
                                    Employee Name :</td>
                                <td >
                                    <asp:Label ID="Employee_NameLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Employee_Name") %>' />
                                </td>
                                <td align="right">
                                    Relation :</td>
                                <td>
                                    <asp:Label ID="Relation_NameLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Relation_Name") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Gender :</td>
                                <td >
                                    <asp:Label ID="GenderLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Gender") %>' />
                                </td>
                                <td align="right">
                                    CNIC :</td>
                                <td>
                                    <asp:Label ID="CNICLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("CNIC") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Religion :</td>
                                <td >
                                    <asp:Label ID="Religion_nameLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Religion_name") %>' />
                                </td>
                                <td align="right">
                                    D.O.B</td>
                                <td>
                                    <asp:Label ID="DateOfBirthLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("DateOfBirth") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Marital Status :</td>
                                <td >
                                    <asp:Label ID="Marital_StatusLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Marital_Status") %>' />
                                </td>
                                <td align="right">
                                    Mobile :</td>
                                <td>
                                    <asp:Label ID="Mobile_NumberLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Mobile_Number") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    </td>
                                <td >
                                    </td>
                                <td align="right">
                                    E-Mail :</td>
                                <td>
                                    <asp:Label ID="email_addressLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("email_address") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Type :</td>
                                <td >
                                    <asp:Label ID="Employee_TypeLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Employee_Type") %>' />
                                </td>
                                <td align="right">
                                    JoinDate :</td>
                                <td>
                                    <asp:Label ID="JoinDateLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("JoinDate") %>' />
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right">
                                    Designation :</td>
                                <td >
                                    <asp:Label ID="Designation_NameLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Designation_Name") %>' />
                                </td>
                                <td align="right">
                                    Saction :</td>
                                <td>
                                    <asp:Label ID="SubDept_NameLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("SubDept_Name") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Department :
                                </td>
                                <td >
                                    <asp:Label ID="Dept_NameLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Dept_Name") %>' />
                                </td>
                                <td align="right">
                                    Office Phone :</td>
                                <td>
                                    <asp:Label ID="Emp_Offical_NumberLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("OphoneNo") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    PayScale :</td>
                                <td >
                                    <asp:Label ID="PayScaleLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("PayScale") %>' />
                                </td>
                                <td align="right">
                                    Department Join Date :</td>
                                <td>
                                    <asp:Label ID="DeptJoinDateLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("DeptJoinDate") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Emp No. :</td>
                                <td >
                                    <asp:Label ID="DateOfBirthLabel0" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Emp_Offical_Number") %>' />
                                </td>
                                <td align="right">
                                    Basic Salary :</td>
                                <td>
                                    <asp:Label ID="Employee_Basic_SalaryLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Employee_Basic_Salary") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Details :</td>
                                <td colspan="3">
                                    <asp:Label ID="Designation_DetailLabel" runat="server" Font-Bold="True" 
                                        Text='<%# Eval("Designation_Detail") %>' />
                                </td>
                            </tr>
                        </table>
                        <br />
                    </ItemTemplate>
                </asp:DataList>      
                    
                    
                    
                    
                    
                    
                    
                    </td>
  </tr>
</table>
       
            
         
  
       
                
               <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                    <tr>
                        <td align="right">
                            Select date :</td>
                        <td>
                            <igsch:WebDateChooser ID="WebDateChooser1" runat="server">
                                <AutoPostBack CalendarMonthChanged="True" ValueChanged="True" />
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                            <asp:HiddenField ID="HiddenField_ForDate" runat="server" />
                            Time In : <asp:TextBox id="txtTimeIn" TextMode="time" runat="server" />
                            Time Out : <asp:TextBox id="txtTimeOut" TextMode="time" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Remarks :</td>
                        <td>
                          <asp:TextBox ID="TextBox_Remarks" runat="server" Height="55px" 
                                TextMode="MultiLine" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            </td>
                        <td>
                          <asp:Button ID="Button_SaveRemarks" runat="server" Text="Save" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left">
                        <br>

                          <asp:SqlDataSource ID="SqlDataSource_Remarks" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                                InsertCommand="Insert_Emp_Shift_Attendence_AdminComment" 
                                InsertCommandType="StoredProcedure" 
                                SelectCommand="SELECT CONVERT (Varchar(20), For_Date, 103) AS Date, Remarks FROM Emp_Shift_Attendence_AdminComment WHERE (Emp_Id = @Emp_Id)">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="HiddenField_Selected_Emp_Id" Name="Emp_Id" 
                                        PropertyName="Value" />
                              </SelectParameters>
                            <InsertParameters>
                              <asp:ControlParameter ControlID="TextBox_Remarks" Name="Remarks" 
                                        PropertyName="Text" Type="String" />
                              <asp:SessionParameter Name="EnteredByEmpId" SessionField="Emp_Id" 
                                        Type="Int32" />
                              <asp:ControlParameter ControlID="HiddenField_Selected_Emp_Id" Name="Emp_Id" 
                                        PropertyName="Value" Type="Int32" />
                              <asp:ControlParameter ControlID="HiddenField_ForDate" Name="For_Date" 
                                        PropertyName="Value" Type="DateTime" />
                              </InsertParameters>
                            </asp:SqlDataSource>
                          <asp:GridView ID="GridView_Remarks" runat="server" AutoGenerateColumns="False" Width="100%" 
                                DataSourceID="SqlDataSource_Remarks">
                            <Columns>
                              <asp:TemplateField HeaderText="#">
                                <ItemTemplate>
                                  <%# Container.DataItemIndex + 1 %>   
                                </ItemTemplate>
                                </asp:TemplateField>
                              <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" 
                                        SortExpression="Date" />
                              <asp:BoundField DataField="Remarks" HeaderText="Remarks" 
                                        SortExpression="Remarks" />
                            </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                    SelectCommand="Select_Employee_FaceSheet" SelectCommandType="StoredProcedure">
              <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_Selected_Emp_Id" Name="EmpID" 
                            PropertyName="Value" Type="Int32" />
              </SelectParameters>
</asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Selected_Emp_Id" runat="server" Value="1" /> 
                
              

            </div>
               </div>
            </asp:Panel>



    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />

    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]">
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