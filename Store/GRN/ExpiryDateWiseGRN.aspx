<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="~/Store/GRN/ExpiryDateWiseGRN.cs" Inherits="Store_ExpiryDateWiseGRN" %>
<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>
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
           <h2><span>Expiry Date Wise Receiving Report</span></h2>
                <table class="style1">
                    <tr>
                        <td class="style2">
                            Department :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_SubDeptId" runat="server" 
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                                Width="200px" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td class="style2">
                            Suppliers :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_Manufacturer" runat="server" 
                                DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id" 
                                Width="200px" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            Item Name :
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="txt_ItemName" runat="server" Width="200px" AutoPostBack="false">
                            </asp:TextBox>
                            <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txt_ItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2">
                    </asp:AutoCompleteExtender>
                            <asp:HiddenField ID="hfItemCode" runat="server" />
                            <%--<asp:AutoCompleteExtender ID="txt_ItemName_AutoCompleteExtender" runat="server" DelimiterCharacters=""
                                Enabled="True" ServiceMethod="GetListofItems" MinimumPrefixLength="1" EnableCaching="true"
                                ServicePath="" TargetControlID="txt_ItemName">
                            </asp:AutoCompleteExtender>--%>
                        </td>
                    </tr>
                     <tr>
                        <td class="style2">
                            PO # :
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="txtPoNo" runat="server" Width="200px" AutoPostBack="false">
                            </asp:TextBox>
                            </td>
                         </tr>
                    <%--<tr>
                        <td class="style2">
                            Start Date<strong> :</strong></td>
                        <td class="style3">
                               <igsch:webdatechooser id="WebDateChooser_Start_Date" runat="server" width="202px" AutoPostBack-ValueChanged="false">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:webdatechooser>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            End Date<strong> :</strong></td>
                        <td class="style3">
                          <igsch:WebDateChooser ID="WebDateChooser_end_Date" runat="server" Width="202px" AutoPostBack-ValueChanged="false">
                                   
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                    </tr>--%>


                    <tr>
                        <td class="style2">
                            Start Date :</td>
                        <td class="style3">
                            &nbsp;<asp:TextBox ID="txtStartDate" runat="server" TextMode="Date">
                    </asp:TextBox>
                            <asp:HiddenField ID="hfIStartDate" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            End Date :</td>
                        <td class="style3">
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date">
                    </asp:TextBox>
                            <asp:HiddenField ID="hfEndDate" runat="server" />
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
     <rsweb:reportviewer id="ReportViewer1" runat="server" Width="100%">
                </rsweb:reportviewer>
    </div>
</asp:Content>
