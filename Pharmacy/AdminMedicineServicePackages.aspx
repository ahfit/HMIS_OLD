<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AdminMedicineServicePackages.aspx.cs" Inherits="Pharmacy_AdminMedicineServicePackages" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>
      <script type="text/javascript">
          $(document).ready(function () {
              $("#<%=txtItemName.ClientID %>").keyup(function (event) {
           
                  if (event.keyCode === 13) {
                      $("#<%=Button1_Search.ClientID %>").click();
                  }
              });
          })</script>
    <script type="text/javascript">
        function confirmationDelete() {
            if (confirm('Are you sure you want to delete Package ?')) {
                return true;
            } else {
                return false;
            }
        }
   </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
    
    
    <table style="width: 100%;">
        <tr>
            <td align="right">PackageName :</td>
            <td>
                <asp:TextBox ID="TextBox_MedicinePackage" runat="server" Width="202px"></asp:TextBox>
                <asp:Button ID="btn_add" runat="server" Text="Add" OnClick="btn_add_Click" />
                <asp:Label ID="Lbl_mg" runat="server" BorderColor="Lime" Font-Bold="True" ForeColor="Lime"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right">Amount :</td>
            <td>
                <asp:TextBox ID="TextBox_MedicinePackageAmount" runat="server" Width="102px"></asp:TextBox><asp:Label runat="server" ID="lblinfo" Text=" Estimated " ForeColor="Gray" Font-Size="Smaller" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right">Package :</td>
            <td>
                <asp:dropdownlist id="ddlPackages" runat="server" datasourceid="dsPackagesMedicineMain"
                    datatextfield="MP_Name" datavaluefield="AMP_ID" autopostback="True" Width="202px" >
                </asp:dropdownlist>
                <asp:sqldatasource id="dsPackagesMedicineMain" runat="server"
                    connectionstring="<%$ ConnectionStrings:Pharmacy_ConnectionString %>"
                    selectcommand="select 0 AS AMP_ID, '--Select Package--' as MP_Name union SELECT AMP_ID,MP_Name  FROM AdminMedicineServicesPackage"></asp:sqldatasource>
                <asp:Button ID="btnDelete" runat="server" Text="Delete Package" OnClick="btnDelete_Click" OnClientClick="return confirmationDelete()"/>
            </td>
        </tr>
        <tr>
            <td align="right">Store :</td>
            <td>
                <asp:dropdownlist id="ddlAdminServiceCategory" runat="server"
                    autopostback="True" datasourceid="dsAdminMedicineServices" datatextfield="Item_Category"
                    datavaluefield="Item_Category_ID" Width="202px">
                </asp:dropdownlist>
                <asp:sqldatasource id="dsAdminMedicineServices" runat="server"
                    connectionstring="<%$ ConnectionStrings:STOREConnectionString %>"
                    selectcommand="select 0 as  Item_Category_ID, '--ALL--' as Item_Category UNION Select SubDept_Id as Item_Category_ID,SubDept_Name as Item_Category from SubDepartment where SubDept_Name like '%Store%' and SubDept_Id not in (46,47)"></asp:sqldatasource>
            </td>
        </tr>
         <tr>
                <td align="right" width="40%">Item Name :</td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtItemName" runat="server" Width="330px"></asp:TextBox>
                    <asp:Button ID="Button1_Search" runat="server" Text="Search" OnClick="Button1_Search_Click" />
                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList" 
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                </td>
            </tr>
         <tr>
                <td align="right" width="40%">&nbsp;</td>
                <td align="left" width="60%">
                    <asp:HiddenField ID="hfItemCode" runat="server" />
                </td>
            </tr>
        <tr>
            <td>
                <asp:label id="lblMessage" runat="server"></asp:label>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td width="45%">
                <div style="overflow: scroll; height: 300px;">
                    <asp:gridview id="grdServices" runat="server" autogeneratecolumns="False" width="100%"
                         >
    <Columns>
        <asp:BoundField DataField="Item_Name" HeaderText="Medicine" 
            SortExpression="Item_Name" />
        <asp:BoundField DataField="Item_Category" HeaderText="Service Category" 
            SortExpression="Item_Category" />
        <asp:TemplateField HeaderText="Amount" SortExpression="Retail_Unit_Price">
            <ItemTemplate>
                <asp:Label ID="txtAmount" runat="server" Text='<%# Eval("Retail_Unit_Price") %>'></asp:Label>
                <asp:HiddenField ID="hfS_ID" runat="server" Value='<%# Eval("Item_Code") %>' />
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Retail_Unit_Price") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Rate" Visible="false">
            <ItemTemplate>
                <asp:TextBox ID="txtRate" runat="server" Width="35px" Text='<%# Bind("Retail_Unit_Price") %>' ></asp:TextBox>
            </ItemTemplate>
        </asp:TemplateField>
         <asp:TemplateField HeaderText="Qty" >
            <ItemTemplate>
                <asp:TextBox ID="txtQty" runat="server" Width="35px" Text="1"  ></asp:TextBox>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:CheckBox ID="chkSelect" runat="server" />
            </ItemTemplate>
            <HeaderTemplate>
                <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="True" 
                    oncheckedchanged="chkSelectAll_CheckedChanged" />
            </HeaderTemplate>
        </asp:TemplateField>
    </Columns>
    </asp:gridview>
                    <asp:sqldatasource id="dsServices" runat="server"
                        connectionstring="<%$ ConnectionStrings:STOREConnectionString %>"
                        selectcommand="
