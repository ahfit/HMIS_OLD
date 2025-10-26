<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="Assign_Duty_To_EmployeeGrid.aspx.vb" Inherits="Assign_Duty_To_EmployeeGrid" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="bxmain inner_content" style="width:100%">
     <h2><span>Assign Duty to Employee</span></h2>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1">
            <tr>
                <td align="right" width="20%">
                    Start From :
                </td>
                <td width="28%">
                    <igsch:WebDateChooser ID="WebDateChooser1" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>

                 <td align="right">
                    Employee of
                    Sub Department :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListSubDepartment" runat="server" Width="200px" AutoPostBack="True"
                        Css DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name" OnSelectedIndexChanged="DropDownListSubDepartment_SelectedIndexChanged1" DataValueField="SubDept_Id">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    End Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser2" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>

                 <td align="right">
                    Employee Name :
                </td>
                <td valign="top">
                   <asp:DropDownList ID="DDLEmployee" runat="server" 
                       Width="400px" AutoPostBack="True">
                    </asp:DropDownList>
</td>
            </tr>
           
            

   
            <tr>
                <td align="right">
                    &nbsp;
                </td>
            <td align="right">
                    <asp:Button ID="ButtonSave" runat="server" Text="Search" />
                    <asp:LinkButton CssClass="login_link" ID="LinkButton1" runat="server" Visible="False">Show All Shift</asp:LinkButton>
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="False" ForeColor="Red"></asp:Label></td>

                <td align="right">
                    &nbsp;
                </td>

                <td align="right">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
    <asp:GridView ID="GridViewEmployeeShift" runat="server"
         AutoGenerateColumns="False" AllowSorting="true" 
        
        OnPageIndexChanging="GridViewEmployeeShift_PageIndexChanging"
        OnRowDataBound="GridViewEmployeeShift_RowDataBound"
         CssClass="Grid_1"
       Width="100%">
        <Columns>
            
            <asp:BoundField DataField="fordate" HeaderText="For Date" SortExpression="fordate" />
            <asp:BoundField DataField="mnthdat" HeaderText="Month Day" SortExpression="mnthdat" />
            <asp:BoundField DataField="wekday" HeaderText="Week Day" SortExpression="wekday" />
           <asp:TemplateField HeaderText="Select Shift">
               
               <ItemTemplate>
                   <asp:HiddenField ID="SubDeptId" runat="server" Value='<%# Bind("SubDeptId")%>' />
                   <asp:HiddenField ID="ShiftID" runat="server" Value='<%# Bind("Shift_ID") %>' />
                   <asp:HiddenField ID="Roasterid" runat="server" Value='<%# Bind("Duty_Roster_ID")%>' />
                   <asp:HiddenField ID="emproasterid" runat="server" Value='<%# Bind("Emp_Duty_Roster")%>' />
                   <asp:HiddenField ID="HFDForDate" runat="server" Value='<%# Bind("Calender_Date")%>' />
                   <asp:HiddenField ID="HFDForEmpID" runat="server" Value='<%# Bind("EmpID") %>' />
                   <asp:HiddenField ID="HFDIsApproved" runat="server" Value='<%# Bind("Is_Approved")%>' />
                   <asp:HiddenField ID="HFDEmpid" runat="server" Value='<%# Bind("ApprovedBy")%>' />
                  
                   <asp:DropDownList ID="DDLgridShift" runat="server"></asp:DropDownList>

               </ItemTemplate>
           </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>

                     <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                    <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                </span>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>--%>
                </ContentTemplate>
            </asp:UpdatePanel>
      <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:DutyRoaster %>"
        ProviderName="<%$ ConnectionStrings:DutyRoaster.ProviderName %>"
        SelectCommand="usp_GetAuthorityEmployeeDepartments" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:sessionparameter name="empid" sessionfield="Emp_ID" type="Int32" />
            
          <%--  <asp:ControlParameter ControlID="DropDownListDepartment" Name="Deptid" PropertyName="SelectedValue" />--%>
        </SelectParameters>
    </asp:SqlDataSource>
       <asp:HiddenField ID="HiddenFieldFlag" runat="server" />
    <asp:HiddenField ID="HiddenField_MyDate" runat="server" />

    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
   
    <asp:HiddenField ID="HiddenField_WeekDay" runat="server" />
    <asp:HiddenField ID="HiddenFieldOff_Day" runat="server" />
    <asp:HiddenField ID="HiddenField_Date_End" runat="server" />
    <asp:HiddenField ID="HiddenField_Date_Start" runat="server" />
    
    <table  width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1">
    <tr>
                <td align="right" width="40%">
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="Btnsave" runat="server" Text="Save" OnClick="Btnsave_Click" />
                     <asp:Button ID="btnReport" runat="server" Text="Report" OnClick="btnReport_Click" Visible="false" />
                   </td>
            </tr>
        </table>
</asp:Content>
