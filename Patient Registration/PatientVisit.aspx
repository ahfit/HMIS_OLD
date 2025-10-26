<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="false" CodeFile="PatientVisit.aspx.vb" Inherits="Patient_Registration_PatientVisit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>

    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<asp:ScriptManager ID="scrptmPatientVisit" runat="server">
    </asp:ScriptManager>--%>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top">
                <asp:FormView ID="fmvPatientInfo" runat="server" HorizontalAlign="Left" Width="100%"
                    DataSourceID="dsPatientInfo" DataKeyNames="RegNo">
                    <ItemTemplate>
                        <div id="p_info" class="patient-info" style="min-height: 20px; line-height: 22px;">
                            <ul style="margin-left: 10px;">
                                <li style="display: inline;"><span class="age" style="display: inline;">MR # &nbsp;<span
                                    class="reg"><strong><asp:Label ID="RegistrationNo" ToolTip="Patient Registration Number"
                                        runat="server" Text='<%# Eval("RegNo") %>'></asp:Label></strong></span><span class="splt">|</span>
                                    <span class="name-p">
                                        <asp:Label ID="PatientNameLabel" runat="server" ToolTip="Patient Name" Text='<%# Eval("prefix", "{0}") %>'></asp:Label>
                                    </span><span class="relation">&nbsp;<asp:Label ID="RelationLabel" ToolTip="Patient Relation"
                                        runat="server" Text='<%# Bind("Relation", "{0}") %>'></asp:Label>&nbsp;</span>
                                    <strong>
                                        <asp:Label ID="RelationNameLabel" ToolTip="Patient Relation Name" runat="server"
                                            Text='<%# Eval("RELATIONNAME", "{0}") %>'></asp:Label></strong><span class="splt">|
                                                <span style="color: #333333">Age :</span></span> <span class="age" style="display: inline;">
                                                    <asp:Label ID="AgeLabel" ToolTip="Patient Age" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                                                    Year(s)<span class="splt">|</span><asp:Label ID="LabelDateofBirth" ToolTip="Patient Date of Birth"
                                                        runat="server" Text='<%# Eval("DateOfBirth") %>' Visible="False"></asp:Label><span
                                                            class="splt"></span><asp:Label ID="LabelGender" ToolTip="Patient Gender" runat="server"
                                                                Text='<%# Eval("Gender", "{0}") %>'></asp:Label></span>
                                    <asp:Label ID="Label_Address" Visible="false" ToolTip="Patient Address" runat="server"
                                        Text='<%# Bind("Address", "{0}") %>'></asp:Label> </li>
                            </ul>

                            <asp:HiddenField ID="HiddenField_Pfname" runat="server" Value='<%# Eval("pfname", "{0}") %>' />
                            <asp:HiddenField ID="HiddenField_Pmname" runat="server" Value='<%# Eval("pmname", "{0}") %>' />
                            <asp:HiddenField ID="HiddenField_Plname" runat="server" Value='<%# Eval("PLName") %>' />
                            <asp:HiddenField ID="HF_Pt_Type" runat="server" Value='<%# Eval("Patient_Type") %>' />
                            
                        </div>
                        </SPAN>
                    </ItemTemplate>
                </asp:FormView>
                <br />
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" style="width: 700px">
                            <br />
                            <div class="bxmain" style="margin-top: 0; width:99%;">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                                    <tr style="display:none;">
                                        <td align="right" width="30%" style="height: 18px">
                                            MR # :</td>
                                        <td style="height: 18px">
                                            <asp:TextBox ID="txtMrNo" runat="server"></asp:TextBox>
                                            <asp:Button ID="btnSearch" runat="server" Text="Search"  />
                                            &nbsp;
                                            <asp:LinkButton ID="lbt_edit_Emp_info" runat="server" Visible="false">Edit Patient</asp:LinkButton>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMrNo"
                                                ErrorMessage="Please Enter Mr #." Enabled="False"></asp:RequiredFieldValidator>
                                            <asp:Image ID="Image_Pic" runat="server" ImageUrl="~/images_hacims/picplace.jpg"
                                                Height="100px" Width="85px" 
                                                Style="position: absolute; left: 45px;top:174px;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="display: none">
                                            <asp:Label ID="Label_Dept" runat="server" Text="Department :"></asp:Label>&nbsp;</td>
                                        <td style="display: none">
                                            <asp:DropDownList AccessKey="d" ID="DDLDepartment" DataSourceID="SqlDataSource_Department" runat="server" TabIndex="1" Width="300px"
                                                AutoPostBack="True" DataTextField="Dept_Name" DataValueField="Dept_ID" Style="text-transform: uppercase;">
                                                <asp:ListItem Value="6">Emergency</asp:ListItem>
                                            </asp:DropDownList>&nbsp;
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="height: 18px">
                                            <asp:Label ID="Label_Subdept" runat="server" Text="Sub-Department :"></asp:Label></td>
                                        <td style="height: 18px">
                                            <asp:DropDownList ID="ddlSubDept" runat="server" DataSourceID="SqlDataSource_SubDept"
                                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" Width="199px" 
                                                AutoPostBack="True" TabIndex="2">
                                            </asp:DropDownList></td>
                                    </tr>
                                </table>
                                <asp:Panel ID="pnl_ward" Width="100%" runat="server">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                                        <tr>
                                            <td align="right" width="30%" style="height: 18px">
                                                <asp:Label ID="Label_Ward" runat="server" Text="Ward :"></asp:Label>
                                            </td>
                                            <td style="height: 18px">
                                                <asp:DropDownList ID="DDL_Ward" runat="server" DataSourceID="SqlDataSourceWardFloor"
                                                    DataTextField="Ward_Name" DataValueField="Ward_id" Width="199px" 
                                                    TabIndex="3" AutoPostBack="True">
                                                </asp:DropDownList>
                                                
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                                    <tr>
                                        <td align="right" width="30%">
                                            Search :</td>
                                        <td>
                 <asp:TextBox ID = "txt_Consultant" runat = "server" AutoPostBack="True" TabIndex="4"></asp:TextBox>

                 <asp:HiddenField ID ="hf_consultant" runat ="server" value ="%" />
                                            </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="30%">
                                            Admit By :</td>
                                        <td>
                                            <br />
                                            <asp:DropDownList ID="ddl_Doctor" runat="server" DataSourceID="SQL_Select_Doctor"
                                                DataTextField="Employee Name" 
                                                DataValueField="EmpID" Width="202px" AutoPostBack="True" TabIndex="4">
                                                <asp:ListItem Text="" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                                  <asp:SqlDataSource ID="SQL_Select_Doctor" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                    SelectCommand="select ''  AS [Employee Name], 0 as EmpID 
