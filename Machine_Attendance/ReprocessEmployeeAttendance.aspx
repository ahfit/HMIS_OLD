<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="ReprocessEmployeeAttendance.aspx.vb" 
    Inherits="HR_ReprocessEmployeeAttendance" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function confirmationDelete() {
            if (confirm('Are you sure you want to Reprocess Record ?')) {
                return true;
            } else {
                return false;
            }
        }

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
        <h2><span>Reprocess Employee Attendance</span></h2>
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
                        DataValueField="SubDept_Id" AutoPostBack="True" OnSelectedIndexChanged="DDL_Branch_SelectedIndexChanged">
                    </asp:DropDownList>
           <asp:SqlDataSource ID="SDS_Branch" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="
                            Select SubDepartment.SubDept_Id,SubDept_Name from SubDepartment
                            ORDER BY SubDept_Name">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Employee :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Sold_By" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Employee" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand=" Select '0' AS EmpID,'--ALL--'AS Name 
	                                    union 
	                                         SELECT Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+ Designation.Designation_Name +')' AS Name
	                                    FROM  Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID
	                                    WHERE 
	                                         (@SubDept_Id =0 or Employee.SubDeptId = @SubDept_Id)
	                                     AND 
	                                        (Employee.ActiveStatus = 1)   order by Name,EmpID"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="SubDept_Id"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>
            </tr> 
            <tr>
                <td align="right" class="style1">&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btn_Report" runat="server" Text="Show Record" CssClass="btn_hacims"
                        OnClick="btn_Report_Click" />
                       <asp:Button Text="Update" ID="btnUpdate" OnClick="btnUpdate_Click" runat="server" Visible="false" />
                      <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </td>
             
            </tr>
           
        </table>
    </div>
    <asp:GridView ID="gvupdatemachineID" AutoGenerateColumns="false" runat="server" OnRowDataBound="grdPatientsSchedules_RowDataBound">
        <Columns>
             <asp:TemplateField HeaderText="ID">
                <ItemTemplate>
                    <%#Container.DataItemIndex + 1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Employee ID">
                <ItemTemplate>
                    <asp:Label ID="lblID" runat="server"  Text='<%#Bind("EmpID")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Emploee Name">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblbEmployeeName" Text='<%#Bind("EmpName")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Desiganation">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblDesiganation" Text='<%#Bind("Designation_Name")%>'></asp:Label> 
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Department">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblSubdepartment" Text='<%#Bind("SubDept_Name")%>'></asp:Label> 
                </ItemTemplate>
            </asp:TemplateField>
            <%--<asp:TemplateField HeaderText="Basic Shift">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlShift" runat="server" DataValueField="ShiftID" DataTextField="ShiftName"></asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>--%>
            <asp:TemplateField HeaderText="Basic Shift" Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblBasicShift" Text='<%#Bind("ShiftName")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="From Date">
                <ItemTemplate>
                <igsch:WebDateChooser ID="webdatechooser" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <%--<asp:TextBox runat="server" ID ="btndate" "></asp:TextBox>--%>
                    <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
                    <%--<asp:TextBox runat="server" ID="txtDutyHours" Text='<%#Bind("DutyTimeHours")%>' SkinID="intdata"></asp:TextBox>--%> 
                </ItemTemplate>
            </asp:TemplateField>
              <asp:TemplateField>
                <ItemTemplate>
                    <%--<asp:CheckBox ID="chkatt" runat="server" Visible="true" ToolTip='<%# Bind("EmpID") %>'  />--%>
                    <asp:LinkButton ID="lnkbtn" runat="server"  CommandArgument='<%#Bind("EmpID")%>' text="Reprocess" OnClick="lnkbtn_Click"  OnClientClick="return confirmationDelete()"></asp:LinkButton>
                    <asp:HiddenField ID="HfSubDeptId" runat="Server" Value='<%#Bind("SubDeptId")%>'></asp:HiddenField>
                    <asp:HiddenField ID="HfShiftId" runat="Server" Value='<%#Bind("ShiftId")%>'></asp:HiddenField>
                    <asp:HiddenField ID="hfempid" runat="Server" Value='<%#Bind("EmpID")%>'></asp:HiddenField>
                 
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>


