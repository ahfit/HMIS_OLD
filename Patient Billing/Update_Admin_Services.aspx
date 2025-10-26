<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Patient_Billing_Update_Admin_Services, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="diagnosis_list">
    <tr>
        <td colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td align="right">
            Select Category :</td>
        <td>
            <asp:DropDownList ID="ddl_category" runat="server" DataSourceID="SQL_category" 
                DataTextField="Asc_Name" DataValueField="Asc_id" AutoPostBack="True" 
                onselectedindexchanged="ddl_category_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SQL_category" runat="server"   
                ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" SelectCommand="SELECT   0  Asc_id, 'All' Asc_Name
union
SELECT     Asc_id, Asc_Name
FROM         Admin_Service_Category" ></asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td align="right">
            &nbsp;</td>
        <td>
            <asp:Button ID="btn_export" runat="server" OnClick="btn_export_Click" Text="Export" />
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource1" 
                DataKeyNames="S_ID" OnRowDataBound="GridView1_RowDataBound"  OnRowUpdating="GridView1_RowUpdating">
                <Columns>
                <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                     <asp:BoundField DataField="S_ID" HeaderText="Service ID" 
                        SortExpression="S_ID" />
                    <asp:BoundField DataField="S_Name" HeaderText="Service Name" 
                        SortExpression="S_Name" />
                    <asp:BoundField DataField="Asc_Name" HeaderText="Category" 
                        SortExpression="Asc_Name" />
                      <asp:BoundField DataField="S_Amount" HeaderText="Service Price" 
                        SortExpression="S_Amount" />                       
                    <asp:TemplateField>                        
                        <ItemTemplate>
                                <asp:DropDownList runat="server" ID="ddlStatus">
                                <asp:ListItem Value="True" Text="True"></asp:ListItem>
                                <asp:ListItem Value="False" Text="False"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:HiddenField runat="server" ID="hfStatus" Value='<%# Eval("Edit_Status") %>' />
                        </ItemTemplate>                                     
                        <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="ddlStatus">
                                <asp:ListItem Value="True" Text="True"></asp:ListItem>
                                <asp:ListItem Value="False" Text="False"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:HiddenField runat="server" ID="hfStatus" Value='<%# Eval("Edit_Status") %>' />
                        </EditItemTemplate>                                     
                    </asp:TemplateField>
                  
                    <asp:BoundField DataField="S_ID" HeaderText="S_ID" InsertVisible="False" 
                        SortExpression="S_ID" ReadOnly="True" Visible="False" />
                </Columns>
            </asp:GridView>
            <asp:HiddenField ID="status" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                SelectCommand="SELECT Admin_Services.S_ID, Admin_Services.S_Name, Admin_Services.S_Amount, Admin_Services.S_ID AS Expr1, Admin_Service_Category.Asc_Name,isnull( Admin_Services.Edit_Status,0) Edit_Status FROM Admin_Services INNER JOIN Admin_Service_Category ON Admin_Services.S_Category = Admin_Service_Category.Asc_id WHERE (@S_Category = 0) OR (Admin_Services.S_Category = @S_Category) ORDER BY Admin_Service_Category.Asc_Name" 
                UpdateCommand="UPDATE       Admin_Services
SET                S_Name = @S_Name, S_Amount = @S_Amount, Display_Rate = @S_Amount, Edit_Status = @Edit_Status
WHERE        (S_ID = @S_ID)"
               deleteCommand=" DELETE FROM Admin_Services WHERE (S_ID = @S_ID)" >
                 <DeleteParameters>
                   <asp:Parameter Name="S_ID" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddl_category" Name="S_Category" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="S_Name" />
                    <asp:Parameter Name="S_Amount" />
                    <asp:Parameter Name="S_ID" />                    
                    <asp:ControlParameter ControlID="status" Name="Edit_Status" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
</table>
</asp:Content>