union
SELECT     ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name], EmpID
FROM         Employee
WHERE     (Is_Consultant = 1) AND (ActiveStatus = 1) 
 and ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') like @name;" 
                                                CancelSelectOnNullParameter="False">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="IS_Consultant" />
                        <asp:ControlParameter ControlID="hf_consultant" DefaultValue="" Name="name" 
                            PropertyName="Value" />
                      
                    </SelectParameters>
                </asp:SqlDataSource>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Consultant:</td>
                                        <td>
                                            <asp:DropDownList ID="ddlEmployeeName" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="ddlEmployeeName_SelectedIndexChanged" DataSourceID="SqlDataSource_Employee"
                                                DataTextField="Employee Name" 
                                                DataValueField="EmpID" Width="202px" TabIndex="5">
                                              
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="Label1" runat="server" Text="Complaint :"></asp:Label></td>
                                        <td>
                                            <asp:DropDownList DataTextField="Diagnosis" DataValueField="Diagnosis" ID="ddlDiagnosis"
                                                runat="server" TabIndex="6" DataSourceID="SqlDataSourceDiagnosis" 
                                                Width="202px">
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="Label2" runat="server" Text="Other :"></asp:Label></td>
                                        <td>
                                            <asp:TextBox AccessKey="f" CssClass="input_txt" ID="TextBoxDiagnosis" runat="server"
                                                TabIndex="7"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Referred From :</td>
                                        <td>
                                            <asp:TextBox ID="txtReferedFrom" runat="server" TabIndex="8"></asp:TextBox>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Room No :</td>
                                        <td>
                                            <asp:TextBox ID="txtRoomNo" runat="server" TabIndex="9"></asp:TextBox>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="Label_Ins_Detail" runat="server" Text="Referrence Letter :" Visible="False"></asp:Label></td>
                                        <td>
                                            <asp:TextBox ID="TextBox_Ins_Detail" runat="server" Height="135px" TextMode="MultiLine"
                                                Visible="False" Width="90%"></asp:TextBox></td>
                                    </tr>
                                   
                                    <tr>
                                      <td align="right">Patient Type:</td>
                                        <td>
                                        
                                            <br />
                                        
                                            <asp:RadioButtonList ID="RadioButtonList_Type" runat="server" RepeatLayout="Flow"
                                                RepeatColumns="2" RepeatDirection="Horizontal" Visible="False">
                                                <asp:ListItem Selected="True">Paid</asp:ListItem>
                                                <asp:ListItem>Free</asp:ListItem>
                                            </asp:RadioButtonList>
                                         
                                            <asp:RadioButtonList ID="rblPatientTypeCategory" runat="server"
                                                DataSourceID="SqlDataSourcePatientTypeCategory" DataValueField="Patient_type_Cat"
                                                DataTextField="Patient_type_Cat" AutoPostBack="True" RepeatDirection="Horizontal"
                                                RepeatLayout="Flow" Visible="False">
                                            </asp:RadioButtonList>
                                            <asp:SqlDataSource ID="SqlDataSourcePatientTypeCategory" runat="server"
                                                SelectCommand="SELECT DISTINCT Patient_type_Cat FROM Patient_type WHERE (Active = 1) ORDER BY Patient_type_Cat DESC"
                                                ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>">                                                
                                                </asp:SqlDataSource>
                                            
                                            <asp:DropDownList ID="RadioButtonList_Patient_Type" runat="server" DataSourceID="SQL_Patient_Type_Sub"  DataValueField="Patient_Type_ID" DataTextField="Patient_type" AutoPostBack="True" TabIndex="10"></asp:DropDownList>
                                            &nbsp;&nbsp;&nbsp;
                                            <asp:DropDownList ID="ddlRate" runat="server"  
                                    TabIndex = "11" 
                                    DataSourceID="SqlDataSource_Consul_Rate" DataTextField="S_Amount" 
                                    DataValueField="Id" Height="20px" Width="69px" style="background: chartreuse;">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Consul_Rate" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" SelectCommand="SELECT        Admin_OPD_Slip_Rates.Id, Admin_OPD_Slip_Rates.S_Amount, Admin_OPD_Slip_Rates.Patient_Type_id, MapServiceswithDoctor.DeptID
FROM            Admin_OPD_Slip_Rates INNER JOIN
                         MapServiceswithDoctor ON Admin_OPD_Slip_Rates.Id = MapServiceswithDoctor.S_ID
