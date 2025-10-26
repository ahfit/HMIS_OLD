<%@ page language="VB" autoeventwireup="false" inherits="EMOPatientInfo, App_Web_ppbttiod" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />

</head>

<body onload="MM_preloadImages('images1/img_btn_over.gif')" dir="ltr">
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" alt="" width="1003" height="24" /></td>
  </tr>
  
  
  <tr>
    <td width="23" height="478" valign="top" class="left_border"><img src="images1/img_border_left.gif" alt="" width="23" height="15" /></td>
    <td width="957" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <!--DWLayoutTable-->
        <tr>
          <td height="73" colspan="2" valign="bottom" bgcolor="#F4F4F4" ><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="215" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
        </tr>
        
        
        <tr>
          <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="938" valign="middle" class="text_lables3" ><span style="font-size: 15pt; font-family: Arial">Patient Profile </span></td>
          </tr>
        <tr><div id ="a1" runat ="server">
          <td>&nbsp;</td>
        <tr>
          <td height="277" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <!--DWLayoutTable-->
            <tr>
              <td rowspan="10" valign="top" style="width: 20px"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="19" colspan="2" valign="top" style="height: 10px; text-align: center;"><img src="images1/img_spacer2.gif" width="2" height="10" />
                      <asp:Label ID="Label_message" runat="server" ></asp:Label></td>
                  <td width="20" rowspan="10" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="4">&nbsp;</td>
              </tr>
            <tr>
              <td height="134" colspan="2" valign="top" style="width: 446px"><span style="height: 22px"><img src="images/image_heading1.gif" width="153" height="22" /></span>
                <table width="910"  border="0" cellpadding="0" cellspacing="0" class="myborder" style="height: 91px">
                  <!--DWLayoutTable-->
                  <tr>
                    <td align="right" valign="middle" class="myborder2" ><span >Name :&nbsp;</span></td>
                    <td width="348" valign="middle" class="myborder3" >&nbsp;
                        <asp:Label CssClass="text_nameheading" ID="labelPName" runat="server" ></asp:Label>
                      &nbsp;
                        <asp:Label CssClass="text_titles_bold"   ID="LabelRelation" runat="server" ></asp:Label>
                        <asp:Label CssClass="text_titles_bold"   ID="LabelRName" runat="server" ></asp:Label></td>
                  </tr>
                  <tr>
                    <td align="right" valign="middle" class="myborder2" ><span >RegistrationNo :&nbsp;</span></td>
                    <td width="348" valign="middle" class="myborder3" >&nbsp;
                        <asp:Label CssClass="text_titles_bold" ID="labelRegistrationNo" runat="server" Width="350px"></asp:Label>                    </td>
                  </tr>
                  <tr>
                    <td align="right" valign="middle" class="myborder2"><span >&nbsp; &nbsp; &nbsp;&nbsp; Age :&nbsp;</span></td>
                    <td valign="middle" class="myborder3" style="height: 21px" >&nbsp;<asp:Label    ID="LabelPAge" runat="server"></asp:Label><asp:Label ID="LabelAge" runat="server" ></asp:Label>
                          <asp:Label    ID="LabelPType" runat="server" Visible="False"></asp:Label></td>
                  </tr>
                  <tr>
                    <td align="right" valign="middle" class="myborder2" style="height: 24px; width: 82px;"></td>
                    <td valign="top" class="myborder3" style="height: 24px"></td>
                  </tr>
                </table></td>
                <td>&nbsp;</td>
              </tr>
            <tr>
              <td height="19" colspan="2" align="right" valign="top"><span style="height: 19px; text-align: right">
                <asp:LinkButton ID="LinkButtonDeathCertificate" runat="server" CssClass="login_link" Visible="False">Death Certificate</asp:LinkButton>
              </span></td>
              <td></td>
            </tr>
            <tr>
              <td height="14" style="width: 446px"></td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td height="527" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td height="22" valign="bottom" style="width: 900px"><img src="images/diag_tab.gif" width="153" height="20" /><img src="images/line_tab.gif" width="720" height="1" /></td>
                </tr>
                <tr>
                  <td height="22" valign="top" style="width: 900px"><span style="height: 41px; text-align: right;">
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDiagnosis"
                Width="884px" >
                      <Columns>
                      <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                        Visible="False" />
                      <asp:BoundField DataField="DiseaseName" HeaderText="Disease Name" SortExpression="DiseaseName" />
                      <asp:BoundField DataField="ICD10 Code" HeaderText="ICD10 Code" SortExpression="ICD10 Code" />
                      <asp:BoundField DataField="Past" HeaderText="Past" SortExpression="Past" />
                      <asp:BoundField DataField="Provisional" HeaderText="Provisional" SortExpression="Provisional" />
                      <asp:BoundField DataField="Final" HeaderText="Final" SortExpression="Final" />
                      <asp:BoundField DataField="Doctor" HeaderText="Doctor" ReadOnly="True" SortExpression="Doctor" />
                      </Columns>
                      <RowStyle CssClass="GridItem" />
                      <HeaderStyle CssClass="GridHeader" />              
                      <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                  </span></td>
                </tr>
                <tr>
                  <td valign="top" style="height: 22px; text-align: right; width: 900px;"><!--DWLayoutEmptyCell-->&nbsp;</td>
                </tr>
                <tr>
                  <td height="22" valign="bottom" style="width: 900px"><img src="images/sysm_tab.gif" width="153" height="20" /><img src="images/line_tab.gif" width="720" height="1" /></td>
                </tr>
                <tr>
                  <td valign="top" style="height: 22px; width: 900px;"><asp:GridView ID="GridViewSymptoms" runat="server" DataSourceID="SqlDataSourcesymptoms" Width="884px" AutoGenerateColumns="False" Height="58px" >
                      <RowStyle CssClass="GridItem" />
                      <HeaderStyle CssClass="GridHeader" />              
                      <AlternatingRowStyle CssClass="GridAltItem" />
                      <Columns>
                      <asp:BoundField DataField="symptoms" HeaderText="Symptoms" SortExpression="symptoms" />
                      <asp:BoundField DataField="duration" HeaderText="Duration" SortExpression="duration" />
                      <asp:BoundField DataField="datetime" HeaderText="Date and Time" SortExpression="datetime" />
                          <asp:BoundField DataField="Doctor" HeaderText="Doctor" SortExpression="Doctor" />
                      </Columns>
                    </asp:GridView>
                      <asp:GridView ID="GridViewHOPI" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                       DataKeyNames="PCSaveRecord_ID" DataSourceID="SqlDataSource_HOPI"
                      Width="885px" PageSize="20">
                        <Columns>
                        <asp:BoundField DataField="Complaint_Name" HeaderText="Complaint Name" SortExpression="Complaint_Name" />
                        <asp:BoundField DataField="Sub_Type" HeaderText="Component" SortExpression="Sub_Type" />
                        <asp:BoundField DataField="ComponentName" HeaderText="Values" SortExpression="ComponentName" />
                        <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                              Visible="False" />
                        <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
                        <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" Visible="False" />
                            <asp:BoundField DataField="Doctor" HeaderText="Doctor" SortExpression="Doctor" />
                        </Columns>
                        <RowStyle CssClass="GridItem" HorizontalAlign="Center" />
                        <HeaderStyle CssClass="GridHeader" />                
                        <AlternatingRowStyle CssClass="GridAltItem" />
                      </asp:GridView>                  </td>
                </tr>
                <tr>
                  <td valign="top" style="width: 900px; height: 22px">&nbsp;
                      <asp:SqlDataSource ID="SqlDataSource_HOPI" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="[pt_Select_Presenting_Complaints]"
                      SelectCommandType="StoredProcedure">
                        <SelectParameters>
                          <asp:SessionParameter DefaultValue="" Name="RegNo" SessionField="RegistrationNo"
                              Type="String" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSourcesymptoms" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT symptoms.symptoms, pt_Symptoms.duration, pt_Symptoms.datetime, Designation.Designation_Name, ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + '(' + Designation.Designation_Name + ')' AS Doctor FROM Designation INNER JOIN Employee ON Designation.Designation_ID = Employee.DesignationID INNER JOIN symptoms INNER JOIN pt_Symptoms ON symptoms.ID = pt_Symptoms.symptomsID ON Employee.EmpID = pt_Symptoms.emp_id WHERE (pt_Symptoms.YearlyNo = @yearlyno) AND (pt_Symptoms.RegNo = @regno)">
                        <SelectParameters>
                          <asp:SessionParameter Name="yearlyno" SessionField="YearlyNo" />
                          <asp:SessionParameter Name="regno" SessionField="registrationNo" />
                        </SelectParameters>
                      </asp:SqlDataSource>                  </td>
                </tr>
                <tr>
                  <td height="22" valign="bottom" style="width: 900px"><img src="images/med_tab.gif" width="153" height="20" /><img src="images/line_tab.gif" width="720" height="1" /></td>
                </tr>
                <tr>
                  <td height="22" valign="top" style="width: 900px"><span style="height: 41px; text-align: right;">&nbsp;
                        <asp:GridView ID="GridView_Medicine" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMedcine1" Width="884px" >
                          <Columns>
                          <asp:BoundField DataField="MGName" HeaderText="MGName" ReadOnly="True" SortExpression="MGName" />
                          <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                          <asp:BoundField DataField="Dosage" HeaderText="Dosage" SortExpression="Dosage" />
                          <asp:BoundField DataField="days" HeaderText="days" SortExpression="days" />
                          <asp:BoundField DataField="Doctor" HeaderText="Doctor" ReadOnly="True" SortExpression="Doctor" />
                          </Columns>
                          <RowStyle CssClass="GridItem" />
                          <HeaderStyle CssClass="GridHeader" />                  
                          <AlternatingRowStyle CssClass="GridAltItem" />
                        </asp:GridView>
                    </span>
                      <asp:SqlDataSource ID="SqlDataSourceMedcine1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            SelectCommand="pt_Select_Medicine_Prescription" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="Yearlyno" Type="Decimal" />
                        </SelectParameters>
                    </asp:SqlDataSource></td>
                </tr>
                <tr>
                  <td align="right" valign="bottom" style="height: 21px; width: 900px;"><asp:LinkButton CssClass="link1" ID="LinkButton_TestResults" runat="server">Test Results</asp:LinkButton></td>
                </tr>
                <tr>
                  <td height="22" valign="bottom" style="width: 900px"><span style="height: 41px"><img src="images/test_tab.gif" width="153" height="20" /><img src="images/line_tab.gif" width="720" height="1" /></span></td>
                </tr>
                <tr>
                  <td valign="top" style="width: 900px; height: 22px"><span style="height: 41px">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTest" Width="884px" >
                      <Columns>
                      <asp:BoundField DataField="TGName" HeaderText="Test Group" SortExpression="TGName" >
                        <ItemStyle Font-Bold="True" />                      </asp:BoundField>
                      <asp:BoundField DataField="TSGName" HeaderText="Sub Group" SortExpression="TSGName" />
                      <asp:BoundField DataField="TestAssignDate" HeaderText="Test Assign Date &amp; Time"
                SortExpression="TestAssignDate" />
                          <asp:BoundField DataField="Doctor" HeaderText="Doctor" SortExpression="Doctor" />
                      </Columns>
                      <RowStyle CssClass="GridItem" />
                      <HeaderStyle CssClass="GridHeader" />              
                      <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                  </span></td>
                </tr>
                <tr>
                  <td height="22" valign="top" style="width: 900px"><!--DWLayoutEmptyCell-->&nbsp;</td>
                </tr>
                <tr>
                  <td height="22" valign="bottom" style="width: 900px"><span style="height: 34px"><img src="images/radtab.gif" width="153" height="20" /><img src="images/line_tab.gif" width="720" height="1" /></span></td>
                </tr>
                <tr>
                  <td valign="top" dir="ltr" style="height: 22px; width: 900px;"><asp:GridView ID="GridViewRadiology" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceRadiology" Width="884px" DataKeyNames="RID" >
                      <Columns>
                      <asp:BoundField DataField="RGName" HeaderText="Services" SortExpression="RGName" />
                      <asp:BoundField DataField="RSGName" HeaderText="Services Name" SortExpression="RSGName" />
                      <asp:BoundField DataField="RadiologyName" HeaderText="Radiology Test" SortExpression="RadiologyName" />
                      <asp:BoundField DataField="DateTime" HeaderText="DateTime" SortExpression="DateTime" />
                      <asp:BoundField DataField="Doctor" HeaderText="Doctor" ReadOnly="True" SortExpression="Doctor" />
                      <asp:HyperLinkField DataNavigateUrlFields="PayID,RegNo,RID" DataNavigateUrlFormatString="http://mjahangir/lgh/dicom/DicomeViewer.aspx"
                        HeaderText="Report" Text="view Report" />
                      <asp:HyperLinkField DataNavigateUrlFields="RID,PayID,RegNo" DataNavigateUrlFormatString="dicom/DicomeViewer.aspx?rid={0}&amp;payid={1}&amp;regno={2}"
                        HeaderText="Dicom Viewer" Text="View" />
                      </Columns>
                      <RowStyle CssClass="GridItem" />
                      <HeaderStyle CssClass="GridHeader" />              
                      <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                      <asp:SqlDataSource ID="SqlDataSourceRadiology" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            SelectCommand="pt_Radiology_Select_Tests" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                          <asp:SessionParameter Name="PayID" SessionField="Yearlyno" Type="Decimal" />
                        </SelectParameters>
                    </asp:SqlDataSource></td>
                </tr>
                <tr>
                  <td valign="top" style="height: 22px; width: 900px;"><!--DWLayoutEptyCell-->
                    &nbsp;</td>
                </tr>
                <tr>
                  <td valign="bottom" style="height: 22px; width: 900px;"><span style="height: 34px"><img src="images/xry_tab.gif" width="153" height="20" /><img src="images/line_tab.gif" width="720" height="1" /></span></td>
                </tr>
                <tr>
                  <td height="22" valign="top" style="width: 900px"><span style="height: 34px">
                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceXray" Width="884px" >
                      <Columns>
                      <asp:BoundField DataField="Rd_body_part" HeaderText="Body Part" SortExpression="Rd_body_part" />
                      <asp:BoundField DataField="Expr1" HeaderText="Expr1" SortExpression="Expr1" Visible="False" />
                      <asp:BoundField DataField="Projection" HeaderText="Projection" SortExpression="Projection" />
                      <asp:BoundField DataField="Reg_No" HeaderText="Reg_No" SortExpression="Reg_No" Visible="False" />
                      <asp:BoundField DataField="Yearly_No" HeaderText="Yearly_No" SortExpression="Yearly_No"
                        Visible="False" />
                      <asp:BoundField DataField="Time_Stamp" HeaderText="Date and Time" SortExpression="Time_Stamp" />
                          <asp:BoundField DataField="Doctor" HeaderText="Doctor" SortExpression="Doctor" />
                      </Columns>
                      <RowStyle CssClass="GridItem" />
                      <HeaderStyle CssClass="GridHeader" />              
                      <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceXray" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT Pt_Xray.XRay_ID AS Expr1, Rd_xray_projections.Projections AS Projection, Pt_Xray.Reg_No, Pt_Xray.Yearly_No, Pt_Xray.Time_Stamp, Rd_body_part.Rd_body_part, ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' (' + Designation.Designation_Name + ' )' AS Doctor FROM Designation INNER JOIN Employee ON Designation.Designation_ID = Employee.DesignationID INNER JOIN Pt_Xray INNER JOIN Rd_xray_projections ON Pt_Xray.XRay_ID = Rd_xray_projections.Projection_ID INNER JOIN Rd_body_part ON Rd_xray_projections.Rd_Body_part_Id = Rd_body_part.Rd_body_part_id ON Employee.EmpID = Pt_Xray.Emp_ID WHERE (Pt_Xray.Reg_No = @regno) AND (Pt_Xray.Yearly_No = @yearlyno)">
                      <SelectParameters>
                        <asp:SessionParameter Name="regno" SessionField="registrationNo" />
                        <asp:SessionParameter Name="yearlyno" SessionField="Yearlyno" />
                      </SelectParameters>
                    </asp:SqlDataSource>
                  </span></td>
                </tr>
                <tr>
                  <td valign="top" style="height: 22px; width: 900px;"><!--DWLayoutEmptyCell-->&nbsp;</td>
                </tr>
                <tr>
                  <td valign="bottom" style="height: 22px; width: 900px;"><span style="height: 34px"><img src="images/view_xray.gif" width="153" height="20" /><img src="images/line_tab.gif" width="720" height="1" /></span></td>
                </tr>
                <tr>
                  <td valign="top" dir="ltr" style="height: 22px; width: 900px;">&nbsp;
                      <asp:GridView ID="GridViewXrayView" runat="server" AutoGenerateColumns="False"
                      DataKeyNames="XRay_ID" DataSourceID="SqlDataSourceXrayView" Width="884px" >
                        <Columns>
                        <asp:BoundField DataField="Expr1" HeaderText="Part Id" SortExpression="Expr1" Visible="False" />
                        <asp:BoundField DataField="Rd_body_part" HeaderText="Body Part" SortExpression="Rd_body_part" />
                        <asp:BoundField DataField="Projection" HeaderText="Projection" SortExpression="Projection" />
                        <asp:BoundField DataField="Reg_No" HeaderText="Reg_No" SortExpression="Reg_No" Visible="False" />
                        <asp:BoundField DataField="Yearly_No" HeaderText="Yearly_No" SortExpression="Yearly_No"
                              Visible="False" />
                        <asp:BoundField DataField="Time_Stamp" HeaderText="Time " SortExpression="Date Time" />
                            <asp:BoundField DataField="Doctor" HeaderText="Doctor" SortExpression="Doctor" />
                        <asp:CommandField SelectText="View" ShowSelectButton="True" Visible="False" />
                        <asp:HyperLinkField DataNavigateUrlFields="XRay_ID,Yearly_No,Reg_No" DataNavigateUrlFormatString="Ptxrayview1.aspx?Xray_ID={0}&amp;payId={1}&amp;rig_no={2}"
                              HeaderText="Xray" ShowHeader="False" Target="_blank" Text="Show" />
                        <asp:CommandField SelectText="View" ShowSelectButton="True" />
                        <asp:HyperLinkField DataNavigateUrlFields="XRay_ID,Reg_No,Yearly_No" DataNavigateUrlFormatString="XrayFindings.aspx?XRay_ID={0}&amp;Reg_No={1}&amp;Yearly_No={2}"
                              Text="Add Findings" />
                        <asp:BoundField DataField="XRay_ID" HeaderText="XRay_ID" SortExpression="XRay_ID"
                              Visible="False" />
                        </Columns>
                        <RowStyle CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />                
                        <AlternatingRowStyle CssClass="GridAltItem" />
                      </asp:GridView>
                      <asp:SqlDataSource ID="SqlDataSourceXrayView" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                      SelectCommand="SELECT Rd_xray_projections.Projections AS Projection, Pt_Xray.Reg_No, Pt_Xray.Yearly_No, Pt_Xray.Time_Stamp, Rd_body_part.Rd_body_part, Pt_Xray.XRay_ID, pt_Xray_Images.Xray_ID AS Expr1, ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + '( ' + Designation.Designation_Name + ') ' AS Doctor FROM Designation INNER JOIN Employee ON Designation.Designation_ID = Employee.DesignationID INNER JOIN Pt_Xray INNER JOIN Rd_xray_projections ON Pt_Xray.XRay_ID = Rd_xray_projections.Projection_ID INNER JOIN Rd_body_part ON Rd_xray_projections.Rd_Body_part_Id = Rd_body_part.Rd_body_part_id INNER JOIN pt_Xray_Images ON Pt_Xray.XRay_ID = pt_Xray_Images.Xray_ID ON Employee.EmpID = Pt_Xray.Emp_ID WHERE (Pt_Xray.Reg_No = @regno) AND (Pt_Xray.Yearly_No = @yearlyno)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                        <SelectParameters>
                          <asp:SessionParameter Name="regno" SessionField="registrationNo" />
                          <asp:SessionParameter Name="yearlyno" SessionField="YearlyNo" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceviewxray"
                      Width="887px" >
                        <Columns>
                        <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
                        <asp:BoundField DataField="Name" HeaderText="Doctor" ReadOnly="True" SortExpression="Name" />
                        <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                              Visible="False" />
                        <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
                        <asp:BoundField DataField="Xray_ID" HeaderText="Xray_ID" SortExpression="Xray_ID" />
                        <asp:BoundField DataField="Xray_Description" HeaderText="Xray_Description" SortExpression="Xray_Description" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        </Columns>
                        <RowStyle  HorizontalAlign="Center" />
                        <HeaderStyle CssClass="GridHeader" />                
                        <AlternatingRowStyle CssClass="GridAltItem" />
                      </asp:GridView>
                      <asp:SqlDataSource ID="SqlDataSourceviewxray" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                      InsertCommand="INSERT INTO [LGH].[dbo].[Rd_Xray_Report]
           ([Xray_ID]
           ,[RegNo]
           ,[YearlyNo]
           ,[Xray_Description]
           ,[EmpID])
     VALUES
           (@Xray_ID
           ,@RegNo
           ,@YearlyNo
           ,@Xray_Description
           ,@EmpID
)"
                      ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Rd_Xray_Report.YearlyNo, Rd_Xray_Report.RegNo, Rd_Xray_Report.Xray_ID, Rd_Xray_Report.Xray_Description, ISNULL(Employee.Prefix, '') + ISNULL(Employee.EFName, '') + ISNULL(Employee.EMName, '') + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name AS Expr1, '  )' AS Name, Department.Dept_Name, Designation.Designation_Name FROM Rd_Xray_Report INNER JOIN Employee ON Rd_Xray_Report.EmpID = Employee.EmpID INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Rd_Xray_Report.YearlyNo = @YearlyNo) AND (Rd_Xray_Report.RegNo = @RegNo) AND (Rd_Xray_Report.Xray_ID = @Xray_ID)">
                        <SelectParameters>
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                          <asp:ControlParameter ControlID="GridViewXrayView" Name="Xray_ID" PropertyName="SelectedValue" />
                        </SelectParameters>
                        <InsertParameters>
                          <asp:QueryStringParameter Name="Xray_ID" QueryStringField="Xid" />
                          <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:ControlParameter ControlID="TextBoxFindings" Name="Xray_Description" PropertyName="Text" />
                          <asp:ControlParameter ControlID="DropDownListSDoctors" Name="EmpID" PropertyName="SelectedValue" />
                        </InsertParameters>
                      </asp:SqlDataSource>
                    <asp:GridView ID="GridView_History" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_History"
                      Width="887px" >
                        <Columns>
                        <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
                        <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                              Visible="False" />
                        <asp:BoundField DataField="MG_Code" HeaderText="MG_Code" SortExpression="MG_Code"
                              Visible="False" />
                        <asp:BoundField DataField="e_Code" HeaderText="e_Code" InsertVisible="False" ReadOnly="True"
                              SortExpression="e_Code" Visible="False" />
                        <asp:BoundField DataField="MG_Name" HeaderText="Group" SortExpression="MG_Name" />
                        <asp:BoundField DataField="e_Name" HeaderText="Element Name" SortExpression="e_Name" />
                        <asp:BoundField DataField="ev_Code" HeaderText="Value/Examine Results" SortExpression="ev_Code" />
                            <asp:BoundField DataField="Doctor" HeaderText="Doctor" SortExpression="Doctor" />
                        </Columns>
                        <RowStyle  HorizontalAlign="Center" />
                        <HeaderStyle CssClass="GridHeader" />                
                        <AlternatingRowStyle CssClass="GridAltItem" />
                      </asp:GridView>
                      <asp:SqlDataSource ID="SqlDataSource_History" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Pt_history_SaveRecord.RegNo, Pt_history_SaveRecord.YearlyNo, admin_History_Elements.MG_Code, admin_History_Elements.e_Code, admin_History_Elements.e_Name, Pt_history_SaveRecord.ev_Code, admin_History_MainGroup.MG_Name, ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' (' + Designation.Designation_Name + ' )' AS Doctor FROM Designation INNER JOIN Employee ON Designation.Designation_ID = Employee.DesignationID INNER JOIN admin_History_MainGroup INNER JOIN admin_History_Elements ON admin_History_MainGroup.MG_Code = admin_History_Elements.MG_Code INNER JOIN Pt_history_SaveRecord ON admin_History_Elements.e_Code = Pt_history_SaveRecord.e_Code AND admin_History_Elements.MG_Code = Pt_history_SaveRecord.MG_Code ON Employee.EmpID = Pt_history_SaveRecord.Emp_ID WHERE (Pt_history_SaveRecord.YearlyNo = @YearlyNo) AND (Pt_history_SaveRecord.RegNo = @RegNo) ORDER BY admin_History_Elements.MG_Code">
                        <SelectParameters>
                          <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:SessionParameter DefaultValue="" Name="RegNo" SessionField="RegistrationNo" />
                        </SelectParameters>
                      </asp:SqlDataSource>                  </td>
                </tr>
                <tr>
                  <td height="22" valign="top" style="width: 900px"><!--DWLayoutEmptyCell-->&nbsp;</td>
                </tr>
                <tr>
                  <td height="22" valign="bottom" style="width: 900px"><span style="height: 34px"><img src="images/physical_tab.gif" width="177" height="20" /><img src="images/line_tab.gif" width="695" height="1" /></span></td>
                </tr>
                <tr>
                  <td valign="top" style="height: 22px; width: 900px;">&nbsp;&nbsp;
                      <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False"
                       DataSourceID="SqlDataSource1" EmptyDataText="no  row"
                      GridLines="None" Width="892px">
                        <Columns>
                        <asp:BoundField DataField="MG_Name" HeaderText="Main Group Name" SortExpression="MG_Name" />
                        <asp:BoundField DataField="e_Name" HeaderText="Element" SortExpression="e_Name" />
                        <asp:BoundField DataField="Exam_Result" HeaderText="Result" SortExpression="Exam_Result" />
                        <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                        <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                        <asp:BoundField DataField="MG_Code" HeaderText="MG_Code" ReadOnly="True" SortExpression="MG_Code"
                              Visible="False" />
                        <asp:BoundField DataField="e_Code" HeaderText="e_Code" InsertVisible="False" ReadOnly="True"
                              SortExpression="e_Code" Visible="False" />
                        <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                              Visible="False" />
                        <asp:BoundField DataField="RegistrationNo" HeaderText="RegistrationNo" SortExpression="RegistrationNo"
                              Visible="False" />
                        </Columns>
                        <RowStyle BorderStyle="None" CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />                
                        <AlternatingRowStyle CssClass="GridAltItem" />
                      </asp:GridView>
                      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT     admin_Phy_Exam_MainGroup.MG_Name, admin_Phy_Exam_Elements.e_Name, CONVERT(varchar, Pt_physical_exam_saveRecord.Time, 108) 
                      AS Time, admin_Phy_Exam_MainGroup.MG_Code, admin_Phy_Exam_Elements.e_Code, Pt_physical_exam_saveRecord.YearlyNo, 
                      Pt_physical_exam_saveRecord.RegNo AS RegistrationNo, Pt_physical_exam_saveRecord.Exam_Result, 
                      convert(varchar,Pt_physical_exam_saveRecord.Time,103) as Date
