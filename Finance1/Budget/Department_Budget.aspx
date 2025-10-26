<%@ Page Title="" Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master"
    AutoEventWireup="true" CodeFile="Department_Budget.aspx.cs" Inherits="Finance_Department_Budget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <div class="bxmain inner_content" style="width: 100%;">
            <h2>
                <span>Departmental Budget</span></h2>
            <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                <tr>
                    <td width="40%" align="right">Budget Head :
                    </td>
                    <td width="60%">
                        <asp:Label ID="lblHeadName" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td width="40%" align="right">Total Amount :
                    </td>
                    <td width="60%">
                        <asp:Label ID="lblTotalAmount" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="40%" align="right">Total Monthly Limit :
                    </td>
                    <td width="60%">
                        <asp:Label ID="lblMonthlyLimit" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="40%" align="right">Remaning Amount :
                    </td>
                    <td width="60%">
                        <asp:Label ID="lblRemaningAmount" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="40%" align="right">Department :
                    </td>
                    <td width="60%">
                        <asp:DropDownList ID="ddlSubDepartment" runat="server"
                            DataTextField="SubDept_Name" DataValueField="SubDept_Id" Width="252px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td width="40%" align="right">Yearly Limit :
                    </td>
                    <td width="60%">
                        <asp:TextBox ID="txtYearlyLimit" runat="server" TextMode="Number"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td width="40%" align="right">Monthly Limit :
                    </td>
                    <td width="60%">
                        <asp:TextBox ID="txtMonthlyLimit" runat="server" TextMode="Number"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td width="40%" align="right">Description :
                    </td>
                    <td width="60%">
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Width="300px" Height="75px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <div style="width:100%; text-align:center;">
            <asp:GridView ID="gvDetail" runat="server" Width="100%" EmptyDataText="No Record(s) Found." ShowFooter="true" 
                AutoGenerateColumns="false" OnPreRender="gvDetail_PreRender">
                <Columns>
                    <asp:TemplateField HeaderText="Sr. #">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="E_Code" HeaderText="Head Code" />
                    <asp:BoundField DataField="E_Name" HeaderText="Head Name" />
                    <asp:BoundField DataField="SubDept_Name" HeaderText="Department Name" />
                    <asp:BoundField DataField="DeptMonthLimit" HeaderText="Dept. Monthly Limit" />
                    <asp:TemplateField HeaderText="Yearly Final Amount">
                        <ItemTemplate>
                            <asp:Label ID="lblYearlyLimit" runat="server" Text='<%# Eval("YearlyLimit") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lblTotalDeptBudget" runat="server"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
</asp:Content>
