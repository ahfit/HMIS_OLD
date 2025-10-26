<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Pathology/LabTestSummaryReportCostCenter.aspx.cs" Inherits="Pathology_LabTestSummaryReportCostCenter" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="bxmain inner_content" style="width:100%">
           <h2><span>Lab Test Summary Report</span></h2>
                <table class="style1" style="margin-left:320px">
                    <tr>
                        <td class="style2">
                            From Date :</td>
                        <td class="style3">
                            &nbsp;<asp:TextBox ID="txtfromdate" runat="server" TextMode="Date">
                    </asp:TextBox>
                            <asp:TextBox ID="hffromdate" runat="server" Visible="false" />
                        </td>
                    
                        <td class="style2" style="margin-right:10px" >
                            To Date :</td>
                        <td class="style3">
                            &nbsp;<asp:TextBox ID="txttodate" runat="server" TextMode="Date">
                    </asp:TextBox>
                            <asp:TextBox ID="hftodate" runat="server" Visible="false" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                           Department :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlDepartment" runat="server" 
                                DataTextField="Dept_Name" DataValueField="Dept_ID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                        <td class="style2">
                          Test Group :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlTestGroup" runat="server" 
                                DataTextField="TGName" DataValueField="TGID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                   </tr>
                    <tr>
                        <td class="style2">
                            Patient Type :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="DropDownList_PatientType" runat="server" 
                                DataTextField="Patient_type" DataValueField="ID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                         <td class="style2">
                            Sent Out Lab :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="DDL_LabCenter" runat="server" 
                                DataTextField="LabCenter" DataValueField="ID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>

                    </tr>
                    
                    <tr>
                      
                        <td></td>
                    <td colspan="2" align="center" style="padding-top:20px">
                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="View Report"  
                             CssClass="btn_1" style="float:right"/>
                      </td>
                    </tr>
    </table>
    </div>

    <div style="width: 100%; margin-top:20px;">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
       <rsweb:ReportViewer ID="ReportViewer1"  runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>



</asp:Content>