FROM         admin_Phy_Exam_Elements INNER JOIN
                      admin_Phy_Exam_MainGroup ON admin_Phy_Exam_Elements.MG_Code = admin_Phy_Exam_MainGroup.MG_Code INNER JOIN
                      Pt_physical_exam_saveRecord ON admin_Phy_Exam_Elements.e_Code = Pt_physical_exam_saveRecord.E_ID
where Pt_physical_exam_saveRecord.RegNo=@regno and Pt_physical_exam_saveRecord.YearlyNo=@yearlyno
order by admin_Phy_Exam_MainGroup.MG_Name
">
                        <SelectParameters>
                          <asp:SessionParameter Name="yearlyno" SessionField="YearlyNo" Type="Decimal" />
                          <asp:SessionParameter Name="regno" SessionField="registrationNo" Type="String" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSourceexamination" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT admin_Phy_Exam_MainGroup.MG_Name, admin_Phy_Exam_Elements.e_Name, Pt_Phy_Exam_SaveRecord.ev_Code, Pt_Phy_Exam_SaveRecord.DateTme FROM Pt_Phy_Exam_SaveRecord INNER JOIN admin_Phy_Exam_Elements ON Pt_Phy_Exam_SaveRecord.e_Code = admin_Phy_Exam_Elements.e_ID INNER JOIN admin_Phy_Exam_MainGroup ON Pt_Phy_Exam_SaveRecord.MG_Code = admin_Phy_Exam_MainGroup.MG_Code WHERE (Pt_Phy_Exam_SaveRecord.RegNo = @regno) AND (Pt_Phy_Exam_SaveRecord.YearlyNo = @yearlyno)">
                        <SelectParameters>
                          <asp:SessionParameter Name="regno" SessionField="registrationNo" />
                          <asp:SessionParameter Name="yearlyno" SessionField="YearlyNo" />
                        </SelectParameters>
                    </asp:SqlDataSource></td>
                </tr>
                <tr>
                  <td height="22" valign="top" style="width: 900px">&nbsp;
                      <asp:SqlDataSource ID="SqlDataSource_priscriptionfordischarge" runat="server"
                      ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (mCode = @mCode) AND (yearlyNo = @yearlyNo)"
                      SelectCommand="[pt_Select_Medicine_PrescriptionforDischarge]"
                      UpdateCommand="UPDATE [Pt_Phy_Exam_SaveRecord] SET [Status] = @Status  WHERE [Record_ID] = @Record_ID" SelectCommandType="StoredProcedure">
                        <DeleteParameters>
                          <asp:Parameter Name="mCode" Type="String" />
                          <asp:Parameter Name="yearlyNo" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                          <asp:Parameter DefaultValue="0" Name="Status" />
                          <asp:Parameter Name="Record_ID" />
                        </UpdateParameters>
                        <SelectParameters>
                          <asp:SessionParameter Name="yearlyNo" SessionField="yearlyNo" Type="Int32" />
                          <asp:SessionParameter Name="regno" SessionField="registrationNo" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:GridView ID="GridViewDischargemedicine" runat="server" DataSourceID="SqlDataSource_priscriptionfordischarge" AutoGenerateColumns="False" Width="877px" Visible="False">
                        <RowStyle CssClass="GridItem" HorizontalAlign="Center" />
                        <HeaderStyle CssClass="GridHeader" />                
                        <AlternatingRowStyle CssClass="GridAltItem" />
                        <Columns>
                        <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                        <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                        <asp:BoundField DataField="MGName" HeaderText="MGName" ReadOnly="True" SortExpression="MGName" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" ReadOnly="True" SortExpression="Quantity" />
                        <asp:BoundField DataField="Doctor" HeaderText="Doctor" ReadOnly="True" SortExpression="Doctor" />
                        <asp:BoundField DataField="yearlyNo" HeaderText="yearlyNo" SortExpression="yearlyNo"
                              Visible="False" />
                        <asp:BoundField DataField="patientId" HeaderText="patientId" SortExpression="patientId"
                              Visible="False" />
                        </Columns>
                      </asp:GridView>                  </td>
                </tr>
              </table></td>
              <td></td>
            </tr>
            <tr>
              <td height="13" style="width: 446px"></td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td height="28" colspan="2" align="center" valign="top"><asp:Button ID="save" runat="server" Text="Save" Width="80px" Visible="False" />              
                <asp:Button ID="Button_Discharge" runat="server" Text="Save &amp; Discharge" Visible="False" />                
                <asp:Button ID="Button_WardAdmission" runat="server" Text="Ward Admission" Visible="False" />                
                <asp:Button ID="ButtonMOT" runat="server" Text="Send to COT" Visible="False" /></td>
              <td></td>
            </tr>
            <tr>
              <td height="15" style="width: 446px"></td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td height="161" colspan="2" valign="top"><asp:SqlDataSource ID="SqlDataSourceWard" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  SelectCommand="SELECT [WardID], [WardName] FROM [Ward]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceSave" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  InsertCommand="INSERT INTO EMOPatientInfo(Condition, Diagnosis, Injury, Advise, RegNo, PayID, DoctorID) 
