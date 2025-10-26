<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Registration_ChangeRoom, App_Web_asx2a3aw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            height: 297px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <%-- <asp:UpdatePanel ID="UDP_Ch_room" runat="server" >
        <ContentTemplate>--%>
    <asp:Label ID="Label2" runat="server"></asp:Label>
    <div  style="width: 100%;" align="left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" style="display: none;">
            <tr>
                <td width="25%" align="right">
                    MR # :
                </td>
                <td width="25%">
                    <asp:TextBox ID="TextBox_RegNo" runat="server" CssClass="input_txt" AutoPostBack="True"></asp:TextBox>
                </td>
                <td width="25%" align="right">
                    Name :
                </td>
                <td width="25%">
                    <asp:TextBox ID="TextBoxName" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Room :
                </td>
                <td>
                    <asp:TextBox ID="TextBoxRoom" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
                <td align="right">
                    Consultant :
                </td>
                <td>
                    <asp:TextBox ID="TextBoxConsultant" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>
        </table>
        
            
            <asp:FormView ID="fmvPatientInfo" runat="server" DataKeyNames="RegNo" DataSourceID="dsPatientInfo"
                HorizontalAlign="Left" Width="100%">
                <ItemTemplate>
                    <div id="p_info" class="patient-info inner_content" style="min-height: 20px; line-height: 22px;">
                    <h2><span>Patient Info</span></h2>
                        <ul style="margin-left: 10px;">
                            <li style="display: inline;"><span class="age" style="display: inline;"></span>MR #
                                &nbsp;<span class="reg"><strong><asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("RegNo") %>'
                                    ToolTip="Patient Registration Number"></asp:Label></strong></span><span class="splt">|</span>
                                <span class="name-p">
                                    <asp:Label ID="PatientNameLabel" runat="server" ToolTip="Patient Name"></asp:Label>
                                </span><span class="relation">&nbsp;<asp:Label ID="RelationLabel" runat="server"
                                    Text='<%# Bind("Relation", "{0}") %>' ToolTip="Patient Relation"></asp:Label>&nbsp;</span>
                                <strong>
                                    <asp:Label ID="RelationNameLabel" runat="server" Text='<%# Eval("RELATIONNAME", "{0}") %>'
                                        ToolTip="Patient Relation Name"></asp:Label></strong><span class="splt">| <span style="color: #333333">
                                            Age :</span></span> <span class="age" style="display: inline;">
                                                <asp:Label ID="AgeLabel" runat="server" Text='<%# Bind("Age") %>' ToolTip="Patient Age"></asp:Label>
                                                Year(s)<span class="splt">|</span><asp:Label ID="LabelDateofBirth" runat="server"
                                                    Text='<%# Eval("DateOfBirth") %>' ToolTip="Patient Date of Birth" Visible="False"></asp:Label><span
                                                        class="splt"></span><asp:Label ID="LabelGender" runat="server" Text='<%# Eval("Gender", "{0}") %>'
                                                            ToolTip="Patient Gender"></asp:Label></span>
                                <asp:Label ID="Label_Address" runat="server" Text='<%# Bind("Address", "{0}") %>'
                                    ToolTip="Patient Address" Visible="false"></asp:Label>
                            </li>
                        </ul>
                        <asp:HiddenField ID="HiddenField_Pfname" runat="server" Value='<%# Eval("pfname", "{0}") %>' />
                        <asp:HiddenField ID="HiddenField_Pmname" runat="server" Value='<%# Eval("pmname", "{0}") %>' />
                        <asp:HiddenField ID="HiddenField_Plname" runat="server" Value='<%# Eval("PLName") %>' />
                        <asp:HiddenField ID="HiddenField_prefix" runat="server" Value='<%# Eval("prefix") %>' />
                    </div>
                </ItemTemplate>
            </asp:FormView>
    </div>
    <br />
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top" class="style1">
                <div class="bxmain inner_content" style="width: 99%;">
                <h2><span>Assigned Bed</span></h2>
                <asp:GridView ID="GridViewRoomOccupied" runat="server" CssClass="Grid_1" Width="90%"
                        AutoGenerateColumns="False" DataSourceID="SqlDataSourceRoomOccupied">
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                        <Columns>
                            <asp:BoundField DataField="Reg_No" HeaderText="Reg_No" SortExpression="Reg_No" Visible="False" />
                            <asp:BoundField DataField="Yearly_No" HeaderText="Yearly_No" SortExpression="Yearly_No"
                                Visible="False" />
                            <asp:BoundField DataField="Ward_Name" HeaderText="Floor" SortExpression="Ward_Name" />
                            <asp:BoundField DataField="Bed_No" HeaderText="Room" SortExpression="Bed_No" />
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="CH_head" runat="server" AutoPostBack="True" OnCheckedChanged="CH_head_CheckedChanged" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                    <asp:HiddenField ID="HiddenFieldRegNo" runat="server" Value='<%# Bind("Reg_No") %>' />
                                    <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" Value='<%# Bind("Yearly_No") %>' />
                                    <asp:HiddenField ID="HiddenFieldBed_Id" runat="server" Value='<%# Bind("Bed_id") %>' />
                                    <asp:HiddenField ID="floorID" runat="server" Value='<%# Bind("FloorID")%>' />
                                    <asp:HiddenField ID="ward_Id" runat="server" Value='<%# Bind("ward_Id")%>' />
                                    
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Bed_id" HeaderText="Bed_id" InsertVisible="False" SortExpression="Bed_id"
                                Visible="False" />
                        </Columns>
                    </asp:GridView>
                    <br />
                    <div style="width: 100%; text-align: center;">
                        Reason For Leave :
                        <asp:TextBox ID="TextBoxReason" runat="server" CssClass="input_txt"></asp:TextBox>
                        <br />
                        <div align="center">
                            <asp:Button ID="Button1" runat="server" CssClass="btn1" OnClick="Button1_Click" Text="Release" />
                            <asp:Label ID="Lbl_Mg0" runat="server" Font-Bold="True" Font-Strikeout="False" ForeColor="#FF0066"></asp:Label>
                        </div>
                        <br />
                    </div>
                </div>
            </td>
            <td valign="top" class="style1">
                <div class="bxmain inner_content" style="width: 100%;">
                <h2><span></span></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr>
                            <td align="right">
                                Change Consultant :
                            </td>
                            <td>
                                <asp:UpdatePanel ID="UDP_consultant" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txt_Consultant" runat="server" AutoPostBack="True"></asp:TextBox><br />
                                        <asp:HiddenField ID="hf_consultant" runat="server" Value="%" />
                                        <asp:DropDownList ID="DropDownList_Consultant" runat="server" AutoPostBack="True"
                                            DataSourceID="SqlDataSource_Consultant" DataTextField="Employee Name" DataValueField="EmpID"
                                            Width="202px">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource_Consultant" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                                            SelectCommand="select ''  AS [Employee Name], 0 as EmpID union SELECT  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name], EmpID FROM  Employee WHERE   (IS_Consultant = @IS_Consultant) and (Employee.ActiveStatus=1)
                    and ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') like @name;">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="1" Name="IS_Consultant" />
                                                <asp:ControlParameter ControlID="hf_consultant" DefaultValue="" Name="name" PropertyName="Value" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Refer By :
                            </td>
                            <td>
                                <asp:DropDownList ID="Dropdownlist_Refby" runat="server" DataSourceID="SqlDataSource_Consultant"
                                    DataTextField="Employee Name" DataValueField="EmpID" Width="201px">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourcePType" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                                    SelectCommand="SELECT    Patient_Type_ID, Patient_type
