<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="Demand_Requisition.aspx.cs" Inherits="Store_Demand_Requisition" %>

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

        textarea {
            resize: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" width="50%">
                <div class="bxmain inner_content" style="width: 98%">
                    <h2>
                        <span>Demand Requisition</span></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr>
                            <td align="right" width="30%">From Office :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlFromOffice" runat="server" DataSourceID="SQL_ForSubDepartment"
                                    DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="True"
                                    Width="250px">
                                </asp:DropDownList>
                                <asp:HiddenField ID="HiddenField3" runat="server" />
                            </td>
                        </tr>
                        <tr style="display:none;">
                            <td align="right" width="30%">Send To Office :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDepartment" runat="server" DataSourceID="SDS_Department"
                                    DataTextField="Dept_Name" DataValueField="Dept_ID" Width="250px" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Department" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                                    SelectCommand="SELECT Dept_ID, Dept_Name FROM Department  order by Dept_Name "></asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
                                <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Send To Store :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownListStore" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceStore"
                                    Width="250px" DataTextField="SubDept_Name" DataValueField="SubDept_Id" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                </asp:DropDownList>
                               <asp:SqlDataSource ID="SqlDataSourceStore" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                  ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                  SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment Where SubDept_Name Like '%South%' --Like '%Store%' or SubDept_Name Like '%Purchase%'   order by SubDept_Name ">
        
    </asp:SqlDataSource>
                                <asp:Label ID="Labeb_Requisition_No" Style="color: red;" ToolTip="Requisition Number"
                                    runat="server" CssClass="red"></asp:Label>
                                 <asp:Label ID="label_Budget" runat="server" Text="" ForeColor="#FF0066" Font-Bold="True"></asp:Label>
                            </td>
                        </tr>
                        <tr style="display:none">
                            <td align="right" >
                                Budget Head :</td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Budget" runat="server"
                                    Width="250px" DataSourceID="SDS_Budget" DataTextField="E_Name"
                                    DataValueField="E_Code" AutoPostBack="true"
                                    OnSelectedIndexChanged="DropDownList_Budget_SelectedIndexChanged" Visible="false" >
                                </asp:DropDownList> <b>Balance :</b>
                                <asp:Label ID="lblBalance" runat="server" ForeColor="#0066FF"></asp:Label>
                                <asp:SqlDataSource ID="SDS_Budget" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    SelectCommand="SELECT        E.E_Code, E.E_Code + ' (' + E.E_Name + ')' AS E_Name
FROM            Expenditure E
Where E_Name like '%Purchase%' or E_Name like '%Stock%'
Order BY E.E_Code + ' (' + E.E_Name + ')'">
                                    <%--<SelectParameters>
                                        <asp:SessionParameter Name="SubDeptID" SessionField="Subdeptid" />
                                    </SelectParameters>--%>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Requisition Description :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_Requsition_Description" runat="server" Height="105px" TextMode="MultiLine"
                                    Width="97%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td>&nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td valign="top" width="50%">
                <div style="margin-left: 8px;">
                    <div align="center">
                        <asp:Button ID="Button_update_QTY" runat="server" OnClick="Button_update_QTY_Click"
                            Text="Update Qty" Visible="False" Style="height: 26px" />
                        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="RoleBack" Visible="False" />
                        <asp:Button ID="Button4" runat="server" Text="Save & Submit" OnClick="Button4_Click"
                            Visible="False" />
                        <asp:Label ID="Label_Message" Style="color: red;" ToolTip="Error" runat="server"
                            CssClass="red"></asp:Label>
                    </div>
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="18"
                                Width="100%" DataSourceID="SqlDataSource_Medicine_Sub" OnPreRender="GridView1_PreRender"
                                OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="Demand_RQ_ID"
                                OnRowCommand="GridView1_RowCommand" ShowFooter="true">
                                <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr#">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                  
                                    <asp:TemplateField HeaderText="Item" SortExpression="Store_Items">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Store_Items") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Store_Items") %>'></asp:Label>
                                            <asp:TextBox ID="TextBox_Specification" runat="server" Text='<%# Bind("Item_Specification") %>'
                                                Width="158px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Balance" Visible="false"></asp:TemplateField>
                                    <asp:TemplateField HeaderText="Pack">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPacks" AutoPostBack="true" Enabled="false"
                                                Width="40px" runat="server" SkinID="input_grid_num" Text='<%# Bind("Units", "{0}") %>'
                                                OnTextChanged="txtPacks_TextChanged"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Unit / Pack">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtUnitPack" AutoPostBack="true" Enabled="false"
                                                Width="40px" runat="server" SkinID="input_grid_num" Text='<%# Bind("Qty_Per_Unit", "{0}") %>'
                                                OnTextChanged="txtUnitsPerPack_TextChanged"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Qty">
                                        <ItemTemplate>
                                            <%-- OnTextChanged="txtQtyPacks_TextChanged"--%>
                                            <asp:TextBox ID="txtQtyPacks" AutoPostBack="true"
                                                Width="40px" runat="server" SkinID="input_grid_num" Text='<%# Bind("Qty", "{0}") %>'></asp:TextBox>
                                            <asp:HiddenField ID="hfldQty_Per_Unit" runat="server" Value='<%# Bind("Qty", "{0}") %>' />
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Item_Code", "{0}") %>' />
                                        </ItemTemplate>
                                        <%--<FooterTemplate>
                                            <strong>Grand Total = </strong>
                                        </FooterTemplate>--%>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Rate" Visible="false" >
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtUnitRate" AutoPostBack="true" OnTextChanged="txtUnitsPerPack_TextChanged"
                                                Width="50px" runat="server" SkinID="input_grid_num" Text='<%# Bind("Item_Rate", "{0:N2}") %>'></asp:TextBox>
                                            <asp:HiddenField ID="hfldRate" runat="server" Value='<%# Bind("Item_Rate", "{0}") %>' />
                                        </ItemTemplate>

                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Discount (%)" Visible="false">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDiscount" runat="server" SkinID="input_grid_num" Text='<%# Bind("Discount", "{0:N2}") %>'
                                                Width="50px" OnTextChanged="txtDiscount_TextChanged" AutoPostBack="true"></asp:TextBox>

                                        </ItemTemplate>

                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total" Visible="false">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtTotal" runat="server" SkinID="input_grid_num" Text='<%# Bind("Total_Amount", "{0:N2}") %>'
                                                Enabled="false" Width="50px"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterTemplate >
                                            <strong>
                                                <asp:Label ID="lblGrandTotal" runat="server" Text="0"></asp:Label>
                                            </strong>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Demand_RQ_ID" ReadOnly="True" SortExpression="Demand_RQ_ID" Visible="false" />
                                    <asp:BoundField DataField="Item_Code" HeaderText="Item_Code" ReadOnly="True" SortExpression="Item_Code"
                                        Visible="False" />
                                      <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Del" ImageUrl="~/images/deletebtn.png"
                                                Height="11px" Width="10px" OnClientClick="return confirmation(this)" CommandArgument='<%# Eval("Item_Code", "{0}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <div style="text-align: center; display: none;">
                                <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                    <tr>
                                        <td align="right">Accumulated Discount (%) :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtAccDiscount" AutoPostBack="true" runat="server" OnTextChanged="txtAccDiscount_TextChanged"
                                                Text="0" Width="100px"></asp:TextBox>
                                        </td>
                                        <td align="right">Final Amount :
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtGrandTotal" runat="server" Width="100px" Enabled="False" Text="0"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <br />
                    <div width="100%" align="center" style="display: none;">
                        <table width="40%" frame="box">
                            <tr>
                                <td align="center" bgcolor="#78A5BA">
                                    <strong>Expanse Type</strong>
                                </td>
                                <%-- <td align="center" bgcolor="#78A5BA">
                            <strong>Is Included</strong>
                        </td>--%>
                                <td align="center" bgcolor="#78A5BA">
                                    <strong>Percent %</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>GST :
                                </td>
                                <%-- <td align="center">
                            <asp:CheckBox ID="CKGST" runat="server" AutoPostBack="True" OnCheckedChanged="CKGST_CheckedChanged" />
                        </td>--%>
                                <td align="left">
                                    <asp:TextBox ID="TXT_GST" runat="server" Text="0" Width="50px"
                                        MaxLength="5" Enabled="true"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>With Holding Tax :
                                </td>
                                <%--<td align="center">
                            <asp:CheckBox ID="CKWHT" runat="server" AutoPostBack="True" OnCheckedChanged="CKWHT_CheckedChanged">
                            </asp:CheckBox>
                        </td>--%>
                                <td align="left">
                                    <asp:TextBox ID="TXT_WHT" runat="server" Text="0" Enabled="true" Width="50px" MaxLength="5">

                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Income Tax :
                                </td>
                                <%--  <td align="center">
                            <asp:CheckBox ID="CKIncometax" runat="server" AutoPostBack="True" OnCheckedChanged="CKIncometax_CheckedChanged">
                            </asp:CheckBox>
                        </td>--%>
                                <td align="left">
                                    <asp:TextBox ID="TXT_IT" runat="server" Text="0" Enabled="true"
                                        Width="50px" MaxLength="5" Height="22px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Other Tax:
                                </td>
                                <%--<td align="center">
                            <asp:CheckBox ID="CKoTHER" runat="server" OnCheckedChanged="CKoTHER_CheckedChanged"
                                AutoPostBack="True" />
                        </td>--%>
                                <td align="left">
                                    <asp:TextBox ID="TXT_oTHER" runat="server" Enabled="true" MaxLength="5" Text="0"
                                        Width="50px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <table width="40%">
                            <tr>
                                <td width="50%" align="left">&nbsp;
                                </td>
                                <td width="50%" align="right">
                                    <asp:TextBox ID="TxtFTamount" runat="server" Enabled="false" Width="100px" Style="margin-bottom: 0px" Visible="false">0</asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div align="center">
                        <asp:Label ID="lblApprovalAuthorityMsg" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                        <br />
                        <asp:Button ID="Button5" runat="server" CssClass="btn1" OnClick="Button_update_QTY_Click"
                            Text="Update Qty" Visible="False" />
                        <asp:Button ID="Button6" runat="server" CssClass="btn1" OnClick="Button3_Click" Text="RoleBack" />
                        <asp:Button ID="Button7" runat="server" CssClass="btn1" Text="Save & Submit" OnClick="Button4_Click" />
                        <asp:Button ID="Button_Report" runat="server" CssClass="btn1" OnClick="Button_Report_Click"
                            Text="Report" Visible="False" />
                    </div>
                </div>

            </td>
        </tr>
    </table>
    <br />
    &nbsp;
    <asp:SqlDataSource ID="SqlDataSource_Min_Alert" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="IndentBook_Item_Search" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListStore" Name="SubDept_Id" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="ddlDepartment" Name="Dept_Id" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter DefaultValue="%" Name="item_name" Type="String" />

        </SelectParameters>
    </asp:SqlDataSource>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" width="50%">
                <div class="bxmain inner_content" style="width: 98%;">
                    <h2>
                        <span>Search Items</span></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr>
                            <td align="right" width="23%">Item Name :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_specificMedicine" Width="242px" runat="server" CssClass="input_txt"
                                    OnTextChanged="TextBox_specificMedicine_TextChanged"></asp:TextBox>
                                <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                                    MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                    TargetControlID="TextBox_specificMedicine" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                                    CompletionListCssClass="AutoExtender"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                </asp:AutoCompleteExtender>
                                <asp:HiddenField ID="hfItemCode" runat="server" />
                                <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" CausesValidation="False" />
                                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="ALL" Visible="False" />
                                <asp:HiddenField ID="HF_Item_Name" runat="server" />
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
                        <tr>
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
                    </table>

                    <asp:GridView ID="GridViewMedicine" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceGetMedicine"
                        Width="98%" DataKeyNames="Item_Code" Visible="False">
                        <Columns>
                            <asp:TemplateField HeaderText="Item">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnItem" runat="server" Text='<%# Eval("Medicine") %>' CommandArgument='<%# Eval("Item_Code") %>'
                                        OnClick="btnItem_Click" CausesValidation="false"></asp:LinkButton>
                                    <span style="color: Blue;">(
                                        <asp:Label ID="lblStock" runat="server" Text='<%# Eval("Stock") %>'></asp:Label>
                                        ) </span>
                                    <br />
                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Detail") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty">
                                <HeaderStyle Width="45px" />
                                <ItemStyle Width="45px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtQty" runat="server" Width="40px" Text="1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="false" HeaderText="Rate" >
                                <HeaderStyle Width="45px" />
                                <ItemStyle Width="45px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtCost" runat="server" Width="40px" Text='<%# Eval("Rate") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                </div>
                <br />
            </td>
            <td valign="top">
                <div class="bxmain inner_content" style="visibility: hidden;">
                    <h2>
                        <span>Customer</span></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr>
                            <td align="right" width="30%">Reseller / Customer :
                            </td>
                            <td>
                                <asp:TextBox ID="TXT_Party_Name" runat="server" AutoPostBack="True" OnTextChanged="TXT_Party_Name_TextChanged"
                                    Height="22px"></asp:TextBox>
                                <asp:Button ID="BtnSearchParty" runat="server" Text="Search" OnClick="BtnSearchParty_Click" />
                                <br />
                                <asp:DropDownList ID="ddlCompnay" runat="server" DataSourceID="SQL_Comapany" DataTextField="Party_Name"
                                    DataValueField="Party_Id" Width="190px">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SQL_Comapany" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
                                    SelectCommand="SELECT Party_Id,LTRIM(RTRIM(Party_Name)) As Party_Name  FROM Parties where party_name like @Par_name and Party_Name<>' '  ORDER BY Party_Name">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="Hf_PARTY_NAME" Name="Par_name" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Dept_Id) AND (SubDept_Id = @SubDept_Id)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="Dept_Id" SessionField="Dept_ID" />
                                        <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptId" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="Hf_PARTY_NAME" runat="server" />
                                <a id="addlink" class="add_link box" runat="server" href="Add_New_Company.aspx">Add</a>
                                <asp:Label ID="LBL_Rec_MSG" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">End User :
                            </td>
                            <td>
                                <asp:TextBox ID="TXT_DeliverySite" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Delivery Address :
                            </td>
                            <td>
                                <asp:TextBox ID="TXT_delivery_Address" runat="server" TextMode="MultiLine" Height="45px"
                                    Width="96%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Contact Person :
                            </td>
                            <td>
                                <asp:TextBox ID="TXT_Person" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Contact # :
                            </td>
                            <td>
                                <asp:TextBox ID="TXT_Phone" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <br />
    <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>
    <asp:HiddenField ID="HiddenField_Med_Qty" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceDelete_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="DELETE FROM Demand_Requisition_Sub WHERE     (Demand_RQ_ID = @Demand_RQ_ID) "
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="Demand_RQ_ID" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Med_Code" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Submit" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="INSERT INTO Item_Request_Track(IB_ID, By_Emp_ID, By_Dept_ID, Date_Time, Request_Status) VALUES (@IB_ID, @By_Emp_ID, @By_Dept_ID, GETDATE(), 0)"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" DeleteCommand="DELETE FROM Store_Indent_Book_Sub WHERE (IB_ID = @Demand_RQ_ID) AND (Item_Code = @med_Code)">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="By_Emp_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Dept_ID" Name="By_Dept_ID" PropertyName="Value" />
        </InsertParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="med_Code" PropertyName="Value" />
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
    <asp:SqlDataSource ID="SqlDataSource_Requsition_SendTo_Delete" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="DELETE FROM Requsition_Forwarded_To WHERE (IB_ID = @IB_ID)" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Tender_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_counter" runat="server" />
    <asp:HiddenField ID="hfldUnits" runat="server" />
    <asp:HiddenField ID="hfldQtyPerUnit" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Dept_ID, Dept_Name FROM Department WHERE (Hospital_ID = @Hospital_ID) ORDER BY Dept_Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlDepartment" Name="Hospital_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_YearlyCounter" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Medicine_Main" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="DELETE FROM Demand_Requisition_Main WHERE (Demand_RQ_ID = @Demand_RQ_ID)"
        InsertCommand="usp_CreateDemand_Requisition_Main" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
        InsertCommandType="StoredProcedure" UpdateCommand="usp_UpdateDemand_Requisition_Main"
        UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="Demand_RQ_ID" PropertyName="Value" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Demand_RQ_ID" Type="String" />
            <asp:Parameter Name="Yearly_Counter" Type="Int32" />
            <asp:Parameter Name="From_Dept_ID" Type="Int32" />
            <asp:Parameter Name="From_Sub_Dept_ID" Type="Int32" />
            <asp:Parameter Name="To_Sub_Dept_ID" Type="Int32" />
            <asp:Parameter Name="Date_Time" Type="DateTime" />
            <asp:Parameter Name="Emp_ID" Type="Int32" />
            <asp:Parameter Name="Request_Priority" Type="String" />
            <asp:Parameter Name="When_Required" Type="DateTime" />
            <asp:Parameter Name="ShiftID" Type="Int32" />
            <asp:Parameter Name="Reg_No" Type="String" />
            <asp:Parameter Name="Yearly_NO" Type="Decimal" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Company_ID" Type="Int32" />
            <%--<asp:Parameter Direction="InputOutput" Name="id" Type="Decimal" />--%>
            <asp:Parameter Name="Is_Approved" Type="Boolean" DefaultValue="false" />
            <asp:Parameter Name="SO_ID" Type="Decimal" />
            <asp:Parameter Name="Remarks" Type="String" />
             <asp:Parameter Name="Type" Type="String" />


            <%-- <asp:Parameter Name="Is_Completed" Type="Boolean" />--%>
            <asp:ControlParameter ControlID="TXT_DeliverySite" Name="Delivery_Site" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_delivery_Address" Name="Delivery_Address" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_Person" Name="Contact_Person" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_Phone" Name="Contact_No" PropertyName="Text"
                Type="String" />

            <asp:ControlParameter ControlID="txtAccDiscount" Name="Acc_Discount"
                PropertyName="Text" Type="Double" />

            <asp:ControlParameter ControlID="DropDownList_Budget" Name="BudgetHead" PropertyName="SelectedValue" Type="String" />

        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="Demand_RQ_ID" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="ddlCompnay" Name="Company_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="TXT_DeliverySite" Name="Delivery_Site" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_delivery_Address" Name="Delivery_Address" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_Person" Name="Contact_Person" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_Phone" Name="Contact_No" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_GST" Name="GST" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_WHT" Name="WHTax" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_IT" Name="ITax" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TXT_oTHER" Name="OtherTax" PropertyName="Text"
                Type="String" />

            <asp:ControlParameter ControlID="txtAccDiscount" Name="Acc_Discount"
                PropertyName="Text" Type="Double" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Medicine_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="usp_DeleteDemand_Requisition" InsertCommand="usp_CreateDemand_Requisition_Sub"
        SelectCommand="usp_SelectDemand_Requisition_Sub" UpdateCommand="usp_UpdateDemand_Requisition_Sub"
        SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" InsertCommandType="StoredProcedure"
        DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="Demand_RQ_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Item_Code" PropertyName="Value" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="Demand_RQ_ID" PropertyName="Value" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_counter" Name="Demand_RQ_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Item_Code" PropertyName="Value"
                Type="String" DefaultValue="" />
            <asp:Parameter DefaultValue="1" Name="Item_Qty" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Specification" DefaultValue="" Name="Item_Specification" PropertyName="Value" Type="String" />
            <asp:Parameter DefaultValue="0" Name="Item_Rate" Type="Double" />
            <asp:Parameter DefaultValue="0" Name="Discount" Type="Double" />
            <asp:Parameter DefaultValue="0" Name="Total" Type="Double" />
               <asp:Parameter Name="Type" Type="String" />

            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />

        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="hfldUnits" Name="Units" PropertyName="Value" />
            <asp:ControlParameter ControlID="hfldQtyPerUnit" Name="Qty_Per_Unit" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_counter" Name="Demand_RQ_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Item_Code" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Med_Qty" Name="Item_Qty" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Specification" Name="Item_Specification"
                PropertyName="Value" Type="String" />
            <asp:Parameter Name="Discount" Type="Decimal" />
            <asp:Parameter Name="Total" Type="Decimal" />
            <asp:Parameter Name="Item_Rate" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGetMedicine" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="uspSearchItemsForDemand"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HF_Item_Name" Name="item_name"
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="ddlManufacturer" Name="Manufacturer" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddlFromOffice" Name="SubDept_Id" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Category" Name="CatId" DefaultValue="0" Type="Int32" PropertyName="SelectedValue" />
             <asp:ControlParameter ControlID="DropDownListStore" Name="ForStore" PropertyName="SelectedValue"
                                Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField2" runat="server" />
    &nbsp;<asp:HiddenField ID="HiddenField_Specification" runat="server" />
    <asp:HiddenField ID="HiddenField_Reg_no" runat="server" />
    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
    <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>
    <asp:SqlDataSource ID="SQL_ForSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT        S.SubDept_Name, S.SubDept_Id
