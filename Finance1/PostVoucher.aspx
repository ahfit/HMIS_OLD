<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="PostVoucher.aspx.cs" Inherits="Finance_PostVoucher" %>



<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<style  type ="text/css">
    .NoDisplay
    {
        display:none;
    }

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div style="width: 100%;">
        <table width="100%">
            <tr>
                <td width="40%" align="center" valign="top">
                    <div class="bxmain inner_content" style="width: 100%;">
                        <h2>
                            <span>Add Voucher</span></h2>
                        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                            <tr>
                                <td align="right" width="30%">
                                    Comapny :
                                </td>
                                <td width="50%" align="left">
                                    <asp:DropDownList ID="ddlFinancialComapny" DataTextField="Financial_Company_Name"
                                        Width="257px" DataValueField="Financial_Company_Id" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlFinancialComapny_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td width="30%" align="right">
                                    Branch :
                                </td>
                                <td width="50%" align="left">
                                    <asp:DropDownList ID="ddlBranch" runat="server" DataTextField="Company_Branch_Name"
                                        Width="257px" DataValueField="Company_Branch_Id">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" width="30%">
                                    Date :
                                </td>
                                <td>
                                    <igsch:WebDateChooser ID="WebDateChooser_Reciept" runat="server" Width="257px" Enabled="true">
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" width="v%">
                                    Voucher Type :
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_VoucherType" DataValueField="Voucher_Type_ID" DataTextField="Voucher_Type_Name" runat="server" Width="257px">                                    
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" width="30%">
                                    Search Head :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtHeadName" runat="server" OnTextChanged="btnSearch_Click" AutoPostBack="true" Width="250px"></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="Auto_Names_Extender" runat="server" ServiceMethod="SearchHead"
                        MinimumPrefixLength="2" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtHeadName" FirstRowSelected="true" CompletionListCssClass="AutoExtender"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight" ></asp:AutoCompleteExtender>
                                    <asp:Button Visible="false" Text="Search" OnClick="btnSearch_Click" ID="btnSearch" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" width="30%">
                                    Account Head
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlAccountHead" AutoPostBack="true" OnSelectedIndexChanged="ddlAccountHead_SelectedIndexChanged"
                                        runat="server" DataTextField="E_Name" DataValueField="E_Code" Width="257px">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="DDL_Parties" Visible="False" runat="server" DataTextField="Party_Name"
                                        DataValueField="Party_Id">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                             <tr>
                                <td width="30%" align="right">
                                    Cost Center :
                                </td>
                                <td width="50%" align="left">
                                    <asp:DropDownList ID="ddlCostCenter" runat="server" DataTextField="CostCenterName"
                                        Width="257px" DataValueField="CostCenterID">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                             <tr>
                                <td width="30%" align="right">
                                    Financial Year :
                                </td>
                                <td width="50%" align="left">
                                    <asp:DropDownList ID="DDL_Finacial_Year" runat="server" DataTextField="Financial_Year" Enabled="true"
                                        Width="257px" DataValueField="Financial_Year_Id">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr >
                                <td align="right" width="30%">
                                    Cheque# :
                                </td>
                                <td>
                                    <asp:TextBox runat="server" Text="" ID="txtCheque" Width="250px" />
                                </td>
                            </tr>
                            <tr >
                                <td align="right" width="30%">
                                    Cheque Date :
                                </td>
                                <td>
                                    <igsch:WebDateChooser ID="WebDateChooser_CheqDate" runat="server" Width="257px" Enabled="true">
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" width="30%">
                                    Type :
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="DDL_CreditType" CssClass="bxmain" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Value="1" Text="Dr." />
                                        <asp:ListItem Value="2" Text="Cr." />
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" width="30%">
                                    Amount :
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtAmount" Text="0" Width="250px" />
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right" width="30%">
                                    Description :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Height="100px"
                                        Width="250px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:Button Text="Add" ID="btnAdd" OnClick="btnAdd_Click" runat="server" />
                                </td>
                            </tr>
                            <tr>
                            <td colspan="2">
                                <asp:Label Text="" ID="lblMsg2" ForeColor="Red" runat="server" />
                            </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td valign="top" align="center">
                    <div class="bxmain inner_content" style="width: 100%">
                        <h2>
                            <span>Voucher Detail</span></h2>
                    </div>
                    <asp:GridView runat="server" ID="GridView1" AutoGenerateColumns="false" CssClass="Grid_1"
                        Width="100%" ShowHeaderWhenEmpty="true" ShowFooter="true" OnPreRender="GridView1_PreRender">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.#">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account#">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("Head_Id") %>' ID="lblHeadId" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Cost Centre">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("CostCenterName") %>' ID="Label1" runat="server" />

                                    <asp:Label Text='<%#Bind("CostCenter") %>' ID="lblCostCentre" runat="server"  CssClass ="NoDisplay" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account Head">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("Head_Name") %>' ID="lblHead_Name" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Cheque">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("Cheque") %>' ID="lblHead_Cheque" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Debit">
                                <ItemTemplate>
                                    <asp:Label Text="" ToolTip='<%#Bind("Dr") %>' ID="lblDr" runat="server" />
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label Text="" ID="lblTotalDr" Font-Bold="true" runat="server" />
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Credit">
                                <ItemTemplate>
                                    <asp:Label Text="" ToolTip='<%#Bind("Amount") %>' ID="lblCr" runat="server" />
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label Text="" ID="lblTotalCr" Font-Bold="true" runat="server" />
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:LinkButton CommandArgument='<%#Bind("Id") %>' Text="Delete" ID="lbtnDelete"
                                        OnClick="lbtnDelete_Click" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:Button Text="Save & Print" ID="btnSave" Visible="false" OnClick="btnSave_Click" runat="server" />
                    <asp:Label Text="" ID="lblMsg" Font-Bold="false" runat="server" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
