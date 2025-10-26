<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Registration_AdmitPatient, App_Web_gswfk1g0" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../SpryAssets/SpryCollapsiblePanel.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bx_rad">
        <ul id="CollapsiblePanel1">
            <li><strong>&nbsp;Click here for Search</strong></li><li>
                <asp:Panel ID="Panel2" runat="server" Width="100%">
                </asp:Panel>
            </li>
        </ul>
    </div>
    <br />
    <div align="center">
        <asp:Button ID="Button1" runat="server" Text="Search" />
     <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Blue"></asp:Label></div>
    <br />
    <asp:GridView ID="GridViewSearch" runat="server" Width="100%" BackColor="LightGoldenrodYellow" AllowPaging="True"
        PageSize="100">
        <Columns>
            <%-- <asp:HyperLinkField DataTextField="[Registration No],[Visit No]" NavigateUrl="~/Patient Billing/PatientAdvancesReport.aspx?RegNo={0}&YearlyNo={1}" />--%>
             <asp:ButtonField CommandName="WithOutDoctorWise" Text="Hospital Services" />
             <asp:ButtonField CommandName="ServicesReport" Text="Doctor Services" />
            <asp:ButtonField CommandName="AdvanceReport" Text="Advance" />
            <asp:ButtonField CommandName="RefundReport" Text="Refund" />
              
            <%--<asp:ButtonField CommandName="SummaryReport" Text="Summary Report" />--%>
            
          
            <%--<asp:ButtonField CommandName="PatientConsumption" Text="Patient Consumption" />--%>
            <asp:ButtonField CommandName="Discharge" Text="Collection Summary" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images_hacims/run_bill.png"
                        AlternateText="Running Bill" CommandName="Bill" CommandArgument="<%# Container.DataItemIndex %>" />
                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images_hacims/run_bill_comp.png"
                        AlternateText="Running Bill Company" CommandName="BillCompany" CommandArgument="<%# Container.DataItemIndex %>" />
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Bill"
                        Text="Running Bill" Visible="False"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton_company" runat="server" CausesValidation="false" CommandName="BillCompany"
                        Text="Running Bill Company" Visible="False"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton3" runat="server" AlternateText="Final Bill" ImageUrl="~/images/Final_Bill.jpg"
                        CommandName="Final" CommandArgument="<%# Container.DataItemIndex %>" 
                        Height="54px" Width="53px" />
                    <asp:ImageButton ID="ImageButton4" runat="server" AlternateText="Final Bill Company"
                        ImageUrl="~/images/Final_Bill.jpg" CommandName="FinalCompany" 
                        CommandArgument="<%# Container.DataItemIndex %>" Height="52px" Width="53px" />
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="false" CommandName="Final"
                        Text="Final Bill" Visible="false"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
           
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <script type="text/javascript">
<!--
        var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", { contentIsOpen: false });
//-->
    </script>
</asp:Content>
