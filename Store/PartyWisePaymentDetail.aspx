<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="true" CodeFile="PartyWisePaymentDetail.aspx.cs" Inherits="Store_PartyWisePaymentDetail" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
        .auto-style1 {
            width: 47%;
            text-align: right;
        }
    </style>
     <script type="text/javascript">


        function ClientItemSelected(sender, e) {
            $get("<%=hfPaymentToId.ClientID %>").value = e.get_value();
        }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>

     <div class="bxmain inner_content" style="width:100%;">
           <h2><span>Party Wise Payment Detail</span></h2>

    <table class="style1">                   
          <tr>
                        <td class="auto-style1">
                            <strong>Date From :</strong></td>
                        <td class="style3">
                          <asp:TextBox ID="txtDateFrom" runat="server" type="Date" ></asp:TextBox>
                            
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <strong>Date To :</strong></td>
                        <td class="style3">
                         
                          <asp:TextBox ID="txtDateTo" runat="server" type="Date"></asp:TextBox>
                            </td>
                    </tr>
        <tr>
                                <td align="right" class="auto-style1">
                                    <strong>Payment to :
                                </strong>
                                </td>
                                <td class="style3">
                                    <asp:TextBox ID="ddlPaymentTo" runat="server" Width="185px"  ></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="Auto_Parties_Extender" runat="server" ServiceMethod="SearchCustomers"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="ddlPaymentTo" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected" CompletionListCssClass="AutoExtender"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                    </asp:AutoCompleteExtender>
                                    <asp:HiddenField ID="hfPaymentToId" runat="server"  Value="0"/>
                                  
                                </td>
                            </tr>
        <tr>
            <td colspan="2" align="center">
                        <asp:Button ID="Button_report" runat="server" Text="View Report" 
                            OnClick="Button_report_Click" CssClass="btn_1" />
                      </td>
                
        </tr>
        </table>
         </div>
     <div>
     <rsweb:reportviewer id="ReportViewer1" runat="server" Width="100%">
                </rsweb:reportviewer>
    </div>

</asp:Content>

