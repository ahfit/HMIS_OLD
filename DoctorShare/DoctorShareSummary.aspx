<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Finance_DoctorShareSummary, App_Web_pxrjewcn" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%">
        <tr>
        <td align="right" style="width: 100px;">
                Departments :
            </td>
            <td style="width: 200px;">
                <asp:DropDownList ID="ddlDepartment" runat="server" DataValueField="Dept_ID" DataTextField="Dept_Name"
                    AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td align="right" style="width: 100px;">
                Doctor :
            </td>
            <td style="width: 200px;">
                <asp:DropDownList ID="ddlDoctors" runat="server" >
                </asp:DropDownList>
            </td>
             <td align="right" style="width: 100px;">
                    Start Date:
                </td>
                <td style="width: 150px;">
                    <igsch:WebDateChooser ID="Wdc_start" runat="server"  Width="122px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                <td align="right" style="width: 100px;">
                    End Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="wdc_End_date" runat="server"  Width="122px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>            
            </tr>
            <tr>
            <td>&nbsp;</td>
            </tr>
            <tr>
            
            <td colspan="8" align="center">
            <asp:Button ID="Btn_Search" runat="server" Text="Search" />
            <asp:Button ID="btnEToExcel" runat="server" Text="Export To Excel" Visible="true" />
            </td>            
        </tr>
    </table>
    <div style="padding-top: 10px;">
        <asp:GridView ID="grdDoctorShareSummary" runat="server" AutoGenerateColumns="False"
            ShowFooter="True" CssClass="Grid_1" Width="95%">
            <Columns>
                <asp:TemplateField HeaderText="Doctor Name">
                    <ItemTemplate>
                        <%# Eval("DoctorName") %></ItemTemplate>
                    <FooterTemplate>
                        <strong>Total Amount :</strong>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cash Amount" Visible="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkCashAmount" CommandArgument='<%# Eval("DoctorId") %>' Text='<%# String.Format("{0:0.##}", Eval("CashAmount"))%>'
                            CommandName="Cash" runat="server"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterTemplate>
                        <b>
                            <asp:Label ID="lblTotalCashAmount" runat="server"></asp:Label></b>
                    </FooterTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBankAmount" CommandArgument='<%# Eval("DoctorId") %>' Text='<%# String.Format("{0:0}", Eval("BankAmount"))%>'
                            CommandName="Bank" runat="server"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterTemplate>
                        <b>
                            <asp:Label ID="lblTotalBankAmount" runat="server"></asp:Label></b>
                    </FooterTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDelete" CommandArgument='<%# Eval("DoctorId") %>' Text='Delete' Enabled="false"
                            CommandName="Remove" runat="server"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                   
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Amount" Visible="False">
                    <ItemTemplate>
                        <%# String.Format("{0:0}", Eval("TotalAmount"))%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterTemplate>
                        <b>
                            <asp:Label ID="lblTotalAmount" runat="server" ></asp:Label></b>
                    </FooterTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="GridItem" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
    </div>
</asp:Content>
