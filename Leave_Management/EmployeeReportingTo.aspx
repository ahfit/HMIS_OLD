<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EmployeeReportingTo.aspx.cs" Inherits="Leave_Management_EmployeeReportingTo" %>

<asp:Content ID="content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:GridView ID="GridView1" Width="100%" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Employee ID" ItemStyle-Width="50px">
                <ItemTemplate>
                    <asp:Label ID="lbl_EmpID" runat="server" Text='<%# Bind("EmpID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Employee Name">
                <ItemTemplate>
                    <asp:Label ID="lbl_" runat="server" Text='<%# Bind("Employee_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CNIC" ItemStyle-Width="200px" >
                <ItemTemplate>
                    <asp:Label ID="lbl_CNIC" runat="server" Text='<%# Bind("CNIC") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Mobile No">
                <ItemTemplate>
                    <asp:Label ID="lbl_Mobile_Number" runat="server" Text='<%# Bind("Mobile_Number") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Relation Name">
                <ItemTemplate>
                    <asp:Label ID="lbl_Relation_Name" runat="server" Text='<%# Bind("Relation_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Email Address">
                <ItemTemplate >
                    <asp:Label ID="lbl_email_address" runat="server" Text='<%# Bind("email_address") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Designation">
                <ItemTemplate>
                    <asp:Label ID="lbl_Designation_Name" runat="server" Text='<%# Bind("Designation_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sub Department">
                <ItemTemplate>
                    <asp:Label ID="lbl_SubDept_Name" runat="server" Text='<%# Bind("SubDept_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Gender">
                <ItemTemplate>
                    <asp:Label ID="lbl_Gender" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="View Attendance">
                <ItemTemplate>
                    <asp:LinkButton ID="lbViewAttedance" CommandArgument='<%#Eval("EmpID")%>'  OnClick="lbViewAttedance_Click" runat="server">View Attendance</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Leave Summary">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnLeaveSummary" CommandArgument='<%#Eval("EmpID")%>'  OnClick="lbtnLeaveSummary_Click" runat="server">Leave Summary</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
   
</asp:Content>
