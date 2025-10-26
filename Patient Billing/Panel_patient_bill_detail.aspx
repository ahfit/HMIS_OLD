<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" 
     CodeFile="Panel_patient_bill_detail.aspx.vb" Inherits="Patient_Billing_Panel_patient_bill_detail" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
     <asp:ScriptManager ID="ScriptManager2" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width:100%"><span><h2>Panel Patient Bill Detail</h2></span>
    <table class="diagnosis_list" style="width:100%;">
       
        <tr>
        <td style="width:50%;">
        <table>
        <tr>
            <td class="AmountAlign" style="width:40%;"><strong>Hospital:</strong></td>
            <td>
             <asp:DropDownList ID="DDL_Hospital" runat="server" DataSourceID="SDS_Hospital" 
                DataTextField="Hospital_Name" DataValueField="Hospital_ID" >
            </asp:DropDownList>
            </td>
            <asp:SqlDataSource ID = "SDS_Hospital" runat = "server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
           
        </tr>
         <tr>
        <td width = "30%" align = "right">
       <strong>Start Date :</strong> 
        </td>
        <td width = "50%" >
        <igsch:WebDateChooser ID="WebDateChooser_Sdate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>

           
        </td>
    </tr>
    <tr>
        <td width = "30%" align = "right">
            <strong> End Date :</strong>
        </td>
        <td width = "50%" >
            <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server" 
                    Width="202px" >
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                    <AutoPostBack ValueChanged="True" />
                </igsch:WebDateChooser>

        </td>
        
    </tr>
      <tr>
            <td colspan="2" style="text-align:center;padding-top:10px;">
                <asp:Button ID="btnShowReport" Text="Search"  runat="server" />
                <asp:Button ID="Button1" Text="View Report"  runat="server"  OnClick="Button1_Click"/>
               </td>
        </tr>
    </table>
    </td>
    <td style="vertical-align:top;">
    <div class="bxmain inner_content" style="padding-left:10px;"><span><h2>Invoice No</h2></span>
    <table>
         <tr>
         <td class="AmountAlign" style="width:40%;">
                <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Panel Company:</strong></td>
            <td>
                                                                <asp:DropDownList ID="DropDownList_Parties" runat="server" AutoPostBack="false" 
                                                                    
                    DataSourceID="SqlDataSource_parties" DataTextField="Party_Name" 
                                                                    DataValueField="Party_Id">
                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" 
                                                                    
                                                                    
                    ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" 
                    SelectCommand="SELECT     Parties.Party_Id, Parties.Party_Name