VALUES (@Condition, @Diagnosis, @Injury, @Advise, @RegNo, @PayID, @DID)"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                  <InsertParameters>
                    <asp:FormParameter FormField="textboxcondition" Name="Condition" />
                    <asp:FormParameter FormField="Textboxdiagnosis" Name="Diagnosis" />
                    <asp:FormParameter FormField="TextBoxInjury" Name="Injury" />
                    <asp:FormParameter FormField="textboxadvise" Name="Advise" />
                    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                    <asp:SessionParameter Name="PayID" SessionField="YearlyNo" />
                    <asp:SessionParameter Name="DID" SessionField="emp_id" />
                  </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SELECT DISTINCT TestGroup.TGName, TestSubGroup.TSGName, CONVERT (varchar, PatientsLabTest.DateTime, 103) AS TestAssignDate, ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' (' + Designation.Designation_Name + ' )' AS Doctor FROM TestGroup INNER JOIN TestSubGroup ON TestGroup.TGID = TestSubGroup.TGID INNER JOIN PatientsLabTest INNER JOIN Test ON PatientsLabTest.TID = Test.TID ON TestSubGroup.TSGID = Test.TSGID AND TestSubGroup.TGID = Test.TGID AND PatientsLabTest.PayID = @PayID AND PatientsLabTest.RegNo = @RegNo INNER JOIN Employee ON PatientsLabTest.EmpID = Employee.EmpID INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID">
                  <SelectParameters>
                    <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Int32" />
                    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                  </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_status_open" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    InsertCommand="status_open" InsertCommandType="StoredProcedure" SelectCommand="status_open"
                    SelectCommandType="StoredProcedure">
                  <SelectParameters>
                    <asp:ControlParameter ControlID="Hidden_Registration" Name="Reg_No" PropertyName="Value"
                            Type="String" />
                    <asp:ControlParameter ControlID="Hidden_yearlyNo" Name="yearly_no" PropertyName="Value"
                            Type="Int32" />
                    <asp:Parameter DefaultValue="1" Name="to_sub_Dept" Type="Int32" />
                    <asp:ControlParameter ControlID="Hidden_empid" DefaultValue="" Name="by_doctor" PropertyName="Value"
                            Type="Int32" />
                    <asp:Parameter DefaultValue="1" Name="by_sub_dept_id" Type="Int32" />
                    <asp:ControlParameter ControlID="Hidden_date" DefaultValue="" Name="forward_date"
                            PropertyName="Value" Type="DateTime" />
                    <asp:Parameter DefaultValue="1" Name="request_type_id" Type="Int32" />
                  </SelectParameters>
                  <InsertParameters>
                    <asp:ControlParameter ControlID="Hidden_Registration" Name="Reg_No" PropertyName="Value"
                            Type="String" />
                    <asp:ControlParameter ControlID="Hidden_yearlyNo" Name="yearly_no" PropertyName="Value"
                            Type="Int32" />
                    <asp:Parameter DefaultValue="1" Name="to_sub_Dept" Type="Int32" />
                    <asp:ControlParameter ControlID="Hidden_empid" DefaultValue="" Name="by_doctor" PropertyName="Value"
                            Type="Int32" />
                    <asp:Parameter DefaultValue="1" Name="by_sub_dept_id" Type="Int32" />
                    <asp:ControlParameter ControlID="Hidden_date" DefaultValue="" Name="forward_date"
                            PropertyName="Value" Type="DateTime" />
                    <asp:Parameter DefaultValue="3" Name="request_type_id" Type="Int32" />
                  </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="Hidden_date" runat="server" />
