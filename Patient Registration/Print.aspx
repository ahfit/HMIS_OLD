<%@ page language="VB" autoeventwireup="false" inherits="Print, App_Web_3d5bytc0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 
<link href="css_hacims/class_reset.css"   rel="stylesheet"   type="text/css" media="screen, projection" />
<link href="css_hacims/class_content.css" rel="stylesheet"   type="text/css" media="screen, projection" />
 
<link href="../css_hacims/class_reset.css"   rel="stylesheet"   type="text/css" media="screen, projection" />
<link href="../css_hacims/class_content.css" rel="stylesheet"   type="text/css" media="screen, projection" />
 
<script type ="text/javascript" >
function resetform() {document.form1.reset(); document.form1.TextBoxYearlyNo.focus(); }

function print1(a)
{
    window.print(); 

}
</script>


<style type="text/css">body{background-color:#FFFFFF;}</style>
</head>

<body onload="print1(this)">
<form id="form1" runat = "server">
<div>

<div align="center" style="font-family:arial; font-size:16px; font-weight:bold;">
        <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
        
        </div>
        <br />
        
        <asp:GridView
        ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" DataSourceID="SqlDataSource_For_Grid"
        Width="100%">
        
        <Columns>
            <asp:BoundField DataField="Registration No" HeaderText="Registration No" SortExpression="Registration No" />
            <asp:TemplateField HeaderText="Patient Name" SortExpression="Prefix">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Prefix") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Prefix") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField_pfname" runat="server" Value='<%# Eval("PFName", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_pmname" runat="server" Value='<%# Eval("PMName", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_plname" runat="server" Value='<%# Eval("PLName", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_r" runat="server" Value='<%# Eval("Relation", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_rname" runat="server" Value='<%# Eval("[Relation Name]", "{0}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Registration Date" HeaderText="Registration Date" SortExpression="Registration Date" />
            <asp:BoundField DataField="MobilePhone" HeaderText="MobilePhone" SortExpression="MobilePhone" />
            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
            <asp:BoundField DataField="Patient Type" HeaderText="Patient Type" SortExpression="Patient Type" />
        </Columns><RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
       
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="Search_Patient_For_Print"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="startdate" SessionField="startdate" Type="DateTime" />
            <asp:SessionParameter Name="enddate" SessionField="enddate" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</div>

</form>

</body>
</html>