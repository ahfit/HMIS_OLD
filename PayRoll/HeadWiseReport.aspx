<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="HeadWiseReport.aspx.vb" Inherits="Payroll_HeadWiseReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">


    </script>
    <style type="text/css">
        .style1 {
            width: 410px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
      <iframe id="frmPrint" name="IframeName" width="500" 
  height="200" runat="server" 
  style="display: none" ></iframe>
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Head Wise Report</span></h2>

        <table class="tbl_form">
            <tr>
                <td align="right" class="style1">
                    <strong>Hospital :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Company" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Company" DataTextField="Hospital_Name"
                        DataValueField="Hospital_ID"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Company" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>




                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong> Sub Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Branch" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>


                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                         ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="
Select 0  as SubDept_Id,'---ALL---' as SubDept_Name UNION
Select SubDepartment.SubDept_Id,SubDept_Name from SubDepartment
 
 
ORDER BY SubDept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                
                        </SelectParameters>


                    </asp:SqlDataSource>


                    <%--<asp:SqlDataSource ID="SDS_Branch1" runat="server"
                         ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="
Select distinct SubDepartment.SubDept_Id,SubDept_Name from SubDepartment
inner join EmployeeReportingAuthority er on er.SubdeptId=SubDepartment.SubDept_Id
where er.EmpID=@empid
ORDER BY SubDept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                
                        </SelectParameters>


                    </asp:SqlDataSource>--%>




                </td>
            </tr>
            <tr>
                <td align="right" class="style1">SalaryHead:
                </td>
                <td class="style2">
                    <asp:DropDownList ID="DropDownList_SalaryHeads" runat="server" DataSourceID="SqlDataSource_SalaryHead"
                        DataTextField="Head_Name" DataValueField="E_ID" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_SalaryHead" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                        SelectCommand="SELECT      E_ID, Sort_Order, Allowance_Deduction, Head_Name + ' (' +Allowance_Deduction+')' AS Head_Name, BI_Report_Head FROM Salary_Allowance_Deduction_Setup where ISNULL(IsVariable,0)=1">
                        <SelectParameters>
                            <asp:SessionParameter Name="Empid" SessionField="emp_id" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="style2">&nbsp;</td>
            </tr>
            <td align="right" class="style1">Salary Month :
            </td>
            <td class="style2">
                <asp:DropDownList ID="DropDownList_SalaryMonth" runat="server" AutoPostBack="True">
                    <asp:ListItem Value="1">January</asp:ListItem>
                    <asp:ListItem Value="2">February</asp:ListItem>
                    <asp:ListItem Value="3">March</asp:ListItem>
                    <asp:ListItem Value="4">April</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">Jun</asp:ListItem>
                    <asp:ListItem Value="7">July</asp:ListItem>
                    <asp:ListItem Value="8">August</asp:ListItem>
                    <asp:ListItem Value="9">September</asp:ListItem>
                    <asp:ListItem Value="10">October</asp:ListItem>
                    <asp:ListItem Value="11">November</asp:ListItem>
                    <asp:ListItem Value="12">December</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="style2">&nbsp;</td>
            <tr>
                <td align="right" class="style1">Salary Year:
                </td>
                <td class="style2">
                    <asp:DropDownList ID="DropDownList_SalaryYear" runat="server" AutoPostBack="True">
                        <asp:ListItem Value="2011">2011</asp:ListItem>
                            <asp:ListItem Value="2012">2012</asp:ListItem>
                            <asp:ListItem Value="2013">2013</asp:ListItem>
                            <asp:ListItem Value="2014">2014</asp:ListItem>
                            <asp:ListItem Value="2015">2015</asp:ListItem>
                            <asp:ListItem Value="2016">2016</asp:ListItem>
                            <asp:ListItem Value="2017">2017</asp:ListItem>
                            <asp:ListItem Value="2018">2018</asp:ListItem>
                            <asp:ListItem Value="2019">2019</asp:ListItem>
                            <asp:ListItem Value="2020">2020</asp:ListItem>
                            <asp:ListItem Value="2021">2021</asp:ListItem>
                            <asp:ListItem Value="2022">2022</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label>
                </td>
                <td class="style2">&nbsp;</td>
            </tr>
            
            <tr>
                <td align="right" class="style1">&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btn_Report" runat="server" Text="View Report" CssClass="btn_hacims"
                        OnClick="btn_Report_Click" />
                </td>
            </tr>
        </table>
    </div>

   
    <input style="visibility: hidden" type="button" value="print" onclick="printSpecial()" id="btn_print" autofocus="autofocus" onload="Set_focus()"  />
    <br />
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
    </rsweb:ReportViewer>

</asp:Content>

