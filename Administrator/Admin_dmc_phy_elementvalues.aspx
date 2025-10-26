<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_dmc_phy_elementvalues, App_Web_0xn5azrs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label><br />
    <div class="bxmain">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
            <tr>
                <td width="25%" align="right">
                    Main Group Part :
                </td>
                <td width="25%">
                    <asp:DropDownList AutoPostBack="True" DataTextField="MG_Name" DataValueField="MG_Code"
                        ID="DropDownListMGroup" runat="server" Width="180px" DataSourceID="SqlDataSourceMainGroup">
                    </asp:DropDownList>
                </td>
                <td width="25%" align="right">
                    Element Group :
                </td>
                <td width="25%">
                    <asp:DropDownList AutoPostBack="True" DataTextField="e_Name" DataValueField="e_Code"
                        ID="DropDownListEGroup" runat="server" Width="180px" DataSourceID="SqlDataSourceElementGroup">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Element Value :
                </td>
                <td colspan="3">
                    <asp:TextBox ID="TextBoxEName" runat="server" Width="174px"></asp:TextBox>
                    <asp:Button ID="ButtonSave" runat="server" Text="Save" />
                    <asp:Button ID="ButtonRefresh" runat="server" Text="Refresh" />
                    <asp:Label CssClass="err" ID="Label1" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:GridView ID="GridViewElementValues" runat="server" AutoGenerateColumns="False"
        DataKeyNames="ev_Code" DataSourceID="SqlDataSourceForGrid" Width="100%">
        <FooterStyle CssClass="GridPager" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="MG_Name" HeaderText="Main Group" SortExpression="MG_Name"
                ReadOnly="True" />
            <asp:BoundField DataField="e_Name" HeaderText="Element Name" SortExpression="e_Name"
                ReadOnly="True" />
            <asp:BoundField DataField="ev_Value" HeaderText="Element Value" SortExpression="ev_Value" />
            <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />
            <%--<asp:BoundField DataField="Image_Path" HeaderText="Image Path" SortExpression="Image_Path" />--%>
            <asp:BoundField DataField="ev_Code" HeaderText="Element Code" InsertVisible="False"
                ReadOnly="True" SortExpression="ev_Code" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
        DeleteCommand="DELETE FROM admin_Phy_Exam_ElementValue WHERE (ev_Code = @ev_Code)"
        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
        SelectCommand="SELECT admin_Phy_Exam_MainGroup.MG_Name, admin_Phy_Exam_Elements.e_Name, admin_Phy_Exam_ElementValue.ev_Value, admin_Phy_Exam_ElementValue.ev_Code, admin_Phy_Exam_ElementValue.Priority, admin_Phy_Exam_ElementValue.Image_Path FROM Admin_Phy_Exam_Elememt_Assign_To_Group INNER JOIN admin_Phy_Exam_Elements ON Admin_Phy_Exam_Elememt_Assign_To_Group.e_Code = admin_Phy_Exam_Elements.e_Code INNER JOIN admin_Phy_Exam_MainGroup ON Admin_Phy_Exam_Elememt_Assign_To_Group.MG_Code = admin_Phy_Exam_MainGroup.MG_Code INNER JOIN admin_Phy_Exam_ElementValue ON Admin_Phy_Exam_Elememt_Assign_To_Group.e_Code = admin_Phy_Exam_ElementValue.e_Code AND Admin_Phy_Exam_Elememt_Assign_To_Group.MG_Code = admin_Phy_Exam_ElementValue.MG_Code WHERE (Admin_Phy_Exam_Elememt_Assign_To_Group.MG_Code = @MG_Code) AND (Admin_Phy_Exam_Elememt_Assign_To_Group.e_Code = @e_Code)"
        UpdateCommand="UPDATE admin_Phy_Exam_ElementValue SET ev_Value = @ev_Value, Priority = @Priority, Image_Path = @Image_Path WHERE (ev_Code = @ev_Code)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridViewElementValues" Name="ev_Code" PropertyName="SelectedValue" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListMGroup" Name="MG_Code" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownListEGroup" Name="e_Code" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldE_Val" Name="ev_Value" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldE_Priority" Name="Priority" PropertyName="Value" />
            <asp:ControlParameter ControlID="GridViewElementValues" Name="ev_Code" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_Img_Path" Name="Image_Path" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
        SelectCommand="SELECT MG_Code, MG_Name FROM admin_Phy_Exam_MainGroup&#13;&#10;order by MG_Name">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceElementGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
        SelectCommand="SELECT admin_Phy_Exam_Elements.e_Code, admin_Phy_Exam_Elements.e_Name, admin_Phy_Exam_Elements.e_Field_Type, admin_Phy_Exam_Elements.MG_Code FROM admin_Phy_Exam_Elements INNER JOIN Admin_Phy_Exam_Elememt_Assign_To_Group ON admin_Phy_Exam_Elements.e_Code = Admin_Phy_Exam_Elememt_Assign_To_Group.e_Code WHERE (Admin_Phy_Exam_Elememt_Assign_To_Group.MG_Code = @MG_Code)&#13;&#10;order by admin_Phy_Exam_Elements.e_Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListMGroup" Name="MG_Code" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
        InsertCommand="Admin_Insert_Phy_exam_Element_Values" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownListMGroup" Name="MG_Code" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListEGroup" Name="e_Code" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="TextBoxEName" Name="ev_Value" PropertyName="Text"
                Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldE_Val" runat="server" />
    <asp:HiddenField ID="HiddenFieldE_Priority" runat="server" />
    <asp:HiddenField ID="HiddenField_Img_Path" runat="server" />
</asp:Content>
