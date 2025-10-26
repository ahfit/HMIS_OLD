<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_employee_Information, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 466px;
        }
    </style>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
    
        selectcommand="usp_Employee_Information" 
        CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure"
    >
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_hos" Name="hosID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_dept" Name="deptID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
     <div class="bxmain inner_content" style="text-align:left; width:100%;color:#f67f2e; background-color:transparent; border:none; font-weight:bold;">
<h3><span>Employee Information </span> </h3> </div>


    <table class="diagnosis_list">
        <tr>
            <td align="right" class="style1">
                <strong>Hospital : </strong></td>
            <td>
                
                <asp:DropDownList ID="DropDownList_hos" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource_hos" DataTextField="Hospital_Name" 
                    DataValueField="Hospital_ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_hos" runat="server"
                ConnectionString="<%$ ConnectionStrings:basicdatainfoConnectionString %>" 
                    SelectCommand="select 0 as Hospital_ID,'-ALL-' as Hospital_Name union
SELECT Hospital_ID, Hospital_Name FROM Hospital
order by Hospital_Name"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" class="style1">
                <strong>Department : </strong></td>
            <td>
                <asp:DropDownList ID="DropDownList_dept" runat="server" 
                    DataSourceID="SqlDataSource_dept" DataTextField="Dept_Name" 
                    DataValueField="Dept_ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_dept" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:basicdatainfoConnectionString %>" 
                    SelectCommand="select 0 as Dept_ID,'---ALL---' as Dept_Name union
SELECT Dept_ID, Dept_Name 
FROM Department 
WHERE (Hospital_ID = @Hospital_ID)
order by Dept_Name">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList_hos" Name="Hospital_ID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource></td>
        </tr>
        <tr>
            <td align="right" class="style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" class="style1">
                &nbsp;</td>
            <td>
                <asp:Button ID="Btn_report" runat="server" Text="View Report" 
                    onclick="Btn_report_Click" />
            </td>
        </tr>
    </table>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

  
    
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>

  
    
    </asp:Content>

