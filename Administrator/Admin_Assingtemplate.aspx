<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Assingtemplate, App_Web_lwhdjlgh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        function CheckMainGroup(a) {
            if (document.getElementById("TextBoxMGname").value == "") {
                alert("Please Enter the main Group Name");
                return false;
            }
            var Textbox = document.getElementById("TextBoxMGname").value;
            if (Textbox.length != 0) {
                var i;
                var space = " ";
                for (i = 0; i <= Textbox.length; i++) {
                    if (Textbox == space) {
                        alert("Spaces Are Not Allowed");
                        return false;
                    }
                    space += " ";
                }

            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label>
    <div class="bxmain">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
            <tr>
               
                <td align="right">
                    Hospital :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListHospital" runat="server" DataSourceID="SqlDataSourceHospital"
                        DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="250px" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceHospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT Hospital_ID, Hospital_Name FROM Hospital" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                    </asp:SqlDataSource>
                </td>
                  <td align="right">
                    Department :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListDepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" Width="250px" AppendDataBoundItems="True"
                        AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="Select_Dept" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
              
                <td align="right">
                    Sub Department :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListsubDepartment" runat="server" Width="250px" AutoPostBack="True"
                        DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="Select_SubDept" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListDepartment" Name="Dept_Id" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                 <td align="right">
                    Template :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListTemplate" runat="server" DataSourceID="SqlDataSourceTemplates"
                        DataTextField="Template_Name" DataValueField="Template_Id" Width="250px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceTemplates" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                        SelectCommand="SELECT Template_Id, Template_Name FROM Admin_Template where active=1" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:Label CssClass="err" ID="LabelEmpName" runat="server"></asp:Label>
    <asp:Label CssClass="err" ID="Label1" runat="server"></asp:Label><br />
    <asp:GridView ID="GridViewMGName" runat="server" AutoGenerateColumns="False" Width="100%"
        CssClass="Grid_1" DataSourceID="SqlDataSourceForGrid" DataKeyNames="id">
        <FooterStyle CssClass="GridPager" />
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"
                        ToolTip="Delete" OnClientClick="return confirmation(this)" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Template_Name" HeaderText="Template Name" SortExpression="Template_Name" />
            <asp:BoundField DataField="SubDepartment" HeaderText="SubDepartment" SortExpression="SubDepartment" />
            <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True"
                SortExpression="id" Visible="False" />
        </Columns>
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" DeleteCommand="DELETE FROM Admin_Assign_Template WHERE (id = @Id)"
        InsertCommand="INSERT INTO [admin_Phy_Exam_MainGroup] ([MG_Name], [Priority]) VALUES (@MG_Name, @Priority)"
        SelectCommand="Select_Dept_Template" UpdateCommand="UPDATE [admin_Phy_Exam_MainGroup] SET [MG_Name] = @MG_Name, [Priority] = @Priority WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority"
        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
        SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridViewMGName" Name="Id" PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="MG_Name" Type="String" />
            <asp:Parameter Name="Priority" Type="Int32" />
            <asp:Parameter Name="original_MG_Code" Type="Int32" />
            <asp:Parameter Name="original_MG_Name" Type="String" />
            <asp:Parameter Name="original_Priority" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="MG_Name" Type="String" />
            <asp:Parameter Name="Priority" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="dept_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" DeleteCommand="DELETE FROM [admin_Phy_Exam_MainGroup] WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority"
        InsertCommand="insert into Admin_Assign_Template(hospital_id,dept_id,subdept_id,template_id)&#13;&#10;values(@hospital_id,@dept_id,@subdept_id,@template_id)"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT Template_Id, Template_Name FROM Admin_Template"
        UpdateCommand="UPDATE [admin_Phy_Exam_MainGroup] SET [MG_Name] = @MG_Name, [Priority] = @Priority WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority"
        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:Parameter Name="original_MG_Code" Type="Int32" />
            <asp:Parameter Name="original_MG_Name" Type="String" />
            <asp:Parameter Name="original_Priority" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="MG_Name" Type="String" />
            <asp:Parameter Name="Priority" Type="Int32" />
            <asp:Parameter Name="original_MG_Code" Type="Int32" />
            <asp:Parameter Name="original_MG_Name" Type="String" />
            <asp:Parameter Name="original_Priority" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownListHospital" Name="hospital_id" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="dept_id" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownListsubDepartment" Name="subdept_id" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownListTemplate" Name="template_id" PropertyName="SelectedValue" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
    <div align="center">
        <asp:Button ID="ButtonSave" runat="server" Text="Save" /></div>
    <asp:HiddenField ID="HiddenFieldename" runat="server" />
    <asp:HiddenField ID="HiddenField_id" runat="server" />
    <br />
</asp:Content>
