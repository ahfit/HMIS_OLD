<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Store/LastThreePoPrice.cs" Inherits="Store_LastThreePoPrice" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span>Stock Value</span></h2>
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
             <%-- <tr>
                        <td align="right" width="40%">
                            Category :
                        </td>
                      <td align="left" width="60%">
                            <asp:DropDownList ID="ddl_Category" runat="server" 
                                DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id" 
                                Width="200px" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
             <tr>--%>
                <%--<td align="right" width="40%">SubCategory:
                </td>
                <td class="style3">
                    <asp:DropDownList ID="DropDownList_Generic_ItemName" runat="server"
                        DataTextField="Generic_Name" DataValueField="G_N_Id"
                        Width="200px" DataSourceID="SqlDataSource_Generic_Item_Name">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Generic_Item_Name" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
                        ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>" SelectCommand="Select 0 as G_N_Id,'---ALL---' as Generic_Name union SELECT G_N_Id, Generic_Name FROM [Generic_Names] WHERE ([Cat_Id] = @Cat_Id or @Cat_Id=0)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_Category" Name="Cat_Id" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>--%>

           <%-- <tr>
                <td align="right" width="40%">Manufacturer:
                </td>
                <td class="style3">
                    <asp:DropDownList ID="DropDownList_Manufacturer" runat="server"
                        DataTextField="Manufacturer_Name" DataValueField="ID"
                        Width="200px" AutoPostBack="false">
                    </asp:DropDownList>
                </td>
            </tr>
 
            <tr>
                <td align="right" width="40%">Sub Department :</td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlSubDepartment" runat="server"></asp:DropDownList></td>
            </tr>
               <tr>
                <td align="right" width="40%">Zero Quantity <strong> :</strong></td>
                <td class="style3">
                    <asp:RadioButtonList runat="server" ID="rb_list" RepeatDirection="Horizontal"     >
<asp:ListItem Text="Include Zero" Selected="True" Value="-1"></asp:ListItem>
<asp:ListItem Text="Exclude Zero" Value="0"></asp:ListItem>
                        </asp:RadioButtonList>
                </td>
            </tr>--%>
            <tr>
                <td align="right" width="40%">From Date :</td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">To Date :</td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">Item Name :</td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtItemName" runat="server"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList" 
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfItemCode" runat="server" />
                </td>
            </tr>
               <%--<tr >
                 <td align="right" width="40%">Order By :<strong> </strong></td>
                <td class="style3">
                    <asp:DropDownList ID="ddlorderBy" runat="server">
                        <asp:ListItem Value="ASC">Ascending</asp:ListItem>
                        <asp:ListItem Value="DESC">descending</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr> --%>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </td>

            </tr>
        </table>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="90%">
    </rsweb:ReportViewer>
</asp:Content>

