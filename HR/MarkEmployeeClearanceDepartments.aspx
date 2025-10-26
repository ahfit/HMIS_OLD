<%@ Page Title="" Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="MarkEmployeeClearanceDepartments.aspx.cs" Inherits="HR_MarkEmployeeClearanceDepartments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span>Mark Clearance Departments</span></h2>
        <div style="text-align: center; margin-top: 1%">

            <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save"/>
            <br />

            <asp:GridView ID="gvdDepartments" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" Width="100%" OnRowDataBound="gvdDepartments_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Sr#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                   
                    <asp:BoundField DataField="SubDept_Name" HeaderText="Department" SortExpression="SubDept_Name" />
                    <asp:TemplateField HeaderText="Designation">
                    <ItemTemplate>
                       <asp:DropDownList ID="ddlDesignation" runat="server" DataSourceID="SqlDataSourceDesignation" DataTextField="Designation_Name" DataValueField="Designation_ID">
                           
                       </asp:DropDownList>
                        
                        <asp:SqlDataSource ID="SqlDataSourceDesignation" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
        SelectCommand="Usp_GetDeprtmentDesignations" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="SubDeptId" Type="Int32"/>
        </SelectParameters>
    </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                    


                    <asp:TemplateField HeaderText="Is Clearance Department">
                        <ItemTemplate>
                            <asp:CheckBox ID="ChkClearance" runat="server" Checked='<%# Bind("IsClearance") %>' />
                            <asp:HiddenField runat="server" ID="hfSubDeptId" Value='<%#Bind("SubDept_Id")%>' />
                            <asp:HiddenField runat="server" ID="HfClearanceId" Value='<%#Bind("ClearanceId")%>' />
                            <asp:HiddenField runat="server" ID="HfDesignationId" Value='<%#Bind("DesignationId")%>' />

                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Final Clearance Department">
                    <ItemTemplate>
                       <asp:CheckBox ID="ChkFinalClearance" runat="server" Checked='<%# Bind("IsFinal") %>'/>
                    </ItemTemplate>
                </asp:TemplateField>
                    
                </Columns>
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView>

        </div>




    </div>

     
    <asp:HiddenField ID="HfSubDeptId" runat="server"/>

</asp:Content>

