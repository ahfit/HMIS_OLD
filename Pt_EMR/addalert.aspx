<%@ page language="VB" autoeventwireup="false" CodeFile="~/Pt_EMR/addalert.aspx.vb" inherits="addalert" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../css_hacims/class_reset.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <link href="../css_hacims/class_content.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <!--[if IE]><link rel="stylesheet" href="../css_hacims/content_ie.css" type="text/css" media="screen, projection"/><![endif]-->
    <style type="text/css">
body {background-image:none; background:none; }

</style>
</head>
<body>
    <form id="form1" runat="server">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top">
                    <div class="bx_infos_patients" style="width: 100%; display: none;">
                        <h2>
                            <span>Alerts</span></h2>
                        <div class="bxinfo_margin" style="height: auto;">
                            <asp:DataList ID="DataList_Alert" runat="server" DataSourceID="SqlDataSource_Alert_Show"
                                RepeatColumns="5" RepeatDirection="Horizontal">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Style="color: red; font-weight: bold; border-right: #c6c6c6 solid 1px;
                                        padding-left: 5px; padding-right: 5px;" Text='<%# Eval("Alert") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:DataList>
                            <asp:SqlDataSource ID="SqlDataSource_Alert_Show" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                DeleteCommand="DELETE FROM [OPD_Alert] WHERE [Alert_ID] = @Alert_ID" InsertCommand="INSERT INTO [OPD_Alert] ([Reg_No], [Yearly_No], [Alert]) VALUES (@Reg_No, @Yearly_No, @Alert)"
                                SelectCommand="SELECT TOP (5) Reg_No, Yearly_No, Alert, Alert_ID FROM OPD_Alert WHERE (Reg_No = @Reg_No) AND (Yearly_No = @Yearly_No) ORDER BY Alert_ID DESC"
                                UpdateCommand="UPDATE [OPD_Alert] SET [Reg_No] = @Reg_No, [Yearly_No] = @Yearly_No, [Alert] = @Alert WHERE [Alert_ID] = @Alert_ID"
                                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
                                <DeleteParameters>
                                    <asp:Parameter Name="Alert_ID" Type="Int32" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Reg_No" Type="String" />
                                    <asp:Parameter Name="Yearly_No" Type="String" />
                                    <asp:Parameter Name="Alert" Type="String" />
                                    <asp:Parameter Name="Alert_ID" Type="Int32" />
                                </UpdateParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                                    <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" Type="String" />
                                    <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" Type="String" />
                                    <asp:ControlParameter ControlID="TextBox_Alert" Name="Alert" PropertyName="Text"
                                        Type="String" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top">
                    <div style="margin-left: 18px;">
                        <div class="bx_infos_patients">
                            <h2>
                                <span>Alerts</span></h2>
                            <div class="bxinfo_marginb">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                    <tr>
                                        <td align="right" width="20%">
                                            <strong>Add Alert : </strong>
                                        </td>
                                        <td width="80%">
                                            <asp:TextBox ID="TextBox_Alert" runat="server" Height="35px" TextMode="MultiLine"
                                                Width="200px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            &nbsp;</td>
                                        <td>
                                            <asp:Button ID="Button_Alert" runat="server" Text="save" /></td>
                                    </tr>
                                </table>
                                <br />
                                <asp:GridView ID="GridView_Alert" runat="server" AutoGenerateColumns="False" DataKeyNames="Alert_ID"
                                    CssClass="Grid_1" Width="100%" DataSourceID="SqlDataSource_Alert">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnDelete" runat="server" OnClick="lbtnDelete_Click">Delete</asp:LinkButton>
                                                <asp:Label ID="lbl_Alert_ID" runat="server" Text='<%# Eval("Alert_ID") %>' Visible ="false"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Alert" HeaderText="Alert" SortExpression="Alert" />
                                    </Columns>
                                </asp:GridView>
                                &nbsp;
                                <br />
                            </div>
                        </div>
                        <asp:SqlDataSource ID="SqlDataSource_Alert" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                            DeleteCommand="DELETE FROM [OPD_Alert] WHERE [Alert_ID] = @Alert_ID" InsertCommand="INSERT INTO OPD_Alert(Reg_No, Yearly_No, Alert, Active,Date_time,Emp_Id) VALUES (@Reg_No, @Yearly_No, @Alert, 'True',GetDate(),@Emp_Id)" SelectCommand="SELECT Reg_No, Yearly_No, Alert, Alert_ID, Active FROM OPD_Alert WHERE (Reg_No = @Reg_No) AND (Yearly_No = @Yearly_No) AND (Active = 1)"
                            UpdateCommand="UPDATE_OPD_Alert" UpdateCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" />
                                <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                            </SelectParameters>
                            <InsertParameters>
                                <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" />
                                <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNO" />
                                <asp:ControlParameter ControlID="TextBox_Alert" Name="Alert" PropertyName="Text" />
                                <asp:SessionParameter Name="Emp_Id" SessionField="Emp_Id" />
                            </InsertParameters>
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="GridView_Alert" Name="Alert_ID" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:ControlParameter ControlID="hf_Alert_ID" Name="Alert_ID" PropertyName="Value"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="txtReason" Name="Reason" PropertyName="Text" Type="String" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        &nbsp;<br />
                        <asp:Panel ID="pnl_AlertReason" runat="server" CssClass="" Visible ="false">
                            <div class="" style="left: 352%; top: 598%">
                                <table>
                                    <tr>
                                        <td style="width: 100px">
                                            Reason</td>
                                        <td style="width: 100px">
                                            <asp:TextBox ID="txtReason" runat="server" MaxLength="499" Rows="3" TextMode="MultiLine"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100px">
                                        </td>
                                        <td style="width: 100px">
                                            <asp:Button ID="btnOK" runat="server" Text="Ok" Width="60px" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                                            <asp:Label ID="lblMessage" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label></td>
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hf_Alert_ID" runat="server" />
                            </div>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
        </table>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <asp:HiddenField ID="HiddenField_MH_Code" runat="server" />
    </form>
</body>
</html>
