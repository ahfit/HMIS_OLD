<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="print_Patient_Search, App_Web_3d5bytc0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
<script language="javascript" type="text/javascript">
function OpenWindow()
{
    var RegNo=document.getElementById("hidRegNo").value;
    var YearlyNo=document.getElementById("HidYearlyNo").value;
    window.open('Mark_Test_For_Pathology.aspx?registrationNo='+RegNo+'&YearlyNo='+YearlyNo,'','toolbar=none,width=1000,y=10,x=10');
}
</script>

<style type="text/css">

#printgrid {height:100%; overflow:auto; overflow-x:hidden; }

</style>

<style type="text/css" media="print">
body {background-image:none; background-color:none;  }
#printgrid {height:auto; overflow:visible; font-family:arial; font-size:12px; }
#footer {display:none;}
#logininfo {display:none;}
#navigation {display:none;}
a {display:none;}

</style>
 

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  
<asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="../PatientServices.asmx" />
        </Services>
    </asp:ScriptManager>



            <div class="bxmain inner_content" style="width: 100%;">
            <h2> <span> Patient Between Dates </span></h2>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="40%" align="right" >
        Start date :</td>
    <td width="60%" align="left" >
        <igsch:WebDateChooser ID="WebDateChooser_start_Date" runat="server" Width="202px" CssClass="drop_date">
            <CalendarLayout Culture="English (United Kingdom)">
            </CalendarLayout>
        </igsch:WebDateChooser>
    </td>
  </tr>
  <tr>
    <td align="right"> 
        End Date :</td>
    <td>
      <igsch:WebDateChooser ID="WebDateChooser_End_Date" runat="server" Width="202px" CssClass="drop_date">
            <CalendarLayout Culture="English (United Kingdom)">
            </CalendarLayout>
        </igsch:WebDateChooser>
    </td>
  </tr>
     <tr>
         <td align="right">
         </td>
         <td>
             <asp:Button ID="Button_Search" runat="server" Text="Seach" />
             <asp:HyperLink ID="HyperLink_print" runat="server" NavigateUrl="Print.aspx" Target="_blank" CssClass="report_print"
                  >Print</asp:HyperLink></td>
     </tr>
  
 
</table></div>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">

    
    <div id="printgrid" >
        <div align="center" >
        <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
        
        </div>
        <br />
        
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_For_Grid"
                                    Width="100%" CssClass="Grid_1" >
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
                                                <asp:HiddenField ID="HiddenField_plname" runat="server" 
                                                    Value='<%# Eval("PLName", "{0}") %>' />
                                                <asp:HiddenField ID="HiddenField_r" runat="server" Value='<%# Eval("Relation", "{0}") %>' />
                                                <asp:HiddenField ID="HiddenField_rname" runat="server" Value='<%# Eval("[Relation Name]", "{0}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Registration Date" HeaderText="Registration Date" SortExpression="Registration Date" />
                                        <asp:BoundField DataField="MobilePhone" HeaderText="MobilePhone" SortExpression="MobilePhone" />
                                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                                        <asp:BoundField DataField="Patient Type" HeaderText="Patient Type" SortExpression="Patient Type" />
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader_b" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView></div>
                                <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>"
                                SelectCommand="Search_Patient_For_Print" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenField_Start_Date" Name="startdate" PropertyName="Value"
                                    Type="DateTime" />
                                <asp:ControlParameter ControlID="HiddenField_End_Date" Name="enddate" PropertyName="Value"
                                    Type="DateTime" />
                            </SelectParameters>
                          </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
        <asp:HiddenField ID="HiddenField_End_Date" runat="server" />
<br />
</td>
      
  </tr>
</table>

 



<br />




  </asp:Content>