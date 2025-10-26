<%@ page title="" language="VB" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="false" inherits="Patient_Billing_ChangePatientStatusAfterDischarge, App_Web_asx2a3aw" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        var gAutoPrint = true; // Flag for whether or not to automatically call the print function 
        function printSpecial() {
            if (document.getElementById != null) {
                var html = '<HTML>\n<HEAD>\n';
                if (document.getElementsByTagName != null) {
                    var headTags = document.getElementsByTagName("head");
                    if (headTags.length > 0) html += headTags[0].innerHTML;
                }
                if (gAutoPrint) {
                    if (navigator.appName == "Microsoft Internet Explorer") {
                        html += '\n</HEAD>\n<'
                        html += 'BODY onLoad="PrintCommandObject.ExecWB(6, -1);">\n';
                    }
                    else {
                        html += '\n</HEAD>\n<BODY>\n';
                    }
                }
                else {
                    html += '\n</HEAD>\n<BODY>\n';
                }

                var printReadyElem = document.getElementById("PrintDiv");
                if (printReadyElem != null) {
                    html += printReadyElem.innerHTML;
                }
                else {
                    alert("Could not find the printReady section in the HTML");
                    return;
                }
                if (gAutoPrint) {
                    if (navigator.appName == "Microsoft Internet Explorer") {
                        html += '<OBJECT ID="PrintCommandObject" WIDTH=0 HEIGHT=0 '
                        html += 'CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT >\n</BODY>\n</HTML>';
                    }
                    else {
                        html += '\n</BODY>\n</HTML>';
                    }
                }
                else {
                    html += '\n</BODY>\n</HTML>';
                }
                var printWin = window.open("", "printSpecial");
                printWin.document.open();
                printWin.document.write(html);

                printWin.document.close();
                if (gAutoPrint) {
                    if (navigator.appName != "Microsoft Internet Explorer") {

                        printWin.print();
                    }
                }
            }
            else {
                alert("Sorry, the print ready feature is only available in modern browsers.");
            }
            printWin.close();
        }

        function Set_focus() {
            document.getElementById("btn_print").focus();
        }
    </script>
    <style type="text/css">
        .style1
        {
            width: 555px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Patient Bill Report</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                
                <td>
                    <asp:TextBox ID="txtRegNo" runat="server" Style="width: 177px;" visible="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    Yearly No:
                </td>
                <td>
                    <asp:TextBox ID="txtYearlyNo" runat="server" Style="width: 177px;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="Btn_Search" runat="server" Text="Search" />
                </td>
            </tr>
        </table>
    </div>
    <div style="text-align: center; width: 100%; margin-top: 10px;">
        <asp:GridView ID="gv_bill" runat="server" AutoGenerateColumns="False" DataSourceID="sds_bill"
            DataKeyNames="Patient_final_bill_id" Width="100%" CssClass="Grid_1" 
            PageSize="30">
            <Columns>
                <%--<asp:CommandField ShowEditButton="True" />--%>
                <asp:TemplateField HeaderText="Edit">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbtnEdit" Text="Change Status" CommandArgument='<%# Eval("YearlyNo") %>'
                            runat="server" OnClick="lnkbtnEdit_Click"></asp:LinkButton>
                        <asp:HiddenField ID="hf_yearlyNoForEdit" runat="server" Value='<%# Bind("YearlyNo") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Patient_final_bill_id" HeaderText="Bill No." InsertVisible="False"
                    SortExpression="Patient_final_bill_id" Visible="False" />
                <asp:TemplateField HeaderText="Registration No" SortExpression="Regno">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbl_reg" runat="server" OnClick="lbl_reg_Click"></asp:LinkButton>
                        <asp:HiddenField ID="hf_reg" runat="server" Value='<%# Bind("Regno") %>' />
                        <asp:HiddenField ID="hf_smp_id" runat="server" Value='<%# Bind("SMPID") %>' />
                        <asp:HiddenField ID="hf_yearlyNo" runat="server" Value='<%# Bind("YearlyNo") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo" />
                <asp:TemplateField HeaderText="Patient Name">
                    <ItemTemplate>
                        <asp:Label ID="lbl_name" runat="server"></asp:Label>
                        <asp:HiddenField ID="hf_Prefix" runat="server" Value='<%# Bind("Prefix") %>' />
                        <asp:HiddenField ID="hf_PFName" runat="server" Value='<%# Bind("PFName") %>' />
                        <asp:HiddenField ID="hf_PMName" runat="server" Value='<%# Bind("PMName") %>' />
                        <asp:HiddenField ID="hf_PLName" runat="server" Value='<%# Bind("PLName") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="RegDate" HeaderText="Registration Date" SortExpression="RegDate" />
                <asp:BoundField DataField="Patient_Type" HeaderText="Type" SortExpression="Patient_Type" />
                <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
                <asp:BoundField DataField="dis_Time" HeaderText="Discharge Time" SortExpression="dis_Time"
                    Visible="False" />
                <asp:BoundField DataField="Employee" HeaderText="Approved By" SortExpression="Employee"
                    Visible="False" />
                <asp:BoundField DataField="DischargeDate" HeaderText="Discharge Date" SortExpression="DischargeDate"
                    Visible="False" />
                <asp:TemplateField HeaderText="Discharge Date" HeaderStyle-Width="100px" Visible="False">
                    <ItemTemplate>
                        <igsch:WebDateChooser ID="WebDateChooser_DischargeDate" runat="server" Width="98%"
                            Value='<%# Eval("DischargeDate") %>' Enabled="false">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                        <br />
                        <asp:HiddenField ID="HF_DischargeDate" runat="server" Value='<%# Eval("DischargeDate") %>' />
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                </asp:TemplateField>
                <asp:BoundField DataField="DischargeStatus" HeaderText="Status" SortExpression="DischargeStatus" />
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CommandArgument='<%# Eval("Patient_final_bill_id") %>'
                            OnClick="lnkEdit_Click"></asp:LinkButton>
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("YearlyNo") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="Regno,YearlyNo,SMPID" DataNavigateUrlFormatString="~/PatientServices.aspx?RegNo={0}&Yearlyno={1}&SPMID={2}"
                    Text="View" Target="_blank" Visible="False" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sds_bill" runat="server" CancelSelectOnNullParameter="False"
            ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>" ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
            SelectCommand="ChangeStatusAfterDischarge" SelectCommandType="StoredProcedure"
            UpdateCommand="UPDATE Payment SET DischargeStatus = 0 WHERE  (PayID = @YearlyNo)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtRegNo" Name="RegNo" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtYearlyNo" Name="YealyNo" PropertyName="Text"
                    Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="txtYearlyNo" Name="YearlyNo" PropertyName="Text" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlTrackDischargeBill" runat="server" CancelSelectOnNullParameter="False"
            ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>" ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
            InsertCommand="INSERT INTO DischargeUpDateTrack(Emp_ID, ModifyDate)VALUES (@Emp_ID,GETDATE())">
            <InsertParameters>
                <asp:SessionParameter DefaultValue="" Name="Emp_ID" SessionField="emp_id" />
            </InsertParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
