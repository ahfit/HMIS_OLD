<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="EmployeeAllowancesDeductionsSetup.aspx.cs" Inherits="PayRoll_EmployeeAllowancesDeductionsSetup" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
    <script type="text/javascript">
        

        function CalculateSal() {
            var grossSal = $("[id$='txtGrossSal']").val();
            if (parseInt(grossSal) < 0) {
                alert("Please enter valid Basic Salary");
                $("[id$='txtGrossSal']").val("0");
                return false;
            }
            $("[id$='GVD_Allowance'] tr:gt(0)").each(function () {
                var hfGSPercentage = $(this).find("[id$='hfGSPercentage']").val();
                if (hfGSPercentage != "0") {
                    $(this).find("[id$='txtAllowanceAmount']").val((grossSal * parseInt(hfGSPercentage)) / 100);
                    $(this).find("[id$='hfAmount']").val((grossSal * parseInt(hfGSPercentage)) / 100);
                }
                
            });
        }
        function validateSal() {

            var grossSal = $("[id$='txtGrossSal']").val();
            if (parseInt(grossSal) <= 0) {
                alert("Please enter Basic Salary");
                return false;
            }
        }
        function setSalRaise() {            
            var grossSalaryR = $("[id$='txtGrossSalaryR']").val() == "" ? "0" : $("[id$='txtGrossSalaryR']").val();
            if (parseInt(grossSalaryR) <= 0) {
                alert("Please enter valid Gross Salary");
                return false;
            }
            var effectiveDate = $("[id$='txtEffectiveDate']").val();
            if (effectiveDate=="") {
                alert("Please enter Effective Date");
                return false;
            }
            var remarks = $("[id$='txtRemarks']").val();
            if (remarks == "") {
                alert("Please enter Remarks");
                return false;
            }
            $("[id$='txtGrossSal']").val(parseInt(grossSalaryR));
            CalculateSal();
            $("#divRevisePanel").hide();
            $("[id$='hfType']").val($("[id*=rdoType] input:checked").val());
            $("[id$='hfIsRevised']").val("true");
            $("[id$='hfEffectiveDate']").val($("[id$='txtEffectiveDate']").val());
            return false;

        }
        function showRevisePanel() {
            $("#divRevisePanel").show();
            return false;
        }
        function closeRaisePanel() {
            $("#divRevisePanel").hide();
            return false;
        }
        </script>
    <style type="text/css">
        .nodisplay {
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="inner_content bxmain">
        <h2>Add Employee Allowances / Deductions</h2>
        <table style="width: 100%;">
            <tr>
                <td colspan="2">
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
                            <asp:QueryStringParameter Name="EmpID" QueryStringField="EmpId" DefaultValue="0" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            
            <tr>
                <td style="width: 45%; vertical-align: top;">
                    <div class="inner_content">
                        <h2>Allowances</h2>
                        <div style="width: 100%; margin-bottom: 10px;">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 40%; text-align: right;display:none">Tax Exemption :</td>
                                    <td style="width: 10%;display:none">
                                        <asp:TextBox ID="txtEmpExcemption"  TextMode="Number" onblur="minmax('0','100')" runat="server" Text="0" MaxLength="3"></asp:TextBox></td>
                                    <td style="width: 40%; text-align: right">Basic Salary :</td>
                                    <td>
                                        <asp:TextBox ID="txtGrossSal" TextMode="Number" onblur="return CalculateSal();" runat="server" Text="0"></asp:TextBox>
                                        <asp:HiddenField ID="hfGrossSal" runat="server" />
                                    </td>

                                </tr>
                            </table>
                        </div>
                    </div>
                    <div>

                        <asp:GridView ID="GVD_Allowance" runat="server" Width="99%"
                            AutoGenerateColumns="False" OnRowDataBound="GVD_Allowance_RowDataBound" ShowFooter="true">
                            <Columns>
                                <asp:TemplateField HeaderText="Head Name" SortExpression="Head_Name">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Head_Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Financial Code" SortExpression="BI_Report_Head">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("BI_Report_Head")%>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                    <asp:Label ID="lblTotal" runat="server" Text="Total Salary: " Font-Bold="true"></asp:Label>
                </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Enabled='<%# Eval("HeadEnable") %>' ID="txtAllowanceAmount" Style="width: 90%" TextMode="Number" min="0" Text='<%# Bind("Amount")%>'></asp:TextBox>
                                        <asp:HiddenField ID="hfHeadId" runat="server" Value='<%# Eval("E_Id") %>' />
                                        <asp:HiddenField ID="hfAmount" runat="server" Value='<%# Eval("Amount") %>' />
                                        <asp:HiddenField ID="hfGSPercentage" runat="server" Value='<%# Eval("GSPercentage") %>' />
                                         <asp:HiddenField ID="hfIsGrossSalaryHead" runat="server" Value='<%# Eval("IsGrossSalaryHead") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                    <asp:Label ID="lblTotalAllowance" runat="server" Font-Bold="true"></asp:Label>
                </FooterTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tax Exempted %" Visible="false">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtTaxExempted" Style="width: 90%" Text='<%# Bind("TaxExempted")%>'></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Excluded Tax" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkExclude" runat="server" OnCheckedChanged="chkExclude_CheckedChanged" />
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="nodisplay" />
                                    <ItemStyle CssClass="nodisplay" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Select" Visible="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelectAllowances" runat="server" AutoPostBack="True" />

                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
                <td style="vertical-align: top;">
                    <div class="inner_content" style="margin-left: 4%">
                        <h2>Deductions</h2>
                    </div>
                    <div style="margin-left: 5%;">
                        <asp:GridView ID="GVD_Deduction" runat="server" Width="99%" AutoGenerateColumns="False" ShowFooter="true" OnRowDataBound="GVD_Deduction_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="Head Name" SortExpression="Head_Name">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Head_Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Financial Code" SortExpression="BI_Report_Head">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("BI_Report_Head")%>'></asp:Label>
                                    </ItemTemplate>
                                       <FooterTemplate>
                    <asp:Label ID="lblTotal" runat="server" Text="Total Deductions: " Font-Bold="true"></asp:Label>
                </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Deduction #" SortExpression="Amount">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtDeductionNo" Style="width: 90%" Text='<%# Bind("DeductionNo")%>'></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Opening Balance">

                                    <ItemTemplate>
                                        <asp:TextBox ID="txtOpening" runat="server" Text='<%# Bind("OpeningBalance") %>' Style="width: 90%" TextMode="Number" min="0"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtDeductionAmount" Style="width: 90%" Text='<%# Bind("Amount")%>' TextMode="Number" min="0"></asp:TextBox>
                                        <asp:HiddenField ID="hfHeadId" runat="server" Value='<%# Eval("E_Id") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                    <asp:Label ID="lblTotalDeduction" runat="server" Font-Bold="true"></asp:Label>
                </FooterTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Select" Visible="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelectDeduction" runat="server" AutoPostBack="True" />

                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <div style="padding-top: 10px;">
                        <asp:Button runat="server" ID="btnSave" Text="Save" OnClientClick="return validateSal()" OnClick="btnSave_Click" />&nbsp;&nbsp;
                        <asp:Button runat="server" ID="btnRevise" Text="Revise Salary" OnClientClick="return showRevisePanel()" />

                    &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label runat="server" ID="lblMsg" Text="" Style="font-size: 13px; font-weight: bold"></asp:Label>
                   
                    </div>
                </td>
            </tr>
        </table>

        <div style="padding-top:10px; margin:0 auto;">
            <div style="margin: 0 auto;width:70%">
            <asp:GridView ID="grdSalRaiseLog" runat="server" Width="100%" AutoGenerateColumns="False" >
                            <Columns>
                                
                                <asp:TemplateField HeaderText="Gross Salary">
                                    <ItemTemplate>
                                        <asp:Label ID="lblGrossSalary" runat="server" Text='<%# Bind("GrossSal") %>'></asp:Label>
                                    </ItemTemplate>   
                                    <ItemStyle HorizontalAlign="Center" />                                 
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReviseType" runat="server" Text='<%# Bind("ReviseType") %>'></asp:Label>
                                    </ItemTemplate>   
                                    <ItemStyle HorizontalAlign="Center" />                                 
                                </asp:TemplateField>
                               <asp:TemplateField HeaderText="Effective Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEffectiveDate" runat="server" Text='<%# Bind("EffectiveDate") %>'></asp:Label>
                                    </ItemTemplate>   
                                     <ItemStyle HorizontalAlign="Center" />                                    
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Created Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Bind("CreatedDate") %>'></asp:Label>
                                    </ItemTemplate> 
                                       <ItemStyle HorizontalAlign="Center" />                                      
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Details">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDetails" runat="server" Text='Details' CommandArgument='<%# Bind("EmpSalId") %>' OnClick="lnkDetails_Click"></asp:LinkButton>
                                    </ItemTemplate> 
                                       <ItemStyle HorizontalAlign="Center" />                                      
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                </div>
        </div>
        <asp:Panel ID="pnlSalRaiseBreakeup" class="lightbox" Style="width: 500px;top:40% !important; height: 400px !important" runat="server"
                Visible="false">

            <asp:GridView ID="grdSalRaiseBreakUp" runat="server" Width="100%" AutoGenerateColumns="False" >
                            <Columns>
                                 <asp:TemplateField HeaderText="Head Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblHead_Name" runat="server" Text='<%# Bind("Head_Name") %>'></asp:Label>
                                    </ItemTemplate>   
                                     <ItemStyle HorizontalAlign="Center" />                                    
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                                    </ItemTemplate>   
                                    <ItemStyle HorizontalAlign="Center" />                                 
                                </asp:TemplateField>
                              
                                 
                            </Columns>
                        </asp:GridView>

            <div style="text-align:center;padding-top:10px;">
                <asp:Button ID="btnCloseRaisSal" runat="server" Text="Close" OnClick="btnCloseRaisSal_Click" />
            </div>
            </asp:Panel>
       <div id="divRevisePanel" class="div-alert" style="display: none;">
                        <div style="text-align: center;">
                            <h2>Employee Salary Revise</h2>
                        </div>
                <table class="tbl_form">
                    <tr>
                        <td style="text-align:right">
                            Type:
                        </td>
                        <td>
                        <asp:RadioButtonList ID="rdoType" RepeatDirection="Horizontal" runat="server">
                            <asp:ListItem Text="Promotion" Value="Promotion" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Demotion" Value="Demotion"></asp:ListItem>
                        </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                         <td>Basic Salary:</td>
                        <td> <asp:TextBox ID="txtGrossSalaryR" TextMode="Number" runat="server"></asp:TextBox></td>
                         <td>Effective Date:</td>
                        <td>
                    <asp:TextBox ID="txtEffectiveDate" TextMode="Date" runat="server"></asp:TextBox>
                        </td>
                       
                    </tr>
                    <tr>
                        <td style="text-align:right;">Remarks:</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtRemarks" runat="server" style="width:99%;height:100px;"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align:center">
                            <asp:Button ID="btnSet" runat="server" Text="Set" OnClientClick="return setSalRaise()"  />
                            &nbsp;
                        <asp:Button ID="btnClose" runat="server" Text="Close" OnClientClick="return closeRaisePanel()" />
                        </td>
                    </tr>
                </table>
           </div>
        <asp:HiddenField ID="hfType" runat="server" Value='Initial' />
        <asp:HiddenField ID="hfIsRevised" runat="server" Value='true' />
        <asp:HiddenField ID="hfEffectiveDate" runat="server" Value='' />
    </div>
</asp:Content>
