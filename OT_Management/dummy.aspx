<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dummy.aspx.cs" Inherits="Radiology_dummy" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView_Services" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
            DataKeyNames="ID" DataSourceID="SqlDataSource_Booking_Service" Width="100%">
<RowStyle CssClass="GridItem"></RowStyle>
<Columns>
<asp:BoundField DataField="TB_Name" HeaderText="Name" SortExpression="TB_Name"></asp:BoundField>
<asp:BoundField DataField="TGName" HeaderText="Group Name" SortExpression="TGName"></asp:BoundField>
<asp:CommandField DeleteText="Cancel" ShowDeleteButton="True"></asp:CommandField>
<asp:TemplateField HeaderText="Sample Appointment"><EditItemTemplate>
<asp:TextBox runat="server" id="TextBox1"></asp:TextBox>
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label1" runat="server" __designer:wfdid="w9"></asp:Label> <igsch:webdatechooser id="WebDateChooser1" runat="server" __designer:wfdid="w10"></igsch:webdatechooser> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Take Report"><EditItemTemplate>
<asp:TextBox runat="server" id="TextBox2"></asp:TextBox>
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="Label2" runat="server" __designer:wfdid="w11"></asp:Label> <igsch:webdatechooser id="WebDateChooser1" runat="server" __designer:wfdid="w12"></igsch:webdatechooser>
</ItemTemplate>
</asp:TemplateField>
</Columns>

<HeaderStyle CssClass="GridHeader"></HeaderStyle>

<AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
</asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource_Booking_Service" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
            DeleteCommand="DELETE FROM Test_Booking_Services WHERE (ID = @ID)" SelectCommand="SELECT Test_Booking.TB_Name, TestGroup.TGName, Test_Booking_Services.ID, Test_Status.Status FROM Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID WHERE (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Reg_no = @RegNo)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                                    </SelectParameters>
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="GridView_Services" Name="ID" PropertyName="SelectedValue" />
                                    </DeleteParameters>
                                </asp:SqlDataSource>
        &nbsp;</div>
        <asp:Button ID="Button1" runat="server" Text="Save" />
    </form>
</body>
</html>
