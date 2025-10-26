<%@ page language="C#" autoeventwireup="true" inherits="Finance_NewInvoice, App_Web_ymbcbbcj" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script type="text/javascript">

        function ClientItemSelected(sender, e) {
            $("[id$='lblInvoiceCode']").html(e.get_value());

        }
 
    </script>
    <style type="text/css">
        .style1
        {
            font-weight: bold;
            width: 49%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>New Invoice Against Party</span></h2>
        <table class="table-form" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td align="right" class="style1">
                    Purchases
                  Invoice :&nbsp;&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Exp_Name" runat="server" ></asp:TextBox>
                     <asp:AutoCompleteExtender ID="Auto_Complete_Extender_Head" runat="server" ServiceMethod="SearchHead"
                        MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="TextBox_Exp_Name" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected">
                    </asp:AutoCompleteExtender>

                    <span style="font-weight: bold;color: blue;" >
                    <asp:Label ID="lblInvoiceCode" runat="server"></asp:Label>
                    </span>
                    
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    Invoice Company :&nbsp;&nbsp;
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="DDL_Parties" DataValueField="Party_Id"
                        DataTextField="Party_Name" 
                        OnSelectedIndexChanged="DDL_Parties_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    Invoice # :&nbsp;&nbsp;
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtInvoiceNo"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    Invoice Date :&nbsp;&nbsp;
                </td>
                <td>
                    <asp:TextBox runat="server" ID="webdateChooser_Invoice_Date" ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1" valign="top">
                    Invoice Amount :&nbsp;&nbsp;
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtAmount" SkinID="intdata"></asp:TextBox>
                    <br />
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    &nbsp;Invoice Description :&nbsp;&nbsp;
                </td>
                <td>
                    <asp:TextBox TextMode="MultiLine" Height="80" runat="server" ID="txtDescription"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    Invoice Attachment :&nbsp;&nbsp;
                </td>
                <td>
                    <asp:FileUpload runat="server" ID="file1" />
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    Other Attachment :&nbsp;&nbsp;
                </td>
                <td>
                    <asp:FileUpload runat="server" ID="file2" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button runat="server" ID="btnSave" OnClick="btnSave_Click" Text="Save" />
                    <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                </td>
            </tr>
           
        </table>
    </div>
    <div style="margin-top:15px; width:100%;">
       
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                        Width="100%">
                        <Columns>
                            <asp:BoundField DataField="Party_Name" HeaderText="Company" SortExpression="Party_Name" />
                            <asp:BoundField DataField="PO_NO" HeaderText="Account Head" SortExpression="PO_NO" />
                            <asp:BoundField DataField="Invoice_No" HeaderText="Invoice No" SortExpression="Invoice_No" />
                            <asp:BoundField DataField="Invoice_Date" HeaderText="Invoice Date" SortExpression="Invoice_Date" />
                            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="Name" HeaderText="Post by" SortExpression="Name" />
                            <asp:HyperLinkField DataNavigateUrlFields="invoice_ID" DataNavigateUrlFormatString="~/Finance/invoice_report.aspx?ID={0}"
                                HeaderText="invoice detail" Target="_blank" Text="view" Visible="False" />
                            <asp:HyperLinkField DataNavigateUrlFields="Party_ID" DataNavigateUrlFormatString="~/Finance/Payment_To_Vender.aspx?Party_ID={0}"
                                Target="_blank" Text="Approve" />
                        </Columns>

                    </asp:GridView>
                    
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT Invoices.Invoice_ID, Invoices.Party_Id, Invoices.PO_NO, Invoices.Invoice_No, Invoices.Invoice_Date, Invoices.Amount, Invoices.Description, Parties.Party_Name, Employee.Name FROM Invoices INNER JOIN Parties ON Invoices.Party_Id = Parties.Party_Id INNER JOIN Employee ON Invoices.Enter_By = Employee.EmpID">
                    </asp:SqlDataSource>
             
    </div>
</asp:Content>
