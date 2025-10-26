<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPO.aspx.cs" Inherits="IPO"
    MasterPageFile="~/hacims_masterpage_admin.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        function CheckRequirment() {
            if (document.getElementById("TextBox_specificMedicine").value.length == 0) {

            }
        }
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>

    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .item-detail1 {
            position: absolute;
            font-size: 11px;
            font-weight: bold;
            color: #000;
            font-family: arial;
            border: #d7d477 solid 1px;
            border-radius: 5px;
            width: 100px;
            height: auto;
            background: #fffdc5;
            padding: 8px;
            box-shadow: #999 1px 1px 2px;
        }

        .item-details {
            text-indent: -99999px;
            display: inline-block;
        }

        .info {
            background: url(../images_mega/info.png) top center no-repeat;
            min-width: 16px;
            min-height: 16px;
            display: inline-block;
        }

        .style1 {
            width: 100%;
        }

        .style2 {
            text-align: right;
        }

        textarea {
            resize: none;
        }

        .lightbox_bg {
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
       <asp:Panel ID="panel" Visible="false" runat="server"  CssClass="lightbox"> <%-- --%>
        <div >    <%--class="lightbox"--%>
            <div style="display: inline; float: left; width: 98%;" class="bxmain inner_content">

                <h2><span>Stock Detail</span></h2>
               
            </div>
            <div style="margin-top: 10px">

                <asp:GridView ID="Gridview2" AutoGenerateColumns="false" runat="server"  Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.#">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Item Name">
                            <ItemTemplate>
                                <asp:Label ID="lbEName" Text='<%# Bind("Item_Name") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Unit">
                            <ItemTemplate>
                                <asp:Label ID="lbEnaa" Text='<%# Bind("Unit") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Item Code">
                            <ItemTemplate>
                                <asp:Label ID="Item_Code" Text='<%# Bind("Item_Code") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                          <asp:TemplateField HeaderText="Stock">
                            <ItemTemplate>
                                <asp:Label ID="Stock" Text='<%# Bind("Stock") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Department">
                            <ItemTemplate>
                                <asp:Label ID="SubDept_Name" Text='<%# Bind("SubDept_Name") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
                

            </div>
            <div style="width:800px; margin:0 auto;">
             <asp:Button ID="Button_Close"  runat="server" Text="Close" OnClick="Button_Close_Click" CausesValidation="False" />
           </div>
                 </div>
          
    </asp:Panel>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" width="35%">
                <div class="bxmain inner_content" style="width: 100%; height: 270px;">
                    <h2>
                        <span>Official Information</span></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        
                         <tr>
                            <td align="right" width="30%">Types:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddltypes" Enabled="false" runat="server" DataSourceID="SqlDataSourceTypes"
                                    DataTextField="Type_Name" DataValueField="Type_Name" AutoPostBack="True" Width="290px">
                                </asp:DropDownList>
                              
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">From Office :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlFromOffice" runat="server" DataSourceID="SQL_ForSubDepartment"
                                    DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="True" Width="290px"
                                     OnSelectedIndexChanged="ddlFromOffice_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:HiddenField ID="HiddenField3" runat="server" />
                            </td>
                        </tr>
                        <tr style="display:none;">
                            <td align="right">Send To Office :
                            </td>
                            <td>
                                <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
                                <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
                                <asp:DropDownList ID="DropDownList_Department" runat="server" AutoPostBack="True"
                                    DataSourceID="SqlDataSource_Department" DataTextField="Dept_Name" DataValueField="Dept_ID"
                                    OnSelectedIndexChanged="DropDownList_Department_SelectedIndexChanged" Width="290px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">For Store :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownListStore" runat="server" AutoPostBack="False" DataSourceID="SqlDataSourceStore"
                                    Width="290px" DataTextField="SubDept_Name" DataValueField="SubDept_Id" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                </asp:DropDownList>
                                <br />
                                <asp:Label ID="Labeb_Requisition_No" Style="color: red;" ToolTip="Requisition Number"
                                    runat="server" CssClass="red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Requsition Description :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_Requsition_Description" runat="server" Height="131px" TextMode="MultiLine"
                                    Width="290px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            
            <td align="center" valign="top" colspan="2">
                <asp:Label ID="lblMsg" runat="server" Text="Please Select Company." ForeColor="Red"
                    Font-Bold="true" Visible="false"></asp:Label>
                <br />
                <asp:Button ID="Button_update_QTY" runat="server" OnClick="Button_update_QTY_Click"
                    Text="Update Qty" Visible="False" Style="height: 26px" CausesValidation="False" />
                <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="RoleBack" Visible="False"
                    CausesValidation="False" />
                <asp:Button ID="Button4" runat="server" Text="Save & Submit" OnClick="Button4_Click"
                    Visible="False" />
                <asp:Button ID="btnExcludeGST" runat="server" Text="Exclude GST" OnClick="btnExcludeGST_Click"
                    Visible="false" CausesValidation="False" />
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="18"
                            Width="135%" style="margin-left:10px" DataSourceID="SqlDataSource_Medicine_Sub" OnPreRender="GridView1_PreRender"
                            OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="IB_ID"
                            OnRowCommand="GridView1_RowCommand" EnableModelValidation="True">
                            <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />
                            <AlternatingRowStyle CssClass="GridAltItem" />
                            <Columns>
                               
                                <asp:TemplateField ItemStyle-Width="20px">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/deletebtn.png"
                                            Height="11px" Width="10px" CausesValidation="false" OnClientClick='return confirm("Do you want to delete this record?");'
                                            CommandArgument='<%# Eval("Item_Code", "{0}") %>' OnClick="ImageButton2_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                  <asp:TemplateField HeaderText="Sr. #" ItemStyle-Width="10px" HeaderStyle-Width="10px"  >
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1%>
                                    </ItemTemplate>
                                    <ItemStyle Width="4%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Store_Items" Visible="false" ReadOnly="True"   SortExpression="Store_Items" />
                            
                                <asp:TemplateField HeaderText="Item" SortExpression="Store_Items" ItemStyle-Width="180px">
                                    <EditItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Store_Items","{0}") %>'></asp:Label>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" Width="180px" runat="server" Text='<%# Bind("Item_Code") + " - "+ Bind("Store_Items","{0}") %>'></asp:Label>
                                        <br />
                                        <asp:TextBox ID="TextBox_Specification" runat="server" TextMode="MultiLine" Text='<%# Bind("Item_Specification","{0}") %>'
                                            Width="180px"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <strong>GST Rate : </strong>
                                    </FooterTemplate>
                                </asp:TemplateField>
                              
                                <asp:TemplateField HeaderText="Balance" Visible="False"></asp:TemplateField>
                                
                                 <asp:TemplateField HeaderText="Pack" ItemStyle-Width="40px">
                                    <ItemTemplate>
                                        <asp:TextBox Enabled="false" ID="txtPack" runat="server" Width="50px"
                                            OnTextChanged="txtPack_TextChanged" AutoPostBack="true" Text='<%# Bind("Pack", "{0}") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Units / Pack" ItemStyle-Width="40px">
                                    <ItemTemplate>
                                        <asp:TextBox Enabled="false" ID="txtUnitsPack" runat="server" Width="50px"
                                            OnTextChanged="txtUnitsPack_TextChanged" AutoPostBack="true" Text='<%# Bind("Unit_Pack", "{0}") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="QTY" ItemStyle-Width="40px">
                                    <ItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" SkinID="input_grid_num" Text='<%# Bind("Qty", "{0}") %>'
                                            Width="50px" ></asp:TextBox>
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Item_Code", "{0}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate" Visible="false">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txt_item_qty" runat="server" SkinID="input_grid_num" Width="50px"
                                            Text='<%# Bind("Item_Rate", "{0:#,#.##}") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
                                <asp:BoundField DataField="IB_ID" ReadOnly="True" Visible="false" SortExpression="IB_ID" />
                                <asp:BoundField DataField="Item_Code" HeaderText="Item_Code" ReadOnly="True" SortExpression="Item_Code"
                                    Visible="False" />
                                 <asp:BoundField DataField="01Months" HeaderText="01 Mon" ItemStyle-Width="30px" />
              <asp:BoundField DataField="03Months" HeaderText="03 Mon" ItemStyle-Width="30px" />
              <asp:BoundField DataField="06Months" HeaderText="06 Mon" ItemStyle-Width="30px"/>
              <asp:BoundField DataField="09Months" HeaderText="09 Mon" ItemStyle-Width="30px" />
              <asp:BoundField DataField="12Months" HeaderText="12 Mon" ItemStyle-Width="30px"/>
                                 
                            </Columns>
                        </asp:GridView>
                        <asp:Panel ID="Pnl_GST" runat="server" Visible="false">
                            <table width="100%">
                                <tr>
                                    <td align="right" width="80%">
                                        <strong>GST Rate : </strong>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TXT_GST" runat="server" Text="0" MaxLength="2" Width="20px"></asp:TextBox>
                                        <strong>% </strong>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div align="center">
                    <asp:Label ID="lblApprovalMsg" runat="server" Visible="false" Text="No approval authorities are found for your department."
                         Font-Bold="true" ForeColor="Red"></asp:Label>
                    <br />
                    <asp:Button ID="Button5" runat="server" CssClass="btn1" OnClick="Button_update_QTY_Click"
                        Text="Update Qty" Visible="False" CausesValidation="False" />
                    <asp:Button ID="Button6" runat="server" CssClass="btn1" OnClick="Button3_Click" Text="RoleBack"
                        CausesValidation="False" />
                    <asp:Button ID="Button7" runat="server" CssClass="btn1" Text="Save & Submit" OnClick="Button4_Click" CausesValidation="False" />

                    <asp:Button ID="Button_Report" runat="server" CssClass="btn1" OnClick="Button_Report_Click"
                        Text="Report" CausesValidation="False" />
                    <asp:Button ID="btnGSTExclude" runat="server" Text="Exclude GST" OnClick="btnExcludeGST_Click"
                        Visible="False" CausesValidation="False" />

                </div>
            </td>
            <td valign="top" width="25%">
                <div class="bxmain inner_content" style="width: 98%; height: 270px; display: none;">
                    <h2>
                        <span>Customer Outstanding</span></h2>
                    <asp:Panel ID="PNL_Customer_information" runat="server">
                        <table class="style1">
                            <tr>
                                <td class="AmountAlign" colspan="2">&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">Credit Limit :
                                </td>
                                <td class="AmountAlign">
                                    <asp:Label ID="LBL_CL" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">Last Invoice :
                                </td>
                                <td class="AmountAlign">
                                    <asp:Label ID="LBL_LI" runat="server"></asp:Label>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">Last Payment :
                                </td>
                                <td class="AmountAlign">
                                    <asp:Label ID="LBL_LP" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <strong>OUTSTANDING</strong>
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">30 Days :
                                </td>
                                <td class="AmountAlign">
                                    <asp:Label ID="LBL_30" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">60 Days :
                                </td>
                                <td class="AmountAlign">
                                    <asp:Label ID="LBL_60" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">90 Days :
                                </td>
                                <td class="AmountAlign">
                                    <asp:Label ID="LBL_90" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">90+ :
                                </td>
                                <td class="AmountAlign">
                                    <asp:Label ID="lbl_90plus" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">Total :
                                </td>
                                <td class="AmountAlign">
                                    <asp:Label ID="LBL_Total" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">&nbsp;
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top" width="35%">
                <div class="bxmain inner_content" style="width: 100%;">
                    <h2>
                        <span>Search Items</span></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr style="display: none;">
                            <td align="center" colspan="2">
                                <asp:RadioButtonList ID="rbManufacturer" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="HP" Value="HP"></asp:ListItem>
                                    <asp:ListItem Text="Microsoft" Value="Microsoft"></asp:ListItem>
                                    <asp:ListItem Text="Schneider" Value="Schneider"></asp:ListItem>
                                    <asp:ListItem Text="Others" Value="Others"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="23%">
                                <asp:Label ID="lblCompany" runat="server" Text="Company:" Visible="false"></asp:Label>

                            </td>
                            <td>
                                <asp:DropDownList ID="ddlParties" runat="server" DataSourceID="SQL_Parties" DataTextField="Party_Name"
                                    DataValueField="Party_Id" Width="190px" Visible="false">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SQL_Parties" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
                                    SelectCommand="select P.Party_Id,P.Party_Name from Parties P inner join Store.dbo.Purchase_Order_Main POM on P.Party_Id=POM.Company_ID  where PO_Type='Loan'">
                                 
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="23%">Item Name :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_specificMedicine" Width="70%" runat="server" CssClass="input_txt"
                                    OnTextChanged="TextBox_specificMedicine_TextChanged"></asp:TextBox>
                                <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                                    MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                    TargetControlID="TextBox_specificMedicine" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2" CompletionListCssClass="AutoExtender"
                                    CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                </asp:AutoCompleteExtender>
                                <asp:HiddenField ID="hfItemCode" runat="server" />
                                <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" CausesValidation="False" />
                                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="ALL" Visible="False" />
                                <asp:HiddenField ID="HF_Item_Name" runat="server" />
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td align="right" width="23%">Order #:
                            </td>
                            <td> 
                                <asp:TextBox ID="TXT_Order" Width="70%" runat="server" CssClass="input_txt" OnTextChanged="TextBox_specificMedicine_TextChanged"></asp:TextBox>
                                <br />
                                <asp:HiddenField ID="HF_Order_no" runat="server" />
                            </td>
                        </tr>
                         <tr>
                            <td align="right" width="23%">Category :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Category" runat="server" Width="202px" DataSourceID="SqlDataSource_Item_Category"
                        DataTextField="Item_Type" DataValueField="Item_Type_Id" AutoPostBack="True">
                    </asp:DropDownList>
                                 <asp:SqlDataSource ID="SqlDataSource_Item_Category" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="Store_Items_category" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="%" Name="Item_Category" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </td>
                        </tr>
                        <tr style="display:none">
                            <td align="right" width="23%">Manufacturer :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlManufacturer" runat="server" DataSourceID="sdsManufacturer"
                                    DataTextField="Manufacturer_Name" DataValueField="Manufacturer_Id" Width="242px">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsManufacturer" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="Select 0 Manufacturer_Id,' ----- ALL ----- ' Manufacturer_Name union Select Manufacturer_Id,Manufacturer_Name From Items_Manufacturer"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left">
                                <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:GridView ID="GridViewMedicine" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceGetMedicine"
                        Width="98%" DataKeyNames="Item_Code" Visible="False" OnPreRender="GridViewMedicine_PreRender">
                        <Columns>
                            <asp:TemplateField HeaderText="Item">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnItem" runat="server" Text='<%# Eval("Item_Code") +" - "+ Eval("Medicine") %>' CommandArgument='<%# Eval("Item_Code") %>'
                                        OnClick="btnItem_Click" CausesValidation="false"></asp:LinkButton>
                                    <span style="color: Blue;">(
                                        <asp:Label ID="lblStock" runat="server" Text='<%# Eval("Stock") %>'></asp:Label>
                                        ) </span>
                                    <br />
                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Detail") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:BoundField DataField="ToStock" HeaderText="Issuer Stock" SortExpression="ToStock" />
                            <asp:BoundField DataField="Unit" HeaderText="UOM" SortExpression="Unit" />
                              <asp:TemplateField HeaderText="View Stock" Visible="false">
                                <HeaderStyle Width="45px" />
                                <ItemStyle Width="45px" />
                                <ItemTemplate>
                                     
                                  <asp:LinkButton ID="lnkDetail" runat="server" Text="Stock" CausesValidation="false" OnClick="lnkDetail_Click"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty">
                                <HeaderStyle Width="45px" />
                                <ItemStyle Width="45px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtQty" runat="server" Width="40px" Text="1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cost" Visible="false">
                                <HeaderStyle Width="45px" />
                                <ItemStyle Width="45px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtCost" runat="server" Width="40px"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceGetMedicine" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
                        SelectCommand="IndentBook_Item_Search_new"
                        SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlFromOffice" Name="SubDept_Id" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" Type="Int32" />
                            <asp:ControlParameter ControlID="HF_Item_Name" Name="item_name" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="HF_Order_no" Name="order_no" PropertyName="Value"
                                Type="String" />
                            <asp:Parameter Name="Manufacturer" Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_Category" Name="CatId" DefaultValue="0" Type="Int32" PropertyName="SelectedValue" />
                             <asp:ControlParameter ControlID="DropDownListStore" Name="ForStore" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="ddlParties" Name="Party_Id" DefaultValue="0" Type="Int32" PropertyName="SelectedValue" />

                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                
 
            </td>
            
            <td valign="top" width="40%" >
                
                <div class="bxmain inner_content" style="width: 100%; height: 270px; margin-left: 15px;"  id="cinfo" runat="server" visible="false">
                    <h2>
                        <span>Customer Information</span></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr>
                            <td align="right" width="30%">For Customer :
                            </td>
                            <td>
                                <asp:TextBox ID="TXT_Party_Name" runat="server" AutoPostBack="True" OnTextChanged="TXT_Party_Name_TextChanged"
                                    Width="262px" Placeholder="Company Name"></asp:TextBox>
                                <asp:Button ID="BtnSearchParty" runat="server" Text="Search" OnClick="BtnSearchParty_Click" CausesValidation="false" />
                                <br />
                                <asp:DropDownList ID="ddlCompnay" runat="server" DataSourceID="SQL_Comapany" DataTextField="Party_Name"
                                    DataValueField="Party_Id" Width="190px">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SQL_Comapany" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
                                    SelectCommand="SELECT Party_Id, Rtrim(LTrim(Party_Name)) as Party_Name FROM Parties
where party_name like @Par_name and not Party_name=''  ORDER BY Party_Name">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="Hf_PARTY_NAME" Name="Par_name" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <a id="a1" class="add_link box" runat="server" href="Add_New_Company.aspx" visible="false">Add</a>
                                <asp:Label ID="LBL_Rec_MSG" runat="server" Text="No Record(s) Found"></asp:Label>
                                <asp:SqlDataSource ID="SQL_ForSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT   Distinct     S.SubDept_Name, S.SubDept_Id
FROM            SubDepartment AS S JOIN
                         requisition_department_filter AS R ON S.SubDept_Id = R.sub_Subdept_ID
WHERE        (R.Main_Subdept_ID = @SubDept_Id) and (R.Requisition_Type = 'Internal')" >
        <SelectParameters>
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
        </SelectParameters>
      
    </asp:SqlDataSource>
                                 <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT  [TypeID]      ,[Type_Name]      ,[IsComplete]  FROM [STORE].[dbo].[InternalRequsitionTypes]" >
       
      
    </asp:SqlDataSource>
                                <asp:HiddenField ID="Hf_PARTY_NAME" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Contact Person :
                            </td>
                            <td>
                                <asp:TextBox ID="TXT_Person" runat="server" Width="96%"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="TXT_Person" ForeColor="Red"
                                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Contact Person"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator Display="Dynamic" ValidationExpression="^[A-Za-z ]*$"
                                    ID="RegularExpressionValidator2" runat="server" ErrorMessage="Please provide valid input!"
                                    ForeColor="Red" ControlToValidate="TXT_Person">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Contact # :
                            </td>
                            <td>
                                <asp:TextBox ID="TXT_Phone" runat="server" Width="96%"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="TXT_Phone" ForeColor="Red"
                                    ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Contact #"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator Display="Dynamic" ValidationExpression="^[0-9]*$"
                                    ID="RegularExpressionValidator3" runat="server" ErrorMessage="Please provide valid input!"
                                    ForeColor="Red" ControlToValidate="TXT_Phone">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Email :
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtEmail" ForeColor="Red"
                                    ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Email"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please provide valid input!"
                                    ForeColor="Red" ControlToValidate="txtEmail"></asp:RegularExpressionValidator>
                                <td>
                                    <asp:TextBox ID="TXT_DeliverySite" runat="server" Width="96%" Visible="false"></asp:TextBox>
                                </td>
                                </td>
                        </tr>
                        <tr>
                            <td align="right">Delivery Address :
                            </td>
                            <td>
                                <asp:TextBox ID="TXT_delivery_Address" runat="server" TextMode="MultiLine" Height="45px"
                                    Width="96%"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="TXT_delivery_Address"
                                    ForeColor="Red" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Enter Address"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
                    </div>
            </td>
        </tr>
    </table>

    
    <br />
    <asp:SqlDataSource ID="SqlDataSourceStore" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment Where SubDept_Name Like '%Store%' or SubDept_Name LIKE '%pharmacy%' order by SubDept_Name desc">
        
    </asp:SqlDataSource>

    <asp:Panel ID="PNL_Exceed_limit" runat="server" Visible="false" CssClass="lightbox_bg">
        <table width="100%" class="tbl_form">
            <tr>
                <td colspan="2"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <h1>
                        <span style="color: #FF0000; text-transform: capitalize; font-weight: bold; font-size: large">Exeeding Limit... Are you sure to Continue ?</span></h1>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    <asp:Button ID="BTN_Save" runat="server" Text="Save" OnClick="BTN_Save_Click" />
                </td>
                <td width="50%">
                    <asp:Button ID="BTN_Cancel" runat="server" Text="Cancel" OnClick="BTN_Cancel_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:HiddenField ID="HiddenField_Med_Qty" runat="server" />
    <asp:HiddenField ID="HiddenField_Med_Pack" runat="server" />
    <asp:HiddenField ID="HiddenField_Med_Unit_Pack" runat="server" />
    <asp:HiddenField ID="HF_GST" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceDelete_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="DELETE FROM Store_Indent_Book_Sub&#13;&#10;WHERE     (IB_ID = @IB_ID) "
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Med_Code" runat="server" />
    <asp:HiddenField ID="hf_SaveCheck" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Submit" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="INSERT INTO Item_Request_Track(IB_ID, By_Emp_ID, By_Dept_ID, Date_Time, Request_Status) VALUES (@IB_ID, @By_Emp_ID, @By_Dept_ID, GETDATE(), 0)"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" DeleteCommand="DELETE FROM Store_Indent_Book_Sub WHERE (IB_ID = @IB_ID) AND (Item_Code = @Med_Code)">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="By_Emp_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Dept_ID" Name="By_Dept_ID" PropertyName="Value" />
        </InsertParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Med_Code" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceApprove" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="medicine_order_approve" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
        InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" DefaultValue="" Name="IB_ID"
                PropertyName="Value" />
            <asp:Parameter DefaultValue="1" Name="Status" />
            <asp:SessionParameter DefaultValue="" Name="Emp_ID" SessionField="emp_id" />
            <asp:SessionParameter DefaultValue="" Name="By_Dept_ID" SessionField="dept_id" />
            <asp:ControlParameter ControlID="HiddenField_Dept_ID" Name="For_Dept_ID" PropertyName="Value"
                Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Request_Main" runat="server" UpdateCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Requsition_SendTo_Delete" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="DELETE FROM Requsition_Forwarded_To WHERE (IB_ID = @IB_ID)" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_Exceeded" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" UpdateCommand="UPDATE Store_Indent_Book_Main SET IS_Exceeded = 1 WHERE (IB_ID = @IB_ID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="Labeb_Requisition_No" Name="IB_ID" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Tender_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_counter" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Dept_ID, Dept_Name FROM Department  order by Dept_Name "></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_YearlyCounter" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Medicine_Main" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="DELETE FROM Store_Indent_Book_Main WHERE (IB_ID = @IB_ID)"
        InsertCommand="Insert_Indent_Book_Main" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
        InsertCommandType="StoredProcedure" UpdateCommand="Update_Indent_Book_Main" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="TextBox_Requsition_Description" Name="Description"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="ddlCompnay" Name="Company_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TXT_Phone" Name="Phone_No" PropertyName="Text" />
            <asp:ControlParameter ControlID="TXT_Person" Name="Contact_Person" PropertyName="Text" />
            <asp:ControlParameter ControlID="TXT_delivery_Address" Name="Delivery_Address" PropertyName="Text" />
            <asp:ControlParameter ControlID="TXT_DeliverySite" Name="Delivery_Site" PropertyName="Text" />
            <asp:ControlParameter ControlID="DropDownListStore" Name="To_Sub_Dept_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter Name="GST" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value"
                Type="String" DefaultValue="" />
            <asp:ControlParameter ControlID="HiddenField_YearlyCounter" Name="Yearly_Counter"
                PropertyName="Value" Type="Int32" />
            <asp:SessionParameter Name="From_Dept_ID" SessionField="Dept_id" Type="Int32" />
          <%--  <asp:SessionParameter DefaultValue="" Name="From_Sub_Dept_ID" SessionField="SubDeptid"
                Type="Int32" />--%>
             <asp:ControlParameter ControlID="ddlFromOffice" Name="From_Sub_Dept_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListStore" Name="To_Sub_Dept_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" DefaultValue="" />
            <asp:SessionParameter Name="ShiftID" SessionField="ShiftID" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Reg_no" Name="Reg_No" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="Yearly_No" PropertyName="Value"
                Type="Decimal" />
            <asp:ControlParameter ControlID="TextBox_Requsition_Description" Name="Description"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="ddlCompnay" DefaultValue="0" Name="Company_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="TXT_DeliverySite" DefaultValue=" " Name="Delivery_Site"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TXT_delivery_Address" DefaultValue=" " Name="Delivery_Address"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TXT_Person" Name="Contact_Person" PropertyName="Text"
                Type="String" DefaultValue=" " />
            <asp:ControlParameter ControlID="TXT_Phone" Name="Phone_No" PropertyName="Text" Type="String"
                DefaultValue=" " />
             <asp:Parameter Name="Type" Type="String" />
             
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Medicine_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
        DeleteCommand="Delete_Pharmacy_Requisition" CancelSelectOnNullParameter="False"
        InsertCommand="Insert_Indent_Book_Sub_IPO" SelectCommand="Select_Store_Items_Order"
        UpdateCommand="[Update_IPO_Item]" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure"
        InsertCommandType="StoredProcedure" DeleteCommandType="StoredProcedure" OnDeleting="SqlDataSource_Medicine_Sub_Deleting">
        <DeleteParameters>
            <asp:Parameter Name="Item_Code" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value"
                Type="String" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Item_Code" PropertyName="Value"
                Type="String" />
            <asp:Parameter DefaultValue="1" Name="Item_Qty" Type="Int32" />
            <asp:Parameter DefaultValue="0.0" Name="Item_Rate" Type="Decimal" />
            <asp:ControlParameter ControlID="rbManufacturer" Name="Manufacturer" PropertyName="SelectedValue"
                Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Item_Code" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Qty" Name="Item_Qty" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Specification" Name="Item_Specification"
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Rate" Name="Item_Rate" PropertyName="Value"
                Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenField_Med_Pack" Name="Pack"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Med_Unit_Pack" Name="Unit_Pack"
                PropertyName="Value" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Rate" runat="server" />
    &nbsp;<asp:HiddenField ID="HiddenField_Specification" runat="server" />
    <asp:HiddenField ID="HiddenField_Reg_no" runat="server" />
    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
    <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>
    <asp:SqlDataSource ID="sdsLastFiveSoldItems" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="usp_Last_Five_Sold_Items" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="Labeb_Requisition_No" Name="IB_ID" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsLastFiveSoldItemsParty" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="usp_Last_Five_Sold_Items_Party" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="Labeb_Requisition_No" Name="IB_ID" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="ddlCompnay" Name="Party_Id" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsLastFivePurchases" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="usp_Last_Approved_IPO_Prices_From_PO" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="Labeb_Requisition_No" Name="IB_ID" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
