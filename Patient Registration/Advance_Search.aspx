<%@ page language="VB" autoeventwireup="false" inherits="Patient_Registration_Advance_Search, App_Web_3d5bytc0" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
  <script type="text/javascript">

$(document).ready(function(){
				   
$('#Button_clr').click(function () {
                $('input').val("")
                $('input#ctl00_ContentPlaceHolder1_Button1').val("Search")
				$('input#ctl00_ContentPlaceHolder1_Button_Advance_Search').val("Advance Search")
				$('#Button_clr').val("Clear")
				$('input#ctl00_ContentPlaceHolder1_Button_Print').val("Print")
            });
});
</script>
<script type="text/javascript">

$(document).ready(function(){
						   
						   
  $('a.grid_track').attr('title', 'Track Patient History');
  $('a.grid_edit').attr('title', 'Edit Patient Information');
  $('a.grid_view').attr('title', 'View Patient Detail');
  $('a.grid_add').attr('title', 'Assign Bed to Patient');
 
 
});
</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"> 
    
    
    <div class="bx_rad" style="width:100%;">
    <ul id="tp1">
      <li><strong>&nbsp;Patient Search</strong></li><li>
              <asp:Panel ID="Panel2" runat="server"  Width="100%"></asp:Panel>
            
          <br />
<div align="center"> <asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Search" />  <input class="btn_hacims" name="Clear" value="Clear" type="button" id="Button_clr" /></div> <br /></li></ul>
</div>
</td>
  </tr>
  <tr>
    <td valign="top"><asp:Label CssClass="err"  ID="Label1" runat="server" ></asp:Label><br />
        &nbsp;<asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            CssClass="Grid_1" PageSize="15" Width="100%">
            <RowStyle CssClass="GridItem" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <Columns>
                <asp:ButtonField CommandName="patienttrack">
                    <ControlStyle CssClass="grid_track" />
                </asp:ButtonField>
                <asp:ButtonField CommandName="Editrecord">
                    <ControlStyle CssClass="grid_edit" />
                </asp:ButtonField>
                <asp:ButtonField CommandName="View">
                    <ControlStyle CssClass="grid_view" />
                </asp:ButtonField>
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("[Registration No]", "PatientAppointment_box.aspx?regno={0}") %>'
                            Target="_blank" Text="Appointment"></asp:HyperLink>&nbsp;
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbNewVisit" runat="server" OnClick="lnkbNewVisit_Click">New Visit</asp:LinkButton>
                        &nbsp;
                        <asp:ImageButton ID="ImageButton_FP" runat="server" CausesValidation="False" Height="30px"
                            ImageUrl="~/images_hacims/fpic.png" OnClick="ImageButton_FP_Click" ToolTip="Register Finger Print"
                            Width="36px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="No Of Visits" ShowHeader="False">
                    <ItemTemplate>
                        &nbsp;<asp:HiddenField ID="HiddenField_FP" runat="server" Value='<%# Eval("[FP]") %>' />
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Registration No") %>'
                            CommandName="NoOFVisit" CssClass="openbssox" OnClick="LinkButton1_Click" Text='<%# Eval("[No_Of_Visits]") %>'></asp:LinkButton>
                        <asp:HiddenField ID="HiddenField_RegNo" runat="server" Value='<%# Eval("[Registration No]") %>' />
                        <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
                        <asp:HiddenField ID="HiddenField_Patient_Type_ID" runat="server" Value='<%# Eval("[Patient_Type_ID]") %>' />
                        &nbsp;&nbsp;
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerStyle CssClass="GridPager" />
        </asp:GridView>
        &nbsp;
       <asp:Panel ID="Panel_Visit_Summary" runat="server"  Width="90%"  Visible="false" CssClass="lightbox_bg"  >
     <div class="lightbox">   
   <div style="float:right; text-align:right; heigh:10px;">  
 <asp:ImageButton ID="ImageButton_Close" runat="server" ImageUrl="~/images_hacims/icon_delete.gif" />  
       </div>  <div style="height:350px; display:block; overflow:auto; overflow-x:hidden;">
