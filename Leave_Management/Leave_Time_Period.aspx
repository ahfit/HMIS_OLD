<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Leave_Time_Period.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Leave_Time_Period" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function backto() {
            history.go(-1);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Leaves Time Period</span></h2>
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right" width="40%">Leave Name :</td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList_Leave_Name" runat="server"
                        DataSourceID="SqlDataSource_Leave_Type_Detail" DataTextField="Leave_Type_Name"
                        DataValueField="Leave_Type_Id" CssClass="drop_down">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Time Period :</td>
                <td>
                    <asp:RadioButtonList ID="RadioButtonList_time_Period" runat="server"
                        RepeatDirection="Horizontal" RepeatLayout="flow">
                        <asp:ListItem Selected="True">Monthly</asp:ListItem>
                        <asp:ListItem>Quarterly</asp:ListItem>
                        <asp:ListItem>Yearly</asp:ListItem>
                        <asp:ListItem>Life</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="right">Max Avail Days :</td>
                <td>
                    <asp:TextBox ID="TextBox_Max_Avail_Days" runat="server" Width="50px"></asp:TextBox>
                </td>
            </tr>
            <tr   style="display:none">
                <td align="right">One time Avail Days : </td>
                <td>
                    <asp:TextBox ID="TextBox_Ontime_Avail_Days" Text="1" runat="server" Width="50px"></asp:TextBox>
                </td>
            </tr>
            <tr  style="display:none">
                <td align="right">Document Required : </td>
                <td>
                    <asp:RadioButtonList ID="RadioButtonList_certificate_Required" runat="server" RepeatLayout="flow"
                        RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                
                <td colspan="2" align="center">
                    <asp:Button ID="Button_Save" CssClass="btn_hacims" runat="server" Text="Save" />
                </td>
            </tr>
        </table>
    </div>
    <br />

    <asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail" runat="server"
        ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        DeleteCommand="DELETE FROM [Leave_Type_Detail] WHERE [Type_Detail_id] = @Type_Detail_id"
        InsertCommand="INSERT INTO Leave_Type_Detail(Leave_Type_id, Pay, Min_Service_Day, Start_Date, Avail_Time_Limit, Rule_Text, Leave_Name) VALUES (@Leave_Type_id, @Pay, @Min_Service_Day, @Start_Date, @Avail_Time_Limit, @Rule_Text,@Leave_Name)"
        SelectCommand="SELECT Leave_Type_Name, Leave_Type_Id FROM Leave_Types"
        UpdateCommand="UPDATE [Leave_Type_Detail] SET [Leave_Type_id] = @Leave_Type_id, [Pay] = @Pay, [Min_Service_Day] = @Min_Service_Day, [Start_Date] = @Start_Date, [Avail_Time_Limit] = @Avail_Time_Limit, [Rule_Text] = @Rule_Text WHERE [Type_Detail_id] = @Type_Detail_id">
        <DeleteParameters>
            <asp:Parameter Name="Type_Detail_id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Leave_Type_id" Type="Int32" />
            <asp:Parameter Name="Pay" Type="String" />
            <asp:Parameter Name="Min_Service_Day" Type="Int32" />
            <asp:Parameter Type="Datetime" Name="Start_Date" />
            <asp:Parameter Name="Avail_Time_Limit" Type="String" />
            <asp:Parameter Name="Rule_Text" Type="String" />
            <asp:Parameter Name="Type_Detail_id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownList_Leave_Type" Name="Leave_Type_id"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_pay" Name="Pay"
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_days" Name="Min_Service_Day"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_date" Type="DateTime"
                Name="Start_Date" PropertyName="Value" />
            <asp:ControlParameter ControlID="TextBox_Avail_Time_Limit"
                Name="Avail_Time_Limit" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_Leave_Rule_Text" Name="Rule_Text"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_Type_Name" Name="Leave_Name"
                PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource_Leave_Time_Period" runat="server"
        ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        DeleteCommand="DELETE FROM [Leave_Detail_Time] WHERE [Leave_TimePeriod_Id] = @Leave_TimePeriod_Id"
        InsertCommand="INSERT INTO Leave_Detail_Time(OneTime_MaxDays, Max_Days, Period_Id, Certificate_Req, Leave_Type_id) VALUES (@OneTime_MaxDays, @Max_Days, @Period_Id, @Certificate_Req, @Leave_Type_id)"
        SelectCommand="SELECT Leave_Detail_Time.OneTime_MaxDays, Leave_Detail_Time.Max_Days, Leave_Detail_Time.Period_Id, Leave_Detail_Time.Certificate_Req, Leave_Detail_Time.Leave_TimePeriod_Id, Leave_Types.Leave_Type_Name, Leave_Types.Leave_Type_Id FROM Leave_Detail_Time INNER JOIN Leave_Types ON Leave_Detail_Time.Leave_Type_id = Leave_Types.Leave_Type_Id"
        UpdateCommand="UPDATE [Leave_Detail_Time] SET [Leave_Type_id] = @Leave_Type_id, [OneTime_MaxDays] = @OneTime_MaxDays, [Max_Days] = @Max_Days, [Period_Id] = @Period_Id, [Certificate_Req] = @Certificate_Req WHERE [Leave_TimePeriod_Id] = @Leave_TimePeriod_Id">
        <DeleteParameters>
            <asp:Parameter Name="Leave_TimePeriod_Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Leave_Type_id" />
            <asp:Parameter Name="OneTime_MaxDays" Type="Int32" />
            <asp:Parameter Name="Max_Days" Type="Int32" />
            <asp:Parameter Name="Period_Id" Type="String" />
            <asp:Parameter Name="Certificate_Req" />
            <asp:Parameter Name="Leave_TimePeriod_Id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Ontime_Avail_Days"
                Name="OneTime_MaxDays" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_Max_Avail_Days" Name="Max_Days"
                PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadioButtonList_time_Period" Name="Period_Id"
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="RadioButtonList_certificate_Required"
                Name="Certificate_Req" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Leave_Name" Name="Leave_Type_id"
                PropertyName="SelectedValue" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        DataKeyNames="Leave_TimePeriod_Id"
        AllowSorting="true"
        DataSourceID="SqlDataSource_Leave_Time_Period" Width="100%"
        AllowPaging="True">
        <Columns>
            <asp:TemplateField HeaderText="Leave Name" SortExpression="Leave_Type_Name">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList_Leave_Name" runat="server"
                        DataSourceID="SqlDataSource_Leave_Type_Detail" DataTextField="Leave_Type_Name"
                        DataValueField="Leave_Type_Id"
                        SelectedValue='<%# Bind("Leave_Type_Id", "{0}") %>' Width="150px">
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Leave_Type_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="OneTime_MaxDays" HeaderText="One Time Max Days"
                SortExpression="OneTime_MaxDays" Visible="false" />
            <asp:BoundField DataField="Max_Days" HeaderText="Max Days"
                SortExpression="Max_Days" />
            <asp:TemplateField HeaderText="Period" SortExpression="Period_Id">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server"
                        SelectedValue='<%# Bind("Period_Id", "{0}") %>' Width="100px">
                        <asp:ListItem>Monthly</asp:ListItem>
                        <asp:ListItem>Quarterly</asp:ListItem>
                        <asp:ListItem>Yearly</asp:ListItem>
                        <asp:ListItem>Life</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Period_Id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CheckBoxField Visible="false" DataField="Certificate_Req"
                HeaderText="Certificate Required" SortExpression="Certificate_Req" />
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <FooterStyle CssClass="GridPager" />
        <SelectedRowStyle CssClass="gridselect" />
        <HeaderStyle CssClass="GridHeader" />
        <EditRowStyle CssClass="gridedit" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
                     <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                    <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                </span>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </ContentTemplate>
            </asp:UpdatePanel>
    <asp:HiddenField ID="HiddenField_date" runat="server" />
    <asp:HiddenField ID="HiddenField_days" runat="server" />
    <br />

</asp:Content>
