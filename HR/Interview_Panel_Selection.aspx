<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="Interview_Panel_Selection.aspx.cs" Inherits="HR_Advertisement_Interview_Panel_Selection" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<script runat="server">

    
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 40%;
            text-align: right;
        }
        
        .style2
        {
            width: 60%;
            text-align: left;
        }
        
        .Panelstyle1
        {
            width: 22%;
            text-align: right;
        }
        
        .Panelstyle2
        {
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Interview Panel Selection</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td class="style1">
                    Advertisement
                </td>
                <td class="style2">
                    <asp:DropDownList runat="server" ID="DDL_Advertisement" DataTextField="Ad_Title"
                        DataValueField="Ad_Id" AutoPostBack="true"
                        onselectedindexchanged="DDL_Advertisement_SelectedIndexChanged">
                    </asp:DropDownList>
                    <span style="padding-left: 4px; color: Green;">
                        <asp:CheckBox Text="Outer faculity" AutoPostBack="true" ID="chkboxSelection" runat="server"
                            OnCheckedChanged="chkboxSelection_CheckedChanged" /></span>
                              <asp:LinkButton ID="lnkbtnAddOuterEmployee" runat="server" Text="Add Outer Employee"
                        OnClick="lnkbtnAddOuterEmployee_Click"></asp:LinkButton>
                </td>
            </tr>
             <tr>
                <td class="style1">
                    Job Post
                </td>
                <td class="style2">
                    <asp:DropDownList runat="server" ID="ddlPosts" DataTextField="Ad_Title"
                        DataValueField="Ad_Id" AutoPostBack="true" onselectedindexchanged="ddlPosts_SelectedIndexChanged"
                        >
                    </asp:DropDownList>  
                    <asp:RequiredFieldValidator ID="validator" runat="server" ErrorMessage="Required" ControlToValidate="ddlPosts" ValidationGroup="mainApp" ></asp:RequiredFieldValidator>                
                </td>
            </tr>

           

            <tr runat="server" id="department" runat="server">
                <td class="style1">
                    Select Department
                </td>
                <td class="style2">
                    <asp:DropDownList runat="server" ID="DDL_Department" DataTextField="Dept_Name" DataValueField="Dept_Id"
                        AutoPostBack="true" OnSelectedIndexChanged="DDL_Department_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr id="employee"  runat="server">
                <td class="style1">
                    Employee
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="DDL_Employee" DataTextField="Employee_Name"
                        DataValueField="EmpId" 
                        onselectedindexchanged="DDL_EmployeeOuter_SelectedIndexChanged" >
                    </asp:DropDownList>
                </td>
            </tr>
            <tr id="divddlOuterEmployee"  runat="server">
                <td class="style1">
                    Employee
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlOuterEmployee" DataTextField="Employee_Name"
                 AutoPostBack="true"       DataValueField="EmpId" OnSelectedIndexChanged="DDL_Employee_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr runat="server" id="empDetailouter" >
                <td class="style1">
                    Employee Detail
                </td>
                <td class="style2">
                    <asp:DataList  runat="server" id="tempEmployyDatalist"  >
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td ><span style="font-size:large;color:Red"> <%# Eval("columnmae")%></span></td> <td><span style="font-size:large;color:Green"><%# Eval("Value")%></span></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                  
                </td>
            </tr>
            <asp:SqlDataSource ID="SqlDataSource1" SelectCommand="" runat="server">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DDL_Employee" Type="Int32" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button Text="Add" ID="btnAdd" runat="server" ValidationGroup="mainApp" OnClick="btnAdd_Click" />
                    <asp:Label ID="lblMsg" Visible="false" Font-Bold="true" Font-Size="15px" runat="server" />
                </td>
            </tr>
        </table>
        <div style="width::100%" class="bxmain inner_content"><span><h2>AlKhidmat Faculty</h2></span>
        
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
                        <asp:Label ID="lblEmp_Id" Text='<%# Bind("Emp_Id") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Label ID="txtName24" Text='<%# Bind("Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Designation">
                    <ItemTemplate>
                        <asp:Label ID="lblDesignation" Text='<%# Bind("Designation_Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Department">
                    <ItemTemplate>
                        <asp:Label ID="lblDepartment4" Text='<%# Bind("Dept_Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton Text="Remove" CommandArgument='<%# Bind("Interview_Panel_Id") %>'
                            runat="server" ID="lbtnRemove" OnClick="lbtnRemove_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        
        </div>
    </div>

     <div style="width::100%" class="bxmain inner_content"><span><h2>Outer Faculty</h2></span>
      <asp:GridView ID="gridviewOuterEmployee" runat="server" Width="100%" AutoGenerateColumns="False"
            AllowPaging="True" PageSize="50" EmptyDataText="No Record(s) Found">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>                
                
                <asp:TemplateField HeaderText="Advertisment title">
                    <ItemTemplate>
                        <asp:Label ID="txtName6" Text='<%# Bind("Ad_Title") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Label ID="txtName3" Text='<%# Bind("EmployeeName") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Institute">
                    <ItemTemplate>
                        <asp:Label ID="txtName4" Text='<%# Bind("Institute") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Designation">
                    <ItemTemplate>
                        <asp:Label ID="lblDesignation" Text='<%# Bind("Designation") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Department">
                    <ItemTemplate>
                        <asp:Label ID="lblDepartment1" Text='<%# Bind("DepartmentName") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Experience">
                    <ItemTemplate>
                        <asp:Label ID="lblDepartment2" Text='<%# Bind("Experience") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Experties">
                    <ItemTemplate>
                        <asp:Label ID="lblDepartment3" Text='<%# Bind("Experties") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton Text="Remove" CommandArgument='<%# Bind("OuterEmployee_ID") %>'
                            runat="server" ID="lbtnRemove" OnClick="RemoveOuterFaculty_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
     </div>


</asp:Content>
