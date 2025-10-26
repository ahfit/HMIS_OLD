<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatientBasicInfo_Iframe.aspx.vb" Inherits="PatientBasicInfo_Iframe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head runat="server">
    
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
<TABLE class="patientinfo_border" cellSpacing=0 cellPadding=0 width="100%" border=0><!--DWLayoutTable--><TBODY><TR><TD rowSpan=3><IMG height=2 src="images1/img_spacer.gif" width=10 /></TD><TD  vAlign=middle align=left colSpan=2><asp:Label id="PatientNameLabel" runat="server" CssClass="text_nameheading" ForeColor="Transparent" Text='<%# Bind("PatientName") %>'></asp:Label>&nbsp;&nbsp;<asp:Label id="RelationLabel" runat="server"  Text='<%# Bind("Relation", "{0}") %>'></asp:Label>&nbsp;&nbsp;<asp:Label id="RelationNameLabel" runat="server" ForeColor="Transparent" Text='<%# Bind("RelationName", "{0}") %>'></asp:Label> &nbsp; &nbsp; &nbsp;&nbsp; Gender : <asp:Label id="LabelGender" runat="server"  ForeColor="Transparent" Text='<%# Eval("SexDescription") %>'></asp:Label></TD><TD  vAlign=middle align=right>Age : <asp:Label id="AgeLabel" runat="server"  ForeColor="Transparent" Text='<%# Bind("Age") %>'></asp:Label> &nbsp;<SPAN class="style1">|</SPAN> &nbsp;BP : <asp:Label id="BPHighLabel" runat="server"  ForeColor="Transparent" Text='<%# Bind("BPHigh") %>'></asp:Label> / <asp:Label id="BPLowLabel" runat="server"  ForeColor="Transparent" Text='<%# Bind("BPLow") %>'></asp:Label> <SPAN class="style1">|&nbsp; </SPAN>&nbsp;Pulse :<asp:Label id="PulseLabel" runat="server"  ForeColor="Transparent" Text='<%# Bind("Pulse") %>'></asp:Label> </TD><TD vAlign=top width=10 rowSpan=3><IMG height=2 src="images1/img_spacer.gif" width=10 /></TD></TR><TR><TD class="title_bg" vAlign=middle align=left><SPAN >Registration No: <asp:Label id="RegistrationNo" runat="server"  ForeColor="Transparent" Text='<%# Eval("RegNo") %>'></asp:Label></SPAN></TD><TD style="WIDTH: 338px; HEIGHT: 32px" class="title_bg" vAlign=middle align=left><SPAN >&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Date of Birth : &nbsp;<asp:Label id="LabelDateofBirth" runat="server"  ForeColor="Transparent" Text='<%# Eval("DateOfBirth") %>'></asp:Label>&nbsp;</SPAN></TD><TD style="HEIGHT: 32px" class="title_bg" vAlign=middle align=right><SPAN >Temp :<asp:Label id="TemperatureLabel" runat="server"  ForeColor="Transparent" Text='<%# Bind("Temperature") %>'></asp:Label> &nbsp; </SPAN><SPAN class="style2">&nbsp;<SPAN class="style1">|</SPAN> &nbsp;</SPAN><SPAN >RR : <asp:Label id="RRLabel" runat="server"  ForeColor="Transparent" Text='<%# Bind("RR") %>'></asp:Label><STRONG> /per min.</STRONG></SPAN></TD></TR><TR><TD style="WIDTH: 305px" height=13></TD><TD></TD><TD></TD></TR></TBODY></TABLE>
</ItemTemplate>
</asp:FormView>
    </div>
        <asp:SqlDataSource ID="patient_detail" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            SelectCommand="pt_basic_info" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:LGHConnectionString1.ProviderName %>">
            <SelectParameters>
                <asp:SessionParameter Name="regno" SessionField="registrationNo" Type="String" />
                <asp:SessionParameter Name="payid" SessionField="YearlyNo" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
