<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="~/HR/Search_EmployeeRequestHODtoHR.vb"
     Inherits="Search_EmployeeRequestHODtoHR" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />


    <asp:Label ID="LabelDoctorName" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="Label_SubDepartment" runat="server" Visible="false" Text="Label_SubDepartment"></asp:Label><asp:Label ID="LabelDate" Visible="false" runat="server"></asp:Label>



    <asp:Panel ID="Panel6" runat="server"></asp:Panel>
    <div class="bxmain inner_content " style="width: 100%">
        <h2><span> Leave Approval By HR</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td width="25%" align="right">Department : </td>
                <td width="25%">
                    <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
                        DataSourceID="SqlDataSourceDepartment" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" TabIndex="5">
                    </asp:DropDownList>
                </td>
               
                <td align="right">
                   CNIC # :</td><td align="left"> <asp:TextBox ID="TextBox_CNIC" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right">Employee Name :</td>
                <td width="25%">
                    <asp:TextBox ID="TextBox_Employee_name" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
                
                <td align="right">
                   Status:</td><td align="left"> <asp:DropDownList ID="DDL_Status" runat="server" Width="116px">                        
                        <asp:ListItem Value="1">Approved</asp:ListItem>
                       <%-- <asp:ListItem Value="0">Rejected</asp:ListItem>--%>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td width="25%" align="right" style="display:none">Month :</td>
                <td width="25%" style="display:none">
                     <asp:DropDownList ID="DDLMonth" runat="server"  Width="100px">


                    <asp:ListItem Value="1">January</asp:ListItem>
                            <asp:ListItem Value="2">February</asp:ListItem>
                            <asp:ListItem Value="3">March</asp:ListItem>
                            <asp:ListItem Value="4">April</asp:ListItem>
                            <asp:ListItem Value="5">May</asp:ListItem>
                            <asp:ListItem Value="6">June</asp:ListItem>
                            <asp:ListItem Value="7">July</asp:ListItem>
                            <asp:ListItem Value="8">August</asp:ListItem>
                            <asp:ListItem Value="9">September</asp:ListItem>
                            <asp:ListItem Value="10">October</asp:ListItem>
                            <asp:ListItem Value="11">November</asp:ListItem>
                            <asp:ListItem Value="12">December</asp:ListItem>
                         </asp:DropDownList>
                </td>
                
                <td align="right" >

                   Date :</td><td align="left"> 
                    <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:DropDownList ID="DDLYear" runat="server"  Width="60px" Visible="false">
                            <asp:ListItem Value="2011">2011</asp:ListItem>
                            <asp:ListItem Value="2012">2012</asp:ListItem>
                            <asp:ListItem Value="2013">2013</asp:ListItem>
                            <asp:ListItem Value="2014">2014</asp:ListItem>
                            <asp:ListItem Value="2015">2015</asp:ListItem>
                            <asp:ListItem Value="2016">2016</asp:ListItem>
                            <asp:ListItem Value="2017">2017</asp:ListItem>
                            <asp:ListItem Value="2018">2018</asp:ListItem>
                            <asp:ListItem Value="2019">2019</asp:ListItem>
                            <asp:ListItem Value="2020">2020</asp:ListItem>
                            <asp:ListItem Value="2021">2021</asp:ListItem>
                            <asp:ListItem Value="2022">2022</asp:ListItem>
                            <asp:ListItem Value="2020">2023</asp:ListItem>
                            <asp:ListItem Value="2021">2024</asp:ListItem>
                            <asp:ListItem Value="2022">2025</asp:ListItem>

                        </asp:DropDownList></td>
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
            <asp:TemplateField HeaderText="Sr.#">
        <ItemTemplate>
             <%#Container.DataItemIndex+1 %>
        </ItemTemplate>
    </asp:TemplateField>
            <%--<asp:ButtonField  CommandName="Select" DataTextField="EmployeeName" HeaderText="Employee Name" />--%>
<asp:BoundField DataField="EmpID" HeaderText="Emp ID" SortExpression="EmpID" />
            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
             <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
             <%--<asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />--%>
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" Visible="false" />
            <asp:BoundField DataField="Leave" HeaderText="Date Requested" SortExpression="Leave" />
            <asp:BoundField DataField="Leave_Name" HeaderText="Leave" SortExpression="Leave_Name" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                SortExpression="EmpID" Visible="False" />
             <asp:BoundField DataField="ApproveDate" HeaderText="Approve HOD Date" SortExpression="ApproveDate" />
             <asp:BoundField DataField="ApproveBy" HeaderText="Approve HOD Name" SortExpression="ApproveBy" />
            <asp:BoundField DataField="LeaveDays" HeaderText="Day of Leave" SortExpression="LeaveDays" />

                    <asp:HyperLinkField HeaderText="Approve / Reject" DataNavigateUrlFields="Emp_Leave_Id,EMPID,SubDeptId,LeaveApprovalID" DataNavigateUrlFormatString="~/Leave_Management/Employee_Leaves_Approve_RejectForHR.aspx?Emp_Leave_Id={0}&Emp_ID={1}&SubDeptId={2}&LeaveApprovalID={3}"
                         Text="Approve / Reject" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>




    <br />




    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:HiddenField ID="HfDate" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>" ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="select '0' AS SubDept_Id,'---ALL---' AS SubDept_Name union select SubDept_Id,SubDept_Name from SubDepartment order by SubDept_Name ">
       
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT 0 AS Gender_ID, '' AS Gender UNION SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT 0 AS Religion_ID, '' AS Religion_name UNION SELECT Religion_ID, Religion_name FROM Religion"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_place_of_birth" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT 0 AS DistrictCode, '' AS DistrictName UNION SELECT DistrictCode, DistrictName FROM DISTRICT ORDER BY DistrictName"></asp:SqlDataSource>






</asp:Content>
