<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Leave_Type.aspx.vb" Inherits="Leave_Type" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>

    <div class="bxmain inner_content" style="width: 100%">
        <div>
            <h2><span>Add Leave Type</span></h2>
        </div>
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right" width="40%">Type Name :</td>
                <td width="60%">
                    <asp:TextBox ID="TextBox_Type_Name"  runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">Leave Abb :</td>
                <td width="60%">
                    <asp:TextBox ID="txtAbb" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr style="display:none">
                <td align="right" style="height: 18px">Encashment :</td>
                <td style="height: 18px">
                    <asp:RadioButtonList ID="RadioButtonList_Encashment" runat="server"
                        RepeatDirection="Horizontal" RepeatLayout="flow">
                        <asp:ListItem Selected="True" Value="true">Yes</asp:ListItem>
                        <asp:ListItem Value="false">No</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr style="display:none">
                <td align="right">Gender :</td>
                <td>
                    <asp:RadioButtonList ID="RadioButtonList_Gender" runat="server" RepeatLayout="flow"
                        RepeatDirection="Horizontal">
                        <asp:ListItem  Value="1">Male</asp:ListItem>
                        <asp:ListItem Value="2">Female</asp:ListItem>
                        <asp:ListItem Value="3" Selected="True">Both</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr  style="display:none">
                <td align="right">Carries Forward : </td>
                <td>
                    <asp:RadioButtonList ID="RadioButtonList_Carries_Forward" runat="server" RepeatLayout="flow"
                        RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="true">Yes</asp:ListItem>
                        <asp:ListItem Value="false">No</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="right">Description : </td>
                <td>
                    <asp:TextBox ID="TextBox_Description" runat="server" Width="70%"
                        CssClass="input_txt" Height="65px" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right"></td>
                <td></td>
            </tr>
            <tr>
                <td align="right"></td>
                <td>
                    <asp:Button ID="Button_Save" runat="server" Text="Save" />
                    <asp:Button ID="Button_Cancel" runat="server" Text="Cancel" Visible="False" />
                    <asp:Label ID="Label3" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <br />



    <asp:SqlDataSource ID="SqlDataSource_Leave_Type" runat="server"
        ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        DeleteCommand="DELETE FROM [Leave_Types] WHERE [Leave_Type_Id] = @Leave_Type_Id"
        InsertCommand="INSERT INTO [Leave_Types] ( [Leave_Type_Name], [Encashment], [Gender_ID], [Carries_Forward], [Description],leave_abb) VALUES (@Leave_Type_Name, @Encashment, @Gender_ID, @Carries_Forward, @Description,@leave_abb)"
        SelectCommand="SELECT Leave_Types.Leave_Type_Id, Leave_Types.Leave_Type_Name, Leave_Types.Encashment, Leave_Types.Gender_ID, Leave_Types.Carries_Forward, Leave_Types.Description, Gender.Gender, Leave_Types.leave_abb FROM Leave_Types INNER JOIN Gender ON Leave_Types.Gender_ID = Gender.Gender_ID"
        UpdateCommand="UPDATE Leave_Types SET Leave_Type_Name = @Leave_Type_Name, Encashment = @Encashment, Gender_ID = @Gender_ID, Carries_Forward = @Carries_Forward, Description = @Description, leave_abb = @leave_abb WHERE (Leave_Type_Id = @Leave_Type_Id)">
        <DeleteParameters>
            <asp:Parameter Name="Leave_Type_Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>

            <asp:ControlParameter ControlID="TextBox_Type_Name" Name="Leave_Type_Name"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="RadioButtonList_Encashment" Name="Encashment"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="RadioButtonList_Gender" Name="Gender_ID"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="RadioButtonList_Carries_Forward"
                Name="Carries_Forward" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBox_Description" Name="Description"
                PropertyName="Text" />
            <asp:Parameter Name="Leave_Type_Id" />
            <asp:ControlParameter ControlID="txtAbb" Name="leave_abb" PropertyName="Text" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Type_Name" Name="Leave_Type_Name"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="RadioButtonList_Encashment" Name="Encashment"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="RadioButtonList_Gender" Name="Gender_ID"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="RadioButtonList_Carries_Forward"
                Name="Carries_Forward" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBox_Description" Name="Description"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="txtAbb" Name="leave_abb"
                PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False"
        Allowsorting="true" CssClass="Grid_1"
        DataKeyNames="Leave_Type_Id"
        DataSourceID="SqlDataSource_Leave_Type" Width="100%">
        <Columns>
            
            <asp:TemplateField>
                <ItemTemplate>
                    <%#Container.DataItemIndex + 1%>
                    <asp:HiddenField ID="HiddenField_Type_id" runat="server"
                        Value='<%# Eval("Leave_Type_Id") %>' />
                    <asp:HiddenField ID="HiddenField_Abb" runat="server" Value='<%# Eval("leave_abb") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Type Name" SortExpression="Leave_Type_Name">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server"
                        Text='<%# Bind("Leave_Type_Name", "{0}") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Leave_Type_Name") %>'></asp:Label>
                    <asp:HiddenField ID="HF_TypeName" runat="server"
                        Value='<%# Eval("Leave_Type_Name") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="leave_abb" HeaderText="abbrvation" SortExpression="leave_abb" />
            <asp:TemplateField Visible="false" HeaderText="Encashment" SortExpression="Encashment">
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Encashment") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="Chk_Encash" runat="server" Checked='<%# Bind("Encashment") %>'
                        Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  Visible="false" HeaderText="Carries Forward" SortExpression="Carries_Forward">
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("Carries_Forward") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="Chk_CarriesFrd" runat="server" Checked='<%# Bind("Carries_Forward") %>'
                        Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  Visible="false" HeaderText="Gender" SortExpression="Gender">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server"
                        SelectedValue='<%# Bind("Gender_ID") %>' Width="100px"
                        DataSourceID="SqlDataSource1" DataTextField="Gender" DataValueField="Gender_ID">
                        <asp:ListItem Value="1">Male</asp:ListItem>
                        <asp:ListItem Value="2">Female</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                        ConnectionString="<%$ ConnectionStrings:UVAS_HRConnectionString %>"
                        SelectCommand="SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                    <asp:HiddenField ID="HF_Gender_ID" runat="server" Value='<%# Eval("Gender_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                <EditItemTemplate>
                    <asp:TextBox ID="txt_DEsc" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lbl_Desc" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                    <asp:HiddenField ID="HF_Description" runat="server"
                        Value='<%# Eval("Description") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField Visible="False" ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/images/deletebtn.png"
                        OnClientClick="return confirm('are you sure you want To delete ?');" Text="Delete"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="LinkButton_Edit" runat="server" CommandName="select" ImageUrl="~/images/editbtn.png"
                        OnClick="LinkButton_Edit_Click" OnClientClick="return confirm('are you sure you want To Edit ?');"
                        CommandArgument='<%# Eval("Leave_Type_Id") %>'></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="GridItem" />
        <FooterStyle CssClass="GridPager" BorderColor="#C0C0FF" />
        <SelectedRowStyle CssClass="gridselect" BackColor="Cyan" />
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
    <asp:HiddenField ID="HF_Leave_Type" runat="server" />
    <asp:HiddenField ID="HF_LeaveTypeID" runat="server" />
    <asp:HiddenField ID="HF_GenderID" runat="server" />
    <asp:HiddenField ID="HF_CarriesForward" runat="server" />
    <asp:HiddenField ID="HF_Description" runat="server" />
    <asp:HiddenField ID="HiddenField_TypeName" runat="server" />
    <asp:HiddenField ID="HF_Encashment" runat="server" />
    <br />

</asp:Content>
