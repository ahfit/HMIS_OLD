<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="Indoor_UnAdjusted_Payment.aspx.vb" Inherits="DoctorShare_Indoor_UnAdjusted_Payment" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<%--    <%#Container.DataItemIndex+1%>--%>
    <link href="../css_hacims/jquery_ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet"
        type="text/css" />
    <script src="../css_hacims/jquery_ui/ui/jquery.ui.datepicker.js" type="text/javascript"></script>
    <style type="text/css">
        .border-red
        {
            border: solid 1px red;
        }
        .displaynone
        {
            display:none;
        }
        A.a_1
        {
            font-family: tahoma;
            font-size: 11px;
            font-weight: bold;
            color: #000;
        }
        A.a_1:hover
        {
            color: #0033FF;
        }
        
        .Grid_1 th
        {
            background-image: url(../images-/block_title_2_large.gif);
            background-repeat: repeat-x;
            height: 35px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <asp:SqlDataSource ID="SqlDataSourceConsultant" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name, EmpID FROM Employee WHERE (Is_Consultant=1) ORDER BY Name">
                    </asp:SqlDataSource>--%>
    <fieldset>
    <legend>Search Criteria</legend>
        <table width="100%">
            <tr>
                <td align="right" style="width:100px;">
                    Category :

                </td>
                <td style="width: 250px;">
                    <asp:DropDownList ID="DropDownListCategory" runat="server" DataValueField="Dept_ID" DataTextField="Dept_Name"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td align="right" style="width:100px;">
                    Services :

                </td>
                <td style="width: 250px;">
                    <asp:DropDownList ID="DropDownListServices" runat="server" DataValueField="" DataTextField="Dept_Name"
                        AutoPostBack="true" >
                    </asp:DropDownList>
                </td>
                  <td align="right" style="width: 100px;">
                    
                      Patient Type:
                    
                </td>
                <td style="width: 150px;">
                   
                    <asp:DropDownList ID="DropDownListP_type" runat="server" AutoPostBack="true">
                        <asp:ListItem Selected="True">All</asp:ListItem>
                        <asp:ListItem>OPD</asp:ListItem>
                        <asp:ListItem>IPD</asp:ListItem>
                    </asp:DropDownList>
                   
                </td>
                <td align="right" style="width: 100px;">
                   
                </td>
                <td>
                    
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 100px;">
                    Departments :
                </td>
                <td style="width: 250px;">
                    <asp:DropDownList ID="ddlDepartment" runat="server" DataValueField="Dept_ID" DataTextField="Dept_Name"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td align="right" style="width: 100px;">
                    Select Consultant :
                </td>
                <td style="width: 150px;">
                    <asp:DropDownList ID="DDL_Consultant" runat="server" DataTextField="Name" DataValueField="EmpID">
                    </asp:DropDownList>
                </td>
                <td align="right" style="width: 100px;">
                    Start Date:
                </td>
                <td style="width: 150px;">
                    <igsch:WebDateChooser ID="Wdc_start" runat="server" Value="2010-06-18" Width="122px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                <td align="right" style="width: 100px;">
                    End Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="wdc_End_date" runat="server" Value="2010-06-18" Width="122px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>           
            <tr>
                <td align="center" colspan="8">
                    <asp:Button ID="Btn_Search" runat="server" Text="Search" />
                </td>
            </tr>
           
            <tr>               
                <td>
                </td>
            </tr>
        </table>
    </fieldset>
    <br />
    <br />
    <div width ="100%" align="right">
        <span style="color:yellow; font-size:x-large; font-weight: bold; background-color: #0000FF;" width="200px" >
            <asp:Label ID ="lbl_Tamount" runat="server"></asp:Label>
        </span>
    </div>
    <asp:GridView ID="GridView_General_Services" runat="server" AutoGenerateColumns="False" EmptyDataText="No Record Found.."
        CssClass="Grid_1" Width="100%" ShowFooter="True">
        <Columns>
            <asp:TemplateField HeaderText="Sr.No.">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1%>
                </ItemTemplate>
                <ItemStyle Width="20px" />
            </asp:TemplateField>
            <asp:BoundField DataField="YearlyNo" HeaderText="File No." SortExpression="YearlyNo">
                <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Patient Name">
                <ItemTemplate>
                    <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date" SortExpression="Date">
                <ItemTemplate>
                    <asp:Label ID="lbldate" Text=' <%# Eval("Date")%>' runat="server"></asp:Label>
                   
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Doctor Name" SortExpression="Charges">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Doctor_Name", "{0}") %>' Width="199px"></asp:Label>
                    <asp:DropDownList ID="ddlConsultant" runat="server" Width="172px" Visible="false">
                    </asp:DropDownList>
                </ItemTemplate>
                <FooterTemplate>
                    <strong>Total Amount :</strong>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Service Amount" SortExpression="Amount">
                <ItemTemplate>
                    <asp:Label ID="lblAmount" class="bankAmount" runat="server" Text='<%# String.Format("{0:0.##}", Eval("Amount"))%>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <b>
                        <asp:Label ID="lblTotalAmount" runat="server"></asp:Label></b>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>


               <asp:TemplateField HeaderText="Qty" SortExpression="Qty">
                <ItemTemplate>
                    <asp:Label ID="lblQty" class="bankAmount" runat="server" Text='<%# String.Format("{0:0.##}", Eval("Qty"))%>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <b>
                                          </b>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>




            <asp:TemplateField HeaderText="Doctor Share" SortExpression="Charges">
                <ItemTemplate>
                    <asp:Label ID="lblDoctorCharges" runat="server" ></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <b>
                        <asp:Label ID="lblTotalDoctorCharges" runat="server"></asp:Label></b>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Doctor Discount" SortExpression="Charges">
                <ItemTemplate>
                    <asp:Label ID="lblDoctorDiscount" Text='<%# Bind("ConsultantDiscount")%>' runat="server"></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <b>
                        <asp:Label ID="lblTotalDD" runat="server"></asp:Label></b>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
           
            <asp:TemplateField HeaderText="Cash Amount" SortExpression="Charges"  ControlStyle-CssClass="displaynone" ShowHeader="false" FooterStyle-CssClass="displaynone" >
                <ItemTemplate>
                    <asp:TextBox ID="txtCashAmount" runat="server" Style="width: 100px;"></asp:TextBox>
                    
                </ItemTemplate>
                <FooterTemplate>
                    <b>
                        <asp:Label ID="lblTotalCashAmount" runat="server"></asp:Label></b>
                </FooterTemplate>

