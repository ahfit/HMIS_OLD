<%@ Page Title="" Language="VB" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="false" Inherits="HR_SearchEmployeeDetail" CodeFile="~/HR/SearchEmployeeDetail.aspx.vb" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <script src="validate.js" type="text/javascript"></script>


    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
    <asp:Label ID="LabelDoctorName" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="Label_SubDepartment" runat="server" Text="Label_SubDepartment" Visible="False"></asp:Label>
    <asp:Label ID="LabelDate" runat="server" Visible="false"></asp:Label>
    <div class="bxmain">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td align="right">Hospital:</td>

                <td>
                    <asp:DropDownList ID="ddlHospital" Enabled="false" runat="server" CssClass="dropbox"
                        Width="262px" DataSourceID="sdsHospital" DataTextField="Hospital_Name"
                        DataValueField="Hospital_ID" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsHospital" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="
 SELECT distinct    Hospital.Hospital_ID, Hospital.Hospital_Name
FROM         Hospital">
                        <SelectParameters>
                            <asp:SessionParameter Name="Admin_ID" SessionField="emp_id" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>


                <td align="right">Department : </td>
                <td>
                    <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
                        DataTextField="SubDept_Name"  OnSelectedIndexChanged="Dropdownlistdepartment_SelectedIndexChanged"
                        DataValueField="SubDept_Id" CssClass="dropbox" Width="200px"
                        AutoPostBack="True">
                    </asp:DropDownList></td>

             <td align="right">
                    <strong>Employee :</strong></td>
                <td>
                    <asp:DropDownList ID="ddlEmpId" runat="server"
                        CssClass="drop_down" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>

                </td>
            </tr>
            <tr>
                <td align="right">Designation :  </td>
                <td>
                    <asp:DropDownList ID="DropDownList_desg" runat="server"
                        CssClass="dropbox" DataTextField="Designation_Name"
                        DataValueField="Designation_ID" TabIndex="5" Width="200px" AutoPostBack="true">
                    </asp:DropDownList></td>

              

                     <td align="right">Employee Type : </td>
                <td>
                       <asp:DropDownList ID="ddlEmpType" runat="server"
                        CssClass="drop_down" DataTextField="Type" DataSourceID="SqlDataSource_Emp_Type" 
                        DataValueField="Employee_Type_ID">
                    </asp:DropDownList>

                  
                </td>
                <td align="right">
                    <strong>Employee Status :</strong></td>
                <td>
                    <asp:RadioButtonList ID="RBL_Emp_stat" runat="server"
                        RepeatDirection="Horizontal">                        
                        <asp:ListItem Selected="True" Value="1">Active</asp:ListItem>
                        <asp:ListItem Value="0">In Active</asp:ListItem>                        
                    </asp:RadioButtonList>
                </td>

                <td style="text-align: center">
                    <asp:Button ID="Button_Search" runat="server" Text="Search" />
                    &nbsp;
            <asp:Button ID="btn_export" runat="server" Text="Export" />
                    <asp:Label ID="Label1" runat="server"></asp:Label>

                </td>
            </tr>

        </table>
    </div>


    <br />

    <div style="width: 100%; height: 300px; overflow: auto">


        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            CssClass="Grid_1" Width="100%" DataKeyNames="EmpID"
            Height="98px" PageSize="50">
            <Columns>
                <asp:TemplateField HeaderText="#">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                        <asp:HiddenField ID="HiddenField_EmpId" runat="server"
                            Value='<%# Bind("EmpID") %>' />
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:BoundField DataField="Empid" HeaderText="Emp ID" />
                <asp:BoundField DataField="Emp_No" HeaderText="Emp No" />
                <asp:ButtonField CommandName="Select" DataTextField="EmployeeName" HeaderText="Emp Name" />
                <asp:HyperLinkField DataNavigateUrlFields="EmpID" DataNavigateUrlFormatString="~/hr/convert.aspx?Enter_emp_ID={0}"
                    DataTextField="EmployeeName" HeaderText="Employee Name" Visible="False" />
                <asp:BoundField DataField="RelationName" HeaderText="RelationName" SortExpression="RelationName" Visible="false" />
                <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
                <asp:BoundField DataField="Join Date" HeaderText="Join Date" SortExpression="Join Date" Visible="false" />

                <asp:BoundField DataField="Dept_Name" HeaderText="Department" />
                <asp:BoundField DataField="SubDept_Name" HeaderText="SubDepartment" />
                <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />


                <asp:TemplateField HeaderText="Education">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton_Education" runat="server"
                            OnClick="LinkButton_Education_Click">Education</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Certifications">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton_Certification" runat="server"
                            OnClick="LinkButton_Certification_Click">Certifications</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Skills">
                    <ItemTemplate>

                        <asp:LinkButton ID="LinkButton_Skill" runat="server"
                            OnClick="LinkButton_Skill_Click">Skills</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Additional Info">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton_AdditionalInfo" runat="server"
                            OnClick="LinkButton_AdditionalInfo_Click">Additional Info</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Relationship">
                    <ItemTemplate>

                        <asp:LinkButton ID="LinkButton_Relationship" runat="server"
                            OnClick="LinkButton_Relationship_Click">Relationship</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Documents">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton_Documents" runat="server"
                            OnClick="LinkButton_Documents_Click">Documents</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Delete" Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False"
                            CommandArgument='<%#Container.DataItem("EMPId")%>'
                            CommandName="DelEmployee" Text="Delete"
                            OnClientClick="return confirmation(this)" OnClick="LinkButton1_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkViewDetail" runat="server" CommandArgument='<%# Eval("EmpID") %>'
                            OnClick="lnkViewDetail_Click">View Detail</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtnEmpBenifit" runat="server"
                            CommandArgument='<%#Eval("EmpID") %>' OnClick="lbtnEmpBenifit_Click">Benifit</asp:LinkButton>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Card">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtnGenrateID" runat="server"
                            CommandArgument='<%# Eval("empid") %>' OnClick="lbtnGenrateID_Click">Genrate</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Employee_Confirmation.aspx?empid={0}"
                    HeaderText="Emp Confirmation " Target="_blank" Text="Confirmation"
                    DataNavigateUrlFields="EmpID" />

                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Resignation.aspx?empid={0}"
                    DataNavigateUrlFields="EmpID" HeaderText="Resignation" Target="_blank"
                    Text="Resignation" />
                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/EmployeeSuspension.aspx?empid={0}"
                    DataNavigateUrlFields="EmpID" HeaderText="Suspension" Target="_blank"
                    Text="Suspension" />
                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Employee_Contract.aspx?empid={0}"
                    DataNavigateUrlFields="EmpID" HeaderText="Contract" Target="_blank" Text="Contract" />

                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Acadmic_improvement.aspx?empid={0}"
                    DataNavigateUrlFields="EmpID" HeaderText="Ac.Improvement" Target="_blank"
                    Text="Ac.Improvement" />

                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/Professional_improvement.aspx?empid={0}"
                    DataNavigateUrlFields="EmpID" HeaderText="Pro.Improvement" Target="_blank"
                    Text="Pro.Improvement" />



                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/EmployeeJobHistory.aspx?empid={0}"
                    DataNavigateUrlFields="EmpID" HeaderText="Job History" Target="_blank" Text="JOB History" />

                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/EmployeeFileLabel.aspx?empid={0}"
                    DataNavigateUrlFields="EmpID" HeaderText="File label" Target="_blank" Text="File Label" />

                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/EmployeeSummeryRpt.aspx?empid={0}"
                    DataNavigateUrlFields="EmpID" HeaderText="Emp Summary" Target="_blank" Text="Emp Summery" />





                <asp:HyperLinkField DataNavigateUrlFields="EmpID"
                    DataNavigateUrlFormatString="~/hr/Promotion.aspx?empid={0}"
                    HeaderText="Promotion" Target="_blank" Text="Promotion" />


                <asp:HyperLinkField DataNavigateUrlFields="EmpID" Visible="false"
                    DataNavigateUrlFormatString="~/hr/HR_Performa.aspx?empid={0}"
                    HeaderText="Emp ACR" Target="_blank" Text="Emp ACR" />

            </Columns>
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <PagerStyle CssClass="GridPager" />
        </asp:GridView>
    </div>
    <asp:HiddenField ID="HiddenField_CNIC" runat="server" />

    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource_Emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select 0 as Employee_Type_ID,'All' as Type from Employee_Type union SELECT Employee_Type_ID, Type FROM Employee_Type"></asp:SqlDataSource>
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
