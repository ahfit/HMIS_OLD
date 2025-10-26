<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Machine_Attendance_DontConsiderLateAttendanceEmployee, App_Web_aiw43tag" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
    </script>
    <style type="text/css">
        .style1 {
           width:40%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>

    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Don't Consider Late Attendance</span></h2>

        <table class="tbl_form">
            <tr>
                <td align="right" class="style1">
                    <strong>Select Campus :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Company" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Company" DataTextField="Hospital_Name"
                        DataValueField="Hospital_ID"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Company" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Select Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Branch" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="Dept_Name"
                        DataValueField="Dept_ID" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="select 0 as Dept_ID ,'ALL' as Dept_Name union SELECT     Dept_ID, Dept_Name
FROM         Department
where Hospital_ID = @HospitalID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
             <tr>
                <td align="right" class="style1">
                    <strong>Select Employee :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Employee" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Employee" DataTextField="Name"
                        DataValueField="Emp_Id" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="select 0 as Emp_Id,'ALL' as Name union select EmpId,(ISNULL(EFName,'')+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,''))as Name from Employee where (@Dept_Id=0 or DeptId=@Dept_Id)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="Dept_Id"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1"><strong>Select Date:</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server"  CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
                </td>
            </tr>
            <tr>
                 <td align="right" class="style1"><strong>Comment:</strong></td>
               
                <td  align="left">
                     <asp:TextBox Height="70px" Width="250px" runat="server" ID="txtComment" TextMode="MultiLine" />
                     </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button Text="Don't Consider Late Attendance" ID="btnDontConsider" OnClick="btnDontConsider_Click" runat="server" />
                    <asp:Label ID="lblMsg" Text="Marked Successfully" ForeColor="Green" Visible="false" Font-Bold="true" runat="server" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

