<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Assign_phy_Group_to_Heading, App_Web_0xn5azrs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1"
            onclick="return TABLE1_onclick()">
            <tr>
                <td align="right">
                    Template :
                </td>
                <td>
                    <asp:DropDownList ID="ddlTemplates" runat="server" AutoPostBack="true">
                    </asp:DropDownList>
                </td>
            </tr>            
            <tr>
                <td align="right" style="height: 18px">
                    Main Heading :&nbsp;
                </td>
                <td style="height: 18px">
                    <asp:TextBox ID="TextBoxMH" runat="server"></asp:TextBox>                    
                </td>
            </tr>
            <tr>
             <td align="right">
             Priority
                </td>
                <td><asp:TextBox ID="TextBox_Priority" runat="server" Width="50px" ></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right" style="height: 18px">
                </td>
                <td style="height: 18px">
                    
                    <asp:Button ID="ButtonSave" runat="server" Text="Save" />
                    <asp:Button ID="Button_Cancel" runat="server" Text="Cancel" Visible="False" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:SqlDataSource ID="SqlDataSourceMH" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                        InsertCommand="INSERT INTO Admin_Exam_Main_Heading(MH_Heading,Priority, TemplateId) VALUES (@MH_Heading,@Priority, @TemplateId)"
                        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                        SelectCommand="SELECT Admin_Exam_Main_Heading.MH_Heading,  Admin_Exam_Main_Heading.Priority, Admin_Exam_Main_Heading.MH_Code FROM Admin_Exam_Main_Heading   WHERE (Admin_Exam_Main_Heading.TemplateId = @TemplateId)"
                        DeleteCommand="DELETE FROM Admin_Exam_Main_Heading WHERE (MH_Code = @MH_Code)"
                        UpdateCommand="UPDATE Admin_Exam_Main_Heading SET Priority = @Priority, MH_Heading = @MH_Heading WHERE (MH_Code = @MH_Code)">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="TextBoxMH" Name="MH_Heading" PropertyName="Text" />
                            <asp:ControlParameter ControlID="TextBox_Priority" Name="Priority" PropertyName="Text" />
                            <asp:ControlParameter ControlID="ddlTemplates" Name="TemplateId" PropertyName="SelectedValue" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlTemplates" Name="TemplateId" PropertyName="SelectedValue" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:ControlParameter ControlID="GridViewMain_Heading" Name="MH_Code" PropertyName="SelectedValue" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="TextBoxPriority" Name="Priority" PropertyName="Text" />
                            <asp:ControlParameter ControlID="HiddenFieldMH" Name="MH_Heading" PropertyName="Value" />
                            <asp:ControlParameter ControlID="GridViewMain_Heading" Name="MH_Code" PropertyName="SelectedValue" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    
                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="Select_Dept" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenFieldPriority_Heading" runat="server" />
                    <asp:HiddenField ID="HiddenFieldMain_Heading" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <br />
                    <asp:GridView ID="GridViewMain_Heading" runat="server" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSourceMH" Width="100%" AllowPaging="True" DataKeyNames="MH_Code"
                        PageSize="5">
                        <Columns>
                            <asp:BoundField DataField="MH_Heading" HeaderText="Main Heading" SortExpression="MH_Heading" />
                            <%-- <asp:BoundField DataField="Template_Name" HeaderText="Template Name" SortExpression="Template_Name" />--%>
                            <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />
                            <asp:BoundField DataField="MH_Code" HeaderText="Main Code" InsertVisible="False"
                                SortExpression="MH_Code" />                            
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif"
                                        ToolTip="Update" />&nbsp;<asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel"
                                            ImageUrl="~/images_hacims/icon_err.gif" ToolTip="Cancel" />&nbsp;
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Select" ImageUrl="~/images_hacims/icon_edit.gif"
                                        ToolTip="Edit" OnClientClick="return confirmation_edit(this)" />&nbsp;<asp:ImageButton
                                            ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"
                                            ToolTip="Delete" OnClientClick="return confirmation(this)" />&nbsp;
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="2" valign="top">
                    <strong class="err">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Assign Physical Examination Group</strong>
                    to Heading
                </td>
            </tr>
            <tr>
                <td align="right">
                    Template :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListNew" runat="server" AutoPostBack="true">
                    </asp:DropDownList>
                </td>
                
            </tr>
            <tr>
                <td align="right">
                    Main Heading :&nbsp;
                </td>
                <td valign="top">
                    <asp:DropDownList ID="DropDownListMH" runat="server" Width="226px" DataSourceID="SqlDataSourceMHDDL"
                        DataTextField="MH_Heading" DataValueField="MH_Code" AutoPostBack="True">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Main Group :&nbsp;
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceMainGroup"
                        DataTextField="MG_Name" DataValueField="MG_Code" Width="226px">
                    </asp:DropDownList>
                    <asp:Button ID="ButtonSaveTemplate" runat="server" Text="Save" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <br />
                    <asp:GridView ID="GridViewExam" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                        DataKeyNames="id" DataSourceID="SqlDataSourceSave" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="MH_Heading" HeaderText="Main Heading" SortExpression="MH_Heading" />
                            <asp:BoundField DataField="MG_Name" HeaderText="Main Group" SortExpression="MG_Name" />
                            <%--<asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />--%>
                            <asp:BoundField DataField="MH_Code" HeaderText="MH_Code" InsertVisible="False" SortExpression="MH_Code"
                                Visible="False" />
                            <asp:BoundField DataField="id" HeaderText="ID" InsertVisible="False" SortExpression="id" />
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif"
                                        ToolTip="Update" />&nbsp;<asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel"
                                            ImageUrl="~/images_hacims/icon_err.gif" ToolTip="Cancel" />&nbsp;
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif"
                                        ToolTip="Edit" OnClientClick="return confirmation_edit(this)" />&nbsp;<asp:ImageButton
                                            ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"
                                            ToolTip="Delete" OnClientClick="return confirmation(this)" />&nbsp;
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td align="right">
                </td>
                <td>
                    <asp:SqlDataSource ID="SqlDataSourceMHDDL" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                        SelectCommand="SELECT MH_Code, MH_Heading FROM Admin_Exam_Main_Heading WHERE (TemplateId = @Template_Id)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListNew" Name="Template_Id" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                        SelectCommand="SELECT MG_Code, MG_Name FROM admin_Phy_Exam_MainGroup&#13;&#10;order by MG_Name">
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceSave" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                        InsertCommand="INSERT INTO Admin_Exam_MainHeading_Group(MH_Code, Mg_Code) VALUES (@MH_Code, @Mg_Code)"
                        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                        DeleteCommand="DELETE FROM Admin_Exam_MainHeading_Group WHERE (id = @id)" SelectCommand="SELECT Admin_Exam_Main_Heading.MH_Heading, admin_Phy_Exam_MainGroup.MG_Name, Admin_Exam_MainHeading_Group.Priority, Admin_Exam_Main_Heading.MH_Code, Admin_Exam_MainHeading_Group.id FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code INNER JOIN admin_Phy_Exam_MainGroup ON Admin_Exam_MainHeading_Group.Mg_Code = admin_Phy_Exam_MainGroup.MG_Code WHERE (Admin_Exam_Main_Heading.MH_Code = @MH_Code)"
                        UpdateCommand="UPDATE Admin_Exam_MainHeading_Group SET Priority = @Priority WHERE (id = @id)">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="DropDownListMH" Name="MH_Code" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DropDownList1" Name="Mg_Code" PropertyName="SelectedValue" />
                        </InsertParameters>
                        <DeleteParameters>
                            <asp:ControlParameter ControlID="GridViewExam" Name="id" PropertyName="SelectedValue" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListMH" Name="MH_Code" PropertyName="SelectedValue" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="HiddenFieldExam_Priority" Name="Priority" PropertyName="Value" />
                            <asp:ControlParameter ControlID="GridViewExam" Name="id" PropertyName="SelectedValue" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenFieldMg_Code" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSourceDelete" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                        DeleteCommand="DELETE FROM Admin_Exam_MainHeading_Group WHERE (MH_Code = @MH_Code) AND (Mg_Code = @Mg_Code)"
                        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                        <DeleteParameters>
                            <asp:ControlParameter ControlID="DropDownListMH" Name="MH_Code" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="HiddenFieldMg_Code" Name="Mg_Code" PropertyName="Value" />
                        </DeleteParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenFieldExam_Priority" runat="server" />
                    <asp:HiddenField ID="HF_MH_Code" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:Label CssClass="err" ID="Label1" runat="server"></asp:Label><br />
</asp:Content>
