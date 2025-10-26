<%@ Page Title="" Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="~/Leave_Management/LeaveBalanceReport.cs" Inherits="Leave_Management_LeaveBalanceReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="bxmain inner_content" style="width:100%">
           <h2><span>Card Expire Report</span></h2>
                <table class="style1" style="margin-left:320px">
            
                    <tr>
                        <td class="style2">
                           Department :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_SubDeptId" runat="server"  OnSelectedIndexChanged="ddl_SubDeptId_SelectedIndexChanged" AutoPostBack="true"
                                DataTextField="EmployeeName" DataValueField="EmpID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                        <td class="style2">
                           Employee :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_Employee" runat="server"   
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                      <td class="style2">
                           Balance Year :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlBalanceYear" runat="server"   >
                             <asp:ListItem Text="2018" Value="2018"></asp:ListItem>
                                <asp:ListItem Text="2019" Value="2019"></asp:ListItem>
                                <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        
                   </tr>
                   
                    
         
                    <tr>
         
                    <td colspan="2" align="center">
                        <asp:Button ID="btnSearch" runat="server" Text="View Report"  OnClick="btnSearch_Click"
                             CssClass="btn_1" style="float:right"/>
                      </td>
                    </tr>
    </table>



    </div>

    <div style="width: 100%; margin-top:20px;">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>



</asp:Content>

