<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Discount_Search.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Discount_Search" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


<script type ="text/javascript" >
function resetform() {document.form1.reset(); document.form1.TextBoxYearlyNo.focus(); }
function enablelist(a)
{
if(a.checked==true)
{
document.getElementById ("dropdownlistDiagnosis").disabled =false;
}
elsestore
{

document.getElementById ("dropdownlistDiagnosis").disabled =true;
}

}


function confirmationDelete() {
    if (confirm('Are you sure you want to delete Record ?')) {
        return true;
    } else {
        return false;
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
                  <asp:ButtonField CommandName="Select" Text="Discount" />

                <%--  <asp:TemplateField>
                      <ItemTemplate>
                          <asp:HiddenField ID="hfdiscount" runat="server"  Value='<%# Eval("Request_ID") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>--%>

                   <%--<asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnk_DeleteRecord" CssClass="delete" runat="server" Text="Reject"  CommandArgument='<%#Eval("Visit No") %>'
                                    onclick="lnk_DeleteRecord_Click" OnClientClick="return confirmationDelete();"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>--%>

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