<%@ Page Language="VB" AutoEventWireup="false" ValidateRequest ="false" CodeFile="Critical_Care_Flow_sheet.aspx.vb"   MasterPageFile="~/hacims_masterpage_billing.master" Inherits="Critical_Care_Flow_sheet" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

 
 
<script language="javascript" type="text/javascript">
function ShowPanel(Control_ID)
{
   document.getElementById("HiddenFieldTextOther").value=Control_ID;
   document.getElementById('Div_Text').style.visibility = 'visible';
   //document.getElementById('Div_Text').style.left=event.clientX-100;
   document.getElementById('Div_Text').style.top=event.clientY-100;
   document.getElementById("TextBox1").value=document.getElementById(Control_ID).value;
}
function Show_Text_Value()
{
    var id =document.getElementById("HiddenFieldTextOther").value;
    var text=document.getElementById("TextBox1").value;
    if (id!="")
    {
        document.getElementById(id).value=text;
    }
    document.getElementById("HiddenFieldTextOther").value="";
}

</script>

 <script src="../css_hacims/SpryAssets/SpryTabbedPanelsb.js" type="text/javascript"></script>
 <link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
 <script src="../css_hacims/ck.js" type="text/javascript"></script>
   
 <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
 

<style type="text/css">

.Grid_dynamic table td {border:0;}

.datest {font-weight:bold; padding-left:5px; padding-right:5px; font-size:13px; }
</style>
 <script src="../Scripts/swfobject_modified.js" type="text/javascript" ></script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel2" runat="server"  Visible="false"></asp:Panel> 
    

</td>
<td  style="width:auto;" valign="top" >
     <div style="margin-left:10px;">
<%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
--%>
<asp:Label ID="Label_message" runat="server" ></asp:Label>
 
 
        <igsch:webdatechooser id="WebDateChooser1" runat="server" visible="False"></igsch:webdatechooser>
        
        
         
         
        
        
     <div id="TabbedPanels1" class="TabbedPanels">
          
        <ul class="TabbedPanelsTabGroup" style="margin-left:10px;">
          
        <li class="TabbedPanelsTab" tabindex="0"  ><asp:LinkButton ID="LinkButton_CC_FlowSheet" runat="server">CC FlowSheet</asp:LinkButton></li><li class="TabbedPanelsTab" tabindex="0"  > <asp:LinkButton ID="LinkButton_Shift_Schedule" runat="server">Shift Schedule</asp:LinkButton></li><li class="TabbedPanelsTab" tabindex="0"  ><asp:LinkButton ID="LinkButton_Routine_Care" runat="server">Routine Care</asp:LinkButton></li><li class="TabbedPanelsTab" tabindex="0"  ><asp:LinkButton ID="LinkButton_ChartInOut" runat="server">Chart Intake Output</asp:LinkButton></li><li class="TabbedPanelsTab" tabindex="0"  ><asp:LinkButton ID="LinkButton_Chartvitals" runat="server">Chart Vitals</asp:LinkButton></li></ul>
      
        
       
        <div class="TabbedPanelsContentGroup" style="height:auto;">
        
        <div class="TabbedPanelsContent">       
        
        <asp:Panel ID="Panel1" runat="server" Width="100%"></asp:Panel>
        <br />
        <div align="center"> <asp:Button ID="Button_Save" runat="server" Text="Save"/></div>
        <br />
        
        
          <div align="center">  <asp:ImageButton ID="ImageButton_Previous_1" runat="server" ImageUrl="~/images_hacims/1leftarrow.png" /><asp:Label
                ID="Label_Date_1" runat="server" CssClass="datest"></asp:Label><asp:ImageButton ID="ImageButton_Forward_1"
                    runat="server" ImageUrl="~/images_hacims/1rightarrow.png" /></div><br />
                    
       <asp:Panel ID="Panel_CC_FlowSheet" runat="server" Width="100%">