<asp:DataList ID="DataList_Visit_Summary" runat="server" DataSourceID="SqlDataSource_Visit_Summary" Width="100%" >
<ItemTemplate>
<div class="bx_infos_patients" style="margin-top:15px; display:block-block;">
<ul style="line-height:18px;">
<li>Visit Date Time : <asp:Label ID="visit_Date_TimeLabel" runat="server" Text='<%# Eval("visit_Date_Time") %>'></asp:Label><span class="splt">|</span> 
Patient Type : <asp:Label ID="PatientTypeLabel" runat="server" Text='<%# Eval("PatientType") %>'> </asp:Label><span class="splt">|</span> 
Status : <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("Status") %>'></asp:Label><span class="splt">|</span> 
Daily No. : <asp:Label ID="DailyNoLabel" runat="server" Text='<%# Eval("DailyNo") %>'></asp:Label><span class="splt">|</span> 
<asp:Label ID="Patient_TypeLabel" Visible="false" runat="server" Text='<%# Eval("Patient_Type") %>'> </asp:Label></li> 
<li>Daycase : <asp:Label ID="DaycaseLabel" runat="server" Text='<%# Eval("Daycase") %>'></asp:Label><span class="splt">|</span> 
Discharge Date Time : <asp:Label ID="DischargeDateTimeLabel" runat="server" Text='<%# Eval("DischargeDateTime") %>'> </asp:Label><span class="splt">|</span> 
Visit # : <asp:Label ID="visit_NoLabel" runat="server" Text='<%# Eval("visit_No") %>'></asp:Label><span class="splt">|</span> 
Diagonosis : <asp:Label ID="DiagonosisLabel" runat="server" Text='<%# Eval("Diagonosis") %>'> </asp:Label></li>
<li> 
Doctor : <asp:Label ID="DoctorLabel" runat="server" Text='<%# Eval("Doctor") %>'></asp:Label></li></ul> 
     </div>                     
</ItemTemplate>
</asp:DataList> 
       </div> </div>
        <asp:SqlDataSource ID="SqlDataSource_Visit_Summary" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT     CONVERT(varchar, Payment.DateTime, 105) + ' ' + RIGHT(CONVERT(varchar, Payment.DateTime, 100), 7) AS visit_Date_Time, Payment.PatientType, Payment.Status, &#13;&#10;                      Payment.DailyNo, Payment.Patient_Type, Payment.Daycase, Payment.DischargeDateTime, Payment.PayID AS visit_No, Payment.Diagonosis, &#13;&#10;                      Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Doctor&#13;&#10;FROM         Payment LEFT OUTER JOIN&#13;&#10;                      Employee ON Payment.DoctorID = Employee.EmpID&#13;&#10;WHERE     (Payment.RegNo = @RegNo)">
            <SelectParameters>
                <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>

<asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"> </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT [Diagnosis] FROM [Diagnosis]"></asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_Flag" runat="server" />

<br />
<div align="center"><asp:Button CssClass="btn1" ID="Button_Print" runat="server" Text="Print" /></div></td>
  </tr>
</table>




 


   <script type="text/javascript">

var cookies = Spry.Utils.Cookie("read","tabbedpanels_adsearch");

 if (cookies == "true") { 
var tp1 = new Spry.Widget.CollapsiblePanel("tp1",{ contentIsOpen: true } );
} else { 
var tp1 = new Spry.Widget.CollapsiblePanel("tp1",{ contentIsOpen: false } );
 } 

Spry.Utils.addUnLoadListener(function(){
    
 Spry.Utils.Cookie("create","tabbedpanels_adsearch",tp1.isOpen());
	
});

 
</script>
 
 
  </asp:Content>