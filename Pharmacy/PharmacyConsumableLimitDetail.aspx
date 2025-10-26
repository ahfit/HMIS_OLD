<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="PharmacyConsumableLimitDetail.aspx.cs" Inherits="Pharmacy_PharmacyConsumableLimitDetail" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>

        <table class="table-form">
            <tr>
                <td align="right"><b>From Date :</b></td>
                <td>
                    <asp:TextBox ID="txt_frmdate" runat="server" TextMode="Date"></asp:TextBox>
                </td>

                <td align="right"><b>To Date :</b></td>

                <td>
                    <asp:TextBox ID="txt_todate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>

             <tr>
                <td align="right"><b>Department :</b></td>
                <td>
                    <asp:DropDownList ID="ddl_deptid" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddl_deptid_SelectedIndexChanged"></asp:DropDownList>
                </td>

                <td align="right"><b>Sub Department :</b></td>

                <td>
                 <asp:DropDownList ID="ddl_subdeptid" runat="server"></asp:DropDownList>
                 </td>
            </tr>
            <tr>
                <td align="right"><b>Mr # :</b></td>
                <td>
                    <asp:TextBox ID="txt_Mr_No" runat="server" ></asp:TextBox>
            
                </td>
            </tr>
            <tr>
                <td></td>
                <td align="center">
                    <asp:Button ID="btn_Srch" runat="server" Text="Search" OnClick="btn_Srch_Click" />
                </td>
            </tr>
        </table>
        
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server"></rsweb:ReportViewer>

    </div>
</asp:Content>