<br />
    <div style="width:100%; overflow:auto; overflow-y:hidden;">
    <asp:GridView ID="GridView_CC_FlowSheet" runat="server" CssClass="Grid_1" Width="100%">
    <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    </div>
    </asp:Panel>
    </div>                         
   
   <div class="TabbedPanelsContent"> <asp:Panel ID="Panel1b" runat="server" Width="100%"></asp:Panel>
        
        <br />
        <div align="center"> <asp:Button ID="Button_Save2" runat="server" Text="Save"/></div>
        
        <br />
        
     <div align="center">   
     
     <asp:ImageButton ID="ImageButton_Previous_2" runat="server" ImageUrl="~/images_hacims/1leftarrow.png" />
     <asp:Label ID="Label_Date_2" runat="server" CssClass="datest"></asp:Label>
     <asp:ImageButton ID="ImageButton_Forward_2" runat="server" ImageUrl="~/images_hacims/1rightarrow.png" />
                    
                    
                    </div><br />
     <asp:Panel ID="Panel_Shift_Schedule"  runat="server" Width="100%">
               <div style="width:100%; overflow:auto; overflow-y:hidden;">
    <asp:GridView ID="GridView_Shift_Schedule" runat="server" CssClass="Grid_1" Width="100%">
    <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    </div>
    </asp:Panel>
        
        </div>        
        <div class="TabbedPanelsContent"> <asp:Panel ID="Panel1c" runat="server" Width="100%"></asp:Panel>
        
        
        <br />
        <div align="center"> <asp:Button ID="Button_Save3" runat="server" Text="Save"/></div>
        <br />
        <div align="center">
        <asp:ImageButton ID="ImageButton_Previous_3" runat="server" ImageUrl="~/images_hacims/1leftarrow.png" />
        
        <asp:Label ID="Label_Date_3" runat="server" CssClass="datest"></asp:Label><asp:ImageButton ID="ImageButton_Forward_3" runat="server" ImageUrl="~/images_hacims/1rightarrow.png" />
         </div><br />           
        <asp:Panel ID="Panel_Routine_Care" runat="server" Width="100%">
     <div style="width:100%; overflow:auto; overflow-y:hidden;">
    <asp:GridView ID="GridView_Routine_Care" runat="server" CssClass="Grid_1" Width="100%">
    <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
    
    </asp:GridView>
    </div>
    </asp:Panel>
        
        
        </div>        
       
     <div class="TabbedPanelsContent">
      <div align="center">  <asp:ImageButton ID="ImageButton_Previous_4" runat="server" ImageUrl="~/images_hacims/1leftarrow.png" />
     <asp:Label ID="Label_Date_4" runat="server" CssClass="datest"></asp:Label>
     <asp:ImageButton ID="ImageButton_Forward_4" runat="server" ImageUrl="~/images_hacims/1rightarrow.png" /></div><br />
     <div style="width:1050px; overflow:auto; overflow-y:hidden;">
     
   <object id="FlashID" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="1100" height="699"><param name="movie" value="../chart_intakeoutput.swf" /><param name="quality" value="high" /><param name="wmode" value="opaque" /><param name="swfversion" value="9.0.45.0" /><!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don’t want users to see the prompt. -->
  <param name="expressinstall" value="Scripts/expressInstall.swf" />
  <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
  <!--[if !IE]>-->
  <object type="application/x-shockwave-flash" data="../chart_intakeoutput.swf" width="1100" height="699">
    <!--<![endif]-->
    <param name="quality" value="high" />
    <param name="wmode" value="opaque" />
    <param name="swfversion" value="9.0.45.0" />
    <param name="expressinstall" value="../Scripts/expressInstall.swf" />
    <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
    <div>
      <h4>Content on this page requires a newer version of Adobe Flash Player.</h4>
      <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" width="112" height="33" /></a></p>
    </div>
    <!--[if !IE]>-->
  </object>
  <!--<![endif]-->
