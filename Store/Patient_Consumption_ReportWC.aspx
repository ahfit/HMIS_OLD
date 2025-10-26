<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Patient_Consumption_ReportWC.aspx.cs" Inherits="Patient_Consumption_ReportWC" %>

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
        width:50%;
        text-align:right;
    }
    .style3
    {
        width:50%;
        text-align:left;
    }
    .auto-style1 {
        width: 50%;
        text-align: right;
        height: 24px;
    }
    .auto-style2 {
        width: 50%;
        text-align: left;
        height: 24px;
    }
</style>
     <script type="text/javascript">
         function ClientItemSelected2(sender, e) {
             $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>
     <script type="text/javascript">
        function toggle_visibility(id) {
            var e = document.getElementById(id);
            if (e.style.display == 'block' || e.style.display == '') e.style.display = 'none';
            else e.style.display = 'block';
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
           <div class="bxmain inner_content" style="width:100%;">
        
             <a onclick="toggle_visibility('hideMe')" style="background: no-repeat;box-shadow: none;border: none;" data-toggle="collapse" data-target="#demo">
           <h2 style=" border: none;">
               <span style="font-size: 1em;">Datewise Consumption Report</span>
               <i style="float:right; padding-right:1em" class="glyphicon glyphicon-chevron-down"></i>
           </h2>
          </a>

                <div id="hideMe" style="background:none">
                <table class="style1">

                      <tr>
             <td align="right" width="40%">Hospital :</td>
                <td align="left" >
                       <asp:DropDownList ID="DropDownList_Hospital" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Hospital"
                DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="290px" style="text-transform:uppercase;">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource> 
                    </td>

            </tr>

                        <tr>
                        <td class="style2">
                             Departments :
                        </td>
                        <td class="style3">
                                 <asp:DropDownList CssClass="text_dropdown" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" Width="290px"  DataTextField="Dept_Name" DataValueField="Dept_ID" ID="DropDownList1" runat="server"
                         DataSourceID="SqlDataSourceDepartment"  AutoPostBack="True" style="text-transform:uppercase;"> </asp:DropDownList>
                    
                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="select Dept_ID, Dept_Name from Department where Hospital_ID=@Hospital_Id"> 
                  <SelectParameters>
                      <asp:ControlParameter ControlID="DropDownList_Hospital" Name="Hospital_Id" PropertyName="SelectedValue"
                          Type="Int32" />
                  </SelectParameters>
              </asp:SqlDataSource>



                        </td>
                    </tr> 
                          <tr>
                        <td class="style2">
                             SubDepartments :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlDepartment" Width="290px" runat="server" 
                                DataTextField="SubDept_Name"   DataValueField="SubDept_Id"
                                 AutoPostBack="True" OnSelectedIndexChanged="ddlSubDepartment_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>

                        <tr>
                         <td align="right">
                    Item Category :
                </td>
                <td align="left">
                    <asp:DropDownList  Width="290px" ID="DropDownList_Category" runat="server"  DataSourceID="SqlDataSource_Item_Category"
                        DataTextField="Item_Type" DataValueField="Item_Type_Id" AutoPostBack="True">
                    </asp:DropDownList>
                    
                </td>
                    </tr>
                     <tr>
                        <td class="style2">
                           Patient Category:</td>
                        <td class="style3">
                                  <asp:DropDownList Width="290px" ID="ddlpatient_cat" DataTextField="Patient_type" DataSourceID="SqlDataSourcecategory" DataValueField="Patient_Type_ID" runat="server"></asp:DropDownList>
                     <asp:SqlDataSource ID="SqlDataSourcecategory" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT    '0'    Patient_Type_ID,' All ' Patient_type union Select Patient_Type_ID,Patient_type from BasicDataInfo.dbo. Patient_Type">
               
                    
                    </asp:SqlDataSource>


                                </td>
                    </tr>

 

                <tr>
                        <td class="auto-style1">
                             Select Start Date :
                        </td>
                        <td class="auto-style2">
                           <igsch:WebDateChooser ID="WebDateChooser_SDate" runat="server" 
                  Width="290px">
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
                    Width="290px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
                        </td>
                    </tr>

                    <tr>
                        <td class="style2">
                            Item Name:
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="txtItemName" Width="290px" runat="server"></asp:TextBox> 
                            <asp:AutoCompleteExtender   ID="aceItems" runat="server" ServiceMethod="SearchItems"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2">
                                    </asp:AutoCompleteExtender>
<asp:HiddenField ID="hfItemCode" runat="server" />

                        </td>
                    </tr>
                
                    <tr>
                        <td class="style2">
                            item Code<strong> :</strong></td>
                        <td class="style3">
                             <asp:TextBox ID="txtcode" Width="290px" runat="server"></asp:TextBox>
    
                            </td>
                    </tr>


                    <tr>
                    <td colspan="2" align="center">
                        <asp:Button style="margin-left:7.3em" ID="Button_report" runat="server" Text="View Report" 
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
    </div>
    <div>
     <rsweb:reportviewer id="ReportViewer1" runat="server" Width="100%">
                </rsweb:reportviewer>
    </div>
</asp:Content>

