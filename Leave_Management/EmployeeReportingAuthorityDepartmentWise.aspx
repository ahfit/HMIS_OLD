<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EmployeeReportingAuthorityDepartmentWise.aspx.cs" Inherits="Leave_Management_EmployeeReportingAuthorityDepartmentWise" %>

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
                <asp:TemplateField HeaderText="Employee Name">
                    <ItemTemplate>
                        <asp:Label ID="lbEName" Text='<%# Bind("Employee_Name") %>' runat="server" />

                        <asp:HiddenField ID="hfEmpID" runat="server" Value='<%# Bind("EmpID") %>' />

                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:TemplateField HeaderText="Mark Authority">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnMark" runat="server" Text="Mark Authority" CommandArgument='<%# Bind("EmpID") %>' OnClick="btnMark_Click" />
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
                    <tr style="display:none">
                        <td width="35%" align="right">

                            <b>Employee Name:</b> </td>
                        <td>
                            <asp:DropDownList ID="ddlEmpName" runat="server" DataValueField="EmpID" DataTextField="Employee_Name">
                            </asp:DropDownList></td>

                    </tr>

                    <tr  >
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

                <asp:GridView ID="Gridview2" runat="server" AutoGenerateColumns="false" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.#">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Employee Name">
                            <ItemTemplate>
                                <asp:Label ID="lbEName" Text='<%# Bind("Employee_Name") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Department">
                            <ItemTemplate>
                                <asp:Label ID="lbEnaa" Text='<%# Bind("Authority_Name") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                       <asp:TemplateField HeaderText="Authority Level">
                            <ItemTemplate>
                                <asp:Label ID="lbAuthLevel" Text='<%# Bind("PriorityLevel") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField >
                            <ItemTemplate>
                                <asp:LinkButton Text="Delete" ID="btnDelAuthority" CommandArgument='<%#Bind("ReportingId") %>' OnClick="btnDelAuthority_Click" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>


            </div>
    </asp:Panel>



</asp:Content>