WHERE        (Admin_OPD_Slip_Rates.Patient_Type_id = @Patient_Type_Id) AND (MapServiceswithDoctor.DoctorID = @DoctorID) AND (MapServiceswithDoctor.DeptID = @DeptID)
ORDER BY Admin_OPD_Slip_Rates.S_Amount">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="RadioButtonList_Patient_Type" Name="Patient_Type_Id" 
                                            PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="ddlEmployeeName" Name="DoctorID" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="ddlSubDept" Name="DeptID" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                            
                                            <asp:SqlDataSource ID="SQL_Patient_Type_Sub" runat="server"
                                                SelectCommand="SELECT     *&#13;&#10;FROM         Patient_Type AS pt INNER JOIN&#13;&#10;                      Patient_Type_HospitalWise AS pth ON pt.ID = pth.Patient_Type_Id&#13;&#10;WHERE   (pth.Hospital_Id = @Hospital_Id) and pt.Active = 'True' --AND (Patient_type_Cat = @Patient_type_Cat)"
                                                ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                                                                            <table>
                                                    <tbody>
                                                        <tr runat ="Server" id ="td_Insurer">
                                                            <td style="width: 100px">
                                                                Insurer :</td>
                                                            <td style="width: 100px">
                                                                <asp:DropDownList ID="DropDownList_Parties" runat="server" CssClass="panedrop" DataSourceID="SqlDataSource_parties"
                                                                    Width="150px" DataValueField="Party_Id" DataTextField="Party_Name" AutoPostBack="True">
                                                                </asp:DropDownList></td>
                                                        </tr>
                                                        <tr runat ="Server" id ="td_Employee_Designation">
                                                            <td style="width: 100px">
                                                                Employee Designation :</td>
                                                            <td style="width: 100px">
                                                                <asp:DropDownList ID="ddlDesignation" runat="server" DataSourceID="dsDesignations"
                                                                    DataValueField="Party_Desg_ID" DataTextField="Party_Desg_Name" AutoPostBack="True">
                                                                </asp:DropDownList></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                    <tr>
                                        <td align="right">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>

                                            <asp:Panel ID="pnlPanelPatient" runat="server">
                                            </asp:Panel>
                                           
                                        </td>
                                    </tr>
                                   
                                    <tr>
                                        <td align="right" valign="top">
                                            &nbsp;</td>
                                        <td>
                                            <asp:Label ID="lbl_Referal_Department" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top">
                                            &nbsp;</td>
                                        <td>
                                            <asp:Label ID="lbl_Referal_subDept" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            &nbsp;</td>
                                        <td>
                                            
                                            <asp:Button ID="Button_SaveAndPrint" runat="server" Text="Save & Print" 
                                                TabIndex="12" 
                                                onclientclick="javascript: return confirm('Are you sure you want to Save and print?')" />&nbsp;
                                            <asp:Button ID="btn_Return" runat="server" Text="Return" OnClick="btn_Return_Click"
                                                TabIndex="12" />
                                            <asp:HiddenField ID="hfRegNo" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            &nbsp;
                            <asp:Panel ID="pnlParentInfo"  runat="server" Visible="False">
                                <table>
                                    <tr>
                                        <td style="width: 100px">
                                            Parent Name</td>
                                        <td style="width: 100px">
                                            <asp:Label ID="lblParentName" runat="server"></asp:Label></td>
                                        <td style="width: 100px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100px">
                                            Registration Date</td>
                                        <td style="width: 100px">
                                            <asp:Label ID="lblRegistrationDate" runat="server"></asp:Label></td>
                                        <td style="width: 100px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100px">
                                        </td>
                                        <td style="width: 100px">
                                        </td>
                                        <td style="width: 100px">
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td valign="top">
                            <asp:Panel runat="server" ID="panel_admit" Width="100%">
                                <br />
                                <asp:Panel runat="server" ID="payment_info" Width="100%">
                                    <div class="bx_rad" style="margin-left: 8px;">
                                        <ul id="CollapsiblePanel1">
                                            <li><strong>&nbsp;Patient Advances</strong></li><li>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                                    <tr>
                                                        <td align="right" style="width: 160px">
                                                            Category</td>
                                                        <td>
                                                            <asp:RadioButtonList ID="RadioButtonListCategory" runat="server" RepeatColumns="2"
                                                                RepeatLayout="Flow" TabIndex="10">
                                                                <asp:ListItem Selected="True" Value="AdmissionAdvance">Admission Advance</asp:ListItem>
                                                            </asp:RadioButtonList></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 160px">
                                                            Advance Payment :
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="TextBox_Payment" runat="server" CssClass="input_txt" 
                                                                TabIndex="11"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 160px">
                                                            Package :</td>
                                                        <td>
                                                            <asp:DropDownList ID="DropDownList_Admin_Service_Package" runat="server" AutoPostBack="True"
                                                                DataSourceID="SqlDataSource_Admin_Service_Package" DataTextField="AP_Name" 
                                                                DataValueField="ASP_ID" TabIndex="12">
                                                            </asp:DropDownList>
                                                            <asp:SqlDataSource ID="SqlDataSource_Admin_Service_Package" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                                SelectCommand="SELECT 0 AS ASP_ID, '' AS AP_Name UNION SELECT ASP_ID, AP_Name FROM Admin_Service_Package  ">
                                                              
                                                                   
                                                            </asp:SqlDataSource>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 160px">
                                                            Remarks :</td>
                                                        <td>
                                                            <asp:TextBox ID="TextBox_description" runat="server" CssClass="input_txt" 
                                                                Width="270px" TabIndex="13"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 160px; height: 18px">
                                                            &nbsp;Payment Mode :</td>
                                                        <td style="height: 18px">
                                                            <asp:DropDownList ID="DropDownList_Payment_Type" runat="server" 
                                                                AutoPostBack="True" TabIndex="14">
                                                                <asp:ListItem>Cash</asp:ListItem>
                                                                <asp:ListItem>Cheque</asp:ListItem>
                                                                <asp:ListItem>Credit Card</asp:ListItem>
                                                            </asp:DropDownList></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 160px">
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label_script" runat="server" Text=""></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 160px">
                                                        </td>
                                                        <td>
                                                        
                                                            <asp:Button ID="Button_SaveAll" runat="server" Text="Save &amp; Admit" 
                                                                TabIndex="15" />
                                                            <asp:Label ID="Label3" runat="server" BorderColor="#FF0066"></asp:Label>
                                                        </td>

                                                          </tr>
                                                </table>
                                                <asp:Panel ID="Panel_Bank" runat="server" Visible="False" Width="100%">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td style="width: 85px" align="right">
                                                                Bank Name :</td>
                                                            <td>
                                                                <asp:TextBox ID="TextBox_Bank_Name" runat="server" CssClass="input_txt"></asp:TextBox></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 85px">
                                                                Branch Name :</td>
                                                            <td style="width: 100px">
                                                                <asp:TextBox ID="TextBox_Branch_Name" runat="server" CssClass="input_txt"></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                <asp:Panel ID="Panel_cheque" runat="server" Width="100%" Visible="False">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td align="right" style="width: 65px">
                                                                Cheque # :</td>
                                                            <td style="width: 100px">
                                                                <asp:TextBox ID="TextBox_Cheque_no" runat="server"></asp:TextBox></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 65px">
                                                                Cheque Date :
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="TextBox_ChequeDate" runat="server"></asp:TextBox></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 65px">
                                                            </td>
                                                            <td style="width: 100px">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                <asp:Panel ID="Panel_Card" runat="server" Visible="False" Width="100%">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td align="right" style="width: 67px">
                                                                Card # :</td>
                                                            <td style="width: 100px">
                                                                <asp:TextBox ID="TextBox_Cradit_Card_No" runat="server"></asp:TextBox></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 67px">
                                                                Card Type :</td>
                                                            <td style="width: 100px">
                                                                <asp:DropDownList ID="DropDownList_Card_Type" runat="server" Width="155px">
                                                                    <asp:ListItem>Credit Card</asp:ListItem>
                                                                    <asp:ListItem>Debit Card</asp:ListItem>
                                                                </asp:DropDownList></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 67px">
                                                                Card Service :</td>
                                                            <td style="width: 100px">
                                                                <asp:TextBox ID="TextBox_Card_Service" runat="server"></asp:TextBox></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 67px">
                                                                Approval # :</td>
                                                            <td style="width: 100px; height: 12px">
                                                                <asp:TextBox ID="TextBox_approval_no" runat="server"></asp:TextBox></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 67px">
                                                            </td>
                                                            <td style="width: 100px">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </li>
                                            <li>
                                                <asp:GridView ID="GridView_Advance" runat="server" AutoGenerateColumns="False" DataKeyNames="Payment_No"
                                                    DataSourceID="SqlDataSource_For_Grid" Height="149px" Width="100%">
                                                    <RowStyle CssClass="GridItem" />
                                                    <Columns>
                                                        <asp:ButtonField CommandName="Delete" Text="Delete" />
                                                        <asp:BoundField DataField="YearlyNo" HeaderText="File No." SortExpression="YearlyNo" />
                                                        <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                                                        <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                                                        <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                                                        <asp:BoundField DataField="Check_No" HeaderText="Check No." SortExpression="Check_No"
                                                            Visible="False" />
                                                        <asp:BoundField DataField="Bank_Name" HeaderText="Bank Name" SortExpression="Bank_Name"
                                                            Visible="False" />
                                                        <asp:BoundField DataField="Branch_Name" HeaderText="Branch Name" SortExpression="Branch_Name"
                                                            Visible="False" />
                                                        <asp:BoundField DataField="Payment_No" HeaderText="Payment_No" InsertVisible="False"
                                                            SortExpression="Payment_No" />
                                                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                                    </Columns>
                                                    <HeaderStyle CssClass="GridHeader" />
                                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    DeleteCommand="DELETE FROM Advance_Payment WHERE (Payment_No = @Payment_No)"
                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                    SelectCommand="SELECT YearlyNo, CONVERT (varchar, Pay_DateTime, 107) AS Date, CONVERT (varchar, Pay_DateTime, 108) AS Time, Amount, Check_No, Bank_Name, Branch_Name, Payment_No, Status FROM Advance_Payment WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (Status = 0)">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                                    </SelectParameters>
                                                    <DeleteParameters>
                                                        <asp:ControlParameter ControlID="GridView1" Name="Payment_No" PropertyName="SelectedValue" />
                                                    </DeleteParameters>
                                                </asp:SqlDataSource>
                                            </li>
                                        </ul>
                                    </div>
                                </asp:Panel>
                                <br />
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td valign="top">
                                            <asp:Panel runat="server" ID="assignbed" Width="100%">
                                                <asp:SqlDataSource ID="SqlDataSourceFloor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                    SelectCommand="SELECT DISTINCT SubDepartment.SubDept_Id, Department.Dept_Name + ' ( ' + SubDepartment.SubDept_Name + ' )' AS SubDept_Name FROM Department INNER JOIN SubDepartment ON Department.Dept_ID = SubDepartment.Dept_Id INNER JOIN admin_Hospital_Wards ON SubDepartment.SubDept_Id = admin_Hospital_Wards.SubDept_Id WHERE (SubDepartment.SubDept_Name <> 'Admin') AND (SubDepartment.SubDept_Name <> 'Cardic')">
                                                </asp:SqlDataSource>
                                                <asp:HiddenField ID="HiddenFieldWard_SubDept_ID" runat="server" />
                                                <asp:SqlDataSource ID="SqlDataSourceWardFloor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                    SelectCommand="select 0 as Ward_id, '' as Ward_Name
