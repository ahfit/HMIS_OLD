<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Leave_Type_Detail.aspx.vb"
    MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Leave_Type_Detail" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function backto() {
            history.go(-1);
        }



        //$(function () {
        //    debugger;
        //    $('.delete').on('click', function () {
        //        confirm("Are you sure to delete this..!!");
        //    });
        //});

        function confirmationDelete() {
            if (confirm('Are you sure you want to delete Record ?')) {
                return true;
            } else {
                return false;
            }
        }


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%">

        <div>
            <h2><span>Add Leave Detail</span></h2>
        </div>
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right">Institute :
                </td>
                <td>
                    <asp:DropDownList ID="ddlHospital" runat="server" AutoPostBack="True" CssClass="drop_down"
                        DataSourceID="sqlDs_Hospital" DataTextField="Hospital_Name" Width="300px"
                        DataValueField="Hospital_ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_Hospital" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT Hospital_ID, Hospital_Name FROM Hospital"></asp:SqlDataSource>
                </td>

                <td align="right">Leave Type :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Leave_Type" runat="server" DataSourceID="sqlDs_LeaveTypes" CssClass="drop_down" Width="300px"
                        DataTextField="Leave_Type_Name" DataValueField="Leave_Type_Id">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_LeaveTypes" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
                        SelectCommand="SELECT DISTINCT 
                      Leave_Types.Leave_Type_Id, Leave_Types.Leave_Type_Name
