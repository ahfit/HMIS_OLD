<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Update_Admin_ServicesHead.aspx.cs" Inherits="Patient_Billing_Update_Admin_ServicesHead" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="sm" runat="server" ></asp:ScriptManager>
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
            Search Services :</td>
        <td>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt" 
                                                Width="200px" AutoPostBack="false"></asp:TextBox>
                                            <asp:Label ID="Label1" runat="server" CssClass="err" Visible="False"></asp:Label>
              <asp:HiddenField ID="hfItemCode" runat="server" />
             <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="TextBox1" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2">
                    </asp:AutoCompleteExtender>
        </td>
        </tr>
        
    
    <tr>
        <td align="right">
            &nbsp;</td>
        <td>
            <asp:Button ID="btn_export" runat="server" OnClick="btn_export_Click" Text="Search" />
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="S_ID" OnRowDataBound="GridView1_RowDataBound" OnRowEditing ="GridView1_RowEditing"  OnRowUpdating="GridView1_RowUpdating1" DataSourceID="SqlDataSource1">
                <Columns>
                <asp:TemplateField HeaderText="SrNo."> 
                <ItemTemplate> <%#Container.DataItemIndex+1%> 
                </ItemTemplate>
                <ItemStyle Width="8%" /> 
                </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                    
                    <asp:TemplateField  HeaderText="Service ID" ControlStyle-Width="190">                        
                        <ItemTemplate>
                                <asp:Label ID="lblSID" runat ="server" Text='<%# Eval("S_ID") %>' ></asp:Label>
                        </ItemTemplate>           
                                </asp:TemplateField>
                     <asp:TemplateField  HeaderText="Service Name" ControlStyle-Width="190">                        
                        <ItemTemplate>
                                <asp:Label ID="lblSNAMe" runat ="server" Text='<%# Eval("S_Name") %>' ></asp:Label>
                        </ItemTemplate>           
                                </asp:TemplateField>
                    <asp:TemplateField ControlStyle-Width="190">                        
                        <ItemTemplate>
                                <asp:DropDownList runat="server"   ID="ddlStatus"> </asp:DropDownList>
                        <asp:HiddenField ID="hfdstatus" runat="server"  />
                        </ItemTemplate>                                     
                                                    
                    </asp:TemplateField>
                  
                    
                </Columns>
            </asp:GridView>
            <asp:HiddenField ID="status" runat="server" />
            <asp:HiddenField ID="HiddenFieldSID" runat="server" />
            <asp:HiddenField ID="HiddenFieldSHID" runat="server" />
            <asp:HiddenField ID="HiddenFieldPHID" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                SelectCommand="SELECT TOP (20) Admin_Services.S_ID, Admin_Services.S_Name, Admin_Services.S_Amount, Admin_Services.S_ID AS Expr1, Admin_Service_Category.Asc_Name,isnull( Admin_Services.Edit_Status,0) Edit_Status FROM Admin_Services INNER JOIN Admin_Service_Category ON Admin_Services.S_Category = Admin_Service_Category.Asc_id WHERE ((@S_Category = 0) OR (Admin_Services.S_Category = @S_Category)) and S_Name like '%'+@SNAME+'%' ORDER BY Admin_Service_Category.Asc_Name" 
                UpdateCommand="UPDATE       Admin_Services
SET               SH_ID=@SH_ID
WHERE        (S_ID = @S_ID)

Insert into HeadChangeTrack(serviceid,cheadid,changedate ,Emp_ID,pheadid) VALUES(@S_ID,@SH_ID,GetDate(),@EmpID,@PHID)"
               deleteCommand=" DELETE FROM Admin_Services WHERE (S_ID = @S_ID)" >
                 <DeleteParameters>
                   <asp:Parameter Name="S_ID" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="SNAME" DefaultValue="%"
                        PropertyName="Text" />
                     <asp:ControlParameter ControlID="ddl_category" Name="S_Category" 
                        PropertyName="SelectedValue" />
                  
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="HiddenFieldSID" Name="S_ID"    PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenFieldPHID" Name="PHID"    PropertyName="Value" />
                  
                      <asp:ControlParameter ControlID="HiddenFieldSHID" Name="SH_ID"   PropertyName="Value" />   
                     <asp:SessionParameter DefaultValue="0" Name="EmpID" SessionField="emp_id" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
</table>
</asp:Content>

