<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="InsertMainPage.aspx.vb" Inherits="Administrator_InsertMainPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 5px;">
        <h2><span>Add Main Page</span></h2>
        <table class="style1">
            <tr>
                <td align="right">Page Name:</td>
                <td>
                    <asp:TextBox ID="tbxpagename" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Page URL:</td>
                <td>
                    <asp:TextBox ID="tbxpageurl" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="BtnSave" runat="server" Text="Save" />
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT [MainPage], [MainPage_URL], [MainPage_ID] FROM [MainPages]"
        InsertCommand="INSERT INTO MainPages(MainPage, MainPage_URL) VALUES (@pagename, @pageurl)"
        UpdateCommand="UPDATE MainPages Set MainPage=@MainPage,MainPage_URL=@MainPage_URL Where MainPage_ID=@MainPage_ID">
        <InsertParameters>
            <asp:ControlParameter ControlID="tbxpagename" Name="pagename"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="tbxpageurl" Name="pageurl"
                PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />

    <div runat="server" style="vertical-align: middle">
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True"
            AutoGenerateColumns="False" DataKeyNames="MainPage_ID"
            DataSourceID="SqlDataSource1" Width="100%">
            <Columns>
                <asp:BoundField DataField="MainPage" HeaderText="MainPage Name"
                    SortExpression="MainPage" />
                <asp:BoundField DataField="MainPage_URL" HeaderText="MainPage URL"
                    SortExpression="MainPage_URL" />
                <asp:BoundField DataField="MainPage_ID" HeaderText="MainPage_ID"
                    InsertVisible="False" ReadOnly="True" SortExpression="MainPage_ID" Visible="false" />
                <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif" ToolTip="Edit"
                            OnClientClick="return confirmation_edit(this)" />&nbsp;<asp:ImageButton ID="ImageButton2"
                                runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif" ToolTip="Delete" OnClientClick="return confirmation(this)" />&nbsp;
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>