FROM         Leave_Types"></asp:SqlDataSource>
                </td>
            </tr>

            <tr style="display: none;">
                <td align="right">Pay :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_pay" CssClass="drop_down" runat="server">
                        <asp:ListItem>Full</asp:ListItem>
                        <asp:ListItem>Half</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="display: none">
                <td align="right">Min Service Day :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_min_Service_Day" Text="0" runat="server" Width="50px"></asp:TextBox>
                    <asp:DropDownList ID="DropDownList_Min_Service_Day" runat="server" Width="250px">
                        <%-- <asp:ListItem>Year</asp:ListItem>
                        <asp:ListItem>Month</asp:ListItem>--%>
                        <asp:ListItem>Day</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="display: none;">
                <td align="right">Start Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser_Start_date" runat="server" CssClass="drop_date">
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr style="display: none;">
                <td align="right">Avail Time Limit :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Avail_Time_Limit" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td align="right">Leave Name :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Type_Name" runat="server" Width="300px"></asp:TextBox>
                </td>

                <td align="right">Maximum Avail Days(Yearly):
                </td>
                <td>
                    <asp:TextBox SkinID="intdata" ID="txtboxAvailDays" runat="server" Width="300px"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td align="right">Forwardable day(s) :
                </td>
                <td>
                    <asp:TextBox ID="Txt_FDays" runat="server" Width="300px" TextMode="Number"></asp:TextBox>
                </td>

                <td align="right">One Time Avail Time :
                </td>
                <td>
                    <asp:TextBox ID="OTAT" runat="server" Width="300px" TextMode="Number"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td align="right">Leave Limit :
                </td>
                <td>
                    <asp:DropDownList ID="LeaveLimit" runat="server" DataSourceID="sqlDs_LeaveLimit" CssClass="drop_down" Width="300px"
                        DataTextField="Tilte" DataValueField="LeaveLimitId">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_LeaveLimit" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
                        SelectCommand="select * from Leave_Limit where isnull(IsActive,0) = 1"></asp:SqlDataSource>
                </td>

                <td align="right">Gender :
                </td>
                <td>
                    <asp:DropDownList ID="Gender" runat="server" DataSourceID="sqlDs_Gender" CssClass="drop_down" Width="300px"
                        DataTextField="Gender" DataValueField="Gender_ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlDs_Gender" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
                        SelectCommand="select * from Gender where Gender_ID <> 3"></asp:SqlDataSource>
                </td>
            </tr>

            <tr>
                <td align="right">Forward :
                </td>
                <td>
                    <asp:RadioButtonList ID="IsFrwd" runat="server" Width="300px" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>

                    </asp:RadioButtonList>
                </td>

                <td align="right">Opening :
                </td>
                <td>
                    <asp:RadioButtonList ID="HasOpening" runat="server" Width="300px" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>

                    </asp:RadioButtonList>
                </td>
            </tr>

            <tr>

                <td align="right">Document Required :
                </td>
                <td>
                    <asp:RadioButtonList ID="IsDocumentRequired" runat="server" Width="300px" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>

                    </asp:RadioButtonList>
                </td>

                <td align="right">Effect on salary :
                </td>
                <td>
                    <asp:RadioButtonList ID="RBT_Salary" runat="server" Width="300px" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>

                    </asp:RadioButtonList>
                </td>

            </tr>

            <tr>
                <td align="right" style="display:none">Has Opening Balance :
                </td>
                <td style="display:none">
                    <asp:RadioButtonList ID="RBT_HasOpening" runat="server" Width="300px" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>

                    </asp:RadioButtonList>
                </td>

                <td align="right">Remarks :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Leave_Rule_Text" runat="server" Width="300px" Height="65px"
                        TextMode="MultiLine"></asp:TextBox>
                </td>

            </tr>

            <tr>
                <td colspan="2" align="right">
                    <asp:Button CssClass="btn_hacims" ID="Button_Save" runat="server" Text="Save"/>
                      <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000"></asp:Label>
                </td>
            </tr>


        </table>
    </div>
    <div class="bxmain inner_content" style="width: 100%">
        <h2>Leave Detail Record</h2>
        <br />
        <asp:SqlDataSource ID="SqlDataSource_Leave_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
            DeleteCommand="DELETE FROM [Leave_Types] WHERE [Leave_Type_Id] = @Leave_Type_Id"
            InsertCommand="INSERT INTO [Leave_Types] ( [Leave_Type_Name], [Encashment], [Gender_ID], [Carries_Forward], [Description]) VALUES (@Leave_Type_Name, @Encashment, @Gender_ID, @Carries_Forward, @Description)"
            SelectCommand="SELECT Leave_Types.Leave_Type_Id, Leave_Types.Leave_Type_Name, Leave_Types.Encashment, Leave_Types.Gender_ID, Leave_Types.Carries_Forward, Leave_Types.Description, Gender.Gender FROM Leave_Types INNER JOIN Gender ON Leave_Types.Gender_ID = Gender.Gender_ID"
            UpdateCommand="UPDATE [Leave_Types] SET [Leave_Type_Name] = @Leave_Type_Name, [Encashment] = @Encashment, [Gender_ID] = @Gender_ID, [Carries_Forward] = @Carries_Forward, [Description] = @Description WHERE [Leave_Type_Id] = @Leave_Type_Id">
            <DeleteParameters>
                <asp:Parameter Name="Leave_Type_Id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Leave_Type_Name" Type="String" />
                <asp:Parameter Name="Encashment" Type="Boolean" />
                <asp:Parameter Name="Gender_ID" Type="Int32" />
                <asp:Parameter Name="Carries_Forward" Type="Boolean" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Leave_Type_Id" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox_Type_Name" Name="Leave_Type_Name" PropertyName="Text" />
                <asp:ControlParameter ControlID="RadioButtonList_Encashment" Name="Encashment" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="RadioButtonList_Gender" Name="Gender_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="RadioButtonList_Carries_Forward" Name="Carries_Forward"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text" />
                <asp:ControlParameter ControlID="LeaveLimit" Name="Leave_Type_Name" PropertyName="Text" />
                <asp:ControlParameter ControlID="OTAT" Name="OneTimeAvailLimit" PropertyName="Text" />
                <asp:ControlParameter ControlID="Gender" Name="Gender" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="IsFrwd" Name="IS_forward" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HasOpening" Name="Has_Opening" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="IsDocumentRequired" Name="IsDocumentRequired" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="RBT_Salary" Name="Salary_Day" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="LeaveLimit" Name="LeaveLimit" PropertyName="SelectedValue" />

            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
            DeleteCommand="DELETE FROM [Leave_Type_Detail] WHERE [Type_Detail_id] = @Type_Detail_id"
            InsertCommand="INSERT INTO Leave_Type_Detail(Leave_Type_id, Pay, Min_Service_Day, Start_Date, Avail_Time_Limit, Rule_Text, Leave_Name, MaximumAvailDays, ForwardableLeave, Salary_Day, Has_Opening, OneTimeAvailLimit, GenderId, LeaveLimit, IsDocumentRequired) VALUES (@Leave_Type_id, @Pay, @Min_Service_Day, @Start_Date, @Avail_Time_Limit, @Rule_Text, @Leave_Name, @AvailDays, @ForwardableLeave, @Salary_Day, @HasOpening, @OneTimeAvailLimit, @GenderId, @LeaveLimit, @IsDocumentRequired)"
            SelectCommand="SELECT LTD.MaximumAvailDays,LTD.Type_Detail_id, LTD.Leave_Type_id, LTD.Pay, LTD.Min_Service_Day, LTD.Start_Date, LTD.Avail_Time_Limit, LTD.Rule_Text, Leave_Types.Leave_Type_Name,
 LTD.Leave_Name,LTD.ForwardableLeave,LTD.ForwardableLeave,Gender,Leave_Limit.Tilte as LeaveLimit, LTD.OneTimeAvailLimit,
 CASE LTD.IsDocumentRequired 
    WHEN 0 THEN 'No'
    WHEN 1 THEN 'Yes'