FROM         Patient_type
where Active = 1"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                            <td>
                                &nbsp;<asp:Button ID="Button_Cons" runat="server" Text="Update Consulant" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Patiet Type :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownListPType" runat="server" DataSourceID="SqlDataSourcePType"
                                    DataTextField="Patient_type" DataValueField="Patient_Type_ID" Width="125px" Enabled="False">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Floor/ Ward :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownListFloor" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceFloor"
                                    DataTextField="Ward_Name" DataValueField="Ward_id" Width="125px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>
                                :
                            </td>
                            <td align="left">
                                <asp:CheckBoxList ID="CheckBoxListRoom" runat="server" CssClass="chklist" DataSourceID="SqlDataSourceRoomBed"
                                    DataTextField="Bed_No" DataValueField="ward_Id" RepeatDirection="Horizontal"
                                    Visible="False" RepeatColumns="8">
                                </asp:CheckBoxList>
                                <asp:RadioButtonList ID="RadioButtonListBed" runat="server" CssClass="radlist" DataSourceID="SqlDataSourceRoomBed"
                                    DataTextField="Bed_No" DataValueField="ward_Id" RepeatDirection="Horizontal"
                                    Visible="False" RepeatColumns="8">
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="Button3" runat="server" CssClass="btn1" Text="Allocate" />
                                <asp:Label ID="Lbl_Mg" runat="server" Font-Bold="True" Font-Strikeout="False" ForeColor="#FF0066"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceRoomOccupied" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT Pt_Assign_Bed.Reg_No, Pt_Assign_Bed.Yearly_No,Ward_Beds.ward_Id,Pt_Assign_Bed.FloorID, admin_Hospital_Wards.Ward_Name, Ward_Beds.Bed_No, Ward_Beds.Bed_id, admin_Hospital_Wards.Ward_Name AS Expr1
