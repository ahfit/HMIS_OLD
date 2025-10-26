<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EmployeeAppraisalReport.aspx.cs" Inherits="HR_EmployeeAppraisalReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Employee Appraisal</span></h2>

        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
              <tr>
            <td align="right"  width="40%">
                Hospital : </td>
            <td >
                <asp:DropDownList ID="ddlhospital" runat="server" AutoPostBack="True" DataSourceID="sqlhospital" OnSelectedIndexChanged="ddlhospital_SelectedIndexChanged"
                    DataTextField="Hospital_Name" DataValueField="Hospital_ID"  >
                </asp:DropDownList><asp:SqlDataSource ID="sqlhospital" runat="server"
                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT '0' AS Hospital_ID,'All' as Hospital_Name union select a.Hospital_ID,a.Hospital_Name from Hospital a">
                </asp:SqlDataSource>
            </td>
             
        </tr>
             <tr>
            <td align="right"  width="40%">
                Department : </td>
            <td >
                <asp:DropDownList ID="ddldept" runat="server" AutoPostBack="True"  OnSelectedIndexChanged="ddldept_SelectedIndexChanged"></asp:DropDownList>               
                
            </td>
             
        </tr>
            
              <tr>
                <td width="20%" align="right"> Sub Department :  </td>
                <td class="radio-Type"> 
                    <asp:DropDownList ID="DropDownListSubDepartment" AutoPostBack="true" OnSelectedIndexChanged="DropDownListSubDepartment_SelectedIndexChanged" runat="server"></asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td width="20%" align="right">Employee :  </td>
                <td class="radio-Type"> 
                    <asp:DropDownList ID="ddlEmployee" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td width="20%" align="right">Financial Year :  </td>
                <td class="radio-Type"> 
                    <asp:DropDownList ID="ddlFinancialYear" runat="server"></asp:DropDownList>
                </td>
            </tr>
           <%-- <tr>
                <td width="20%" align="right">Designation :  </td>
                <td class="radio-Type">--%>
                    <asp:DropDownList  ID="ddlDesignation" runat="server" Enabled="false" Visible="false"></asp:DropDownList>
                <%--</td
            </tr>--%>

            <tr  visible="false">
                <td width="20%" align="right" visible="false">Heading :  </td>
                <td>
                    <asp:DropDownList ID="ddlHeading" runat="server" AutoPostBack="true"  >
                    </asp:DropDownList>
                </td>
            </tr>
             
             
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnReport" runat="server" Text="Report" OnClick="btnReport_Click" />
                    <asp:Label ID="lblmsg" runat="server" Visible="false" Font-Bold="true" Font-Size="Large" ForeColor="Green"></asp:Label>
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