FROM       Parties 
		   INNER JOIN Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id
		   Order By Party_Name">
                                                                </asp:SqlDataSource>
                                                            </td>
            </tr>
    <tr style="line-height:29px;">
    
        <td width = "30%"  align = "right">
            <strong> Invoice # :</strong>
        </td>
        <td width = "50%" >
            <asp:TextBox ID="txtboxInvoiceNo" runat="server"></asp:TextBox>
        </td>
       
    </tr>
     <tr>
    
        <td width = "30%"  align = "right">
            <strong> Date :</strong>
        </td>
        <td width = "50%" >
            <igsch:WebDateChooser ID="WebDateChooser_Invoicedate" runat="server" 
                    Width="202px" >
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                    <AutoPostBack ValueChanged="True" />
                </igsch:WebDateChooser>

        </td>

    
    </tr>
    </table>
    </div>
    </td>
    </tr>


      
        </table>
        </div>
    <table width="100%">
        <tr>
            <td align="center" colspan="2">
                <asp:GridView ID="gv_bill" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sds_bill" Width="100%" ShowFooter="true">
                    <Columns>
                        
                        <asp:BoundField DataField="Patient_final_bill_id" HeaderText="Bill No." 
                            InsertVisible="False" SortExpression="Patient_final_bill_id" />

                       
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEditDates" runat="server" Text="Edit Date" OnClick="lnkEditDates_Click" CommandArgument='<%# Eval("dis_Time")%>'></asp:LinkButton>
                                <asp:HiddenField ID="hfAdmissionDate" runat="server" value='<%# Bind("dis_Time")%>' />
                                
                            </ItemTemplate>
                        </asp:TemplateField> 
                         <asp:HyperLinkField DataNavigateUrlFields="Reg_no,YearlyNo" Target="_blank" DataNavigateUrlFormatString="~/Patient%20Billing/PanelCompany_BillAdjustment.aspx?RegNo={0}&YearlyNo={1}" Text="Edit Services" HeaderText=""  />   
                        <asp:HyperLinkField DataNavigateUrlFields="Reg_no" Target="_blank" DataNavigateUrlFormatString="~/Patient%20Billing/PanelCompanyCashLimit.aspx?RegNo={0}" Text="Edit" HeaderText="Edit"  />
                        <asp:HyperLinkField DataNavigateUrlFields="Reg_no,YearlyNo" Target="_blank" DataNavigateUrlFormatString="~/Patient%20Billing/PatientSummaryCollection.aspx?RegNo={0}&YearlyNo={1}" Text="Summary" HeaderText="Summary"  />   


                        <asp:TemplateField HeaderText="Registration No" SortExpression="Reg_no">
                            <ItemTemplate>
                            <asp:LinkButton ID="lbl_reg" CommandArgument="ViewReport" runat="server" onclick="lbl_reg_Click" ></asp:LinkButton>

                                <asp:HiddenField ID="hf_Company_ID" runat="server" value='<%# Bind("Party_Id") %>' />
                                <asp:HiddenField ID="hf_Company_Name" runat="server" value='<%# Bind("Party_Name") %>' />                                                                
                                <asp:HiddenField ID="hf_reg" runat="server" value='<%# Bind("Reg_no") %>' />
                               <asp:HiddenField ID="hf_smp_id" runat="server" value='<%# Bind("SMPID") %>' />
                               <asp:HiddenField ID="hf_yearlyNo" runat="server" value='<%# Bind("YearlyNo") %>' />
                                <asp:HiddenField ID="hf_PartyAmount" runat="server" value='<%# Bind("Party_Amount") %>' />
                                 <asp:HiddenField ID="hfd_TotalBill" runat="server" value='<%# Bind("TotalBill") %>' />
                                <asp:HiddenField ID="hf_Patient_final_bill_id" runat="server" value='<%# Bind("Patient_final_bill_id")%>' />
                                <asp:HiddenField ID="hf_InvoiceDate" runat="server" value='<%# Bind("dis_Time")%>' />
                                
                            </ItemTemplate>
                            
                        </asp:TemplateField>
                        <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" 
                            SortExpression="YearlyNo" />
                        <asp:TemplateField HeaderText="Patient Name">
                         <ItemTemplate>
                                <asp:Label ID="lbl_name" runat="server" ></asp:Label>
                                <asp:HiddenField ID="hf_Prefix" runat="server" value='<%# Bind("Prefix") %>' />
                                <asp:HiddenField ID="hf_PFName" runat="server" value='<%# Bind("PFName") %>' />
                                <asp:HiddenField ID="hf_PMName" runat="server" value='<%# Bind("PMName") %>' />
                                <asp:HiddenField ID="hf_PLName" runat="server" value='<%# Bind("PLName") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" 
                            SortExpression="Remarks" />
                        
                             <asp:BoundField DataField="Main_ID" HeaderText="Lab #" 
                            SortExpression="Main_ID" />
                           
                        <asp:BoundField DataField="dis_Time" HeaderText="Discharge Time" 
                            SortExpression="dis_Time" />
                        <asp:BoundField DataField="Employee" HeaderText="Employee" 
                            SortExpression="Employee" />
                            <asp:BoundField DataField="Party_Name" HeaderText="Party Name" 
                            SortExpression="Party_Name" />
                             <asp:BoundField DataField="Party_Amount" HeaderText="Party Amount" 
                            SortExpression="Party_Amount" />
                             <asp:BoundField DataField="Patient_Amount" HeaderText="Patient Amount" 
                            SortExpression="Patient_Amount" />
                          <asp:BoundField DataField="Refund_Amount" HeaderText="Refund Amount" 
                            SortExpression="Refund_Amount" />
                            <asp:BoundField DataField="TotalBill" HeaderText="Total Bill" 
                            SortExpression="TotalBill" />
                        <asp:TemplateField Visible="false">
                            <HeaderTemplate>
                                <asp:CheckBox ID="CK_main" runat="server" AutoPostBack ="true"  Text="Recieveable"
                                    oncheckedchanged="CK_main_CheckedChanged" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="Ck_Sub" runat="server" Visible='<%# Eval("V_CK") %>' />   
                                <asp:LinkButton ID ="Lbl_Voucher" runat = "server" OnClick="Lbl_Voucher_Click" Text='<%# Eval("Voucher_Trans_ID") %>' Visible='<%# Eval("V_VT") %>'></asp:LinkButton>
                           
                                 </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="CK_PanalInvoicemain" runat="server" AutoPostBack ="true"  Text="Invoices"
                                    oncheckedchanged="CK_PanalInvoicemain_CheckedChanged" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CK_PanalInvoiceSub"  runat="server"  Visible='<%# Eval("I_CK") %>' />                                   
                                <asp:LinkButton ID ="Lbl_VoucherPanal" CommandArgument="ViewInvoice" runat="server" onclick="lbl_reg_Click"   Text='<%# Eval("InvoiceID") %>' Visible='<%# Eval("I_VT") %>'></asp:LinkButton>                                
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                
                 <asp:SqlDataSource ID="sds_bill" runat="server" 
                    CancelSelectOnNullParameter="False" 
                    ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>" 
                    SelectCommand="Patient_Panel_Billing_report_final" 
                    SelectCommandType="StoredProcedure" InsertCommand="JV_Panel_Receivable" 
                    InsertCommandType="StoredProcedure">
                    
                     <InsertParameters>
                         <asp:SessionParameter Name="By_Emp_Id" SessionField="emp_ID" Type="Int32" />
                         <asp:SessionParameter Name="Dept_Id" SessionField="Dept_ID" Type="Int32" />
                         <asp:SessionParameter Name="SubDept_Id" SessionField="SubdeptID" 
                             Type="Int32" />
                         <asp:Parameter Name="SMP_ID" Type="Int32" />
                         <asp:Parameter Name="Company_Id" Type="Decimal" />
                         <asp:Parameter Name="CompanyName" Type="String" />
                         <asp:Parameter Name="Reg_No" Type="String" />
                         <asp:Parameter Name="Yearly_No" Type="Int32" />
                     </InsertParameters>
                     <SelectParameters>
                         <asp:ControlParameter ControlID="DropDownList_Parties" Name="Party_Id" 
                             PropertyName="SelectedValue" Type="Decimal" DefaultValue="" />
                         <asp:Parameter Name="StartDate" Type="DateTime" />
                         <asp:Parameter Name="EndDate" Type="DateTime" />
                           <asp:ControlParameter ControlID="ddl_Hospital" Name="HospitalID" PropertyName="SelectedValue" Type="Int32" />
                     </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:Button ID="Btn_Payable" Visible="false" runat="server" Text="Create Recieveable" />
                <asp:Button ID="btnGenerateInvoice" Visible="false" runat="server" Text="Generate Invoice" />
                <asp:Label ID="LBL_Message" runat="server" CssClass= "errmsg" style="font-weight:bold;" > </asp:Label>
                <br />
            </td>
 
        </tr>
    </table>

       <asp:Panel ID="pnlReport" runat="server">
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
    </asp:Panel>
    <asp:Panel ID="pnlEditDates" runat="server" CssClass="lightbox" Visible="false">
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="center" width="50%" style=" font-weight:bold;">Reg No : 
                    <asp:Label ID="lblRegNo" runat="server" ></asp:Label>
                </td>
                <td align="center" width="50%" style=" font-weight:bold;">
                    Visit No : 
                    <asp:Label ID="lblYearlyNo" runat="server" ></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">Admission Date :</td>
                <td align="left" width="50%">
                    <igsch:WebDateChooser ID="wdcAdmissionDate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                    </igsch:WebDateChooser>

                </td>
            </tr>
             <tr>
                <td align="right" width="50%">Discharge Date :</td>
                <td align="left" width="50%">
                    <igsch:WebDateChooser ID="wdcDischargeDate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnUpdateDates" runat="server" Text="Update" OnClick="btnUpdateDates_Click" />
                    <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" />

                </td>
            </tr>
        </table>
    </asp:Panel>
    
</asp:Content>

