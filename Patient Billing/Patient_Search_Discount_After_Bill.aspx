<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Patient Billing/Patient_Search_Discount_After_Bill.aspx.cs" Inherits="Patient_Billing_Patient_Search_Discount_After_Bill" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /* Table Border & Padding */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }

        /* Header Row */
        .header-style {
            background-color: lightgray;
            color: white;
            font-weight: bold;
            font-size: 16px;
            padding: 10px;
            text-align: center;
        }

        /* Alternating Row Colors */
        .row-white {
            background-color: #ffffff;
        }

        .row-gray {
            background-color: #f2f2f2;
        }

        /* Cell Text Centering */
        .cell-center {
            text-align: left;
            padding: 8px;
        }

        /* Stylish Paging */
        .pager-style a, .pager-style span {
            display: inline-block;
            padding: 8px 12px;
            margin: 2px;
            border: 1px solid #007BFF;
            color: #007BFF;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
        }

        .pager-style span {
            background-color: #007BFF;
            color: white;
        }

        .pager-style a:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%">
        <span>
            <h2>Patient Search For Discount</h2>
        </span>

        <table class="diagnosis_list">
            <tr>
                <td style="width: 20%; text-align: right">
                    <strong>From Date :</strong></td>
                <td>
                    <asp:TextBox ID="txtfromdate" runat="server" TextMode="Date" Width="202px">
                    </asp:TextBox>
                </td>

                <td style="width: 20%; text-align: right">
                    <strong>To Date :</strong></td>
                <td>
                    <asp:TextBox ID="txttodate" runat="server" TextMode="Date" Width="202px">
                    </asp:TextBox>
                </td>
            </tr>
            <tr>
            <tr>
                <td style="width: 20%; text-align: right">Reg # :</td>
                <td>
                    <asp:TextBox ID="TextBoxRegNo" runat="server" Width="202px"></asp:TextBox>
                </td>
                <td style="width: 20%; text-align: right">Visit #</td>
                <td>
                    <asp:TextBox ID="TextBoxYearlyNo" runat="server" Width="202px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%; text-align: right">Mobile # :</td>
                <td>
                    <asp:TextBox ID="txtMobile" runat="server" Width="202px"></asp:TextBox>
                </td>
                <td style="width: 20%; text-align: right">CNIC # :</td>
                <td>
                    <asp:TextBox ID="txtcnic" runat="server" Width="202px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btn_Ledger" runat="server" Text="Search" OnClick="btn_Ledger_Click" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            AllowPaging="True" PageSize="20"
            OnPageIndexChanging="GridView1_PageIndexChanging"
            CssClass="gridview">
            <HeaderStyle HorizontalAlign="Center" CssClass="header-style" VerticalAlign="Middle" />
            <RowStyle CssClass="row-white" />
            <AlternatingRowStyle CssClass="row-gray" />
            <PagerStyle CssClass="pager-style" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk_Discount" runat="server" Text="Approve Discount" OnClick="lnk_Discount_Click" CommandArgument='<%# Eval("RegNo") %>' ToolTip='<%# Eval("VisitNo") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="RegNo" HeaderText="Registration No" ItemStyle-CssClass="cell-center" />
                <asp:BoundField DataField="VisitNo" HeaderText="Visit No" ItemStyle-CssClass="cell-center" />
                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" ItemStyle-CssClass="cell-center" />
                <asp:BoundField DataField="Gender" HeaderText="Gender" ItemStyle-CssClass="cell-center" />
                <asp:BoundField DataField="PatientAge" HeaderText="Age" ItemStyle-CssClass="cell-center" />
                <asp:BoundField DataField="MobilePhone" HeaderText="Mobile" ItemStyle-CssClass="cell-center" />
                <asp:BoundField DataField="CNIC" HeaderText="CNIC" ItemStyle-CssClass="cell-center" />
                <asp:BoundField DataField="RegistrationDate" HeaderText="Registration Date" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-CssClass="cell-center" />
                <asp:BoundField DataField="Patient_Type" HeaderText="Patient Category" ItemStyle-CssClass="cell-center" />
                <asp:BoundField DataField="PType" HeaderText="Patient Type" ItemStyle-CssClass="cell-center" />
            </Columns>
        </asp:GridView>
        <asp:Label ID="lblError" runat="server" ForeColor="Red" />
    </div>
</asp:Content>

