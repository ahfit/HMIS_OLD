<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="ItemExpiry.aspx.cs" Inherits="Store_ItemExpiry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 440px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <table class="diagnosis_list" style="display:none">
           
            <tr>
                <td align="right" class="auto-style1"><strong>Department :</strong></td>
                <td>
                            <asp:DropDownList ID="ddl_SubDepartment" runat="server" 
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                                Width="200px" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
            </tr>
            <tr>
                <td align="right" class="auto-style1"><strong>Category :</strong></td>
                <td>
                    <asp:DropDownList ID="DropDownList_Category" runat="server" Width="202px" DataSourceID="SqlDataSource_Item_Category"
                        DataTextField="Item_Type" DataValueField="Item_Type_Id" AutoPostBack="True">
                    </asp:DropDownList>
                    
                        <asp:SqlDataSource ID="SqlDataSource_Item_Category" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            SelectCommand="category" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter DefaultValue="%" Name="Item_Category" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
                      </td>
            </tr>
            <tr>
                <td align="right" class="auto-style1"><strong>SubCategory :</strong></td>
                <td>
                    <asp:DropDownList ID="DropDownList_Generic_ItemName" runat="server" DataSourceID="SqlDataSource_Generic_Item_Name"
                        DataTextField="Generic_Name" DataValueField="G_N_Id" Width="202px" AutoPostBack="True">
                    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource_Generic_Item_Name" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>" SelectCommand="Select 0 as G_N_Id,'---ALL---' as Generic_Name union SELECT G_N_Id, Generic_Name FROM [Generic_Names] WHERE ([Cat_Id] = @Cat_Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Category" Name="Cat_Id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
                    
                        </td>
            </tr>
            <tr>
                <td align="right" class="auto-style1">&nbsp;</td>
                <td>
                    <asp:Button ID="btn_Search" runat="server" Text="Search" OnClick="btn_Search_Click" />
                    
                        </td>
            </tr>
        </table>
        <br />
        <br />
    </div>

          <div class="bxmain inner_content " style="width:100%;float:left;">
               <h2>
            <span>Expiry </span></h2>
            <asp:GridView ID="GridviewExp" runat="server" AutoGenerateColumns="false" 
                   onprerender="GridviewExp_PreRender" Width="100%" EmptyDataText="No Items Expired in Next 4 Months" >
                   <RowStyle CssClass="GridItem" />
<Columns>

    <asp:TemplateField  HeaderText="Sr. #" ItemStyle-Width="100px">
                     <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                       </ItemTemplate>
         </asp:TemplateField>
    <asp:TemplateField HeaderText="Item Name" ControlStyle-Width="500px">
            <ItemTemplate>
            <asp:Label ID="lbitemName" Text='<%# Bind("Item_Name") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>


    <asp:TemplateField HeaderText="Qty" ControlStyle-Width="100px">
            <ItemTemplate>
            <asp:Label ID="lblQty" Text='<%# Bind("AvaliableQty") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

     <asp:TemplateField HeaderText="Expiry Date" ControlStyle-Width="400px">
            <ItemTemplate>
            <asp:Label ID="lblExpiryDate" Text='<%# Bind("Exp","{0:dd, MMMM , yyyy}") %>' runat="server" />
        </ItemTemplate>

         </asp:TemplateField>
          <asp:TemplateField HeaderText="Days Remaining" ControlStyle-Width="200px">
            <ItemTemplate>
            <asp:Label ID="lblRemaningDays" Text='<%# Bind("RemaningDays") %>' runat="server" />
        </ItemTemplate>

         </asp:TemplateField>
    </Columns>
                </asp:GridView>
               </div>   
           

         <div class="bxmain inner_content " style="width:49%;float:right;display:none">
              <h2>
            <span>Minimum </span></h2>
            <asp:GridView ID="GridViewMin" runat="server" AutoGenerateColumns="false" 
                     onprerender="GridViewMin_PreRender" >
                     <RowStyle CssClass="GridItem" />
<Columns>
    <asp:TemplateField  HeaderText="Sr. #">
                     <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                       </ItemTemplate>
         </asp:TemplateField>

    <asp:TemplateField HeaderText="Item Name">
            <ItemTemplate>
            <asp:Label ID="lbitemNameR" Text='<%# Bind("Item_Name") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>


    <asp:TemplateField HeaderText="Qty">
            <ItemTemplate>
            <asp:Label ID="lblQtyR" Text='<%# Bind("AvaliableQty") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

     <asp:TemplateField HeaderText="Minimum Alert">
            <ItemTemplate>
            <asp:Label ID="lblmin" Text='<%# Bind("MinAlert") %>' runat="server" />
        </ItemTemplate>

         </asp:TemplateField>

     <asp:TemplateField HeaderText="Maximum Level">
            <ItemTemplate>
            <asp:Label ID="LabelMaxLevel" Text='<%# Bind("MaxLevel") %>' runat="server" />
        </ItemTemplate>

         </asp:TemplateField>

     <asp:TemplateField HeaderText="Reorder Level">
            <ItemTemplate>
            <asp:Label ID="LabelReorder" Text='<%# Bind("ReOrder") %>' runat="server" />
        </ItemTemplate>

         </asp:TemplateField>

    </Columns>
                </asp:GridView>
               </div>

</asp:Content>
