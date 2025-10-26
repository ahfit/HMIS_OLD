<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Finance_TrialBalance_Report, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

  <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="bxmain inner_content" style="width:98%;">
    <h2><span>Trial Balance</span></h2>
        <table cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
         <%--   <tr>
                <td width="40%" align="right">
                    Select Company :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList_Companyname" runat="server" AutoPostBack="True"
                        DataSourceID="SQL_Companyname" DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Select Branch :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Branchname" runat="server" AutoPostBack="False"
                        DataSourceID="SQL_Branchname" DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id">
                    </asp:DropDownList>
                </td>
            </tr>--%>
            <tr>
                <td align="right">
                    Start Date:
                </td>
                <td>
                  
                    <igsch:WebDateChooser ID="StartDate_Search" runat="server" Width="213px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right">
                    End Date:
                </td>
                <td>
                    <igsch:WebDateChooser ID="EndDate_Search" runat="server" Width="213px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="btnReport" runat="server" Text="Search" OnClick="btnReport_Click" />

                </td>

            </tr>
            </table>
         </div>

       <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           
          <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" 
        Height="500px">
    </rsweb:ReportViewer>


           <%-- <asp:SqlDataSource ID="SQL_Companyname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies WHERE (Financial_Company_Id IN (SELECT Financial_Company_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_id)))">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_id" SessionField="emp_id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Branchname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT Company_Branch_Id, Company_Branch_Name FROM Group_Company_Branches WHERE (Company_Branch_Id IN (SELECT Company_Branch_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @Emp_id) AND (CONVERT (varchar, Financial_Company_ID) LIKE CASE @Financial_Company_Id WHEN 0 THEN '%' ELSE CONVERT (varchar , @Financial_Company_Id) END)))">
        <SelectParameters>
            <asp:SessionParameter Name="Emp_id" SessionField="emp_id" />
            <asp:ControlParameter ControlID="DropDownList_Companyname" Name="Financial_Company_Id"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>--%>

</asp:Content>

