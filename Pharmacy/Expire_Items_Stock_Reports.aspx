<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Store_Expire_Items_Stock_Reports"
    codefile="Expire_Items_Stock_Reports.aspx.cs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

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
           <h2><span>Expiry Wise Items</span></h2>
           
                <table class="tbl_form" style="width:100%;">
                    <tr>
                        <td style="text-align:right;">
                            Department :
                        </td>
                        <td>
                            <asp:DropDownList ID="Dropdownlistdepartment" runat="server" align="Left"
					 DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID"  CssClass="dropbox" Width="262px" 
            AutoPostBack="True" >
            </asp:DropDownList>
              <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="usp_selectDepartment" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <%--<asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" />--%>
            <asp:SessionParameter Name="Hospital_ID" SessionField="HospitalId"/>
            
            <%--<asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />--%>
        </SelectParameters>
    </asp:SqlDataSource>
                        </td>
                   
                        <td style="text-align:right;">
                            Sub Department:
                        </td>
                        <td>
                          <asp:DropDownList ID="DDL_Branch" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="select 0 as SubDept_Id,'---ALL---' as SubDept_Name union select SubDept_Id,SubDept_Name from SubDepartment where (Dept_Id = @DeptID or @DeptID = 0) order by SubDept_Name">
                        <SelectParameters>
                           <%-- <asp:ControlParameter ControlID="ddlHospital" Name="HospitalID"
                                PropertyName="SelectedValue" />--%>
                            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="String" />
                
                        </SelectParameters>
                    </asp:SqlDataSource>

                        </td>
                    </tr>
                <tr>
                        <td style="text-align:right;">
                            Manufacturer:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList_Manufacturer" runat="server" 
                                DataTextField="Manufacturer_Name"   DataValueField="ID"
                                Width="200px" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
                   
                        <td style="text-align:right;">
                            Item Name:
                        </td>
                        <td>
                          <asp:TextBox ID="txtItemName" runat="server"></asp:TextBox> 
                            <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                                CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList" 
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                    </asp:AutoCompleteExtender>
<asp:HiddenField ID="hfItemCode" runat="server" />

                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td class="style2">
                            Part #<strong> :</strong></td>
                        <td class="style3">
                          <asp:TextBox ID="txtPartno" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:right;">
                            Batch #<strong> :</strong></td>
                        <td class="style3">
                             <asp:TextBox ID="txtOrderNo" runat="server"></asp:TextBox>
                                </td>
                        <td></td>
                        <td>
                            <asp:RadioButtonList ID="rdoExp" RepeatDirection="Horizontal" runat="server">
                                <asp:ListItem Text="Expired" Value="0" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Near To Expire" Value="1"></asp:ListItem>
                            </asp:RadioButtonList>
                            <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                            <asp:HiddenField ID="HfExpiryDate" runat="server"/>
                            </td>
                   
                    </tr>
                    <tr>
                             <td  style="text-align:right;">Items Of :</td>
                <td class="style3" >
                    <asp:DropDownList ID="ddlStore" runat="server"></asp:DropDownList></td>

                        <td  style="text-align:right;">Report Type :</td>
                <td class="style3" >
                    <asp:DropDownList ID="ddlReportType" runat="server">
                        <asp:ListItem Value="1" Text="Expiry Report"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Expiry Report With Purchase Details"></asp:ListItem>
                    </asp:DropDownList></td>
                    </tr>


                    <tr>
                    <td colspan="4" align="center">
                        <asp:Button ID="Button_report" runat="server" Text="View Report" 
                            OnClick="Button_Report_Click" CssClass="btn_1" />
                      </td>
                
           
                    </tr>
            
    </table>
    </div>
    <div>
     <rsweb:reportviewer id="ReportViewer1" runat="server" Width="90%">
                </rsweb:reportviewer>
    </div>
</asp:Content>

