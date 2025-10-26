<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Administrator_ManageEmployeeMainPge, App_Web_hbh2gz45" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%">
        <tr>
            <td align="right">
                Select Branch :
            </td>
            <td>
                <asp:DropDownList ID="DDL_SubDepartment" runat="server" AutoPostBack="True" DataSourceID="SDS_SubDept"
                    DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SDS_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT 0 AS SubDept_Id, '---ALL---' AS SubDept_Name UNION SELECT SubDept_Id, SubDept_Name FROM SubDepartment Where IS_Hidden is Null">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                Select Employee :
            </td>
            <td>
                <asp:DropDownList ID="DDL_Employee" runat="server" DataSourceID="SDS_Employee" DataTextField="EfName"
                    DataValueField="EmpID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SDS_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT 0 AS EmpID, '---All---' AS EfName UNION SELECT EmpID, ISNULL(EfName,'')+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,'') EfName FROM Employee WHERE ActiveStatus=1 and (SubDeptId LIKE CASE WHEN @subdept_id = 0 THEN '%' ELSE @subdept_id END) ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DDL_SubDepartment" Name="subdept_id" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
            </td>
            <td>
                <asp:Button ID="Btn_Search" runat="server" Text="Search" OnClick="Btn_Search_Click" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="gvEmployeeMainPageDetail" Width="100%" DataSourceID="SdsEmployeeMainPageDetail"
        AllowPaging="true" PageSize="20" runat="server" AutoGenerateColumns="False" DataKeyNames="MainPage_ID"
        OnRowUpdating="gvEmployeeMainPageDetail_RowUpdating">
        <Columns>
            <asp:BoundField DataField="Employee_Name" HeaderText="Employee Name" ReadOnly="True"
                SortExpression="Employee_Name" />
            <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName" />
            <asp:BoundField DataField="id" HeaderText="id" Visible="false" InsertVisible="False"
                ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="MainPage_ID" Visible="false" HeaderText="MainPage_ID"
                InsertVisible="False" ReadOnly="True" SortExpression="MainPage_ID" />
            <asp:TemplateField HeaderText="Main Page" SortExpression="MainPage">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlMainPage" runat="server" DataSourceID="SqlDataSource1" DataTextField="MainPage"
                        DataValueField="MainPage_ID" SelectedValue='<%# Bind("MainPage_ID") %>' Enabled="False"
                        AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="SELECT [MainPage_ID], [MainPage] FROM [MainPages]"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <%--  <asp:BoundField DataField="MainPage" HeaderText="MainPage" 
                SortExpression="MainPage" />--%>
            <asp:TemplateField HeaderText="Manage Page">
                <ItemTemplate>
                    <asp:LinkButton ID="btnChangeMainPage" runat="server" Text="Change Main Page" CommandArgument='<%# Eval("id") %>'
                        OnClick="btnChangeMainPage_Click"></asp:LinkButton>
                    <asp:LinkButton ID="btnUpdate" runat="server" Text="Update" CommandArgument='<%# Eval("id") %>'
                        Visible="false" OnClick="btnUpdate_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SdsEmployeeMainPageDetail" runat="server" SelectCommandType="StoredProcedure"
        ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>"
        SelectCommand="usp_GetEmployeeMainPageDetail" UpdateCommand="usp_UpdateEmployeeMainPage"
        UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDL_Employee" Name="EmpID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DDL_SubDepartment" Name="SubDeptId" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="id" Type="Int32" />
            <asp:Parameter Name="MainPage_Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
