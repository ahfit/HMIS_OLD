<%@ page language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Patient_Billing_PanelCompanyCashLimit, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Add Patient Limits</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td width="25%" align="right">
                    <b>Total Limit :</b>
                </td>
                <td>
                    <asp:TextBox ID="TextLimtAmount" runat="server"></asp:TextBox>
                </td>
                <td width="25%" align="right">
                    <b>Reference No :</b>
                </td>
                <td>
                    <asp:TextBox ID="txtReferNo" runat="server" />
                </td>
            </tr>
            <tr>
                <td width="25%" align="right">
                    <b>Employee No :</b>
                </td>
                <td>
                    <asp:TextBox ID="txtEmpNo" runat="server"></asp:TextBox>
                </td>
                <td width="25%" align="right">
                    <b>Expiry Date :</b>
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser_ExpiryDate" runat="server" EnableKeyboardNavigation="True">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right">
                    <b>Manual File No :</b>
                </td>
                <td>
                    <asp:TextBox ID="txtFileNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" />
                    <asp:Label ID="lblMessage" runat="server" Font-Bold="True" ForeColor="#0066FF"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td width="45%">
                    <div style="overflow: scroll; height: 300px;">
                        <asp:GridView ID="grdServices" runat="server" AutoGenerateColumns="False" Width="100%"
                            ShowHeaderWhenEmpty="true" DataSourceID="dsServices">
                            <Columns>
                                <asp:BoundField DataField="CategoryName" HeaderText="Category Name" SortExpression="S_Category" />
                                <asp:TemplateField HeaderText="Total Limit">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txttotalLimit" Text='<%#Bind("TotalLimit") %>' ToolTip='<%#Bind("CategoryId") %>' runat="server"
                                            Width="100px"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Per Day">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPerDayRate" Text='<%#Bind("PerDayLimit") %>' runat="server" Width="100px"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" Checked='<%#Bind("is_exist") %>' ToolTip='<%#Bind("Detail_Id") %>' runat="server" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="True" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="dsServices" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                            SelectCommand="select CategoryName,CategoryId,ISNULL(PLD.TotalLimit,0) as TotalLimit,case when PLD.DetailID IS NULL then CONVERT(bit,0) else CONVERT(bit,1) end as is_exist,ISNULL(PLD.DetailID,0) as Detail_Id,PLD.PerDayLimit from serviceMainCategory left outer join PatientLimitMain as PLM on  PLM.RegNo=@RegNo left outer join PatientLimitDetail PLD on serviceMainCategory.CategoryId=PLD.Category_Id and PLM.LimitID=PLD.LimitId ">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="RegNO" QueryStringField="regno" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="hfS_IDPage" runat="server" />
                    </div>
                </td>
        </table>
</asp:Content>
