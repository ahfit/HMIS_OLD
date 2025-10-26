<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Anesthesia_main_page.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Anesthesia_main_page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
 <style type="text/css" >

.cr_reading {   border-bottom:#CCC dotted 1px; width:100%; padding-bottom:2px; padding-top:4px; }
.cr_reading ul { width:100%;     }
.cr_reading li {   display:block; height:auto; line-height:17px; background:url(images_hacims/img_bullet-2.png) 0 6px no-repeat; padding-left:10px; width:100%; }
.bno{ color:#C00; border-left:#bfbfbf solid 1px; margin-left:5px; padding-left:5px;}
.bnb{ color:#333; border-left:#bfbfbf solid 1px; margin-left:5px; padding-left:5px; }
.bnc{ color:#0e5b87; margin-left:2px; padding-left:2px; }
.cr_reading .detail { color:#999; background:none; padding-left:0; }

.bx_infos_patients {width:94%;}

.rd_tests {}
.rd_tests ul {}
.rd_tests li {display:block;  line-height:17px; background:url(images_hacims/img_bullet-2.png) 0 6px no-repeat; height:auto; width:100%; margin-left:0px; margin-top:3px; border:#d6d6d6 solid 1px; background:#fff;  -moz-border-radius: 4px; }
.tcount {color:#015aae; padding-left:4px; }
</style>
<script src="SpryAssets/mycollaps.js" type="text/javascript"></script>
 <link href="SpryAssets/mycollaps.css"  rel="stylesheet"   type="text/css" media="screen, projection" />
 
  <script language="javascript" type="text/javascript">
		$(document).ready(function(){
			 
			$(".tab_b").colorbox({width:"85%", height:"90%",inline:true, href:"#cr_readings" });
			$(".tab_b").colorbox({width:"85%", height:"90%",inline:true, href:"#op_list" });
			$(".tab_b").colorbox({width:"85%", height:"90%",inline:true, href:"#doc_info" });
			$(".tab_b").colorbox({width:"85%", height:"90%",inline:true, href:"#pathology" });
			$(".tab_b").colorbox({width:"85%", height:"90%",inline:true, href:"#radiology" });
			 
		});
		
		 
		
	</script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="40%"><div id="doc_patients" class="bx_infos_patients">
<h2><span>Patients </span></h2>

<asp:Label ID="Label1" runat="server" Text="Label" style="display:none;"></asp:Label>
<ul class="links_bx" style="margin-top:10px;"> 
<asp:DataList
    ID="DataListSubDepartment" runat="server" DataKeyField="SubDept_Id" DataSourceID="SqlDataSourceSubDepartment"
    RepeatColumns="2" Width="100%" >
    <ItemTemplate>
      
                 <li style="margin-top:7px;">  <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" 
                        Text='<%# Eval("SubDept_Name") %>'></asp:LinkButton> 
                 <span class="tcount">( <asp:Label ID="Label4" runat="server" ToolTip="Total Patients" Text='<%# Eval("Ct") %>'></asp:Label> )</span></li>
         
               
    </ItemTemplate>
</asp:DataList>
</ul>
  
  <table cellpadding="0" cellspacing="0" border="0" class="tbl_form"><tr ><td width="50%" valign="top" align="left">

<ul class="links_bx" >
<li style="margin-top:4px; display:none;"><asp:LinkButton ID="Link_inpatinet" runat="server">InPatient</asp:LinkButton><span class="tcount">(10)</span></li><li style="margin-top:4px;  display:none;"><asp:LinkButton ID="Link_outpatient" runat="server">OutPatient</asp:LinkButton><span class="tcount">(12)</span></li><li style="margin-top:4px;  display:none;"><asp:LinkButton ID="LinkButton_Private_Patient" runat="server">Private Patient</asp:LinkButton><span class="tcount">(15)</span></li><li style="margin-top:4px;"><asp:LinkButton ID="lnkAppointment" runat ="server" >Appointments</asp:LinkButton><span class="tcount"></span></li><br /></ul>

</td><td width="50%" valign="top" align="left">
<ul class="links_bx" style="display:none;">

<li style="margin-top:4px;"><asp:LinkButton ID="Link_calls" runat="server">Calls</asp:LinkButton><span class="tcount">(09)</span></li><li style="margin-top:4px;"><asp:LinkButton ID="Link_correspondance" runat="server">Correspondance</asp:LinkButton><span class="tcount">(01)</span></li><li style="margin-top:4px;"><asp:LinkButton ID="Link_tasks" runat="server">Tasks</asp:LinkButton><span class="tcount">(15)</span></li></ul>


</td></tr></table>
  
  
  
     


    <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>"
        SelectCommand="Select_Patient_For_MainPage_Summery_OT" 
            SelectCommandType="StoredProcedure">
        <SelectParameters>
            <%--<asp:ControlParameter ControlID="DropDownListDept" Name="Dept_Id" PropertyName="SelectedValue"
                Type="Int32" />--%>
           <%-- <asp:SessionParameter Name="DoctorID" SessionField="Emp_id" />--%>
             <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
        </SelectParameters>
    </asp:SqlDataSource>


 

<div class="bx_rad">

<ul id="CollapsiblePanel1">
<li><strong>&nbsp;Search</strong></li><li><table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" >
  <tr>
    <td  width="35%"align="right" >
        Reg No.: </td>
    <td width="65%">
        <asp:TextBox ID="TextBoxRegNo" runat="server" CssClass="input_txt" Width="130px"></asp:TextBox></td>
  </tr>
      <tr>
          <td align="right" >
              Visit No.: </td>
          <td width="77%">
              <asp:TextBox ID="TextBoxYearlyNo" runat="server" CssClass="input_txt" Width="130px"></asp:TextBox></td>
      </tr>
      <tr>
          <td align="right" >
        Name : </td>
          <td width="77%">
              <asp:TextBox ID="TextBoxPFName" runat="server" CssClass="input_txt" Width="130px"></asp:TextBox></td>
      </tr>
      <tr>
          <td align="right" style="height: 18px" >
              Department : </td>
          <td width="77%" style="height: 18px">
              <asp:DropDownList ID="DropDownListDept" runat="server" CssClass="dropbox" 
                  Width="132px" DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name" 
                  DataValueField="Dept_ID" AutoPostBack="True" Enabled="False">
              </asp:DropDownList></td>
      </tr>
  <tr>
    <td align="right" >&nbsp;</td>
    <td>
        <asp:Button ID="Button1" runat="server" CssClass="btn1" Text="Serach" /></td>
  </tr>
</table></li> 

</ul>

</div>


      <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
          ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="Select_Dept" SelectCommandType="StoredProcedure">
          <SelectParameters>
              <asp:SessionParameter Name="hospital_ID" SessionField="HospitalID" 
                  Type="Int32" />
          </SelectParameters>
      </asp:SqlDataSource>


<br /> 


<div style="width:100%; height:315px; overflow:auto; overflow-x:hidden; margin-bottom:10px; ">

<asp:DataList ID="DataList1" runat="server" Width="100%">
<ItemTemplate>
       
<div class="p_box">  
               <table cellpadding="0" cellspacing="0" width="100%" class="tbl_pinfo" >
                    <tr>
                        <td  style="height: 16px" ><asp:LinkButton ID="LinkButtonName" runat="server" CommandName="Select"  ></asp:LinkButton></td>
                        <td  align="right" style="height: 16px" ><asp:Label ID="DiagonosisLabel" runat="server" style="color:red; font-weight:bold; font-size:10px;"   Text='<%# Eval("Diagonosis") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td ><asp:Label ID="LabelRegNo" runat="server" style="color:#6b6b6b; font-size:9px;" Text='<%# Eval("RegNo") %>'></asp:Label><span class="spltr">&nbsp;|&nbsp;</span><asp:Label ID="Label2" runat="server" style="color:#151313; font-size:9px;" Text='<%# Eval("BedNo") %>'></asp:Label></td>
                        <td align="right" >                        <asp:Label style="color:#333; font-size:10px;" ID="AgeLabel" runat="server" Text='<%# Eval("Age") %>'></asp:Label>
<asp:Label ID="AgeTypeLabel" style="color:#6b6b6b; font-size:10px;" runat="server" Text='<%# Eval("AgeType") %>'></asp:Label>
<span class="spltr">&nbsp;|&nbsp;</span><asp:Label ID="LabelGender" style="color:#d71635; font-size:10px;" runat="server" Text='<%# Eval("Gender") %>'></asp:Label></td>
                    </tr>
                    <tr >
                      <td colspan="2"  ><asp:Label ID="PFNameLabel" CssClass="deslist" runat="server" Text='<%# Eval("PFName") %>' Visible="False"></asp:Label>
                            <asp:Label ID="PrefixLabel" CssClass="deslist" runat="server" Text='<%# Eval("Prefix") %>' Visible="False"></asp:Label>
                            <asp:Label ID="PMNameLabel" CssClass="deslist" runat="server" Text='<%# Eval("PMName") %>' Visible="False"></asp:Label>
                            <asp:Label ID="PLNameLabel" CssClass="deslist" runat="server" Text='<%# Eval("PLName") %>' Visible="False"></asp:Label>
                            <asp:Label ID="LabelPayID" CssClass="deslist" runat="server" Text='<%# Eval("PayID") %>' Visible="False"></asp:Label>                       
                          <asp:HiddenField ID="HiddenField_reg_no" runat="server" Value='<%# Eval("RegNo") %>' />
                          <asp:HiddenField ID="HiddenField_pay_ID" runat="server" Value='<%# Eval("PayID") %>' />
                          </td>
                    </tr>
                </table>
</div>

            </ItemTemplate>
        </asp:DataList>
    
   <asp:Panel ID="Panel_App" runat="server">
            <asp:ScriptManager id="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td valign="top">
                        &nbsp;</td>
                </tr>
            </table>
            <br />
  
      
          

            
        </asp:Panel>
 
    
    
        
<div>
    </div>

  
    <asp:Label ID="Label3" runat="server"></asp:Label></div>
  <asp:Label ID="GenderLabel" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>

  
</div>
        
</td>
    <td valign="top"  >
      
        
         
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100%" valign="top">
    
     <%--<table width="100%" border="0" cellspacing="0" cellpadding="0">
    
    <tr>
    
    
    <td width="50%" valign="top">
    
     <div id="cr_readings"  class="bx_infos_patients tab_bx"  >
<h2><span >Critical Readings</span></h2>
<div class="bxinfo_margin" style="height:auto;">
 
  <asp:DataList ID="DataList_CriticalReading" runat="server" Width="100%">
            <ItemTemplate>
            
<div class="bx_crreadings">
            <ul   >
            <li>
                <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Select" 
                    Text='<%# Eval("Prefix") %>'></asp:LinkButton>
                (<span class="ward" ><asp:Label ID="Label_Bed_Diagnosis" runat="server" Text='<%# Eval("Bed_Diagnosis") %>'></asp:Label></span>)</li>
            <li class="detail"><asp:Label ID="Label_Time" runat="server" Text='<%# Eval("Time") %>'></asp:Label>
                <asp:HiddenField ID="hfRegNo" runat="server" Value='<%# Eval("RegNo") %>' />
                </li>
                <li class="detail">
                    <asp:HiddenField ID="hfYearlyNo" runat="server" 
                        Value='<%# Eval("YearlyNo") %>' />
                </li>
            </ul>
            
            </div>
            </ItemTemplate>
        </asp:DataList> 
  
</div>
</div> <!--End Critical Readings--> 
  <br />
   <div  class="bx_infos_patients"  >
<h2 ><span ><a href="#" style="text-decoration:none;">Pathology</a></span></h2>
<div class="bxinfo_margin" style="height:auto;">



     <asp:DataList ID="DataList_Pathology" runat="server" DataSourceID="SqlDataSource_Pathology_Test" Width="100%">
         <ItemTemplate>
             <asp:HiddenField ID="HiddenField_PFName" runat="server" Value='<%# Eval("PFName") %>' />
             <asp:HiddenField ID="HiddenField_PMName" runat="server" Value='<%# Eval("PMName") %>' />
             <asp:HiddenField ID="HiddenField_PLName" runat="server" Value='<%# Eval("PLName") %>' />
             <asp:HiddenField ID="HiddenField_DeptID" runat="server" Value='<%# Eval("DeptId") %>' />
             <asp:HiddenField ID="hfPrefix" runat="server" />
             <asp:HiddenField ID="HiddenField_RegNo" runat="server" Value='<%# Eval("RegNo") %>' />
          
          <div class="bx_pathology">
           
           <ul >
            <li>
            <span class="name"><asp:Label ID="PrefixLabel" runat="server" ToolTip="Patient & Relation Name" Text='<%# Eval("Prefix") %>'></asp:Label></span> 
             ( <span class="ward"><asp:Label ID="AgeLabel" runat="server" ToolTip="Age" Text='<%# Eval("Age") %>'></asp:Label> Year </span> ) (<span class="ward">  <asp:Label ID="Ward_NameLabel" runat="server" ToolTip="Ward Name" Text='<%# Eval("Ward_Name") %>'></asp:Label> /  <asp:Label ID="Bed_NoLabel" runat="server" ToolTip="Bed Number" Text='<%# Eval("Bed_No") %>'></asp:Label> </span>)</li><li style="font-size:10px; color:#6a6666;"><asp:Label ID="RegNoLabel" runat="server" ToolTip="Registration Number" Text='<%# Eval("RegNo") %>'></asp:Label> ( <asp:Label ID="YearlyNoLabel" style="color:#000;" runat="server" Text='<%# Eval("YearlyNo") %>'></asp:Label> )  
             <asp:Label ID="TestDateLabel" ToolTip="Test Date" CssClass="date" runat="server" Text='<%# Eval("TestDate") %>'></asp:Label> </li>
              
           
             
            
            <li> <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource_PathTestDetail">
                 <ItemTemplate>
                     <strong><asp:LinkButton ID="LinkButton2"  runat="server" ToolTip="Test Group" Text='<%# Eval("TGName") %>'></asp:LinkButton><asp:Label ID="TGNameLabel" runat="server" Visible="false" ToolTip="Test Group" Text='<%# Eval("TGName") %>'></asp:Label></strong> 
                     { <span class="bnc"><asp:Label ID="TBNameLabel" ToolTip="Test Sub Group" runat="server" Text='<%# Eval("TBName") %>'></asp:Label></span> }
                    
                     
                    
                 </ItemTemplate>
             </asp:DataList></li></ul>
             
             </div>
             <asp:SqlDataSource ID="SqlDataSource_PathTestDetail" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                 ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                 SelectCommand="SELECT DISTINCT TestGroup.TGName,dbo.[Pathology_TB_Name](Investigation_Order_Main.DeptId,Investigation_Order_Main.YearlyNo,Investigation_Order_Main.RegNo,TestGroup.TGID) as TBName&#13;&#10;FROM         Test_Booking INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN&#13;&#10;                      Investigation_Order_Sub INNER JOIN&#13;&#10;                      Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID ON &#13;&#10;                      Test_Booking.TB_ID = Investigation_Order_Sub.TB_ID&#13;&#10;WHERE     (Investigation_Order_Main.YearlyNo = @YearlyNo) AND (Investigation_Order_Main.RegNo = @RegNo) AND &#13;&#10;                      (Investigation_Order_Main.DeptId = @DeptId) AND (CONVERT(varchar,Investigation_Order_Main.Date_Time, 103) = @Date)&#13;&#10;">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="YearlyNoLabel" Name="YearlyNo" PropertyName="Text" />
                     <asp:ControlParameter ControlID="HiddenField_RegNo" Name="RegNo" PropertyName="Value" />
                     <asp:ControlParameter ControlID="HiddenField_DeptID" Name="DeptId" PropertyName="Value" />
                     <asp:ControlParameter ControlID="TestDateLabel" Name="Date" PropertyName="Text" />
                 </SelectParameters>
             </asp:SqlDataSource>
             
         </ItemTemplate>
     </asp:DataList><asp:SqlDataSource ID="SqlDataSource_Pathology_Test" runat="server"
         ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
         
         
         SelectCommand="SELECT DISTINCT 
                      CONVERT(varchar, Investigation_Order_Main.Date_Time, 103) AS TestDate, Investigation_Order_Main.YearlyNo, Investigation_Order_Main.RegNo, 
                      Investigation_Order_Main.DeptId, admin_Hospital_Wards.Ward_Name, Ward_Beds.Bed_No, Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName, 
                      Patient.Age
FROM         Investigation_Order_Main INNER JOIN
                      Pt_Assign_Bed ON Investigation_Order_Main.YearlyNo = Pt_Assign_Bed.Yearly_No AND Investigation_Order_Main.RegNo = Pt_Assign_Bed.Reg_No INNER JOIN
                      Ward_Beds ON Pt_Assign_Bed.Bed_id = Ward_Beds.Bed_id AND Pt_Assign_Bed.Ward_id = Ward_Beds.ward_Id INNER JOIN
                      admin_Hospital_Wards ON Pt_Assign_Bed.Ward_id = admin_Hospital_Wards.Ward_id INNER JOIN
                      Patient ON Investigation_Order_Main.RegNo = Patient.RegNo
WHERE     (Investigation_Order_Main.DeptId = @Dept_Id) AND (CONVERT(varchar, Investigation_Order_Main.Date_Time, 103) = convert(varchar,getdate(),103))and Investigation_Order_Main.Emp_ID=@Emp_Id">
         <SelectParameters>
             <asp:SessionParameter Name="Dept_Id" SessionField="Dept_Id" />
             <asp:SessionParameter Name="Emp_Id" SessionField="Emp_Id" />
         </SelectParameters>
     </asp:SqlDataSource>
     
     </div></div><!--Pathology Test-->
  <br />
   <div  class="bx_infos_patients"  >
<h2><span >Radiology Test</span></h2>
<div class="bxinfo_margin" style="height:auto;">
 
  
  
  
   
        
        <asp:DataList ID="DataList_RadiologyTest" runat="server" DataSourceID="SqlDataSource_RadiologyTest" Width="100%">
            <ItemTemplate>
                <asp:HiddenField ID="HiddenField_Reg_No" runat="server" Value='<%# Eval("Reg_No") %>' />
                <asp:HiddenField ID="HiddenField_PFName" runat="server" Value='<%# Eval("PFName") %>' />
                <asp:HiddenField ID="HiddenField_PMName" runat="server" Value='<%# Eval("PMName") %>' />
                <asp:HiddenField ID="HiddenField_DeptID" runat="server" Value='<%# Eval("DeptId") %>' />
                <asp:HiddenField ID="HiddenField_PLName" runat="server" Value='<%# Eval("PLName") %>' />
                <asp:HiddenField ID="hfPrefix" runat ="server" Value ='<%# Eval("Prefix") %>' />
             <div class="bx_rad">
              <ul id="CollapsiblePanel2">
              <li  > <span class="name"><asp:Label ID="PrefixLabel" runat="server" Text='<%# Eval("Prefix") %>'></asp:Label></span> ( <span class="ward"><asp:Label ID="AgeLabel" runat="server" Text='<%# Eval("Age") %>'></asp:Label> Year </span>) ( <span class="ward"> <asp:Label ID="patientWardbedLabel" runat="server" ToolTip="Ward & Bed Number" Text='<%# Eval("patientWardbed") %>'></asp:Label></span> )</li><li >
                  <asp:Label ID="Reg_NoLabel" style="font-size:10px; color:#6a6666;" runat="server" Text='<%# Eval("Reg_No") %>'></asp:Label> ( <asp:Label ID="Yearly_NoLabel" style="color
                  #000;" runat="server" Text='<%# Eval("Yearly_No") %>'></asp:Label> )
                
                 <asp:Label ID="DateTimeLabel" runat="server" style="font-size:10px; color:#6a6666;" CssClass="date" Text='<%# Eval("DateTime") %>'></asp:Label>  
                
                                
              
                <asp:DataList ID="DataList_TestDetail" runat="server" DataSourceID="SqlDataSource_TestDetail" Width="100%">
                    <ItemTemplate>
                         <strong><asp:Label ID="TGNameLabel" runat="server" Text='<%# Eval("TGName") %>'></asp:Label> </strong>{ <span class="bnc"><asp:Label ID="tbnameLabel" runat="server" Text='<%# Eval("tbname") %>'></asp:Label> </span>} 
                        
                    </ItemTemplate>
                </asp:DataList></li></ul>
               </div>
                 <asp:SqlDataSource ID="SqlDataSource_TestDetail" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="&#13;&#10;SELECT DISTINCT Radiology.dbo.TestGroup.TGName, dbo.Radiology_TB_Name(Radiology_Order_Main.DeptId, Radiology_Order_Main.YearlyNo, Radiology_Order_Main.RegNo, &#13;&#10;                      Radiology.dbo.TestGroup.TGID) AS tbname&#13;&#10;FROM         Radiology_Order_Sub INNER JOIN&#13;&#10;                      Radiology_Order_Main ON Radiology_Order_Sub.Order_ID = Radiology_Order_Main.Order_ID INNER JOIN&#13;&#10;                      Radiology.dbo.Test_Booking ON Radiology_Order_Sub.TB_ID = Radiology.dbo.Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Radiology.dbo.TestGroup ON Radiology.dbo.Test_Booking.MG_ID = Radiology.dbo.TestGroup.TGID&#13;&#10;WHERE     (Radiology_Order_Main.DeptId = @DeptId) AND (Radiology_Order_Main.YearlyNo = @YearlyNo) AND &#13;&#10;                      (Radiology_Order_Main.RegNo =@RegNo) AND (CONVERT(varchar, Radiology_Order_Main.Date_Time, 103) &#13;&#10;                      = @Date)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_DeptID" Name="DeptId" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_Reg_No" Name="RegNo" PropertyName="Value" />
                        <asp:ControlParameter ControlID="DateTimeLabel" Name="Date" PropertyName="Text" />
                        <asp:ControlParameter ControlID="Yearly_NoLabel" Name="YearlyNo" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
               
            </ItemTemplate>
        </asp:DataList> 
        
        <asp:SqlDataSource ID="SqlDataSource_RadiologyTest" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
            
            SelectCommand="SELECT DISTINCT Radiology_Order_Main.YearlyNo AS Yearly_No, CONVERT (varchar, Radiology_Order_Main.Date_Time, 103) AS DateTime, Radiology_Order_Main.RegNo AS Reg_No, Radiology_Order_Main.DeptId, ISNULL(admin_Hospital_Wards.Ward_Name, '') + ' ( ' + ISNULL(Ward_Beds.Bed_No, '') + ' ) ' AS patientWardbed, Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName, Patient.Age FROM Patient INNER JOIN Radiology_Order_Main ON Patient.RegNo = Radiology_Order_Main.RegNo LEFT OUTER JOIN Ward_Beds INNER JOIN Pt_Assign_Bed ON Ward_Beds.Bed_id = Pt_Assign_Bed.Bed_id AND Ward_Beds.ward_Id = Pt_Assign_Bed.Ward_id INNER JOIN admin_Hospital_Wards ON Ward_Beds.ward_Id = admin_Hospital_Wards.Ward_id INNER JOIN SubDepartment ON admin_Hospital_Wards.SubDept_Id = SubDepartment.SubDept_Id AND admin_Hospital_Wards.Dept_Id = SubDepartment.Dept_Id INNER JOIN Department ON SubDepartment.Dept_Id = Department.Dept_ID ON Radiology_Order_Main.RegNo = Pt_Assign_Bed.Reg_No AND Radiology_Order_Main.YearlyNo = Pt_Assign_Bed.Yearly_No WHERE (Radiology_Order_Main.DeptId = @Dept_ID) AND (CONVERT (varchar, Radiology_Order_Main.Date_Time, 103) = CONVERT (varchar, GETDATE(), 103))">
            <SelectParameters>
                <asp:SessionParameter Name="Dept_ID" SessionField="Dept_ID" />
            </SelectParameters>
        </asp:SqlDataSource>
        
       
       
   </div></div> <!--End Radiology Test-->  
  <br />
  <div  class="bx_infos_patients"  >
<h2><span >Operation List</span></h2>
<div class="bxinfo_marsgin" style="height:auto;">
       
      
        <asp:DataList ID="DataList_OperationList" runat="server" Width="100%">
            <ItemTemplate>
             <div class="bx_oplist" style="margin-top:5px;">
            <ul>
            
             <li> 
                 <asp:LinkButton ID="lnkPrefix" runat="server" CommandName="Select" 
                     Text='<%# Eval("Prefix") %>'></asp:LinkButton>
                 (<span class="ward"><asp:Label ID="Label_Ward_Name" runat="server" Text='<%# Eval("Ward_Name") %>'></asp:Label>/ <asp:Label ID="Label_Bed_No" runat="server" ToolTip="Bed Number" Text='<%# Eval("Bed_No") %>'></asp:Label></span>) </li> 
             
			 <li   ><asp:Label ID="Label_Urgency" runat="server"  style="color:#d73c3d;" Text='<%# Eval("Urgency") %>'></asp:Label> 
                 ( <asp:Label ID="Label_Procedure_Name" style="color:#0e5b87;" ToolTip="Procedure Name" runat="server" Text='<%# Eval("Procedure_Name") %>'></asp:Label> )  </li>             
             
               <li style="font-size:10px; color:#6a6666;" > <asp:Label ID="Label_RegNo" ToolTip="Registration Number" runat="server" Text='<%# Eval("RegNo") %>'></asp:Label> ( <asp:Label ID="Label_YearlyNo" runat="server" style="color:#000;" ToolTip="Yearly Number" Text='<%# Eval("YearlyNo") %>'></asp:Label> )<asp:Label ID="Label_ExpectedOpDate" runat="server" CssClass="date" ToolTip="Expected Operation Date" Text='<%# Eval("ExpectedOpDate") %>'></asp:Label> </li>
               <li style ="font-size:10px; color:#6a6666;">( From Time : <asp:Label ID="lblStratTime" 
                       runat ="server" Text='<%# Eval("From_Time") %>' ></asp:Label>) (To Time :
                   <asp:Label ID="lblEndTime" runat="server" Text='<%# Eval("To_Time") %>' ></asp:Label>)</li>
               
               </ul>
                </div>
            </ItemTemplate>
        </asp:DataList> 
   <br />

   </div></div><!--End Operation List--> 
    <br />  
    
    <div  class="bx_infos_patients"  >
<h2><span >Doctor Information</span></h2>
<div class="bxinfo_margin" style="height:auto;">
 
<asp:DataList ID="DataList_Search" runat="server" DataSourceID="SqlDataSource_DataListSearch" Width="100%"
            RepeatLayout="Flow">
            <ItemTemplate>
           <div class="bx_doctor">       
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" align="center" style="width:75px;"><img src="images_hacims/docpic.jpg" width="59" height="72" style="margin-top:4px;" /></td>
    <td valign="top"> 
    
     
<ul >
                                <li  >
                                   <span class="name"> <asp:Label ID="Label_Designation" runat="server" Text='<%# Eval("Designation_Name") %>'></asp:Label>
                                    <asp:Label ID="Label_Name" runat="server" Text='<%# Eval("name") %>'></asp:Label></span>
                                    <span style="color: #0658a8">(
                                        <asp:Label ID="Label_Department" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label>
                                        <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" Value='<%# Eval("EmpID") %>' />
                                        )</span></li>
                                <asp:DataList ID="DataList_Dist_Ser" runat="server" DataSourceID="SqlDataSource_Deg_Dist_Ser">
                                    <ItemTemplate>
                                        <li>
                                            <asp:Label ID="Label_deg" runat="server" Text='<%# Eval("Degree") %>'></asp:Label></li>
                                        <li>
                                            <asp:Label ID="Label_Dis" runat="server" Text='<%# Eval("Distinction") %>'></asp:Label></li>
                                        <li class="services">
                                            <asp:Label ID="Label_ser" runat="server" Text='<%# Eval("Services") %>'></asp:Label></li>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:DataList ID="DataList_Description" runat="server" DataSourceID="SqlDataSource_Description">
                                    <ItemTemplate>
                                        <li class="profile">
                                            <asp:Label ID="Label_Description" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                        </li>
                                    </ItemTemplate>
                                </asp:DataList>
                            </ul>
                       
                      </td>
  </tr>
</table>
  </div>                    
                        
                <asp:SqlDataSource ID="SqlDataSource_Description" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT Emp_Information AS Description FROM Employee_Other_Info WHERE (Emp_id = @Emp_id) AND (Emp_info_Type_id = 4)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_id" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
                <asp:SqlDataSource ID="SqlDataSource_Deg_Dist_Ser" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT (CASE WHEN (Emp_info_Type_id = 1) THEN Emp_Information ELSE '' END) AS Degree, (CASE WHEN (Emp_info_Type_id = 2) THEN Emp_Information ELSE '' END) AS Distinction, (CASE WHEN (Emp_info_Type_id = 3) THEN Emp_Information ELSE '' END) AS Services FROM Employee_Other_Info WHERE (Emp_id = @Emp_id) AND (Emp_info_Type_id <> 4)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_id" PropertyName="Value" />

                    </SelectParameters>
                </asp:SqlDataSource>
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="SqlDataSource_DataListSearch" runat="server"
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT name, Dept_Name, DeptID, SexID, Designation_Name, EmpID FROM (SELECT ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS name, ISNULL(Department.Dept_Name, '') AS Dept_Name, Employee.DeptID, Employee.SexID, ISNULL(Designation.Designation_Name, '') AS Designation_Name, Employee.EmpID FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.Profession_Code = 1)) AS tblview WHERE (EmpID = @EmpID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_EmpId" Name="EmpID" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_EmpId" runat="server" Value="665" />
        
        </div></div><!--End Docotor Info-->
 </td>
 <td width="50%" valign="top">
 
  <div  class="bx_infos_patients"  >
<h2><span >Calls</span></h2>
<div class="bxinfo_margin" style="height:auto;">

<asp:DataList ID="DataList_DOCTOR_CALL" runat="server" DataSourceID="SqlDataSource_DOCTOR_CALL">
        <ItemTemplate>
            <div class="bx_pathology">
                <ul >
                    <li><span class="name">
                        </span>
                        <asp:LinkButton ID="LinkButton_Patient" runat="server" ToolTip="Patient Name" CommandName="Select">LinkButton</asp:LinkButton>
                        ( <span class="ward">
                            <asp:Label ID="AgeLabel" runat="server"  Text='<%# Eval("Age") %>' ToolTip="Patient Age"></asp:Label>
                            Year </span>) (<span class="ward">
                                <asp:Label ID="Ward_NameLabel" runat="server" Text='<%# Eval("Ward_Name") %>' ToolTip="Ward Name"></asp:Label>
                                /
                                <asp:Label ID="Bed_NoLabel" runat="server" Text='<%# Eval("Bed_No") %>' ToolTip="Bed Number"></asp:Label>
                            </span>)</li><li style="font-size:10px; color:#6a6666;">&nbsp;(MR#
                                <asp:Label ID="Label_RegNo" runat="server" ToolTip="Registration Number" Style="font-size: 10px; color: #6a6666"></asp:Label>
                                Yearly #<asp:Label ID="Label_YearlyNo" runat="server" ToolTip="Yearly Number" Text='<%# Eval("YearlyNo") %>'></asp:Label>)&nbsp;
                    </li>
                    <li style="font-size:11px;"> <asp:Label ID="CallBYLabel" ToolTip="Call By" runat="server" Text='<%# Eval("CallBY") %>'></asp:Label>&nbsp;|&nbsp;
            <asp:Label ID="CallByDepartmentLabel" runat="server" ToolTip="Call by Department" Text='<%# Eval("CallByDepartment") %>'></asp:Label>&nbsp;|&nbsp;
                        <asp:Label ID="Label_CallType" ToolTip="Call Type" runat="server" Text='<%# Eval("Call_Type") %>'></asp:Label>&nbsp;|&nbsp;
                        <asp:Label ID="Label_CallDate" ToolTip="Call Type" runat="server" Text='<%# Eval("CallDate") %>'></asp:Label>&nbsp;|&nbsp;
         			   <asp:Label ID="CallTimeLabel" runat="server" ToolTip="Call Time" Text='<%# Eval("CallTime") %>'></asp:Label>
                        <asp:HiddenField ID="hfPrefix" runat ="server" Value ='<%# Eval("Prefix") %>' />
                        <asp:HiddenField ID="HiddenField_Reg_No" runat="server" Value='<%# Eval("RegNo") %>' />
                        <asp:HiddenField ID="HiddenField_PFName" runat="server" Value='<%# Eval("PFName") %>' />
                        <asp:HiddenField ID="HiddenField_PMName" runat="server" Value='<%# Eval("PMName") %>' /></li>
                </ul><asp:HiddenField ID="HiddenField_PLName" runat="server" Value='<%# Eval("PLName") %>' />
            </div>
        </ItemTemplate>
    </asp:DataList></div>
        <asp:SqlDataSource ID="SqlDataSource_DOCTOR_CALL" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="Select_Doctor_Call_XML_New" SelectCommandType="StoredProcedure">
          <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="Doctor_ID" SessionField="Emp_id" Type="Int32" />
            <asp:SessionParameter Name="Call_To_Dept" SessionField="Dept_Id"
                Type="Int32" />
            </SelectParameters>
          </asp:SqlDataSource>
        </div><!--End calls Info-->
     
     <br />
     <div  class="bx_infos_patients"  >
<h2><span >Correspondence</span></h2>
<div class="bxinfo_margin" style="height:auto;">

 </div></div><!--End Correspondanc Info-->  

     <br />
     <div  class="bx_infos_patients"  >
<h2><span >Tasks</span></h2>
<div class="bxinfo_margin" style="height:auto;">

 </div></div><!--End Tasks Info-->    
     
     </td></tr>
    
    </table>--%>
  
 
     

 

    
   
   <br />
 
  
 
 
 
 
 
       </td>
  </tr>
</table>

 

 

   
   
       
       
       
       
       
        
        
        
        
        </td>
        
        
     
  </tr>
</table>


 



 


<script type="text/javascript">
<!--
var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1",{contentIsOpen:false});
var CollapsiblePanel2 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel2", {contentIsOpen:false});
//-->
</script>

 </asp:Content>
 