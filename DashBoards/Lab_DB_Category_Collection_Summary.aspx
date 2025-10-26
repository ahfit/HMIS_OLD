<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="Lab_DB_Category_Collection_Summary.aspx.cs" Inherits="DashBoards_Lab_DB_Category_Collection_Summary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset>
        <legend>Search Criteria</legend>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
            <td align="right"><strong>Hospital :</strong></td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="300px"  Enabled="false">
                    
                </asp:DropDownList> 
            </td>
        </tr>
            <tr>
                <td style="padding-bottom: 10px; text-align: right;" width="30%">From Date:
                </td>
                <td style="padding-bottom: 10px; text-align: left;" width="70%">
                    <asp:textbox id="txtDateFrom" runat="server" textmode="Date" Width="150px"></asp:textbox>
                    <asp:textbox id="txtTimeFrom" runat="server" textmode="Time" Width="150px"></asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: 10px;"" align="right">To Date:
                </td>
                <td style="padding-bottom: 10px;">

                    <asp:textbox id="txtDateTo" runat="server" textmode="Date" Width="150px"></asp:textbox>
                    <asp:textbox id="txtTimeTo" runat="server" textmode="Time" Width="150px"></asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: 10px;" align="right">Patient Type:
                </td>
                <td style="padding-bottom: 10px;" align="left">
                    <asp:dropdownlist id="ddlType" runat="server">
                        <asp:ListItem Text="Both" Value="Both"></asp:ListItem>
                        <asp:ListItem Text="OPD" Value="OPD"></asp:ListItem>
                        <asp:ListItem Text="IPD" Value="IPD"></asp:ListItem>
                    </asp:dropdownlist>
                    <asp:button id="Button1" runat="server" text="Search" font-bold="True" font-size="Medium"
                        onclick="Button1_Click" />
                     <asp:button id="btnExportToExcel" runat="server" text="Export to Excel" font-bold="True" font-size="Medium" visible="false"
                        onclick="btnExportToExcel_Click" />
                </td>
               
            </tr>
        </table>
    </fieldset>
    <div style="width: 70%; margin: 0 auto; padding-top: 20px;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <asp:gridview id="gvCategoryCollection" onrowcommand="gvCategoryCollection_RowCommand" runat="server" emptydatatext="No Record(s) Found"
                        style="width: 100%;" autogeneratecolumns="False" ShowFooter="true" OnRowDataBound="gvCategoryCollection_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <asp:LinkButton CommandName="ViewDetails" ID="lnkViewDetails" runat="server" Text =<%# Eval("Category") %>></asp:LinkButton>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lbl1" runat="server" Text=" Total : " ></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true"/>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Total Services">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotalServices" runat="server" Text='<%# Eval("TotalServices") %>'></asp:Label>
                                     <asp:HiddenField ID="hdnTotalServices" runat="server"  Value='<%# Eval("TotalServices") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <asp:Label ID="lblTotalServices_Footer" runat="server" Text=""></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true"/>
                            </asp:TemplateField>

                           
                            <asp:TemplateField HeaderText="Total Amount">
                                <ItemTemplate>
                                    <asp:Label ID="lblServiceCategory" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                                     <asp:HiddenField ID="hdnServiceCategoryId" runat="server"  Value='<%# Eval("ServiceCategoryId") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <asp:Label ID="lblTotalAmount" runat="server" Text=""></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true"/>
                            </asp:TemplateField>
                           <%-- <asp:BoundField DataField="Discount" HeaderText="Discount">
                            <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>--%>
                            <asp:TemplateField HeaderText="Discount">
                                <ItemTemplate>
                                    <asp:Label ID="lblDsicount" runat="server" Text ='<%# String.Format("{0}", Eval("Discount")) %>'></asp:Label>
                                    <asp:HiddenField ID="hfdiscount" runat="server"  Value='<%# Eval("Discount") %>' />
                                </ItemTemplate >
                                <ItemStyle HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <asp:Label ID="lblDis" runat="server" Text=""></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true"/>
                            </asp:TemplateField>
                            

                              <asp:TemplateField HeaderText="Total Services Refund">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotalServiesRefund" runat="server" Text ='<%# String.Format("{0}", Eval("TotalServiesRefund")) %>'></asp:Label>
                                    <asp:HiddenField ID="hfTotalServiesRefund" runat="server"  Value='<%# Eval("TotalServiesRefund") %>' />
                                </ItemTemplate >

                                <ItemStyle HorizontalAlign="Right" />
                                 <FooterTemplate>
                                     <asp:Label ID="lblTotalServiesRefund_Footer" runat="server" Text=""></asp:Label>
                                 </FooterTemplate>
                                 <FooterStyle HorizontalAlign="Right" Font-Bold="true"/>
                            </asp:TemplateField>
                             

                             <asp:TemplateField HeaderText="Refund Amount">
                                <ItemTemplate>
                                    <asp:Label ID="lblRefundAmount" runat="server" Text ='<%# String.Format("{0}", Eval("RefundAmount")) %>'></asp:Label>
                                    <asp:HiddenField ID="hfRefundAmount" runat="server"  Value='<%# Eval("RefundAmount") %>' />
                                </ItemTemplate >

                                <ItemStyle HorizontalAlign="Right" />
                                 <FooterTemplate>
                                     <asp:Label ID="lblRfdAmount_Footer" runat="server" Text=""></asp:Label>
                                 </FooterTemplate>
                                 <FooterStyle HorizontalAlign="Right" Font-Bold="true"/>
                            </asp:TemplateField>
                             
                            <asp:TemplateField HeaderText="Net Income">
                                <ItemTemplate>
                                    <asp:Label ID="lblPaid" runat="server" Text ='<%# String.Format("{0}", Eval("Paid")) %>'></asp:Label>
                                    <asp:HiddenField ID="hfPaid" runat="server"  Value='<%# Eval("Paid") %>' />
                                </ItemTemplate >
                                <ItemStyle HorizontalAlign="Right" Font-Bold="true"/>
                                <FooterTemplate>
                                    <asp:Label ID="lblNetIncome" runat="server" Text="" ></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true"/>
                            </asp:TemplateField>
                                                                                  
                        </Columns>
                    </asp:gridview>

                </td>

            </tr>
        </table>
    </div>
</asp:Content>