union
SELECT DISTINCT admin_Hospital_Wards.Ward_id, admin_Hospital_Wards.Ward_Name
FROM         admin_Hospital_Wards 
">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalId" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                &nbsp;&nbsp;&nbsp;&nbsp;<asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
                                                <asp:SqlDataSource ID="SDC_Shift_To_Other" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                                    InsertCommand="Insert_Patient_Subdept_InOut" InsertCommandType="StoredProcedure"
                                                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
                                                    <InsertParameters>
                                                        <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" Type="String" />
                                                        <asp:SessionParameter Name="yearly_no" SessionField="PayId" Type="Decimal" />
                                                        <asp:SessionParameter Name="Admit_By" SessionField="Emp_ID" Type="Int32" />
                                                        <asp:SessionParameter Name="Discharge_By" SessionField="Emp_ID" Type="Int32" />
                                                        <asp:ControlParameter ControlID="ddlEmployeeName" Name="Consultant_Id" PropertyName="SelectedValue"
                                                            Type="Int32" />
                                                        <asp:SessionParameter Name="From_Sub_DeptID" SessionField="dept_id" Type="Int32" />
                                                        <asp:ControlParameter ControlID="ddlSubDept" Name="To_Sub_DeptID" PropertyName="SelectedValue"
                                                            Type="Int32" />
                                                    </InsertParameters>
                                                </asp:SqlDataSource>
                                                <asp:SqlDataSource ID="SqlDataSourceRoomBed" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                    SelectCommand="SELECT DISTINCT Ward_Beds.Bed_No, SubDepartment.SubDept_Id, Ward_Beds.Bed_id, Ward_Beds.ward_Id, admin_Hospital_Wards.Ward_Name AS SubDept_Name, SubDepartment.[Order] FROM Pt_Assign_Bed RIGHT OUTER JOIN Ward_Beds INNER JOIN SubDepartment INNER JOIN admin_Hospital_Wards ON SubDepartment.SubDept_Id = admin_Hospital_Wards.SubDept_Id ON Ward_Beds.ward_Id = admin_Hospital_Wards.Ward_id ON Pt_Assign_Bed.Bed_id = Ward_Beds.Bed_id AND Pt_Assign_Bed.Ward_id = Ward_Beds.ward_Id WHERE (admin_Hospital_Wards.Ward_id =@ward_id) ORDER BY SubDepartment.[Order]">
                                                    <SelectParameters>
                                                        <asp:Parameter Name="ward_id" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <asp:HiddenField ID="HiddenField_EncrRegNo" runat="server" />
                                                <asp:SqlDataSource ID="SqlDataSource_Save" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                    InsertCommand="insert_Patient_Assign_Bed" InsertCommandType="StoredProcedure">
                                                    <InsertParameters>
                                                        <asp:ControlParameter ControlID="HiddenFieldBedID" DefaultValue="" Name="Ward_id"
                                                            PropertyName="Value" />
                                                        <asp:ControlParameter ControlID="HiddenFieldWard_Id" DefaultValue="" Name="Bed_id"
                                                            PropertyName="Value" />
                                                        <asp:SessionParameter Name="admission_By" SessionField="emp_id" />
                                                        <asp:ControlParameter ControlID="HiddenField_EncrRegNo" DefaultValue="" Name="Reg_No"
                                                            PropertyName="Value" />
                                                        <asp:SessionParameter DefaultValue="" Name="Yearly_No" SessionField="YearlyNo" />
                                                        <asp:ControlParameter ControlID="DDL_Ward" Name="FloorID" PropertyName="SelectedValue"
                                                            Type="Int32" />
                                                    </InsertParameters>
                                                </asp:SqlDataSource>
                                                <asp:SqlDataSource ID="SqlDataSource_Update" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                    UpdateCommand="UPDATE Ward_Beds SET Bed_Status = 1 WHERE (ward_Id = @ward_Id) AND (Bed_id = @Bed_ID) 

