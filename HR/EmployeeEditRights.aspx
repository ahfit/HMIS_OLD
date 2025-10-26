<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_EmployeeEditRights, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="big_wrapper" style="width: 100%" class="bxmain inner_content">
        <h2>
            <span>Total Return Books Report</span></h2>
        <table width="100%" class="tbl_form">
            <tr>
                <td style="width: 40%; text-align: right;">
                    <asp:Label ID="Label4" runat="server" Text="Department :"></asp:Label>
                </td>
                <td style="width: 50%; text-align: left;">
                    <asp:DropDownList ID="ddlDept" runat="server" AutoPostBack="true" 
                        OnSelectedIndexChanged="ddlDept_SelectedIndexChanged">
                    </asp:DropDownList>

                </td>
            </tr>

            <tr>
                <td style="width: 40%; text-align: right;">
                    <asp:Label ID="Label7" runat="server" Text="Sub Department:"></asp:Label>
                </td>
                <td style="width: 50%; text-align: left;">
                    <asp:DropDownList ID="ddlSubDept" runat="server"></asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td style="text-align: center; padding-top: 7px;" colspan="2">&nbsp;</td>
            </tr>
        </table>
        <div style="text-align: center;">
            <asp:Button ID="btn_Search" runat="server" Text="Search Employee"
                OnClick="btn_Search_Click" />
        
        <asp:Button ID="btnSave" runat="server" Text="Save"
                OnClick="btnSave_Click" />

                <asp:Label ID="lblMsg" Visible="false" runat="server" ForeColor="Green" Font-Size="15px" Text="Data is Save Successfully"></asp:Label>
        </div>
    </div>
    <div style="width:100%;">
    <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvdEmployee" 
            onrowdatabound="gvdEmployee_RowDataBound">
    <Columns>
    <asp:BoundField HeaderText="Dept Name" DataField="Dept_Name" />
    <asp:BoundField HeaderText="SubDept Name" DataField="SubDept_Name" />
    <asp:BoundField HeaderText="Employee Name" DataField="employee_name" />
    <asp:TemplateField HeaderText="Select">
    <ItemTemplate>
    <asp:CheckBox ID="checkbox" runat="server"  ToolTip='<%# Eval("SelectedEmployee") %>'    />
    <asp:HiddenField ID="hfEmpid" runat="server" Value='<%# Eval("EmpID") %>' /> 
    <asp:HiddenField ID="isactive" runat="server" Value='<%# Eval("isActive") %>' /> 
    
    </ItemTemplate>
    </asp:TemplateField>
    </Columns>
    </asp:GridView>
    </div>

</asp:Content>

