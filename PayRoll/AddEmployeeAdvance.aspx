<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="AddEmployeeAdvance.aspx.cs" Inherits="PayRoll_AddEmployeeAdvance" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        #grdLoanPlan {
            margin: 0 auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="bxmain">
        <div class="bxmain inner_content">
            <span>
                <h2>Add Employee Advances</h2>
            </span>
            <div style="width: 100%; text-align: center;">
                <asp:Label ID="lblMsg" runat="server" Style="font-size: 13px; font-weight: bold;"></asp:Label>
            </div>
            <table style="width: 100%; line-height: 30px;">
                <tr>
                    <td align="right">Type:
                    </td>
                    <td>
                        <asp:RadioButtonList ID="rdoType" RepeatDirection="Horizontal" runat="server">
                            <asp:ListItem Text="Advance" Value="Advance"></asp:ListItem>
                            <asp:ListItem Text="Loan" Value="Loan" Selected="True"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 20%;">Sub Department :

                    </td>
                    <td style="width: 30%;">
                        <asp:DropDownList runat="server" ID="ddlsdept" OnSelectedIndexChanged="ddlsdept_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                    <td align="right" style="width: 20%;">Select Employee :
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlEmployee">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center;">
                        <h3 class="title">Loan  Details</h3>
                    </td>
                </tr>
                <tr>
                    <td align="right">Total Amount:
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmount" TextMode="Number" runat="server"></asp:TextBox>
                    </td>
                    <td align="right" class="style3">Installment Started From Month :
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList_Month" runat="server" Width="120px">
                            <asp:ListItem Value="01">January</asp:ListItem>
                            <asp:ListItem Value="02">February</asp:ListItem>
                            <asp:ListItem Value="03">March</asp:ListItem>
                            <asp:ListItem Value="04">April</asp:ListItem>
                            <asp:ListItem Value="05">May</asp:ListItem>
                            <asp:ListItem Value="6">Jun</asp:ListItem>
                            <asp:ListItem Value="7">July</asp:ListItem>
                            <asp:ListItem Value="8">August</asp:ListItem>
                            <asp:ListItem Value="9">September</asp:ListItem>
                            <asp:ListItem Value="10">October</asp:ListItem>
                            <asp:ListItem Value="11">November</asp:ListItem>
                            <asp:ListItem Value="12">December</asp:ListItem>
                        </asp:DropDownList>
                    </td>



                </tr>
                <tr>
                    <td align="right">No. of Installments:
                    </td>
                    <td>
                        <asp:TextBox ID="txtInstallment" TextMode="Number" runat="server"></asp:TextBox>
                    </td>

                    <td align="right" class="style3">For Year :
                    </td>
                    <td class="style1">
                        <asp:DropDownList ID="DropDownList_year" runat="server" Width="120px">
                        </asp:DropDownList>
                    </td>

                </tr>
                <tr>
                    <td align="right">Installment Type:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlInstallmentType" runat="server" Enabled="false">
                            <asp:ListItem Text="Month" Value="Month"></asp:ListItem>
                            <asp:ListItem Text="Year" Value="Year"></asp:ListItem>
                        </asp:DropDownList>
                    </td>


                    <td align="right" class="style3">Approved Date :
                    </td>
                    <td class="style1">
                        <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server" CssClass="drop_down">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>

                </tr>
                <tr style="display: none;">
                    <td align="right">Main Head:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlMainHead" DataTextField="Head_Name" DataValueField="E_ID"
                            runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="right">Salary Head:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSalaryHead" DataTextField="Head_Name" DataValueField="E_ID"
                            runat="server">
                        </asp:DropDownList>
                    </td>
                    <td style="display: none;" align="right">Start:
                    </td>
                    <td style="display: none;">
                        <igsch:WebDateChooser ID="txtStart" runat="server">
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="return validateInstallment();" />
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div style="width: 90%; margin: 0 auto;" class="bxmain inner_content">
            <span>
                <h2>Employee Loan Details</h2>
            </span>

            <asp:GridView ID="grdViewEmployeeAdvanceLoanDetails"
                OnSorting="grdViewEmployeeAdvanceLoanDetails_Sorting"
                OnPageIndexChanging="grdViewEmployeeAdvanceLoanDetails_PageIndexChanging"
                runat="server" AutoGenerateColumns="false"
                AllowSorting="true">
                <Columns>
                    <asp:BoundField DataField="EmpId" HeaderText="EmpID" SortExpression="EmpId" />
                    <asp:BoundField DataField="Employee" HeaderText="Employee Name" SortExpression="Employee" />
                    <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                    <asp:BoundField DataField="Installment" HeaderText="Total Installments" SortExpression="Installment" />

                    <asp:BoundField DataField="ApplyDate" HeaderText="Approve Date" SortExpression="ApplyDate" />
                    <asp:TemplateField HeaderText="Edit Plan">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit Plan" CommandArgument='<%#Bind("AdvanceId_Main")%>' ToolTip='<%#Bind("Amount")%>' OnClick="lnkEdit_Click"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Revise Plan">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkRevise" runat="server" Text="Revise Plan" CommandArgument='<%#Bind("AdvanceId_Main")%>' ToolTip='<%#Bind("EmpId")%>' OnClick="lnkRevise_Click"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Report">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkReport" runat="server" Text="Report" CommandArgument='<%#Bind("AdvanceId_Main")%> ' OnClientClick="window.document.forms[0].target='_blank';" OnClick="lnkReport_Click"></asp:LinkButton>

                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            <%--<asp:UpdateProgress ID="upd_Cnicgvd" runat="server">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                            <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                            </span>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>--%>
        </div>
    </div>

    <asp:Panel ID="panelLoanPlan" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2><span>Loan Plan</span></h2>
                <div style="height: 300px; overflow-y: auto; text-align: center" class="bxmain inner_content">

                    <div style="width: 50%; margin: 0 auto; margin-top: 10px;">
                        <div style="float: left; width: 100px; font-weight: bold;">Total Amount:</div>
                        <div style="float: left; width: 100px; font-size: 13px; font-weight: bold;">
                            <asp:Label ID="lblAmount" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div style="float: left; width: 100%; margin-top: 10px;">
                        <div style="width: 80%; margin: 0 auto;">
                            <asp:GridView ID="grdLoanPlan" runat="server" AutoGenerateColumns="false" OnRowDataBound="grdLoanPlan_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="InstallmentNo" HeaderText="Installment No" />
                                    <asp:BoundField DataField="Month" HeaderText="Month" />
                                    <asp:BoundField DataField="Year" HeaderText="Year" />

                                    <asp:TemplateField HeaderText="Amount">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtAmount" CssClass="loanAmount" TextMode="Number" runat="server" Text='<%#Bind("Amount")%> '></asp:TextBox>
                                            <asp:HiddenField ID="hdnAdvanceId_Sub" Value='<%#Bind("AdvanceId_Sub")%>' runat="server" />
                                            <asp:HiddenField ID="hdnMainHeadId" Value='<%#Bind("MainHeadId")%>' runat="server" />
                                            <asp:HiddenField ID="hdnEmpId" Value='<%#Bind("EmpId")%>' runat="server" />
                                            <asp:HiddenField ID="hdnStatus" Value='<%#Bind("Status")%>' runat="server" />
                                            <asp:HiddenField ID="hdnApprovedId" Value='<%#Bind("ApprovedId")%>' runat="server" />

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Hold">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkCancel" runat="server" Text='Hold' CommandArgument='<%#Bind("AdvanceId_Sub")%>' OnClick="lnkCancel_Click"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>

                </div>
                <div style="text-align: center; padding-top: 10px;">

                    <asp:Button ID="btnUpdate" Text="Update" OnClick="btnUpdate_Click" runat="server" OnClientClick="return validateLoad();" />
                    &nbsp;&nbsp;&nbsp;
             <asp:Button ID="btnClose" Text="Close" OnClick="btnClose_Click" runat="server" />

                    <asp:HiddenField ID="hdnPlanId" runat="server" Value="0" />
                </div>
            </div>
        </div>
    </asp:Panel>


    <asp:Panel ID="panelRevise" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox" style="height: 250px;width: 400px;">
            <div style="display: inline; float: left; width: 100%;    height: 200px;" class="bxmain inner_content">
                <h2><span>Revise Loan Plan</span></h2>
                
                    <table style="width: 100%;">
                        <tr>
                            <td align="right" style="width:40%">Remaing Amount:</td>
                            <td>
                                <asp:Label ID="lblRemaingAmount" Font-Bold="true" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td align="right">Installments:
                            </td>
                            <td>
                                <asp:TextBox ID="txtRInstallments" TextMode="Number" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
               
                <div style="text-align: center; padding-top: 10px;">

                    <asp:Button ID="btnUpdateRevisePlan" Text="Update" OnClick="btnUpdateRevisePlan_Click" runat="server" OnClientClick="return validateRevise();" />
                    &nbsp;&nbsp;&nbsp;
             <asp:Button ID="btnRevisePlanClose" Text="Close" OnClick="btnRevisePlanClose_Click" runat="server" />

                    <asp:HiddenField ID="hdfPlanIdRevisePlan" runat="server" Value="0" />
                      <asp:HiddenField ID="HFEmpIdR" runat="server" Value="0" />
                </div>
            </div>
        </div>
    </asp:Panel>

    <script type="text/javascript">
        function validateLoad() {

            var _totalAmount = 0;
            var _error = false;

            $(".loanAmount").removeClass("border-red");

            $("[id$='grdLoanPlan'] tr:gt(0)").each(function () {

                var crtAmount = $.trim($(this).find("[id$='txtAmount']").val()) == "" ? "0" : $.trim($(this).find("[id$='txtAmount']").val());
                var status = $.trim($(this).find("[id$='lnkCancel']").text());

                if (parseInt(crtAmount) == 0 && status == "Hold") {
                    $(this).find("[id$='txtAmount']").addClass("border-red");
                    _error = true;
                    //return false;
                }
                else {
                    _totalAmount = parseInt(_totalAmount) + parseInt(crtAmount);
                }
            });

            if (_error == true) {
                alert("Installment amount can not be zero(0).");
                return false;
            }
            else {
                var actualLoanAmount = $.trim($("[id$='lblAmount']").html());
                if (_totalAmount != parseInt(actualLoanAmount)) {
                    alert("All instalment amount should be equal to total loan amount.");
                    return false;
                }
            }
        }
        function validateInstallment() {
            var amount = $.trim($("[id$='txtAmount']").val());
            var installment = $.trim($("[id$='txtInstallment']").val());
            if (amount == "") {
                alert("Please enter Amount.");
                return false;
            }
            if (installment == "") {
                alert("Please enter Installment.");
                return false;
            }
        }
        function validateRevise() {
            var installment = $.trim($("[id$='txtRInstallments']").val());
            if (installment == "0") {
                alert("Please enter valid Installment.");
                return false;
            }
        }
    </script>
</asp:Content>
