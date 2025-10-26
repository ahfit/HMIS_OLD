<%@ Page Title="" Language="VB" AutoEventWireup="false" CodeFile="ViewPatientConsumption.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master"
    Inherits="Store_ViewPatientConsumption" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 5px;">
        <table style="width: 90%; margin: auto;">
            <tr>
                <td align="right" style="font-weight: bold; width: 25%;">MR. # :
                </td>
                <td align="left" style="width: 25%;">
                    <asp:TextBox ID="txtRegNo" runat="server"></asp:TextBox>
                </td>
                <td align="right" style="font-weight: bold; width: 25%;">Visit # :
                </td>
                <td align="left" style="width: 25%;">
                    <asp:TextBox ID="txtYearlyNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr style="display:none;">
                <td align="right" style="font-weight: bold; width: 25%;">Item Category :
                </td>
                <td align="left" style="width: 25%;">
                    <asp:DropDownList ID="DDL_item_cat" runat="server" AutoPostBack="True" DataSourceID="SDS_Item_cat" DataTextField="Item_Category" DataValueField="Item_Category_ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Item_cat" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT  0 Item_Category_ID, ' All ' Item_Category Union 
Select T.Item_Type_Id Item_Category_ID, T.Item_Type Item_Category 
from StoreItems_Consumption_Detail Cd Inner join StoreItem_Consumption_Main Cm on Cm.Consumption_Id = CD.Consumption_Id inner join  
	 Store_items I on I.Item_Code = Cd.Item_code Inner join 
	 Store_Item_Types T
on I.Item_Type_Id = T.Item_Type_Id
where CM.SubDept_Id = @Subdept_id ;">
                        <SelectParameters>
                            <asp:SessionParameter Name="Subdept_id" SessionField="SubDeptID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td align="right" style="font-weight: bold; width: 25%;">Item :</td>
                <td align="left" style="width: 25%;">
                    <asp:DropDownList ID="DDL_item" runat="server" DataSourceID="SDS_Item" DataTextField="Item_Name" DataValueField="Item_Code">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Item" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT    '0'    Item_Code,' All ' Item_Name union Select I.Item_Code ,I.Item_Name from StoreItems_Consumption_Detail Cd Inner join StoreItem_Consumption_Main Cm on Cm.Consumption_Id = CD.Consumption_Id inner join  Store_items I on I.Item_Code = Cd.Item_code