END As IsDocumentRequired,
 CASE LTD.IS_forward 
    WHEN 0 THEN 'No'
    WHEN 1 THEN 'Yes'
END As IS_forward ,
 CASE LTD.Has_Opening 
    WHEN 0 THEN 'No'
    WHEN 1 THEN 'Yes'
END As Has_Opening,
 CASE LTD.Salary_Day 
    WHEN 0 THEN 'No'
    WHEN 1 THEN 'Yes'
END As Salary_Day 
 FROM Leave_Type_Detail as LTD  
INNER JOIN Leave_Types ON LTD.Leave_Type_id = Leave_Types.Leave_Type_Id
INNER JOIN Gender ON Gender.Gender_ID = LTD.GenderId
Left JOIN Leave_Limit ON Leave_Limit.LeaveLimitId = LTD.LeaveLimit"
            UpdateCommand="UPDATE [Leave_Type_Detail] SET MaximumAvailDays=@MaximumAvailDays, [Leave_Type_id] = @Leave_Type_id, [Pay] = @Pay, [Min_Service_Day] = @Min_Service_Day, [Start_Date] = @Start_Date, [Avail_Time_Limit] = @Avail_Time_Limit, [Rule_Text] = @Rule_Text WHERE [Type_Detail_id] = @Type_Detail_id">
            <DeleteParameters>
                <asp:Parameter Name="Type_Detail_id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>   
                <asp:Parameter Name="Leave_Type_Id" Type="Int32" />
                 <asp:Parameter Name="Type_Detail_id" Type="Int32" />
                 <asp:Parameter Name="AvailDays" Type="Int32" />
                <asp:Parameter  Name="Pay" Type="String" />
                <asp:Parameter Name="Min_Service_Day"  Type="Int32" />
                <asp:Parameter  Type="DateTime" Name="Start_Date"/>
                <asp:Parameter  Name="Avail_Time_Limit"  Type="String" />
                <asp:Parameter  Name="Rule_Text"  Type="String" />
                <asp:Parameter  Name="Leave_Name" />
                <asp:Parameter Name="ForwardableLeave"  />
                 <asp:Parameter Name="MaximumAvailDays"  />
                <asp:Parameter Name="Leave_Type_Name"  />
                <asp:Parameter  Name="OneTimeAvailLimit"  />
                <asp:Parameter  Name="Gender"  />
                <asp:Parameter  Name="HasOpening"  />
                <asp:Parameter  Name="GenderId"/>
                <asp:Parameter  Name="LeaveLimit"  />
                <asp:Parameter  Name="IsDocumentRequired"  />
                 <asp:Parameter  Name="Salary_Day"  />
                <asp:Parameter  Name="IsFrwd" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="txtboxAvailDays" Name="AvailDays" PropertyName="Text"
                    Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_Leave_Type" Name="Leave_Type_id" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_pay" Name="Pay" PropertyName="SelectedValue"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_days" Name="Min_Service_Day" PropertyName="Value"
                    Type="Int32" />
                <asp:ControlParameter ControlID="HiddenField_date" Type="DateTime" Name="Start_Date"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="TextBox_Avail_Time_Limit" Name="Avail_Time_Limit"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox_Leave_Rule_Text" Name="Rule_Text" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Type_Name" Name="Leave_Name" PropertyName="Text" />
                <asp:ControlParameter ControlID="Txt_FDays" Name="ForwardableLeave" PropertyName="Text" />

                <asp:ControlParameter ControlID="LeaveLimit" Name="Leave_Type_Name" PropertyName="Text" />
                <asp:ControlParameter ControlID="OTAT" Name="OneTimeAvailLimit" PropertyName="Text" />
                <asp:ControlParameter ControlID="Gender" Name="Gender" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HasOpening" Name="HasOpening" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="Gender" Name="GenderId" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="LeaveLimit" Name="LeaveLimit" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="IsDocumentRequired" Name="IsDocumentRequired" PropertyName="SelectedValue" />
               <asp:ControlParameter ControlID="RBT_Salary" Name="Salary_Day" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="IsFrwd" Name="IsFrwd" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
       <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">--%>
            <%--<ContentTemplate>--%>
                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataKeyNames="Type_Detail_id" CssClass="Grid_1"
                    DataSourceID="SqlDataSource_Leave_Type_Detail" Width="100%" AllowPaging="True">
                    <Columns>
                        <asp:TemplateField HeaderText="Type Name" SortExpression="Leave_Type_Name">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList_Leave_Type" runat="server" DataSourceID="SqlDataSource_Leave_Type"
                                    DataTextField="Leave_Type_Name" DataValueField="Leave_Type_Id" SelectedValue='<%# Bind("Leave_Type_ID") %>'
                                    Width="150px">
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Leave_Type_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <ControlStyle Width="150px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Leave_Name" HeaderText="Leave Name" SortExpression="Leave_Name">
                            <ControlStyle Width="150px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="MaximumAvailDays" HeaderText="Maximum Avail Days" SortExpression="Min_Service_Day" />
                        <asp:BoundField DataField="ForwardableLeave" HeaderText="Forwardable Leaves" SortExpression="ForwardableLeave" />
                        <asp:BoundField DataField="Min_Service_Day" Visible="false" HeaderText="Service Day" SortExpression="Min_Service_Day">
                            <ControlStyle Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Start_Date" Visible="false" HeaderText="Start Date" SortExpression="Start_Date">
                            <ControlStyle Width="60px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Avail_Time_Limit" Visible="false" HeaderText="Avail Limit" SortExpression="Avail_Time_Limit">
                            <ControlStyle Width="70px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Rule_Text" HeaderText="Remarks" SortExpression="Rule_Text">
                            <ControlStyle Width="200px" />
                        </asp:BoundField>

                         <asp:BoundField DataField="Has_Opening" HeaderText="Opening" SortExpression="Has_Opening">
                            <ControlStyle Width="200px" />
                        </asp:BoundField>

                         <asp:BoundField DataField="IS_forward" HeaderText="forward" SortExpression="IS_forward">
                            <ControlStyle Width="200px" />
                        </asp:BoundField>

                          <asp:BoundField DataField="Salary_Day" HeaderText="Effect on salary" SortExpression="Salary_Day">
                            <ControlStyle Width="200px" />
                        </asp:BoundField>

                        <asp:BoundField DataField="OneTimeAvailLimit" HeaderText="One Time Avail Limit" SortExpression="OneTimeAvailLimit">
                            <ControlStyle Width="200px" />
                        </asp:BoundField>
                                                <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Rule_Text">
                            <ControlStyle Width="200px" />
                        </asp:BoundField>
                          <asp:BoundField DataField="LeaveLimit" HeaderText="Leave Limit" SortExpression="LeaveLimit">
                            <ControlStyle Width="200px" />
                        </asp:BoundField>

                          <asp:BoundField DataField="IsDocumentRequired" HeaderText="Document Required" SortExpression="IsDocumentRequired">
                            <ControlStyle Width="200px" />
                        </asp:BoundField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnk_UpdateRecord" runat="server" Text="Update" CommandArgument='<%#Eval("Type_Detail_id") %>'
                                    OnClick="lnk_UpdateRecord_Click"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                          <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnk_DeleteRecord" CssClass="delete" runat="server" Text="Delete" CommandArgument='<%#Eval("Type_Detail_id") %>'
                                    onclick="lnk_DeleteRecord_Click" OnClientClick="return confirmationDelete();"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/images/cancelbtn.png" EditImageUrl="~/images/editbtn.png" Visible="false" />
                        <asp:CommandField ShowDeleteButton="True" ButtonType="Image" DeleteImageUrl="~/images/deletebtn.png" Visible="false"  />

                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <FooterStyle CssClass="GridPager" />
                    <SelectedRowStyle CssClass="gridselect" />
                    <HeaderStyle CssClass="GridHeader" />
                    <EditRowStyle CssClass="gridedit" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
           <%-- </ContentTemplate>--%>
       <%-- </asp:UpdatePanel>--%>
        <asp:HiddenField ID="HiddenField_date" runat="server" />
        <asp:HiddenField ID="HiddenField_days" runat="server" />
         <asp:HiddenField ID="HiddenField_ID" runat="server" />
        <br />
    </div>
</asp:Content>
