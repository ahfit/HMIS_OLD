<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Advertisement_Interview_Panel_Selection, App_Web_sbolykjk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:content id="Content1" contentplaceholderid="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 40%;
            text-align: right;
        }

        .style2 {
            width: 60%;
            text-align: left;
        }

        .Panelstyle1 {
            width: 22%;
            text-align: right;
        }

        .Panelstyle2 {
            width: 22%;
            text-align: left;
        }
    </style>
    <script type="text/javascript">
        function PanelAddPosts() {
            $("[id$='PanelAddPosts']").toggle();

        }
        function PanelQuotaPosts() {
            $("[id$='PanelQuotaPosts']").toggle();
        }
    </script>
</asp:content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Interview Panel Selection</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td class="style1">Advertisement</td>
                <td class="style2">
                    <asp:DropDownList runat="server" ID="DDL_Advertisement" DataTextField="Ad_Title" DataValueField="Ad_Id">    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style1">Select Department
                </td>
                <td class="style2">
                    <asp:DropDownList runat="server" ID="DDL_Department" DataTextField="Dept_Name" DataValueField="Dept_Id" AutoPostBack="true" OnSelectedIndexChanged="DDL_Department_SelectedIndexChanged"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style1">Employee
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="DDL_Employee" DataTextField="Employee_Name" DataValueField="EmpId"></asp:DropDownList>
                </td>
            </tr>
           
            <tr>
                <td colspan="2" align="center">
                    <asp:Button Text="Add" ID="btnAdd" runat="server" OnClick="btnAdd_Click" />
                    <asp:Label ID="lblMsg" runat="server" />
                </td>
            </tr>
        </table>
        <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False"
            AllowPaging="True" PageSize="50" EmptyDataText="No Record(s) Found">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Emp ID">
                    <ItemTemplate>
                        <asp:Label ID="lblEmp_Id"  Text='<%# Bind("Emp_Id") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Label ID="txtName" Text='<%# Bind("Name") %>'  runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Designation">
                    <ItemTemplate>
                        <asp:Label ID="lblDesignation" Text='<%# Bind("Designation_Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField >
                <asp:TemplateField HeaderText="Department">
                    <ItemTemplate>
                        <asp:Label ID="lblDepartment" Text='<%# Bind("Dept_Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton Text="Remove" CommandArgument='<%# Bind("Interview_Panel_Id") %>' runat="server" ID="lbtnRemove" OnClick="lbtnRemove_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

    </div>
</asp:content>