&nbsp; &nbsp;
<asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="pt_get_diagnosis"
                SelectCommandType="StoredProcedure">
  <SelectParameters>
    <asp:SessionParameter Name="COD" SessionField="YearlyNo" Type="String" />
    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceforward" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" InsertCommand="pt_InnerDepartment_PatientForward" InsertCommandType="StoredProcedure" SelectCommand="a">
  <InsertParameters>
    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
    <asp:SessionParameter Name="EmpID" SessionField="emp_id" Type="Int32" />
    <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
    <asp:ControlParameter ControlID="HiddenFieldSubDeptto" Name="ToSubDept" PropertyName="Value"
                        Type="Int32" />
    <asp:ControlParameter ControlID="HiddenFieldsubdeptfrom" Name="SendingDept" PropertyName="Value"
                        Type="Int32" />
    <asp:ControlParameter ControlID="HiddenFieldrequestto" Name="iRequestTypeTo" PropertyName="Value"
                        Type="Int32" />
    <asp:ControlParameter ControlID="HiddenFieldrequestby" Name="iRequestTypeBy" PropertyName="Value"
                        Type="Int32" />
  </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourcerequeststatus" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                InsertCommand="insertEMOPatientForward" InsertCommandType="StoredProcedure" SelectCommand="a"
                UpdateCommand="RequestStatus_Close" UpdateCommandType="StoredProcedure">
  <UpdateParameters>
    <asp:SessionParameter Name="RegNo" Type="String" SessionField="registrationNo" />
    <asp:SessionParameter Name="PayID" Type="Decimal" SessionField="YearlyNo" />
    <asp:ControlParameter ControlID="HiddenFieldSubDeptto" Name="SendingDept" PropertyName="Value"
          Type="Int32" />
    <asp:ControlParameter ControlID="HiddenFieldrequestby" Name="Request_Type" PropertyName="Value"
          Type="Int32" />
  </UpdateParameters>
  <InsertParameters>
    <asp:ControlParameter ControlID="Hidden_Registration" Name="RegNo" PropertyName="Value"
                        Type="String" />
    <asp:SessionParameter Name="EmpID" SessionField="UserID" Type="Int32" />
    <asp:ControlParameter ControlID="Hidden_yearlyNo" Name="PayID" PropertyName="Value"
                        Type="Decimal" />
    <asp:Parameter DefaultValue="2" Name="ToSubDept" Type="Int32" />
    <asp:ControlParameter ControlID="TextBoxdiagnosis" DefaultValue="" Name="Diagnosis"
                        PropertyName="Text" Type="String" />
    <asp:ControlParameter ControlID="HiddenFieldSubDept" Name="SendingDept" PropertyName="Value"
                        Type="Int32" />
  </InsertParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="Hidden_yearlyNo" runat="server" />
