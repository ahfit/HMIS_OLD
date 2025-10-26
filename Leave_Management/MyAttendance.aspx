<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Leave_Management_MyAttendance" CodeFile="~/Leave_Management/MyAttendance.aspx.cs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .style1 {
            width: 410px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>View Attendance</span></h2>
        <table width="100%">
            <tr>
                <td align="right" width="40%">From Date
                </td>
                <td width="60%" align="left">
                    <asp:TextBox ID="datefrom" TextMode="date" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">From Date
                </td>
                <td width="60%" align="left">
                    <asp:TextBox ID="dateTo" TextMode="date" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button Text="Search" ID="btnSearch" OnClick="btnSearch_Click" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <asp:GridView ID="GridView1" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Sr.#">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date">
                <ItemTemplate>
                    <asp:Label ID="lblDate" Text='<%# Bind("for_Date") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Day">
                <ItemTemplate>
                    <asp:Label ID="lblDayName" Text='<%# Bind("Day_Name") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Type">
                <ItemTemplate>
                    <asp:Label ID="lblholiday" Text='<%# Bind("E_Status") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Time In">
                <ItemTemplate>
                    <asp:Label ID="lblTimeIn" Text='<%# Bind("Time_In") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Time Out">
                <ItemTemplate>
                    <asp:Label ID="lblTimeOut" Text='<%# Bind("Time_Out") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total Hours">
                <ItemTemplate>
                    <asp:Label ID="lblTotalHours" Text='<%# Bind("Total_Hours") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Update Time" Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnshowPanel" OnClick="lbtnshowPanel_Click" Text="Modify Time" ToolTip='<%# Bind("att_id") %>' CommandArgument='<%# Bind("Emp_id") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

    </asp:GridView>
    <asp:Panel ID="pnlPopUp" runat="server" Visible="False" Width="100%" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="height: 420px; overflow: auto; overflow-x: hidden; width: 100%;">

                <asp:ImageButton runat="server" ImageUrl="~/images/deletebtn.png" Style="float: right; margin-right: 10px;" ID="Button1" OnClick="Button1_Click"></asp:ImageButton>
                <br />

                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top">
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/PictureFrame.png"
                                Width="85px" Height="100px" />

                        </td>
                        <td align="center" valign="top" width="90%">

                            <asp:DataList ID="DataList1" runat="server" DataKeyField="EmpID"
                                DataSourceID="SqlDataSource1" Width="98%">
                                <ItemTemplate>
                                    <table cellspacing="0" cellpadding="0" border="0" class="Grid_2" width="98%">
                                        <tr>
                                            <td align="right">Employee Name :</td>
                                            <td>
                                                <asp:Label ID="Employee_NameLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Employee_Name") %>' />
                                            </td>
                                            <td align="right">Relation :</td>
                                            <td>
                                                <asp:Label ID="Relation_NameLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Relation_Name") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Gender :</td>
                                            <td>
                                                <asp:Label ID="GenderLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Gender") %>' />
                                            </td>
                                            <td align="right">CNIC :</td>
                                            <td>
                                                <asp:Label ID="CNICLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("CNIC") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Religion :</td>
                                            <td>
                                                <asp:Label ID="Religion_nameLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Religion_name") %>' />
                                            </td>
                                            <td align="right">D.O.B</td>
                                            <td>
                                                <asp:Label ID="DateOfBirthLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("DateOfBirth") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Marital Status :</td>
                                            <td>
                                                <asp:Label ID="Marital_StatusLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Marital_Status") %>' />
                                            </td>
                                            <td align="right">Mobile :</td>
                                            <td>
                                                <asp:Label ID="Mobile_NumberLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Mobile_Number") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td align="right">E-Mail :</td>
                                            <td>
                                                <asp:Label ID="email_addressLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("email_address") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Type :</td>
                                            <td>
                                                <asp:Label ID="Employee_TypeLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Employee_Type") %>' />
                                            </td>
                                            <td align="right">JoinDate :</td>
                                            <td>
                                                <asp:Label ID="JoinDateLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("JoinDate") %>' />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td align="right">Designation :</td>
                                            <td>
                                                <asp:Label ID="Designation_NameLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Designation_Name") %>' />
                                            </td>
                                            <td align="right">Saction :</td>
                                            <td>
                                                <asp:Label ID="SubDept_NameLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("SubDept_Name") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Department :
                                            </td>
                                            <td>
                                                <asp:Label ID="Dept_NameLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Dept_Name") %>' />
                                            </td>
                                            <td align="right">Office Phone :</td>
                                            <td>
                                                <asp:Label ID="Emp_Offical_NumberLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("OphoneNo") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">PayScale :</td>
                                            <td>
                                                <asp:Label ID="PayScaleLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("PayScale") %>' />
                                            </td>
                                            <td align="right">Department Join Date :</td>
                                            <td>
                                                <asp:Label ID="DeptJoinDateLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("DeptJoinDate") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Emp No. :</td>
                                            <td>
                                                <asp:Label ID="DateOfBirthLabel0" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Emp_Offical_Number") %>' />
                                            </td>
                                            <td align="right">Basic Salary :</td>
                                            <td>
                                                <asp:Label ID="Employee_Basic_SalaryLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Employee_Basic_Salary") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Details :</td>
                                            <td colspan="3">
                                                <asp:Label ID="Designation_DetailLabel" runat="server" Font-Bold="True"
                                                    Text='<%# Eval("Designation_Detail") %>' />
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                </ItemTemplate>
                            </asp:DataList>

                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                    <tr>
                        <td align="right">Select date :</td>
                        <td>
                            <asp:TextBox ID="DateFor" TextMode="date" runat="server" Enabled="false" />
                            Time In :
                            <asp:TextBox ID="txtTimeIn" TextMode="time" runat="server" />
                            Time Out :
                            <asp:TextBox ID="txtTimeOut" TextMode="time"  runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Remarks :</td>
                        <td>
                            <asp:TextBox ID="TextBox_Remarks" runat="server" Height="55px"
                                TextMode="MultiLine" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"></td>
                        <td>
                            <asp:Button ID="Button_SaveRemarks" OnClick="Button_SaveRemarks_Click" runat="server" Text="Save" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left">
                            <br>

                            <asp:SqlDataSource ID="SqlDataSource_Remarks" runat="server"
                                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                InsertCommand="usp_updateEmployeeTimeInOut"
                                InsertCommandType="StoredProcedure"
                                SelectCommand="SELECT ISNULL(attendance_id,0) as att_id, CONVERT (date, For_Day, 103) AS For_Day,Time_In,Time_out,admin_comment  FROM Emp_Shift_Attendence WHERE (Emp_Id = @Emp_id) and (@att_id=0 or Attendance_Id=@att_id) and convert(varchar,For_Day,112)=convert(varchar,@for_date,112)">
                                <SelectParameters>
                                    <asp:Parameter Name="Emp_id" Type="Int32" />
                                    <asp:Parameter Name="att_id" Type="Int32" />
                                    <asp:Parameter Name="for_date" Type="DateTime" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBox_Remarks" Name="Comments" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="HiddenField_Selected_Emp_Id" Name="Emp_Id" PropertyName="Value"
                                        Type="Int32" />
                                    <asp:ControlParameter ControlID="HiddenField_ForDate" Name="forday" PropertyName="Value"
                                        Type="DateTime" />
                                    <asp:ControlParameter ControlID="txtTimeIn" Name="Time_In" PropertyName="Text" Type="DateTime" />
                                    <asp:ControlParameter ControlID="txtTimeOut" Name="Time_Out" PropertyName="Text"
                                        Type="DateTime" />

                                </InsertParameters>
                            </asp:SqlDataSource>
                           
                        </td>
                    </tr>
                </table>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                    ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                    SelectCommand="Select_Employee_FaceSheet" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_Selected_Emp_Id" Name="EmpID"
                            PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Selected_Emp_Id" runat="server" Value="1" />
            </div>
        </div>
    </asp:Panel>
</asp:Content>
