<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Search_Purchase_Order.aspx.vb"  Inherits="Store_Search_Purchase_Order" MasterPageFile="~/hacims_masterpage_admin.master" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
 


 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
         .Caption
        {
            width : 25%;
            text-align : right;  
        }
        .Control
        {
            width : 25%;
            text-align : left;  
        }
     </style>
     
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%;">
<h2><span>Search Purchase Order</span></h2>
<table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%"  >
 
 <tr>
        <td class = "Caption"  >
             Purchase Order 
             No. :
             </td>
        <td  class = "Control" >
            <asp:TextBox ID="txtPurchaserNo" runat="server" Width="198px" MaxLength="10"></asp:TextBox>
    <asp:HiddenField ID="HiddenFieldPO" runat="server" />
        </td>
         <td class = "Caption"  >
             Office From :
             </td>
        <td  class = "Control">
                            <asp:DropDownList ID="DropDownList_subdeprtment" runat="server" DataSourceID="SDS_Subdepartment"
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id"
                                Width="200px" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SDS_Subdepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                
                SelectCommand="SELECT 0 AS SubDept_Id, '---ALL---' AS SubDept_Name UNION SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE is_Hidden is null ORDER BY SubDept_Name"></asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class = "Caption" >
            Date From : </td>
        <td  class = "Control"  >
             <igsch:webdatechooser id="WebDateChooser_date_From" runat="server" Width="200px" >
                <CalendarLayout Culture="English (United Kingdom)">
                </CalendarLayout>
             </igsch:webdatechooser></td>
   
        <td class = "Caption"  >
             Date To : </td>
        <td  class = "Control" >
            <igsch:webdatechooser id="WebDateChooser_Date_To" runat="server" Width="200px" >
                <CalendarLayout Culture="English (United Kingdom)">
                </CalendarLayout>
            </igsch:webdatechooser>
        </td>
    </tr>
    <tr>
        <td class = "Caption"  >
             Payment To : 
            </td>
        <td  class = "Control" >
            <asp:DropDownList ID="ddlParty" runat="server" DataSourceID="dsSql_Party" 
                DataTextField="Party_Name" DataValueField="Party_Id" Width="200px" 
                AutoPostBack="True" ></asp:DropDownList>
            <asp:SqlDataSource ID="dsSql_Party" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                SelectCommand="usp_GetAllParties" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </td>  <td class = "Caption"  >
             Item Name : 
             </td>
        <td  class = "Control" >
            <asp:TextBox ID="txtItemName" runat="server" Width="198px"></asp:TextBox>
    <asp:HiddenField ID="HiddenField_Item" runat="server" />
        </td>
       
    </tr>
    
    
    <tr>
        <td class = "Caption"  >
             Order No. :
             </td>
        <td  class = "Control"  >
            <asp:TextBox ID="txtOrderNo" runat="server" Width="198px" MaxLength="10"></asp:TextBox>
    <asp:HiddenField ID="HiddenFieldOrder" runat="server" />
        </td>
   <td class = "Caption"  >
             Quotation No. :
             </td>
        <td  class = "Control"  >
              <asp:TextBox ID = "Txt_Quotation" runat ="server" Width = "198px" MaxLength="15"></asp:TextBox>
                            
    <asp:HiddenField ID="HiddenFieldQuo" runat="server" />
                            
        </td>
      
    </tr>

        <tr>
        <td class = "Caption"  >
             Status :
             </td>
        <td  class = "Control"  >
       <asp:DropDownList runat="server" ID="ddl_Status" AutoPostBack="true" OnSelectedIndexChanged="ddl_Status_SelectedIndexChanged">
               <asp:ListItem Value="2">ALL</asp:ListItem>
            <asp:ListItem Value="1">Approved</asp:ListItem>
                <asp:ListItem Value="0">Rejected</asp:ListItem>
            </asp:DropDownList>
        </td>
             <td class = "Caption"  >
             PO Type :
             </td>
        <td  class = "Control"  >
              <asp:DropDownList DataSourceID="SqlDataSourcePoType" ID = "DDlPoType" DataTextField="PO_Type" DataValueField="PO_ID" runat ="server" Width = "198px" MaxLength="15"></asp:DropDownList>
                             
                        <asp:SqlDataSource ID="SqlDataSourcePoType" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                SelectCommand="Select '--All--' as PO_Type ,'' PO_ID  UNION Select Distinct PO_Type,PO_Type as PO_ID  from Store.Dbo.Purchase_Order_Main  where PO_Type is not null" SelectCommandType="Text"></asp:SqlDataSource>
          
        </td>
            </tr>


    
    
    <tr >
              <td align="Center" colspan="4" >
    <asp:Button ID="Button2" runat="server" CssClass="btn1"
                                       Text="Search" />    
    <asp:Label ID="Label_Rec_found" runat="server" Font-Bold="True" ForeColor="red"></asp:Label>
    <asp:HiddenField ID="HiddenField_from_date" runat="server" />
    <asp:HiddenField ID="HiddenField_to_Date" runat="server" />
                  </td>
    </tr>
              
            </table></div><br />
 
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
        DataKeyNames="PO_ID" DataSourceID="SqlDataSource1" Width="100%" 
        EnableModelValidation="True" AllowPaging="True" PageSize="50" 
        EmptyDataText="No Record(s) Found.">
        <EmptyDataTemplate>
            
        </EmptyDataTemplate>
        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
        <RowStyle CssClass="GridItem" />
        <Columns>
        <asp:HyperLinkField DataNavigateUrlFields="PO_ID" 
                DataNavigateUrlFormatString="PurchaseOrderReport.aspx?PO_ID={0}" 
                 Target="_blank" DataTextField="PO_ID"  >
            <ControlStyle Width="5%" />
            </asp:HyperLinkField>
           <%-- <asp:BoundField DataField="PO_ID" HeaderText="Purchase Order" ReadOnly="True" 
                SortExpression="PO_ID" >
            <ItemStyle Width="5%" />
            </asp:BoundField>--%>
            <asp:BoundField DataField="Company Name" HeaderText="Payment To" ReadOnly="True"
                SortExpression="Company Name" >
                <ItemStyle Width="20%" />
            </asp:BoundField>
            <asp:BoundField DataField="Order_To" HeaderText="Order To" 
                SortExpression="Order_To" >