<asp:HiddenField ID="Hidden_empid" runat="server" />
<asp:HiddenField ID="Hidden_Registration" runat="server" />
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  DeleteCommand="DELETE FROM [Pt_Phy_Exam_SaveRecord] WHERE [Record_ID] = @Record_ID"
                  InsertCommand="INSERT INTO [Pt_Phy_Exam_SaveRecord] ([Status], [Emp_ID]) VALUES (@Status, @Emp_ID)"
                  SelectCommand="SELECT [Record_ID], [Status], [Emp_ID] FROM [Pt_Phy_Exam_SaveRecord]"
                  UpdateCommand="UPDATE [Pt_Phy_Exam_SaveRecord] SET [Status] = @Status  WHERE  [Emp_ID] = @Emp_ID">
  <DeleteParameters>
    <asp:Parameter Name="Record_ID" Type="Int32" />
  </DeleteParameters>
  <UpdateParameters>
    <asp:Parameter DefaultValue="False" Name="Status" Type="Boolean" />
    <asp:SessionParameter DefaultValue="" Name="Emp_ID" SessionField="emp_id" />
  </UpdateParameters>
  <InsertParameters>
    <asp:Parameter DefaultValue="0" Name="Status" Type="Boolean" />
    <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
  </InsertParameters>
</asp:SqlDataSource>
&nbsp;&nbsp;&nbsp;
<asp:SqlDataSource ID="SqlDataSourcePresentingComplaints" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE Pt_Presenting_Complaint_saveRecord SET status = 0 WHERE (empid = @empid) AND (RegNo = @RegNo) AND (YearlyNo = @YearlyNo)">
  <UpdateParameters>
    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
    <asp:SessionParameter Name="empid" SessionField="emp_id" />
    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
  </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceHOPI" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE pt_Save_Presenting_Complaints SET status = 0
WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (empid = @empid)" SelectCommand="pt_Select_Presenting_Complaints" SelectCommandType="StoredProcedure">
  <UpdateParameters>
    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
    <asp:SessionParameter Name="empid" SessionField="emp_id" />
  </UpdateParameters>
  <SelectParameters>
    <asp:Parameter DefaultValue="session(&quot;registration_no&quot;)" Name="RegNo" Type="String" />
    <asp:Parameter DefaultValue="session(&quot;yearly_no&quot;)" Name="YearlyNo" Type="Decimal" />
  </SelectParameters>
</asp:SqlDataSource>
&nbsp;
<asp:SqlDataSource ID="SqlDataSourceSystemInquiry" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE Pt_System_Inquiry_SaveRecord SET status = 0 WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (Emp_ID = @empid)">
  <UpdateParameters>
    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
    <asp:SessionParameter Name="empid" SessionField="emp_id" />
    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
  </UpdateParameters>
</asp:SqlDataSource>
&nbsp; &nbsp;
              &nbsp; &nbsp;&nbsp; <br />
              <asp:SqlDataSource ID="SqlDataSourceAllergyHistoryCasuedby" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE PT_Allergy_CauseBy SET status = 0 WHERE (RegNo = @RegNo) AND (YearlyNO = @YearlyNo) AND (empid = @empid)">
                <UpdateParameters>
                  <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                  <asp:SessionParameter Name="empid" SessionField="emp_id" />
                </UpdateParameters>
              </asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSourceDetailPhysicalExam" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" UpdateCommand="UPDATE Pt_physical_exam_saveRecord SET status = 0 WHERE (empid = @empid) AND (YearlyNo = @yearlyno) AND (RegNo = @regno)">
                <UpdateParameters>
                  <asp:SessionParameter Name="empid" SessionField="emp_id" />
                  <asp:SessionParameter Name="yearlyno" SessionField="YearlyNo" />
                  <asp:SessionParameter Name="regno" SessionField="registrationNo" />
                </UpdateParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldSubDeptto" runat="server" />