FROM            Pt_Assign_Bed INNER JOIN
                         Ward_Beds ON Pt_Assign_Bed.Bed_id = Ward_Beds.Bed_id INNER JOIN
                         admin_Hospital_Wards ON Pt_Assign_Bed.Ward_id = admin_Hospital_Wards.Ward_id
WHERE        (Ward_Beds.Bed_Status = 1) AND (Pt_Assign_Bed.Yearly_No = @Yearly_No) AND (Pt_Assign_Bed.Pt_Status = 0)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="Yearly_No" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:TextBox ID="TextBoxRegNo" runat="server" Visible="False"></asp:TextBox>&nbsp;&nbsp;
    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
    <asp:HiddenField ID="HiddenFieldBed_Id" runat="server" />
    <asp:SqlDataSource ID="dsPatientInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT Patient.RegNo, ISNULL(Patient.Prefix, ' ') AS prefix, ISNULL(Patient.PFName, ' ') AS pfname, ISNULL(Patient.PMName, ' ') AS pmname, ISNULL(Patient.PLName, ' ') AS PLName, UPPER(Patient.Relation) AS Relation, UPPER(ISNULL(Patient.RFName, ' ')) + ' ' + UPPER(ISNULL(Patient.RMName, ' ')) + ' ' + UPPER(ISNULL(Patient.RLName, ' ')) AS RELATIONNAME, CONVERT (varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) / 365) + '  Years  ' + CONVERT (varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) % 365 / 30) + '  M  ' + CONVERT (varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) % 365 % 30) + '  D' AS Age, UPPER(Gender.Gender) AS Gender, CONVERT (varchar, Patient.DateOfBirth, 107) AS DateOfBirth, Patient.CNIC, CONVERT (varchar, Patient.DateOfBirth, 107) AS DateOfBirth, ISNULL(Patient.House_No, '') + ' ' + ISNULL(Patient.StreetAddress, ' ') + ' ' + ISNULL(Patient.Colony, ' ') + ' ' + ISNULL(Tehsil.TehsilName, '') AS Address FROM Patient LEFT OUTER JOIN Gender ON Patient.SexID = Gender.Gender_ID LEFT OUTER JOIN Tehsil ON Patient.TehsilCode = Tehsil.TehsilCode WHERE (Patient.RegNo = @RegNo)">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="registrationno" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceUpdateWardBed" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Ward_Beds SET Bed_Status = 0,YearlyNo=NULL WHERE (Bed_id = @Bed_id) ">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldBed_Id" Name="Bed_id" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUpdatePt_Assign_Bed" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Pt_Assign_Bed SET Pt_Status = 1, leave_datetime = GETDATE(), Change_Room = 1 WHERE (Bed_id = @Bed_id) AND (Reg_No = @Reg_No) AND (Yearly_No = @Yearly_No)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldBed_Id" Name="Bed_id" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldRegNo" Name="Reg_No" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="Yearly_No" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceFloor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT Ward_Name, Ward_id, isDeleted&#13;&#10;FROM         admin_Hospital_Wards&#13;&#10;WHERE     (isDeleted = 0) &#13;&#10;">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRoomBed" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     Ward_Beds.ward_Id, Ward_Beds.Bed_No, Ward_Beds.Bed_Status