<ItemStyle Width="20%" />
            </asp:BoundField>
            <asp:BoundField DataField="Purchase_Order Date" HeaderText="Purchase Order Date" DataFormatString="{0:ddMMyyyy}"
                SortExpression="Purchase_Order Date" >
                <ItemStyle Width="10%" />
            </asp:BoundField>
            <asp:BoundField DataField="PO_Detail" HeaderText="Detail" 
                SortExpression="PO_Detail" >
                <ItemStyle Width="20%"  />
            </asp:BoundField>
             
         
            <asp:HyperLinkField DataNavigateUrlFields="PO_ID" 
                DataNavigateUrlFormatString="OtherExpenseReport.aspx?PO_ID={0}" 
                HeaderText="Expense Report" Target="_blank" Text="Detail Report" Visible="false" >
            <ControlStyle Width="5%" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataNavigateUrlFields="PO_ID" 
                DataNavigateUrlFormatString="Shipment_information_Report.aspx?PO_ID={0}" 
                HeaderText="Ship Info" Target="_blank" Text="Status" Visible="false" />
            <asp:HyperLinkField DataNavigateUrlFields="PO_ID" 
                DataNavigateUrlFormatString="Purchase_Order_Tags.aspx?PO_ID={0}" 
                HeaderText="Tag #" Text="Tag #" Visible="false" />
            <asp:HyperLinkField DataNavigateUrlFields="PO_ID" 
                DataNavigateUrlFormatString="PurchaseOrderDetail.aspx?PO_ID={0}" 
                HeaderText="Distribution" Target="_blank" Text="Add" Visible="false" />
            <asp:HyperLinkField DataNavigateUrlFields="PO_ID" 
                DataNavigateUrlFormatString="Purchase_Order_Distribution.aspx?PO_ID={0}" 
                HeaderText="Distribution " Target="_blank" Text="Report" Visible="false" />
             <asp:HyperLinkField DataNavigateUrlFields="PO_ID" 
                DataNavigateUrlFormatString="~/Store/ViewPO_Distribution.aspx?PO_ID={0}" 
                HeaderText="Dist. Detail" Target="_blank" Text="Report" Visible="false"  />
                <asp:HyperLinkField DataNavigateUrlFields="PO_ID" 
                DataNavigateUrlFormatString="~/Store/Purchase_Order_Stock_Detail.aspx?PO_ID={0}" 
                HeaderText="Stock Detail" Target="_blank" Text="View" Visible="False"/>
            <asp:TemplateField HeaderText="Hidden Data Field" Visible="False">
                <ItemTemplate>
                    <asp:HiddenField ID="HiddenField_FAC_Complete" runat="server" 
                        Value='<%# Eval("FAC_Complete") %>' />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:HyperLinkField DataNavigateUrlFields="PO_ID" 
                DataNavigateUrlFormatString="DistributionDetailReport.aspx?PO_NO={0}" 
                HeaderText="Shipment Status" Target="_blank" Text="Status" Visible="false" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" 
        
        SelectCommand="Search_Purchase_Order" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_from_date" Name="start" 
                PropertyName="Value" DefaultValue="" />
            <asp:ControlParameter ControlID="HiddenField_to_Date" Name="end" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_subdeprtment" Name="SubDept_ID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlParty" Name="Company" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenFieldOrder" DefaultValue="" Name="order_no" 
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldQuo" Name="QO_ID" 
                PropertyName="Value"  />
            <asp:ControlParameter ControlID="HiddenField_Item"  Name="Item_Name" 
                PropertyName="Value" DefaultValue="%" />
            <asp:ControlParameter ControlID="HiddenFieldPO" Name="PO_ID" 
                PropertyName="Value" DefaultValue="%"/>
             <asp:ControlParameter ControlID="ddl_Status" Name="Status" 
                PropertyName="SelectedValue" /> 
            <asp:ControlParameter ControlID="DDlPoType" Name="PoType" 
                PropertyName="SelectedValue" /> 

        </SelectParameters>
    </asp:SqlDataSource>
            
 </asp:Content>