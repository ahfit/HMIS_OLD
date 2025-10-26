<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="SearchAddPOtoGP.aspx.cs" Inherits="Store_Gatepass_SearchAddPOtoGP" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <%-- <div class="bxmain inner_content" style="width: 100%;">

        </div>--%>
      <asp:Panel ID="panel" runat="server"  visible="false" CssClass="lightbox_bg">
         <div class="lightbox">
             <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                 <div style="display: inline; float: left; width: 95%;">
                <h2><span> Add PO Item For Gate Pass</span></h2>
                </div>
                 <div style="display: inline; float: right; width: 5%;">
                 <asp:ImageButton ID="closepnl" runat="server" ImageUrl="~/images_hacims/icon_delete.gif"  OnClick="Unnamed_Click" />
                 </div>
                 </div>
              <br />
              <asp:HiddenField ID="hfdGPsubid" runat="server" />
            
            
             <div style="display: inline; float: left; width: 25%;" class="bxmain inner_content">
               
                 <asp:DropDownList ID="ddlPo" Width="80%" DataTextField="PO_ID" DataValueField="PO_ID" OnSelectedIndexChanged="ddlPo_SelectedIndexChanged" AutoPostBack="true"  runat="server">

                 </asp:DropDownList>
                      
                 </div>
             <div  style="float: right;width:70%">
                 <asp:GridView ID="gvdPoItems" AutoGenerateColumns="false" Width="100%" runat="server">
                     <Columns>
                         <asp:TemplateField HeaderText="Sr. #">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                        
                <asp:BoundField DataField="PO_ID" HeaderText="PO #" />
                <asp:BoundField DataField="Item_Name" HeaderText="Item Name" />
                <asp:BoundField DataField="Item_Code" HeaderText="Item Code" />
                <asp:BoundField DataField="Qty" HeaderText="Qty" />
                 
                         <asp:TemplateField>
                             <ItemTemplate>
                                 <asp:CheckBox ID="ckcheck" runat="server" Checked="true" />
                                 <asp:HiddenField ID="hfdpoid" Value='<%# Bind("PO_ID") %>' runat="server" />
                                  <asp:HiddenField ID="hfdItemCode" Value='<%# Bind("Item_Code") %>' runat="server" />
                                  <asp:HiddenField ID="hfdQty" Value='<%# Bind("Qty") %>' runat="server" />
                             </ItemTemplate>
                         </asp:TemplateField>
                     </Columns>
                 </asp:GridView>
                 <br />
                 <div style="width:100%;">
                     <asp:Button ID="btnsave" runat="server" style="margin-left: 129px;" Text="Save" OnClick="btnsave_Click" />
                 </div>
             </div>
                
             </div>
          </asp:Panel>
    <div class="bxmain inner_content" style="width: 100%;">
        
        <h2><span>Search Add PO to Gatepass</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="40%">GP # : </td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtGPNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">From Date : </td>
                <td align="left" width="60%">
                    <igsch:WebDateChooser ID="wdcFromDate" runat="server" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">To Date : </td>
                <td align="left" width="60%">
                    <igsch:WebDateChooser ID="wdcToDate" runat="server" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">Type : </td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlGPType" runat="server">
                        <asp:ListItem Selected="True">All</asp:ListItem>
                        <asp:ListItem>Returnable</asp:ListItem>
                        <asp:ListItem>Non Returnable</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 10px; text-align: center; width: 100%;">
        <asp:GridView ID="gvGPValues" runat="server" AutoGenerateColumns="false" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Sr. #">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Gate_PassDate" HeaderText="Date" />
                <asp:BoundField DataField="G_PassNO" HeaderText="GP #" />
                <asp:BoundField DataField="ReferenceNo" HeaderText=" Ref. #" />
                <asp:BoundField DataField="Transporter" HeaderText="Transporter" />
                <asp:BoundField DataField="Vehicle_No" HeaderText="Vehicle #" />
                <asp:BoundField DataField="Trv_From" HeaderText="Trans. From" />
                <asp:BoundField DataField="Trv_To" HeaderText="Trans. To" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkAddPO" runat="server" Text="Assign PO" OnClick="lnkAddPO_Click"></asp:LinkButton>
                        <asp:HiddenField ID="hfdgpsubid" runat="server" Value='<%# Bind("Gate_Pass_Sub_ID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

