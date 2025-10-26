<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Attendance_report.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="PayRoll_Attendance_report" %>

 
    
 <%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<%-- <%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>

 
    
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%;color:#f67f2e; background-color:transparent; border:none; font-weight:bold;">
<span>Attendance Salary Report</span>
</div>
 <div class="bxmain" style="width:100%;">
    
        <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
         <tr>
                <td align="right" class="style1">
                    Hospital :
                </td>
                <td width="25%">
                    <asp:DropDownList ID="dropdownlist_Hospital" runat="server" DataSourceID="SqlDataSource_Company"
                        DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="202px" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Company" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="SELECT 0 [Hospital_ID],' All ' [Hospital_Name]  union SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                </td>
            </tr>
          
            <tr>
                <td width="29%" align="right" style="height: 18px">
                    Select Month :</td>
                <td width="71%" align="left" style="height: 18px">
                <asp:DropDownList ID="DropDownList_Month" runat="server" Width="250px"  >
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
          </tr>
            <tr>
                <td align="right" style="height: 18px">
                    Select Year :</td>
                <td align="left" style="height: 18px">
                <asp:DropDownList ID="DropDownList_year" runat="server" Width="250px"   >
              </asp:DropDownList></td>
          </tr>
            <tr>
                <td align="right">
                    Select Department :</td>
                <td align="left">
        <asp:DropDownList ID="Dropdownlistdepartment" runat="server" Width="250px" 
					 DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID" TabIndex="5"  
            >
        </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] where (@Hospital =0 or Hospital_ID = @Hospital) ORDER BY [Dept_Name] ">
         <SelectParameters>
                  <asp:ControlParameter ControlID="dropdownlist_Hospital" Name="Hospital" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
              </td>
          </tr>
            <tr>
                <td align="right">
                    Select Employee:</td>
                <td align="left">
                    <asp:TextBox ID="txt_employee" runat="server"></asp:TextBox>
                    <asp:CheckBox ID="ck_my_emp" runat="server" AutoPostBack="True" 
                        Checked="True" />
              </td>
          </tr>
            <tr>
                <td align="right">&nbsp;
              </td>
                <td align="left" style=" padding-left:177px;">
                  <asp:Button ID="Button_Search" runat="server" Text="Search" />
              </td>
          </tr>
            <tr>
                <td align="right">
                    <asp:SqlDataSource ID="SDS_Report" runat="server" 
                        CancelSelectOnNullParameter="False" 
                        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" 
                        SelectCommand="Search_Attendence_Detail" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Month" Name="Salary_Month" 
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_year" Name="Salary_Year" 
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:Parameter Name="Department" Type="Int32" />
                            <asp:Parameter Name="emp_name" Type="String" />
                            <asp:Parameter Name="admin_id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td align="left" style=" padding-left:177px;">
                    &nbsp;</td>
          </tr>
          </table>
          
          </div>
          
          <br />

         <div class="rpt_pos">
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" 
            AutoDataBind="true"/>
               </div>
               
               
               <br />

 
    
</asp:Content>