</object>
<script type="text/javascript">
<!--
swfobject.registerObject("FlashID");
//-->
</script>
    </div> 
     
     
     
     </div>  
        
        
        
        
        
        
        
        
    <div class="TabbedPanelsContent">
      <div align="center">  <asp:ImageButton ID="ImageButton_Previous_5" runat="server" ImageUrl="~/images_hacims/1leftarrow.png" />
     <asp:Label ID="Label_Date_5" runat="server" CssClass="datest"></asp:Label>
     <asp:ImageButton ID="ImageButton_Forward_5" runat="server" ImageUrl="~/images_hacims/1rightarrow.png" /></div><br />
     <div style="width:1050px; overflow:auto; overflow-y:hidden;">
     
   <object id="FlashID2" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="2050" height="699"><param name="movie" value="../chart_vitals.swf" /><param name="quality" value="high" /><param name="wmode" value="opaque" /><param name="swfversion" value="9.0.45.0" /><!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don’t want users to see the prompt. -->
  <param name="expressinstall" value="Scripts/expressInstall.swf" />
  <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
  <!--[if !IE]>-->
  <object type="application/x-shockwave-flash" data="../chart_vitals.swf" width="2050" height="699">
    <!--<![endif]-->
    <param name="quality" value="high" />
    <param name="wmode" value="opaque" />
    <param name="swfversion" value="9.0.45.0" />
    <param name="expressinstall" value="../Scripts/expressInstall.swf" />
    <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
    <div>
      <h4>Content on this page requires a newer version of Adobe Flash Player.</h4>
      <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" width="112" height="33" /></a></p>
    </div>
    <!--[if !IE]>-->
  </object>
  <!--<![endif]-->