SELECT    top(15)    Store_Items.Item_Code, Store_Items.Item_Name, Store_Item_Category.Item_Category, Store_Items.Retail_Unit_Price
FROM            Store.dbo.Store_Items INNER JOIN
                         STORE.dbo.Store_Item_Category on Store_Items.Item_Type_Id = Store_Item_Category.Item_Category_ID
WHERE        (Store_Items.Item_Name like '%'+@Item_Name+'%') and (Store_Items.G_N_Id=@Itemtypeid or @Itemtypeid=0)
						

">
    <SelectParameters>
     <asp:ControlParameter ControlID="ddlAdminServiceCategory" Name="Itemtypeid" 
            PropertyName="SelectedValue" /> 
        <asp:ControlParameter ControlID="txtItemName" Name="Item_Name" DefaultValue="1" PropertyName="Text" />
    </SelectParameters>
    </asp:sqldatasource>
                    <asp:hiddenfield id="hfS_IDPage" runat="server" />
                </div>
            </td>
            <td width="5%">
                <asp:button id="btnSave" text="Save" runat="server" onclick="btnSave_Click" />
            </td>
            <td width="45%">
                     <asp:button id="btnUpdate" text="Update" runat="server" style="margin-left: 504px;" onclick="btnUpdate_Click"/>
                <div style="height: 300px; overflow: auto;">
                    <asp:gridview id="grdPckages" runat="server" autogeneratecolumns="False" width="100%" showfooter="true"
                        datakeynames="S_ID,AMSP_ID,ID" datasourceid="dsPackages" onrowdatabound="grdPckages_RowDataBound" OnRowUpdating="grdPckages_RowUpdating">
    <Columns>
        <asp:CommandField ControlStyle-Width="40px" HeaderStyle-Width="60px"   ShowDeleteButton="True" ShowEditButton="False" />
        <asp:BoundField DataField="MP_Name" Visible="false" HeaderText="Medicine Package" 
            SortExpression="MP_Name" />
         <asp:TemplateField HeaderText="Priority"  ControlStyle-Width="1px" HeaderStyle-Width="1px"   >
            <ItemTemplate>
           <asp:TextBox Visible="true" ID="lblpriority" style="width: 15px;" runat="server" Text='<%# Eval("Priority") %>'></asp:TextBox>          
           </ItemTemplate>
           
        </asp:TemplateField>
      <%--  <asp:BoundField DataField="S_Name" HeaderText="Service" 
            SortExpression="S_Name" />--%>
           <asp:TemplateField HeaderText="Medicines"  >
           <ItemTemplate>
           <asp:Label Visible="true" ID="lblMedicineName" runat="server"  Text='<%# Eval("Item_Name") %>'></asp:Label>
           </ItemTemplate>
               <EditItemTemplate>                    
                    <asp:TextBox ID="txtbox" runat="server" Text='<%# Bind("Item_Name") %>'></asp:TextBox>                
               </EditItemTemplate>
               
           </asp:TemplateField>
        <asp:TemplateField HeaderText="Qty" HeaderStyle-Width="15px" ControlStyle-Width="15px">
            <ItemTemplate>
           <asp:TextBox Visible="true" ID="lblQty" style="width: 40px;" runat="server" Text='<%# Eval("Qty") %>'></asp:TextBox>  
                <asp:HiddenField ID="hfdid" runat="server" Value='<%# Eval("ID") %>' />        
           </ItemTemplate>
           <EditItemTemplate>                    
                    <asp:TextBox ID="txtboxqty" runat="server" Text='<%# Bind("Qty") %>'></asp:TextBox>                
               </EditItemTemplate>
        </asp:TemplateField>
            <asp:TemplateField HeaderText="Rate" HeaderStyle-Width="20px" ControlStyle-Width="20px">
           <ItemTemplate>
           <asp:Label Visible="true" ID="lblRate" runat="server" Text='<%# Eval("Rate") %>'></asp:Label>          
           </ItemTemplate>
                 <FooterTemplate>
                   <asp:Label ID="lblTotal" runat="server" Text="Total" Font-Bold="true"></asp:Label>
               </FooterTemplate>
           </asp:TemplateField>
        <asp:TemplateField HeaderText="Amount" HeaderStyle-Width="20px" ControlStyle-Width="20px">
            <ItemTemplate>
                
                    <asp:Label   Visible="true" ID="lbltotal" Font-Bold="true" runat="server" ></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                    <asp:Label  ForeColor="Red" Visible="true" ID="lblSum" Font-Bold="true" runat="server" ></asp:Label>
                </FooterTemplate>

        </asp:TemplateField>
       
    </Columns>
    </asp:gridview>
               
                    <asp:sqldatasource id="dsPackages" runat="server"
                        connectionstring="<%$ ConnectionStrings:Pharmacy_ConnectionString %>"
                        insertcommand="uspInsertPackageSub" InsertCommandType="StoredProcedure" 
                        selectcommand="SELECT   AdminMedicineServicesPackageSub.ID,isnull(AdminMedicineServicesPackageSub.QTY,0) Qty,isnull(Priority,0) Priority,     Store_Items.Category, Store_Items.S_Id, Store_Items.Retail_Unit_Price, Store_Items.Item_Name, AdminMedicineServicesPackageSub.ID, AdminMedicineServicesPackageSub.Rate,AdminMedicineServicesPackageSub.Qty,  
                         AdminMedicineServicesPackageSub.MS_ID, AdminMedicineServicesPackageSub.AMSP_ID, AdminMedicineServicesPackage.MP_Name
