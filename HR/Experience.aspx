<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_Experience, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain" style="padding: 17px; width: 65%;">
        <div>
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="EmpID" DataSourceID="dsEmployeeInfo"
                HorizontalAlign="Left" Width="100%">
                <ItemTemplate>
                    <asp:Image ID="Image2" runat="server" Style="position: absolute; margin-left: 25px;
                        margin-top: 60px;" ImageUrl=' <%# Convert.ToString("~/DisplayPic.ashx?Emp_Id=") + Convert.ToString(Eval("EmpID")) %>'
                        Width="77px" Height="90px" />
                    <div class="bxinset radius4">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top">
                                    <ul class="empinfo">
                                        <li class="name" style="display: inline;">
                                            <asp:Label ID="Label_EmpName" runat="server" Text='<%# Eval("[Employee Name]") %>'
                                                ToolTip="Employee Name"></asp:Label></li>
                                        <span class="splt">|</span>
                                        <li style="display: inline;">
                                            <asp:Label ID="Designation_NameLabel" runat="server" Style="color: #c60c0c; font-weight: bold;"
                                                Text='<%# Bind("Designation_Name") %>'></asp:Label>
                                            <asp:Label ID="Designation_NameLabel0" Visible="false" runat="server" Text='<%# Convert.ToString("( ")+ Convert.ToString(Eval("SubDept_Name"))+Convert.ToString(" )") %>'></asp:Label></li><span
                                                class="splt">|</span>
                                        <li class="div" style="display: inline;">
                                            <asp:Label ID="Designation_NameLabel1" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label></li><span
                                                class="splt">|</span>
                                        <li style="display: inline;">Emp # <strong>
                                            <asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpNo") %>' ToolTip="Patient Registration Number"></asp:Label></strong>
                                            <span class="spl">|</span> Join Date : <strong>
                                                <asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' ToolTip="Patient Age"></asp:Label></strong>
                                            <span class="spl">|</span> <strong>
                                                <asp:Label ID="Label_CNIC" runat="server" Visible="false" Text='<%# Eval("CNIC") %>'
                                                    ToolTip="Identity Card #"></asp:Label></strong> <strong>
                                                        <asp:Label ID="LabelGender" Visible="false" runat="server" Text='<%# Eval("Gender") %>'
                                                            ToolTip="Patient Gender"></asp:Label></strong> </li>
                                    </ul>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="dsEmployeeInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <%--<asp:ControlParameter ControlID="HiddenField_Emp_ID" DefaultValue="0" 
                    Name="EmpID" PropertyName="Value" />--%>
                    <asp:QueryStringParameter Name="EmpID" DefaultValue="0" QueryStringField="Emp_Id" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
    <div class="bxmain">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td>
                    Start Date
                </td>
                <td>
                    :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser_from_date" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_from_date" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    End Date
                </td>
                <td>
                    :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser_todate" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_to_date" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    Organisation
                </td>
                <td>
                    :
                </td>
                <td>
                    <asp:TextBox ID="txtOrganisation" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Designation / Role
                </td>
                <td>
                    :
                </td>
                <td>
                    <asp:TextBox ID="txtDesignationRole" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Remarks
                </td>
                <td>
                    :
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="300px" Height="65px" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    <asp:HiddenField ID="hfldEmployeeExperienceId" runat="server" Value="0" />
                    <asp:Button ID="btnSaveExperience" runat="server" Text="Save" />
                </td>
            </tr>
        </table>
        <br />
        <br />
        <asp:GridView ID="gvEemployeeExperience" runat="server" AutoGenerateColumns="False"
            DataKeyNames="Employee_Exp_ID" DataSourceID="sqlDs_EmpExp" EnableModelValidation="True"
            Width="100%">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBtnEditExp" runat="server" Text="Edit" OnClick="lnkBtnEditExp_Click"
                            CommandArgument='<%# Eval("Employee_Exp_ID") %>'></asp:LinkButton>
                        &nbsp;&nbsp;
                        <asp:LinkButton ID="lnkBtnDeleteExp" runat="server" Text="Delete" OnClick="lnkBtnDeleteExp_Click"
                            CommandArgument='<%# Eval("Employee_Exp_ID") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Employee_Exp_ID" HeaderText="Employee_Exp_ID" InsertVisible="False"
                    ReadOnly="True" Visible="false" SortExpression="Employee_Exp_ID" />
                <asp:BoundField DataField="Emp_Id" Visible="false" HeaderText="Emp_Id" SortExpression="Emp_Id" />
                <asp:BoundField DataField="Start_Date" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Start Date"
                    SortExpression="Start_Date" />
                <asp:BoundField DataField="End_Date" DataFormatString="{0:dd/MM/yyyy}" HeaderText="End Date"
                    SortExpression="End_Date" />
                <asp:BoundField DataField="Organisation" HeaderText="Organisation" SortExpression="Organisation" />
                <asp:BoundField DataField="Designation_Role" HeaderText="Designation / Role" SortExpression="Designation_Role" />
                <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sqlDs_EmpExp" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="usp_DeleteExperience" DeleteCommandType="StoredProcedure" InsertCommand="usp_CreateExperience"
            InsertCommandType="StoredProcedure" SelectCommand="usp_GetAllExperienceByEmpId"
            SelectCommandType="StoredProcedure" UpdateCommand="usp_UpdateExperience" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="Employee_Exp_ID" Type="Int64" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Direction="InputOutput" Name="Employee_Exp_ID" Type="Int64" />
                <asp:Parameter Name="Emp_Id" Type="Decimal" />
                <asp:Parameter Name="Start_Date" Type="DateTime" />
                <asp:Parameter Name="End_Date" Type="DateTime" />
                <asp:Parameter Name="Organisation" Type="String" />
                <asp:Parameter Name="Designation_Role" Type="String" />
                <asp:Parameter Name="Remarks" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="Emp_Id" Type="Decimal" DefaultValue="0" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Employee_Exp_ID" Type="Int64" />
                <asp:Parameter Name="Emp_Id" Type="Decimal" />
                <asp:Parameter Name="Start_Date" Type="DateTime" />
                <asp:Parameter Name="End_Date" Type="DateTime" />
                <asp:Parameter Name="Organisation" Type="String" />
                <asp:Parameter Name="Designation_Role" Type="String" />
                <asp:Parameter Name="Remarks" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