">
                                                    <UpdateParameters>
                                                        <asp:ControlParameter ControlID="HiddenFieldWard_Id" Name="ward_Id" PropertyName="Value" />
                                                        <asp:ControlParameter ControlID="HiddenFieldBedID" Name="Bed_ID" PropertyName="Value" />
                                                    </UpdateParameters>
                                                </asp:SqlDataSource>
                                                <asp:HiddenField ID="HiddenFieldMainId" runat="server" />
                                                <asp:HiddenField ID="HiddenFieldBedID" runat="server" />
                                                <asp:HiddenField ID="HiddenFieldSubDepartment" runat="server" />
                                                <asp:SqlDataSource ID="SqlDataSourceCounterClose" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    DeleteCommand="DELETE FROM Sub_Counter_Close WHERE (Reg_No = @Reg_No) AND (YearlyNo = @YearlyNo) AND (Main_Id = @Main_Id)"
                                                    InsertCommand="INSERT INTO Sub_Counter_Close (Amount, Amount_Type, Dept_Id, SubDept_Id, Date_time, Reg_No, YearlyNo, PaymentCategory, Main_Id, Adv_payment_ID, emp_id) VALUES     (@Amount,@Amount_Type,@Dept_Id,@SubDept_Id, GETDATE(),@Reg_No,@YearlyNo,@PaymentCategory,@Main_Id,@Main_Id,@emp_id)"
                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                                                    <InsertParameters>
                                                        <asp:ControlParameter ControlID="TextBox_Payment" Name="Amount" PropertyName="Text" />
                                                        <asp:Parameter DefaultValue="Advance" Name="Amount_Type" />
                                                        <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />
                                                        <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
                                                        <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" />
                                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                                        <asp:ControlParameter ControlID="RadioButtonListCategory" Name="PaymentCategory"
                                                            PropertyName="SelectedValue" />
                                                        <asp:ControlParameter ControlID="HiddenFieldMainId" Name="Main_Id" PropertyName="Value" />
                                                        <asp:SessionParameter Name="emp_id" SessionField="emp_id" />
                                                    </InsertParameters>
                                                    <DeleteParameters>
                                                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                                        <asp:ControlParameter ControlID="HiddenFieldPaymentID" Name="Main_Id" PropertyName="Value" />
                                                    </DeleteParameters>
                                                </asp:SqlDataSource>
                                                <asp:SqlDataSource ID="SqlDataSource_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                    SelectCommand="Pt_View_AssignBed" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="ddlSubDept" Name="SubDept_Id" PropertyName="SelectedValue"
                                                            Type="Int32" />
                                                        <asp:ControlParameter ControlID="DDLDepartment" Name="Dept_Id" PropertyName="SelectedValue"
                                                            Type="Int32" />
                                                        <asp:ControlParameter ControlID="DDL_Ward" Name="ward_Id" PropertyName="SelectedValue"
                                                            Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <asp:HiddenField ID="HiddenFieldWard_Id" runat="server" />
                                                <asp:SqlDataSource ID="SqlDataSourceBedRoomCharges" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                    InsertCommand="Insert_Patient_services" InsertCommandType="StoredProcedure">
                                                    <InsertParameters>
                                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                                        <asp:SessionParameter Name="empid" SessionField="emp_id" Type="Int32" />
                                                        <asp:Parameter DefaultValue="56" Name="S_ID" Type="Int32" />
                                                        <asp:ControlParameter ControlID="HiddenFieldBedRoomCharges" DefaultValue="" Name="Amount"
                                                            PropertyName="Value" Type="Int32" />
                                                        <asp:Parameter DefaultValue="False" Name="Payment_Status" Type="Boolean" />
                                                        <asp:ControlParameter ControlID="HiddenFieldSubDepartment" Name="SubDept_ID" PropertyName="Value"
                                                            Type="Int32" />
                                                        <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                                                    </InsertParameters>
                                                </asp:SqlDataSource>
                                                <asp:HiddenField ID="HiddenFieldBedRoomCharges" runat="server" />
                                                <asp:SqlDataSource ID="SqlDataSource_Refernces" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                    SelectCommand="SELECT  Refferer_ID as EmpID, isnull(Referer_Name,'') as [Employee Name] &#13;&#10;FROM         Doctor_Referneces&#13;&#10;union&#13;&#10;SELECT EmpID, ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, ' ') + ' ' + ISNULL(ELName, ' ') AS [Employee Name] FROM Employee WHERE (Emp_Type = 'Consultant') &#13;&#10;ORDER BY [Employee Name]">
                                                </asp:SqlDataSource>
                                                <asp:SqlDataSource ID="SqlDataSourceUpdatePayment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="Update_Payment_For_Consultant"
                                                    UpdateCommandType="StoredProcedure">
                                                    <UpdateParameters>
                                                        <asp:ControlParameter ControlID="DropDownListConsultant" Name="DoctorID" PropertyName="SelectedValue" />
                                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                                        <asp:SessionParameter Name="PayID" SessionField="YearlyNo" />
                                                        <asp:ControlParameter ControlID="DropDownListReferBy" Name="Refer_By_ID" PropertyName="SelectedValue"
                                                            Type="Int32" />
                                                    </UpdateParameters>
                                                </asp:SqlDataSource>
                                                <asp:SqlDataSource ID="SqlDataSource_Insert" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                                    InsertCommand="Pt_InnerDepartment_PatientForward" InsertCommandType="StoredProcedure"
                                                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE  Payment Set Patient_Type='IPD' where PayID=@PayID">
                                                    <InsertParameters>
                                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                                        <asp:SessionParameter Name="EmpID" SessionField="emp_id" Type="Int32" />
                                                        <asp:SessionParameter Name="PayID" SessionField="PayId" Type="Decimal" />
                                                        <asp:ControlParameter ControlID="HiddenFieldWard_SubDept_ID" Name="ToSubDept" PropertyName="Value"
                                                            Type="Int32" />
                                                        <asp:SessionParameter Name="SendingDept" SessionField="SubDeptID" Type="Int32" />
                                                        <asp:Parameter DefaultValue="6" Name="iRequestTypeTo" Type="Int32" />
                                                        <asp:Parameter DefaultValue="1" Name="iRequestTypeBy" Type="Int32" />
                                                    </InsertParameters>
                                                    <UpdateParameters>
                                                        <asp:SessionParameter Name="PayID" SessionField="PayId" />
                                                    </UpdateParameters>
                                                </asp:SqlDataSource>
                                                &nbsp;<asp:SqlDataSource ID="SqlDataSource_Adv_Payment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                    InsertCommand="Insert_Patient_Advance_IPD" InsertCommandType="StoredProcedure">
                                                    <InsertParameters>
                                                        <asp:SessionParameter Name="RegNo" SessionField="Registrationno" />
                                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                                        <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" />
                                                        <asp:ControlParameter ControlID="TextBox_Payment" Name="Amount" PropertyName="Text" />
                                                        <asp:ControlParameter ControlID="TextBox_Cheque_no" Name="Check_No" PropertyName="Text" />
                                                        <asp:ControlParameter ControlID="TextBox_Bank_Name" Name="Bank_Name" PropertyName="Text" />
                                                        <asp:ControlParameter ControlID="TextBox_Branch_Name" Name="Branch_Name" PropertyName="Text" />
                                                        <asp:ControlParameter ControlID="HiddenFieldMainId" Direction="Output" Name="PaymentNo"
                                                            PropertyName="Value" Type="Int32" />
                                                        <asp:ControlParameter ControlID="DropDownList_Payment_Type" Name="Payment_Type" PropertyName="SelectedValue" />
                                                        <asp:ControlParameter ControlID="DropDownList_Admin_Service_Package" Name="ASP_ID"
                                                            PropertyName="SelectedValue" Type="Int32" />
                                                        <asp:ControlParameter ControlID="TextBox_ChequeDate" Name="Cheque_Date" PropertyName="Text"
                                                            Type="DateTime" />
                                                        <asp:ControlParameter ControlID="TextBox_Cradit_Card_No" Name="Card_No" PropertyName="Text"
                                                            Type="String" />
                                                        <asp:ControlParameter ControlID="DropDownList_Card_Type" Name="Card_Type" PropertyName="SelectedValue"
                                                            Type="String" />
                                                        <asp:ControlParameter ControlID="TextBox_Card_Service" Name="Card_Service" PropertyName="Text"
                                                            Type="String" />
                                                        <asp:ControlParameter ControlID="TextBox_approval_no" Name="Approval_No" PropertyName="Text"
                                                            Type="String" />
                                                        <asp:Parameter Name="Discription" Type="String" DefaultValue="&quot;&quot;" />
                                                    </InsertParameters>
                                                </asp:SqlDataSource>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
                <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT '' AS Dept_Name, 0 AS Dept_ID UNION SELECT DISTINCT Dept_Name, Dept_ID FROM Department WHERE (Hospital_ID = @Hospital_Id)">
                    <SelectParameters>
                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
                                            
                                            <asp:SqlDataSource ID="dsDesignations" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>"
                                                ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
                                                SelectCommand="SELECT Party_Designations.Party_Desg_ID, Party_Designations.Party_Desg_Name, Parties.Party_Name FROM Party_Designations INNER JOIN Parties ON Party_Designations.Party_ID = Parties.Party_Id WHERE (Party_Designations.Party_ID = @Party_id) ORDER BY Party_Designations.Party_Desg_Name">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="DropDownList_Parties" Name="Party_id" PropertyName="SelectedValue"
                                                        Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand=" SELECT DISTINCT SubDepartment.SubDept_Name, SubDepartment.SubDept_Id FROM SubDepartment 
 WHERE SubDepartment.SubDept_Type = 1 
 ORDER BY SubDepartment.SubDept_Name ">
                  
                </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                                                SelectCommand="SELECT     Parties.Party_Id, Parties.Party_Name
