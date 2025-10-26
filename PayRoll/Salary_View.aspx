<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_Salary_View, App_Web_xk2k0ijz" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
    <table class="diagnosis_list">
        <tr>
            <td align="right">
                <strong>Hospital:</strong></td>
            <td>
                <asp:DropDownList ID="ddlHospital" runat="server" CssClass="dropbox" 
           Width="262px" DataSourceID="sdsHospital" DataTextField="Hospital_Name" 
           DataValueField="Hospital_ID" AutoPostBack="True" ></asp:DropDownList>
    <asp:SqlDataSource ID="sdsHospital" runat="server" 
           ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
           SelectCommand="SELECT 0 as [Hospital_ID],'---ALL---' as [Hospital_Name] union SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
   
            </td>
        </tr>
        <tr>
            <td align="right">
                <strong>Department:</strong></td>
            <td>
                <asp:DropDownList ID="Dropdownlistdepartment" runat="server"
					 DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name"
                      DataValueField="Dept_ID"  CssClass="dropbox" Width="262px" 
            AutoPostBack="True" >
        </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="usp_selectDepartment" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                <strong>Enter Amount :</strong></td>
            <td>
                <asp:TextBox ID="TextBox_Less" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
               <strong> Emp Name :</strong></td>
            <td>
                <asp:TextBox ID="txtName" runat="server" AutoPostBack="True"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
               <strong> Emp No :</strong></td>
            <td>
                <asp:TextBox ID="txtEmpNO" runat="server" AutoPostBack="True"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td class="style1">
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" 
                    RepeatDirection="Horizontal">
                    <asp:ListItem Value="-1">Less</asp:ListItem>
                    <asp:ListItem Value="1">Greater</asp:ListItem>
                    <asp:ListItem Value="0">Equal</asp:ListItem>
                    <asp:ListItem Value="2">All</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="Button1" runat="server" Text="View Report" Visible="True" />
            &nbsp;
            <asp:Button ID="btn_export" runat="server" Text="Export" />
            <asp:Button ID="btnSearch" runat="server" Text="Search" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
                </rsweb:ReportViewer>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="EmpID" DataSourceID="SqlDataSource1" Width="100%" ShowHeaderWhenEmpty="true">
        <Columns>
        <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
            <asp:BoundField DataField="Emp_No" HeaderText="Emp_No" 
                SortExpression="Emp_No" />
            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" 
                ReadOnly="True" SortExpression="EmployeeName" />
            <asp:BoundField DataField="RelationName" HeaderText="Relation Name" 
                ReadOnly="True" SortExpression="RelationName" />
            <asp:BoundField DataField="Dept_Name" HeaderText="Department" ReadOnly="True" 
                SortExpression="Dept_Name" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="SubDepartment" 
                SortExpression="SubDept_Name" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" 
                SortExpression="Designation_Name" />
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
            <asp:BoundField DataField="Join_Date" HeaderText="Joining Date" ReadOnly="True" 
                SortExpression="Join_Date" />
            <asp:BoundField DataField="Min_PayScale" HeaderText="PayScale" 
                SortExpression="Min_PayScale" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" 
                ReadOnly="True" SortExpression="EmpID" Visible="False" />
            <asp:BoundField DataField="Gross_Salary" HeaderText="Gross Salary" 
                SortExpression="Gross_Salary" />
            <asp:BoundField DataField="E_ID" HeaderText="E_ID" SortExpression="E_ID" 
                Visible="False" />
            <asp:CheckBoxField DataField="ActiveStatus" HeaderText="ActiveStatus" 
                SortExpression="ActiveStatus" Visible="False" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        SelectCommand="Salary_View_Detail" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadioButtonList1" Name="chkstatus" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_Less" Name="amount" 
                PropertyName="Text" Type="Int32" />
                 <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                PropertyName="Text" Type="Int32" />
                 <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_ID" 
                PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtName" Name="empName" PropertyName="Text" 
                Type="String" DefaultValue="%" />
            <asp:ControlParameter ControlID="txtEmpNO" DefaultValue="%" Name="empNO" 
                PropertyName="Text" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

