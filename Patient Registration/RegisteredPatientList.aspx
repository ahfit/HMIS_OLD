<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="RegisteredPatientList.aspx.cs" Inherits="Patient_Registration_RegisteredPatientList" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            text-align: right;
            width: 50%;
        }

        .style2 {
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>New Patient Registered</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
             <tr>
            <td align="right"><b>Hospital :</b></td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
            <tr>
                <td class="style1">
                    <b>From Date : </b>
                </td>
                <td class="style2">
                    <asp:TextBox runat="server" ID="txtDateFrom" TextMode="Date" />
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <b>To Date : </b>
                </td>
                <td class="style2">
                    <asp:TextBox runat="server" ID="txtDateTo" TextMode="Date" />
                </td>
            </tr>
            <tr>
                  <td class="style1">
                    <b>Department : </b>
                </td>
                <td class="style2">
                    <asp:DropDownList ID="ddlDepartment" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
               <tr>
                  <td class="style1">
                    <b>New/Old Patient : </b>
                </td>
                <td class="style2">
                    <asp:DropDownList ID="DropDownListRank" runat="server">
                      <asp:ListItem Value="1" Selected="True"> New </asp:ListItem>  
                       <asp:ListItem Value="0"> Old </asp:ListItem>  
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" Width="100px" />
                </td>
            </tr>
        </table>

    </div>
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
    </rsweb:ReportViewer>

</asp:Content>
