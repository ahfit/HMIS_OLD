<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Search_Employee_IDCard, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
 
 
 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 
 
 
 
  <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                      <tr>
                          <td align="right" >
                                Department : </td>
                          <td >
                              <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
                       DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID" TabIndex="5" Width="229px" Height="19px">
                              </asp:DropDownList></td>
                      </tr>
                      <tr>
                          <td align="right" >
                              Designation :</td>
                          <td >
                              <asp:DropDownList ID="DropDownList_desg" runat="server"
                       DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                      DataValueField="Designation_ID" TabIndex="5" Width="229px" Height="19px">
                              </asp:DropDownList></td>
                      </tr>
                      <tr>
                          <td align="right" >
                              Employee Name :</td>
                          <td >
                        <asp:TextBox ID="TextBox_Employee_name" runat="server" Width="221px"></asp:TextBox></td>
                      </tr>
                      <tr>
                          <td align="right" >
                              CNIC :</td>
                          <td >
                            <igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#" Width="220px"></igtxt:webmaskedit>
                          </td>
                      </tr>
                       
                      <tr>
                          <td align="right" >
                          </td>
                          <td >
                        <asp:Button ID="Button_Search" runat="server" CssClass="btn1" Text="Search" /></td>
                      </tr>
                  </table>
 
 
 
 
 
 
  
  <br>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"    Width="100%">
        <Columns>
            <asp:ButtonField CommandName="Select" DataTextField="EmployeeName" HeaderText="Generate ID Card" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="~/hr/convert.aspx?Enter_emp_ID={0}"
                DataTextField="EmployeeName" HeaderText="Employee Name" Visible="False" />
            <asp:BoundField DataField="RelationName" HeaderText="RelationName" SortExpression="RelationName" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                SortExpression="EmpID" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID,Min_PayScale" DataNavigateUrlFormatString="ACR/Employee_ACR.aspx?EmpID={0}&amp;Min_PayScale={1}"
                HeaderText="Make ACR" Text="Make ACR" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID,Min_PayScale" DataNavigateUrlFormatString="ACR/Employee_ACR_View.aspx?EmpID={0}&amp;Min_PayScale={1}"
                HeaderText="View ACR" Text="View ACR" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="EmpID,Min_PayScale" DataNavigateUrlFormatString="ACR/ACR_view_Comparison.aspx?EmpID={0}&amp;Min_PayScale={1}"
                HeaderText="View ACR" Text="View ACR" Visible="False" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
                 
 
    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]">
    </asp:SqlDataSource>
   
   
 </asp:Content>
   