where CM.SubDept_Id = @Subdept_id and (@cat =0 or I.Item_Type_Id =@cat) order by Item_Name;">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_item_cat" Name="cat" PropertyName="SelectedValue" />
                            <asp:SessionParameter Name="Subdept_id" SessionField="SubDeptID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" style="font-weight: bold; width: 25%;">Date From :
                </td>
                <td align="left" style="width: 25%;">
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
                <td align="right" style="font-weight: bold; width: 25%;">Date To :</td>
                <td>
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" style="font-weight: bold; width: 25%;">Invoice # :</td>
                <td align="left" style="width: 25%;">
                    <asp:TextBox ID="txtReceiptNo" runat="server"></asp:TextBox>
                </td>
                <td align="right" style="font-weight: bold; width: 25%;">&nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" />
                    <asp:Button ID="btn_Report" runat="server" Text="Report" Visible="false" />
                </td>
            </tr>
        </table>
    </div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Consumption_Id"
         Width="99%" EmptyDataText="No Record(s) Found" ShowFooter="True">
        <Columns>
            <asp:TemplateField HeaderText="Sr. No.">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
                <ItemStyle Width="50px"></ItemStyle>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="Consumption_id" Target="_blank" DataTextField="Reg_No" HeaderText="MR. #"
                DataNavigateUrlFormatString="Consumed_Medicine_Report.aspx?C_ID={0}" />

            <asp:BoundField DataField="Consumed_Date" DataFormatString="{0:dd/MM/yyyy hh:mm:ss tt}"
                HeaderText="Issue Date" SortExpression="Consumed_Date" />
            
            <asp:BoundField DataField="Consumption_id" HeaderText="Pharam #" SortExpression="Consumption_id" />
            <asp:BoundField DataField="Yearly_No" HeaderText="Visit #" SortExpression="Yearly_No" />
             <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt #" SortExpression="ReceiptNo" />
            <asp:BoundField DataField="Contact_Person" HeaderText="Patient Name" SortExpression="Contact_Person" />
            <asp:TemplateField HeaderText="Total Qty">
                <ItemTemplate>
                    <asp:Label ID="lblqty" runat="server" Text='<%# Eval("Qty") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbltotalqty" runat="server" Text=""></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
             <asp:BoundField DataField="Rqty" HeaderText="Returned Qty" SortExpression="Rqty" />
            <asp:TemplateField HeaderText="Remaining Quantity">
                <ItemTemplate>
                    <asp:Label ID="lblqt" runat="server" Text='<%# Eval("return_qty") %>'></asp:Label>
                </ItemTemplate>
            
            </asp:TemplateField>
           
            <asp:BoundField DataField="EFName" HeaderText="Employee name" SortExpression="EFName"
                Visible="False" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="Issue To" SortExpression="SubDept_Name"
                Visible="False" />
         <%--   <asp:HyperLinkField DataNavigateUrlFields="Consumption_id,Reg_No,Yearly_No" DataNavigateUrlFormatString="Pharmacy_ReturnItems.aspx?C_ID={0}&regNO={1}&payid={2}"
                Target="_blank" Text="Return Item" />--%>


               <asp:TemplateField HeaderText="Return Item" Visible="true">
                <ItemTemplate>
                    <asp:LinkButton ID="Return_Item" runat="server" CommandArgument='<%# Eval("Consumption_Id") %>' ToolTip='<%# Eval("Yearly_No")%>' CommandName='<%# Eval("Reg_No")%>'
                         OnClick="Return_Item_Click">Return Item</asp:LinkButton>
                    
                   </ItemTemplate>
            </asp:TemplateField>




            <%--<asp:HyperLinkField DataNavigateUrlFields="Consumption_id,Sale_Return_Id" DataNavigateUrlFormatString="PatientSaleReturnReport.aspx?C_ID={0}&rtn_id={1}" 
                Target="_blank" DataTextField="Sale_Return_Id" HeaderText="Return Report"  />--%>
           <%-- <asp:TemplateField HeaderText="Invoice" Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="LBN_Invoice" runat="server" CommandArgument='<%# Eval("Consumption_Id") %>'
                        Visible='<%# Eval("gen_vis") %>' OnClick="LBN_Invoice_Click">Generate</asp:LinkButton>
                    <asp:LinkButton ID="LBN_View" runat="server" CommandArgument='<%# Eval("SO_Id") %>'
                        Visible='<%# Eval("View_vis") %>' OnClick="LBN_View_Click">View</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>--%>
              <asp:TemplateField HeaderText="Report" Visible="true">
                <ItemTemplate>
                    <asp:LinkButton ID="ReturnRepo" runat="server" CommandArgument='<%# Eval("Consumption_Id") %>'
                         OnClick="ReturnRepo_Click">View Report</asp:LinkButton>
                     <asp:HiddenField ID="hdConsumption_Id" runat="server" 
                        Value='<%# Eval("Consumption_id") %>' />
                   </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:HiddenField ID="hfdConsumption_Id" runat="server"  />
     <div class="bxmain inner_content" style="width: 100%; margin-bottom: 5px;">
    <asp:Panel ID="pnlreport" runat="server" Visible="false" CssClass="lightbox" Width="500px"
        Height="200px" ScrollBars="Auto">
        <table style="width: 90%; margin: auto;">
            <tr>
                <%--<td align="right">For Office :
                </td>--%>
                 <td align="left" colspan="3" style="padding-left: 150px;">
                  
                    <asp:Button ID="Button2" runat="server" Text="Close" OnClick="btnClosePnl_Click" />
                </td>
               <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Consumption_Id"
         Width="99%" EmptyDataText="No Record(s) Found" ShowFooter="True">
        <Columns>
            <asp:TemplateField HeaderText="Sr. No.">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
                <ItemStyle Width="50px"></ItemStyle>
            </asp:TemplateField>
             <asp:BoundField DataField="Sale_Return_Id" HeaderText="Sale_Return_Id " SortExpression="Sale_Return_Id" />
             <asp:BoundField DataField="Consumption_Id" HeaderText="Consumption_Id " SortExpression="Consumption_Id" />
             <asp:BoundField DataField="Return_Date" HeaderText="Return_Date" SortExpression="Return_Date" />
                   <asp:BoundField DataField="Name" HeaderText="Return_By" SortExpression="Name" />
           
            
            
            <asp:HyperLinkField DataNavigateUrlFields="Consumption_id,Sale_Return_Id" DataNavigateUrlFormatString="PatientSaleReturnReport.aspx?C_ID={0}&rtn_id={1}" 
                Target="_blank" DataTextField="Sale_Return_Id" HeaderText="Return Report"  />
          
        </Columns>
    </asp:GridView>
            </tr>
          
        </table>
    </asp:Panel>
         </div>
</asp:Content>
