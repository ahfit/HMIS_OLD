<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="HR_searchEmp, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="100%">
     <tr>
        <td>
            Hospital
        </td>
        <td>
            <asp:DropDownList ID="ddlHospital" runat="server"
                DataTextField="Hospital_Name" DataValueField="Hospital_ID"  
                AutoPostBack="true" DataSourceID="sdsHospital" onselectedindexchanged="ddlHospital_SelectedIndexChanged"
            ></asp:DropDownList>
            <asp:SqlDataSource ID="sdsHospital" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"  
               SelectCommand="select 0 as Hospital_ID,'All' as Hospital_Name Union select Hospital_ID,Hospital_Name from hospital">
               
            </asp:SqlDataSource>
        </td>
     </tr>
    <tr>
        <td>
            Department:
        </td>
        <td>
            <asp:DropDownList ID="ddlDepartment" runat="server" 
               DataSourceID="sdsDepartment" DataTextField="Dept_Name" DataValueField="Dept_ID"
            ></asp:DropDownList>
            <asp:SqlDataSource ID="sdsDepartment"  runat="server"
            ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            
                SelectCommand=" SELECT 0 as Dept_ID, ' All' as Dept_Name union SELECT Dept_ID, Dept_Name FROM Department WHERE (Hospital_ID = @Hospital_ID or @Hospital_ID=0)  ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlHospital" Name="Hospital_ID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            
            
            
            </asp:SqlDataSource> 

        </td>
     </tr>
     <tr>
        <td>
            SubDepartment:
        </td>
        <td>
            <asp:DropDownList ID="ddlSubDepartment" runat="server"></asp:DropDownList>
        </td>
     </tr>
      <tr>
        <td>
            Employee NO
        </td>
        <td>
            <asp:TextBox ID="txtEmpNo" runat="server"></asp:TextBox>
        </td>
     </tr>
     <tr>
        <td>
          <asp:Button ID="btnSearch" runat="server" />
        </td>
        <td>
            <asp:Label ID="lblTotalRecordFound" runat="server"></asp:Label>
        </td>
     </tr>
</table>

</asp:Content>

