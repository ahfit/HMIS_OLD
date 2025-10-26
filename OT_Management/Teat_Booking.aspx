<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Teat_Booking.aspx.vb" Inherits="Teat_Booking" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        &nbsp;<table>
            <tr>
                <td style="width: 290px">
                    Main Group :
                    <asp:DropDownList ID="DropDownList_Main_Group" runat="server" AutoPostBack="True"
                        DataSourceID="SqlDataSource_Main_Group" DataTextField="TGName" DataValueField="TGID"
                        Width="192px">
                    </asp:DropDownList>
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 290px">
                    <asp:GridView ID="GridView_Booking" runat="server" AutoGenerateColumns="False" DataKeyNames="TB_ID"
                        DataSourceID="SqlDataSource_Booking">
                        <Columns>
                            <asp:ButtonField CommandName="Select" DataTextField="TB_Name" HeaderText="Test Name " />
                            <asp:TemplateField HeaderText="TB_Name" SortExpression="TB_Name">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TB_Name") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("TB_Name") %>'></asp:Label>
                                    <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" InsertVisible="False" ReadOnly="True"
                                SortExpression="TB_ID" Visible="False" />
                        </Columns>
                    </asp:GridView>
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <asp:GridView ID="GridView_Services" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Booking_Service"
                        Width="264px">
                        <Columns>
                            <asp:BoundField DataField="TB_Name" HeaderText="TB_Name" SortExpression="TB_Name" />
                            <asp:BoundField DataField="TGName" HeaderText="TGName" SortExpression="TGName" />
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td style="width: 290px">
                    <asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        InsertCommand="INsert_Test_Booking_Services" InsertCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT TB_Name, TB_ID FROM Test_Booking WHERE (MG_ID = @MG_ID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Main_Group" Name="MG_ID" PropertyName="SelectedValue" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                            <asp:SessionParameter DefaultValue="" Name="RegNo" SessionField="registrationNo" />
                            <asp:ControlParameter ControlID="HiddenField_TBID" DefaultValue="" Name="TB_ID" PropertyName="Value" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_Main_Group" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT TGID, TGName FROM TestGroup">
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_TBID" runat="server" />
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: center">
                    <asp:Button ID="Button_Save" runat="server" Text="Save All Test" />
                    <asp:SqlDataSource ID="SqlDataSource_Booking_Service" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Booking.TB_Name, TestGroup.TGName FROM Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID WHERE (Test_Booking_Services.YearlyNo = @YearlyNo) AND (Test_Booking_Services.RegNo = @RegNo)">
                        <SelectParameters>
                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 290px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
