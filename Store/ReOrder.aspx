<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Store/ReOrder.aspx.cs" Inherits="Store_ReOrder" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
    <div class="bxmain inner_content" style="float:right;width:57%;margin-right:20px;margin-top:1px;">
        <h2><span></span></h2>
        
                <asp:Label ID="lblDemandMsg" runat="server" Text="" Font-Bold="true" Font-Size="Medium" Visible="false" ></asp:Label>
     <asp:GridView ID="GridViewSavedItems" runat="server" Width="100%" AutoGenerateColumns="false" >

          <Columns>
             <asp:TemplateField HeaderText="Item Name">
                 <ItemTemplate>
                     <asp:Label ID="itemname"  Width="450px"  Text='<%# Bind("Item_Name") %>' runat="server" />
                     <asp:HiddenField ID="hfitemcode" runat="server" Value='<%# Bind("ItemCode") %>' />
                     <asp:HiddenField id="hfItemId" runat="server" Value='<%# Bind("Id") %>' />
                 </ItemTemplate>               
             </asp:TemplateField>
               <asp:TemplateField HeaderText="Order Quantity" ItemStyle-Width="100px">
                 <ItemTemplate>
<%--                     <asp:Label ID="orderqty"  Width="100px"  Text='<%# Bind("Order_Quantity") %>' runat="server" />--%>
                     <asp:TextBox  ID="orderqty"  Width="40px"  Text='<%# Bind("Order_Quantity") %>' runat="server" />
                 </ItemTemplate>               
             </asp:TemplateField>
               <asp:TemplateField ItemStyle-Width="88px" Visible="false">
                 <ItemTemplate>
                     <asp:LinkButton ID="lnkConsumptionNew" runat="server" Text="Consumption" OnClick="lnkConsumption_Click" CommandArgument='<%# Bind("ItemCode") %>'></asp:LinkButton>
                 </ItemTemplate>
             </asp:TemplateField>
              <asp:BoundField DataField="01Months" HeaderText="01 Mon" />
              <asp:BoundField DataField="03Months" HeaderText="03 Mon" />
              <asp:BoundField DataField="06Months" HeaderText="06 Mon" />
              <asp:BoundField DataField="09Months" HeaderText="09 Mon" />
              <asp:BoundField DataField="12Months" HeaderText="12 Mon" />
              <asp:TemplateField ItemStyle-Width="20px">
                  <ItemTemplate>
                      <asp:ImageButton ID="delbtn" runat="server" ImageUrl="~/images/deletebtn.png"
                                            Height="11px" Width="10px" CausesValidation="false" OnClientClick='return confirm("Do you want to delete this record?");'
                                            CommandArgument='<%# Eval("Id") %>' OnClick="delbtn_Click"  />
                  </ItemTemplate>
              </asp:TemplateField>
                       
             
             </Columns>
       
         </asp:GridView>
        <div style="text-align:center;width:100%">
        <asp:Button ID="btnUpdateQty" runat="server" Text="Update Qty" OnClick="btnUpdateQty_Click" />
        <asp:Button runat="server" Text="Generate Demand Requisition" ID="btnGenrate" Visible="false" OnClick="btnGenrate_Click" />

            <asp:Button runat="server" Text="Generate Internal Requisition" ID="btnDemand" Visible="false" OnClick="btnDemand_Click" />
            </div>
    </div>
    
    <asp:Panel ID="pnlGen" runat="server" CssClass="lightbox" Visible="false">
        <table border="0" cellpadding="0" cellspacing="0" class="bxmain tbl_form" width="100%">
           
            <tr>
                <td align="left" colspan="2">
                    <asp:Button ID="btnGenerateNewDemand" runat="server" Text="Generate" OnClick="btnGenerateNewDemand_Click" />
                    <asp:Button ID="btnInternal" runat="server" Text="Generate" OnClick="btnInternal_Click" Visible="false" />
                    <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" />
                 
                </td>
            </tr>
        </table>
    </asp:Panel>
      <div class="bxmain inner_content" style="width: 40%; margin-bottom: 10px;">
        <h2><span></span></h2>
     
        
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="40%">Departments :</td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlSubDept" runat="server" ></asp:DropDownList></td>
                
                                <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
                <asp:HiddenField ID="HiddenField_YearlyCounter" runat="server" />
                
    <asp:HiddenField ID="HiddenField_counter" runat="server" />
                
                                <asp:Label ID="Labeb_Requisition_No" Style="color: red;" Visible="false" ToolTip="Requisition Number"
                                    runat="server" CssClass="red"></asp:Label>
            </tr>
            <tr>
                <td align="right" width="40%">Category :</td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"></asp:DropDownList></td>
            </tr>

              <tr>
                <td align="right" width="40%">Sub Category :</td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlSubCategory" runat="server"></asp:DropDownList></td>
            </tr>
              <tr>
                <td align="right" width="40%">Item Name :</td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtItemName" runat="server"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfItemCode" runat="server" />
                    </td>
            </tr>
               <tr>
                <td align="right" width="40%">Specification :</td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtSpecification" runat="server"></asp:TextBox>
            </tr>
                <tr>
                <td align="right" width="40%">
                    Send To Department :
                </td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlSendTo" runat="server"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">
                    Remarks :
                </td>
                <td align="left" width="60%">
                   <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Width="200px" Height="75px"></asp:TextBox>
                    
                    <asp:HiddenField ID="hdfYearlyCounter" runat="server" />
                    <asp:HiddenField ID="hdfNewDemandNo" runat="server" />
                </td>
            </tr>
              <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </td>

            </tr>
             <tr>
             <td align="left" colspan="2">
                 
                <asp:Label ID="lblNewMsg" runat="server" Text="" Font-Bold="true" Font-Size="Medium" Visible="false" ></asp:Label>
             </td></tr>

            </table>
          </div>
    
    <div id="panelbox" class="lightbox" runat="server" visible="false"  style="height:500px" >
        <asp:Panel ID="ItemConsumptionDetailPanel" runat="server" style="height:440px;overflow-y:scroll;" >
            <div style="width:100%;text-align:center">
                <h3>Previous Month Item Consumption</h3>
            </div>
          <asp:GridView runat="server" ID="Gridview_Consumption"  >
              
          </asp:GridView>
           
        </asp:Panel>
         <div style="text-align:center;width:100%">
        <asp:Button runat="server" Text="Close" ID="closbtn" OnClick="closbtn_Click" />
          </div>
    </div>
      <div class="bxmain inner_content" style="width: 40%;">

      <asp:Button ID="Addbtn" Text="Add" runat="server" style="float:right" Visible="false" OnClick="Addbtn_Click" />

     <asp:GridView ID="gridview" runat="server" Width="100%" AutoGenerateColumns="false" >
         <Columns>
             <asp:TemplateField HeaderText="Item Name">
                 <ItemTemplate>
                     <asp:LinkButton ID="itemname"  Width="150px" CommandArgument='<%# Bind("Item_Code") %>'  Text='<%# Bind("Item_Name") %>' Enabled="false" style="text-decoration:none;color:black"  OnClick="itemname_Click" runat="server" />
                     <asp:HiddenField ID="hfitemcode" runat="server" Value='<%# Bind("Item_Code") %>' />
                 </ItemTemplate>               
             </asp:TemplateField>
              <asp:TemplateField HeaderText="Min Level" >
                 <ItemTemplate>
                     <asp:TextBox ID="lblMinLevel" width="55px" Enabled="false" Text='<%# Bind("Min_Level") %>'  runat="server" />
                 </ItemTemplate>            
             </asp:TemplateField>
                <asp:TemplateField HeaderText="Max Level"  >
                 <ItemTemplate>
                     <asp:TextBox ID="lblMaxLevel" width="55px" Enabled="false"  Text='<%# Bind("Max_Level") %>'   runat="server" />
                 </ItemTemplate>            
             </asp:TemplateField>
               <asp:TemplateField HeaderText="Par Level" >
                 <ItemTemplate>
                     <asp:TextBox ID="lblParLevel" width="55px"  Enabled="false" Text='<%# Bind("Par_Level") %>'   runat="server" />
                 </ItemTemplate>            
             </asp:TemplateField>
              <asp:TemplateField HeaderText="Stock" >
                 <ItemTemplate>
                     <asp:Label ID="lblStock" width="40px"   Text='<%# Bind("Stock") %>' runat="server" />
                 </ItemTemplate>            
             </asp:TemplateField>
           <%--  <asp:TemplateField>
                 <ItemTemplate>
                     <asp:LinkButton ID="lnkConsumption" runat="server" Text="Consumption" OnClick="lnkConsumption_Click" CommandArgument='<%# Bind("Item_Code") %>'></asp:LinkButton>
                 </ItemTemplate>
             </asp:TemplateField>--%>
              <asp:TemplateField HeaderText="Update"  Visible="false">
                    <ItemTemplate>
                      <asp:ImageButton ID="btnUpdate" runat="server" Text="Update" OnClientClick="return confirm('Do you want to Update this record?');"
                         ToolTip="Update"   CommandArgument='<%# Eval("Item_Code") %>' onclick="btnUpdate_Click" ImageUrl="~/Images/updatebtn.png" Width="16"/>
                    </ItemTemplate>
                </asp:TemplateField>
             <asp:TemplateField >
                 <HeaderTemplate>
                      <asp:CheckBox ID="chkboxall" runat="server" OnCheckedChanged="chkboxall_CheckedChanged" AutoPostBack="true"  />
                 </HeaderTemplate>
                    <ItemTemplate>
                      <asp:CheckBox ID="chkbox" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
             </Columns>
         </asp:GridView>
           </div>
    

</asp:Content>

