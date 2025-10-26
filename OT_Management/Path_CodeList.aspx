<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Path_CodeList.aspx.vb" Inherits="Pathology_Path_CodeList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link href="../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../images/sheet_form.css" rel="stylesheet" type="text/css" />


<script src="../images/highlight.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function OpenNewPage()
{
var regno=document.getElementById("HiddenFieldRegNo").value;
var yearlyno=document.getElementById("HiddenFieldYearlyNo").value;
window.open("","MyWidows")
    
}
</script>

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}
.Grid_1 th {background-image:url(../images/block_title_2_large.gif); background-repeat:repeat-x; height:40px;}
*{margin:0 0 0 0;}
</style>

</head>

<body><form id="form1" runat = "server">

<div id="forms_items" class="forms_items">

<br />
<br class="break" />



<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="border:#CCCCCC solid 1px; padding:5px;" colspan="3"> 
   

<asp:GridView ID="GridView_Booking" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
DataKeyNames="TB_ID" DataSourceID="SqlDataSource_Booking" Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" InsertVisible="False" ReadOnly="True"
                                        SortExpression="TB_ID" />
                                    <asp:TemplateField HeaderText="Test Name" SortExpression="TB_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TB_Name") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("TB_Name") %>'></asp:Label>&nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Group Name" SortExpression="TGName">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TGName") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("TGName") %>'></asp:Label><br />
                                            &nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Public Price" SortExpression="Public_Price">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Public_Price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Public_Price") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Private Price" SortExpression="Private_Price">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Private_Price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Private_Price") %>'></asp:Label>
                                            <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader2" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                      
                            <asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Booking.TB_ID, Test_Booking.TB_Name, TestGroup.TGName, Test_Booking.Private_Price, Test_Booking.Public_Price FROM Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID&#13;&#10;order by TestGroup.TGID,Test_Booking.TB_ID">
                            </asp:SqlDataSource>
        &nbsp;
                            <asp:HiddenField ID="HiddenField_TBID" runat="server" />
        &nbsp;&nbsp;
    </td>
  </tr>
</table>
<br />
</div>
</form>
</body>
</html>