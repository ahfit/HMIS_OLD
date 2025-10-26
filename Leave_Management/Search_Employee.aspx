<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Search_Employee.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="HR_Search_Employee" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>

    <div>
        <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
        <asp:HiddenField ID="HiddenFieldPage" runat="server" />
        <asp:Label ID="LabelDoctorName" runat="server" Visible="false"></asp:Label>
        <asp:Label ID="Label_SubDepartment" runat="server" Text="Label_SubDepartment" Visible="False"></asp:Label>
        <asp:Label ID="LabelDate" runat="server" Visible="false"></asp:Label>
        <div class="bxmain inner_content" style="width:100%">
            <div><h2><span>Search Employee For Adding Leave</span></h2></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td align="right" width="40%">Campus :&nbsp;</td>
                    <td width="60%">
                        <asp:DropDownList ID="DDL_Campus" runat="server"
                            DataSourceID="SqlDataSourceCampus" DataTextField="Hospital_Name" CssClass="drop_down"
                            DataValueField="Hospital_Id" TabIndex="1" 
                            Width="262px" AutoPostBack="True">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="right" width="40%">Department :&nbsp;</td>
                    <td width="60%">
                        <asp:DropDownList ID="Dropdownlistdepartment" runat="server" CssClass="drop_down"
                            DataSourceID="SqlDataSourceDepartment" DataTextField="SubDept_Name"
                            DataValueField="SubDept_ID" TabIndex="1" 
                            Width="262px" AutoPostBack="True">
                        </asp:DropDownList></td>
                </tr>
                <tr style="display:none">
                    <td align="right">Designation :&nbsp; </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_desg" runat="server" CssClass="drop_down"
                             DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                            DataValueField="Designation_ID" TabIndex="2" Width="262px">
                        </asp:DropDownList></td>
                </tr>

                <tr>
                    <td align="right">Employee Name :&nbsp;</td>
                    <td>
                        <asp:TextBox ID="TextBox_Employee_name" runat="server" Width="248px" TabIndex="3"></asp:TextBox></td>
                </tr>

                <tr>
                    <td align="right">CNIC # :&nbsp;</td>
                    <td>
                        <igtxt:WebMaskEdit ID="TextBox_CNIC" runat="server" InputMask="#####-#######-#" CssClass="input_txt" TabIndex="4" Width="248px"></igtxt:WebMaskEdit>
                    </td>
                </tr>

                <tr>
                    <td align="right">Emp No :</td>
                    <td>
                        <asp:TextBox ID="TextBox_EmpNo" runat="server" TabIndex="5"></asp:TextBox>
                    </td>
                </tr>

                <tr style="visibility:hidden">
                    <td align="right">Employee Type : </td>
                    <td>
                        <asp:RadioButtonList ID="RBL_Employee_Type" runat="server" RepeatLayout="Flow"
                            DataSourceID="SqlDataSource_Emp_Type" DataTextField="Type"
                            DataValueField="Employee_Type_ID" RepeatDirection="Horizontal" TabIndex="6">
                        </asp:RadioButtonList>
                    </td>
                </tr>

                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Button ID="Button_Search" runat="server" CssClass="btn1" Text="Search" TabIndex="7" />
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </td>
                </tr>

            </table>
       


        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" 
                    AutoGenerateColumns="False"
                     Width="100%" 
                    AllowSorting="true"
                    AllowPaging="false" DataKeyNames="EmpID">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.#">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:BoundField DataField="EmpID" HeaderText="Emp ID" SortExpression="EmpID" />
                        <asp:TemplateField HeaderText="Employee Name" ShowHeader="False">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("EmployeeName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="~/hr/convert.aspx?Enter_emp_ID={0}"
                            DataTextField="EmployeeName" HeaderText="Employee Name" Visible="False" />
                       <%-- <asp:BoundField DataField="RelationName" HeaderText="RelationName" SortExpression="RelationName" />
                        <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />--%>
                        <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" />
                        <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />
                        <asp:BoundField DataField="Dept_Name" HeaderText="Department" />

                        <asp:HyperLinkField DataNavigateUrlFields="EmpID"
                            Target="_blank"
                            DataNavigateUrlFormatString="~/Leave_Management/Leave_History_Report.aspx?emp_id={0}"
                            Text="Leave Detail" />

                        <asp:HyperLinkField DataNavigateUrlFields="EmpID,SubDeptId"
                            Target="_blank"
                            DataNavigateUrlFormatString="~/Leave_Management/Employee_Leaves.aspx?Emp_ID={0}&SubDeptId={1}"
                            Text="Add Leave" />
                        <asp:HyperLinkField DataNavigateUrlFields="EmpID,Min_PayScale" DataNavigateUrlFormatString="~/Leave_Management/Leave_History_Report.aspx?Emp_ID={0}&amp;Min_PayScale={1}"
                            HeaderText="Leave Record" Text="Leave Record" Visible="False" />
                    </Columns>
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <PagerStyle CssClass="GridPager" />
                </asp:GridView>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                            <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                <img src="../../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                            </span>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </ContentTemplate>
        </asp:UpdatePanel>
             </div>
        <asp:HiddenField ID="HiddenField_CNIC" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="
SELECT [Designation_ID], [Designation_Name] FROM [Designation]
ORDER BY [Designation_Name]
"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceCampus" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="select Hospital_Id,Hospital_Name from  Hospital"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
            ProviderName="<%$ ConnectionStrings:HRConnectionString.ProviderName %>"
            SelectCommand="usp_GetAuthoritySubDepartments" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter Name="HospitalId" ControlID="DDL_Campus" PropertyName="SelectedValue"/>
                <asp:sessionparameter Name="EmpId" sessionfield="emp_id" type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="Select 0 as Employee_Type_ID,'All' as Type from Employee_Type
union
SELECT Employee_Type_ID, Type FROM Employee_Type"></asp:SqlDataSource>
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


    </div>



</asp:Content>
