<%@ Page Language="VB" AutoEventWireup="false" CodeFile="IndoorPayment.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Patient_Registration_IndoorPayment" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


<script type ="text/javascript" >
function resetform() {document.form1.reset(); document.form1.TextBoxYearlyNo.focus(); }
function enablelist(a)
{
if(a.checked==true)
{
document.getElementById ("dropdownlistDiagnosis").disabled =false;
}
else
{

document.getElementById ("dropdownlistDiagnosis").disabled =true;
}

}
</script>

 <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
<link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
<script src="../css_hacims/ck.js" type="text/javascript"></script>




</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"> <div class="bx_rad" style="width:100%;">
<ul id="tp1">
<li><strong>&nbsp;Search</strong></li><li>


              <asp:Panel ID="Panel2" runat="server" Width="100%"></asp:Panel> 
 
 
<div align="center"><asp:Button  ID="Button1" runat="server" Text="Search" /></div>
<br/> </li></ul></div></td>
  </tr>
  <tr>
    <td valign="top">
 

<asp:Label CssClass="err"  ID="Label1" runat="server" ></asp:Label>
<br />

<asp:GridView ID="GridViewSearch" runat="server" AutoGenerateColumns="False"
               Width="100%"  >
              <RowStyle CssClass="GridItem" />
              <HeaderStyle CssClass="GridHeader" />            
              <AlternatingRowStyle CssClass="GridAltItem" />
              <Columns>
                  <asp:ButtonField CommandName="Select" Text="Payment" />
                  <asp:ButtonField CommandName="Advance" Text="Advance Payment" />
              </Columns>
            </asp:GridView>
            
     &nbsp;</td>
  </tr>
</table>
    
<br />
 
<script type="text/javascript">

var cookies = Spry.Utils.Cookie("read","tabbedpanels");

 if (cookies == "true") { 
var tp1 = new Spry.Widget.CollapsiblePanel("tp1",{ contentIsOpen: true } );
} else { 
var tp1 = new Spry.Widget.CollapsiblePanel("tp1",{ contentIsOpen: false } );
 } 

Spry.Utils.addUnLoadListener(function(){
    
 Spry.Utils.Cookie("create","tabbedpanels",tp1.isOpen());
	
});

 
</script>
  </asp:Content>