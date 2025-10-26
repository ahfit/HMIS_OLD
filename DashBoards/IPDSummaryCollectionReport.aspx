<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="~/DashBoards/IPDSummaryCollectionReport.aspx.cs" Inherits="DashBoards_IPDSummaryCollectionReport" %>
    <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Department Wise Patients</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
              <tr>
            <td align="right"><strong>Hospital :</td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
             <tr>
                <td class="style1">
                    <b>From Date : </b>
                </td>
                <td class="style2">
                    <igsch:WebDateChooser ID="wdcStartDate" runat="server" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <b>To Date : </b>
                </td>
                <td class="style2">
                    <igsch:WebDateChooser ID="wdcEndDate" runat="server" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
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
     ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
     SelectCommand="Patient_Package_DoctorServices_Summary" SelectCommandType="StoredProcedure"
    >
        <SelectParameters>
           <asp:Parameter Name="startDate" Type="DateTime" />
            <asp:Parameter Name="endDate" Type="DateTime" />
            <asp:ControlParameter ControlID="ddl_Hospital" Name="HospitalID" Type="Int16" PropertyName="SelectedValue" />
            
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
