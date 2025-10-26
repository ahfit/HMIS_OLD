<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Machine_Attendance_Enroll_EmployeeToMachine, App_Web_aiw43tag" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Enroll Employee to Machine</span></h2>
        <table width="100%">
            <tr>
                <td>
                    <table class="diagnosis_list">
                        <tr>
                            <td align="right" class="style1">
                                <strong>Select Branch :</strong> </td>
                            <td colspan="2">
                                <asp:DropDownList ID="DDL_Company" runat="server" CssClass="drop_down"
                                    DataSourceID="SDS_Company" DataTextField="Hospital_Name" OnSelectedIndexChanged="DDL_Company_SelectedIndexChanged"
                                    DataValueField="Hospital_ID"
                                    AutoPostBack="True" Style="margin-left: 0px">
                                </asp:DropDownList>

                                <asp:SqlDataSource ID="SDS_Company" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>




                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="style1">
                                <strong>Select Department :</strong></td>
                            <td colspan="2">
                                <asp:DropDownList ID="DDL_Branch" runat="server"
                                    DataSourceID="SDS_Branch" DataTextField="Dept_Name" CssClass="drop_down" OnSelectedIndexChanged="DDL_Branch_SelectedIndexChanged"
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
                                <strong>Select SubDepartment :</strong></td>
                            <td colspan="2">
                                <asp:DropDownList ID="DDL_SubDepartment" runat="server"
                                    DataSourceID="SqlDataSource_SubDepartment" DataTextField="SubDept_Name" CssClass="drop_down" OnSelectedIndexChanged="DDL_SubDepartment_SelectedIndexChanged"
                                    DataValueField="SubDept_Id" AutoPostBack="True">
                                </asp:DropDownList>




                                <asp:SqlDataSource ID="SqlDataSource_SubDepartment" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    SelectCommand="select 0 as SubDept_Id, '---ALL---' as SubDept_Name union select SubDept_Id,SubDept_Name from SubDepartment where SubDepartment.Dept_Id=@DeptID">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DDL_Branch" Name="DeptID"
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
                                    DataSourceID="SDS_Employee" DataTextField="Name" CssClass="drop_down" OnSelectedIndexChanged="DDL_Employee_SelectedIndexChanged" AutoPostBack="true"
                                    DataValueField="EmpID">
                                </asp:DropDownList>

                                <asp:SqlDataSource ID="SDS_Employee" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    SelectCommand="SELECT     EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee
WHERE     (@SubDept_ID =0 or SubDeptId = @SubDept_ID) and (  Employee.ActiveStatus=1)"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DDL_SubDepartment" Name="SubDept_ID"
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>




                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="style1">
                                <strong>Select Machine :</strong></td>
                            <td colspan="2">
                                <asp:DropDownList ID="DDL_Machine" runat="server"
                                    DataSourceID="SqlDataSource_Machines" DataTextField="Location" CssClass="drop_down"
                                    DataValueField="IP_Machine" AutoPostBack="false">
                                </asp:DropDownList>
                                <asp:Label Text="" Font-Bold="true" ID="lbl_MachineMsg" runat="server" />
                              
                                <asp:SqlDataSource ID="SqlDataSource_Machines" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                                    SelectCommand="select Location, IP_Machine from Attendence_Machines where Is_Active=1"></asp:SqlDataSource>

                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="style1">
                                <strong>Select Finger :</strong></td>
                            <td colspan="2">
                                <asp:DropDownList ID="DDL_Finger" runat="server"
                                    CssClass="drop_down" AutoPostBack="false">
                                    <asp:ListItem Value="0" Text="0" />
                                    <asp:ListItem Value="1" Text="1" />
                                    <asp:ListItem Value="2" Text="2" />
                                    <asp:ListItem Value="3" Text="3" />
                                    <asp:ListItem Value="4" Text="4" />
                                    <asp:ListItem Value="5" Text="5" />
                                    <asp:ListItem Value="6" Text="6" />
                                    <asp:ListItem Value="7" Text="7" />
                                    <asp:ListItem Value="8" Text="8" />
                                    <asp:ListItem Value="9" Text="9" />
                                </asp:DropDownList>

                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="style1">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="btn_Enroll" CssClass="btn_hacims" runat="server" Text="Enroll" OnClick="btn_Enroll_Click" />
                                <asp:Button Text="Save to DB" Visible="false" ID="btn_SaveDB" OnClick="btn_SaveDB_Click" CssClass="btn_hacims" runat="server" />
                                <asp:Label runat="server" ID="lblMsg" Font-Bold="true"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:ImageButton ImageUrl="~/images/hand_img.png"  runat="server" />
                                  <asp:GridView runat="server" ID="GridViewFingerDetail" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" CssClass="Grid_1" OnRowDataBound="GridViewFingerDetail_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="0">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="FigImgID0" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F0") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="1">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="FigImgID1" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F1") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="2">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="FigImgID2" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F2") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="3">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="FigImgID3" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F3") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="4">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="FigImgID4" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F4") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="5">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="FigImgID5" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F5") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="6">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="FigImgID6" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F6") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="7">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="FigImgID7" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F7") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="8">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="FigImgID8" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F8") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="9">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="FigImgID9" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F9") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>


                </td>
            </tr>
        </table>

    </div>

</asp:Content>

