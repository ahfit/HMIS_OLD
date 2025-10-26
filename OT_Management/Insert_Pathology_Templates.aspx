<%@ Page Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="Insert_Pathology_Templates.aspx.vb" Inherits="Pathology_Insert_Pathology_Templates"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            text-align: right;
            height: 22px;
            width: 118px;
        }
        .style2
        {
            text-align: right;
            width: 118px;
        }
        .style3
        {
            width: 118px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 1142px">
        <tr>
            <td class="style1">
                Servive Name :</td>
            <td style="width: 219px; height: 22px">
                <asp:DropDownList ID="DropDownList_Service" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Service"
                    DataTextField="TB_Name" DataValueField="TB_ID" Width="250px" 
                    style="margin-left: 0px">
                </asp:DropDownList></td>
            <td style="width: 100px; height: 22px">
                &nbsp;</td>
                <tr>
                <td class="style2">Template Name:</td>
            <td style="width: 100px; height: 22px">
                <asp:TextBox ID="TextBox_Template_Name" runat="server" Width="194px" 
                    style="margin-left: 0px"></asp:TextBox></td>
                    </tr>
        </tr>
        <tr>
            <td class="style2">
                Template Description:</td>
            <td colspan="3">
                <asp:TextBox ID="TextBox_Template" runat="server" Height="66px" TextMode="MultiLine"
                    Width="668px"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="style3">
            </td>
            <td style="width: 219px">
            </td>
            <td style="width: 100px">
                <asp:Button ID="Button_Save" runat="server" Text="Save" /></td>
            <td style="width: 100px">
            </td>
        </tr>
    </table>
    <asp:GridView ID="GridView_Template" runat="server" AutoGenerateColumns="False" DataKeyNames="Template_ID"
        DataSourceID="SqlDataSource_Insert_Template">
        <Columns>
            <asp:TemplateField HeaderText="Service Name" SortExpression="S_Name">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList_Service" runat="server" DataSourceID="SqlDataSource_Service"
                        DataTextField="TB_Name" DataValueField="TB_ID" SelectedValue='<%# Bind("TB_ID", "{0}") %>'
                        Width="150px">
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("S_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Template_Name" HeaderText="Template Name" SortExpression="Template_Name" />
            <asp:TemplateField HeaderText="Detail" SortExpression="Template_Detail">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Template_Detail") %>' TextMode="MultiLine"
                        Width="400px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Template_Detail") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowDeleteButton="True" />
            <asp:CommandField ShowEditButton="True" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_Service" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
        SelectCommand="SELECT TB_ID, TB_Name FROM Test_Booking ORDER BY TB_Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Insert_Template" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        DeleteCommand="DELETE FROM [Pathology_Templates] WHERE [Template_ID] = @Template_ID"
        InsertCommand="INSERT INTO [Pathology_Templates] ([TB_ID], [Template_Detail], [Template_Name]) VALUES (@TB_ID, @Template_Detail, @Template_Name)"
        SelectCommand="SELECT Pathology_Templates.Template_ID, Pathology_Templates.TB_ID, Pathology_Templates.Template_Detail, Pathology_Templates.Template_Name, Test_Booking.TB_Name AS S_Name FROM Pathology_Templates INNER JOIN Test_Booking ON Pathology_Templates.TB_ID = Test_Booking.TB_ID WHERE (Pathology_Templates.TB_ID = @TB_ID)"
        UpdateCommand="UPDATE [Pathology_Templates] SET [TB_ID] = @TB_ID, [Template_Detail] = @Template_Detail, [Template_Name] = @Template_Name WHERE [Template_ID] = @Template_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Service" Name="TB_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Template_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Template_Detail" Type="String" />
            <asp:Parameter Name="Template_Name" Type="String" />
            <asp:Parameter Name="Template_ID" Type="Decimal" />
            <asp:Parameter Name="TB_ID" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Template" Name="Template_Detail" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_Template_Name" Name="Template_Name" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList_Service" Name="TB_ID" PropertyName="SelectedValue" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>

