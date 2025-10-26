<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="AddDashBoardPages.aspx.cs" Inherits="DashBoards_AddDashBoardPages" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Add Dashboard Pages</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="50%">
                    Heading
                </td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtAddHeading" runat="server" required 
                       ></asp:TextBox>
                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchModules"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtAddHeading" FirstRowSelected="true">
                    </asp:AutoCompleteExtender>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    Report Name
                </td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtReportName" runat="server" ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    URL
                </td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtURL" runat="server" ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" 
                        onclick="btnSearch_Click" CausesValidation="false" />
                       <asp:HiddenField ID="hid" runat="server" ></asp:HiddenField>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Label ID="lblMsg" runat="server" Text="Record Saved Successfully!!!!!" ForeColor="Green"
                        Font-Bold="true" Visible="false"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div class="inner_content" style="margin-top: 10px; width: 100%;">
        <asp:GridView ID="gvSystemReports" runat="server" AutoGenerateColumns="false" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Sr. #">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    <ItemStyle Width="50px"></ItemStyle>
                </asp:TemplateField>
                <asp:BoundField DataField="Module_Name" HeaderText="Module Name" SortExpression="Module_Name" />
                <asp:BoundField DataField="Reprot_Name" HeaderText="Report Name" SortExpression="Reprot_Name" />
                <asp:BoundField DataField="URL" HeaderText="URL" SortExpression="URL" />
                <asp:TemplateField ControlStyle-Width="15px">
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenField1" Value='<%# Eval("Module_Name") %>' runat="server" ></asp:HiddenField>
                        <asp:HiddenField ID="HiddenField2" Value='<%# Eval("Reprot_Name") %>' runat="server" ></asp:HiddenField>
                        <asp:HiddenField ID="HiddenField3" Value='<%# Eval("URL") %>' runat="server" ></asp:HiddenField>
                        <asp:ImageButton ID="imgDelete" runat="server" ImageUrl="~/images/delete.png" 
                            CommandArgument='<%# Eval("System_Report_Id") %>' onclick="imgDelete_Click" OnClientClick="return confirm('Do You Want to Delete?');" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ControlStyle-Width="15px">
                    <ItemTemplate>
                        <asp:ImageButton   ID="ImageEdit" runat="server" ImageUrl="~/images/Editbtn.png" 
                            CommandArgument='<%# Eval("System_Report_Id") %>' onclick="ImageEdit_Click"  OnClientClick="return confirm('Do You Want to Edit?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
         
    </div>
</asp:Content>
