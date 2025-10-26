<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_EmployeeConfirmationDetail, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width="100%">
    <tr>
        
        <td>
        
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" 
                onselectedindexchanged="RadioButtonList1_SelectedIndexChanged" 
                RepeatDirection="Horizontal">
                <asp:ListItem Value="0">Confirmed Employee</asp:ListItem>
                <asp:ListItem Value="1">Confirmation Due</asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td>
        </td>
    </tr>
     <tr>
        <td colspan="2">
            <asp:GridView ID="GridView1" runat="server" Width="100%">
            </asp:GridView>
        </td>
       
    </tr>

 <tr>
        <td>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                SelectCommand="usp_EmpConfirmDetail" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="RadioButton1" Name="is_confirmed" 
                        PropertyName="Checked" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
        <td>
        </td>
    </tr>

 <tr>
        <td>
        </td>
        <td>
        </td>
    </tr>


</table>

</asp:Content>

