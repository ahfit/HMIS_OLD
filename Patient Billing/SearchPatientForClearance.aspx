<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="SearchPatientForClearance.aspx.cs" Inherits="Store_SearchPatientForClearance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="bxmain inner_content" style=" padding-bottom:10px">
        <h2> Patient For Discharge Clearance </h2>
     </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" EmptyDataText="No Request Pending For Clearance!"
        Width="100%">
        <Columns>
              <asp:TemplateField HeaderText="Sr #">
                <ItemTemplate>
                   <%# Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="PatientName" HeaderText="Patient Name"  />
            <asp:BoundField DataField="FromSubDept" HeaderText="Patient Department" />
            <asp:BoundField DataField="forward_date" HeaderText="Forwarded Date" />
         <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="btnclear" OnClientClick="return confirm('Are you sure you want to mark this patient as Cleared');"
                        runat="server" CommandArgument='<%#Eval("Reg_No")%>' ToolTip='<%#Eval("yearly_no")%>'
                        Text="Mark Cleared" Width="100px" OnClick="btnClear_Clicked" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>