</object>
<script type="text/javascript">
<!--
swfobject.registerObject("FlashID2");
//-->
</script>
    </div> 
     
     
     
     </div>      
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
       </div></div> 
        
        
        
 
   <asp:Label ID="Label_Select_All" runat="server" Visible="false"></asp:Label>
 
                    <asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
            SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                          <SelectParameters>
                            <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                            <asp:SessionParameter Name="deptid" SessionField="dept_id" />
                            </SelectParameters>
                          </asp:SqlDataSource>        
 
     <asp:SqlDataSource ID="SqlDataSource_select_all" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
            InsertCommand="Insert_Patient_Complaint_out_Nurse" InsertCommandType="StoredProcedure"
            ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="SELECT ISNULL(OPD_Encounter_Form_Remarks_Nurse.Remarks, '') AS Remarks, Admin_Exam_Main_Heading.MH_Heading, Admin_Exam_Main_Heading.MH_Code FROM OPD_Encounter_Form_Remarks_Nurse INNER JOIN Admin_Exam_Main_Heading ON OPD_Encounter_Form_Remarks_Nurse.MH_Code = Admin_Exam_Main_Heading.MH_Code WHERE (OPD_Encounter_Form_Remarks_Nurse.Yearly_No = @YearlyNo) AND (OPD_Encounter_Form_Remarks_Nurse.Type_val = 'PHY')">
            <SelectParameters>
                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            </SelectParameters>
            <InsertParameters>
                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                <asp:ControlParameter ControlID="HiddenFieldComplaint_ID" Name="Complaint_ID" PropertyName="Value" />
                <asp:SessionParameter Name="empid" SessionField="emp_id" />
                <asp:ControlParameter ControlID="TextBox_Remarks" Name="Description" PropertyName="Text"
                    Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_OPD_Encounter_Form_Remarks" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
            DeleteCommand="DELETE FROM [OPD_Encounter_Form_Remarks_Nurse] WHERE [Reg_No] = @Reg_No AND [Yearly_No] = @Yearly_No AND [MH_Code] = @MH_Code"
            InsertCommand="OPD_Encounter_Form_Remarks_Insert_Nurse" InsertCommandType="StoredProcedure"
            ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="SELECT  [Remarks] FROM [OPD_Encounter_Form_Remarks_Nurse] where [Reg_No]=@Reg_No and  [Yearly_No]=@Yearly_No and [MH_Code]=@MH_Code and Type_Val='PHY'"
            UpdateCommand="UPDATE [OPD_Encounter_Form_Remarks_Nurse] SET [Remarks] = @Remarks WHERE [Reg_No] = @Reg_No AND [Yearly_No] = @Yearly_No AND [MH_Code] = @MH_Code">
            <SelectParameters>
                <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" />
                <asp:ControlParameter ControlID="HiddenField3" Name="MH_Code" PropertyName="Value" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="Reg_No" Type="String" />
                <asp:Parameter Name="Yearly_No" Type="String" />
                <asp:Parameter Name="MH_Code" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Remarks" Type="String" />
                <asp:Parameter Name="Reg_No" Type="String" />
                <asp:Parameter Name="Yearly_No" Type="String" />
                <asp:Parameter Name="MH_Code" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" Type="String" />
                <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" Type="String" />
                <asp:ControlParameter ControlID="HiddenField3" Name="MH_Code" PropertyName="Value"
                    Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_Remarks" Name="Remarks" PropertyName="Text"
                    Type="String" />
                <asp:Parameter DefaultValue="PHY" Name="type" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <br />
         
        <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
            SelectCommand="SELECT DISTINCT Admin_Exam_Main_Heading.MH_Heading, Admin_Exam_Main_Heading.Priority, Admin_Exam_Main_Heading.MH_Code FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code WHERE (Admin_Exam_MainHeading_Group.Mg_Code IN (SELECT MainGroup_Id FROM Admin_Template_phy_Elements WHERE (Template_Id = @Template_Id))) AND (Admin_Exam_Main_Heading.Dept_id = @detp_id) ORDER BY Admin_Exam_Main_Heading.Priority" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
              <SelectParameters>
                  <asp:ControlParameter ControlID="HiddenFieldTemplate_id" Name="Template_Id" PropertyName="Value" />
                  <asp:SessionParameter Name="detp_id" SessionField="dept_id" />
                </SelectParameters>
              </asp:SqlDataSource>  
 
    <asp:SqlDataSource ID="SqlDataSourceSaveValue" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
        ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>"
        SelectCommand="SELECT     Pt_physical_exam_saveRecord_Nurse.Exam_Result, admin_Phy_Exam_Elements.e_Name, Pt_physical_exam_saveRecord_Nurse.Time&#13;&#10;FROM         Pt_physical_exam_saveRecord_Nurse INNER JOIN&#13;&#10;                      Admin_Exam_MainHeading_Group ON Pt_physical_exam_saveRecord_Nurse.body_system_Id = Admin_Exam_MainHeading_Group.Mg_Code INNER JOIN&#13;&#10;                      admin_Phy_Exam_Elements ON Pt_physical_exam_saveRecord_Nurse.E_ID = admin_Phy_Exam_Elements.e_Code&#13;&#10;WHERE     (Pt_physical_exam_saveRecord_Nurse.YearlyNo = @YearlyNo) AND (Pt_physical_exam_saveRecord_Nurse.RegNo = @RegNo) AND &#13;&#10;                      (Pt_physical_exam_saveRecord_Nurse.Ele_Status = 0) AND (Admin_Exam_MainHeading_Group.MH_Code = @MH_Code)&#13;&#10;ORDER BY admin_Phy_Exam_Elements.e_Name, Pt_physical_exam_saveRecord_Nurse.Time DESC">
        <SelectParameters>
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
            <asp:Parameter Name="MH_Code" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                            <asp:HiddenField ID="HiddenField3" runat="server" Value="0" />
                              <asp:HiddenField ID="HiddenFieldTemplate_id" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldTextOther" runat="server" /><asp:HiddenField ID="HiddenField_SelectedDate" runat="server" />
                          
 
<asp:Button ID="Button1" runat="server" CssClass="btn_close" Text="" Visible="false" /> 
<asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt" Height="88px" TextMode="MultiLine"  Width="100%" Visible="false"></asp:TextBox> 

 

<asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>
</div>
    </td>
</tr>
</table> 
  
<script type="text/javascript">
var cookies = Spry.Utils.Cookie("read","tabbedpanels_sheet");
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
Spry.Utils.addUnLoadListener(function(){
    // save the current value
    Spry.Utils.Cookie('create','tabbedpanels_sheet',TabbedPanels1.getCurrentTabIndex());
});
</script>
  
    </asp:Content> 
    
 