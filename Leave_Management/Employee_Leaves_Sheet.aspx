<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Employee_Leaves_Sheet, App_Web_gxw3jji3" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
function backto()
{
history.go(-1);
}
</script>

     <style type="text/css">
         .style1
         {
             height: 26px;
         }
     </style>

 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
           
<div class="bxmain">
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form" >
            <tr>
                <td align="right" width="40%">
                    Select Department :</td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList_Dept" runat="server" AutoPostBack="True"
                        DataSourceID="SqlDataSource_Dept" DataTextField="Dept_Name" 
                        DataValueField="Dept_ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Dept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="Select_Dept" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
    <td align="right" width="40%" >
        Year :</td>
                            <td width="60%" >
                                <asp:DropDownList ID="DropDownList_Year" runat="server" >
                                </asp:DropDownList>
                            </td>
          </tr>
                        <tr>
                            <td align="right" class="style1" >
                                Month :</td>
                            <td class="style1" >
                                 <asp:DropDownList ID="DropDownList_Month" runat="server" 
                                    DataSourceID="SqlDataSource_Month" DataTextField="Month_Name" 
                                    DataValueField="Month_No" >
                                    <asp:ListItem Value="4">April</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
            <tr>
                <td align="right">
                </td>
                <td>
                    <asp:Button ID="Button_Search" runat="server" Text="Search" /></td>
            </tr>
            
      </table></div>

          
                    <asp:SqlDataSource ID="SqlDataSource_Month" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                
                
                SelectCommand="SELECT Month_No, Month_Name FROM Year_Months" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
            </asp:SqlDataSource>

                    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                DeleteCommand="DELETE FROM [Employee_Leaves] WHERE [Emp_Leave_Id] = @Emp_Leave_Id" 
                InsertCommand="INSERT INTO Employee_Leaves(Emp_Id, Start_Date, End_Date, Leave_Days, Description, Type_Detail_Id, Office_Ins_Id, Salary_Day) VALUES (@Emp_Id, @Start_Date, @End_Date, @Leave_Days, @Description, @Type_Detail_Id, @Office_Ins_Id, @Salary_Day)" 
                
                
                SelectCommand="Search_Employee" 
                
                
                
                
                
                
        UpdateCommand="UPDATE [Employee_Leaves] SET [Emp_Id] = @Emp_Id, [Start_Date] = @Start_Date, [End_Date] = @End_Date, [Leave_Days] = @Leave_Days, [Description] = @Description, [Type_Detail_Id] = @Type_Detail_Id, [Office_Ins_Id] = @Office_Ins_Id WHERE [Emp_Leave_Id] = @Emp_Leave_Id" 
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
        SelectCommandType="StoredProcedure">
                        <DeleteParameters>
                            <asp:Parameter Name="Emp_Leave_Id" Type="Decimal" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Emp_Id" Type="Int32" />
                            <asp:Parameter Name="Start_Date" type="DateTime" />
                            <asp:Parameter Name="End_Date" type="DateTime" />
                            <asp:Parameter Name="Leave_Days" Type="Int32" />
                            <asp:Parameter Name="Description" Type="String" />
                            <asp:Parameter Name="Type_Detail_Id" Type="String" />
                            <asp:Parameter Name="Office_Ins_Id" Type="Int32" />
                            <asp:Parameter Name="Emp_Leave_Id" Type="Decimal" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:QueryStringParameter Name="Emp_Id" QueryStringField="emp_ID" />
                            <asp:ControlParameter ControlID="HiddenField_From_Date" 
                                Name="Start_Date" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenField_to_Date" 
                                Name="End_Date" PropertyName="Value" />
                            <asp:ControlParameter ControlID="TextBox_Leave_Day" Name="Leave_Days" 
                                PropertyName="Text" />
                            <asp:ControlParameter ControlID="TextBox_Description" Name="Description" 
                                PropertyName="Text" />
                            <asp:ControlParameter ControlID="DropDownList_Leave_Name" Name="Type_Detail_Id" 
                                PropertyName="SelectedValue" />
                            <asp:Parameter DefaultValue="1" Name="Office_Ins_Id" Type="Int32" />
                            <asp:ControlParameter ControlID="TextBox_Salary_Day" Name="Salary_Day" 
                                PropertyName="Text" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Dept" Name="DeptID" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
            </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
 <br />


                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource_Employee" Width="100%" 
                AllowPaging="True">
                        <Columns>
                        <asp:BoundField DataField="Emp_No" HeaderText="Emp No" SortExpression="Employee No" />
                            <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName" SortExpression="EmployeeName" />
                            <asp:BoundField DataField="Join Date" HeaderText="Joining Date" SortExpression="Joining Date" />
                            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
                            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
                            <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
                            <asp:TemplateField>
                                <ItemTemplate>
  <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" SkinId="innertbl" DataSourceID="SqlDataSource_Employee_Available" Width="99%">
        <Columns>
            <asp:BoundField DataField="Leave_Type_Name" HeaderText="Leave Type" SortExpression="Leave_Type_Name" />
            <asp:BoundField DataField="Leave_Name" HeaderText="Leave Name" SortExpression="Leave_Name" />
            <asp:BoundField DataField="OneTime_MaxDays" HeaderText="Max At A Time" SortExpression="OneTime_MaxDays" />
            <asp:BoundField DataField="Max_Days" HeaderText="Total Leaves" SortExpression="Max_Days" />
            <asp:BoundField DataField="leave_Earned" HeaderText="leaves Earned" SortExpression="leave_Earned" />
            <asp:BoundField DataField="Avail_Time_Limit" HeaderText="No of Times Avail" SortExpression="Avail_Time_Limit" />
            <asp:BoundField DataField="Period_Id" HeaderText="Period" SortExpression="Period_Id" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_Employee_Available" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
        SelectCommand="[Employee_Available_Leaves]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="emp_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Year" Name="year" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Month" Name="month" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
                                    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" Value='<%# Eval("EmpID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />                    </asp:GridView>
            <asp:HiddenField ID="HiddenField_to_Date" runat="server" />
            <asp:HiddenField ID="HiddenField_From_Date" runat="server" />
            <br />

    </asp:Content>