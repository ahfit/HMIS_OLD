<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Vouchers_Summary_FullDetail_Report, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div width = "100%">
    <asp:HiddenField ID="HiddenField_EndDate" runat="server" />
<table width = "100%">
    <tr>
        <td width = "50%" align = "right">
            Employee Name :</td>
        <td width = "50%" >
            <asp:DropDownList ID="DDL_Employee" runat="server" DataSourceID="SDS_Employee" 
                DataTextField="NAME" DataValueField="EmpID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SDS_Employee" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="SELECT ' ALL ' as NAME, 0 as EmpID union SELECT     ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS NAME, Employee.EmpID FROM Employee INNER JOIN Receptionist ON Employee.EmpID = Receptionist.Receptionist_id WHERE  (ActiveStatus = 1)">
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td width = "50%" align = "right">
        Start Date :
        </td>
        <td width = "50%" >
        <igsch:WebDateChooser ID="WebDateChooser_Sdate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>

            <asp:DropDownList ID="DDL_Hospital" runat="server" DataSourceID="SDS_Hospital" Visible = "false"
                DataTextField="Hospital_Name" DataValueField="Hospital_ID" >
            </asp:DropDownList>
            <asp:SqlDataSource ID = "SDS_Hospital" runat = "server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td width = "50%" align = "right">
            End Date :
        </td>
        <td width = "50%" >
            <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                    <AutoPostBack ValueChanged="True" />
                </igsch:WebDateChooser>

        </td>
    </tr>
    <tr>
        <td colspan = "2" align = "center">
        
            <asp:SqlDataSource ID="SqlDataSource_report" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                SelectCommand="CashBook_FULL_Services_category_wise" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False" 
                >
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_StartDate" Name="Start_Date" 
                        PropertyName="Value" Type="DateTime" />
                    <asp:ControlParameter ControlID="HiddenField_EndDate" Name="end_Date" 
                        PropertyName="Value" Type="DateTime" />
                    <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        
            <asp:HiddenField ID="HiddenField_StartDate" runat="server" />
        
            <asp:Button ID="btn_report" runat="server" Text="View Report" 
                onclick="btn_report_Click" />
            
        </td>
        
    </tr>
        <tr >
        <td colspan = "2" align = "center">
            
             <asp:ScriptManager ID="ScriptManager1" runat="server">
             </asp:ScriptManager>
            
             
        </td>
        
    </tr>
            <tr>
        <td colspan = "2" align = "center">
            
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
            </rsweb:ReportViewer>
            
        </td>
        
    </tr>
          <tr>
        <td colspan = "2" align = "center">
            
            <br />
        
        </td>
        
    </tr>
          <tr>
        <td colspan = "2" align = "center">
            
            &nbsp;</td>
        
    </tr>
</table>


</div>

</asp:Content>

