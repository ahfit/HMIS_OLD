<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="~/Patient Billing/SearchServicesForCancelation.vb" Inherits="Patient_Billing_SearchServicesForCancelation" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

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
        .auto-style1 {
            width: 311px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Patient Services Status</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
           <tr>
                <td align ="right" class="auto-style1">Hospital</td>
        <td><asp:DropDownList ID="ddlHospital" runat = "server" DataSourceID="sdsHospital" DataTextField="Hospital_Name" 
           DataValueField="Hospital_ID" AutoPostBack="True" Width="262px"></asp:DropDownList></td>
        <asp:SqlDataSource ID ="sdsHospital" runat="server"  ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
        
        SelectCommand="SELECT 0 as [Hospital_ID] , ' All' as [Hospital_Name] union SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"
        
        ></asp:SqlDataSource>
            </tr>
             <tr>
                <td align="right" class="auto-style1">Reg #:</td>
                <td>
                    <asp:TextBox ID="txtRegNo" runat="server" Style="width: 177px;"></asp:TextBox>
                </td>

            </tr>
            <tr>
                <td align="right" class="auto-style1">Yearly No:</td>
                <td>
                    <asp:TextBox ID="txtYearlyNo" runat="server" Style="width: 177px;"></asp:TextBox>
                </td>

            </tr>
            <tr>
                <td align="right" class="auto-style1">Mobile # :</td>
                <td>
                    <asp:TextBox ID="txtMobileNo" runat="server" Style="width: 177px;" MaxLength="11"></asp:TextBox>
                </td>

            </tr>
            <tr>
                <td class="auto-style1"></td>
                <td>
                    <asp:Button ID="Btn_Search" runat="server" Text="Search" />
                </td>
            </tr>
        </table>
    </div>
    <div style="text-align: left; width: 100%; margin-top: 10px;">

        <asp:GridView ID="GridView_View_Payments" runat="server" AutoGenerateColumns="False"
            CssClass="Grid_1"  DataKeyNames="SPS_ID"
            Width="100%" ShowFooter="false" AllowPaging="True" PageSize="20" OnPageIndexChanging="GridView_View_Payments_PageIndexChanging">
            <Columns>
                <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" />
                <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo" />

                <asp:HyperLinkField DataNavigateUrlFields="RegNo,YearlyNo,SPM_ID" DataNavigateUrlFormatString="DuplicatepatientReceipt.aspx?RegNo={0}&amp;Yearlyno={1}&amp;SPMID={2}"
                    DataTextField="SPM_ID" HeaderText="Receipt No." Target="_blank" />
                <asp:BoundField DataField="PName" HeaderText="Patient Name" SortExpression="PName" />
                <asp:TemplateField HeaderText="Date Time" SortExpression="Date_Time">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Date_Time") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Date_Time") %>'></asp:Label>
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("P_SID", "{0}") %>' />
                        <asp:HiddenField ID="HiddenField_mainID" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                        <asp:HiddenField ID="HiddenField_Amount" runat="server" Value='<%# Eval("S_Amount", "{0}") %>' />
                        <asp:HiddenField ID="HiddenField_SPM_ID" runat="server" Value='<%# Eval("SPM_ID", "{0}") %>' />
                        <asp:HiddenField ID="HiddenFieldRegNo" runat="server" Value='<%# Eval("RegNo") %>' />
                        <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" Value='<%# Eval("YearlyNo") %>' />
                        <asp:HiddenField ID="HiddenFieldS_id" runat="server" Value='<%# Eval("S_ID") %>' />
                        <asp:HiddenField ID="HiddenFieldDiscount" runat="server" Value='<%# Eval("Discount") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                 <asp:BoundField DataField="S_Amount" HeaderText="Amount" SortExpression="S_Amount" />
                 <asp:BoundField DataField="Discount" HeaderText="Discount" SortExpression="Discount" />
                <asp:BoundField DataField="NetAmount" HeaderText="Net Amount" SortExpression="NetAmount" />
                <asp:BoundField DataField="S_Name" HeaderText="Service Name" SortExpression="S_Name" />
               <%--  <asp:BoundField DataField="Amount" HeaderText="Service Name" SortExpression="Amount" />--%>
                <asp:TemplateField HeaderText="Status" SortExpression="Status">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtn_cancel" runat="server" CausesValidation="False" CommandName="Select"
                            Text="Cancel" Visible='<%# Eval("Column1") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="SPS_ID" HeaderText="SPS_ID" InsertVisible="False" SortExpression="SPS_ID"
                    Visible="False" />
                <asp:BoundField DataField="P_SID" HeaderText="P_SID" SortExpression="P_SID" Visible="False" />

            </Columns>
            <RowStyle CssClass="GridItem" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <FooterStyle CssClass="myfooter" />
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource_For_View" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            UpdateCommand="Cancel_Paid_Payment" UpdateCommandType="StoredProcedure" SelectCommandType="StoredProcedure" SelectCommand="Search_cancel_Services" CancelSelectOnNullParameter="False">
            <SelectParameters>

                <asp:ControlParameter ControlID="txtRegNo" Name="Regno" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtYearlyNo" Name="YearlyNo" PropertyName="Text" Type="Int32" />
               

                <asp:ControlParameter ControlID="txtMobileNo" Name="MobileNo" PropertyName="Text" Type="String" />
               

            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="GridView_View_Payments" Name="SPS_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HiddenField_P_SID" Name="P_SID" PropertyName="Value"
                    Type="Int32" />
                <asp:Parameter DefaultValue="Request For Refund" Name="Status" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceRefundRequest" runat="server" CancelSelectOnNullParameter="False"
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" InsertCommand="InsertRefund"
            InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:Parameter Name="RegNo" />
                <asp:Parameter Name="YearlyNo" />
                <asp:Parameter Name="PS_ID" />
                <asp:Parameter Name="S_ID" />
                <asp:Parameter Name="SPM_ID" />
                <asp:SessionParameter Name="Requested_By" SessionField="emp_id" />
                <asp:Parameter Name="Amount" />
                <asp:Parameter Name="Discount" />
            </InsertParameters>
        </asp:SqlDataSource>

        <asp:HiddenField ID="HiddenField_P_SID" runat="server" />

    </div>
</asp:Content>