<ControlStyle CssClass="displaynone"></ControlStyle>

                <FooterStyle HorizontalAlign="Right" />
                <HeaderStyle CssClass="displaynone" />
                <ItemStyle CssClass="displaynone" />
            </asp:TemplateField>
            <asp:TemplateField Visible="False">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlDoctorAcountHead" runat="server" DataSourceID="SqlDataSource1"
                        DataTextField="E_Name" DataValueField="E_ID" Width="163px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT     Expenditure.E_Name, Expenditure.E_ID&#13;&#10;FROM         Expenditure INNER JOIN&#13;&#10;                      Expenditure_Sub_Heading ON Expenditure.ESH_Code = Expenditure_Sub_Heading.ESH_Code INNER JOIN&#13;&#10;                      Expenditure_Heading ON Expenditure_Sub_Heading.EH_Code = Expenditure_Heading.EH_Code&#13;&#10;WHERE     (Expenditure_Sub_Heading.ESH_Code IN ('A013', 'A040'))">
                    </asp:SqlDataSource>
                    <%--<asp:HiddenField ID="HiddenField_Amount" runat="server" Value='<%# Bind("Charges", "{0}") %>' />--%>
                </ItemTemplate>
                <ItemStyle Width="250px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Hospital Share Discount">
                <ItemTemplate>
                    <asp:Label ID="lblHDiscount" runat="server"></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <b>
                        <asp:Label ID="lblTotalHD" runat="server"></asp:Label></b>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Hospital Share">
                <ItemTemplate>
                    <asp:Label ID="lblHospitalShare" runat="server"></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <b>
                        <asp:Label ID="lblTotalHospitalShare" runat="server"></asp:Label></b>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Payable Amount" SortExpression="Charges">
                <ItemTemplate>
                    <asp:TextBox ID="txtBankAmount" runat="server" Style="width: 100px;" Enabled="false"    ></asp:TextBox>
                </ItemTemplate>
                <FooterTemplate>
                    <b>
                        <asp:Label ID="lblTotalBankAmount" runat="server"></asp:Label></b>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox ID="Ck_Head" runat="server" OnCheckedChanged="Ck_Head_CheckedChanged"
                        AutoPostBack="True" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelected" CssClass="chkSelected" runat="server" AutoPostBack ="true" OnCheckedChanged="chkSelected_CheckedChanged"      />
                    <asp:HiddenField ID="HiddenField_SID" runat="server" Value='<%# Bind("SH_Id", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_RegNo" runat="server" Value='<%# Bind("RegNo", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" Value='<%# Bind("YearlyNo", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldID" runat="server" />
                    <%--<asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" Value='<%# Bind("Doctor_ID", "{0}") %>' />--%>
                    <asp:HiddenField ID="HiddenField_PSID" runat="server" Value='<%# Bind("PSID", "{0}") %>' />
                    <%-- <asp:SqlDataSource ID="SqlDataSourceConsultant" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name, EmpID FROM Employee WHERE (Is_Consultant=1) ORDER BY Name">
                    </asp:SqlDataSource>--%>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <br />
    <br />
    <div align="center">
        <%--<asp:Button ID="Button1" runat="server" Text="Update" CssClass="btn1" />&nbsp;
        <asp:Button ID="Button2" runat="server" Text="Report" CssClass="btn1" />--%>
        <asp:Button ID="btnTransfer" runat="server"  Text="Transfer(s)" CssClass="btn1" OnClientClick="return checkDoctorShare();" />
                    <igsch:WebDateChooser ID="PostVoucher_date" runat="server" Value="2010-06-18" Width="122px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                <br />
    </div>
    <asp:HiddenField ID="HiddenFieldAccountHeadID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Patient_Final_BIll_Duplicate SET Doctor_Share = @Doctor_Share, Account_Head = @Account_Head, AccountUpdateDate = GETDATE(), Doctor_ID = @New_Doctor_ID WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (H_ID = @H_ID) AND (Doctor_ID = @Doctor_ID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Doctor_Share" Name="Doctor_Share" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldYearlyNo" Name="YearlyNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldRegNo" Name="RegNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_SH_Id" Name="H_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Doctor_ID" Name="Doctor_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldAccountHeadID" Name="Account_Head" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldNew_Doctor_ID" Name="New_Doctor_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Doctor_Share" runat="server" />
    <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
    <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
    <asp:HiddenField ID="HiddenField_SH_Id" runat="server" />
    <asp:HiddenField ID="HiddenFieldDocotr_Id" runat="server" />
    <asp:HiddenField ID="HiddenField_ID1" runat="server" />
    <asp:HiddenField ID="HiddenField_ID2" runat="server" />
    <asp:HiddenField ID="HiddenField_H_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" />
    <%-- <asp:SqlDataSource ID="SqlDataSourceTransfer" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Patient_Final_BIll_Duplicate SET AmountStatus = 1, AccountUpdateDate = GETDATE() WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (H_ID = @H_ID) AND (Doctor_ID = @Doctor_ID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldYearlyNo" Name="YearlyNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldRegNo" Name="RegNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_SH_Id" Name="H_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Doctor_ID" Name="Doctor_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>--%>
    <asp:HiddenField ID="HiddenFieldNew_Doctor_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceUpdatePatientServices" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        UpdateCommand="&#13;&#10;UPDATE    Patient_Services&#13;&#10;SET              Doctor_ID = @New_Doctor_ID&#13;&#10;FROM         Patient_Services INNER JOIN&#13;&#10;                      Admin_Services ON Patient_Services.S_ID = Admin_Services.S_ID INNER JOIN&#13;&#10;                      Admin_Service_Head ON Admin_Services.SH_ID = Admin_Service_Head.SH_Id&#13;&#10;WHERE     (Patient_Services.Doctor_ID = @Doctor_ID) AND (Patient_Services.RegNo = @RegNo) AND (Patient_Services.YearlyNo = @YearlyNo) AND &#13;&#10;                      (Admin_Service_Head.SH_Id = @SH_Id)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldNew_Doctor_ID" Name="New_Doctor_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Doctor_ID" Name="Doctor_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldRegNo" Name="RegNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldYearlyNo" Name="YearlyNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_SH_Id" Name="SH_Id" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <script type="text/javascript">
        function checkDoctorShare() {

         


            if ($("[id$='GridView_General_Services']").find(".chkSelected input:checked").length > 0) {
                $("[id$='GridView_General_Services']").find("input").removeClass("border-red");
                var isError = false;
                $("[id$='GridView_General_Services'] tr").each(function () {
                    if ($(this).find(".chkSelected input").is(":checked")) {

                        var doctorShare = $.trim($(this).find("[id$='lblDoctorCharges']").html());
                        var bankAmount = $.trim($(this).find("[id$='txtBankAmount']").val()) == "" ? 0 : $.trim($(this).find("[id$='txtBankAmount']").val());
                        var cashAmount = $.trim($(this).find("[id$='txtCashAmount']").val()) == "" ? 0 : $.trim($(this).find("[id$='txtCashAmount']").val());

                        if (parseFloat(doctorShare) < (parseFloat(bankAmount) + parseFloat(cashAmount))) {
                            $(this).find("[id$='txtBankAmount']").addClass("border-red");
                            $(this).find("[id$='txtCashAmount']").addClass("border-red");
                            isError = true;

                        }
                       
                    }
                });
                if (isError) {
                    alert("Cash amount and bank amount should not be greater than Doctor Share");
                    return false;
                }
                else {
                    return confirm("Are you sure you want to Transfer?");
                }
            }
            else {
                alert("Please select at least 1 payment");
                return false;
            }
        }
    </script>
</asp:Content>