&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
              &nbsp; &nbsp; &nbsp;&nbsp;
              <asp:HiddenField ID="HiddenField_PayID" runat="server" />
              <asp:HiddenField ID="HiddenField_RegNo" runat="server" />
&nbsp;
<asp:HiddenField ID="HiddenFieldrequestto" runat="server" />
&nbsp;&nbsp;
<asp:HiddenField ID="HiddenFieldrequestby" runat="server" />
<asp:HiddenField ID="HiddenFieldsubdeptfrom" runat="server" />
<asp:HiddenField ID="HiddenFieldrequest" runat="server" />
<asp:SqlDataSource ID="SqlDataSourceTestStatus" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" UpdateCommand="LabTestStatusOn" UpdateCommandType="StoredProcedure">
  <UpdateParameters>
    <asp:ControlParameter ControlID="Hidden_Registration" Name="reg_No" PropertyName="Value"
                            Type="String" />
    <asp:ControlParameter ControlID="Hidden_yearlyNo" Name="yearly_no" PropertyName="Value"
                            Type="Int32" />
  </UpdateParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="HiddenFieldmainpage" runat="server" />
<asp:SqlDataSource ID="SqlDataSourceMedicine" runat="server" SelectCommand="SELECT Medicine.MMName, Pt_Prescription_Detail.date FROM Medicine INNER JOIN Pt_Prescription_Detail ON Medicine.MedCode = Pt_Prescription_Detail.mCode WHERE (Pt_Prescription_Detail.yearlyNo = @payid)" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>">
  <SelectParameters>
    <asp:SessionParameter Name="payid" SessionField="YearlyNo" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:LinkButton ID="LinkButton1" runat="server" CssClass="link1" Width="150px" Visible="false">Symptoms</asp:LinkButton>
