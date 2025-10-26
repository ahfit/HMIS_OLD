<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="SearchItemsNarcoticsReport.aspx.cs" Inherits="Store_SearchItemsNarcoticsReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemID.ClientID %>").value = e.get_value();
        }
    </script>
    <style type="text/css">
        .auto-style1 {
            height: 22px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScrMn" runat="server"></asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Mark Items Narcotic </span></h2>
        <table style="width: 100%; margin: auto">

            <tr>
                <td style="width: 45%; text-align: right;" align="right">Category :</td>
                <td>
                    <asp:DropDownList ID="ddl_Category" runat="server" AutoPostBack="true" DataTextField="Financial_Company_Name" OnSelectedIndexChanged="ddl_Category_SelectedIndexChanged" DataValueField="Financial_Company_Id" Width="202px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">Sub Category :</td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlSubCategory" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td style="width: 45%; text-align: right;" align="right">Item Name :</td>
                <td>
                    <asp:TextBox ID="txtItemName" runat="server"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfItemID" runat="server" />
                </td>
            </tr>

            <tr style="display:none">
                <td align="right" width="40%" class="auto-style1">Status :</td>
                <td align="left" width="60%" class="auto-style1">
                    <asp:DropDownList ID="ddl_Status" Enabled="false" runat="server">
                        <asp:ListItem Selected="True" Value="0"> Active </asp:ListItem>
                        <asp:ListItem Value="1"> InActive </asp:ListItem>
                    </asp:DropDownList></td>
            </tr>


            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="Button1" runat="server" Text="View Report" OnClick="Button1_Click" />

                    <%--<asp:Button ID="btnMarkExpensive" runat="server" Text="Mark Narcotics"  OnClick="btnMarkExpensive_Click" />--%>
             
                </td>

            </tr>
            <tr>
                <td align="right" colspan="2">

                    <asp:Label ID="lblNewMsg" runat="server" Text="" Font-Bold="true" Font-Size="Medium" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <%--<asp:GridView  ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound"  Width="100%">
              <Columns>
                  <asp:TemplateField HeaderText="Sr#">
                      <ItemTemplate>
                          <%#Container.DataItemIndex+1 %>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField HeaderText="Item Code" DataField="Item_Code" />
                  <asp:BoundField HeaderText="Item Name" DataField="Item_Name" />
                  <asp:TemplateField HeaderText="Is Narcotics">
                      <ItemTemplate>
                          <asp:HiddenField ID="hfIs_Expensive" runat="server" Value='<%# Eval("Is_Narcotic") %>' />
                          <asp:HiddenField ID="hf_ItemCode" runat="server" Value='<%# Eval("Item_Code") %>' />
                          <asp:CheckBox ID="chkbox"  runat="server" />
                          <asp:LinkButton ID="btnUnmark" runat="server" CommandArgument='<%# Eval("Item_Code") %>' OnClick="btnUnmark_Click" Visible="false"  Text="Unmark"></asp:LinkButton>
                      </ItemTemplate>

                  </asp:TemplateField>
                  
              </Columns>
                      </asp:GridView>--%>
                    <rsweb:ReportViewer id="ReportViewer1" runat="server" width="90%">
                    </rsweb:ReportViewer>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

