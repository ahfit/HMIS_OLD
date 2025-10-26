<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TaxSlab.aspx.cs" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="PayRoll_TaxSlab" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Tax Slab</span></h2>
        <table width="100%">
            <tr>
                <td align="right">Financial Year:
                </td>
                <td align="left">
                    <asp:DropDownList runat="server" DataTextField="Financial_Year" DataValueField="Financial_Year_Id" ID="DDL_fYear" AutoPostBack="true" OnSelectedIndexChanged="DDL_fYear_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td align="right">Slab From:
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtSlabFrom" TextMode="number" required />
                </td>
            </tr>
            <tr>
                <td align="right">Tax%:
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtTax" Required />
                </td>
                <td align="right">Slab To:
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtSlabTo" TextMode="number" required />
                </td>
            </tr>
            <tr>
                <td align="right">Fixed Amount:
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtFixedAmount" TextMode="number" required />
                </td>
                <%--<td align="right">
                    Per_Fix Check:
                </td>
                <td align="left">
                   <asp:CheckBox ID="chkExceeding" runat="server" Checked="false"/>
                </td>--%>
            </tr>
            <tr>
                <td align="right" colspan="1">Description:
                </td>
                <td align="left" colspan="3">
                    <asp:TextBox runat="server" ID="txtDescription" TextMode="MultiLine" Width="350px" Height="50px" />
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <asp:Button Text="Save" runat="server" ID="btnSave" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
        </br>
        </br>
        <asp:GridView runat="server" ID="GridView_Tax" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                       <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Slab From">
                    <ItemTemplate>
                        <asp:Label ID="lblSlab_From" Text='<%#Bind("Slab_From") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Slab To">
                    <ItemTemplate>
                        <asp:Label ID="lblslab_To" Text='<%#Bind("Slab_To") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tax%">
                    <ItemTemplate>
                        <asp:Label ID="lblTax" Text='<%#Bind("Tax") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Fixed Amount">
                    <ItemTemplate>
                        <asp:Label ID="lblFixedAmount" Text='<%#Bind("Fixed_Amount") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Year">
                    <ItemTemplate>
                        <asp:Label ID="lblF_Year" Text='<%#Bind("Financial_Year") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate>
                        <asp:Label ID="lblDescription" Text='<%#Bind("Description") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Per_Fix Check" Visible="false">
                    <ItemTemplate>
                       <asp:CheckBox ID="chkExceedingCheck" runat="server" Checked='<%#Bind("IsExceedingPercentage") %>' Enabled="false"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtnDelete" CommandArgument='<%#Bind("TaxSlab_Id") %>' Text="Delete" OnClick="lbtnDelete_Click" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Update">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtnupdate" Text="Update" CommandArgument='<%#Bind("TaxSlab_Id") %>' OnClick="lbtnupdate_Click" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    
</asp:Content>