<asp:LinkButton CssClass="link1" ID="LinkButtonMedicine" runat="server" Width="150px" Visible="false">Assign Medicine</asp:LinkButton>
<span style="height: 41px">
<asp:LinkButton CssClass="link1" ID="LinkButtonTest" runat="server" Width="150px" Visible="false">Assign Test</asp:LinkButton>
<span style="height: 34px">
<asp:LinkButton ID="LinkButton2" runat="server" CssClass="link1" Width="150px" Visible="false">Assign XRay</asp:LinkButton>
</span></span><span style="height: 34px">
<asp:LinkButton CssClass="link1" ID="LinkButton3" runat="server" Width="150px" Visible="false">Physical Examination</asp:LinkButton>
<asp:RadioButtonList AutoPostBack="True" CssClass="text_labels_two" ID="RadioButtonListSendto" runat="server"
                        RepeatDirection="Horizontal" Width="163px" Visible="false">
  <asp:ListItem Selected="True">Discharge</asp:ListItem>
  <asp:ListItem>Ward</asp:ListItem>
</asp:RadioButtonList>
<asp:DropDownList ID="DropDownListWard" runat="server"
                        DataSourceID="SqlDataSourceWard" DataTextField="WardName" DataValueField="WardID" Width="180px" CssClass="text_dropdown" Visible="false"> </asp:DropDownList>
</span></td>
              <td></td>
            </tr>
            <tr>
              <td height="27" style="width: 446px">&nbsp;</td>
              <td></td>
              <td></td>
            </tr>
            
            
            
            
            
            
            
              <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
            
            
            
            </table></td>
          <!-- </div>-->
          </tr>
          </table></td>
    <td width="33" valign="top" class="right_border" style="width: 33px"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" alt="" width="1003" height="24" /></td>
  </tr>
</table>



</form>
     
          
       
      
      
      
      
      
      
      
      
      
      
      
      
      
   
    
</body>
</html>