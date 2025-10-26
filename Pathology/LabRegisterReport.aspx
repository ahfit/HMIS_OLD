<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="LabRegisterReport.aspx.cs" Inherits="Pathology_LabRegisterReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style="width:100%">
           <h2><span>Lab Register</span></h2>
                <table class="style1" style="margin-left:220px">
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
                    <tr style="display:none">
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
                                DataTextField="TGName" DataValueField="TGID" AutoPostBack="true"
                                Width="200px" onselectedindexchanged="ddlTestGroup_SelectedIndexChanged" >
                            </asp:DropDownList>
                        </td>
                         <td class="style2">
                          Test Name :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlTestName" runat="server" 
                                DataTextField="TB_Name" DataValueField="TB_ID"  
                                Width="200px"  >
                            </asp:DropDownList>
                        </td>
                   </tr>
                    <tr>
                        <td class="style2" style="display:none">
                            Patient Type :
                        </td>
                        <td class="style3" style="display:none">
                            <asp:DropDownList ID="DropDownList_PatientType" runat="server" 
                                DataTextField="Patient_type" DataValueField="ID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                        <td class="style2" style="display:none">
                          OPD/IPD :
                        </td>
                        <td class="style3" style="display:none">
                            <asp:DropDownList ID="typeid" runat="server"                                 
                                Width="200px" >
                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                <asp:ListItem Text="OPD" Value="OPD"></asp:ListItem>
                                <asp:ListItem Text="IPD" Value="IPD"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2" style="display:none">
                            Status:</td>
                        <td class="style3" style="display:none">
                            <asp:DropDownList ID="DDLServiceStatus" runat="server" Width="153px">
                                <asp:ListItem Selected="True">All</asp:ListItem>
                                <asp:ListItem>Paid</asp:ListItem>
                                <asp:ListItem>Cancel</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="style2" style="display:none">
                            Parties :</td>
                        <td class="style3" style="display:none">
               <asp:DropDownList ID="DropDownList_Parties" runat="server" AutoPostBack="false" 
                                                                    
                    DataSourceID="SqlDataSource_parties" DataTextField="Party_Name" 
                                                                    DataValueField="Party_Id">
                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" 
                                                                    
                                                                    
                    ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" 
                    SelectCommand="SELECT  0 as Party_Id, ' ---ALL---' Party_Name UNION  Select  Parties.Party_Id, Parties.Party_Name
FROM         Parties 
INNER JOIN   Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id
order by Party_Name ">
                                                                </asp:SqlDataSource>

                        </td>
                    </tr>
                    <tr>
                      
                        <td></td>
                    <td colspan="2" align="center" style="padding-top:20px">
                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="View Report"  
                             CssClass="btn_1" style="float:right"/>
                      </td>
                           <td colspan="2" align="center" style="padding-top:20px">
                        <asp:Button ID="btnDepartmentView" runat="server" Text="Department Count" Visible="false"
                             CssClass="btn_1" style="float:right" OnClick="btnDepartmentView_Click"/>
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

