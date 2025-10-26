<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="StockAdjustment.aspx.cs" Inherits="Store_StockAdjustment" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
     <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span>Stock Adjustment</span></h2>

          <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
              <tr>
                <td align="right" width="40%">Location :</td>
                <td align="left" width="60%">
                    
                    <asp:DropDownList ID="ddlLocation" runat="server" Width="256px"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">Vendor :</td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlVendor" runat="server" Width="256px"></asp:DropDownList></td>
            </tr>
            
            <tr>
                <td align="right" width="40%">Item Name :</td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtItemName" runat="server"></asp:TextBox>
                    <ajax:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                       CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList" 
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </ajax:AutoCompleteExtender>
                    <asp:HiddenField ID="hfItemCode" runat="server" />
                </td>
            </tr>
              <tr>
                  <td></td>
                  <td>
                      <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                      <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                  </td>
                  
              </tr>
              </table>
     </div>
    <asp:UpdatePanel ID="upt"  runat="server">
        <ContentTemplate>
            <div style="text-align:center">
            <asp:Label ID="lblMsg" runat="server" Text="" Font-Size="Larger" style="padding:5px" ForeColor="Red" Font-Bold="true"></asp:Label>
                </div>
     <asp:GridView ID="gvStockItems" runat="server" Width="100%" AutoGenerateColumns="false">

      <Columns>
          <asp:TemplateField HeaderText="Sr. #">
              <ItemTemplate>
                  <%# Container.DataItemIndex+1 %>
              </ItemTemplate>
          </asp:TemplateField>
         
          <asp:BoundField HeaderText="Item Code" DataField="Item_Code" />
          <asp:BoundField HeaderText="Item Name" DataField="Item_Name" />
          <asp:BoundField HeaderText="Stock" DataField="Stock" />
         <asp:TemplateField  HeaderText="T.P">
             <ItemTemplate>
                 <asp:TextBox ID="txtRate" runat="server" Text='<%# Eval("Rate") %>' Width="100px"></asp:TextBox>
             </ItemTemplate>
         </asp:TemplateField>
          <asp:TemplateField HeaderText="Addition">
              <ItemTemplate>
                  <asp:HiddenField ID="hfStock" runat="server" Value='<%# Eval("Stock") %>' />
                  <asp:HiddenField ID="hfItem_Code" runat="server" Value='<%# Eval("Item_Code") %>' />
                  <asp:TextBox ID="txtAdd" runat="server" Text="0" OnTextChanged="txtAdd_TextChanged" AutoPostBack="true"  Width="100px" ></asp:TextBox>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Subtraction">
              <ItemTemplate>
                  <asp:TextBox ID="txtSubtract" OnTextChanged="txtSubtract_TextChanged" AutoPostBack="true" runat="server" Text="0"   Width="100px" ></asp:TextBox>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Balance">
              <ItemTemplate>
                  <asp:TextBox ID="txtBalance" Enabled="false" runat="server" Text='<%# Eval("Stock") %>' Width="100px" ></asp:TextBox>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField   HeaderText="Remarks">
              <ItemTemplate>
                  <asp:TextBox ID="txtRemarks" runat="server"  TextMode="MultiLine" Width="150px" ></asp:TextBox>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField Visible="false" HeaderText="Expiry Date">
              <ItemTemplate>
                  <asp:TextBox ID="txtExpiry" runat="server"  TextMode="Date" Width="150px" ></asp:TextBox>
              </ItemTemplate>
          </asp:TemplateField>
            <asp:TemplateField ControlStyle-Width="15px">
                <HeaderTemplate >
                    <asp:CheckBox ID="chkall" runat="server" OnCheckedChanged="chkall_CheckedChanged" AutoPostBack="true" />
                </HeaderTemplate>
              <ItemTemplate>
                    <asp:CheckBox ID="chksingle" runat="server" Width="25px" Height="25px" />
              </ItemTemplate>
          </asp:TemplateField>
      </Columns>

  </asp:GridView>
    

        </ContentTemplate>

    </asp:UpdatePanel> 
</asp:Content>

