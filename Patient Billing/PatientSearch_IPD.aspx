<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" CodeFile="~/Patient Billing/PatientSearch_IPD.aspx.vb" inherits="Patient_Billing_patientsearch_IPD"%>

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
    <td valign="top"><div class="bx_rad" style="width:100%;">
<ul id="tp1">
<li><strong>&nbsp;Search</strong></li><li>

 
              
              <asp:Panel ID="Panel2" runat="server" Width="100%"></asp:Panel>

<br />

 
<div align="center"><asp:Button  ID="Button1" runat="server" Text="Search" /></div></li>
      
</ul></div></td>
  </tr>
  <tr>
    <td valign="top">



 
<asp:Label CssClass="err"  ID="Label1" runat="server" ></asp:Label><br/>
 <div style="width:100%; overflow:auto;">
<asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True"
                 Width="100%" EmptyDataText="Record Found" PageSize="500"  >
            
              <Columns>
                
                  <asp:ButtonField CommandName="Cencel" Text="IPD Slip" />
                  <asp:ButtonField CommandName="Editrecord" Text="Edit" Visible="False" />
                
                  <asp:ButtonField CommandName="Services" Text="Services"/>
                    <asp:ButtonField CommandName="View" Text="Refund" />
                  <asp:ButtonField CommandName="IPDSLIP" Text="Runing Bill"/>
                  
                  <asp:TemplateField Visible="False">
                      <ItemTemplate>
                          <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">IPD Slip</asp:LinkButton>
                          <asp:HiddenField ID="hfld_RegNo" value='<%# Eval("Registration No") %>' runat="server" />
                          <asp:HiddenField ID="hfld_YearlyNo" value='<%# Eval("Visit No") %>' runat="server" />
                      </ItemTemplate>
                  </asp:TemplateField>
                    <asp:ButtonField CommandName="PT_Change_Room" Text="Change Room" />
                 <%-- <asp:HyperLinkField DataNavigateUrlFields="Registration No,Visist No" 
                      DataNavigateUrlFormatString="~/Pharmacy/Medicine_Consumption_To_WIPatient.aspx?RegNo={0}&amp;yearlyNo={1}" 
                      HeaderText="Medicine" Target="_blank" Text="Add" />
--%>              </Columns><RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

            </asp:GridView></div>
            
        &nbsp;</td>
  </tr>
</table>

    
            
<asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"> </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT [Diagnosis] FROM [Diagnosis]"></asp:SqlDataSource>


<br />
<br /><script type="text/javascript">

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
<br />
  </asp:Content>