<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Machine_Attendance_LateAttendanceConsiderationEmployee, App_Web_aiw43tag" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
    </script>
    <style type="text/css">
        .style1 {
            width: 410px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>

    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Late Attendance Consider</span></h2>

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
                        SelectCommand="SELECT     Dept_ID, Dept_Name
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


        </table>
    </div>
    <div>
        <table width="100%">
            <tr>
                <td width="50%" valign="top">
                    <div style="height: 300px; overflow-x: scroll">
                        <div class="bxmain inner_content" style="width: 100%">
                            <h2><span>Late Attendance Considered</span></h2>
                        </div>
                        <asp:GridView DataSourceID="SDS_EmployeeLateConsider" runat="server" ID="GridViewConsider" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.#">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label Text='<%#Bind("Name") %>' ID="lblName" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label Text='<%#Bind("Status") %>' ID="lblStatus" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkMarkDontConsider" ToolTip='<%#Bind("EmpId") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <asp:Button Text="Don't Consider Late Attendance" ID="btnDontConsider" OnClick="btnDontConsider_Click" runat="server" />

                </td>
                <td width="50%" valign="top">
                    <div style="height: 300px; overflow-x: scroll">
                        <div class="bxmain inner_content" style="width: 100%">
                            <h2><span>Late Attendance Not Considered</span></h2>
                        </div>
                        <asp:GridView runat="server" DataSourceID="SDS_EmployeeLateNotConsider" ID="GridView_NotConsider" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.#">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label Text='<%#Bind("Name") %>' ID="lblName" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label Text='<%#Bind("Status") %>' ID="lblStatus" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkMarkConsider" ToolTip='<%#Bind("EmpId") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <asp:Button Text="Consider Late Attendance" ID="btnConsider" OnClick="btnConsider_Click" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SDS_EmployeeLateConsider" runat="server"
        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
        SelectCommand="SELECT     EmpID, (ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')) as Name,case when ISNULL(Consider_LateAttendance,1)=1 then 'Considered' else 'Not Considered' end AS Status
FROM  Employee WHERE     (@DeptID =0 or DeptID = @DeptID) and (ISNULL(Consider_LateAttendance,1)=1)"
        ProviderName="<%$ ConnectionStrings:BasicDataConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDL_Branch" Name="DeptID"
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_EmployeeLateNotConsider" runat="server"
        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
        SelectCommand="SELECT     EmpID, (ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')) as Name,case when ISNULL(Consider_LateAttendance,1)=1 then 'Considered' else 'Not Considered' end AS Status
FROM  Employee WHERE     (@DeptID =0 or DeptID = @DeptID) and (Consider_LateAttendance=0)"
        ProviderName="<%$ ConnectionStrings:BasicDataConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDL_Branch" Name="DeptID"
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

