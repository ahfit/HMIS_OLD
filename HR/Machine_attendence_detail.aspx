<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_Machine_attendence_detail, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 185px;
        }
        .style2
        {
            width: 41%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
<asp:Panel ID = "PNL_Device" runat = "server">
            <div width = "100%" >
            <table width ="100%" align ="center">
                <tr>
                    <td align="right" class="style2">
                        <strong>Start Date :</strong></td>
                    <td align="left" class="style1">
                        <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" 
                            CssClass="drop_date" Width="200px">
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
                        <asp:TextBox ID="txt_emp_no" runat="server" Width="200px"></asp:TextBox>
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
                    <td align="left" class="style1">
                        <asp:Button ID="Button_search" runat="server" Text="Search" />
                        <asp:HiddenField ID="HFD_emp_no" runat="server" Value="%" />
                        <asp:Button ID="Button1" runat="server" Text="View Report" />
                        <asp:Button ID="Btn_Export" runat="server" Text="Export To Excel" />
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
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <asp:Image ID="Progress" runat="server" ImageUrl="~/images_hacims/Progress.gif" 
            Height="73px" Width="75px" />
                        </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
                <tr>
                    <td align="Center" colspan="3" width="33%">
                       <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" 
                            Width="100%" AutoGenerateColumns="False" PageSize="100">
                            <Columns>
                            <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
                                <asp:BoundField DataField="EnrollNumber" HeaderText="Emp #" 
                                    SortExpression="EnrollNumber" />
                                <asp:BoundField DataField="Dept_Name" HeaderText="Department Name" 
                                    SortExpression="Dept_Name" />
                                <asp:BoundField DataField="NAME" HeaderText="NAME" SortExpression="NAME" />
                                <asp:BoundField DataField="Att_Date" HeaderText="Date" 
                                    SortExpression="Att_Date" />
                                <asp:BoundField DataField="Time_In" HeaderText="Time In" 
                                    SortExpression="Time_In" />
								<asp:BoundField DataField="Time_OUT" HeaderText="Time OUT"  
                                    SortExpression="Time_OUT" />	
                                <asp:BoundField DataField="t_hours" HeaderText="Total Hours" 
                                    SortExpression="t_hours" />
                            </Columns>
                        </asp:GridView>

                        </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:Machine_Attendence_LogsConnectionString %>" 
                            SelectCommand="Search_Att_BetDates" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenField_start_Date" Name="StartDate" 
                                    PropertyName="Value" Type="DateTime" />
                                <asp:ControlParameter ControlID="HiddenField_End_Date" Name="EndDate" 
                                    PropertyName="Value" Type="DateTime" />
                                <asp:ControlParameter ControlID="HFD_emp_no" Name="EmpID" PropertyName="Value" 
                                    Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID ="hf_Status" runat ="server" Value = "0" />
                    </td>
                </tr>
                <tr>
                    <td align="Center" class="style2">
                        &nbsp;</td>
                    <td class="style1">
                        &nbsp;</td>
                    <td align="Center" width="33%">
                        &nbsp;</td>
                </tr>
            </table>
            </div>
            </asp:Panel>



</asp:Content>

