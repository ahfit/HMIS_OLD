<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Datewise_Consumption_Report.aspx.cs" Inherits="Datewise_Consumption_Report" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %><%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
    .style1
    {
        width:100%;
        text-align:center;
    }
    .style2
    {
      
        text-align:right;
    }
    .style3
    {
        
        text-align:left;
    }
    .auto-style1 {
     
        text-align: right;
        height: 24px;
    }
    .auto-style2 {
        
        text-align: left;
        height: 24px;
    }
</style>
     <script type="text/javascript">
         function ClientItemSelected2(sender, e) {
             $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
           <div class="bxmain inner_content" style="width:100%;">
           <h2><span>Issuance / Receiving Report</span></h2>
           
                <table class="style1">

                          <tr>
                         <td align="right">
                    Item Category :
                </td>
                <td align="left">
                    <asp:DropDownList ID="DropDownList_Category" runat="server" Width="202px" DataSourceID="SqlDataSource_Item_Category"
                        DataTextField="Item_Type" DataValueField="Item_Type_Id" AutoPostBack="True">
                    </asp:DropDownList>
                    
                </td>
                 
                         <td align="right">
                    Item Sub Category :
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlSubCategory" runat="server" Width="202px" DataSourceID="SqlDataSource_Item_Sub_Category"
                        DataTextField="SubCategory" DataValueField="SubCatId">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Item_Sub_Category" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            SelectCommand="select 0 as SubCatId,'---ALL---' as SubCategory union select G_N_ID as SubCatId,Generic_Name as SubCategory from Generic_Names where (Item_Type_ID = @ItemTypeId or @ItemTypeId = 0)" >
            <SelectParameters>
               <asp:ControlParameter ControlID="DropDownList_Category" Name="ItemTypeId" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
                    
                </td>
                  
                        <td class="style2">
                            Issue Departments :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlIssueDepartment" runat="server" 
                                DataTextField="SubDept_Name"   DataValueField="SubDept_Id"
                                Width="200px" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                          <tr>
                        <td class="style2">
                             Receive Departments :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlDepartment" runat="server" 
                                DataTextField="SubDept_Name"   DataValueField="SubDept_Id"
                                Width="200px" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                 
                        <td class="style2">
                             Employee :</td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_employee" runat="server" DataSourceID="SDS_Employee" DataTextField="Name" DataValueField="EmpID">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SDS_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT 0 AS EmpID, ' --- ALL --- ' AS Name UNION SELECT EmpID, Name FROM Employee WHERE (@SubdeptID =0 or SubDeptId = @SubdeptID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlDepartment" Name="SubdeptID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                
                        <td class="auto-style1">
                             Select Start Date :
                        </td>
                        <td class="auto-style2">
                           <igsch:WebDateChooser ID="WebDateChooser_SDate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
                        </td>
                  </tr>
                  <tr>

                        <td class="style2">
                             End Start Date :
                        </td>
                        <td class="style3">
                           <igsch:WebDateChooser ID="WebDateChooser_EDate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
                        </td>
                  
                        <td class="style2">
                            Item Name:
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="txtItemName" runat="server"></asp:TextBox> 
                            <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2">
                                    </asp:AutoCompleteExtender>
<asp:HiddenField ID="hfItemCode" runat="server" />

                        </td>
                 
                        <td class="style2">
                            item Code<strong> :</strong></td>
                        <td class="style3">
                             <asp:TextBox ID="txtcode" runat="server"></asp:TextBox>
    
                            </td>
                    </tr>


                    <tr>
                         <td class="style2">
                            MR #<strong> :</strong></td>
                        <td class="style3">
                             <asp:TextBox ID="txtMrNo" runat="server" Width="212px"></asp:TextBox>
    
                            </td>
      
                        <td class="style2">
                           Select Type <strong> :</strong></td>
                        <td class="style3">
                             <asp:DropDownList ID="ddlType" runat="server">
                                 <asp:ListItem Text="---ALL---" Value="%"></asp:ListItem>
                                 <asp:ListItem Text="Mateiral Requisition" Value="MR-"></asp:ListItem>
                                 <asp:ListItem Text="Departmental Return" Value="DR-"></asp:ListItem>
                                 <asp:ListItem Text="Purchase Return" Value="PR-"></asp:ListItem>

                             </asp:DropDownList>
    
                            </td>

                         <td colspan="4" align="center">
                        <asp:Button ID="Button_report" runat="server" Text="View Report" 
                            OnClick="Button_Report_Click" CssClass="btn_1" />
                        <asp:SqlDataSource ID="SqlDataSource_Item_Category" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            SelectCommand="category" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter DefaultValue="%" Name="Item_Category" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
                      </td>
                 
           
                    </tr>
            
    </table>
    </div>
    <div>
     <rsweb:reportviewer id="ReportViewer1" runat="server" Width="100%" >
                </rsweb:reportviewer>
    </div>
</asp:Content>

