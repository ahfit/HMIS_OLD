<%@ Page Title="" Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="InitiateEmployeeClearanceProcess.aspx.cs" Inherits="HR_InitiateEmployeeClearanceProcess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span>Initiate Employee Clearance Process</span></h2>

        <table class="table-form">
             <tr>
                <td align="right">
                    Hospital :
                </td>
                <td align="left">
                    <asp:DropDownList runat="server" CssClass="drop_down" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" ID="DDL_Campus" DataTextField="hospital_Name" DataValueField="Hospital_Id" Width="200px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Department:
                </td>
                <td align="left">
                    <asp:DropDownList runat="server" ID="DDL_SubDept" DataTextField="SubDept_Name" CssClass="drop_down" DataValueField="SubDept_Id" AutoPostBack="true" Width="200px" OnSelectedIndexChanged="DDL_SubDept_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td align="right">
                    Employee :
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_Employee" runat="server" AutoPostBack="true"
                                DataTextField="SubDept_Name" DataValueField="SubDept_Id" 
                                Width="200px" >
                            </asp:DropDownList>
                </td>
            </tr>
            <tr>
                 <td align="right">
                    Clearance Departments :
                </td>
                <td align="left">
                    <asp:CheckBoxList ID="ChkClearanceDepartments" runat="server" Selected="true"></asp:CheckBoxList>
                </td>
            </tr>
            </table>
        <div style="text-align: center; margin-top: 1%">
            <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Initiate Clearance Process"/>
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
             </div>
        </div>
            <asp:GridView ID="gvdClearance" runat="server" 
                AutoGenerateColumns="False"
                 DataSourceID="SqlDataSourceClearance"
                 CssClass="Grid_1" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="Sr#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                   
                    <asp:BoundField DataField="SubDept_Name" HeaderText="Department" SortExpression="SubDept_Name" />
                    <asp:BoundField DataField="EmpId" HeaderText="EmpId" SortExpression="EmpId" />
                    <asp:BoundField DataField="Employee" HeaderText="Employee" SortExpression="Employee" />
                    <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
                    <asp:BoundField DataField="JoiningDate" HeaderText="Joining Date" SortExpression="JoiningDate" />
                    <asp:BoundField DataField="InitiateDate" HeaderText="Initiate Date" SortExpression="InitiateDate" />
                    <asp:BoundField DataField="IsCleared" HeaderText="Cleared Status" SortExpression="IsCleared" />
                    


                    <asp:TemplateField HeaderText="Delete" Visible="true">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDeleteClearance" runat="server" Text="Delete" CommandArgument='<%#Bind("ClearanceId")%>' OnClick="lnkDeleteClearance_Delete"></asp:LinkButton>
                            <asp:HiddenField runat="server" ID="HfEmpId" Value='<%#Bind("EmpId")%>' />
                            <asp:HiddenField runat="server" ID="HfClearanceId" Value='<%#Bind("ClearanceId")%>' />
                            

                        </ItemTemplate>

                    </asp:TemplateField>

                     <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/FullandFinalSettelement.aspx?Emp_Id={0}"
                        HeaderText="Full and Final Settelement" Target="_blank" Text="Full and Final Settelement"
                        DataNavigateUrlFields="EmpId" />
                </Columns>
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView>

       

        <asp:SqlDataSource ID="SqlDataSourceClearance" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
        SelectCommand="Usp_GetEmployeeClearanceMain" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>


     
    <asp:HiddenField ID="HfSubDeptId" runat="server"/>

</asp:Content>

