<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" CodeFile="~/Finance/Profit_Loss_Report.aspx.cs" inherits="Finance_Profit_Loss_Report" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>




   <%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

 

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width:100%;">
    <h2><span>Profit and Loss Report</span></h2>
    <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
        
        <tr>
            <td width="40%" align="right" >
                Select Company:</td>
            <td  width="60%">
                <asp:DropDownList ID="DropDownList_Companyname" runat="server" 
                    AutoPostBack="True" DataSourceID="SQL_Companyname" 
                    DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id" 
                    Width="196px">
                </asp:DropDownList>
                 
            </td>
        </tr>
        
        <tr>
            <td width="40%" align="right" >
                Select Branch:</td>
            <td  width="60%">
                <asp:DropDownList ID="DropDownList_Branchname" runat="server" 
                    AutoPostBack="False" DataSourceID="SQL_Branchname" 
                    DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id" 
                    Width="198px">
                </asp:DropDownList>
                 
            </td>
        </tr>
        
            <td width="40%" align="right" >
                Select Cost Centre :</td>
            <td  width="60%">
                  <asp:DropDownList ID="DropDownList_CostCentre" runat="server"
                        DataSourceID="SQL_CostCentre" DataTextField="CostCenterName" DataValueField="CostCenterID"  Width="213px">
                    </asp:DropDownList>
                  <asp:SqlDataSource ID="SQL_CostCentre" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT  0 CostCenterID, '   --- All --- 'CostCenterName
Union
SELECT  CostCenterID, CostCenterName   FROM CostCenter">
    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td width="40%" align="right" >
                Start Date : </td>
            <td  width="60%">
                 <igsch:WebDateChooser ID="WebDateChooserSdate" runat="server"  
                    Value="2010-06-18" Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
                 
            </td>
        </tr>
        <tr>
            <td align="right" width="40%">
                End Date :</td>
            <td width="60%">
                <igsch:WebDateChooser ID="Webdatechooser_Edate" runat="server"   Value="2010-06-18"
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
                <td align="right">
                    &nbsp;
                </td>
                <td colspan="3" style="text-align:Left;padding-left:10px;">
                    <asp:RadioButtonList ID="DDLVoucher" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="2">All</asp:ListItem>
                        <asp:ListItem  Value="1">Posted</asp:ListItem>
                        <asp:ListItem  Value="0">Not Posted</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        <tr>
            <td align="right" width="40%">&nbsp;
                </td>
            <td width="60%">
                <asp:Button ID="Button_Search" runat="server" Text="Search" 
                    style="height: 26px" onclick="Button_Search_Click" /></td>
        </tr>
        
    </table>
  </div>
   <br />
    
   <div class="rpt_pos">

       <asp:SqlDataSource ID="SQL_Companyname" runat="server" 
           ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" 
           
           
           SelectCommand="SELECT [Financial_Company_Id], [Financial_Company_Name] FROM [Group_Financial_Companies]">
         
       </asp:SqlDataSource>
       <asp:SqlDataSource ID="SQL_Branchname" runat="server" 
           ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" SelectCommand="SELECT     Company_Branch_Id, Company_Branch_Name
FROM         Group_Company_Branches
WHERE    Financial_Company_Id=@Financial_Company_Id
 

">
           <SelectParameters>
               
               <asp:ControlParameter ControlID="DropDownList_Companyname" 
                   Name="Financial_Company_Id" PropertyName="SelectedValue" Type="Int32" />
           </SelectParameters>
       </asp:SqlDataSource>

   
 
<br /> </div>
<br />
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="98%" Visible="true">
    </rsweb:ReportViewer>

 <%--<asp:SqlDataSource ID="sdsProfitAndLoss" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
  SelectCommand="usp_ProfitLossReport" SelectCommandType="StoredProcedure"
 CancelSelectOnNullParameter="False">
     <SelectParameters>
         <asp:ControlParameter ControlID="DropDownList_Companyname" 
             Name="Financial_Company_Id" PropertyName="SelectedValue" Type="Int32" />
         <asp:ControlParameter ControlID="DropDownList_Branchname" 
             Name="Company_Branch_Id" PropertyName="SelectedValue" Type="Int32" />
         <asp:Parameter Name="Start_Date" Type="DateTime" />
         <asp:Parameter Name="End_Date" Type="DateTime" />
     </SelectParameters>
    </asp:SqlDataSource>--%>
    

</asp:Content>