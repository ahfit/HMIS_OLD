<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="DoctorShareReport.aspx.cs" Inherits="DashBoards_DoctorShareReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 100%;
        }

        .style2 {
            width: 386px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server" id="ScriptManager1"/>
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Doctor Share Report</span></h2>

        <table class="style1">
            <td align="right" style="width:100px;">
                    Category :

                </td>
                <td style="width: 250px;">
                    <asp:DropDownList ID="DropDownListCategory" runat="server" DataValueField="Dept_ID" DataTextField="Dept_Name"
                        AutoPostBack="true" OnSelectedIndexChanged="DropDownListCategory_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:100px;">
                    Services :

                </td>
                <td style="width: 250px;">
                    <asp:DropDownList ID="DropDownListServices" runat="server" DataValueField="" DataTextField="Dept_Name"
                        AutoPostBack="true" >
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 100px;">
                    Departments :
                </td>
                <td style="width: 250px;">
                    <asp:DropDownList ID="ddlDepartment" runat="server" DataValueField="Dept_ID" DataTextField="Dept_Name"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                </tr>
            <tr>            <td align="right" style="width: 100px;">
                    Select Consultant :
                </td>
                <td style="width: 150px;">
                    <asp:DropDownList ID="DDL_Consultant" runat="server" DataTextField="Name" DataValueField="EmpID">
                    </asp:DropDownList>
                </td>
            <tr>
                <td width="40%" align="right">Start Date
                </td>
                <td width="60%" align="left">
                    <asp:TextBox runat="server" ID="txtSDate" TextMode="Date" />
                </td>
            </tr>
            <tr>
                <td width="40%" align="right">End Date
                </td>
                <td width="60%" align="left">
                    <asp:TextBox runat="server" ID="txtEDate" TextMode="Date" />
                </td>
            </tr>
                  <tr>
                <td width="40%" align="right">Shift
                </td>
                <td width="60%" align="left">
                   <asp:DropDownList runat="server" ID="ddl_shift">
                       <asp:ListItem Selected="True" Value="0">    ALL </asp:ListItem>
                       <asp:ListItem Value="53">Morning </asp:ListItem>
                         <asp:ListItem Value="2">Evening </asp:ListItem>
                         <asp:ListItem Value="3">Night </asp:ListItem>
                   </asp:DropDownList>
                </td>
            </tr>
         
                  <tr>
                <td width="40%" align="right">Type
                </td>
                <td width="60%" align="left">
                        <asp:DropDownList runat="server" ID="ddl_type">
                       <asp:ListItem Selected="True" Value="ALL">    ALL </asp:ListItem>
                       <asp:ListItem Value="OPD">OPD </asp:ListItem>
                         <asp:ListItem Value="IPD">IPD </asp:ListItem>
                        
                   </asp:DropDownList>
                </td>
            </tr>

                   <tr>
                <td width="40%" align="right">Tax
                </td>
                <td width="60%" align="left">
                    <asp:TextBox runat="server" ID="txtTax" TextMode="Number" />
                </td>
            </tr>



            <tr>

                <td colspan="2" align="center">
                    <asp:Button ID="btnReport"  runat="server" Text="Report" 
                        OnClick="btnReport_Click" />

                </td>
            </tr>

        </table>
    </div>
     <div>
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
