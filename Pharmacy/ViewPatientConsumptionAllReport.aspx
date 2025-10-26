<%@ Page Title="" Language="VB" AutoEventWireup="false" CodeFile="ViewPatientConsumptionAllReport.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master"
    Inherits="Store_ViewPatientConsumptionAllReport" %>

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
                <td align="right" style="font-weight: bold; width: 25%;">Receipt # :</td>
                <td align="left" style="width: 25%;">
                    <asp:TextBox ID="txtReceiptNo" runat="server"></asp:TextBox>
                </td>
                <td align="right" style="font-weight: bold; width: 25%;">Deaprtment :</td>
                <td  >
                    <asp:DropDownList ID="ddlDepartment" Width="70%" runat="server" DataTextField="SubDept_Name" DataValueField="SubDept_Id" ></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" style="font-weight: bold; width: 25%;">OPD/IPD:</td>
                <td align="left" style="width: 25%;">
                <asp:DropDownList ID="DropDownTypeWise" Width="70%" runat="server" AutoPostBack="true">
                <asp:ListItem Selected="True" Value="0">ALL</asp:ListItem>
                    <asp:ListItem Value="OPD">OPD</asp:ListItem>
                    <asp:ListItem Value="IPD">IPD</asp:ListItem>
                </asp:DropDownList>
                </td>
                <td align="right" style="font-weight: bold; width: 25%;">Patient Type :</td>
                <td>
                    <asp:DropDownList  Width="70%" ID="DropDownList_PatientType" runat="server">
                    </asp:DropDownList>
                     </td>
            </tr>
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
                <td align="center" colspan="4">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Visible="false" />
                    <asp:Button ID="btn_Report" runat="server" Text="Report"   />
                </td>
            </tr>
          
            <tr>
                <td align="center" colspan="4">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
        </rsweb:ReportViewer>
                </td>
            </tr>
        </table>
    </div>

    </asp:Content>
