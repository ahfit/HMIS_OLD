<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="DepartmentWiseParLevels.aspx.cs" Inherits="Store_DepartmentWiseParLevels" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemID.ClientID %>").value = e.get_value();
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <asp:ScriptManager id="ScrMn" runat="server"></asp:ScriptManager>
     <div class="bxmain inner_content" style="width:100%;">
           <h2><span>Re-Order</span></h2>
          <asp:Label ID="lblDemandMsg" runat="server" Text="" Font-Bold="true" Font-Size="Medium" Visible="false" ></asp:Label>
     <table style=" margin: auto; align-content:center">
       
         <tr>
            
             <td style= text-align: right;" align="right"> Request Department :</td>
            <td>
                <asp:DropDownList ID="ddlDept" runat="server" Width="202">
                </asp:DropDownList>
            </td>
             <td style= text-align: right;" align="right"> Request Subdepartment :</td>
            <td>
                <asp:DropDownList ID="ddl_Department" runat="server" Width="202">
                </asp:DropDownList>
                <asp:HiddenField ID="HiddenField_YearlyCounter" runat="server" />
                <asp:HiddenField ID="HiddenField_counter" runat="server" />
                <asp:Label ID="Labeb_Requisition_No" Style="color: red;" Visible="false" ToolTip="Requisition Number"
                                    runat="server" CssClass="red"></asp:Label>
            </td>
     <td align="right">
                    Send To Department :
                </td>
                <td align="left" >
                    <asp:DropDownList ID="ddlSendTo" runat="server"></asp:DropDownList>
                </td>

               </tr>
          <tr>
              <td style="text-align: right;" align="right">Category :</td>
             <td >
                <asp:DropDownList ID="ddl_Category" runat="server" AutoPostBack="true" DataTextField="Financial_Company_Name" OnSelectedIndexChanged ="ddl_Category_SelectedIndexChanged" DataValueField="Financial_Company_Id" Width="202px">
                </asp:DropDownList>
            </td>
                <td align="right" >Sub Category :</td>
                <td align="left" >
                    <asp:DropDownList ID="ddlSubCategory" runat="server"></asp:DropDownList></td>
              
          
            <td style= text-align: right;" align="right">Item Name :</td>
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
              <td align="right" >
                    Remarks :
                </td>
                <td align="left" >
                   <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Width="200px" Height="75px"></asp:TextBox>
                    
                    <asp:HiddenField ID="hdfYearlyCounter" runat="server" />
                    <asp:HiddenField ID="hdfNewDemandNo" runat="server" />
                </td>

              <td align="right" >
                    Status :
                </td>
                <td align="left" >
                   <asp:DropDownList ID="ddlStatus" runat="server">
                       <asp:ListItem Value="0" Text="---ALL---"></asp:ListItem>
                       <asp:ListItem Value="1" Text="Below Minimum Level"></asp:ListItem>
                   </asp:DropDownList>
                </td>
           <td class="style2">
                            Manufacturer :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_Manufacturer" runat="server" 
                                DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id" 
                                Width="200px" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
       </tr>
         <tr>
              <td style= text-align: right;" align="right">Specification :</td>
                <td align="left" >
                    <asp:TextBox ID="txtSpecification" runat="server"></asp:TextBox>
            </td>
            <td align="center" colspan="2">
                <asp:Button ID="Button1" runat="server" Text="Search" OnClientClick="ButtonSave_Click" OnClick="Button1_Click" />
                <asp:Button ID="btnGenrate" Text="Generate DR"  runat="server" OnClick="btnGenrate_Click" Visible="false" />
                <asp:Button ID="btnDemand"  Text="Generate IR" runat="server"  OnClick="btnDemand_Click"  />
            </td>
               <td align="right" colspan="2">
                 
                <asp:Label ID="lblNewMsg" runat="server" Text="" Font-Bold="true" Font-Size="Medium"  ></asp:Label>
             </td>
          
                </tr>
     
    
            </table>
             <br />
         <div class="bxmain inner_content" style="width:100%;">

         
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:GridView  ID="GridView1"  AllowSorting="true"
                             AutoGenerateColumns="false"
                             runat="server"  Width="100%" >
              <Columns>
                  <asp:TemplateField HeaderText="Sr#">
                      <ItemTemplate>
                          <%#Container.DataItemIndex+1 %>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Item Code" SortExpression="Item_Code">
                      <ItemTemplate>
                          <asp:HiddenField ID="hfItemCode" runat="server" Value='<%#Bind("Item_Code") %>'/>
                          <asp:Label  ID="lblItem_Code" runat="server" Text='<%#Bind("Item_Code") %>'></asp:Label>
                         <%-- <asp:LinkButton ID="lnkItemCode" runat="server"  OnClick="lnkItemCode_Click"  Text='<%#Bind("Item_Code") %>'></asp:LinkButton>--%>

                      </ItemTemplate>
                  </asp:TemplateField>
                  
                   <asp:TemplateField HeaderText="Item Name" SortExpression="Item_Name">
                      <ItemTemplate>
                          <asp:Label ID="lblItem_Name" runat="server" Text='<%#Bind("Item_Name") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>

                   <asp:TemplateField ControlStyle-Width="100" HeaderText="Generic" SortExpression="GenericName">
                      <ItemTemplate>
                          <asp:Label ID="lblGenericName" runat="server" Text='<%#Bind("GenericName") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <%--<asp:TemplateField ControlStyle-Width="100" HeaderText="Generic" SortExpression="Unit">
                      <ItemTemplate>
                          <asp:Label ID="lblUnit" runat="server" Text='<%#Bind("Unit") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>--%>
                   <asp:TemplateField ControlStyle-Width="100" HeaderText="Manufacturer" SortExpression="Manufacturer_Name">
                      <ItemTemplate>
                          <asp:Label ID="lblManufacturer" runat="server" Text='<%#Bind("Manufacturer_Name") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>

                  
                  <asp:TemplateField ControlStyle-Width="100" Visible="false" HeaderText="Par Level"  SortExpression="Par_Level">
                      <ItemTemplate>
                          <asp:TextBox ID="lblPar_Level"   runat="server" Text='<%#Bind("Par_Level") %>'></asp:TextBox>
                      </ItemTemplate>
                  </asp:TemplateField>

                 

                    <asp:TemplateField ControlStyle-Width="50" HeaderText="Min Level" SortExpression="Min_Level">
                       
                      <ItemTemplate>
                          <asp:TextBox ID="lblMin_Level" runat="server" Text='<%#Bind("Min_Level") %>' Enabled="false"></asp:TextBox>
                      </ItemTemplate>
                  </asp:TemplateField>

                       <asp:TemplateField ControlStyle-Width="50" HeaderText="Max Level" SortExpression="Max_Level">
                           <ItemStyle Width="50px" />
                      <ItemTemplate>
                          <asp:TextBox ID="lblMax_Level" runat="server" Text='<%#Bind("Max_Level") %>'
                               AutoPostBack="true" OnTextChanged="lblMax_Level_TextChanged" Enabled="false"></asp:TextBox>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField ControlStyle-Width="50" HeaderText="Re Order" SortExpression="Re_Order">
                       <ItemStyle Width="50px" />
                      <ItemTemplate>
                          <asp:TextBox ID="lblRe_Order"   runat="server" Text='<%#Bind("Re_Order") %>'
                               AutoPostBack="true" OnTextChanged="lblRe_Order_TextChanged" Enabled="false"></asp:TextBox>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField ControlStyle-Width="50" HeaderText="Stock" SortExpression="Stock">
                      <ItemTemplate>
                          <asp:Label ID="lblStock" runat="server" Text='<%#Bind("Stock") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField ControlStyle-Width="50" HeaderText="Hospital Stock" SortExpression="Hospitalstock" Visible="false">
                      <ItemTemplate>
                          <asp:Label ID="lblHospitalStock" runat="server" Text='<%#Bind("Hospitalstock") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                 <asp:TemplateField ControlStyle-Width="50" HeaderText="1 Month" SortExpression="01Months">
                      <ItemTemplate>
                          <asp:Label ID="lbl_1Month" runat="server" Text='<%#Bind("01Months") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField ControlStyle-Width="50" HeaderText="3 Months" SortExpression="03Months">
                      <ItemTemplate>
                          <asp:Label ID="lbl_3Months" runat="server" Text='<%#Bind("03Months") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField ControlStyle-Width="50" HeaderText="6 Months" SortExpression="06Months">
                      <ItemTemplate>
                          <asp:Label ID="lbl_6Months" runat="server" Text='<%#Bind("06Months") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField ControlStyle-Width="50" HeaderText="9 Months" SortExpression="09Months">
                      <ItemTemplate>
                          <asp:Label ID="lbl_9Months" runat="server" Text='<%#Bind("09Months") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField ControlStyle-Width="50" HeaderText="12 Months" SortExpression="12Months">
                      <ItemTemplate>
                          <asp:Label ID="lbl_12Months" runat="server" Text='<%#Bind("12Months") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField ControlStyle-Width="70" HeaderText="Last Received Date" SortExpression="LastDemandDate">
                      <ItemTemplate>
                          <asp:Label ID="lbl_LastDeamndDate" runat="server" Text='<%#Bind("LastDemandDate") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField ControlStyle-Width="50" HeaderText="Last Received Qty" SortExpression="LastDemandQty">
                      <ItemTemplate>
                          <asp:Label ID="lbl_LastDemandQty" runat="server" Text='<%#Bind("LastDemandQty") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="AppliedQty" HeaderText="Applied Qty"/>
                  <asp:TemplateField ControlStyle-Width="100" HeaderText="Request Quantity" SortExpression="ReqQty">
                      <ItemTemplate>
                          <asp:TextBox ID="lbl_ReqQty" runat="server" Text='<%#Bind("ReqQty") %>'></asp:TextBox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField>
                      <HeaderTemplate>
                          <asp:CheckBox ID="chkHead" runat="server" AutoPostBack="true" 
                              OnCheckedChanged="chkHead_CheckedChanged" />
                      </HeaderTemplate>
                      <ItemTemplate>
                          <asp:CheckBox ID="chkBody" runat="server" />
                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
                      </asp:GridView>
           
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                        <progresstemplate>
                                                <div style="position: fixed; text-align: center; 
                                                      height: 100%; width: 100%; top: 0; right: 0; 
                                                      left: 0; z-index: 9999999;
                                                       background-color: #ffffff; opacity: 0.7;">
                                                    <span style="border-width: 0px; 
                                                           position: fixed; padding: 50px; 
                                                            font-size: 36px;
                                                            left: 40%; top: 40%;">
                                                             <img src="../images/loading.gif"  />  </span>
                                                </div>
                                            </progresstemplate>
                                    </asp:UpdateProgress>
                    </ContentTemplate>
                </asp:UpdatePanel>
             </div>
         </div>
</asp:Content>

