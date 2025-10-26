<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Search_Employee_ForLeaveCancel.aspx.vb"
     Inherits="LM_Search_Employee_ForLeaveCancel" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

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
        <h2><span>Employee Leave Cancel Request</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td width="25%" align="right">Department : </td>
                <td width="25%">
                    <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
                        DataSourceID="SqlDataSourceDepartment" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" TabIndex="5" AutoPostBack="true" OnSelectedIndexChanged="Dropdownlistdepartment_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
               
                <td style="width: 224px; display:none;">
                   CNIC # : <asp:TextBox ID="TextBox_CNIC" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Employee :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Sold_By" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Employee" DataTextField="Employee_Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        SelectCommand="usp_GetAuthorityDepartmentsAllEmployee" SelectCommandType="StoredProcedure" 
                        ProviderName="<%$ ConnectionStrings:HRConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="SubDeptId"
                                PropertyName="SelectedValue" />
                            <asp:Parameter Name="LevelId" DefaultValue="2"/>
                            <asp:sessionparameter name="EmpId" sessionfield="emp_id" type="Int32" />
                            <%--<asp:SessionParameter Name="DesignationId" SessionField="DesignationID"/>--%>
                        </SelectParameters>
                    </asp:SqlDataSource>




                </td>
            </tr>
            <tr style="display:none;">
                <td align="right">Employee Name :</td>
                <td>
                    <asp:TextBox ID="TextBox_Employee_name" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
                
                <td style="width: 224px">
                 <div style="display:none;"> Status: <asp:DropDownList ID="DDL_Status" runat="server" Width="116px">
                        <asp:ListItem Selected="True" Value="NULL">IN Process</asp:ListItem>
                        <asp:ListItem Value="1">Approved</asp:ListItem>
                        <asp:ListItem Value="0">Rejected</asp:ListItem>
                    </asp:DropDownList>
                     </div> 
                     </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Start Date :</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>End Date :</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_end_Date" runat="server" CssClass="drop_down">                         
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_end_Date" runat="server" />
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
 <asp:TemplateField HeaderText="Sr.#">
        <ItemTemplate>
             <%#Container.DataItemIndex+1 %>
        </ItemTemplate>
    </asp:TemplateField>
            <%--<asp:ButtonField  CommandName="Select" DataTextField="EmployeeName" HeaderText="Employee Name" />--%>
<asp:BoundField DataField="EmpID" HeaderText="Emp ID" SortExpression="EmpID" />
            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
             <%--<asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />--%>
            <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" />
            <asp:BoundField DataField="Leave" HeaderText="Leave Date" SortExpression="Leave" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                SortExpression="EmpID" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="Emp_Leave_Id,EMPID,SubDeptId" DataNavigateUrlFormatString="~/Leave_Management/Employee_Leaves_Cancel_Request.aspx?Emp_Leave_Id={0}&Emp_ID={1}&SubDeptId={2}"
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
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
        ProviderName="<%$ ConnectionStrings:HRConnectionString.ProviderName %>"
        SelectCommand="usp_GetAuthoritySubDepartments" SelectCommandType="StoredProcedure">

        <SelectParameters>
            <%--<asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" DefaultValue="0" Type="Int32" />--%>
            <%--<asp:SessionParameter Name="DesignationId" SessionField="DesignationID"/>--%>
            <asp:sessionparameter name="EmpId" sessionfield="emp_id" type="Int32" />
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