FROM         admin_Hospital_Wards INNER JOIN
                      Ward_Beds ON admin_Hospital_Wards.Ward_id = Ward_Beds.ward_Id
WHERE     (isnull(Ward_Beds.Bed_Status,0) = 0) and Ward_Beds.Ward_Id=@Ward_Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListFloor" Name="Ward_Id" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldBedID" runat="server" />
    <asp:HiddenField ID="HiddenFieldWard_Id" runat="server" />
    <asp:HiddenField ID="updateWardID"  runat="server"/>
    <asp:HiddenField ID="updateFloorID"  runat="server"/>
     <asp:SqlDataSource ID="SqlDataSource_Update" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        UpdateCommand="insert_Patient_Assign_Bed" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldWard_Id" Name="ward_Id" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldBedID" Name="Bed_ID" PropertyName="Value" />
             <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
            <asp:SessionParameter Name="admission_By" SessionField="Emp_Id" />
            <asp:ControlParameter ControlID="DropDownListFloor" Name="FloorID" PropertyName="SelectedValue" />
            <asp:Parameter Name="Patient_Type" DefaultValue="1" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldBedRoomCharges" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        InsertCommand="pt_InnerDepartment_PatientForward" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldRegNo" Name="RegNo" PropertyName="Value"
                Type="String" />
            <asp:SessionParameter Name="EmpID" SessionField="emp_id" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="PayID" PropertyName="Value"
                Type="Decimal" />
            <asp:ControlParameter ControlID="DropDownListFloor" Name="ToSubDept" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldSubDepartment" Name="SendingDept" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="iRequestTypeTo" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="iRequestTypeBy" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUpdatePayment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="Update_Payment_For_Consultant"
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="DropDownList_Consultant" Name="DoctorID" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
            <asp:SessionParameter Name="PayID" SessionField="YearlyNo" />
            <asp:ControlParameter ControlID="Dropdownlist_Refby" Name="Refer_By_ID" PropertyName="SelectedValue"
                Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldSubDepartment" runat="server" />
    <div style="height: 200px; overflow: scroll; overflow-x: hidden; overflow-y: scroll;">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
            DataSourceID="SqlDataSourceForGridHistory" Width="99%">
            <Columns>
                <asp:BoundField DataField="SubDept_Name" HeaderText="Floor" SortExpression="SubDept_Name" />
                <asp:BoundField DataField="Bed_No" HeaderText="Room/Bed" SortExpression="Bed_No" />
                <asp:BoundField DataField="Admission Date" HeaderText="Admission Date" SortExpression="Admission Date" />
                <asp:BoundField DataField="Admission Time" HeaderText="Admission Time" SortExpression="Admission Time" />
                <asp:BoundField DataField="Leave Date" HeaderText="Release Date" SortExpression="Leave Date" />
                <asp:BoundField DataField="Leave Time" HeaderText="Release Time" SortExpression="Leave Time" />
            </Columns>
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceForGridHistory" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT SubDepartment.SubDept_Name, Ward_Beds.Bed_No, CONVERT(varchar, Pt_Assign_Bed.datetime, 107) AS [Admission Date], &#13;&#10;                      RIGHT(Pt_Assign_Bed.datetime, 7) AS [Admission Time], ISNULL(CONVERT(varchar, Pt_Assign_Bed.leave_datetime, 107), '') AS [Leave Date], &#13;&#10;                      isnull(RIGHT(Pt_Assign_Bed.leave_datetime, 7),'') AS [Leave Time]&#13;&#10;FROM         Pt_Assign_Bed INNER JOIN&#13;&#10;                      admin_Hospital_Wards ON Pt_Assign_Bed.Ward_id = admin_Hospital_Wards.Ward_id INNER JOIN&#13;&#10;                      Ward_Beds ON Pt_Assign_Bed.Bed_id = Ward_Beds.Bed_id INNER JOIN&#13;&#10;                      SubDepartment ON Pt_Assign_Bed.FloorID = SubDepartment.SubDept_Id&#13;&#10;WHERE     (Pt_Assign_Bed.Yearly_No = @Yearly_No)&#13;&#10;ORDER BY Pt_Assign_Bed.datetime, Pt_Assign_Bed.leave_datetime">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="Yearly_No" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%--
       </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
