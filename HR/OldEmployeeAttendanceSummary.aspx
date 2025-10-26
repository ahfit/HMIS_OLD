<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_OldEmployeeAttendanceSummary, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 600px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <br />
    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
    



    <table class="diagnosis_list">
        <tr style = "display :none;">
            <td align="right" class="style1">
                <strong>Select Hospital :</strong> </td>
            <td>
              <asp:DropDownList ID="DDL_Hospital" runat="server" 
                  Width="30%" DataSourceID="SDS_Hospital" DataTextField="Hospital_Name" 
                  DataValueField="Hospital_ID" 
                    AutoPostBack="True">
              </asp:DropDownList>


          
          
          <asp:SqlDataSource ID="SDS_Hospital" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]">
    </asp:SqlDataSource>


          
          
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                <strong>Select Department :</strong></td>
            <td>
              <asp:DropDownList ID="DDL_Department" runat="server" 
                  Width="30%" DataSourceID="SDS_Department" DataTextField="Dept_Name" 
                  DataValueField="Dept_ID">
              </asp:DropDownList>


          
          
          <asp:SqlDataSource ID="SDS_Department" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        SelectCommand="Select 0 as Dept_ID, '---ALL---' as Dept_Name
union
Select D.DEPT_CODE as Dept_ID , D.DEPT_NAME as Dept_Name from Timex_TimePayroll_SMC.dbo.DEF_SO_DEPARTMENT D
ORDER BY Dept_Name">
              <SelectParameters>
                  <asp:ControlParameter ControlID="DDL_Hospital" Name="HospitalID" 
                      PropertyName="SelectedValue" />
              </SelectParameters>
    </asp:SqlDataSource>


          
          
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                Start Date<strong> :</strong></td>
            <td>
                   <igsch:webdatechooser id="WebDateChooser_Start_Date" runat="server" width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:webdatechooser>
        <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                End Date<strong> :</strong></td>
            <td>
              <igsch:WebDateChooser ID="WebDateChooser_end_Date" runat="server" Width="202px">
                        <AutoPostBack CalendarMonthChanged="True" ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
        <asp:HiddenField ID="HiddenField_end_Date" runat="server" />
                </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                <strong>Select Employee No:</strong></td>
            <td>
              <asp:TextBox ID = "txt_Emp_no" runat = "server"></asp:TextBox> 
              <asp:DropDownList ID="DDL_Employee" runat="server" 
                  Width="30%" DataSourceID="SDS_Employee" DataTextField="Name" 
                  DataValueField="EmpID" Visible="False">
              </asp:DropDownList>


          
          
          <asp:SqlDataSource ID="SDS_Employee" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>" 
        SelectCommand="SELECT 0 AS EmpID, ' ---ALL---' AS Name UNION SELECT EmpID, Name FROM Employee where len(Name) > 0 ORDER BY Name" 
                    
                    
                    ProviderName="<%$ ConnectionStrings:PayRollConnectionString.ProviderName %>">
    </asp:SqlDataSource>


          
          
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_Report" runat="server" Text="View Report" 
                    onclick="btn_Report_Click" />
            </td>
        </tr>
</table>
    



    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
    </rsweb:ReportViewer>

    <br />
    <asp:SqlDataSource ID="sds_report" runat="server"  runat="server" 
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
        SelectCommand="OldEmployeeAttendanceSummary" 
        SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_Start_Date" Name="DateFrom" 
                PropertyName="Value" Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenField_end_Date" Name="DateTo" 
                PropertyName="Value" Type="DateTime" />
            <asp:ControlParameter ControlID="txt_Emp_no" Name="EmpID" 
                PropertyName="Text" Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="DDL_Department" Name="Dept_ID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DDL_Hospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

