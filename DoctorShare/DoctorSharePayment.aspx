<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="false" CodeFile="DoctorSharePayment.aspx.vb" Inherits="Finance_DoctorSharePayment" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            font-size: medium;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding: 10px 20px; text-align: right;">
        <span style="font-weight: bold; font-size: 13px;">Payment:</span>
       

            <asp:Label ID="lblTotalAmount" runat="server" Text="0.00"></asp:Label>
        <%--  Doctor:<asp:DropDownList ID="ddlDoctors" runat="server" AutoPostBack="true" Visible="false">
        </asp:DropDownList>--%>
    </div>
    <asp:GridView ID="grdDoctorShare" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="Sr No">
                <ItemTemplate>
                    <asp:Label ID="lblSrNo" runat="server"></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Reg #">
                <ItemTemplate>
                    <%# Eval("Regno")%></ItemTemplate>
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Visit #">
                <ItemTemplate>
                    <%# Eval("YearlyNo")%></ItemTemplate>
            </asp:TemplateField>
             
             

            <asp:TemplateField HeaderText="Patient Name">
                <ItemTemplate>
                    <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

              
            <asp:TemplateField HeaderText="Relation">
                <ItemTemplate>
                    <%# Eval("relation")%></ItemTemplate>
            </asp:TemplateField>

             <asp:TemplateField HeaderText="RelationName">
                <ItemTemplate>
                    <%# Eval("Relation_Name")%></ItemTemplate>
            </asp:TemplateField>

             

            <asp:TemplateField HeaderText="Doctor Name">
                <ItemTemplate>
                    <%# Eval("DoctorName") %></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Service">
                <ItemTemplate>
                    <%# Eval("Service") %></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Cash Amount">
                <ItemTemplate>
                    <asp:Label ID="lblCashAmount" class="cashAmount" runat="server" Text='<%# String.Format("{0:0.##}", Eval("CashAmount"))%>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Bank Amount">
                <ItemTemplate>
                    <asp:Label ID="lblBankAmount" class="bankAmount" runat="server" Text='<%# String.Format("{0:0.##}", Eval("BankAmount"))%>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Select Amount">
                <HeaderTemplate>
                    <asp:CheckBox ID="ck_all" CssClass="chkAll" runat="server" AutoPostBack="True" 
                         OnCheckedChanged="ck_all_CheckedChanged" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelected" CssClass="chkSelected" runat="server" OnClick="updateAmount(this);" />
                    <asp:HiddenField ID="hdnSid" runat="server" Value='<%# Bind("SId") %>' />
                    <asp:HiddenField ID="hdnRegNo" runat="server" Value='<%# Bind("RegNo") %>' />
                    <asp:HiddenField ID="hdnYearlyNo" runat="server" Value='<%# Bind("YearlyNo") %>' />
                    <asp:HiddenField ID="hdnDoctorId" runat="server" Value='<%# Bind("DoctorId") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Print">
                <ItemTemplate>
                    <asp:LinkButton ID="linkbtnPrint" runat="server" Text="Print" CommandArgument='<%# Bind("Id") %>'
                        Visible='<%# Bind("p_stat") %>' OnClick="linkbtnPrint_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <div style="text-align: center; padding-top: 10px;">
        <asp:Button ID="btnSavePayment" Text="Pay" runat="server" OnClientClick="return checkPayment();"
            Style="height: 26px" />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btn" Text="Back" runat="server" OnClientClick="javascript:(history.back(-1))" />
    </div>
    <asp:Panel ID="pnl_Deposit" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <table width="100%" class="table-form">
                <tr>
                    <td align="right" width="200px">
                        Total Share:
                    </td>
                    <td>
                        <asp:Label ID="lbl_amount" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>               
                <tr>
                    <td align="right">
                        Tax :
                    </td>
                    <td>
                        <asp:DropDownList ID="ddl_tax" runat="server" DataSourceID="SDS_Tax" DataTextField="E_Name"
                            DataValueField="E_Code">
                        </asp:DropDownList>
                        <span>
                            <asp:TextBox runat="server" ID="txtTax" Text="0" Width="40px" onblur="calculatetax();"></asp:TextBox></span>
                        <span>
                            <asp:Label ID="Label1" runat="server">%</asp:Label></span> <span>
                                <asp:TextBox runat="server" ID="txtRTax" Width="70px" Enabled="false"></asp:TextBox></span>
                        <asp:SqlDataSource ID="SDS_Tax" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                            SelectCommand="SELECT Expenditure.E_Code, E_Name FROM Expenditure
join Head_Master_Table HMT on HMT.E_Code=Expenditure.E_Code
 WHERE (HMT.Head_Type ='Doctor_Tax') ORDER BY E_Name

