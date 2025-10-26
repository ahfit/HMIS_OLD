<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" 
    CodeFile="Employee_monthly_Salary.aspx.vb" Inherits="PayRoll_Emplooyee_Monthly_Salary" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function confirmationRevert() {
            if (confirm('Are you sure you want to Revert Head Amount ?')) {
                return true;
            } else {
                return false;
            }
        }
   </script>
    <style>
        .input_txt {
            width:100%;
            }
        .input_txt:focus {
            width:100%;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <table width="100%" class=" bxmain diagnosis_list">
        <tr>
            <td colspan="2" style="border: 0.2px solid #00a1ff; width: 100%; padding: 5px;">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="EmpID" DataSourceID="dsEmployeeInfo"
                    HorizontalAlign="Left" Width="100%">
                    <ItemTemplate>
                        <div class="bxinset radius4">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td valign="top" width="100" align="center">
                                        <asp:Image ID="Image2" runat="server" ImageUrl=' <%# Convert.ToString("~/DisplayPic.ashx?Emp_Id=") + Convert.ToString(Eval("EmpID")) %>'
                                            Width="77px" Height="90px" />
                                    </td>
                                    <td valign="top">
                                        <ul class="empinfo">
                                            <li class="name">
                                                <asp:Label ID="Label_EmpName" runat="server" Text='<%# Eval("[Employee Name]") %>'
                                                    ToolTip="Employee Name"></asp:Label></li>
                                            <li>
                                                <asp:Label ID="Designation_NameLabel" runat="server" Style="color: #c60c0c; font-weight: bold;"
                                                    Text='<%# Bind("Designation_Name") %>'></asp:Label>
                                                <asp:Label ID="Designation_NameLabel0" runat="server" Text='<%# Convert.ToString("( ")+ Convert.ToString(Eval("SubDept_Name"))+Convert.ToString(" )") %>'></asp:Label></li>
                                            <li class="div">
                                                <asp:Label ID="Designation_NameLabel1" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label></li>
                                            <li>Emp # <strong>
                                                <asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpNo") %>' ToolTip="Patient Registration Number"></asp:Label></strong>
                                                <span class="spl">|</span> Join Date : <strong>
                                                    <asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' ToolTip="Patient Age"></asp:Label></strong>
                                                <span class="spl">|</span> CNIC : <strong>
                                                    <asp:Label ID="Label_CNIC" runat="server" Text='<%# Eval("CNIC") %>' ToolTip="Identity Card #"></asp:Label></strong>
                                                <span class="spl">|</span> <strong>
                                                    <asp:Label ID="LabelGender" runat="server" Text='<%# Eval("Gender") %>' ToolTip="Patient Gender"></asp:Label></strong>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="dsEmployeeInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="EmpID" QueryStringField="emp_ID" DefaultValue="0" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>


        <tr>
            <td colspan="2" align="left">
                <h2><span class="h1" style="font-size: 14px; font-weight: bold; color: blue; line-height: 23px;">ALLOWANCES AND DEDUCTIONS OF
                    <asp:Label ID="LBL_Name" runat="server">Name</asp:Label>
                    of
                    <asp:Label ID="LBL_Month" runat="server">Month</asp:Label>
                    <asp:Label ID="LBL_Year" runat="server">Year</asp:Label>
                    <asp:Label ID="lblSalaryDays" runat="server">SalaryDays</asp:Label>
                    <asp:Label ID="lblMonthDays" runat="server">MonthDays</asp:Label>
                </span></h2>
            </td>
        </tr>

        <tr>
            <td align="center" valign="top" style="margin-right: -10px">
                <div class="bxmain inner_content" style="width: 90%; padding-right: -10px">
                    <h2><span>ALLOWANCES</span></h2>
                    <asp:UpdatePanel ID="pnl_GVD_Allowance" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GVD_Allowance" runat="server"
                                Width="95%" AutoGenerateColumns="False"
                                DataSourceID="SDS_Allowance" AllowSorting="true" ShowFooter="true" OnRowDataBound="GVD_Allowance_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1%>
                                        </ItemTemplate>
                                        <ItemStyle Width="8%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Head Name" SortExpression="Head_Name">

                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Head" runat="server" Text='<%# Bind("Head_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Code" FooterText="Total :">

                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Code" runat="server" Text='<%# Bind("BI_Report_Head") %>'></asp:Label>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="OrignalAmount" SortExpression="Amount" >
                                        <ItemTemplate>
                                             <asp:TextBox ID="TXT_OAmount" runat="server" Enabled="false" Text='<%# Bind("OriginalAmount")%>'  TextMode ="number"></asp:TextBox>

                                         <%--   <asp:Label ID="TXT_Amount" runat="server" Text='<%# Bind("Amount") %>' TextMode="number"></asp:Label>--%>
             
                                        </ItemTemplate>
                                       
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalOAmount" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SalaryAmount" SortExpression="Amount" >
                                        <ItemTemplate>
                                             <asp:TextBox ID="TXT_Amount" runat="server" Enabled="false" Text='<%# Bind("Amount") %>'  TextMode ="number"></asp:TextBox>

                                         <%--   <asp:Label ID="TXT_Amount" runat="server" Text='<%# Bind("Amount") %>' TextMode="number"></asp:Label>--%>
                                            <asp:HiddenField ID="HFD_E_ID" runat="server" Value='<%# Eval("E_ID") %>' />
                                        </ItemTemplate>
                                       
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalAllowances" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>

                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkRevertAllowance" runat="server" Text="Revert" CommandName="Allowance" CommandArgument='<%# Eval("E_ID") %>' Visible='<%# Eval("IsRevertShow") %>' OnClientClick="return confirmationRevert();" OnClick="lnkRevertAllowance_Click"></asp:LinkButton>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:UpdateProgress ID="upd_Cnicgvd" runat="server">
                                <ProgressTemplate>
                                    <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                        <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                            <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                        </span>
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <asp:SqlDataSource ID="SDS_Allowance" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:PayRoll_ConnectionString.ProviderName %>"
                    SelectCommand="Select_Monthly_Salary_head_wise" SelectCommandType="StoredProcedure">

                    <SelectParameters>
                        <asp:Parameter DefaultValue="Allowance" Name="Head_Type" Type="String" />
                        <asp:QueryStringParameter Name="emp_ID" QueryStringField="emp_ID" Type="Int32" />
                        <asp:QueryStringParameter Name="Month" QueryStringField="month" Type="Int32" />
                        <asp:QueryStringParameter Name="Year" QueryStringField="year" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>

            <td align="center" style="vertical-align: top;">
                <div class="bxmain inner_content" style="width: 100%">
                    <h2><span>Deductions</span></h2>
                    <asp:UpdatePanel ID="pnl_GVD_Deduction" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GVD_Deduction" runat="server"
                                Width="95%" AutoGenerateColumns="False"
                                DataSourceID="SDS_Deduction" AllowSorting="true" ShowFooter="true" OnRowDataBound="GVD_Deduction_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1%>
                                        </ItemTemplate>
                                        <ItemStyle Width="8%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Head Name" SortExpression="Head_Name">

                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Head" runat="server" Text='<%# Bind("Head_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Code"  FooterText="Total :">

                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Code" runat="server" Text='<%# Bind("BI_Report_Head") %>' FooterText="Total :"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                     <asp:TemplateField HeaderText="OriginalAmount" SortExpression="Amount" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txt_OAmount" Enabled="false" runat="server" Text='<%# Bind("OriginalAmount")%>' TextMode ="number" ></asp:TextBox>
                                           <%-- <asp:Label ID="txt_Amount" runat="server" Text='<%# Bind("Amount") %>' TextMode="number"></asp:Label>--%>
                                            

                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalOAmount" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="SalaryAmount" SortExpression="Amount" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txt_Amount" Enabled="false" runat="server" Text='<%# Bind("Amount") %>' TextMode ="number" ></asp:TextBox>
                                           <%-- <asp:Label ID="txt_Amount" runat="server" Text='<%# Bind("Amount") %>' TextMode="number"></asp:Label>--%>
                                            <asp:HiddenField ID="HFD_E_ID" runat="server" Value='<%# Eval("E_ID") %>' />

                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalDeduction" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>

                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkRevertDeduction" runat="server" Text="Revert" CommandName="Deduction" CommandArgument='<%# Eval("E_ID") %>' Visible="false" OnClientClick="return confirmationRevert();" OnClick="lnkRevertAllowance_Click"></asp:LinkButton>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                        <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                            <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                        </span>
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <asp:SqlDataSource ID="SDS_Deduction" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:PayRoll_ConnectionString.ProviderName %>" SelectCommand="Select_Monthly_Salary_head_wise"
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Deduction" Name="Head_Type" Type="String" />
                        <asp:QueryStringParameter Name="emp_ID" QueryStringField="emp_id" Type="Int32" />
                        <asp:QueryStringParameter Name="Month" QueryStringField="month" Type="Int32" />
                        <asp:QueryStringParameter Name="Year" QueryStringField="year" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="center" valign="top">&nbsp;</td>
            <td align="center">&nbsp;</td>
        </tr>

        <tr>
            <td align="center" valign="top" colspan="2">
              <%--  <asp:Button  ID="BTN_save"  Text="Save" runat="server" />--%>

                <asp:Button  ID="bntUpdate" Visible="false"  Text="Update" runat="server" OnClick="bntUpdate_Click" />

                  <asp:SqlDataSource ID="sqlUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:PayRoll_ConnectionString.ProviderName %>"
                    UpdateCommand="EmployeAllowanceDeductionsUpdate" UpdateCommandType="StoredProcedure">
                    <UpdateParameters>
                        <asp:QueryStringParameter Name="Empid" QueryStringField="emp_id" Type="Int32" />
                        <asp:ControlParameter ControlID="LBL_Month" Name="SalaryMonth" PropertyName="Text" Type="Int32" />
                        <asp:ControlParameter ControlID="LBL_Year" Name="SalaryYear" PropertyName="Text" Type="Int32" />
                        <asp:Parameter Name="data" Type="String" />
                       
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:Label ID="lbl_Message" CssClass="lblErrorSpan" ForeColor="Red" runat="server"></asp:Label>
                <asp:SqlDataSource ID="SDS_Save" runat="server" ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:PayRoll_ConnectionString.ProviderName %>"
                    InsertCommand="usp_Employee_month_Salary" InsertCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:QueryStringParameter Name="Empid" QueryStringField="emp_id" Type="Int32" />
                        <asp:ControlParameter ControlID="LBL_Month" Name="SalaryMonth" PropertyName="Text" Type="Int32" />
                        <asp:ControlParameter ControlID="LBL_Year" Name="SalaryYear" PropertyName="Text" Type="Int32" />
                        <asp:Parameter Name="data" Type="String" />
                        <asp:Parameter Name="Salary_id" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
            </td>
        </tr>

        <tr>
            <td align="center" valign="top">&nbsp;</td>
            <td align="center">&nbsp;</td>
        </tr>
    </table>
    <asp:HiddenField ID="HfSalMade" runat="server" Value="False"/>
  <asp:HiddenField ID="HfSalApproved" runat="server" Value="False"/>

</asp:Content>

