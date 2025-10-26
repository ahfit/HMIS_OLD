<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AddDonation.aspx.cs" Inherits="Finance_AddDonation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Add Donation</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="left" width="50%" valign="top">
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                        <tr>
                            <td align="right" width="40%">
                                <tr>
                                    <td align="right" width="40%">Name : </td>
                                    <td align="left" width="60%">
                                        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="40%">Cell # : </td>
                                    <td align="left" width="60%">
                                        <asp:TextBox ID="txtCellNo" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="40%">Address : </td>
                                    <td align="left" width="60%">
                                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Width="250px"
                                            Height="100px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="40%">Care Of : </td>
                                    <td align="left" width="60%">
                                        <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Width="250px"
                                            Height="80px"></asp:TextBox>
                                    </td>
                                </tr>
                            </td>
                        </tr>
                    </table>

                </td>
                <td align="right" width="50%" valign="top">
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                        <tr>
                            <td align="right" width="40%">Compnay : </td>
                            <td align="left" width="60%">
                                <asp:DropDownList ID="ddlCompany" runat="server"
                                    AutoPostBack="True"
                                    DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id"
                                    OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Branch : </td>
                            <td align="left" width="60%">
                                <asp:DropDownList ID="ddlBranch" runat="server"
                                    DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Cost Center : </td>
                            <td align="left" width="60%">
                                <asp:DropDownList ID="ddlCostCenter" runat="server"
                                    DataTextField="CostCenterName" DataValueField="CostCenterID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Donation Type : </td>
                            <td align="left" width="60%">
                                <asp:DropDownList ID="ddlExpanse" runat="server"
                                    DataTextField="E_Name" DataValueField="E_Code">
                                </asp:DropDownList>
                            </td>
                        </tr>
                         <tr>
                            <td align="right" width="40%">Amount : </td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtAmount" runat="server" ></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Description : </td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Width="250px" Height="80px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Mode of Payment : </td>
                            <td align="left" width="60%">
                                <asp:DropDownList ID="ddlPaymentMode" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentMode_SelectedIndexChanged">
                                    <asp:ListItem Text="Cash" Selected="True" Value="Cash">Cash</asp:ListItem>
                                    <asp:ListItem Text="Cheque" Value="Bank">Cheque</asp:ListItem>
                                    <asp:ListItem Text="Online" Value="Online">Online</asp:ListItem>
                                </asp:DropDownList>

                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Head</td>
                            <td align="left" width="60%">
                                <asp:DropDownList ID="ddlHead" runat="server"
                                    DataTextField="E_Name" DataValueField="E_Code"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">
                                <asp:Label ID="lblCheqNo" runat="server" Text="Cheque # : " Visible="false"></asp:Label>
                            </td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtChequeNo" runat="server" Visible="false"></asp:TextBox>
                            </td>

                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:GridView ID="gvDonations" runat="server" AutoGenerateColumns="false"
            Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="Sr. #">
                <ItemTemplate>
                    <%# Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DonorName" HeaderText="Name" />
            <asp:BoundField DataField="CellNo" HeaderText="Cell #" />
            <asp:BoundField DataField="DonorAddress" HeaderText="Address" />
            <asp:BoundField DataField="DonorRemarks" HeaderText="Remarks" />
            <asp:BoundField DataField="Amount" HeaderText="Donated Amount" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkReceipt" runat="server" Text="Slip" OnClick="lnkReceipt_Click" CommandArgument='<%# Eval("DonantionID") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

