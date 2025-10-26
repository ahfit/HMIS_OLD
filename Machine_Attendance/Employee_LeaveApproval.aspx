<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="~/Machine_Attendance/Employee_LeaveApproval.aspx.vb" Inherits="Employee_LeaveApproval" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

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
        <h2><span>Leave Approval</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td width="25%" align="right">Department : </td>
                <td width="25%">
                    <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
                        DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name" AutoPostBack="true" OnSelectedIndexChanged="Dropdownlistdepartment_SelectedIndexChanged"
                        DataValueField="Dept_ID" TabIndex="5">
                    </asp:DropDownList>
                </td>
               
                <%--<td style="width: 224px">
                   CNIC # : <igtxt:WebMaskEdit ID="TextBox_CNIC" runat="server" InputMask="#####-#######-#" CssClass="input_txt" Width="202px"></igtxt:WebMaskEdit>
                </td>--%>
            </tr>
            <tr>
                <td align="right">Employee Name :</td>
                <td>
                    <asp:DropDownList ID="DDLEmployee" runat="server"
                        DataSourceID="SqlDataSourceEmployee" DataTextField="Name"
                        DataValueField="EmpID" TabIndex="5">
                    </asp:DropDownList>
                </td>
                
             <%--   <td style="width: 224px">
                   Status: <asp:DropDownList ID="DDL_Status" runat="server" Width="116px">
                        <asp:ListItem Selected="True" Value="NULL">IN Process</asp:ListItem>
                        <asp:ListItem Value="1">Approved</asp:ListItem>
                        <asp:ListItem Value="0">Rejected</asp:ListItem>
                    </asp:DropDownList></td>--%>
            </tr>
              <tr style="display:none;">
                <td align="right" class="style1">
                    <strong>Start Date :</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                </td>
            </tr>
            <tr style="display:none;">
                <td align="right" class="style1">
                    <strong>End Date :</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_end_Date" runat="server" CssClass="drop_down">
                        <AutoPostBack CalendarMonthChanged="True" ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_end_Date" runat="server" />
                </td>
            </tr>
            
                <tr>
            <td align="right" class="style1">
                <strong>Salary Month :</strong></td>
            <td>
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
                   <%--<igsch:webdatechooser id="WebDateChooser_Start_Date" runat="server" CssClass="drop_down">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:webdatechooser>--%>
        <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
           
                        <asp:DropDownList ID="DDLYear" runat="server"  Width="60px">
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

                        </asp:DropDownList>
                    </td>
        </tr>
            <tr>
                <td colspan="4" align="center">
                    <asp:Button ID="Button_Search" runat="server" Text="Search" />
                    <asp:Button ID="btn_Approve" runat="server" Text="Approve" OnClick="btn_Approve_Click" />
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label>
                </td>
            </tr>
        </table>

    </div>


    <br />


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" Width="100%" DataKeyNames="Emp_Id">
        <Columns>
            <asp:ButtonField  CommandName="Select" DataTextField="Name" HeaderText="Employee Name" Visible="false" />
            <asp:BoundField DataField="Name" HeaderText="Employee Name" SortExpression="Name" />
            <asp:BoundField DataField="RelationName" HeaderText="RelationName" SortExpression="RelationName" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
            <asp:BoundField DataField="JoinDate" HeaderText="Join Date" SortExpression="JoinDate" />
            <asp:BoundField DataField="LeaveType" HeaderText="Leave Type" SortExpression="LeaveType" />
            <asp:BoundField DataField="LeaveTotal" HeaderText="Total Leaves" SortExpression="LeaveTotal" />
            <asp:BoundField DataField="LeaveBalance" HeaderText="Leave Balance" SortExpression="LeaveBalance" />
            <asp:BoundField DataField="month" HeaderText="Over Time" SortExpression="overtime" Visible="false" />
            <asp:BoundField DataField="year" HeaderText="Over Time" SortExpression="year" Visible="false" />
            <asp:BoundField DataField="Emp_Id" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                SortExpression="Emp_Id" Visible="False" />
              <asp:TemplateField>
                    <ItemTemplate>
                         <asp:HiddenField runat="server" ID="hfdE_ID" Value='<%#Bind("E_ID")%>' />
                         <asp:HiddenField runat="server" ID="hfdquantity" Value='<%#Bind("LeaveQuantity")%>' />
                        <asp:HiddenField runat="server" ID="HfLeaveType" Value='<%#Bind("LeaveType")%>' />
                        <asp:HiddenField runat="server" ID="HfLeaveTotal" Value='<%#Bind("LeaveTotal")%>' />
                        <asp:CheckBox runat="server" ID="chkBoxSelect" ToolTip='<%#Bind("Emp_Id")%>' />
                    </ItemTemplate>
                    <HeaderTemplate>
                        <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="chkBoxSelectAll_CheckedChanged" ID="chkBoxSelectAll" ToolTip='<%#Bind("Emp_Id") %>'  />
                    </HeaderTemplate>
                </asp:TemplateField>
            <%--<asp:TemplateField HeaderText="Leave Type Deduction">
                    <ItemTemplate>
                        <asp:DropDownList ID="DDLLeaveTypeBalance" runat="server"></asp:DropDownList>
                    </ItemTemplate>
                   
                </asp:TemplateField>--%>
            <asp:TemplateField HeaderText="Deduct Leaves">
                    <ItemTemplate>
           <asp:CheckBox runat="server" ID="chkBoxLeaveDeduction" ToolTip='<%#Bind("Emp_Id")%>' Checked="true" />
                        </ItemTemplate>
                </asp:TemplateField>
             <asp:TemplateField>
                    <ItemTemplate>
            <asp:LinkButton ID="lnkbtnAction"  Text="Action" onclick="lnkbtnAction_Click" runat="server">Action</asp:LinkButton>
                        </ItemTemplate>
                </asp:TemplateField>

<%--            <asp:HyperLinkField DataNavigateUrlFields="month,Emp_Id,year" DataNavigateUrlFormatString="~/Machine_Attendance/EmpoyeeDayWiseLeave.aspx?month={0}&amp;Emp_ID={1}&amp;year={2}"
                Target="_blank" Text="Action" />--%>
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>




    <br />




    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>" ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT '--ALL--' as [Dept_Name],0 as [Dept_ID] UNION SELECT  [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_ID], [Dept_Name]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select  '--ALL--' as Name,0 as EmpID UNION Select  E.EFName+' '+ELName as Name, E.EmpID FROM [Employee] E  Where (E.DeptID=@deptid or @deptid=0) and (e.activestatus=1)">
        <SelectParameters>
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="deptid" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT 0 AS Gender_ID, '' AS Gender UNION SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT 0 AS Religion_ID, '' AS Religion_name UNION SELECT Religion_ID, Religion_name FROM Religion"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_place_of_birth" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT 0 AS DistrictCode, '' AS DistrictName UNION SELECT DistrictCode, DistrictName FROM DISTRICT ORDER BY DistrictName"></asp:SqlDataSource>






</asp:Content>
