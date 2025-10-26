<%@ Page Title="" Language="C#"  MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="SearchItemsReport.aspx.cs" Inherits="Finance_SearchItemsReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

  <div class="bxmain inner_content" style="width:100%;">
           <h2><span>Search Items Report</span></h2>
     <table style="width: 100%; margin: auto">
       
            <tr>
                <td align="right" width="40%">Department :</td>
                <td align="left" width="60%">
                   <asp:DropDownList ID="ddlSubDepartment" runat="server"></asp:DropDownList></td>
            </tr>




         <tr>
            <td style="width: 45%; text-align: right;" align="right">Category :</td>
             <td>
                <asp:DropDownList ID="ddl_Category" runat="server" AutoPostBack="true" DataTextField="Financial_Company_Name" OnSelectedIndexChanged ="ddl_Category_SelectedIndexChanged" DataValueField="Financial_Company_Id" Width="202px">
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
        <tr>
            <td align="center" colspan="4">
                <asp:Button ID="Button1" runat="server" Text="Search"  OnClick="Button1_Click"/>                
              
            </td>
        </tr>     
    </table>
         </div>

 <div style="width: 100%; margin-top:20px;">

        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>












</asp:Content>

