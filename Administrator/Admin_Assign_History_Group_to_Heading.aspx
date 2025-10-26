<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Assign_History_Group_to_Heading, App_Web_0xn5azrs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label Visible="false" ID="lblMsg" runat="server" style="color: Green; font-size: 14px;
        font-weight: bold;">Saved Successfully.</asp:Label>
    <div class="bxmain">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1">
            <tr>
                <td align="right" width="40%">
                    Main Heading :
                </td>
                <td width="60%">
                    <asp:TextBox ID="TextBoxMH" runat="server">
                    </asp:TextBox>
                </td>
            </tr>
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
                <td align="right">
                    Priority:
                </td>
                <td>
                    <asp:TextBox ID="TextBoxPriority" runat="server">
                    </asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="ButtonSave" runat="server" Text="Save" />
                    <asp:SqlDataSource ID="SqlDataSourceMH" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                        InsertCommand="INSERT INTO Admin_History_Main_Heading(MH_Heading,Priority, TemplateId) VALUES (@MH_Heading,@Priority, @TemplateId)"
                        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                        SelectCommand="SELECT Admin_History_Main_Heading.MH_Heading,  Admin_History_Main_Heading.Priority, Admin_History_Main_Heading.MH_Code FROM Admin_History_Main_Heading  WHERE (Admin_History_Main_Heading.TemplateId = @TemplateId)"
                        DeleteCommand="DELETE FROM Admin_History_Main_Heading WHERE (MH_Code = @MH_Code)"
                        UpdateCommand="UPDATE Admin_History_Main_Heading SET Priority = @Priority, MH_Heading = @MH_Heading WHERE (MH_Code = @MH_Code)">
                        <insertparameters>
                            <asp:ControlParameter ControlID="TextBoxMH" Name="MH_Heading" PropertyName="Text" />
                              <asp:ControlParameter ControlID="TextBoxPriority" Name="Priority" PropertyName="Text" />
                            <asp:ControlParameter ControlID="ddlTemplates" Name="TemplateId" PropertyName="SelectedValue" />
                        </insertparameters>
                        <selectparameters>
                            <asp:ControlParameter ControlID="ddlTemplates" Name="TemplateId" PropertyName="SelectedValue" />
                        </selectparameters>
                        <deleteparameters>
                            <asp:ControlParameter ControlID="GridViewMain_Heading" Name="MH_Code" PropertyName="SelectedValue" />
                        </deleteparameters>
                        <updateparameters>
                            <asp:ControlParameter ControlID="TextBoxPriority" Name="Priority" PropertyName="Text" />
                            <asp:ControlParameter ControlID="HiddenFieldMH" Name="MH_Heading" PropertyName="Value" />
                            <asp:ControlParameter ControlID="GridViewMain_Heading" Name="MH_Code" PropertyName="SelectedValue" />
                        </updateparameters>
                    </asp:SqlDataSource>
                 
                    <asp:HiddenField ID="HiddenFieldMH" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div style="width:70%; margin:0 auto;">
    <asp:GridView ID="GridViewMain_Heading" runat="server" AutoGenerateColumns="False"
        DataSourceID="SqlDataSourceMH" Width="100%" AllowPaging="True" DataKeyNames="MH_Code"
        PageSize="3">
        <columns>
            <asp:BoundField DataField="MH_Heading" HeaderText="Main Heading" SortExpression="MH_Heading" />
           
            <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />
            <asp:BoundField DataField="MH_Code" HeaderText="Main Code" InsertVisible="False"
                SortExpression="MH_Code" ReadOnly="True" Visible="false" />
            <asp:TemplateField HeaderText="Action">
                <EditItemTemplate>
                    <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />
                    <asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif"  />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif" />
                    <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif" OnClientClick="return confirmation(this)" />
                </ItemTemplate>
            </asp:TemplateField>
        </columns>
        <rowstyle cssclass="GridItem" />
        <headerstyle cssclass="GridHeader" />
        <alternatingrowstyle cssclass="GridAltItem" />
    </asp:GridView>
    </div>
    <br />
    <h1 class="h1">
        <span>Assign History Group to Heading</span></h1>
    <div class="bxmain">
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
           
            <tr>
                <td align="right">
                    Main Heading :
                </td>
                <td valign="top">
                    <asp:DropDownList ID="DropDownListMH" runat="server" Width="226px" DataSourceID="SqlDataSourceMHDDL"
                        DataTextField="MH_Heading" DataValueField="MH_Code" AutoPostBack="True">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Main Group :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceMainGroup"
                        DataTextField="MG_Name" DataValueField="MG_Code" Width="226px">
                    </asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td align="right">
                    Priority:
                </td>
                <td>
                    <asp:TextBox ID="txtPriorityGroup" runat="server">
                    </asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                </td>
                <td>
                    <asp:Button ID="ButtonSaveTemplate" runat="server" Text="Save" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:GridView ID="GridViewExam" runat="server" AutoGenerateColumns="False" DataKeyNames="id"
        DataSourceID="SqlDataSourceSave" Width="100%">
        <columns>
            <asp:BoundField DataField="MH_Heading" HeaderText="Main Heading" SortExpression="MH_Heading"
                ReadOnly="True" />
            <asp:BoundField DataField="MG_Name" HeaderText="Main Group" SortExpression="MG_Name"
                ReadOnly="True" />
            <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />
            <asp:BoundField DataField="MH_Code" HeaderText="MH_Code" InsertVisible="False" SortExpression="MH_Code"
                Visible="False" ReadOnly="True" />
            <asp:BoundField DataField="id" HeaderText="ID" InsertVisible="False" SortExpression="id"
                ReadOnly="True" Visible="false" />
            
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"/>
                    <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif" OnClientClick="return confirmation(this)" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />
                    <asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                </EditItemTemplate>
            </asp:TemplateField>
        </columns>
        <rowstyle cssclass="GridItem" />
        <headerstyle cssclass="GridHeader" />
        <alternatingrowstyle cssclass="GridAltItem" />
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceMHDDL" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
        SelectCommand="SELECT MH_Code, MH_Heading FROM Admin_History_Main_Heading">
    
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
        SelectCommand="SELECT MG_Code, MG_Name FROM admin_History_MainGroup order by MG_Name">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSave" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
        InsertCommand="INSERT INTO Admin_History_MainHeading_Group(MH_Code, Mg_Code,Priority) VALUES (@MH_Code, @Mg_Code,@Priority)"
        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
        DeleteCommand="DELETE FROM Admin_History_MainHeading_Group WHERE (id = @id)"
        SelectCommand="SELECT Admin_History_Main_Heading.MH_Heading, admin_History_MainGroup.MG_Name, Admin_History_MainHeading_Group.Priority, Admin_History_MainHeading_Group.id, Admin_History_Main_Heading.MH_Code FROM Admin_History_MainHeading_Group INNER JOIN Admin_History_Main_Heading ON Admin_History_MainHeading_Group.MH_Code = Admin_History_Main_Heading.MH_Code INNER JOIN admin_History_MainGroup ON Admin_History_MainHeading_Group.Mg_Code = admin_History_MainGroup.MG_Code  WHERE (Admin_History_Main_Heading.MH_Code = @MH_Code) order by Priority"
        UpdateCommand="UPDATE Admin_History_MainHeading_Group SET Priority = @Priority WHERE (id = @id)">
        <insertparameters>
            <asp:ControlParameter ControlID="DropDownListMH" Name="MH_Code" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Mg_Code" PropertyName="SelectedValue" />
              <asp:ControlParameter ControlID="txtPriorityGroup" Name="Priority" PropertyName="Text" />
        </insertparameters>
        <deleteparameters>
            <asp:ControlParameter ControlID="GridViewExam" Name="id" PropertyName="SelectedValue" />
        </deleteparameters>
        <selectparameters>
            <asp:ControlParameter ControlID="DropDownListMH" Name="MH_Code" PropertyName="SelectedValue" />            
        </selectparameters>
        <updateparameters>
            <asp:Parameter Name="Priority" />
            <asp:Parameter Name="id" />
        </updateparameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldMg_Code" runat="server" />
    <asp:HiddenField ID="HiddenFieldPriority_Exam" runat="server" />
    <br />
    <br />
    <asp:Label CssClass="text_lables_login" ID="Label1" runat="server"></asp:Label>
</asp:Content>
