<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_OLDMachine_attendence_detail, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 185px;
        }
        .style2
        {
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Panel ID = "PNL_Device" runat = "server">
            <div width = "100%" >
            <table width ="100%" align ="center">
                <tr>
                    <td align="right" class="style2">
                        <strong>Start Date :</strong></td>
                    <td align="left" class="style1">
                        <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" 
                            CssClass="drop_date" Width="200px">
                            <AutoPostBack ValueChanged="True" />
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                        <asp:HiddenField ID="HiddenField_start_Date" runat="server" />
                    </td>
                    <td align="left" width="33%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="right" class="style2">
                        <strong>End Date:</strong></td>
                    <td align="left" class="style1">
                        <igsch:WebDateChooser ID="WebDateChooser_End_Date" runat="server" 
                            CssClass="drop_date" Width="200px">
                            <AutoPostBack ValueChanged="True" />
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                        <asp:HiddenField ID="HiddenField_End_Date" runat="server" />
                    </td>
                    <td align="Center" width="33%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="right" class="style2">
                        <strong>Employee No :</strong>&nbsp;</td>
                    <td align="left" class="style1">
                        <asp:TextBox ID="txt_emp_no" runat="server" AutoPostBack="True" Width="200px"></asp:TextBox>
                        <asp:Label ID="lbl_MSG" runat="server" Font-Bold="True" Font-Italic="False" 
                            Font-Overline="False" Font-Strikeout="False" ForeColor="#FF3300"></asp:Label>
                    </td>
                    <td align="left" width="33%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="right" class="style2">
                        &nbsp;</td>
                    <td align="left" class="style1">
                        &nbsp;</td>
                    <td align="left" width="33%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="right" class="style2">
                        &nbsp;</td>
                    <td align="center" class="style1">
                        <asp:Button ID="Button_search" runat="server" Text="Search" />
                        <asp:Button ID="Button_search0" runat="server" Text="View Report" />
                        <asp:HiddenField ID="HFD_emp_no" runat="server" Value="%" />
                    </td>
                    <td align="left" width="33%">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    </td>
                </tr>
                <tr>
                   <td align="left" class="style2">
                       &nbsp;</td>
                    <td align="left" class="style1">
                        &nbsp;</td>
                    <td align="left" width="33%">
                        &nbsp;</td>
                    
                </tr>
                <tr>
                    <td align="left" class="style2">
                        <strong>Total Present :<asp:Label ID="lbl_P" runat="server" ForeColor="#FF3300" 
                            Text="0"></asp:Label>
                        </strong>
                    </td>
                    <td align="left" class="style1">
                        <strong>Total Holidays :<asp:Label ID="lbl_H" runat="server" 
                            ForeColor="#FF3300" Text="0"></asp:Label>
                        </asp:label>
                        </strong>
                    </td>
                    <td align="left" width="33%">
                        <strong>Total Absent :
                        <asp:Label ID="lbl_A" runat="server" ForeColor="#FF3300" Text="0"></asp:Label>
                        </asp:label>
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="style2">
                        &nbsp;</td>
                    <td align="left" class="style1">
                        &nbsp;</td>
                    <td align="left" width="33%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="left" class="style2">
                        &nbsp;</td>
                    <td align="left" class="style1">
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                            SelectCommand="Search_OldMachine_Att_Report" 
                            SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenField_start_Date" Name="StartDate" 
                                    PropertyName="Value" Type="DateTime" />
                                <asp:ControlParameter ControlID="HiddenField_End_Date" Name="EndDate" 
                                    PropertyName="Value" Type="DateTime" />
                                <asp:ControlParameter ControlID="HFD_emp_no" Name="EmpID" PropertyName="Value" 
                                    Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td align="left" width="33%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="Center" colspan="3" width="33%">
                        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource2" 
                            Width="100%" PageSize="100" AutoGenerateColumns="False">
                            <Columns>
                            <asp:TemplateField HeaderText="SrNo."> 
                                <ItemTemplate> <%#Container.DataItemIndex+1%> 
                            <asp:HiddenField ID="HFD_STATUS" runat="server" Value='<%# Eval("Status") %>' />
                                </ItemTemplate>
                            <ItemStyle Width="8%" /> 
                            </asp:TemplateField>
                                <asp:BoundField DataField="Employee Name" HeaderText="Employee Name" 
                                    SortExpression="Employee Name" />
                                <asp:BoundField DataField="Dept_Name" HeaderText="Department" 
                                    SortExpression="Dept_Name" />
                                <asp:BoundField DataField="SubDept_Name" HeaderText="SubDepartment" 
                                    SortExpression="SubDept_Name" />
                                <asp:BoundField DataField="Designation_Name" HeaderText="Designation" 
                                    SortExpression="Designation_Name" />
                                <asp:BoundField DataField="Attendance Date" HeaderText="Attendance Date" 
                                    SortExpression="Attendance Date" />
                                <asp:BoundField DataField="Time In" HeaderText="Time In" 
                                    SortExpression="Time In" />
                                <asp:BoundField DataField="Time Out" HeaderText="Time Out" 
                                    SortExpression="Time Out" />
                            </Columns>
                        </asp:GridView>
                        <asp:HiddenField ID ="hf_Status" runat ="server" Value = "0" />
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            CancelSelectOnNullParameter="False" 
                            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                            SelectCommand="Search_OldMachine_Att_BetDates" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenField_start_Date" Name="StartDate" 
                                    PropertyName="Value" Type="DateTime" />
                                <asp:ControlParameter ControlID="HiddenField_End_Date" Name="EndDate" 
                                    PropertyName="Value" Type="DateTime" />
                                <asp:ControlParameter ControlID="HFD_emp_no" Name="EmpID" PropertyName="Value" 
                                    Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                
                <tr>
                    <td align="Center" class="style2" colspan="3">
                        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
                        </rsweb:ReportViewer>
                    </td>
                </tr>
            </table>
            </div>
            </asp:Panel>



</asp:Content>

