<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="PatientTestsReport.aspx.cs" Inherits="Pathology_PatientTestsReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <script type="text/javascript">
         function ClientItemSelected2(sender, e) {
             $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 100%" class="bxmain inner_content">
        <h2><span>Patient Test Reports</span></h2>
        <table style="width: 99%">
            <tr>
                <td style="width: 20%; text-align: right"><strong>MR #:
                </strong>
                </td>
                <td>
                    <asp:textbox id="txtMrNo" runat="server" Width="180px"></asp:textbox>
                </td>
                <td style="width: 20%; text-align: right"><strong>Patient Name :
                </strong>
                </td>
                <td>
                    <asp:textbox id="txtPFName" runat="server"  Width="180px"></asp:textbox>
                </td>
            </tr>
            <tr>
                        <td style="width: 20%; text-align: right">
                            <strong>From Date :</strong></td>
                        <td >
                            <asp:TextBox ID="txtfromdate" runat="server" TextMode="Date"  Width="180px">
                    </asp:TextBox>
                            <asp:TextBox ID="txtTimeFrom" runat="server" textmode="Time"  Width="100px" />
                        </td>
                    
                        <td style="width: 20%; text-align: right">
                            <strong>To Date :</strong></td>
                        <td>
                            <asp:TextBox ID="txttodate" runat="server" TextMode="Date"  Width="180px">
                    </asp:TextBox>
                            <asp:TextBox ID="txtTimeTo" runat="server" textmode="Time" Width="100px"/>
                        </td>
                    </tr>
            <tr>
                        <td style="width: 20%; text-align: right">
                            <strong>Test Status :</strong></td>
                        <td >
                            <asp:DropDownList ID="DDLStatus" runat="server"  Width="182px">
                            </asp:DropDownList>
                       
               <td style="width: 20%; text-align: right">
                            <strong>Test :</strong></td>
                <td class="style3">
                    <asp:TextBox ID="txtS_Name" runat="server"  Width="180px"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="3"
                        TargetControlID="txtS_Name" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfItemCode" runat="server" />

                </td>
            </tr>

            <tr>
                        <td style="width: 20%; text-align: right">
                            <strong>Department :</strong></td>
                        <td >
                                                       <asp:DropDownList ID="ddlDepartment" runat="server" 
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                                Width="182px" >
                            </asp:DropDownList>
                        
                                       
                <td align="right">
                     <strong>User :</strong></td>
                <td>
                    <asp:DropDownList ID="DDLEmployee" runat="server" Width="182px">
                    </asp:DropDownList>
                                       
                </td>
                 <td align="center">
                     &nbsp;</td>
            </tr>

            <tr>
                        <td style="width: 20%; text-align: right">
                            <strong>Shift :</strong></td>
                        <td >
                    <asp:DropDownList ID="DDLShift" runat="server" Width="182px">
                    </asp:DropDownList>
                                                       
                <td align="right">
                     <strong>Test Group :</strong></td>
                <td>
                    <asp:DropDownList ID="DropDownList_MGName" runat="server" Width="182px">
                        </asp:DropDownList>
                        </td>
                 <td align="center">
                     &nbsp;</td>
            </tr>

            <tr>
                        <td style="width: 20%; text-align: right">
                            <strong>Send Out Test :</strong></td>
                        <td >
                            <asp:CheckBox ID="CheckBoxSendOutTest" runat="server" />
                       
                <td align="right">
                     <strong>Lab # :</strong></td>
                <td>
                    <asp:textbox id="txtLabNo" runat="server" Width="180px"></asp:textbox>
                        </td>
                 <td align="center">
                     &nbsp;</td>
            </tr>

            <tr>
                <td colspan="4" align="center">
                    <asp:button id="btnSearch" runat="server" text="Search" OnClick="btnSearch_Click" />
                    <asp:Button ID="Button1" OnClick="btnSearch_Click" runat="server" Text="View Report"
                        CssClass="btn_1"  />
                </td>
            </tr>
        </table>
        
    </div>
    <div style="width: 100%">
            <asp:scriptmanager id="ScriptManager1" runat="server"></asp:scriptmanager>
            <rsweb:reportviewer id="ReportViewer1" runat="server" width="100%">
        </rsweb:reportviewer>
        </div>
</asp:Content>

