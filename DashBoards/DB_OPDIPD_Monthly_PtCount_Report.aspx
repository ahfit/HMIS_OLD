<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_OPDIPD_Monthly_PtCount_Report, App_Web_csihqmfb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
 <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
    .style1
    {
        text-align:right;
        width:50%;
    }
    .style2
    {
        text-align:left;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Department Wise Daily Patients</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td class="style1">
                    <b>Year : </b>
                </td>
                <td class="style2">
                    <asp:DropDownList ID="ddlYears" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <b>Month : </b>
                </td>
                <td class="style2">
                    <asp:DropDownList ID="ddlmonths" runat="server">
                        <asp:ListItem Value="1">January</asp:ListItem>
                        <asp:ListItem Value="2">February</asp:ListItem>
                        <asp:ListItem Value="3">March</asp:ListItem>
                        <asp:ListItem Value="4">April</asp:ListItem>
                        <asp:ListItem Value="5">May</asp:ListItem>
                        <asp:ListItem Value="6">June</asp:ListItem>
                        <asp:ListItem Value="7">July</asp:ListItem>
                        <asp:ListItem Value="8">August</asp:ListItem>
                        <asp:ListItem Value="9">September</asp:ListItem>
                        <asp:ListItem Value="10">October</asp:ListItem>
                        <asp:ListItem Value="11">November</asp:ListItem>
                        <asp:ListItem Value="12">December</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <b>Patient Type : </b>
                </td>
                <td class="style2">
                    <asp:DropDownList ID="ddlType" runat="server">
                        <asp:ListItem>OPD</asp:ListItem>
                        <asp:ListItem>IPD</asp:ListItem>
                        <asp:ListItem>Both</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
            <td>&nbsp;</td>
                <td align="Left" >
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100px" 
                        onclick="btnSearch_Click" />
                </td>
            </tr>
        </table>
        
    </div>
      <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           
             <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" >
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="sdsPatientCount" runat="server"
     ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
     SelectCommand="usp_OPDIPD_Monthly_Patient_Count" SelectCommandType="StoredProcedure"
    >
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlmonths" Name="Month" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddlYears" Name="Year" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddlType" Name="PType" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
       
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTotalptCount" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" 
        SelectCommand="usp_OPDIPD_Monthly_Patient_TotalCount" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlmonths" Name="Month" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddlYears" Name="Year" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

