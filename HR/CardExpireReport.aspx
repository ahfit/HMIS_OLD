<%@ Page Title="" Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="CardExpireReport.aspx.cs" Inherits="HR_CardExpireReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="bxmain inner_content" style="width:100%">
           <h2><span>Card Expire Report</span></h2>
                <table class="style1" style="margin-left:320px">
                    <tr>
                        <td class="style2">
                            From Date :</td>
                        <td class="style3">
                          <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                            <asp:TextBox ID="hffromdate" runat="server" Visible="false" />
                        </td>
                    
                        <td class="style2">
                            To Date :</td>
                        <td class="style3">
                            <igsch:WebDateChooser ID="WebDateChooser_end_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                            <asp:TextBox ID="hftodate" runat="server" Visible="false" />
                        </td>
                    </tr>
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
                            <asp:DropDownList ID="ddl_Employee" runat="server"  AutoPostBack="true"
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                    
                        
                   </tr>
                    <tr>
                        <td class="style2">
                           Designation :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_Designation" runat="server" 
                                DataTextField="Designation_Name" DataValueField="Designation_ID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                    
                        <td class="style2">
                           Employee Type :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_EmployeeType" runat="server" 
                                Width="200px" >
                                <asp:ListItem Value="">All</asp:ListItem>
                                
                                <asp:ListItem Value="1" Selected="True">Working</asp:ListItem>
                                
                                <asp:ListItem Value="0">Left</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="style2">
                           Employee Status :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_EType" runat="server" 
                                DataTextField="Type" DataValueField="Employee_Type_ID" 
                                Width="200px" >
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

