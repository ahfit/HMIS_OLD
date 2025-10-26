<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpagePatient.master"
    CodeFile="PanelCompany_BillAdjustment.aspx.cs" Inherits="Patient_Billing_PanelCompany_BillAdjustment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content " style="width: 100%">
        <h2>
            <span>Panel Bill Adjustment</span></h2>
        <table width="100%" style="visibility: hidden">
            <tr>
                <td align="center">
                    <asp:DropDownList runat="server" ID="DDL_Company" DataTextField="Party_Name" DataValueField="Party_Id">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>

        <table width="100%">
            <tr>
                <td>
                    <h2>
                        <span>Services Detail</span></h2>
                </td>
                <td>
                    <h2>
                        <span>Limit Detail</span></h2>
                </td>
            </tr>
            <tr  >
                <td width="70%" style="margin-top:20px">
                    <asp:GridView runat="server" ID="GridView_Services" AutoGenerateColumns="false" >
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.#">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("Asc_Name") %>' ID="lblCategory" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("Date") %>' ID="lbldate" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Service">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("S_Name") %>' ID="lblService" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("company_Rate") %>' ID="lblAmount" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Patient Amount">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPatientAmount" Text='<%#Bind("patientAmount") %>' runat="server"
                                        Width="40px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Panel Amount">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtpanelAmount" Text='<%#Bind("panelAmount") %>' ToolTip='<%#Bind("insert_id") %>' runat="server"
                                        Width="40px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkbox" runat="server" Checked="True" Enabled="False" />
                                    <asp:HiddenField ID="hdnS_Id" runat="server" Value='<%#Eval("S_Id") %>' />
                                     <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("insert_id") %>' />
                                    <asp:HiddenField ID="hdnPsid" runat="server" Value='<%#Eval("PSID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
                <td valign="top">
                    <asp:GridView runat="server" ID="GridView_CategoryDetail" AutoGenerateColumns="false">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.#">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("Asc_Name") %>' ID="lblCategory" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("Amount") %>' ID="lblAmount" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Limit">
                                <ItemTemplate>
                                    <asp:Label Text='<%#Bind("Limit_Amount") %>' ID="lblAmount" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