FROM            SubDepartment AS S JOIN
                         requisition_department_filter AS R ON S.SubDept_Id = R.sub_Subdept_ID
WHERE        (R.Main_Subdept_ID = @SubDept_Id) and (R.Requisition_Type = 'Demand')" >
        <SelectParameters>
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
        </SelectParameters>
      
    </asp:SqlDataSource>
    
    <asp:Panel ID="pnlForward" runat="server" CssClass="lightbox" Visible="false">
        <table border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td align="right" width="50%">
                    Remarks:
                </td>
                <td  align="left" width="50%">
                    <asp:TextBox ID="txtForwardRemarks" runat="server" TextMode="MultiLine" Width="300px" Height="100px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">
                    Forward To:
                </td>
                <td  align="left" width="50%">
                    <asp:DropDownList ID="ddlForwardTo" runat="server" DataTextField="Name" DataValueField="EmpID"></asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td  align="center" colspan="2" >
                    <asp:Button ID="btnForward" runat="server" Text="Forward" OnClick="btnForward_Click" />
                    <asp:Button ID="btnClosePanel" runat="server" Text="Close" OnClick="btnClosePanel_Click" />
                    <br />
                    <asp:Label ID="lblForwardMsg" runat="server" Text="No authority is avaliable to approve your demand or your authority balance limit exceed."
                         ForeColor="Red" Font-Bold="true" Visible="false"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    
</asp:Content>
