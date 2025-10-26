<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="AssignSystemReports.aspx.cs" Inherits="DashBoards_AssignSystemReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="margin-top: 10px; width: 100%;">
        <h2>
            <span>Assing Rights To Employee</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="50%">Department:
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddle1" runat="server" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="ddle1_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">Employee:
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddle2" runat="server" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="ddle2_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Assign" />
                    <asp:Label ID="lblMsg" runat="server" Text="Record Saved Successfully!!!!!" ForeColor="Green" Font-Bold="true" Visible="false"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <asp:DataList ID="DataList1" runat="server" OnItemDataBound="DataList1_ItemDataBound"
        RepeatColumns="4" RepeatDirection="Horizontal">
        <ItemTemplate>
            <div class="bxmain inner_content" style="width: 300px; height: 300px; margin-right: 10px; margin-left: 10px; margin-top: 10px;">
                <h2>
                    <asp:Label ID="lblModuleName" runat="server" Text='<%# Eval("Module_Name") %>'></asp:Label></h2>
                <asp:HiddenField ID="hfModuleID" runat="server" Value='<%# Eval("Module_Name") %>' />
                <div style="margin-left: 10px; overflow-y: scroll; height: 260px;">
                    <asp:DataList ID="data" runat="server" OnItemDataBound="data_ItemDataBound">
                        <ItemTemplate>
                            <tr>
                                <td align="left" style="width: 260px">
                                    <asp:Label ID="lblReportName" runat="server" Font-Bold="false" Font-Size="Medium" Text='<%# Eval("Reprot_Name") %>'></asp:Label>
                                    <asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("Role_ID") %>' />
                                    <asp:HiddenField ID="hfStatus" runat="server" Value='<%# Eval("RStatus") %>' />
                                </td>
                                <td align="right">
                                    <asp:CheckBox ID="chkboxOne" runat="server" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </div>
        </ItemTemplate>

    </asp:DataList>

    <%-- <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Report Name">
                    <ItemTemplate>
                        <asp:Label ID="subdeptLabel" Text='<%# Bind("Report_Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Employee Name">
                    <ItemTemplate>
                        <asp:Label ID="subdeptLabel2" Text='<%# Bind("Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>--%>
</asp:Content>
