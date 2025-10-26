<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatientBasicInfo_Iframe.aspx.vb" Inherits="PatientBasicInfo_Iframe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >


<head runat="server">
    <title>
        </title>
        <link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <form id="form1" runat="server">
    <div>
<asp:FormView ID="FormView2" runat="server" CssClass="text_boxtitle" DataSourceID="patient_detail"
            HorizontalAlign="Left" Width="100%"><EditItemTemplate>
                PayID:
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
<InsertItemTemplate>
                PayID:
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




<TABLE class="patientinfo_border" cellSpacing=0 cellPadding=0 width="100%" border=0>
  <!--DWLayoutTable-->
  <TBODY><TR><TD rowSpan=3><IMG height=2 src="images1/img_spacer.gif" width=10 /></TD><TD height="15" colSpan=2 align=left vAlign=middle ><asp:Label id="PatientNameLabel" runat="server" CssClass="text_nameheading" ForeColor="Transparent" Text='<%# Bind("prefix", "{0}") %>'></asp:Label>&nbsp;&nbsp;<asp:Label id="RelationLabel" runat="server"  Text='<%# Bind("Relation", "{0}") %>'></asp:Label>&nbsp;&nbsp;<asp:Label id="RelationNameLabel" runat="server" ForeColor="Transparent" Text='<%# Bind("RelationName", "{0}") %>'></asp:Label> &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; Gender : <asp:Label id="LabelGender" runat="server"  ForeColor="Transparent" Text='<%# Eval("Gender", "{0}") %>'></asp:Label></TD><TD colspan="2" align=right vAlign=middle  style="text-align: left">Registration No: &nbsp;<asp:Label id="RegistrationNo" runat="server"  ForeColor="Transparent" Text='<%# Eval("RegNo") %>'></asp:Label></TD><TD vAlign=top width=10 rowSpan=3>
    &nbsp;<IMG height=2 src="images1/img_spacer.gif" width=10 /></TD></TR><TR><TD width="772" height="15" align=left vAlign=middle class="title_bg" style="height: 16px"><SPAN >Age : <asp:Label id="AgeLabel" runat="server"  ForeColor="Transparent" Text='<%# Bind("Age") %>' ></asp:Label> &nbsp; &nbsp;Date of Birth : &nbsp;<asp:Label id="LabelDateofBirth" runat="server"  ForeColor="Transparent" Text='<%# Eval("DateOfBirth") %>' ></asp:Label>
    </SPAN></TD><TD colspan="2" align=left vAlign=middle class="title_bg" style="HEIGHT: 16px; text-align: left;"><SPAN >Diagnosis :&nbsp;
        <asp:Label ID="Label_Diagnosis"
        runat="server" Font-Bold="False" Text='<%# Bind("Diagonosis", "{0}") %>' Width="169px" Visible="False"></asp:Label>
    &nbsp; &nbsp;</SPAN></TD>
    <TD width="292" align=right vAlign=middle  class="title_bg"><SPAN > </SPAN><SPAN >Weight :
    <asp:Label ID="Label_Weight" runat="server" Font-Bold="False" ></asp:Label>
    </SPAN></TD>
    </TR><TR>
    <td colspan="2"  style="text-align: left; height: 16px;">
    <asp:Label ID="Label_Address" runat="server" Text='<%# Bind("Address", "{0}") %>'
         Font-Bold="False" Visible="False"></asp:Label>&nbsp;    </td>
    <TD colspan="2"  style="height: 16px" >
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    </TD></TR>
    <tr>
      <td height="1"></td>
      <td></td>
      <td width="130"></td>
      <td width="156"></td>
      <td></td>
      <td></td>
    </tr>
</TBODY></TABLE>
    <asp:HiddenField ID="HiddenField_Pfname" runat="server" Value='<%# Bind("pfname", "{0}") %>' />
    <asp:HiddenField ID="HiddenField_Pmname" runat="server" Value='<%# Bind("pmname", "{0}") %>' />




</ItemTemplate>
</asp:FormView>
    </div>
        <asp:SqlDataSource ID="patient_detail" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
            SelectCommand="pt_basic_info" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_regNo" Name="regno" PropertyName="Value"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_Payis" Name="payid" PropertyName="Value"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_regNo" runat="server" />
        <asp:HiddenField ID="HiddenField_Payis" runat="server" />
    </form>
</body>
</html>
