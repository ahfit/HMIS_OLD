<%@ Page Title="" Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="EmployeeLeftReport.aspx.cs" Inherits="HR_EmployeeLeftReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
     <div class="bxmain inner_content" style="width:100%">
           <h2><span>Left Employees  Report </span></h2>
                <table class="form-tbl" style="width:80%">
                    <tr>
                        <td class="tbl-column-1">
                            From Date :</td>
                        <td class="style3">
                            &nbsp;<asp:TextBox ID="txtfromdate" runat="server" TextMode="Date">
                    </asp:TextBox>
                            <asp:TextBox ID="hffromdate" runat="server" Visible="false" />
                        </td>
                    
                        <td class="tbl-column-3">
                            To Date :</td>
                        <td class="style3">
                            &nbsp;<asp:TextBox ID="txttodate" runat="server" TextMode="Date">
                    </asp:TextBox>
                            <asp:TextBox ID="hftodate" runat="server" Visible="false" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tbl-column-1">
                           Department :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_SubDeptId" runat="server"  OnSelectedIndexChanged="ddl_SubDeptId_SelectedIndexChanged" AutoPostBack="true"
                                DataTextField="EmployeeName" DataValueField="EmpID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                        <td class="tbl-column-3">
                           Employee :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_Employee" runat="server"  OnSelectedIndexChanged="ddl_Employee_SelectedIndexChanged" AutoPostBack="true"
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                    
                        
                   </tr>
                    <tr>
                        <td class="tbl-column-1">
                           Designation :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_Designation" runat="server" 
                                DataTextField="Designation_Name" DataValueField="Designation_ID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                    
                        <td class="tbl-column-3">
                           Employee Type :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_EType" runat="server" 
                                DataTextField="Type" DataValueField="Employee_Type_ID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="tbl-column-1">
                           Employee Status :
                        </td>
                        <td class="style3">
                           

                             <asp:DropDownList ID="ddl_EmployeeType" runat="server" 
                                Width="200px" >
                                <asp:ListItem Value="" Selected="True">All</asp:ListItem>
                                
                                <asp:ListItem Value="1" >Working</asp:ListItem>
                                
                                <asp:ListItem Value="0" >Left</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
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

