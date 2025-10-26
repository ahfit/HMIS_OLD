<%@ page language="C#" autoeventwireup="true" inherits="newpharmacymain, App_Web_3j2dqz20" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> </title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {color: #999999}
.style2 {color:#000000; text-decoration:none; font: 11px Verdana;}
-->
</style>
</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="tabs_medicine.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
        </tr>
      
      
      <tr>
        <td width="20" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="937" valign="middle" class="link_spliter"><img src="images1/img_title_pharmacy.gif"   /><img src="images1/img_title_pharmacydetail.gif" width="148" height="15" /></td>
        </tr>
      <tr>
        <td height="428" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="8" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td rowspan="8" valign="top" style="width: 55px"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
              </tr>
          <tr>
            <td height="57" valign="top">
              <asp:FormView ID="FormView2" runat="server" CssClass="text_boxtitle" DataSourceID="patient_detail"
                  HorizontalAlign="Left">
                <EditItemTemplate> PayID:
                  <asp:TextBox ID="PayIDTextBox" runat="server" Text='<%# Bind("PayID") %>'> </asp:TextBox>
                  <br />
                  PatientName:
                  <asp:TextBox ID="PatientNameTextBox" runat="server" Text='<%# Bind("PatientName") %>'> </asp:TextBox>
                  <br />
                  Relation:
                  <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>'> </asp:TextBox>
                  <br />
                  RelationName:
                  <asp:TextBox ID="RelationNameTextBox" runat="server" Text='<%# Bind("RelationName") %>'> </asp:TextBox>
                  <br />
                  Age:
                  <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>'> </asp:TextBox>
                  <br />
                  PatientType:
                  <asp:TextBox ID="PatientTypeTextBox" runat="server" Text='<%# Bind("PatientType") %>'> </asp:TextBox>
                  <br />
                  BPHigh:
                  <asp:TextBox ID="BPHighTextBox" runat="server" Text='<%# Bind("BPHigh") %>'> </asp:TextBox>
                  <br />
                  BPLow:
                  <asp:TextBox ID="BPLowTextBox" runat="server" Text='<%# Bind("BPLow") %>'> </asp:TextBox>
                  <br />
                  Pulse:
                  <asp:TextBox ID="PulseTextBox" runat="server" Text='<%# Bind("Pulse") %>'> </asp:TextBox>
                  <br />
                  Temperature:
                  <asp:TextBox ID="TemperatureTextBox" runat="server" Text='<%# Bind("Temperature") %>'> </asp:TextBox>
                  <br />
                  RR:
                  <asp:TextBox ID="RRTextBox" runat="server" Text='<%# Bind("RR") %>'> </asp:TextBox>
                  <br />
                  StreetAddress:
                  <asp:TextBox ID="StreetAddressTextBox" runat="server" Text='<%# Bind("StreetAddress") %>'> </asp:TextBox>
                  <br />
                  HomePhone:
                  <asp:TextBox ID="HomePhoneTextBox" runat="server" Text='<%# Bind("HomePhone") %>'> </asp:TextBox>
                  <br />
                  MobilePhone:
                  <asp:TextBox ID="MobilePhoneTextBox" runat="server" Text='<%# Bind("MobilePhone") %>'> </asp:TextBox>
                  <br />
                  CNIC:
                  <asp:TextBox ID="CNICTextBox" runat="server" Text='<%# Bind("CNIC") %>'> </asp:TextBox>
                  <br />
                  Year:
                  <asp:TextBox ID="YearTextBox" runat="server" Text='<%# Bind("Year") %>'> </asp:TextBox>
                  <br />
                  AgeType:
                  <asp:TextBox ID="AgeTypeTextBox" runat="server" Text='<%# Bind("AgeType") %>'> </asp:TextBox>
                  <br />
                  <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                          Text="Update"> </asp:LinkButton>
                  <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                          Text="Cancel"> </asp:LinkButton>
                </EditItemTemplate>
                <InsertItemTemplate> PayID:
                  <asp:TextBox ID="PayIDTextBox" runat="server" Text='<%# Bind("PayID") %>'> </asp:TextBox>
                  <br />
                  PatientName:
                  <asp:TextBox ID="PatientNameTextBox" runat="server" Text='<%# Bind("PatientName") %>'> </asp:TextBox>
                  <br />
                  Relation:
                  <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>'> </asp:TextBox>
                  <br />
                  RelationName:
                  <asp:TextBox ID="RelationNameTextBox" runat="server" Text='<%# Bind("RelationName") %>'> </asp:TextBox>
                  <br />
                  Age:
                  <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>'> </asp:TextBox>
                  <br />
                  PatientType:
                  <asp:TextBox ID="PatientTypeTextBox" runat="server" Text='<%# Bind("PatientType") %>'> </asp:TextBox>
                  <br />
                  BPHigh:
                  <asp:TextBox ID="BPHighTextBox" runat="server" Text='<%# Bind("BPHigh") %>'> </asp:TextBox>
                  <br />
                  BPLow:
                  <asp:TextBox ID="BPLowTextBox" runat="server" Text='<%# Bind("BPLow") %>'> </asp:TextBox>
                  <br />
                  Pulse:
                  <asp:TextBox ID="PulseTextBox" runat="server" Text='<%# Bind("Pulse") %>'> </asp:TextBox>
                  <br />
                  Temperature:
                  <asp:TextBox ID="TemperatureTextBox" runat="server" Text='<%# Bind("Temperature") %>'> </asp:TextBox>
                  <br />
                  RR:
                  <asp:TextBox ID="RRTextBox" runat="server" Text='<%# Bind("RR") %>'> </asp:TextBox>
                  <br />
                  StreetAddress:
                  <asp:TextBox ID="StreetAddressTextBox" runat="server" Text='<%# Bind("StreetAddress") %>'> </asp:TextBox>
                  <br />
                  HomePhone:
                  <asp:TextBox ID="HomePhoneTextBox" runat="server" Text='<%# Bind("HomePhone") %>'> </asp:TextBox>
                  <br />
                  MobilePhone:
                  <asp:TextBox ID="MobilePhoneTextBox" runat="server" Text='<%# Bind("MobilePhone") %>'> </asp:TextBox>
                  <br />
                  CNIC:
                  <asp:TextBox ID="CNICTextBox" runat="server" Text='<%# Bind("CNIC") %>'> </asp:TextBox>
                  <br />
                  Year:
                  <asp:TextBox ID="YearTextBox" runat="server" Text='<%# Bind("Year") %>'> </asp:TextBox>
                  <br />
                  AgeType:
                  <asp:TextBox ID="AgeTypeTextBox" runat="server" Text='<%# Bind("AgeType") %>'> </asp:TextBox>
                  <br />
                  <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                          Text="Insert"> </asp:LinkButton>
                  <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                          Text="Cancel"> </asp:LinkButton>
                </InsertItemTemplate>
                <ItemTemplate> 
                    <br />
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="patientinfo_border">
                        <!--DWLayoutTable-->
                        <tr>
                            <td width="12" rowspan="3" valign="top">
                                <img src="images1/img_spacer.gif" width="10" height="2" /></td>
                            <td colspan="2" valign="middle"  style="height: 32px">
                                Patient Name : &nbsp; &nbsp;<asp:Label ID="PatientNameLabel" runat="server" ForeColor="Navy" Text='<%# Bind("PatientName") %>'></asp:Label>
                                <asp:Label ID="RelationLabel" runat="server" Text='<%# Bind("Relation", "{0}") %>'></asp:Label>
                                &nbsp;&nbsp;
                  <asp:Label ID="RelationNameLabel" runat="server" ForeColor="Navy" Text='<%# Bind("RelationName", "{0}") %>'></asp:Label></td>
                            <td width="308" align="right" valign="middle"  style="height: 32px">
                                Age :
                                <asp:Label ID="AgeLabel" runat="server" ForeColor="Red" Text='<%# Bind("Age") %>'></asp:Label>
                                &nbsp;<span class="style1">|</span> &nbsp;BP :
                                <asp:Label ID="BPHighLabel" runat="server" ForeColor="Red" Text='<%# Bind("BPHigh") %>'></asp:Label>
                                /
                  <asp:Label ID="BPLowLabel" runat="server" ForeColor="Red" Text='<%# Bind("BPLow") %>'></asp:Label>
                                <span class="style1">|</span> &nbsp;Pulse :<asp:Label ID="PulseLabel" runat="server" ForeColor="Red" Text='<%# Bind("Pulse") %>'></asp:Label>                            </td>
                            <td width="10" rowspan="3" valign="top">
                                <img src="images1/img_spacer.gif" width="10" height="2" /></td>
                        </tr>
                        <tr>
                            <td width="349" height="22" valign="middle" class="title_bg">
                                <span ></span></td>
                            <td width="236" align="center" valign="middle" class="title_bg">
                                <span ></span></td>
                            <td align="right" valign="middle" class="title_bg">
                                <span >Temp :<asp:Label ID="TemperatureLabel" runat="server" ForeColor="Red" Text='<%# Bind("Temperature") %>'></asp:Label>
                  &nbsp; </span><span class="style2">&nbsp;<span class="style1">|</span> &nbsp;</span><span >RR :
                                        <asp:Label ID="RRLabel" runat="server" ForeColor="Red" Text='<%# Bind("RR") %>'></asp:Label><strong>
                      /per min.</strong></span></td>
                        </tr>
                        <tr>
                            <td height="13">                            </td>
                            <td>                            </td>
                            <td>                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
              </asp:FormView>                </td>
          </tr>
          <tr>
            <td height="13" align="right" valign="top"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
          </tr>
          <tr>
            <td height="8"></td>
            </tr>
          <tr>
            <td height="136" valign="top"><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  Width="100%" DataSourceID="SqlDataSourceMedcine1">
                <FooterStyle CssClass="GridPager" />            
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />            
              <AlternatingRowStyle CssClass="GridAltItem" />
                <Columns>
                    <asp:BoundField DataField="MGName" HeaderText="MGName" ReadOnly="True" SortExpression="MGName" >
                        <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" >
                        <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    <asp:BoundField DataField="Doctor" HeaderText="Doctor" ReadOnly="True" SortExpression="Doctor" >
                        <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    <asp:BoundField DataField="Dosage" HeaderText="Dosage" SortExpression="Dosage" >
                        <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    <asp:BoundField DataField="days" HeaderText="days" SortExpression="days" >
                        <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    <asp:TemplateField HeaderText="QTY">
                        <ItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Width="43px"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1"
                                ErrorMessage="RegularExpressionValidator" ValidationExpression="\d{1,3}">*</asp:RegularExpressionValidator>
                            <asp:HiddenField ID="HiddenField_MedCod" runat="server" Value='<%# Eval("Med_Code", "{0}") %>' />
                        </ItemTemplate>
                        <ControlStyle CssClass="activeinside" />
                        <HeaderStyle CssClass="GridHeader" />
                    </asp:TemplateField>
                </Columns>
                        </asp:GridView>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            </td>
            </tr>
          
          
          
          
          
          
          
          <tr>
            <td height="68" align="center" valign="top"><asp:Button CssClass="bt1up" ID="Button1" runat="server" Text="Save"  OnClick="Button1_Click"   />
                <asp:SqlDataSource ID="SqlDataSourceMedcine1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="pt_Select_Medicine_Prescription_1" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Hidden_Registration" Name="RegNo" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="Hidden_yearlyNo" Name="YearlyNo" PropertyName="Value"
                            Type="Decimal" />
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_status_close" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    InsertCommand="status_close" InsertCommandType="StoredProcedure" SelectCommand="status_close"
                    SelectCommandType="StoredProcedure" UpdateCommand="RequestStatus_Close" UpdateCommandType="StoredProcedure">
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="Hidden_Registration" Name="RegNo" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="Hidden_yearlyNo" Name="PayID" PropertyName="Value"
                            Type="Decimal" />
                        <asp:Parameter DefaultValue="6" Name="SendingDept" Type="Int32" />
                        <asp:Parameter DefaultValue="4" Name="Request_Type" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Hidden_Registration" Name="Reg_No" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="Hidden_yearlyNo" Name="yearly_no" PropertyName="Value"
                            Type="Int32" />
                        <asp:Parameter DefaultValue="1" Name="to_sub_Dept" Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="Hidden_Registration" Name="Reg_No" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="Hidden_yearlyNo" Name="yearly_no" PropertyName="Value"
                            Type="Int32" />
                        <asp:Parameter DefaultValue="2" Name="to_sub_Dept" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_sub" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    InsertCommand="pharmacy_sub_insertion_new" InsertCommandType="StoredProcedure"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenField_MainId" Name="pid" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_mCode" Name="MedCode" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_Qty" Name="quantity" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_dilivered" Name="delivered" PropertyName="Value" />
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>            </td>
          </tr>
          <tr>
            <td valign="top" style="height: 102px"><span ></span> 
              <asp:HiddenField ID="Hidden_Registration" runat="server" />
              <asp:HiddenField ID="Hidden_yearlyNo" runat="server" /><asp:HiddenField ID="HiddenField_empID" runat="server" />
                <asp:HiddenField ID="HiddenField_Department_ID" runat="server" />
              <asp:SqlDataSource ID="patient_detail" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  SelectCommand="pt_basic_info" SelectCommandType="StoredProcedure">
                <SelectParameters>
                  <asp:ControlParameter ControlID="Hidden_Registration" Name="regno" PropertyName="Value"
                          Type="String" />
                  <asp:ControlParameter ControlID="Hidden_yearlyNo" Name="payid" PropertyName="Value"
                          Type="Int32" />
                </SelectParameters>
              </asp:SqlDataSource><asp:HiddenField ID="HiddenField_MainId" runat="server" />
                <asp:HiddenField ID="HiddenField_Qty" runat="server" />
                <asp:HiddenField ID="HiddenField_dilivered" runat="server" />
                <asp:HiddenField ID="HiddenField_mCode" runat="server" />            </td>
          </tr>
          <tr>
            <td height="38">&nbsp;</td>
          </tr>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td valign="top" class="right_border" style="width: 14px"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
  
  <tr>
    <td height="1"></td>
    <td></td>
    <td style="width: 14px"></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script></form>
</body>
</html>