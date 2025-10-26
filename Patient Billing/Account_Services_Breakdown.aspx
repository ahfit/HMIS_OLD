<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="Account_Services_Breakdown.aspx.cs" Inherits="Patient_Billing_Account_Services_Breakdown" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="manager" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Services Breakdown</span></h2>
        <div style="width: 80%; height: 100%; margin: 0 auto;">
            <%--<rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>--%>
            <asp:GridView ID="gvd" runat="server" AutoGenerateColumns="false" ShowFooter="true" ShowHeader="true" OnRowDataBound="gvd_RowDataBound"
            AlternatingRowStyle-BackColor="Wheat" EmptyDataText="No Record FOund">
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:TemplateField HeaderText="SR #">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Visit #">
                        <ItemTemplate>
                            <asp:Label ID="lblPayId" runat="server" Text='<%# Eval("PayId") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MR #">
                        <ItemTemplate>
                            <asp:Label ID="lblRegNo" runat="server" Text='<%# Eval("RegNo") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Patient Name">
                        <ItemTemplate>
                            <asp:Label ID="lblPName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="15%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Service Name">
                        <ItemTemplate>
                            <asp:Label ID="lblService" runat="server" Text='<%# Eval("S_Name") %>' Font-Bold="true"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="20%" />
                        <FooterTemplate>
                            <asp:Label ID="lblT" runat="server" Text="Total :" Font-Bold="true" Font-Size="Larger" ForeColor="Blue"></asp:Label>
                        </FooterTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Amount">
                        <ItemTemplate>
                            <asp:Label ID="lblS_Amount" runat="server" Text='<%# Eval("Amount") %>' Font-Bold="true"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="8%" HorizontalAlign="Right" />
                        <FooterTemplate>
                            <asp:Label ID="lblTotal" runat="server" Text="" Font-Bold="true" Font-Size="Large" ForeColor="Blue"></asp:Label>
                        </FooterTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
