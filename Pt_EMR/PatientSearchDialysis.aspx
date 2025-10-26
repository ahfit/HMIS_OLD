<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatientSearchDialysis.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master" Inherits="PatientSearchDialysis" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


     
 <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
<link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
<script src="../css_hacims/ck.js" type="text/javascript"></script>
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

<asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                 Width="100%" PageSize="20" OnSorting="GridViewSearch_Sorting" AllowSorting="true" EmptyDataText="No Record(s) Found." >
            
              <Columns>
                  <asp:ButtonField CommandName="Cencel" Text="Cencel" Visible="False" />
                  <asp:ButtonField CommandName="Editrecord" Text="Edit" Visible="False" />
                  <asp:ButtonField CommandName="Create" Text="Create" />
                  <asp:ButtonField CommandName="StartSession" Text="Start Session" />
                  
                 <%-- <asp:ButtonField CommandName="View" Text="View" />
                  <asp:ButtonField CommandName="Services" Text="Services" />--%>
                  <asp:ButtonField CommandName="Medicine" Text="Medicine" Visible="false" />
                  <asp:TemplateField Visible="False">
                      <ItemTemplate>
                          <%--<asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">OPD Slip</asp:LinkButton>
                          <asp:HiddenField ID="hfld_RegNo" value='<%# Eval("Registration No") %>' runat="server" />
                          <asp:HiddenField ID="hfld_YearlyNo" value='<%# Eval("Visit No") %>' runat="server" />--%>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="MR #" SortExpression="RegNo" >
                      <ItemTemplate>
                          <asp:Label ID="lblRegNo" runat="server" Text='<%# Eval("RegNo") %>'></asp:Label>
                          <asp:HiddenField ID="hfDialysisID" runat="server" Value='<%#Eval("DialysisID") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="OPD #" SortExpression="OPDNo">
                      <ItemTemplate>
                          <asp:Label ID="lblOPDNo" runat="server" Text='<%# Eval("OPDNo") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Visit #" SortExpression="VisitNo">
                      <ItemTemplate>
                          <asp:Label ID="lblVisitNo" runat="server" Text='<%# Eval("VisitNo") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="PatientName" HeaderText="Patient Name" SortExpression="PatientName"  />
                  <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation"  />
                  <asp:BoundField DataField="RelationName" HeaderText="Relation Name"  SortExpression="RelationName" />
                  <asp:BoundField DataField="PatientAge" HeaderText="Age" SortExpression="PatientAge" />
                  <asp:BoundField DataField="DateOfBirth" HeaderText="Date Of Birth" SortExpression="DateOfBirth" />
                  <asp:BoundField DataField="RegistrationDate" HeaderText="Registration Date" SortExpression="RegistrationDate" />
                  <asp:BoundField DataField="MobilePhone" HeaderText="Mobile #" SortExpression="MobilePhone" />
                  <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC"/>
                  <asp:BoundField DataField="Patient_Type_ID" HeaderText="Patient Type" SortExpression="Patient_Type_ID"  />
                  
              </Columns><RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

            </asp:GridView></div>
            
        &nbsp;</td>
  </tr>
</table>

    
            
<asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"> </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT [Diagnosis] FROM [Diagnosis]"></asp:SqlDataSource>

     <asp:GridView ID="gvTest" runat="server">
            <Columns>
                <asp:BoundField DataField="RegNo" HeaderText="MR # / OPD #" SortExpression="RegNo" />
            </Columns>
        </asp:GridView>
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
function txtChangeMR() {

    var txt = document.getElementById("ctl00_ContentPlaceHolder1_txtRegNo");

    if (txt.value.length == 2 || txt.value.length == 5) {
        txt.value = txt.value + "-";
    }


}
$(function () {
    $('#ctl00_ContentPlaceHolder1_txtRegNo').keydown(function (e) {
        if (e.shiftKey || e.ctrlKey || e.altKey) {
            e.preventDefault();
        } else {
            var key = e.keyCode;
            if (!((key == 8) || (key == 9) || (key == 46) || (key >= 35 && key <= 40) || (key >= 48 && key <= 57) || (key >= 96 && key <= 105))) {
                e.preventDefault();
            }
        }
    });
});
$(document).ready(function () {
    $("#ctl00_ContentPlaceHolder1_txtOPDNo").attr('maxlength', '6');

});
$(function () {
    $('#ctl00_ContentPlaceHolder1_txtOPDNo').keydown(function (e) {
        if (e.shiftKey || e.ctrlKey || e.altKey) {
            e.preventDefault();
        } else {
            var key = e.keyCode;
            if (!((key == 8) || (key == 9) || (key == 46) || (key >= 35 && key <= 40) || (key >= 48 && key <= 57) || (key >= 96 && key <= 105))) {
                e.preventDefault();
            }
        }
    });
});
 
</script>
<br />
  </asp:Content>