<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_EmployeeAttendanceSummary, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
<script type ="text/javascript">

    var gAutoPrint = true; // Flag for whether or not to automatically call the print function 
    function printSpecial() {
        if (document.getElementById != null) {
            var html = '<HTML>\n<HEAD>\n';
            if (document.getElementsByTagName != null) {
                var headTags = document.getElementsByTagName("head");
                if (headTags.length > 0) html += headTags[0].innerHTML;
            }
            if (gAutoPrint) {
                if (navigator.appName == "Microsoft Internet Explorer") {
                    html += '\n</HEAD>\n<'
                    html += 'BODY onLoad="PrintCommandObject.ExecWB(6, -1);">\n';
                }
                else {
                    html += '\n</HEAD>\n<BODY>\n';
                }
            }
            else {
                html += '\n</HEAD>\n<BODY>\n';
            }

            var printReadyElem = document.getElementById("ctl00_ContentPlaceHolder1_ReportViewer1_ctl10");
            if (printReadyElem != null) {
                html += printReadyElem.innerHTML;
            }
            else {
                alert("Could not find the printReady section in the HTML");
                return;
            }
            if (gAutoPrint) {
                if (navigator.appName == "Microsoft Internet Explorer") {
                    html += '<OBJECT ID="PrintCommandObject" WIDTH=0 HEIGHT=0 '
                    html += 'CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT >\n</BODY>\n</HTML>';
                }
                else {
                    html += '\n</BODY>\n</HTML>';
                }
            }
            else {
                html += '\n</BODY>\n</HTML>';
            }
            var printWin = window.open("", "printSpecial");
            printWin.document.open();
            printWin.document.write(html);
            document.body.innerHTML = originalContents;
            printWin.document.close();
            if (gAutoPrint) {
                if (navigator.appName != "Microsoft Internet Explorer") {

                    printWin.print();
                }
            }
        }
        else {
            alert("Sorry, the print ready feature is only available in modern browsers.");
        }
        printWin.close();
    }

    function Set_focus() {
        document.getElementById("btn_print").focus();
    }

</script>
    <style type="text/css">
        .style1
        {
            width: 410px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   
    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
    



    <table class="diagnosis_list">
        <tr>
            <td align="right" class="style1">
                <strong>Select Hospital :</strong> </td>
            <td colspan="2">
              <asp:DropDownList ID="DDL_Company" runat="server" 
                  Width="50%" DataSourceID="SDS_Company" DataTextField="Hospital_Name" 
                  DataValueField="Hospital_ID" 
                    AutoPostBack="True" style="margin-left: 0px">
              </asp:DropDownList>


          
          
          <asp:SqlDataSource ID="SDS_Company" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]">
    </asp:SqlDataSource>


          
          
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                <strong>Select Department :</strong></td>
            <td colspan="2">
              <asp:DropDownList ID="DDL_Branch" runat="server" 
                  Width="50%" DataSourceID="SDS_Branch" DataTextField="Dept_Name" 
                  DataValueField="Dept_ID" AutoPostBack="True">
              </asp:DropDownList>


          
          
          <asp:SqlDataSource ID="SDS_Branch" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        SelectCommand="Select 0 as Dept_ID, '---ALL---' as Dept_Name
union
SELECT     Dept_ID, Dept_Name
FROM         Department
where Hospital_ID = @HospitalID
ORDER BY Dept_Name">
              <SelectParameters>
                  <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID" 
                      PropertyName="SelectedValue" />
              </SelectParameters>
    </asp:SqlDataSource>


          
          
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                Start Date<strong> :</strong></td>
            <td colspan="2">
                   <igsch:webdatechooser id="WebDateChooser_Start_Date" runat="server" width="202px">
                       <a href="OldEmployeeAttendanceSummary.aspx">OldEmployeeAttendanceSummary.aspx</a>
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:webdatechooser>
        <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                End Date<strong> :</strong></td>
            <td colspan="2">
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
                <strong>Select Employee :</strong></td>
            <td colspan="2">
              <asp:DropDownList ID="DDL_Sold_By" runat="server" 
                  Width="50%" DataSourceID="SDS_Employee" DataTextField="Name" 
                  DataValueField="EmpID">
              </asp:DropDownList>


          
          
          <asp:SqlDataSource ID="SDS_Employee" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
        SelectCommand="SELECT 0 AS EmpID, ' ---ALL---' AS Name UNION 
SELECT     EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee
WHERE     (@DeptID =0 or DeptID = @DeptID) and (Employee.ActiveStatus=1)" 
                    
                    
                    
                    ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>">
              <SelectParameters>
                  <asp:ControlParameter ControlID="DDL_Branch" Name="DeptID" 
                      PropertyName="SelectedValue" />
              </SelectParameters>
    </asp:SqlDataSource>


          
          
            </td>
        </tr>
		
        <tr>
            <td align="right" class="style1">
                <strong>Emp No :</strong></td>
            <td colspan="2">
                </b>
               <%-- <asp:TextBox ID="TextBox_Emp" runat="server"></asp:TextBox>
                <asp:HiddenField ID="HiddenField_empNo" runat="server" />--%>


          
          
                <asp:TextBox ID="txtbox_EmpNo" runat="server"></asp:TextBox>


          
          
            </td>
        </tr>
		
		<tr>
            <td align="right" class="style1">
                <strong>Employee Status :</strong></td>
            <td colspan="2">
                <asp:RadioButtonList ID="RBL_Emp_stat" runat="server" 
                    RepeatDirection="Horizontal">
                    <asp:ListItem Value="3">All</asp:ListItem>
                    <asp:ListItem Selected="True" Value="1">Active</asp:ListItem>
                    <asp:ListItem Value="0">Deactive</asp:ListItem>
                    <asp:ListItem Value="2">Ex-employee</asp:ListItem>
                </asp:RadioButtonList>


          
          
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_Report" runat="server" Text="View Report" 
                    onclick="btn_Report_Click" />
            </td>
        </tr>
</table>
    <input type="button" value="print" onclick="printSpecial()" id = "btn_print" autofocus="autofocus" onload ="Set_focus()"><br />
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="sdsReport" runat="server"
     ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
     SelectCommand="uspEmployeeAttendanceSummary" 
    SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_Start_Date" Name="DateFrom" 
                PropertyName="Value" Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenField_end_Date" Name="DateTo" 
                PropertyName="Value" Type="DateTime" />
            <asp:ControlParameter ControlID="DDL_Sold_By" Name="EmpID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DDL_Branch" Name="Dept_ID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DDL_Company" Name="Hospital_ID" 
                PropertyName="SelectedValue" Type="Int32" />
				 <asp:ControlParameter ControlID="RBL_Emp_stat" Name="E_status" 
                PropertyName="SelectedValue" Type="Int32" />
            
            <asp:ControlParameter ControlID="txtbox_EmpNo" Name="EmpNo" PropertyName="Text" 
                Type="Int32" DefaultValue="0" />
            
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