FROM            AdminMedicineServicesPackageSub INNER JOIN
                         AdminMedicineServicesPackage ON AdminMedicineServicesPackageSub.AMSP_ID = AdminMedicineServicesPackage.AMP_ID INNER JOIN
                         Store.dbo.Store_Items ON AdminMedicineServicesPackageSub.MS_ID = Store_Items.Item_Code
WHERE        (AdminMedicineServicesPackageSub.AMSP_ID = @AMSP_ID) order by Priority"
                        deletecommand="delete from AdminMedicineServicesPackageSub where ID=@ID" updatecommand="UPDATE   AdminMedicineServicesPackageSub
SET              Rate = @Rate
WHERE     (ID = @ID);update Store_Items set Item_Name=@S_Name where Item_Code=@S_ID ">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlPackages" Name="AMSP_ID" 
            PropertyName="SelectedValue" />
    </SelectParameters>
    <UpdateParameters>       
    <asp:Parameter Name="Rate" />     
    <asp:Parameter Name="ID" />
    
<asp:Parameter Name="Item_Name"></asp:Parameter>
        <asp:Parameter Name="MS_ID" />
    
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" />
    </DeleteParameters>
    <InsertParameters>
        <asp:ControlParameter ControlID="ddlPackages" Name="AMSP_ID" 
            PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="hfS_IDPage" Name="MS_ID" PropertyName="Value" />
        <asp:ControlParameter ControlID="hfRate" Name="Rate" PropertyName="Value" />
        
        <asp:ControlParameter ControlID="hfQty" Name="Qty" PropertyName="Value" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID" />
    </UpdateParameters>
    </asp:sqldatasource>
                    <asp:hiddenfield id="hfRate" runat="server" />
                    <asp:HiddenField ID="hfQty" runat="server" />
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

