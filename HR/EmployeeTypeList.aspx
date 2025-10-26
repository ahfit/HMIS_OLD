<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="HR_EmployeeTypeList, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 70%;
            height: 177px;
        }
        .style2
        {
            width: 203px;
            text-align: right;
        }
        
      
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="bxmain">
        <h1 style="color: Maroon; font-size: medium">
            Search Employees With Joining Date</h1>
    </div>
    
    
    <div class="bxmain">
    <table class="style1">
        <tr>
            <td class="style2">
                Joining Date Start:
            </td>
            <td>
                <igsch:WebDateChooser ID="startdatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                    Visible="true" AllowNull="True">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
                <asp:HiddenField ID="hdfstartDate" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="style2">
                Joining Date End:
            </td>
            <td>
                <igsch:WebDateChooser ID="enddatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                    Visible="true">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
                <asp:HiddenField ID="hdfIendDate" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="style2">
                Employee Type:
            </td>
            <td>
                <asp:DropDownList ID="ddemptype" runat="server" DataSourceID="SqlDataSource1" DataTextField="Type"
                    DataValueField="Employee_Type_ID">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;
            </td>
            <td>
                <asp:Button ID="Btnsearch" runat="server" OnClick="Btnsave_Click" Text="Search" />
                <asp:Label ID="lblrecordfound" Text="" runat="server"></asp:Label>
                <asp:SqlDataSource ID="sdsEmployeeType" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                    SelectCommand="usp_EmployeeType" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdfstartDate" Name="startdate" PropertyName="Value"
                            Type="DateTime" />
                        <asp:ControlParameter ControlID="hdfIendDate" Name="enddate" PropertyName="Value"
                            Type="DateTime" />
                        <asp:ControlParameter ControlID="ddemptype" Name="emptype" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        SelectCommand="SELECT 0 as  Employee_Type_ID, ' All' as Type union SELECT Employee_Type_ID, Type FROM Employee_Type   order by type">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
        SelectCommand="SELECT EmpID, ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name, JoinDate, DesignationID, DeptID, SubDeptId, Emp_Type, Designation_Detail, Marital_Status FROM Employee WHERE (JoinDate BETWEEN @startdate AND @enddate) AND (Emp_Type = @emptype)"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="hdfstartDate" Name="startdate" PropertyName="Value" />
            <asp:ControlParameter ControlID="hdfIendDate" Name="enddate" PropertyName="Value" />
            <asp:ControlParameter ControlID="ddemptype" Name="emptype" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <div class="bxmain" style="width:100%">
    <asp:GridView ID="gvEmpType" runat="server" DataSourceID="sdsEmployeeType" Width="100%"
        AutoGenerateColumns="False" EmptyDataText="No Record Found">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
            <asp:BoundField DataField="JoinDate" HeaderText="Join Date" SortExpression="JoinDate" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="Marital_Status" HeaderText="Marital Status" SortExpression="Marital_Status" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Dept. Name" SortExpression="SubDept_Name" />
            <asp:BoundField DataField="Dept_Name" HeaderText="Dept. Name" SortExpression="Dept_Name" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
            <asp:BoundField DataField="Type" HeaderText="Employee Type" SortExpression="Type" />
        </Columns>
    </asp:GridView>
    </div>
</asp:Content>
