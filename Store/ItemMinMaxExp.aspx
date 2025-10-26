<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="ItemMinMaxExp.aspx.cs" Inherits="Store_ItemsDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 440px;
        }
    </style>
    
        <script type="text/javascript">
            function ClientItemSelected2(sender, e) {
                $get("<%=hfItemCode.ClientID %>").value = e.get_value();
         }
    </script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div>
        <table class="diagnosis_list">

               <tr>
                <td align="right" class="auto-style1"><strong>Hospital :</strong></td>
                <td>
                            <asp:DropDownList ID="ddl_Hospital" runat="server" 

                                Width="250px" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
            </tr>

              <tr>
                <td align="right" class="auto-style1"><strong>Department :</strong></td>
                <td>
                             <asp:DropDownList CssClass="text_dropdown" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged"   DataTextField="Dept_Name" DataValueField="Dept_ID" ID="ddlDepartment" runat="server"
                         DataSourceID="SqlDataSourceDepartment"  AutoPostBack="True" style="text-transform:uppercase;"> </asp:DropDownList>
                    
                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="select Dept_ID, Dept_Name from Department where Hospital_ID=@Hospital_Id"> 
                  <SelectParameters>
                      <asp:ControlParameter ControlID="ddl_Hospital" Name="Hospital_Id" PropertyName="SelectedValue"
                          Type="Int32" />
                  </SelectParameters>
              </asp:SqlDataSource>
                        </td>
            </tr>


           
            <tr>
                <td align="right" class="auto-style1"><strong>Sub Department :</strong></td>
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
                <td align="right" class="auto-style1"><strong>Item Name :</strong></td>
                <td>
                    <asp:TextBox ID="txtItemName" runat="server" Width="203px"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfItemCode" runat="server" />
                    
                        </td>
            </tr>

            <tr>
                <td align="right" class="auto-style1">&nbsp;</td>
                <td>
                    <asp:Button ID="btn_Search" runat="server" Text="Search" OnClick="btn_Search_Click" />
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    
                        </td>
            </tr>
        </table>
        <br />
        <br />
    </div>

             
         <div class="bxmain inner_content " style="width:100%;">
              <h2>
            <span>Minimum</span></h2>
            <asp:GridView ID="GridViewMin" runat="server" AutoGenerateColumns="false" 
                     onprerender="GridViewMin_PreRender" Width="100%" >
                     <RowStyle CssClass="GridItem" />
<Columns>
    <asp:TemplateField  HeaderText="Sr. #">
                     <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                       </ItemTemplate>
         </asp:TemplateField>

    <asp:TemplateField HeaderText="Item Code">
            <ItemTemplate>
            <asp:Label ID="lblItemCode" runat="server" Text='<%# Bind("Item_Code") %>' runat="server" />
            <asp:HiddenField ID="HfSubDeptId" runat="server" Value='<%# Bind("SubDeptId") %>'/>
        </ItemTemplate>
    </asp:TemplateField>


    <asp:TemplateField HeaderText="Item Name">
            <ItemTemplate>
            <asp:Label ID="lbitemNameR" Text='<%# Bind("Item_Name") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField HeaderText="Dosage Form" Visible="false">
            <ItemTemplate>
            <asp:Label ID="lblDosageForm" Text='<%# Bind("DosageForm") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

    <asp:BoundField DataField="PackQty" HeaderText="Pack Size" SortExpression="PackQty"/>
    <asp:BoundField DataField="Unit" HeaderText="UOM" SortExpression="Unit"/>

     <asp:TemplateField HeaderText="Generic">
            <ItemTemplate>
            <asp:Label ID="lblGenericName" Text='<%# Bind("GenericName") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Manufacturer">
            <ItemTemplate>
            <asp:Label ID="lblManufacturer" Text='<%# Bind("ManufacturerName") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>


    <asp:TemplateField HeaderText="Qty">
            <ItemTemplate>
            <asp:Label ID="lblQtyR" Text='<%# Bind("AvaliableQty") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

     <asp:TemplateField HeaderText="Minimum Alert">
            <ItemTemplate>
            <asp:TextBox ID="txtMinLevel" Text='<%# Bind("MinAlert") %>' runat="server" SkinID="intdata"/>
        </ItemTemplate>

         </asp:TemplateField>

     <asp:TemplateField HeaderText="Maximum Level">
            <ItemTemplate>
            <asp:TextBox ID="txtMaxLevel" Text='<%# Bind("MaxLevel") %>' runat="server" SkinID="intdata" />
        </ItemTemplate>

         </asp:TemplateField>

     <asp:TemplateField HeaderText="Reorder Level">
            <ItemTemplate>
            <asp:TextBox ID="txtReorderLevel" Text='<%# Bind("ReOrder") %>' runat="server" SkinID="intdata"/>
        </ItemTemplate>

         </asp:TemplateField>

    
     <asp:TemplateField HeaderText="Select">
         <HeaderTemplate>
             <asp:CheckBox ID="chkselectAll" runat="server" OnCheckedChanged="chkselectAll_CheckedChanged" AutoPostBack="true"/>
         </HeaderTemplate>
            <ItemTemplate>
            <asp:CheckBox ID="chkSelect" runat="server"/>
        </ItemTemplate>

         </asp:TemplateField>

    </Columns>
                </asp:GridView>
               </div>
    <div class="bxmain inner_content " 
        style="display:none;">
               <h2>
            <span>Expiry </span></h2>
            <asp:GridView ID="GridviewExp" runat="server" AutoGenerateColumns="false" 
                   onprerender="GridviewExp_PreRender" >
                   <RowStyle CssClass="GridItem" />
<Columns>

    <asp:TemplateField  HeaderText="Sr. #">
                     <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                       </ItemTemplate>
         </asp:TemplateField>
    <asp:TemplateField HeaderText="Item Name">
            <ItemTemplate>
            <asp:Label ID="lbitemName" Text='<%# Bind("Item_Name") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>


    <asp:TemplateField HeaderText="Qty">
            <ItemTemplate>
            <asp:Label ID="lblQty" Text='<%# Bind("AvaliableQty") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

     <asp:TemplateField HeaderText="Expiry Date">
            <ItemTemplate>
            <asp:Label ID="lblExpiryDate" Text='<%# Bind("Exp","{0:dd, MMMM , yyyy}") %>' runat="server" />
        </ItemTemplate>

         </asp:TemplateField>
          <asp:TemplateField HeaderText="Days Remaining">
            <ItemTemplate>
            <asp:Label ID="lblRemaningDays" Text='<%# Bind("RemaningDays") %>' runat="server" />
        </ItemTemplate>

         </asp:TemplateField>
    </Columns>
                </asp:GridView>
               </div>
</asp:Content>

