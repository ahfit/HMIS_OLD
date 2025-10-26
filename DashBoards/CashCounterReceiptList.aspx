<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="CashCounterReceiptList.aspx.cs" Inherits="CashCounterReceiptList" %>

    <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset>
        <legend>Search Criteria</legend>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
               <tr>
            <td align="right"><strong>Hospital :</td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
            <tr>
                <td style="padding-bottom: 10px; text-align: right;" width="30%">From Date:
                </td>
                <td style="padding-bottom: 10px; text-align: left;" width="70%">
                    <asp:textbox id="txtDateFrom" runat="server" textmode="Date"></asp:textbox>
                    <asp:textbox id="txtTimeFrom" runat="server" textmode="Time"></asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: 10px;"" align="right">To Date:
                </td>
                <td style="padding-bottom: 10px;">

                    <asp:textbox id="txtDateTo" runat="server" textmode="Date"></asp:textbox>
                    <asp:textbox id="txtTimeTo" runat="server" textmode="Time"></asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: 10px;" align="right">Patient Type:
                </td>
                <td style="padding-bottom: 10px;" align="left">
                    <asp:dropdownlist id="ddlType" runat="server">
                        <asp:ListItem Text="Both" Value="0"></asp:ListItem>
                        <asp:ListItem Text="OPD" Value="OPD"></asp:ListItem>
                        <asp:ListItem Text="IPD" Value="IPD"></asp:ListItem>
                    </asp:dropdownlist>
                    <asp:button id="Button1" runat="server" text="View Report" font-bold="True" font-size="Medium"
                        onclick="Button1_Click" />
         
               
            </tr>
        </table>
       
      

    </fieldset>

       <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
    <div style="width:100%">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" >
    </rsweb:ReportViewer>
    </div>
   
      
</asp:Content>
