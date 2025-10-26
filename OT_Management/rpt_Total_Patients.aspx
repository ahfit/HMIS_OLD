<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="rpt_Total_Patients.aspx.vb" Inherits="Radiology_rpt_Total_Patients" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 288px;
        }
        .style2
        {
            width: 188px;
        }
        .style3
        {
            width: 288px;
            text-align: right;
            font-weight: bold;
        }
        .style4
        {
            width: 188px;
            text-align: right;
            font-weight: bold;
        }
        .style5
        {
            font-family: "Segoe UI";
            font-size: medium;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
    <p>
        <span class="style5"><strong>Radiology Patients Date wise</strong></span></p>
    <table class="diagnosis_list">
        <tr>
            <td class="style3">
                Hospital</td>
            <td colspan="3">
       
           <asp:DropDownList ID="DropDownList_Hospital_Id" runat="server" 
               DataSourceID="SqlDataSource_Hospital_Id" DataTextField="Hospital_Abb" 
               DataValueField="Hospital_ID" style="margin-left: 0px" AutoPostBack="True" 
                    Height="33px" Width="185px">
           </asp:DropDownList>
       
                <br />
                <br />
            </td>
        </tr>
        <tr>
            <td class="style3">
                Year:</td>
            <td>
                <asp:DropDownList ID="DropDownList_Year" runat="server" Height="30px" 
                    Width="77px">
                    <asp:ListItem>2014</asp:ListItem>
                    <asp:ListItem>2015</asp:ListItem>
                    <asp:ListItem>2016</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="style4">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                Month</td>
            <td>
                <asp:DropDownList ID="DropDownList_Month" runat="server" Height="24px" 
                    Width="73px">
                    <asp:ListItem Value="1">Jan</asp:ListItem>
                    <asp:ListItem Value="2">Feb</asp:ListItem>
                    <asp:ListItem Value="3">Mar</asp:ListItem>
                    <asp:ListItem Value="4">Apr</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">Jun</asp:ListItem>
                    <asp:ListItem Value="7">Jul</asp:ListItem>
                    <asp:ListItem Value="8">Aug</asp:ListItem>
                    <asp:ListItem Value="9">Sep</asp:ListItem>
                    <asp:ListItem Value="10">Oct</asp:ListItem>
                    <asp:ListItem Value="11">Nov</asp:ListItem>
                    <asp:ListItem Value="12">Dec</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="style4">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                Test Group:</td>
            <td>
                <asp:SqlDataSource ID="SqlDataSource_TGID" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                    
                    SelectCommand="SELECT TestGroup.TGID, TestGroup.TGName FROM TestGroup INNER JOIN TestGroup_HospitalWise ON TestGroup.TGID = TestGroup_HospitalWise.TGID WHERE (TestGroup_HospitalWise.Hospital_Id = @Hospital_Id) ORDER BY TestGroup.TGName">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList_Hospital_Id" Name="Hospital_Id" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:DropDownList ID="DropDownList_TGID" runat="server" DataSourceID="SqlDataSource_TGID"
                    DataTextField="TGName" DataValueField="TGID" Height="24px" Width="169px">
                </asp:DropDownList>
            </td>
            <td class="style4">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td>
                <asp:Button ID="Button_Search" runat="server" Text="Search" Width="96px" />
            </td>
            <td class="style2">
                &nbsp;</td>
            <td>
       
           <asp:SqlDataSource ID="SqlDataSource_Hospital_Id" runat="server" 
               ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
               ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" 
               
                    
                    SelectCommand="SELECT Hospital_ID, Hospital_Abb FROM Hospital WHERE (Hospital_ID IN (248, 244, 246)) ORDER BY Hospital_ID DESC">
           </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <p>
        <asp:HiddenField ID="HiddenField_StartDate" runat="server" />
        <asp:HiddenField ID="HiddenField_EndDate" runat="server" />
    </p>


    <p>
    <p>
        &nbsp;</p>
    <p>
    </p>
    <rsweb:ReportViewer ID="ReportViewer_radiologyPatient" runat="server" Height="949px" 
    Width="1460px">
</rsweb:ReportViewer>
    <p>
    </p>
    <p>
    </p>
</asp:Content>

