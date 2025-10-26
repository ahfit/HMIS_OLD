<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="FinaceHeadWiseDrCr.aspx.cs" Inherits="Patient_Billing_FinaceHeadWiseDrCr" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="pnlFilter" runat="server">
    <div  class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Services Category Wise Report</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="40%" class="tbl_form">
           
            
             <tr>
                <td align="right" style="width: 10%;">Hospital: 
                </td>
                <td style="width: 20%;">
                    <asp:DropDownList ID="ddHospital" runat="server" OnSelectedIndexChanged="ddHospital_SelectedIndexChanged" DataTextField="Hospital_Name" DataValueField="Hospital_ID" AutoPostBack="true" DataSourceID="SqlDataSource_Hospital">
                        
                    </asp:DropDownList>
                     <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource> 
                </td>
                <td align="right" style="width: 10%;">Department:
                </td>
                <td style="width: 20%;">
                    <asp:DropDownList ID="ddlDepartment" runat="server">
                    </asp:DropDownList>
                </td>
                <td align="right" style="width: 10%;">Patient Type:
                </td>
                <td style="width: 20%;">
                    <asp:DropDownList ID="ddlPatientType" runat="server" Visible="false">
                    </asp:DropDownList>

                       <asp:DropDownList ID="ddlOPDIPD" runat="server">
                        <asp:ListItem Value="" Text="All" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="OPD" Text="OPD"></asp:ListItem>
                        <asp:ListItem Value="IPD" Text="IPD"></asp:ListItem>
                    </asp:DropDownList>

                  
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 10%;">Counter Type
                </td>
                <td style="width: 20%;">
                     <asp:DropDownList ID="DDL_CounterType" runat="server">
                    </asp:DropDownList>
                </td>
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
                <td></td>
                <td>
                     <asp:DropDownList ID="DDL_Employee" runat="server" DataSourceID="SDS_Employee" 
                DataTextField="NAME" DataValueField="EmpID"  Visible="false">
            </asp:DropDownList>
                <br />
            <asp:SqlDataSource ID="SDS_Employee" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                
                    SelectCommand="SELECT '' NAME,0 EmpID
UNION ALL
SELECT ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS NAME, Employee.EmpID
FROM Employee INNER JOIN Receptionist 
ON Employee.EmpID = Receptionist.Receptionist_id 
WHERE (Employee.ActiveStatus = 1)">
            </asp:SqlDataSource>
                </td><td></td>
                <td      colspan="4">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100px" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
        </asp:Panel>
    <div style="width: 80%; height: 100%; margin: 0 auto; text-align:center;">
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server" Height="900px" >
        </rsweb:ReportViewer>
    </div>
    <asp:ScriptManager ID="manager" runat="server">
    </asp:ScriptManager>
</asp:Content>
