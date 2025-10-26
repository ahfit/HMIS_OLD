<%@ page language="VB" autoeventwireup="false" inherits="PatientBasicInfo_Iframe, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >


<head runat="server">
  <link href="images/st_sheet_01.css " rel="stylesheet" type="text/css">
  <link href="images/lgh_003.css" rel="stylesheet" type="text/css">

<style type="text/css">


body{font-family:tahoma; font-size:11px; color:#333; background-color:#e6e6e8; }

.patientinfo_border     { border:0px solid #c6d6e2; border-collapse:collapse; background-color:#FFFFFF; height:48px; }
.patientinfo_border td  { border:0px dashed #dbe5ed; border-collapse:collapse; }

.text_nameheading       {color:#005fbe; font-size:11px; font-weight:bold; font-family:tahoma; }
.text_nameheading2       {color:#005fbe; font-size:11px; font-weight:bold; font-family:tahoma; }

.titname {color:#000; font-size:11px; font-weight:bold; font-family:tahoma; }

.bg {background-image:url(images/info_bg.jpg); background-position:left; background-repeat:no-repeat;}
.divcolor{ color:#b9b9bd;}
</style>

</head>

<body bgcolor="#ffffff">
    <form id="form1" runat="server">
    <div>
<asp:FormView ID="FormView2" runat="server" CssClass="text_boxtitle" DataSourceID="patient_detail"
            HorizontalAlign="Left" Width="95%"><EditItemTemplate>
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



<table style="width:951px; height:50px;" border="0" cellspacing="0" cellpadding="0" class="patientinfo_border bg">
  <tr>
    <td>&nbsp;&nbsp;
    <asp:Label id="PatientNameLabel" runat="server" CssClass="text_nameheading"  Text='<%# Eval("prefix", "{0}") %>'></asp:Label>&nbsp;&nbsp;<asp:Label id="RelationLabel" runat="server"  Text='<%# Bind("Relation", "{0}") %>'></asp:Label>&nbsp;&nbsp;<asp:Label id="RelationNameLabel" runat="server" CssClass="titname"  Text='<%# Eval("RELATIONNAME", "{0}") %>'></asp:Label><span class="divcolor">&nbsp;&nbsp;|&nbsp;&nbsp;</span><strong>Gender :</strong> <asp:Label id="LabelGender" runat="server"  ForeColor="Transparent"  Text='<%# Eval("Gender", "{0}") %>'></asp:Label><span class="divcolor">&nbsp;&nbsp;|&nbsp;&nbsp;</span> <strong>Registration #</strong> <asp:Label id="RegistrationNo" runat="server" CssClass="text_nameheading2" Text='<%# Eval("RegNo") %>'></asp:Label><span class="divcolor">&nbsp;&nbsp;|&nbsp;&nbsp;</span><strong>Age :</strong> <asp:Label id="AgeLabel" runat="server"  ForeColor="Transparent" Text='<%# Bind("Age") %>' ></asp:Label></td></tr>
  <tr>
    <td >&nbsp;&nbsp;&nbsp;<strong>Date of Birth :</strong>
    <asp:Label id="LabelDateofBirth" runat="server"  ForeColor="Transparent" Text='<%# Eval("DateOfBirth") %>' ></asp:Label><span class="divcolor">&nbsp;&nbsp;|&nbsp;&nbsp;</span> <strong>Diagnosis :</strong> <asp:Label ID="Label_Diagnosis" runat="server" Font-Bold="False" Text='<%# Bind("Diagonosis", "{0}") %>'></asp:Label><span class="divcolor">&nbsp;&nbsp;|&nbsp;&nbsp;</span><strong>Weight :</strong> <asp:Label ID="Label_Weight" runat="server" Font-Bold="False" ></asp:Label><span class="divcolor">&nbsp;&nbsp;|&nbsp;&nbsp;</span><strong>Address :</strong> <asp:Label ID="Label_Address" runat="server" Text='<%# Bind("Address", "{0}") %>'
         Font-Bold="False"></asp:Label></td>
  </tr>
</table>


<asp:HiddenField ID="HiddenField_Pfname" runat="server" Value='<%# Eval("pfname", "{0}") %>' />
    <asp:HiddenField ID="HiddenField_Pmname" runat="server" Value='<%# Eval("pmname", "{0}") %>' />

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
