<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="Patient_Receivables.aspx.cs" Inherits="Patient_Billing_Patient_Receivables" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
    function CheckQuantityLimit(valueCmp, recAmount) {
        try {
            var textBox = document.getElementById(recAmount);
            var maxAllow = parseInt(valueCmp);
            var enteredValue = parseInt(textBox.value);
            if (enteredValue > maxAllow) {
                alert('Maximum allowed amount : ' + maxAllow);
                textBox.value = "";
                textBox.focus();
            }
        }
        catch (e) {
            alert(e);
        }
    }
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager2" runat="server">
    </asp:ScriptManager>
    <div class="bxmain" style="width: 100% ! important">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr style="display:none">
                <td align="right">
                    Select Company :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Parties" runat="server" DataValueField="Party_Id"
                        DataTextField="Party_Name" DataSourceID="SqlDataSource_parties" AutoPostBack="false">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                        SelectCommand="SELECT 0 Party_Id,'  --- ALL ---' Party_Name UNION SELECT Party_Id, Party_Name FROM Parties WHERE (Party_Type_Id = 3)">
                    </asp:SqlDataSource>
                </td>
            </tr>
             <tr>
                <td align="right">
                    Select Employee :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataValueField="EmpID"
                        DataTextField="EmployeeName" DataSourceID="SqlDataSource1" AutoPostBack="false">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                        SelectCommand="select 0 as EmpID ,'--ALL--' as EmployeeName union SELECT distinct Employee.EmpID, ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS EmployeeName FROM  Employee Where Employee.ActiveStatus=1 order by EmployeeName">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right">
                    Start Date :
                </td>
                <td width="25%">
                    <igsch:WebDateChooser ID="start_date" runat="server" CssClass="drop_date">
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right">
                    End Date :
                </td>
                <td width="25%">
                    <igsch:WebDateChooser ID="end_date" runat="server" CssClass="drop_date">
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="search" runat="server" Text="Search" OnClick="SearchEmployee_Click" />
                    <asp:Button ID="ShowReport" runat="server" Text="Report" OnClick="Show_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="Btn_Ad_rec" runat="server" OnClick="Btn_Ad_rec_Click" Text="Receive" />
                </td>
            </tr>
        </table>
    </div>
    <hr />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="height: 30px; border-top: #CCC dotted 1px; width: 100%; display: block;
                line-height: 28px; font-weight: bold; color: #000000; font-size: 13px;">
                <div align="right" style="float: right;">
                    <strong>
                        <asp:Label ID="LabelGtotal" Visible="false" runat="server" Text="Recievable Amount :"></asp:Label></strong>
                    <strong>
                        <asp:Label ID="LabelTotal" runat="server" Visible="false" CssClass="marks"></asp:Label></strong></div>
            </div>
            <div>
                <asp:GridView ID="GridViewPatient" runat="server" AutoGenerateColumns="False" OnPreRender="GridViewPatient_PreRender"
                    ShowFooter="true" OnRowDataBound="GridViewPatient_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="MR #">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnRegNo" runat="server" Text='<%# Bind("RegNo") %>' OnClick="btnRegNo_Click"
                                    CommandArgument='<%# Eval("SPM_ID") %>' />
                             

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Name" HeaderText="Patient Name" />
                        <asp:BoundField DataField="Party_Name" HeaderText="C/O" />
                        <asp:BoundField DataField="DateTime" HeaderText="Date" />
                        <asp:BoundField DataField="TotalAmount" HeaderText="Bill Amount" />
                        <asp:BoundField DataField="Discount_Amount" HeaderText="Discount Amount" />
                        <asp:TemplateField HeaderText="Total Receivable">
                            <ItemTemplate>
                                <asp:Label ID="LabelAmount" runat="server" Text='<%# Bind("TotalReceiveable","{0:0,00}") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="footerAmount" runat="server" Text="Total Amount" Font-Bold="true"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Already Received">
                            <ItemTemplate>
                                <asp:Label ID="lblAlreadyReceived" runat="server" Text='<%# Bind("AlreadyRecAmount","{0:0,00}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Received Amount">
                            <ItemTemplate>
                                <asp:TextBox ID="txtReceivedAmount" runat="server" Text='<%# Eval("Amount","{0:0,00}") %>' AutoPostBack="true" ontextchanged="txtReceivedAmount_TextChanged"
                                 ></asp:TextBox>
                            </ItemTemplate>
                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Receivable Amount">
                            <ItemTemplate>
                                <asp:CheckBox ID="CHK_Pay" runat="server" AutoPostBack="true"
                                    OnCheckedChanged="CHK_Pay_CheckedChanged" />
                                <asp:HiddenField ID="HFD_Spm_ID" runat="server" Value='<%# Bind("SPM_ID") %>' />
                                   <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" Value='<%# Eval("YearlyNo", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldRegNo" runat="server" Value='<%# Eval("RegNo", "{0}") %>' />
                                <asp:HiddenField ID="hdfCashBook_ID" runat="server" Value='<%# Eval("CashBook_ID", "{0}") %>' />
                            </ItemTemplate>
                            <HeaderTemplate>
                                <asp:CheckBox ID="CHK_PayAll" runat="server" AutoPostBack="true" OnCheckedChanged="CHK_PayAll_CheckedChanged" />
                            </HeaderTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="post_by" HeaderText="Posted By" SortExpression="post_by" />
                        <asp:TemplateField HeaderText="Company Name">
                            <ItemTemplate>
                                <asp:Label ID="lblParty_ID" runat="server" Text='<%# Bind("Party_Id") %>' Visible="false" />
                                <asp:DropDownList ID="DDL_Parties" AutoPostBack="true" runat="server"  >
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false" HeaderText="Update">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" 
                                    ToolTip='<%# Eval("SPM_ID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
      <div>
     
    </div>

    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
        </rsweb:ReportViewer>
    </div>
     <div>
       <rsweb:ReportViewer ID="ReportViewer2" runat="server" Width="100%" Height="500px">
        </rsweb:ReportViewer>
         </div>
</asp:Content>
