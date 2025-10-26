<%@ page language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Patient_Billing_AdminServicePackages, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <table style="width: 100%;">
        <tr>
            <td class="style1" align="right">For Ward Package :</td>
            <td class="style1">
                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True"
                    DataSourceID="dsWards" DataTextField="Ward_Name" DataValueField="Ward_Id">
                </asp:DropDownList>
                <asp:SqlDataSource ID="dsWards" runat="server"
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="select 0 as Ward_Id, '---ALL---' as Ward_Name union select Ward_Id,Ward_Name from Wards"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style1" align="right">Department :</td>
            <td class="style1">
                <asp:DropDownList ID="ddlDepartment" runat="server"
                    DataSourceID="dsDepartments" DataTextField="Dept_Name"
                    DataValueField="Dept_ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="dsDepartments" runat="server"
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="SELECT Dept_ID, Dept_Name FROM Department where Hospital_Id=@Hospital_Id">

                    <SelectParameters>
                <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
                </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style1" align="right">Package Name :</td>
            <td class="style1">
                <asp:TextBox ID="txtPackageName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">Total Amount :</td>
            <td>
                <asp:TextBox ID="txtTotalAmount" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td align="right">Doctor Share :</td>
            <td>
                <asp:TextBox ID="txtDoctorShare" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">Description :</td>
            <td>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine"></asp:TextBox></td>
        </tr>
        <tr>
            <td align="right">Service Head :</td>
            <td align="left">
                <asp:DropDownList ID="DDL_S_HEAD" runat="server"
                    DataSourceID="SqlDataSourceHead" DataTextField="E_Name" DataValueField="E_Code">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceHead" runat="server"
                    ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>"
                    SelectCommand="select E_Code,E_Name from expenditure where left(E_Code,2)=41 order by e_name asc"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="grdAdminServicePckg" runat="server" AutoGenerateColumns="False" Width="100%"
        DataKeyNames="ASP_ID" DataSourceID="dsAdminServicePckg">
        <Columns>
            <asp:BoundField DataField="AP_Name" HeaderText="Package"
                SortExpression="AP_Name" />
            <asp:BoundField DataField="Total_Amount" HeaderText="Total Amount"
                SortExpression="Total_Amount" />
            <asp:BoundField DataField="Doctor_Share" HeaderText="Doctor Share"
                SortExpression="Doctor_Share" />
            <asp:TemplateField HeaderText="Department" SortExpression="Dept_Name">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Dept_Name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server"
                        DataSourceID="dsDepartments" DataTextField="Dept_Name" DataValueField="Dept_ID"
                        SelectedValue='<%# Bind("Dept_ID") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Description" HeaderText="Description"
                SortExpression="Description" />
            <asp:BoundField DataField="Package_Date" HeaderText="On Date"
                SortExpression="Package_Date" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False"
                        CommandName="Delete"
                        OnClientClick="return confirm('Record will be deleted completely')"
                        Text="Delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowEditButton="True" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="dsAdminServicePckg" runat="server"
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
        InsertCommand="INSERT INTO Admin_Service_Package(AP_Name, Total_Amount, Description, Doctor_Share, Package_Date, Dept_ID,Ward_id,Head_Id,HospitalId) VALUES (@AP_Name, @Total_Amount, @Description, @Doctor_Share, getdate(), @Dept_ID,@Ward_id,@Head_Id,@HospitalId)"
        SelectCommand="SELECT Admin_Service_Package.ASP_ID, Admin_Service_Package.AP_Name, Admin_Service_Package.Total_Amount, Admin_Service_Package.Description, Admin_Service_Package.Doctor_Share, Admin_Service_Package.Package_Date, Admin_Service_Package.Dept_ID, Department.Dept_Name FROM Admin_Service_Package INNER JOIN Department ON Admin_Service_Package.Dept_ID = Department.Dept_ID"
        DeleteCommand="DELETE FROM Admin_Service_Package WHERE (ASP_ID = @ASP_ID)"
        UpdateCommand="UPDATE Admin_Service_Package SET AP_Name = @AP_Name, Total_Amount = @Total_Amount, Description = @Description, Doctor_Share = @Doctor_Share, Dept_ID = @Dept_ID WHERE (ASP_ID = @ASP_ID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="grdAdminServicePckg" Name="ASP_ID"
                PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="grdAdminServicePckg" Name="AP_Name"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="grdAdminServicePckg" Name="Total_Amount"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="grdAdminServicePckg" Name="Description"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="grdAdminServicePckg" Name="Doctor_Share"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="grdAdminServicePckg" Name="Dept_ID"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="grdAdminServicePckg" Name="ASP_ID"
                PropertyName="SelectedValue" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txtPackageName" Name="AP_Name"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="txtTotalAmount" Name="Total_Amount"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="txtDescription" Name="Description"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="txtDoctorShare" Name="Doctor_Share"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlDepartment" Name="Dept_ID"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList2" Name="Ward_id"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDL_S_HEAD" Name="Head_Id"
                PropertyName="SelectedValue" />            
            <asp:SessionParameter Name="HospitalId" SessionField="HospitalID" />
        
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>

