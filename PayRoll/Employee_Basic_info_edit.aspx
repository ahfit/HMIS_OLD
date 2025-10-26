<%@ page language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Employee_Basic_info_edit, App_Web_xk2k0ijz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .btn1
        {
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain">
        <h2>
            <span>General Information</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td width="29%" align="right" class="style1">
                    Title :&nbsp;
                </td>
                <td width="54%" class="style1">
                    <asp:RadioButtonList CssClass="radlist" ID="prefix" RepeatDirection="Horizontal"
                        runat="server">
                        <asp:ListItem Selected="True">Mr.</asp:ListItem>
                        <asp:ListItem>Miss</asp:ListItem>
                        <asp:ListItem>Mrs.</asp:ListItem>
                        <asp:ListItem>Dr.</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td width="17%" rowspan="12" align="center" valign="top">
                    &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" Height="139px" Width="140px"
                        Style="margin-right: 10px;" ImageUrl="~/images/PictureFrame.png" />
                </td>
            </tr>
            <tr style="display: none">
                <td align="right">
                    Employee No :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="TextBox_EmpNumber" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
                    <span style="color: #ff0000">*<asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                        runat="server" ControlToValidate="TextBox_EmpNumber" ErrorMessage="*">*</asp:RequiredFieldValidator></span>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Employee Machine Code (If Any)
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Emp_No" runat="server" Width="150px" CssClass="input_txt"></asp:TextBox>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="right">
                    First Name :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="txtEFName" runat="server" Width="150px" CssClass="input_txt"></asp:TextBox>
                    <span style="color: #ff0000">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEFName"
                        ErrorMessage="*">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Middle Name :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="txtEMName" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Last Name :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="TxtELName" runat="server" Width="150px" CssClass="input_txt"></asp:TextBox>
                    <span style="color: #ff0000">* </span>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Attach Picture :&nbsp;
                </td>
                <td>
                    <asp:FileUpload ID="FileUpload_image" runat="server" Width="200px" />
                    <asp:Button ID="Button_attach_pic" runat="server" CausesValidation="False" Text="Attach"
                        CssClass="btn1" />
                    <asp:HiddenField ID="HiddenField_NewPic" runat="server" Value="0" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    Gender :&nbsp;
                </td>
                <td>
                    <asp:DropDownList CssClass="dropbox" DataSourceID="SqlDataSourceGender" DataTextField="Gender"
                        DataValueField="Gender_ID" ID="Dropdownlistsex" runat="server" Width="152px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td width="19%" align="right">
                </td>
                <td>
                    <asp:RadioButtonList CssClass="radlist" ID="RadioButtonList1" RepeatDirection="Horizontal"
                        runat="server">
                        <asp:ListItem Selected="True">S/O</asp:ListItem>
                        <asp:ListItem>D/O</asp:ListItem>
                        <asp:ListItem>W/O</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Relation First Name :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="TextBoxRFName" CssClass="input_txt" Width="150px" runat="server"></asp:TextBox>
                    <span style="color: #ff0000">* </span>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Relation Middle Name :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="TextBoxRMName" CssClass="input_txt" runat="server" Width="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Relation Last Name :&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="TextBoxRLName" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
                    <span style="color: #ff0000">* </span>
                </td>
            </tr>
            <tr>
                <td align="right" style="height: 26px">
                    Employee Type :&nbsp;
                </td>
                <td style="height: 26px">
                    <asp:DropDownList ID="DropDownList_Type" runat="server" DataSourceID="SqlDataSource_emp_Type"
                        DataTextField="Type" DataValueField="Employee_Type_ID" Width="154px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" >
<ContentTemplate>--%>
    <br />
    <div class="bxmain">
        <h2>
            <span>Basic Information</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td width="50%">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="38%" align="right" style="height: 26px">
                                Date Of Birth :
                            </td>
                            <td width="62%" style="height: 26px">
                                <asp:TextBox ID="TextBox_DOB_day" runat="server" CssClass="input_txt" Width="35px"
                                    MaxLength="2" ValidationGroup="DOB"></asp:TextBox>
                                -
                                <asp:TextBox ID="TextBox_DOB_Month" runat="server" CssClass="input_txt" Width="25px"
                                    MaxLength="2" ValidationGroup="DOB"></asp:TextBox>
                                -
                                <asp:TextBox ID="TextBox_DOB_Year" runat="server" CssClass="input_txt" Width="66px"
                                    MaxLength="4" ValidationGroup="DOB"></asp:TextBox>
                                <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="Enter DOB" Visible="False"></asp:Label>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Marital Status :
                            </td>
                            <td>
                                <asp:RadioButtonList CssClass="radlist" ID="RadioButtonList_marital_status" RepeatDirection="Horizontal"
                                    runat="server" TabIndex="9">
                                    <asp:ListItem>Single</asp:ListItem>
                                    <asp:ListItem>Married</asp:ListItem>
                                    <%-- <asp:ListItem>Widow</asp:ListItem>
          <asp:ListItem>Divorced</asp:ListItem>--%>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Nationality :
                            </td>
                            <td>
                                <asp:DropDownList DataSourceID="SqlDataSource_Nationality" DataTextField="Nationality_Name"
                                    DataValueField="Nationality_ID" ID="DropDownList_nationality" runat="server"
                                    CssClass="dropbox" Width="152px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Language Known :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_language" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td width="38%" align="right">
                                CNIC No. :
                            </td>
                            <td style="width: 179px">
                                <igtxt:WebMaskEdit ID="TextBox_CNIC" runat="server" InputMask="#####-#######-#">
                                </igtxt:WebMaskEdit>
                                <span style="color: #ff0000">* </span>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="50%" valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td align="right">
                                Place of birth :
                            </td>
                            <td>
                                <asp:DropDownList Width="152px" AutoPostBack="True" DataSourceID="SqlDataSource_place_of_birth"
                                    DataTextField="DistrictName" CssClass="dropbox" DataValueField="DistrictCode"
                                    ID="DropDownList_place_of_birth" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Religion :
                            </td>
                            <td>
                                <asp:DropDownList DataSourceID="SqlDataSource_religion" DataTextField="Religion_name"
                                    DataValueField="Religion_ID" ID="DropDownList_religion" CssClass="dropbox" runat="server"
                                    Width="152px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Passport No :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_Passport_no" CssClass="input_txt" Width="150px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Domicile :
                            </td>
                            <td>
                                <asp:DropDownList DataSourceID="SqlDataSource_place_of_birth" DataTextField="DistrictName"
                                    DataValueField="DistrictCode" ID="DropDownList_Domicile" runat="server" CssClass="dropbox"
                                    Width="152px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div class="bxmain">
        <h2>
            <span>Address Information</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td width="50%" valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <%--<tr>
        <td width="38%" align="right">CNIC No. : </td>
        <td style="width: 179px"><igtxt:webmaskedit id="TextBox_CNIC" runat="server" inputmask="#####-#######-#"></igtxt:webmaskedit>
          <span style="color: #ff0000">* </span></td>
      </tr>--%>
                        <tr>
                            <td align="right">
                                District Name :
                            </td>
                            <td style="width: 179px">
                                <asp:DropDownList ID="DropDownList_dist_ID" runat="server" DataSourceID="SqlDataSource_dest_ID"
                                    DataTextField="DistrictName" DataValueField="DistrictCode" CssClass="dropbox"
                                    Width="152px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Home Phone :
                            </td>
                            <td style="width: 179px">
                                <asp:TextBox ID="txthp1" runat="server" Width="35px" CssClass="input_txt">0092</asp:TextBox>
                                -
                                <asp:TextBox ID="txthp2" runat="server" Width="25px" CssClass="input_txt">21</asp:TextBox>
                                -
                                <asp:TextBox ID="txthp3" runat="server" CssClass="input_txt" Width="66px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Mobile No :
                            </td>
                            <td style="width: 179px">
                                <asp:TextBox ID="TextBox_mobile_No" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Office Phone :
                            </td>
                            <td style="width: 179px">
                                <asp:TextBox ID="txtop1" runat="server" Width="35px" CssClass="input_txt">0092</asp:TextBox>
                                -
                                <asp:TextBox ID="txtop2" runat="server" CssClass="input_txt" Width="25px">21</asp:TextBox>
                                -
                                <asp:TextBox ID="txtop3" runat="server" CssClass="input_txt" Width="66px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Email Address :
                            </td>
                            <td style="width: 179px">
                                <asp:TextBox ID="TextBox_email" runat="server" Width="150px" CssClass="input_txt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <%--Join Date : --%>
                            </td>
                            <td style="width: 179px">
                                <asp:TextBox ID="txtday" runat="server" CssClass="input_txt" Width="35px" MaxLength="2"
                                    Visible="false"></asp:TextBox>
                                -
                                <asp:TextBox ID="txtmonth" runat="server" CssClass="input_txt" Width="25px" MaxLength="2"
                                    Visible="false"></asp:TextBox>
                                -
                                <asp:TextBox ID="txtyear" runat="server" Width="66px" CssClass="input_txt" MaxLength="4"
                                    Visible="false"></asp:TextBox>
                                <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="Enter Join Date" Visible="False"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="50%" valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="38%" align="right">
                                Pay Scale(I-IX) :
                            </td>
                            <td width="62%">
                                <asp:DropDownList ID="Dropdownlistpayscale" runat="server">
                                    <asp:ListItem>I</asp:ListItem>
                                    <asp:ListItem>II</asp:ListItem>
                                    <asp:ListItem>III</asp:ListItem>
                                    <asp:ListItem>IV</asp:ListItem>
                                    <asp:ListItem>V</asp:ListItem>
                                    <asp:ListItem>VI</asp:ListItem>
                                    <asp:ListItem>VII</asp:ListItem>
                                    <asp:ListItem>VIII</asp:ListItem>
                                    <asp:ListItem>IX</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td width="38%" align="right">
                                <%--Grade(1-21):--%>
                            </td>
                            <td width="62%">
                                <asp:DropDownList ID="Dropdownlistpayscale0" runat="server" Visible="false">
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                    <asp:ListItem>6</asp:ListItem>
                                    <asp:ListItem>7</asp:ListItem>
                                    <asp:ListItem>8</asp:ListItem>
                                    <asp:ListItem>9</asp:ListItem>
                                    <asp:ListItem>10</asp:ListItem>
                                    <asp:ListItem>11</asp:ListItem>
                                    <asp:ListItem>12</asp:ListItem>
                                    <asp:ListItem>13</asp:ListItem>
                                    <asp:ListItem>14</asp:ListItem>
                                    <asp:ListItem>15</asp:ListItem>
                                    <asp:ListItem>16</asp:ListItem>
                                    <asp:ListItem>17</asp:ListItem>
                                    <asp:ListItem>18</asp:ListItem>
                                    <asp:ListItem>19</asp:ListItem>
                                    <asp:ListItem>20</asp:ListItem>
                                    <asp:ListItem>21</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Tehsil Name :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_teh_ID" runat="server" DataSourceID="SqlDataSource_tehsil_ID"
                                    DataTextField="TehsilName" DataValueField="TehsilCode" Width="152px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Permanent Address :
                            </td>
                            <td>
                                <asp:TextBox ID="homeadd" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
                                <span style="color: #ff0000">*</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Present Address :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_present_address" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Office Address :
                            </td>
                            <td>
                                <asp:TextBox ID="officeadd" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Service Start Date :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_service_satart_Date_day" runat="server" CssClass="input_txt"
                                    Width="35px" MaxLength="2"></asp:TextBox>
                                -
                                <asp:TextBox ID="TextBox_Service_Start_Date_month" runat="server" CssClass="input_txt"
                                    Width="25px" MaxLength="2"></asp:TextBox>
                                -
                                <asp:TextBox ID="TextBox_service_Start_Date_Year" runat="server" CssClass="input_txt"
                                    Width="66px" MaxLength="4"></asp:TextBox>
                                <asp:Label ID="Label6" runat="server" ForeColor="Red" Text="Enter Service Start Date"
                                    Visible="False"></asp:Label>&nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <asp:Label ID="Label4" runat="server"></asp:Label>
        <%--</ContentTemplate>
</asp:UpdatePanel>--%>
        <asp:SqlDataSource ID="SqlDataSource_place_of_birth" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT DistrictCode, DistrictName FROM DISTRICT ORDER BY DistrictName">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_religion" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [Religion_ID], [Religion_name] FROM [Religion]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Nationality" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [Nationality_ID], [Nationality_Name] FROM [Nationality]">
        </asp:SqlDataSource>
        <br />
        <div class="bxmain" style="width: 100%;">
            <h2>
                <span>Employment Information</span></h2>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td width="50%" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="38%" align="right">
                                    Designation :
                                </td>
                                <td width="62%">
                                    <asp:DropDownList CssClass="dropbox" Width="152px" DataTextField="Designation_Name"
                                        DataValueField="Designation_ID" ID="DropDownListdesignation" runat="server" DataSourceID="SqlDataSourceDesignation"
                                        TabIndex="4" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Administrator/Basic Data Management/designation.aspx?PName=Employee Designations&amp;MName=Human Resource"
                                        Target="_self">Add Designation</asp:HyperLink>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="height: 14px">
                                    Designation Detail :
                                </td>
                                <td style="height: 14px">
                                    <asp:TextBox ID="TextBox_Designation_Detail" runat="server" CssClass="input_txt"
                                        Height="34px" TextMode="MultiLine" Width="150px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    D.O.J:
                                </td>
                                <td>
                                    <igsch:WebDateChooser ID="WebDateChooser_LastPromotionDate" runat="server" Width="152px">
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                    <asp:HiddenField ID="HiddenField_MainDesigId" runat="server" />
                                    <asp:HiddenField ID="HiddenField_LastPromotionDate" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    NTN #:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNTNNo" runat="Server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <%--Profession:--%>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlProfession" DataSourceID="SqlDataSourceProfession" DataTextField="Profession_Name"
                                        DataValueField="Profession_Code" AppendDataBoundItems="true" runat="Server" Visible="false">
                                        <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    GP Fund No :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtGPFund" runat="server" CssClass="input_txt" Width="90%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Provident Fund No :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtProvFundNo" runat="server" CssClass="input_txt" Width="90%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    EOBI No :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEOBINo" runat="server" CssClass="input_txt" Width="90%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="height: 20px">
                                </td>
                                <td style="height: 20px">
                                    &nbsp;<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Administrator/Basic%20Data%20Management/SubDept.aspx"
                                        Target="_blank" Visible="False">Add Department</asp:HyperLink>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="50%" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="38%" align="right">
                                    Department: :
                                </td>
                                <td width="62%">
                                    <asp:DropDownList CssClass="dropbox" DataTextField="Dept_Name" Width="200px" DataValueField="Dept_ID"
                                        ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                                        AutoPostBack="True" TabIndex="5">
                                    </asp:DropDownList>
                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Administrator/Basic%20Data%20Management/department.aspx?PName=Departments/Divisions&amp;MName=Human Resource"
                                        Target="_self">Add Department</asp:HyperLink>
                                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                        SelectCommand="SELECT  Department.Dept_Name + ' ( ' + Hospital.Hospital_Abb + ' ) ' Dept_Name, Department.Dept_ID FROM Department Left Outer JOIN Hospital ON Department.Hospital_ID = Hospital.Hospital_ID ORDER BY [Dept_Name]"
                                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Sub Department::
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownListSubDepartment" runat="server" CssClass="dropbox"
                                        DataSourceID="SqlDataSource_Division" DataTextField="SubDept_Name" DataValueField="SubDept_Id"
                                        Width="200px" TabIndex="6" AutoPostBack="True">
                                    </asp:DropDownList>         
                                    <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/Administrator/Basic%20Data%20Management/SubDept.aspx?PName=Section/Subdepartment&amp;MName=Human Resource"
                                        Target="_self">Add Subdepartment</asp:HyperLink>
                                    <asp:SqlDataSource ID="SqlDataSource_Division" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                        SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Dept_Id)"
                                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_Id" PropertyName="SelectedValue"
                                                DefaultValue="0" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Salary Mode :</td>
                                <td>
                        <asp:DropDownList ID="DropDownList_SalaryType" runat="server">
                            <asp:ListItem>Cash</asp:ListItem>
                            <asp:ListItem>Bank Transfer</asp:ListItem>
                            <asp:ListItem>Cheuqe</asp:ListItem>
                        </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <asp:CheckBox ID="checkBoxIsConsultant" runat="server" Text="Is Consultant" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                </td>
                                <td>
                                    <asp:Button ID="ButtonUpdate" runat="server" Text="Update" CssClass="btn1" Width="72px" />
                                </td>
                            </tr>
                        </table>
                        <asp:DropDownList CssClass="dropbox" DataTextField="Section_Name" Width="152px" DataValueField="Section_ID"
                            ID="DropDownList_section" runat="server" DataSourceID="SqlDataSource_section"
                            AutoPostBack="True" TabIndex="5" Visible="False">
                        </asp:DropDownList>
                        <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/Administrator/Basic%20Data%20Management/Section.aspx"
                            Target="_blank" Visible="False">Add Section</asp:HyperLink>
                    </td>
                </tr>
            </table>
            <div align="center">
                <asp:Button ID="Button1" runat="server" Text="Education" />&nbsp;
                <asp:Button ID="Button2" runat="server" Text="Certification" />
                <asp:Button ID="Button_skills" runat="server" Text="Skills" />&nbsp;<asp:Button ID="Button3"
                    runat="server" Text="Additional Info" />
                <asp:Button ID="Button4" runat="server" Text="ADD Relationship" />
                <asp:Button ID="Button_add_Documents" runat="server" Text="ADD Documents" />
                <asp:Button ID="btnAddExperience" runat="server" Text="ADD Experience" />
            </div>
            <br />
            <br />
        </div>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" CssClass="err"></asp:Label>
        <asp:Label ID="Label3" runat="server" CssClass="err"></asp:Label><br />
        <asp:RequiredFieldValidator ControlToValidate="homeadd" CssClass="err" Display="Dynamic"
            ErrorMessage="Please Enter Home Address" ID="RequiredFieldValidatorHomeAdd" runat="server"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ControlToValidate="txtEFName" CssClass="err" Display="Dynamic"
            ErrorMessage="Please Enter First Name" ID="RequiredFieldValidatorPFName" runat="server"></asp:RequiredFieldValidator><asp:SqlDataSource
                ID="SqlDataSourceDesignation" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT Designation_Name, Designation_ID FROM Designation ORDER BY Min_PayScale DESC">
            </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT Gender_ID, Gender FROM Gender" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            InsertCommand="HR_Insert_Employee_Info" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:FormParameter FormField="prefix" Name="Prefix" />
                <asp:FormParameter DefaultValue="" FormField="TxtEFName" Name="EFName" />
                <asp:FormParameter DefaultValue="" FormField="TxtEMName" Name="EMName" />
                <asp:FormParameter FormField="TxtELName" Name="ELName" />
                <asp:SessionParameter Name="JoinDate" SessionField="EJDate" />
                <asp:ControlParameter ControlID="HiddenFieldCNIC" Name="CNIC" PropertyName="Value" />
                <asp:FormParameter FormField="DropdownlistDesignation" Name="DesignationID" />
                <asp:FormParameter FormField="dropdownlistpayscale" Name="PayScale" />
                <asp:ControlParameter ControlID="HiddenFieldHomePhone" Name="HPhoneNo" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenFieldOfficePhone" Name="OphoneNo" PropertyName="Value" />
                <asp:FormParameter FormField="officeadd" Name="OfficeAdd" />
                <asp:FormParameter FormField="homeadd" Name="HomeAdd" />
                <asp:FormParameter FormField="DropdownlistSex" Name="SexID" />
                <asp:FormParameter FormField="DropdownlistDepartment" Name="DeptID" />
                <asp:FormParameter FormField="Dropdownlistsubdepartment" Name="SubDeptId" />
                <asp:Parameter Direction="Output" Name="EmpID" Type="Int32" />
                <asp:ControlParameter ControlID="TextBoxRFName" Name="RFName" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBoxRMName" Name="RMName" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBoxRLName" Name="RLName" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_DOB" Name="DateOfBirth" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenFieldStartDate" Name="ServiceStartDate" PropertyName="Value"
                    Type="DateTime" />
                <asp:SessionParameter Name="Entry_Employee_ID" SessionField="emp_ID" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_email" Name="email_address" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_present_address" Name="Present_address"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox_mobile_No" Name="Mobile_Number" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList_place_of_birth" Name="Place_of_birth"
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="RadioButtonList_marital_status" Name="Marital_Status"
                    PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="DropDownList_religion" Name="Religion" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_nationality" Name="Nationality" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_Passport_no" Name="Passport_No" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList_Domicile" Name="Domicile" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_language" Name="Language_Known" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList_dist_ID" Name="dist_ID" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_teh_ID" Name="tech_ID" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_section" Name="Section_ID" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_Type" Name="Employee_Type_ID" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_Designation_Detail" Name="Designation_Detail"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox_Emp_No" Name="Emp_No" PropertyName="Text"
                    Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenFieldCNIC" runat="server" />
        <asp:HiddenField ID="HiddenFieldHomePhone" runat="server" />
        <asp:HiddenField ID="HiddenFieldOfficePhone" runat="server" />
        &nbsp;
        <asp:SqlDataSource ID="SqlDataSourceProfession" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT Profession_Name, Profession_Code FROM Admin_Employee_Profession">
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_age" runat="server" />
        <asp:HiddenField ID="HiddenField_DOB" runat="server" />
        <asp:HiddenField ID="HiddenFieldEmp_id" runat="server" Value="0" />
        <asp:HiddenField ID="HiddenFieldDateofBirth" runat="server" />
        <asp:HiddenField ID="HiddenFieldStartDate" runat="server" />
        <asp:HiddenField ID="HiddenField_Employee_ID" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource_dest_ID" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [DistrictCode], [DistrictName] FROM [DISTRICT] ORDER BY [DistrictName]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_tehsil_ID" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT [TehsilCode], [TehsilName] FROM [TEHSIL] WHERE ([districtCode] = @districtCode)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_dist_ID" Name="districtCode" PropertyName="SelectedValue"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_emp_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT [Employee_Type_ID], [Type] FROM [Employee_Type]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" CancelSelectOnNullParameter="False"
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            
            UpdateCommand="UPDATE Employee SET Prefix = @Prefix, EFName = @EFName, EMName = @EMName, ELName = @ELName, JoinDate = @JoinDate, CNIC = @CNIC, DesignationID = @DesignationID, PayScale = @PayScale, HPhoneNo = @HPhoneNo, OphoneNo = @OphoneNo, OfficeAdd = @OfficeAdd, HomeAdd = @HomeAdd, SexID = @SexID, DeptID = @DeptID, SubDeptId = @SubDeptId, RFName = @RFName, RMName = @RMName, RLName = @RLName, DateOfBirth = @DateOfBirth, ServiceStartDate = @ServiceStartDate, Entry_Employee_ID = @Entry_Employee_ID, email_address = @email_address, Present_address = @Present_address, Mobile_Number = @Mobile_Number, Place_of_birth = @Place_of_birth, Marital_Status = @Marital_Status, Religion = @Religion, Nationality = @Nationality, Passport_No = @Passport_No, Domicile = @Domicile, Language_Known = @Language_Known, dist_ID = @dist_ID, tech_ID = @tech_ID, Section_ID = @Section_ID, Designation_Detail = @Designation_Detail, Emp_No = @Emp_No, Emp_Offical_Number = @Emp_Offical_Number, Promoted_Designation_Main_Id = @Promoted_Designation_Main_Id, Employee_Scale = @Employee_Scale, Profession_Code = @Profession_Code, NTN = @NTN, GP_Fund_No = @GP_Fund_No, Prov_Fund_No = @Prov_Fund_No, EOBI_No = @EOBI_No, Relation = @Relation, Is_Consultant = @Is_Consultant, SalaryType = @SalaryType, Employee_Type_ID = @Employee_Type_ID WHERE (EmpID = @EmpID)">
            <UpdateParameters>
                <asp:ControlParameter ControlID="prefix" Name="Prefix" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtEFName" Name="EFName" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtEMName" Name="EMName" PropertyName="Text" />
                <asp:ControlParameter ControlID="TxtELName" Name="ELName" PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenFieldStartDate" Name="JoinDate" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenFieldCNIC" Name="CNIC" PropertyName="Value" />
                <asp:ControlParameter ControlID="DropDownListdesignation" Name="DesignationID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="Dropdownlistpayscale" Name="PayScale" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HiddenFieldHomePhone" Name="HPhoneNo" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenFieldOfficePhone" Name="OphoneNo" PropertyName="Value" />
                <asp:ControlParameter ControlID="officeadd" Name="OfficeAdd" PropertyName="Text" />
                <asp:ControlParameter ControlID="homeadd" Name="HomeAdd" PropertyName="Text" />
                <asp:ControlParameter ControlID="Dropdownlistsex" Name="SexID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBoxRFName" Name="RFName" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBoxRMName" Name="RMName" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBoxRLName" Name="RLName" PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenFieldDateofBirth" Name="DateOfBirth" PropertyName="Value" />
                <asp:SessionParameter Name="ServiceStartDate" SessionField="EJDate" />
                <asp:SessionParameter Name="Entry_Employee_ID" SessionField="emp_ID" />
                <asp:ControlParameter ControlID="TextBox_email" Name="email_address" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_present_address" Name="Present_address"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_mobile_No" Name="Mobile_Number" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_place_of_birth" Name="Place_of_birth"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="RadioButtonList_marital_status" Name="Marital_Status"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_religion" Name="Religion" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_nationality" Name="Nationality" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_Passport_no" Name="Passport_No" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_Domicile" Name="Domicile" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_language" Name="Language_Known" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_dist_ID" Name="dist_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_teh_ID" Name="tech_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_section" Name="Section_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_Designation_Detail" Name="Designation_Detail"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_Emp_No" Name="Emp_No" PropertyName="Text" />
                <asp:QueryStringParameter Name="EmpID" QueryStringField="emp_ID" />
                <asp:ControlParameter ControlID="TextBox_EmpNumber" Name="Emp_Offical_Number" PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenField_MainDesigId" Name="Promoted_Designation_Main_Id"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="Dropdownlistpayscale0" Name="Employee_Scale" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlProfession" Name="Profession_Code" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtNTNNo" Name="NTN" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtGPFund" Name="GP_Fund_No" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtProvFundNo" Name="Prov_Fund_No" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtEOBINo" Name="EOBI_No" PropertyName="Text" />
                <asp:ControlParameter ControlID="RadioButtonList1" Name="Relation" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="checkBoxIsConsultant" Name="Is_Consultant" 
                    PropertyName="Checked" />
                     <asp:ControlParameter ControlID="DropDownList_SalaryType" Name="SalaryType" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_Type" Name="Employee_Type_ID" 
                    PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
        &nbsp; &nbsp;
        <br />
        <asp:SqlDataSource ID="SqlDataSource_section" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT [Section_ID], [Section_Name], [Division_ID] FROM [Section] WHERE ([Division_ID] = @Division_ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="Division_ID" PropertyName="SelectedValue"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:RegularExpressionValidator ControlToValidate="txthp3" CssClass="err" Display="Dynamic"
            ErrorMessage="Enter Valid Home Phone No." ID="RegularExpressionValidatorHPhoneNO"
            runat="server" ValidationExpression="\d{7}"></asp:RegularExpressionValidator>
        <asp:RegularExpressionValidator ControlToValidate="txtop3" CssClass="err" ErrorMessage="Enter Valid Phone No."
            ID="RegularExpressionValidatorHphone" runat="server" ValidationExpression="\d{7}"></asp:RegularExpressionValidator>
        <asp:RangeValidator ControlToValidate="txtday" CssClass="err" Display="Dynamic" ErrorMessage="Enter Valid Day"
            ID="RangeValidatorDay" MaximumValue="31" MinimumValue="01" runat="server" Type="Integer"></asp:RangeValidator>
        <asp:RangeValidator ControlToValidate="txtmonth" CssClass="err" Display="Dynamic"
            ErrorMessage="Enter Valid Month" ID="RangeValidatorMonth" MaximumValue="12" MinimumValue="01"
            runat="server" Type="Integer"></asp:RangeValidator>
    </div>
</asp:Content>
