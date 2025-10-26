<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="ExpiredDatewiseStockReports"
    codefile="ExpiredDatewiseStockReports.aspx.cs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<style type="text/css">
    .style1
    {
        width:100%;
        text-align:center;
    }
    .style2
    {
        width:50%;
        text-align:right;
    }
    .style3
    {
        width:50%;
        text-align:left;
    }
</style>
     <script type="text/javascript">
         function ClientItemSelected2(sender, e) {
             $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
           <div class="bxmain inner_content" style="width:100%;">
           <h2><span>Datewise Expiry Items</span></h2>
           
                <table class="style1">
                <tr>
                        <td class="style2">
                            Manufacturer:
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="DropDownList_Manufacturer" runat="server" 
                                DataTextField="Manufacturer_Name"   DataValueField="ID"
                                Width="200px" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            Item Name:
                        </td>
                        <td class="style3">
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


                      <tr >
                <td class="style2">From Date :<strong> :</strong></td>
                <td class="style3">
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
               <tr >
                <td class="style2">End Date :<strong> :</strong></td>
                <td class="style3">
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr> 




                    <tr style="display:none;">
                        <td class="style2">
                            Part #<strong> :</strong></td>
                        <td class="style3">
                          <asp:TextBox ID="txtPartno" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            Batch #<strong> :</strong></td>
                        <td class="style3">
                             <asp:TextBox ID="txtOrderNo" runat="server"></asp:TextBox>
    
                            </td>
                    </tr>


                    <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="Button_report" runat="server" Text="View Report" 
                            OnClick="Button_Report_Click" CssClass="btn_1" />
                      </td>
                
           
                    </tr>
            
    </table>
    </div>
    <div>
     <rsweb:reportviewer id="ReportViewer1" runat="server" Width="90%">
                </rsweb:reportviewer>
    </div>
</asp:Content>

