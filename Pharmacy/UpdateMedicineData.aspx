<%@ Page Title="" Language="VB" AutoEventWireup="false" CodeFile="UpdateMedicineData.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master"
    Inherits="Store_UpdateMedicineData" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 100%;
        }
    </style>
     <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 5px;">
        <table style="width: 90%; margin: auto;">
           
               <tr>
                <td align="right" style="font-weight: bold; width: 25%;">Item Name:
                </td>
                <td align="left" style="width: 25%;">
                    <asp:TextBox ID="txtItemName" runat="server" ></asp:TextBox>
                      <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList" 
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfItemCode" runat="server" />
                </td>
                <%--<td align="right" style="font-weight: bold; width: 25%;">Conusmption Id:</td>
                <td>
                    <asp:TextBox ID="txtConsumptionId" runat="server" ></asp:TextBox>
                </td>--%>
            </tr>
             <tr>
                <td align="right" style="font-weight: bold; width: 25%;">Medecine Code :
                </td> 
                  <td>
                        <asp:TextBox ID="TextBox_Med_Code" runat="server" Width="239px" Height="28px" CssClass="input_txt"></asp:TextBox>

                    </td>             
            </tr>
            <tr>
                <td align="Right" >
                    <asp:Button ID="btnSearch" runat="server" Text="Update" Visible="false"/>
                    <asp:Button ID="btn_Report" runat="server" Text="Search" />
                </td>
            </tr>        
        </table>
    </div>
    <div>
                <asp:GridView ID="GridViewMedicine" runat="server" AutoGenerateColumns="False"
                    Width="98%" AllowSubmitOnEnter="true" EnableKeyboardShortcuts="true">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr #">
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1%>
                            </ItemTemplate>
                            <ItemStyle Width="8%" />
                        </asp:TemplateField>
                        <%-- <asp:BoundField DataField="Stock" HeaderText="Stock" SortExpression="Stock" />--%>
                       <%-- <asp:BoundField DataField="MedCode" HeaderText="MedCode" ReadOnly="True" SortExpression="MedCode"
                            Visible="true" />--%>

                         <asp:TemplateField HeaderText="Item Code" SortExpression="MedCode">
                            
                            <ItemTemplate>
                                <asp:TextBox ID="txtMedCode" runat="server" Text='<%# Bind("MedCode")%>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:ButtonField DataTextField="Medicine Name" HeaderText="Medicine Name"  Visible="False" CommandName="Select" SortExpression="Medicine Name" />
                        <asp:BoundField DataField="Medicine Name" HeaderText="Medicine Name" SortExpression="Medicine Name"
                            Visible="False" />
                        <asp:TemplateField HeaderText="Medicine Name">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lnkMedicineName" CommandName="Select" Text='<%# Eval("Medicine Name") %>'></asp:LinkButton>
                                           <%--<asp:HiddenField runat="server" ID="hf_Sub_ID" Value='<%# Eval("Sub_id") %>' />--%>   
                                            <asp:Label ID="lblPara" runat="server" Text='<%# Eval("Para") %>'></asp:Label>  
                                        </ItemTemplate>
                         </asp:TemplateField>
                        <asp:TemplateField HeaderText="Batch No." SortExpression="BatchNo">
                            
                            <ItemTemplate>
                                <asp:TextBox ID="txtBatch" runat="server" Text='<%# Bind("BatchNo") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Expire Date " SortExpression="exp">
                            
                            <ItemTemplate>
                                <asp:TextBox ID="txtExpire" runat="server" Text='<%# Bind("exp") %>' TextMode="Date"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty Issue">
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox_Qty" Visible="true" runat="server" Text='<%# Bind("PQty") %>' CssClass="input_txt" Width="50px" Enabled="false"></asp:TextBox>

                                <%-- <asp:TextBox ID="TextBox_Qty" Visible="false" runat="server" Text='<%# Bind("Default_Qty", "{0}") %>' CssClass="input_txt" Width="50px" ></asp:TextBox>--%>
                                <asp:HiddenField ID="HiddenField_RetailPrice" runat="server" Value='<%# Eval("Retail_Unit_Price", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldMedCode" runat="server" Value='<%# Eval("MedCode", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_s_ID" runat="server" Value="3161" />
                                <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
                                <asp:HiddenField ID="hdfDefaultQty" runat="server" Value='<%# Bind("PQty") %>' />
                                <asp:HiddenField ID="HfIsNarcotic" runat="server" Value='<%# Bind("Is_Narcotic") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Stock">
                            <ItemTemplate>
                                <asp:Label ID="lbl_Batch_Qty" runat="server" Text='<%# Bind("Stock", "{0}") %>'></asp:Label>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Discount" SortExpression="Discount (%)" Visible="false">

                            <ItemTemplate>
                                <asp:TextBox ID="txtboxDiscount" TextMode="Number" onblur="discountfunction()" onkeyup="discountfunction()" Enabled="false" min="0" max="50" MaxLength="2" runat="server" Text='<%# Bind("Discount")%>' Width="50px"></asp:TextBox>


                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sale Price" SortExpression="Retail_Unit_Price">

                            <ItemTemplate>

                                <asp:TextBox ID="TextBox_RetailPrice" runat="server" Text='<%# Bind("SalePrice")%>' Width="50px" Enabled="True"></asp:TextBox>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Batch">
                            <ItemTemplate>

                                <asp:DropDownList ID="DropDownList1" runat="server"
                                    DataTextField="BatchNo" DataValueField="BatchNo" AutoPostBack="true" Width="80px">
                                </asp:DropDownList>
                                <%--DataSourceID="SqlDataSourceBatch"--%>

                                <asp:HiddenField ID="HiddenField3" runat="server" Value='<%# Eval("MedCode", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_MedName" runat="server" Value='<%# Eval("[Medicine Name]") %>' />
                                <asp:SqlDataSource ID="SqlDataSourceBatch" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="
SELECT ISNULL(Batch_No, 'Nil') AS BatchNo,Count(Item_code) Qty
FROM         Store_Item_TagNo
WHERE   (Item_Code = @Item_Code) and Consumption_ID is null
AND Receive_SubDept_ID = @Sub_dept_Id
GROUP BY ISNULL(Batch_No, 'Nil')"
                                    CancelSelectOnNullParameter="False">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenField3" Name="Item_Code" PropertyName="Value" />
                                        <%--<asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />--%>
                                        <asp:SessionParameter Name="Sub_dept_Id" SessionField="SubDeptId" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="hfd_batchNo" runat="server" />

                            </ItemTemplate>
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:TemplateField>
                       <%-- <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblSB" runat="server" Text='<%# Bind("Sub_Id")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="lnk_Update" runat="server" Text="Update" OnClick="lnk_Update_Click" CommandArgument='<%# Bind("BatchNo")%>'></asp:Button>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
            </div>

    </asp:Content>
