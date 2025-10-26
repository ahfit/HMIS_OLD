<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EmployeeReportingAuthority.aspx.cs" Inherits="Leave_Management_EmployeeReportingAuthority" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 184px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div class="bxmain inner_content" style="width: 100%; float: left">

        <h2><span>Mark Employee Reporting Authority</span></h2>


        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">

            <tr>
                <td width="35%" align="right">
                    <b>Hospital Name: </b></td>
                <td>
                    <asp:DropDownList ID="ddlHospital" runat="server"></asp:DropDownList>
                </td>

            </tr>
            <tr>
                <td width="25%" align="right">
                    <b>Department:</b></td>
                <td>
                    <asp:DropDownList ID="ddldepartment" runat="server" DataTextField="Dept_Name" DataValueField="Dept_ID" AutoPostBack="true" OnSelectedIndexChanged="ddldepartment_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>

            </tr>
            <tr>
                <td width="25%" align="right">

                    <b>SubDepartment:</b> </td>
                <td>
                    <asp:DropDownList ID="ddlsubdepartment" runat="server" DataValueField="SubDept_Id" DataTextField="SubDept_Name">
                    </asp:DropDownList></td>
            </tr>

            <tr>
                <td width="20%" colspan="2" align="center">
                    <asp:Button ID="btnShow" runat="server" Text="Show" OnClick="btnShow_Click" />

                </td>
            </tr>
        </table>
    </div>

    <div style="margin-top: 10px">

        <asp:GridView ID="Gridview1" runat="server" AutoGenerateColumns="false" Width="100%">
            <Columns>
                 
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Employee ID" HeaderStyle-Width="10%">
                    <ItemTemplate >
                        <asp:Label ID="lblEmp_id" Text='<%# Bind("EmpID") %>' runat="server" />

                      <%--  <asp:HiddenField ID="hfEmpID" runat="server" Value='<%# Eval("EmpID") %>' />--%>

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Employee Name">
                    <ItemTemplate>
                        <asp:Label ID="lbEName" Text='<%# Bind("Employee_Name") %>' runat="server" />

                        <asp:HiddenField ID="hfEmpID" runat="server" Value='<%# Eval("EmpID") %>' />

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name"/>
               
                <asp:TemplateField HeaderText="Mark Authority">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnMark" runat="server" ToolTip='<%# Bind("Employee_Name") %>' Text="Mark Authority" CommandArgument='<%# Bind("EmpID") %>' OnClick="btnMark_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
                <%--     <asp:TemplateField HeaderText="Assign Authority">
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Visible='<%#Bind("is_assigned") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Remove">
                    <ItemTemplate>

                        <asp:LinkButton ID="lnkbtnRemoveLeft" Text="Remove" Visible='<%#Bind("is_removable") %>'  CommandName='<%#Bind("ReportingID") %>' runat="server" OnClick="lnkbtnRemoveLeft_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns>
        </asp:GridView>

    </div>


    <asp:Panel ID="panel" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">

                <h2><span>Reporting Authority</span></h2>
                <table style="margin: 10px; line-height: 2">
                    <tr>
                        <td>
                            <b>Employee Name:</b>
                        </td>
                        <td>
                            <asp:Label ID="lblEmpName" runat="server" Text="Label"></asp:Label>

                        </td>
                    </tr>
                    <tr>
                        <td width="35%" align="right">

                            <b>SubDepartment:</b> </td>
                        <td>
                            <asp:DropDownList ID="ddlsubdeptReporting" OnSelectedIndexChanged="ddlsubdeptReporting_SelectedIndexChanged" AutoPostBack="true" runat="server" DataValueField="SubDept_Id" DataTextField="SubDept_Name">
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td width="35%" align="right">

                            <b>Employee Name:</b> </td>
                        <td>
                            <asp:DropDownList ID="ddlEmpName" runat="server" DataValueField="EmpID" DataTextField="Employee_Name">
                            </asp:DropDownList></td>
                       <%--  <asp:SqlDataSource ID="SDS_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="SELECT   0 as EmpID, '--ALL---' AS Name 
                                        UNION 
                                        SELECT Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+Cast( Designation.Designation_Name as varchar )+')' AS Name
                                        FROM  Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID	    
                                        WHERE 
                                        (Employee.ActiveStatus=1) 
                                        AND 
                                        (@SubDept_Id =0 or Employee.SubDeptId = @SubDept_Id) order by Name,EmpID"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlsubdeptReporting" Name="SubDept_Id"
                                PropertyName="SelectedValue" />
                            <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>--%>

                    </tr>

                    <tr>
                        <td width="35%" align="right">
                            <b>Authority Level:</b> </td>
                        <td>
                            <asp:TextBox ID="txtboxPriority" runat="server"></asp:TextBox>
                        </td>
                    </tr>




                    <tr>
                        <td width="20%" colspan="24" align="center">
                            <asp:Button ID="btnReporting" runat="server" Text="Mark Reporting Authority" OnClick="btnReporting_Click" />
                            <asp:Label ID="lblexist" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lblmsg" runat="server" Text="Update Successfully..." ForeColor="Green" Visible="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Button ID="closebtnPanel" Text="Close" runat="server" OnClick="closebtnPanel_Click" />

                        </td>
                    </tr>
                </table>
            </div>
            <div style="margin-top: 10px">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="Gridview2" runat="server" AutoGenerateColumns="false" 
                            AllowSorting="true" Width="100%">
                           
                          
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.#">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employee Name" SortExpression="Employee_Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lbEName" Text='<%# Bind("Employee_Name") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Authority Name" SortExpression="Authority_Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lbEnaa" Text='<%# Bind("Authority_Name") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Authority Level" SortExpression="PriorityLevel">
                                    <ItemTemplate>
                                        <asp:Label ID="lbPLevels" Text='<%# Bind("PriorityLevel") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField SortExpression="ReportingId">
                                    <ItemTemplate>
                                        <asp:LinkButton Text="Delete" ID="btnDelAuthority" CommandArgument='<%#Bind("ReportingId") %>' OnClick="btnDelAuthority_Click" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                    <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                        <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                    </span>
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
    </asp:Panel>



</asp:Content>

