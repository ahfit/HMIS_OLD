<%@ Page Title="" Language="VB" MasterPageFile="~/Hacims_MasterPage_Admin_New.master"
    CodeFile="~/Patient Billing/patient_bill_detail.aspx.vb" AutoEventWireup="false"
    Inherits="Patient_Billing_patient_bill_detail" EnableEventValidation="false"
    Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Patient Bill Report</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
             
             <tr>
            <td align="right"><strong>Hospital :</td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
             <tr>
                <td align="right" width="50%">
                    Start Date :
                </td>
                <td>
                    <igsch:WebDateChooser Width="180px" ID="startDateChooser" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_StartDate" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    End Date :
                </td>
                <td>
                    <igsch:WebDateChooser Width="180px" ID="endDateChooser" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_EndDate" runat="server" />
                </td>
            </tr>
            <tr>
            <td align="right">Bill No:</td>
            <td><asp:TextBox ID="txtBillNo" runat="server" style="width:177px;"></asp:TextBox> </td>

            </tr>
            <tr>
            <td align="right">Reg #:</td>
            <td><asp:TextBox ID="txtRegNo" runat="server" style="width:177px;"></asp:TextBox> </td>

            </tr>
            <tr>
            <td align="right">Yearly No:</td>
            <td><asp:TextBox ID="txtYearlyNo" runat="server" style="width:177px;"></asp:TextBox> </td>

            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="Btn_Search" runat="server" Text="Search" />
                </td>
            </tr>
        </table>
    </div>
    <div style="text-align:center; width:100%; margin-top:10px;">
    <asp:GridView ID="gv_bill" runat="server" AutoGenerateColumns="False" DataSourceID="sds_bill"
        DataKeyNames="Patient_final_bill_id" Width="100%" CssClass="Grid_1">
        <Columns>
            <asp:BoundField DataField="Patient_final_bill_id" HeaderText="Bill No." InsertVisible="False"
                SortExpression="Patient_final_bill_id" />
            <asp:TemplateField HeaderText="Registration No" SortExpression="Reg_no">
                <ItemTemplate>
                    <asp:LinkButton ID="lbl_reg" runat="server" OnClick="lbl_reg_Click"></asp:LinkButton>
                    <asp:HiddenField ID="hf_reg" runat="server" Value='<%# Bind("Reg_no") %>' />
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
            <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
            <asp:BoundField DataField="dis_Time" HeaderText="Discharge Time" SortExpression="dis_Time" />
            <asp:BoundField DataField="Employee" HeaderText="Approved By" SortExpression="Employee" />
            <asp:BoundField DataField="RegDate" HeaderText="Registration Date" SortExpression="RegDate" />
            <asp:BoundField DataField="DischargeDate" HeaderText="Discharge Date" SortExpression="DischargeDate"
                Visible="False" />
            <asp:TemplateField HeaderText="Discharge Date" HeaderStyle-Width="100px">
                <ItemTemplate>
                    <igsch:WebDateChooser ID="WebDateChooser_DischargeDate" runat="server" Width="98%"
                        Value='<%# Eval("DischargeDate") %>' Enabled="false">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <br />
                    <asp:HiddenField ID="HF_DischargeDate" runat="server" Value='<%# Eval("DischargeDate") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CommandArgument='<%# Eval("Patient_final_bill_id") %>'
                        OnClick="lnkEdit_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="Reg_no,YearlyNo,SMPID" DataNavigateUrlFormatString="~/Patient%20Billing/PatientRunningBill_New_Latest.aspx?RegNo={0}&Yearlyno={1}&SPMID={2}"
             Text="View" Target="_blank" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sds_bill" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>" ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
        SelectCommand="Patient_Billing_report_final" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE    Payment
SET              DischargeDateTime = @DischargeDateTime
FROM         Payment INNER JOIN
                      Patient_final_Bill ON Payment.RegNo = Patient_final_Bill.Reg_no 
                      
WHERE     (Patient_final_Bill.Patient_final_bill_id = @FinalID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_StartDate" Name="FromDate" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenField_EndDate" Name="ToDate" PropertyName="Value"
                Type="DateTime" />
                <asp:ControlParameter ControlID="txtBillNo" Name="BillNo" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="txtRegNo" Name="RegNo" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="txtYearlyNo" Name="YealyNo" 
                PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="ddl_Hospital" Name="HospitalID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FinalID" />
            <asp:ControlParameter ControlID="gv_bill" Name="DischargeDateTime" PropertyName="SelectedValue" />
        </UpdateParameters>
    </asp:SqlDataSource>
    

    <asp:SqlDataSource ID="SqlTrackDischargeBill" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>" 
            InsertCommand="INSERT INTO DischargeUpDateTrack(Emp_ID, ModifyDate)VALUES (@Emp_ID,GETDATE())">
        <InsertParameters>
            <asp:SessionParameter DefaultValue="" Name="Emp_ID" SessionField="emp_id" />
           
        </InsertParameters>
       
    </asp:SqlDataSource>
    </div>

    </asp:Content>
