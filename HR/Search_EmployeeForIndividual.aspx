<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Search_EmployeeForIndividual, App_Web_ybbpntbq" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />


    <asp:Label ID="LabelDoctorName" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="Label_SubDepartment" runat="server" Visible="false" Text="Label_SubDepartment"></asp:Label><asp:Label ID="LabelDate" Visible="false" runat="server"></asp:Label>



    <asp:Panel ID="Panel6" runat="server"></asp:Panel>
    <div class="bxmain inner_content " style="width: 100%">
        <h2><span>Leave Request</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr style="display:none">
                <td width="25%" align="right">Department : </td>
                <td width="25%">
                    <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
                        DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                        DataValueField="Dept_ID" TabIndex="5">
                    </asp:DropDownList>
                </td>
               
                
            </tr>
            <tr>
                <td width="100px" align="right">Employee Name :</td>
                <td style="width: 124px">
                    <asp:TextBox ID="TextBox_Employee_name" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
                <td style="width: 124px">
                   CNIC # : <igtxt:WebMaskEdit ID="TextBox_CNIC" runat="server" InputMask="#####-#######-#" CssClass="input_txt" Width="202px"></igtxt:WebMaskEdit>
                </td>
                
               
            </tr>
            <tr>
                <td width="300px"></td>
                <td style="width: 124px">
                    Status: <asp:DropDownList ID="DDL_Status" runat="server" Width="116px">
                        <asp:ListItem Selected="True" Value="NULL">IN Process</asp:ListItem>
                        <asp:ListItem Value="1">Approved</asp:ListItem>
                        <asp:ListItem Value="0">Rejected</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td style="width: 124px">
                 
                </td>
                 
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <asp:Button ID="Button_Search" runat="server" Text="Search" />
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label>
                </td>
            </tr>
        </table>

    </div>


    <br />


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" Width="100%" DataKeyNames="EmpID">
        <Columns>
            <%--<asp:ButtonField  CommandName="Select" DataTextField="EmployeeName" HeaderText="Employee Name" />--%>
            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
            <asp:BoundField DataField="RelationName" HeaderText="RelationName" SortExpression="RelationName" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" />
            <asp:BoundField DataField="Leave" HeaderText="Leave" SortExpression="Leave" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                SortExpression="EmpID" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="Emp_Leave_Id,EMPID" DataNavigateUrlFormatString="~/Leave_Management/Employee_Leaves_Approve_Reject.aspx?Emp_Leave_Id={0}&amp;Emp_ID={1}"
                Target="_blank" Text="Action" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>




    <br />




    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>" ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT 0 AS Gender_ID, '' AS Gender UNION SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT 0 AS Religion_ID, '' AS Religion_name UNION SELECT Religion_ID, Religion_name FROM Religion"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_place_of_birth" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT 0 AS DistrictCode, '' AS DistrictName UNION SELECT DistrictCode, DistrictName FROM DISTRICT ORDER BY DistrictName"></asp:SqlDataSource>






</asp:Content>