FROM         Parties INNER JOIN
                      Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id
WHERE     (Patient_Billing_Party.Patient_Type_Id = @Party_Type_Id)">
<SelectParameters>
                                                <asp:ControlParameter ControlID="RadioButtonList_Patient_Type" Name="Party_Type_Id" 
                                                    PropertyName="SelectedValue" />
                                            </SelectParameters>

                                            </asp:SqlDataSource>
                &nbsp;<asp:SqlDataSource ID="SqlDataSource_Department" 
                    runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                                
                                                                
                    SelectCommand="	SELECT     Dept_ID, Dept_Name
	FROM        Department 
	order by Dept_Name">
                                                            </asp:SqlDataSource>
                                                        &nbsp;<asp:SqlDataSource ID="SqlDataSource_Doctor_Services" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    DeleteCommand="DELETE FROM Doctor_Service WHERE (DS_ID = @DS_ID)" InsertCommand="Insert_Patient_services_and_Payment"
                    InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT Admin_Services.S_Name, Doctor_Service.Charges, Doctor_Service.Doctor_ID, Doctor_Service.DS_ID, Doctor_Service.Bank_Payment AS [Bank Charges], Admin_Services.S_Amount AS [Services Charges], Admin_Services.S_ID FROM Doctor_Service INNER JOIN Admin_Services ON Doctor_Service.Service_ID = Admin_Services.S_ID WHERE (Doctor_Service.Doctor_ID = @Doctor_ID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlEmployeeName" DefaultValue="" Name="Doctor_ID"
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="DS_ID" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="PayId" Type="Decimal" />
                        <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenField_Service_ID" DefaultValue="26626" Name="S_ID"  PropertyName="Value" Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenField_Amount" DefaultValue="25" Name="Amount" PropertyName="Value" Type="Int32" />
                        <asp:Parameter DefaultValue="0" Name="Payment_Status" />
                        <asp:SessionParameter DefaultValue="" Name="SubDept_ID" SessionField="SubDeptID" Type="Int32" />
                        <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlEmployeeName" Name="Doctor_ID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" Type="Int32" />
                        <asp:ControlParameter ControlID="RadioButtonList_Patient_Type" Name="Patient_Type_Id" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenField_OPD_IPD" Name="IPD_OPD" PropertyName="Value" Type="String" />
                        <asp:ControlParameter ControlID="DropDownList_Parties" Name="Billing_Party_Id" PropertyName="SelectedValue" Type="Decimal" DefaultValue="0" />
                        
                        <asp:Parameter Direction="Output" Name="Main_ID_Out" Type="Int32" />
                        <asp:Parameter  Name="Con_S_ID" Type="Int32" DefaultValue="0" />
                        <asp:Parameter  Name="Con_S_Amount" Type="Int32"  DefaultValue="0" />

                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourcePatientType" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT Patient_Type_ID, Patient_Type FROM Patient_type WHERE (Active = 1)">
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Dept" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="Select_Consultant_By_SubDept" 
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="HospitalId" Type="Int32" />
                         <asp:ControlParameter ControlID="ddlSubDept" Name="Dept_type" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                    SelectCommand="SELECT Diagnosis FROM Diagnosis ORDER BY Diagnosis"></asp:SqlDataSource>
                <asp:SqlDataSource ID="dsPatientInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                    SelectCommand="SELECT Patient.RegNo, ISNULL(Patient.Prefix, ' ') AS prefix, ISNULL(Patient.PFName, ' ') AS pfname, ISNULL(Patient.PMName, ' ') AS pmname, ISNULL(Patient.PLName, ' ') AS PLName, UPPER(Patient.Relation) AS Relation, UPPER(ISNULL(Patient.RFName, ' ')) + ' ' + UPPER(ISNULL(Patient.RMName, ' ')) + ' ' + UPPER(ISNULL(Patient.RLName, ' ')) AS RELATIONNAME, CONVERT (varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) / 365) + '  Years  ' + CONVERT (varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) % 365 / 30) + '  M  ' + CONVERT (varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) % 365 % 30) + '  D' AS Age, UPPER(Gender.Gender) AS Gender, CONVERT (varchar, Patient.DateOfBirth, 107) AS DateOfBirth, Patient.CNIC, CONVERT (varchar, Patient.DateOfBirth, 107) AS DateOfBirth, ISNULL(Patient.House_No, '') + ' ' + ISNULL(Patient.StreetAddress, ' ') + ' ' + ISNULL(Patient.Colony, ' ') + ' ' + ISNULL(Tehsil.TehsilName, '') AS Address, Patient.Patient_Type FROM Patient LEFT OUTER JOIN Gender ON Patient.SexID = Gender.Gender_ID LEFT OUTER JOIN Tehsil ON Patient.TehsilCode = Tehsil.TehsilCode WHERE (Patient.RegNo = @RegNo)">
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="registrationno" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_OPD_IPD" runat="server" />
                <asp:HiddenField ID="HiddenField_Service_ID" runat="server" />
                <asp:HiddenField ID="HiddenField_Amount" runat="server" />
                <asp:SqlDataSource ID="SQL_SMP_ID_Update" runat="server"></asp:SqlDataSource>
                <br />
                <asp:GridView ID="GridView_Patient_Visit" runat="server" AutoGenerateColumns="False"
                    Width="100%" DataSourceID="SqlDataSource_PatientVisit" DataKeyNames="PayID">
                    <Columns>
                        <asp:BoundField DataField="PayID" HeaderText="Indoor Visit" ReadOnly="True" SortExpression="PayID" />
                        <asp:TemplateField HeaderText="MR # " SortExpression="RegNo">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("RegNo") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="RegNoLabel" Style="color: #F00;" runat="server" Text='<%# Bind("RegNo") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name" SortExpression="Prefix">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Prefix") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="PrefixLabel" runat="server" Text='<%# Bind("Prefix") %>'></asp:Label><asp:Label
                                    ID="PFNameLabel" runat="server" Text='<%# Eval("PFName") %>' Visible="False"></asp:Label><asp:Label
                                        ID="PMNameLabel" runat="server" Text='<%# Eval("PMName") %>' Visible="False"></asp:Label><asp:Label
                                            ID="PLNameLabel" runat="server" Text='<%# Eval("PLName") %>' Visible="False"></asp:Label>&nbsp;<asp:Label
                                                ID="RelationLabel" runat="server" Text='<%# Eval("Relation") %>'></asp:Label>&nbsp;<asp:Label
                                                    ID="PR_NameLabel" runat="server" Text='<%# Eval("PR_Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="PatientTypeLabel" runat="server" Text='<%# Eval("PatientType") %>'
                                    Visible="False"></asp:Label><asp:Label ID="Label_Ref_Letter" runat="server" Font-Bold="False"
                                        Visible="False">Reference Letter</asp:Label><asp:Label ID="Label_Reference_Letter"
                                            runat="server" Text='<%# Eval("Reference_Letter") %>'></asp:Label>
                                <asp:Label ID="Label_Patient_Type" runat="server" Text='<%# Eval("Patient_Type") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="DteTime" HeaderText="Date" SortExpression="DteTime" />
                        <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="print_btn" CommandName="Select"
                                    Text="Print Report"></asp:LinkButton>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('Are you sure? Record will be delted permanently!')"
                                    Text="Delete" Visible="False"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <br />
                <asp:SqlDataSource ID="SqlDataSource_PatientVisit" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                    DeleteCommand="DELETE FROM Payment WHERE (PayID = @PayID) " ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>"
                    
                    SelectCommand="SELECT     Payment.PayID, Payment.RegNo, Payment.PatientType, CONVERT(varchar, Payment.DateTime, 100) AS DteTime, Patient.Prefix, Patient.PFName, Patient.PMName, &#13;&#10;                      Patient.PLName, Patient.Relation, ISNULL(Patient.RFName, '') + ' ' + ISNULL(Patient.RMName, '') + ' ' + ISNULL(Patient.RLName, '') AS PR_Name, CONVERT(varchar, &#13;&#10;                      Patient.Age) + ' ' + Patient.AgeType AS Age,&#13;&#10; Gender.Gender, isnull(Payment.Reference_Letter,'') AS Reference_Letter, Payment.Patient_Type&#13;&#10;FROM         Payment INNER JOIN&#13;&#10;                      Patient ON Payment.RegNo = Patient.RegNo INNER JOIN&#13;&#10;                      Gender ON Patient.SexID = Gender.Gender_ID &#13;&#10;WHERE (Payment.RegNo = @RegNo) and CONVERT(varchar, Payment.DateTime, 103) = CONVERT(varchar, getdate(), 103)&#13;&#10;order by Payment.PayID desc" 
                    UpdateCommand="Update payment set dischargestatus ='true' where (PayId=@YearlyNo)">
                    <SelectParameters>
                        <asp:Parameter Name="RegNo" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="DataList_Patient_Visit" Name="PayID" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="YearlyNo" PropertyName="Value" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="grdPatientVisit" runat="server" AutoGenerateColumns="False" Width="100%"
                    DataKeyNames="PayID,RegNo" DataSourceID="dsPatientVisit" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="ReferFrom" HeaderText="Refer From" SortExpression="ReferFrom" />
                        <asp:BoundField DataField="PatientType" HeaderText="Patient Type" SortExpression="PatientType" />
                        <asp:BoundField DataField="Diagonosis" HeaderText="Diagonosis" SortExpression="Diagonosis" />
                        <asp:BoundField DataField="DateTime" HeaderText="DateTime" SortExpression="DateTime" />
                        <asp:BoundField DataField="ShiftName" HeaderText="Shift" SortExpression="ShiftName" />
                        <asp:CheckBoxField DataField="DischargeStatus" HeaderText="DischargeStatus" SortExpression="DischargeStatus" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('Are you sure? Record will be delted permanently!')"
                                    Text="Delete"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <PagerStyle CssClass="GridPager" />
                </asp:GridView>
                <asp:SqlDataSource ID="dsPatientVisit" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                    DeleteCommand="DELETE FROM Payment WHERE (PayID = @PayID) AND (RegNo = @RegNo)"
                    SelectCommand="SELECT Payment.DateTime, Payment.Payment, Payment.ReferFrom, Payment.EmpID, Payment.PatientType, Payment.Diagonosis, Payment.DischargeStatus, Payment.Payment_Status, Payment.Status, Shift.ShiftName, Payment.PayID, Payment.RegNo FROM Payment INNER JOIN Shift ON Payment.Shift = Shift.ShiftId WHERE (Payment.RegNo = @RegNo)">
                    <SelectParameters>
                        <asp:Parameter Name="RegNo" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="grdPatientVisit" Name="PayID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="grdPatientVisit" Name="RegNo" PropertyName="SelectedValue" />
                    </DeleteParameters>
                </asp:SqlDataSource>
                <br />
                <asp:SqlDataSource ID="dsPatient_Duplicate_Print" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" UpdateCommand="UPDATE    Payment
SET              SMP_ID = @SMP_ID
WHERE     (PayID = @PayID)">
                    <UpdateParameters>
                        <asp:Parameter Name="SMP_ID" DefaultValue="0" />
                        <asp:SessionParameter Name="PayID" SessionField="PayID" DefaultValue="" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HF_Flag" runat="server" />
                &nbsp;
            </td>
        </tr>
    </table>

    <script type="text/javascript">
<!--
var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", {contentIsOpen:true});
function FIELDSET1_onclick() {

}

//-->
    </script>

</asp:Content>
