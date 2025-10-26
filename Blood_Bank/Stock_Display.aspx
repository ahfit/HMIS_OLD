<%@ page language="C#" autoeventwireup="true" inherits="Blood_Bank_Stock_Display, App_Web_k10uyj0r" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Blood Stock</span></h2>
    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
        <tr>
            <td width="40%" align="right">Stock Report Type :</td>
            <td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged"
                    RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True" Value="0">Stock</asp:ListItem>
                    <asp:ListItem Value="2">Expired</asp:ListItem>
                    <asp:ListItem Value="1">Issue</asp:ListItem>
                </asp:RadioButtonList></td>
        </tr>
        <tr>
            <td align="right">Expiry Till Date :</td>
            <td>
                <table>
                    <tr>
                        <td>
                            <igsch:WebDateChooser ID="WebDateChooser1" runat="server" OnValueChanged="WebDateChooser1_ValueChanged">
                                <AutoPostBack ValueChanged="True" CalendarMonthChanged="True"></AutoPostBack>
                            </igsch:WebDateChooser>
                        </td>
                        <td>
                            <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" /></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnreport" runat="server" Text="View Report" Width="100px" OnClick="btnreport_Click" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>

                <asp:HiddenField ID="HiddenField_Date" runat="server" />
            </td>
        </tr>
    </table>

    </div>
            <br />

    <asp:GridView ID="GridView_Results" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Results" OnPreRender="GridView_Results_PreRender">
        <Columns>
            <asp:TemplateField HeaderText="Blood Group" SortExpression="bg">
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("bg") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("bg") %>'></asp:Label>&nbsp;
                                    <asp:HiddenField ID="HiddenField_BGID" runat="server" Value='<%# Eval("Blood_Group_Id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Plasma" SortExpression="Plasma">
                <EditItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Plasma") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"
                        Text='<%# Bind("Plasma") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Platelet conc" SortExpression="Platelet">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Platelet") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click"
                        Text='<%# Bind("Platelet") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Red Cell conc" SortExpression="Red">
                <EditItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Red") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click"
                        Text='<%# Bind("Red") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fresh Frozen plasma" SortExpression="Fresh">
                <EditItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("Fresh") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton4" runat="server" OnClick="LinkButton4_Click"
                        Text='<%# Bind("Fresh") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Cryo PPt" SortExpression="Cryo">
                <EditItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("Cryo") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton5" runat="server" OnClick="LinkButton5_Click"
                        Text='<%# Bind("Cryo") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Washed Red Cell conc" SortExpression="Washed">
                <EditItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("Washed") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton6" runat="server" OnClick="LinkButton6_Click"
                        Text='<%# Bind("Washed") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Platelet rich plasma" SortExpression="Rich">
                <EditItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("Rich") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton7" runat="server" OnClick="LinkButton7_Click"
                        Text='<%# Bind("Rich") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Buffy coat" SortExpression="Buffy">
                <EditItemTemplate>
                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("Buffy") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton8" runat="server" OnClick="LinkButton8_Click"
                        Text='<%# Bind("Buffy") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Whole Blood" SortExpression="Whole">
                <EditItemTemplate>
                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("Whole") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton9" runat="server" OnClick="LinkButton9_Click1"
                        Text='<%# Bind("Whole") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <br />

    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="SqlDataSource_Results" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
        SelectCommand="Stock_Display" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadioButtonList1" Name="Condition" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="CheckBox1" Name="Is_Date_Given" PropertyName="Checked"
                Type="Boolean" />
            <asp:ControlParameter ControlID="HiddenField_Date" Name="GivenDate" PropertyName="Value"
                Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsPatientCount" runat="server"
        ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
        SelectCommand="Stock_Display_Report" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Is_Date_Given" Type="String" />
            <asp:Parameter Name="Condition" Type="Int32" />
            <asp:Parameter Name="GivenDate" Type="DateTime" />
        </SelectParameters>

    </asp:SqlDataSource>

</asp:Content>