">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Payable (Doctor Expenses) :
                    </td>
                    <td>
                    <span style="float:left;width:34%;">
                        <asp:DropDownList ID="ddl_Deduction" runat="server" DataSourceID="SDS_Deduction"
                            DataTextField="E_Name" DataValueField="E_Code">
                        </asp:DropDownList>
                        </span>
                    <span style="float:left;width:10%;padding-left: 3px;">
                            <asp:TextBox runat="server" ID="txtDeduction" Text="0" Width="40px" onblur="calculateNet();"></asp:TextBox></span>

                           <span style="float:left;width:100px;">Payable Balance :</span>
                           <span style="float:left;"> <asp:TextBox runat="server" ID="txtNetAmount" Enabled="false" Width="100px"></asp:TextBox></span>
                        <asp:SqlDataSource ID="SDS_Deduction" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                            SelectCommand="SELECT Expenditure.E_Code, E_Name FROM Expenditure join Head_Master_Table HMT on HMT.E_Code=Expenditure.E_Code WHERE (HMT.Head_Type ='Doctor_Share_Pay') ORDER BY E_Name">
                        </asp:SqlDataSource>
                    </td>
                </tr>
               
                <tr>
                    <td align="right">
                        Mode of Payment :
                    </td>
                    <td>
                        <asp:DropDownList ID="ddl_mode_of_payment" runat="server" AutoPostBack="True">                            
                            <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
                            <asp:ListItem  Text="Bank" Value="Bank"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Cheque#:
                    </td>
                    <td>
                       <span  style="float:left;width:35%;">  <asp:TextBox runat="server" ID="txtChequeNo" Enabled="false" style="windows:98%;"></asp:TextBox></span>                        
                        <span style="float:left;width:15%;">Cheque Date:</span>
                         <span  style="float:left;">
                            <igsch:WebDateChooser ID="WebDateChooser_ChequeDate" runat="server" Width="99%"
                                Enabled="false">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </span>
                    </td>
                </tr>
                <tr >
                    <td align="right">
                        Select Account Head
                    </td>
                    <td>
                        <asp:DropDownList ID="ddl_head" DataTextField="E_name" DataValueField="E_Code" runat="server"
                            AutoPostBack="true">
                        </asp:DropDownList>
                        
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lbl_payment" runat="server" Text="Remarks :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txt_Description" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                   <td></td>
                    <td>
                     <asp:Button ID="Btn_Post_voucher" runat="server" Text="Post" />
                        <asp:Button ID="btn_close_pnl" runat="server" Text="Cancel" />
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
    <asp:HiddenField ID="hdnPaymentType" runat="server" />
    <asp:HiddenField ID="hdnTotalPayment" runat="server" Value="0" />

    <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0" />
    <asp:HiddenField ID="hdnPayableAmount" runat="server" Value="0" />

    <script type="text/javascript">
        function updateAmount(elem) {

            var amount = "0.00";
            var paymentType = "";
            if ($("[id$='hdnPaymentType']").val() == "Cash") {
                paymentType = "cashAmount"
            }
            else {
                paymentType = "bankAmount"
            }

            $("[id$='grdDoctorShare'] tr:gt(0)").each(function () {

                if ($(this).find(".chkSelected input").is(":checked")) {
                    var currentAmount = $.trim($(this).find("." + paymentType).html()) == "" ? 0 : $.trim($(this).find("." + paymentType).html());
                    amount = parseFloat(amount) + parseFloat(currentAmount);
                }
            });

//            if ($("[id$='grdDoctorShare']").find(".chkSelected input").length < $("[id$='grdDoctorShare']").find(".chkSelected input:checked").length) {
//                $("[id$='grdDoctorShare']").find(".chkAll input").attr("checked", false);
//            }

            $("[id$='lblTotalAmount']").html(amount);
            $("[id$='hdnTotalPayment']").val(amount);
            $("[id$='lbl_amount']").val(amount);

        }
        function checkPayment() {
            if ($("[id$='grdDoctorShare'] tr").find(".chkSelected input:checked").length == 0) {
                alert("Please select at least 1 service to Pay");
                return false;
            }            
        }

        function calculatetax() {            
            var totalAmount = $("[id$='hdnTotalPayment']").val();
            var tax = $("[id$='txtTax']").val();
            var result = (tax / 100) * totalAmount;
            $("[id$='txtRTax']").val(result);
            var deduction = $("[id$='txtDeduction']").val();
            $("[id$='txtNetAmount']").val(totalAmount - result - deduction);

            $("[id$='hdnTaxAmount']").val($("[id$='txtRTax']").val());
            
        }
        function calculateNet() {
            var totalAmount = $("[id$='hdnTotalPayment']").val();
            var tax = $("[id$='txtRTax']").val();
            var deduction = $("[id$='txtDeduction']").val();
            $("[id$='txtNetAmount']").val(totalAmount - tax - deduction);

            $("[id$='hdnPayableAmount']").val($("[id$='txtNetAmount']").val());
        }
    </script>
</asp:Content>
