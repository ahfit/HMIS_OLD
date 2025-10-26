<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Pharmacy_Fast_Moving_Item_for_Pharamacist.aspx.cs" Inherits="Store_Pharmacy_Fast_Moving_Item_for_Pharamacist" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %> 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span>Pharmacy Fast Moving Items for Pharamacist</span></h2>
      <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="40%">Sub Department :</td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlSubDepartment" runat="server"></asp:DropDownList></td>
            </tr>
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
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnExport" runat="server" Text="Export To Excel" OnClick = "ExportToExcel" />
                </td>

            </tr>
        </table>
         </div>

<asp:GridView ID="GridAdminService" runat="server" AutoGenerateColumns="false" AllowPaging="True" PageSize="50" OnPageIndexChanging="GridAdminService_PageIndexChanging">
<Columns>
   <asp:TemplateField HeaderText="Sr. #">
        <ItemTemplate>
            <%# Container.DataItemIndex+1 %>
        </ItemTemplate>
    </asp:TemplateField>
  
    <asp:TemplateField HeaderText="Item Code">
            <ItemTemplate>
            <asp:Label ID="lblmainCategory" Text='<%# Bind("Item_Code") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
     <asp:TemplateField HeaderText="Item Name">
            <ItemTemplate>
            <asp:Label ID="lblItemName" Text='<%# Bind("Item_Name") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Receive Qty">
            <ItemTemplate>
            <asp:Label ID="lblCategory" Text='<%# Bind("ReceiveQty") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
        <asp:TemplateField HeaderText="Consume Qty">
            <ItemTemplate>
            <asp:Label ID="lblservicename" Text='<%# Bind("ConsumeQty") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
    </Columns>
    </asp:GridView>

</asp:Content>

