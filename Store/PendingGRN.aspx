<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="PendingGRN.aspx.cs" Inherits="Store_PendingGRN" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">


        function ClientItemSelected(sender, e) {
            $get("<%=hfComapnyId.ClientID %>").value = e.get_value();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>

    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 5px;">
        <h2>
            <span>Pending Good Received Note
            </span>
        </h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="50%">Company :</td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtComapny" runat="server" Width="300px"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="Auto_Parties_Extender" runat="server" ServiceMethod="SearchCustomers"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtComapny" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected" CompletionListCssClass="AutoExtender"
                        CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfComapnyId" runat="server" Value="0" />
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">Department :</td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="ddlDepartment" runat="server" DataTextField="Dept_Name" DataValueField="Dept_ID" Width="300px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">Sub Department :</td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="ddlSubdepartment" runat="server" DataTextField="SubDept_Name" DataValueField="SubDept_Id" Width="300px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">PO Head :</td>
                <td align="left" width="50%">
                    <asp:DropDownList ID="ddlPOHead" runat="server" DataTextField="E_Name" DataValueField="E_Code" Width="300px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">Received Date From :</td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" Width="300px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">Received Date To :</td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" Width="300px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    <asp:Label ID="lblMsg" runat="server" Text="" Visible="false" Font-Bold="true" ForeColor="Green"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hdfVID" runat="server" />
    <asp:HiddenField ID="hdfPostCount" runat="server" />
    <asp:HiddenField ID="hdfCompleteCount" runat="server" />
    <asp:UpdatePanel ID="pnlAmount" runat="server">
        <ContentTemplate>


            <div style="width: 100%; margin-left: 60%;">
                Total Post Amount : (
                <asp:Label ID="lblTotalAmount" runat="server" ForeColor="Black" Font-Bold="true" Font-Size="Medium" Text="0"></asp:Label>
                ) <span style="display:none;">Total Complete Amount : ( 
                <asp:Label ID="lblComleteTotalAmount" runat="server" ForeColor="Black" Font-Bold="true" Font-Size="Medium" Text="0"></asp:Label> )</span>
            </div>
            <asp:GridView runat="server" ID="gvPendingGRN" AutoGenerateColumns="false" AllowPaging="true"
                PageSize="50" Width="100%" OnPageIndexChanging="gvPendingGRN_PageIndexChanging" OnRowDataBound="gvPendingGRN_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Sr. #">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                   
                    <asp:TemplateField HeaderText="Receiving #">
                        <ItemTemplate>
                            <asp:Label ID="lblReceiveID" runat="server" Text='<%# Eval("Store_Receive_Main_ID") %>'></asp:Label>
                            <asp:HiddenField ID="hdfInvNo" runat="server" Value='<%# Eval("InvoiceNo") %>' />
                            <asp:HiddenField ID="hdfDCNo" runat="server" Value='<%# Eval("LCNo") %>' />
                            <asp:HiddenField ID="hdfReceiveID" runat="server" Value='<%# Eval("GRNNo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- <asp:HyperLinkField HeaderText="GRN #" DataNavigateUrlFields="PO_ID,Store_Receive_Main_ID" 
                        DataTextField="Store_Receive_Main_ID"
                        DataNavigateUrlFormatString="~/Store/PurchaseRecievingQty_RateReport.aspx?PO_ID={0}&RM_ID={1}" Target="_blank" />--%>
                    <asp:HyperLinkField HeaderText="PO #" DataNavigateUrlFields="PO_ID" DataTextField="PO_ID"
                        DataNavigateUrlFormatString="~/Store/PurchaseOrderReport.aspx?PO_ID={0}" Target="_blank" />

                    <asp:BoundField DataField="Receive_Date" HeaderText="Receive Date" />
                    <asp:BoundField DataField="Party_Name" HeaderText="Company" />
                    <asp:BoundField DataField="Dept_Name" HeaderText="Receive Department" />
                    <asp:BoundField DataField="SubDept_Name" HeaderText="Receive Sub Department" />
                    <asp:BoundField DataField="Name" HeaderText="Receive By" />
                    <asp:BoundField DataField="RecQty" HeaderText="Receive QTY" />
                    <asp:TemplateField HeaderText="Generate GRN" Visible="false">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkGenerate" runat="server" Text="Generate GRN" OnClick="lnkGenerate_Click"
                                CommandArgument='<%# Eval("Store_Receive_Main_ID") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Amount">
                        <ItemTemplate>
                            <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("TotalAmount") %>'></asp:Label>
                            
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Post">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkPost" runat="server" Visible='<%# Eval("PostVis") %>' OnCheckedChanged="chkPost_CheckedChanged" ToolTip ='<%# Eval("Store_Receive_Main_ID") %>'
                                    AutoPostBack="true" />
                            <asp:LinkButton ID="lnkPostView" runat="server" Text="View" 
                                CommandArgument='<%# Eval("Post_Voucher_Trans_ID") %>' Visible="true" OnClick="lnkPostView_Click"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Complete">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkComplete" runat="server" Visible='<%# Eval("CompleteVis") %>' OnCheckedChanged="chkComplete_CheckedChanged"
                                 AutoPostBack="true" />
                             <asp:LinkButton ID="lnkCompleteView" runat="server" Text="View" 
                                CommandArgument='<%# Eval("Complete_Voucher_Trans_ID") %>' Visible="false" OnClick="lnkCompleteView_Click"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                      <asp:HyperLinkField HeaderText="Voucher" DataNavigateUrlFields="Post_Voucher_Trans_ID" 
                        DataTextField="Post_Voucher_Trans_ID"
                        DataNavigateUrlFormatString="~/Finance/CReport_Recipt_Voucher.aspx?VTI={0}" Target="_blank" />
                </Columns>
            </asp:GridView>
            <div style="width: 100%; margin-left: 85%;">
                <asp:Button ID="btnPost" runat="server" Text="Post" Visible="false" OnClick="btnPost_Click" />
                <asp:Button ID="btnComplete" runat="server" Text="Complete" Visible="false" OnClick="btnComplete_Click" />
            </div>

    <asp:Panel ID="pnlPost" runat="server"  Visible="false" CssClass="lightbox">
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="40%"><b>Dr. Head : </b></td>
                <td align="left" width="60%">
                    <asp:GridView ID ="Gvd_GRN_DR" runat="server"  Width="350px" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderText="Head" >
                               
                                <ItemTemplate>
                                    <asp:Label ID="lbl_E_Name" runat="server" Text='<%# Eval("E_Name") %>'></asp:Label>
                                    <asp:HiddenField ID="lbl_E_code" runat="server" Value='<%# Eval("E_Code") %>'></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total Amount">
                               
                                <ItemTemplate>
                                    <asp:Label ID="lbl_amount" runat="server" Text='<%# Bind("TotalAmount", "{0:##,##}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%"><b>Cr. Head : </b></td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlPostCr" runat="server" DataTextField="E_Name" DataValueField="E_Code" Width="350px"></asp:DropDownList>
                </td>
            </tr>
            <%--<tr>
                <td align="right" width="40%"><b>DC #  : </b></td>
                <td align="left" width="60%">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </td>
            </tr>
             <tr>
                <td align="right" width="40%"><b>Invoice #  : </b></td>
                <td align="left" width="60%">
                    <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>
                    
                </td>
            </tr>--%>
            <tr>
                <td align="right" width="40%"><b>Amount : </b></td>
                <td align="left" width="60%">
                    <asp:Label ID="lblPostAmount" runat="server"></asp:Label>
                </td>
            </tr>
             <tr>
                <td align="right" width="40%"><b>Description : </b></td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtPostDescription" runat="server" TextMode="MultiLine" Width="350px" Height="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnPostVoucher" runat="server" Text="Post" OnClick="btnPostVoucher_Click" />
                    <asp:Button ID="btnClosePostPnl" runat="server" Text="Close" OnClick="btnClosePostPnl_Click" />
                    <asp:HiddenField id ="hf_grn_id" runat="server" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlComplete" runat="server" CssClass="lightbox" Visible="false">
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="40%"><b>Dr. Head : </td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlCompleteDr" runat="server" DataTextField="E_Name" DataValueField="E_Code"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">Cr. Head : </td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlCompleteCr" runat="server" DataTextField="E_Name" DataValueField="E_Code"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">Amount : </td>
                <td align="left" width="60%">
                    <asp:Label ID="lblCompleteAmount" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnComplateVoucher" runat="server" Text="Complete" OnClick="btnComplateVoucher_Click" />
                    <asp:Button ID="btnCloseCompletePanel" runat="server" Text="Close" OnClick="btnCloseCompletePanel_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
            
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

