<%@ Page  Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="ICDRecordReport.aspx.cs" Inherits="Pt_EMR_ICDRecordReport" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>ICD Record Report</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="40%" class="tbl_form">
            <tr>
                <td align="right">Category :</td>
                <td align="left">
                    <asp:DropDownList ID="ddlCategory" Height="20px" runat="server"></asp:DropDownList></td>
                <td align="right">MR# :</td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtregoNo" />
                </td>
            </tr>
            <tr>
                <td align="right">From Date:
                </td>
                <td>
                    <asp:TextBox runat="server" ID="wdcStartDate" TextMode="Date" />
                </td>
                <td align="right">To Date:
                </td>
                <td>
                    <asp:TextBox runat="server" ID="wdcEndDate" TextMode="Date" />
                </td>
            </tr>
            <tr>
                <td align="right"></td>
                <td align="center">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100px" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div class="bxmain inner_content" style="width: 100%;">
        <asp:GridView ID="gridview" runat="server" Width="100%" AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Label ID="lbl_name" Text='<%# Bind("PatientName") %>' runat="server" />
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="MR#">
                    <ItemTemplate>
                        <asp:Label ID="lbl_MR" Text='<%# Bind("RegNo") %>' runat="server" />
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Visit#">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Visit" Text='<%# Bind("PayID") %>' runat="server" />
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cell#">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Cell" Text='<%# Bind("MobilePhone") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Detail">
                    <ItemTemplate>
                       <%--<asp:LinkButton ID="lnkshowreport" Text="Show Report" runat="server" CommandArgument='<%#Eval("ShowReport") %>'OnClick="lnkshowreport_Click"></asp:LinkButton>--%>
                        <%-- <asp:Label ID="lbl_detail" Text='<%# Bind("Type") %>' runat="server" />--%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
   
    <div style="width: 80%; height: 100%; margin: 0 auto; text-align:center;">
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server" Height="900px" >
        </rsweb:ReportViewer>
    </div>
    <asp:ScriptManager ID="manager" runat="server">
    </asp:ScriptManager>
</asp:Content>
