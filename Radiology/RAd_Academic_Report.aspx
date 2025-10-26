<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Radiology_RAd_Academic_Report, App_Web_44exovlo" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 405px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="diagnosis_list">
        <tr>
            <td align="right" class="style1">
                Select Group:</td>
            <td>
                <asp:DropDownList ID="DDL_TestGroup" runat="server" DataSourceID="Sql_Group" 
                    DataTextField="TGName" DataValueField="TGID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="Sql_Group" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" SelectCommand="SELECT    0 as  TGID,'---ALL---' as TGName union
SELECT     TGID, TGName
FROM         TestGroup
where TestGroup.Category=1"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                Reference</td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server" TabIndex="1" ></asp:TextBox>
                <asp:HiddenField ID="HiddenField_refer" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                RegNo</td>
            <td>
                <asp:TextBox ID="TextBox2" runat="server" TabIndex="2"></asp:TextBox>
                <asp:HiddenField ID="HiddenField_Regno" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                Yearly #:</td>
            <td>
                <asp:TextBox ID="TextBox_yearlyNo" runat="server" TabIndex="3"></asp:TextBox>
                <asp:HiddenField ID="Hfd_yearly_No" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Show Report" 
                    BackColor="#999966" BorderStyle="Double" Font-Bold="True" TabIndex="4" />
            </td>
        </tr>
        <tr>
            <td align="Left" colspan="2">
                <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource1" 
                    AutoGenerateColumns="False" DataKeyNames="AC_ID" 
                    onprerender="GridView2_PreRender" Width="100%">
                    <Columns>
                      <asp:TemplateField HeaderText="No">
                          <ItemTemplate>
                             <%# Container.DataItemIndex + 1 %>
                          </ItemTemplate>
                      </asp:TemplateField>
                    </Columns>
                    <Columns>
                        <asp:BoundField DataField="AC_ID" HeaderText="AC_ID" InsertVisible="False" 
                            ReadOnly="True" SortExpression="AC_ID" Visible="false" />
                        <asp:BoundField DataField="Main_ID" HeaderText="Main_ID" 
                            SortExpression="Main_ID" Visible="false" />
                        <asp:TemplateField HeaderText="RegNo" SortExpression="RegNo">
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenField_regNo" runat="server" value='<%# Bind("RegNo") %>' />
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("RegNo") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("RegNo") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                         
                        <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" 
                            SortExpression="YearlyNo" />
                        <asp:BoundField DataField="Reference" HeaderText="Reference" 
                            SortExpression="Reference" />
                        <asp:BoundField DataField="TB_Name" HeaderText="TB Name" 
                            SortExpression="TB_Name" />
                        <asp:BoundField DataField="TGName" HeaderText="TG Name" 
                            SortExpression="TGName" />
                        
                        <asp:HyperLinkField DataNavigateUrlFields="Regno,YearlyNo,Main_ID,TGID,TB_ID" 
                            Target="_blank" 
                            DataNavigateUrlFormatString="~/Radiology/Patient_Result_report.aspx?RegNo={0}&amp;YearlyNo={1}&amp;TGID={3}&amp;Main_ID={2}&amp;TB_ID={4}" 
                            Text="View Report" />
                        
                        <asp:BoundField DataField="TGID" HeaderText="TGID" InsertVisible="False" 
                            ReadOnly="True" SortExpression="TGID" Visible="False" />
                        <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" InsertVisible="False" 
                            SortExpression="TB_ID" Visible="False" />
                        
                    </Columns>
                    
                     

                </asp:GridView>
    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
          ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>" 
                    
                    
                    SelectCommand="SELECT Radiology_Academic_Report.AC_ID, Radiology_Academic_Report.Main_ID, Radiology_Academic_Report.RegNo, Radiology_Academic_Report.YearlyNo, Radiology_Academic_Report.Reference, Test_Booking.TB_Name, TestGroup.TGName, TestGroup.TGID, Test_Booking.TB_ID FROM Radiology_Academic_Report INNER JOIN Test_Booking ON Radiology_Academic_Report.TB_ID = Test_Booking.TB_ID INNER JOIN TestGroup ON Radiology_Academic_Report.TGID = TestGroup.TGID WHERE (Radiology_Academic_Report.Reference LIKE @Reference) AND (Radiology_Academic_Report.RegNo LIKE @RegNo) AND (Radiology_Academic_Report.YearlyNo LIKE @YearlyNo) AND (@TGID = 0) OR (Radiology_Academic_Report.Reference LIKE @Reference) AND (Radiology_Academic_Report.RegNo LIKE @RegNo) AND (Radiology_Academic_Report.YearlyNo LIKE @YearlyNo) AND (TestGroup.TGID = @TGID)" >
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_refer" Name="Reference" 
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_Regno" Name="RegNo" 
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="Hfd_yearly_No" Name="YearlyNo" 
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="DDL_TestGroup" Name="TGID" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="Reference" 
                        PropertyName="Text" />
            </UpdateParameters>
                </asp:SqlDataSource>
    
                </td>
        </tr>
    </table>
</asp:Content>

