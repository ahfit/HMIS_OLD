<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Advance_Search.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Patient_Registration_Advance_Search" %>

 
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


 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 
          <div class="bxmain">    <asp:Panel ID="Panel2" runat="server"  Width="100%"></asp:Panel></div>
             <br />

<div align="center"> <asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Search" /></div>
<br />


<asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                CssClass="Grid_1" Width="100%" PageSize="25" DataKeyNames="RegNo"  >
              <RowStyle CssClass="GridItem" />
              <HeaderStyle CssClass="GridHeader" />            
              <AlternatingRowStyle CssClass="GridAltItem" />
              <Columns>
                  <asp:TemplateField HeaderText="Assign Test" ShowHeader="False">
                      <ItemTemplate>
                          <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                              Text="New"></asp:LinkButton>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:ButtonField CommandName="OPD" Text="Existing" />
              </Columns><PagerStyle CssClass="GridPager"   />

            </asp:GridView>
     

<asp:Label CssClass="err"  ID="Label1" runat="server" ></asp:Label> 
<asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"> </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT [Diagnosis] FROM [Diagnosis]"></asp:SqlDataSource>

 <br />

<div align="center"><asp:Button CssClass="btn1" ID="Button_Print" runat="server" Text="Print" /></div>

<br />
 
 
  </asp:Content>