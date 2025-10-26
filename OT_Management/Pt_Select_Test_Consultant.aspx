<%@ Page Language="VB" AutoEventWireup="false" ValidateRequest="false"  CodeFile="Pt_Select_Test_Consultant.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="Pt_Select_Test_Consultant" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>


 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
 
    
<script type="text/javascript" src="../Validate.js"></script>

  
<script language="javascript" type="text/javascript"> 

function CheckRequiredField(Element_ID,TB_ID)
{
   
    //Bilirubin="TextBoxT0134"
    //Indirect="TextBoxT0136"
    //Direct="TextBoxT01649"
    //Total Proteins="TextBoxT0142"
    //Albumin="TextBoxT0143"
    //Globulin="TextBoxT0144"
    //A/G Ratio="TextBoxT0145"
    
    //Total Lipids="TextBoxT0151"
    //Trigiycerides="TextBoxT0152"
    //Cholesterol="TextBoxT0153"
    //H.D.L.="TextBoxT0154"
    //L.D.L.="TextBoxT0155"
    //V.L.D.L.="TextBoxT0156"
    //Chylomicrons.="TextBoxT0157"
    
    //24 Hr Urine Protein="TextBoxT0216"
    //Serum Creatinine ="TextBoxT0131"
    //Creatinine Clearance ="TextBoxT0132"
    //Blood Urea ="TextBoxT0130"
    
    //alert(Element_ID);
//    if(TB_ID==369||TB_ID==94||TB_ID==93||TB_ID==95)
//    {
//        var Bilirubin = document.getElementById("TextBoxT0134").value;
//        var InDirect = document.getElementById("TextBoxT0136").value;
//        document.getElementById("TextBoxT01649").value=Bilirubin-InDirect;
//        if(document.getElementById("TextBoxT0142").value!="")
//        {
//            var Globulin=document.getElementById("TextBoxT0142").value - document.getElementById("TextBoxT0143").value;
//            document.getElementById("TextBoxT0144").value = Globulin;
//            var AGRatio=document.getElementById("TextBoxT0143").value/document.getElementById("TextBoxT0144").value;
//            document.getElementById("TextBoxT0145").value=AGRatio;
//        }
//    }
//    else if(TB_ID==378)
//    {
//        if (document.getElementById("TextBoxT0152").value<450)
//        {
//            if(document.getElementById("TextBoxT0154").value!="" && document.getElementById("TextBoxT0153").value!="")
//            {
//                var LDL=document.getElementById("TextBoxT0153").value-document.getElementById("TextBoxT0154").value-(document.getElementById("TextBoxT0152").value/5);
//                document.getElementById("TextBoxT0155").value=LDL;
//                var VLDL=document.getElementById("TextBoxT0153").value-(document.getElementById("TextBoxT0154").value+LDL);
//                document.getElementById("TextBoxT0156").value=VLDL;
//            }
//        }
//    }
//    else if(TB_ID==370)
//    {
//        if(document.getElementById("TextBoxT0131").value.length!=0 && document.getElementById("TextBoxT0216").value.length!=0)
//        {
//            var a=document.getElementById("TextBoxT0130").value*document.getElementById("TextBoxT0216").value;    
//            var b=document.getElementById("TextBoxT0131").value*1440;
//            document.getElementById("TextBoxT0132").value=Math.round(a/b);
//        }
//    }
    return;
}
</script>

 
 <style type="text/css">
     
      .btn_hacims_change {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    background: url("../images_hacims/img_btn_bg.png") repeat-x scroll left bottom rgba(65, 104, 52, 0.00);
    border-color: #E1E1E1;
    border-image: none;
    border-radius: 4px;
    border-style: solid;
    border-width: 1px 1px 0;
    box-shadow: 0 1px 1px #A8A8A8;
    color: #001A65;
    cursor: pointer;
    font-family: Calibri;
    font-size: 16px;
    font-weight: bold;
    height: 22px;
    line-height: 17pt;
    margin: 0;
    outline: medium none;
    padding-bottom: 2px;
    padding-left: 20px;
    padding-right: 20px;
    text-shadow: 1px 1px 0 #FFFFFF;
    width: auto;
}
     
 .bx_oplist a { color:#1a4796; font-size:11px;   }
.bx_oplist a:hover { color:#d71635; }
#nav {display:none; }
 </style>
<script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
<script src="../css_hacims/ck.js" type="text/javascript"></script>
 
	<script src="../css_hacims/js/elrte.min.js" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" href="../css_hacims/css/elrte.min.css" type="text/css" media="screen" charset="utf-8">

 
	<script src="../css_hacims/js/i18n/elrte.ru.js" type="text/javascript" charset="utf-8"></script>

	<script type="text/javascript" charset="utf-8">
		$().ready(function() {
			var opts = {
				cssClass : 'el-rte',
			 
				height   : 450,
				toolbar  : 'complete',
				cssfiles : ['../css_hacims/css/elrte-inner.css']
			}
			$('#ctl00_ContentPlaceHolder1_TextBox_Description').elrte(opts);
		})
		
		</script>
 
 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >
 
    <asp:HiddenField ID="HiddenField_TextDescription" runat="server" />
 
<asp:Label ID="Label_message" runat="server"  CssClass="err"></asp:Label> 
 

<asp:DataList ID="DataListtemplate" runat="server" DataKeyField="Template_id" DataSourceID="SqlDataSourceTemplate"
            RepeatColumns="5" RepeatDirection="Horizontal"  Width="100%" Visible="False">
            <ItemTemplate>
                <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" CssClass="login_link"
                    ForeColor="Blue" Text='<%# Eval("Template_Name", "{0}") %>'></asp:LinkButton>
            </ItemTemplate>
           
        </asp:DataList><asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                <asp:SessionParameter Name="deptid" SessionField="dept_id" />
            </SelectParameters>
        </asp:SqlDataSource>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" Visible="False">
        <contenttemplate>
<TABLE class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD align=right width="40%"></TD><TD><asp:DropDownList id="DropDownList_machine" runat="server" Visible="False" DataSourceID="SqlDataSource_Mechine" DataValueField="Machine_Id" DataTextField="Machine_Name"></asp:DropDownList> <asp:Button id="Button1" runat="server" Text="Go" Visible="False"></asp:Button> </TD></TR></TBODY></TABLE><asp:SqlDataSource id="SqlDataSource_Mechine" runat="server" SelectCommand="SELECT Machine_Id, Machine_Name FROM Lab_Machines" ConnectionString="<%$ ConnectionStrings:Admin_OT_ConnectionString %>"></asp:SqlDataSource> <asp:SqlDataSource id="SqlDataSource_machines_main_ID" runat="server" ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" SelectCommand="SELECT     PT_TestMessages.Pt_Message_Id, case when PT_TestMessages.Machine_Sample_No=Convert(varchar,Path_Result_Delivery.Main_ID) then  PT_TestMessages.Machine_Sample_No else  PT_TestMessages.Sample_No end as [Sample_No],Lab_Machines.Machine_Name, PT_TestMessages.Machine_Sample_No, &#13;&#10;                      Path_Result_Delivery.Main_ID&#13;&#10;FROM         PT_TestMessages INNER JOIN&#13;&#10;                      Lab_Machines ON PT_TestMessages.Machine_id = Lab_Machines.Machine_Id LEFT OUTER JOIN&#13;&#10;                      Path_Result_Delivery ON PT_TestMessages.Machine_Sample_No = Convert(varchar,Path_Result_Delivery.Main_ID) &#13;&#10;  WHERE (Lab_Machines.Machine_Id = @mID) and (PT_TestMessages.Status_Id=0) " ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>" UpdateCommand="UPDATE PT_TestMessages SET Sample_No = @Sample_No WHERE (Machine_Sample_No = @Sample_No)" InsertCommand="INSERT INTO [PT_TestMessages] ([Sample_No]) VALUES (@Sample_No)" DeleteCommand="DELETE FROM [PT_TestMessages] WHERE [Pt_Message_Id] = @Pt_Message_Id"><SelectParameters>
<asp:ControlParameter ControlID="DropDownList_machine" PropertyName="SelectedValue" Name="mID"></asp:ControlParameter>
</SelectParameters>
<DeleteParameters>
<asp:Parameter Name="Pt_Message_Id" Type="Decimal"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:QueryStringParameter QueryStringField="Main_ID" Name="Sample_No" Type="String"></asp:QueryStringParameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="Sample_No" Type="String"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource> 
</contenttemplate>
    </asp:UpdatePanel>
   
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:-15px;">
  <tr>
    <td valign="top" width="25%"> 
    
    <br />

      <fieldset class="fset_1"><legend>Search</legend><table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" style="margin-top:5px;" >
           <tr>
               <td width="30%"    align="right">
                   MR # :</td>
               <td >
                   <asp:TextBox ID="TextBox_Mr_No" runat="server" Width="100px"></asp:TextBox></td>
                   </tr><tr>
               <td  align="right">
                   Visit # :</td>
               <td>
                   <asp:TextBox ID="TextBox_Visit_No" runat="server" Width="100px"></asp:TextBox>
                 <asp:Button ID="Button_Sesch" runat="server" Text="Seach" Width="60px" />                                <asp:TextBox ID="TextBox_Sample_No" runat="server" Width="150px" Visible="False"></asp:TextBox>             </td>
           </tr>
           
       </table> </fieldset>
    
    
    
    
     <div class="bxmain" style="width:98%;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right">Test Group :</td>
    <td><asp:DropDownList ID="DropDownList_Test_Group" runat="server" datasourceid="SqlDataSource_TG"
                    DataTextField="TGName" DataValueField="TGID" Width="150px"> </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td><asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
      <asp:ListItem Value="new">Single</asp:ListItem>
      <asp:ListItem Selected="True" Value="old">Double</asp:ListItem>
    </asp:RadioButtonList></td>
  </tr>
  <tr>
    <td align="right">Test Name :</td>
    <td><asp:DropDownList ID="DropDownList_TestName" runat="server" datasourceid="SqlDataSource_Status"
                    DataTextField="TB_Name" DataValueField="TB_ID" Width="150px"> </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">Status :</td>
    <td><asp:DropDownList ID="DropDownList_Status" runat="server" datasourceid="SqlDataSource_Status_Edit"
                                      DataTextField="Status" DataValueField="Status_ID" Width="150px"> </asp:DropDownList>
      <asp:SqlDataSource ID="SqlDataSource_Status_Edit" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
                                      ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" SelectCommand="SELECT Status, Status_ID FROM Test_Status WHERE (Priority < 2) AND (NOT (Priority IS NULL))"> </asp:SqlDataSource>
      <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Bind("ID", "{0}") %>' /></td>
  </tr>
  <tr>
     
    <td colspan="2" align="center"><asp:Button ID="Button_Draw" runat="server" Text="Draw" Width="50px" />
      <asp:Button ID="Button_update" runat="server" Text="Change Status" Width="85px"   />
        <asp:LinkButton ID="LinkButton_Attach_Image" runat="server" CssClass="report" 
            Width="77px">Attach Image</asp:LinkButton>
        <asp:LinkButton ID="LinkButton_AppDate" runat="server" CssClass="report" 
            Width="66px"  OnClick ="LinkButton_AppDate_Click">App.  Report</asp:LinkButton>
       
            
<asp:HyperLink ID="hplnkPtInfo" runat="server"  CssClass="report" NavigateUrl="~/Pt_EMR/Pt_Info.aspx">Patient chart</asp:HyperLink>

<asp:HyperLink ID="hlnkResults" runat="server"  CssClass="report" NavigateUrl="~/Pt_EMR/Investigation_Results.aspx">Results</asp:HyperLink>
            </td>
  </tr>
   
</table>
 
<br />

 <asp:DataList ID="DataList1" runat="server" DataKeyField="ID" DataSourceID="SqlDataSource_Status" Width="100%">
           <ItemTemplate>
           <div class="bx_oplist" style="width:94%; margin-left:10px;">
               <ul style="margin-left:10px;">
               <li><asp:LinkButton ID="LinkButton_TB_ID" runat="server" CommandName="Select" Text='<%# Eval("TB_Name", "{0}") %>'></asp:LinkButton></li>
               <li></li>
               </ul>
            </div>
                       <asp:HiddenField ID="HiddenField6" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                       <asp:HiddenField ID="HiddenField7" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
                       <asp:HiddenField ID="HiddenField8" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                       <asp:HiddenField ID="HiddenFieldTBID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
           </ItemTemplate>
       </asp:DataList>
</div>
    
    
    
    </td>
    <td valign="top" style="width: 863px"> 
    

    <br />

  <fieldset class="fset_1"><legend>Details</legend></fieldset>   
    
    
 
     <div class="bxmain">
 
    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" style="margin-top:-10px;" >
            <tr>
                <td align="right" width="25%" >
                    Perform Date :</td>
                <td  width="25%">
                  <igsch:webdatechooser id="WebDateChooser_Perform_Date" runat="server" CssClass="drop_date" Width="100px"></igsch:webdatechooser>
                </td>
                <td align="right"  width="25%" >
          Perform Time :</td>
                <td  width="25%">
                    <igtxt:webdatetimeedit id="WebDateTimeEdit_Perform_time" runat="server" editmodeformat="t" CssClass="drop_date" Width="100px"></igtxt:webdatetimeedit>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top" >
            Duration :</td>
                <td valign="top" >
                <asp:TextBox ID="TextBox_Duration" runat="server" Width="65px"></asp:TextBox>&nbsp;
              <asp:DropDownList ID="DropDownList_Duration_Type" runat="server" Width="80px">
                        <asp:ListItem Value="h">Hours</asp:ListItem>
                        <asp:ListItem Value="m">Minutes</asp:ListItem>
                    </asp:DropDownList></td>
                <td align="right" valign="top" >
          Any Complication :</td>
                <td >
                    <asp:TextBox ID="TextBox_any_Complication" runat="server" Height="22px" TextMode="MultiLine"
                        Width="200px"></asp:TextBox></td>
          </tr>
        <tr>
            <td colspan="4">
         <asp:Panel ID="Panel_image" runat="server"   Width="100%" Wrap="False">
                </asp:Panel>
            </td>
        </tr>
           
        </table>
  
      </div>

        <asp:Panel ID="Panel2"  runat="server"  Wrap="False" Width="100%" Direction="RightToLeft">
            <asp:LinkButton ID="LinkButton_PatientConsumption" runat="server" 
                Visible="False">Patient Consumption</asp:LinkButton></asp:Panel>
       
       <div style="position:absolute; margin-left:135px;"><asp:Label ID="Label_remarkstitle" runat="server" CssClass="err" style="margin-left:15px; font-weight:bold; line-height:25px; color:#a00593;" ></asp:Label><SPAN style="COLOR:#CCC;">&nbsp;&nbsp;|&nbsp;&nbsp;</SPAN><asp:LinkButton runat="server" ID="print_report" CssClass="print_btn" style="float:right; margin-left:10px;;">Print Report</asp:LinkButton>
          &nbsp; <asp:LinkButton ID="LinkButton_print" runat="server" CssClass="print_btn" Style="float: right; margin-left:10px;">Print Form</asp:LinkButton>
           &nbsp; &nbsp; &nbsp;
       </div>
       
<div id="TabbedPanels1" class="TabbedPanels">
          <ul class="TabbedPanelsTabGroup" style="margin-left:10px;">
            <li class="TabbedPanelsTab" tabindex="0">Form</li><li class="TabbedPanelsTab" tabindex="0">Remarks</li></ul>
       
          <div class="TabbedPanelsContentGroup" style="height:auto;">
            <div class="TabbedPanelsContent"><asp:Panel ID="Panel1" runat="server" Width="100%"> </asp:Panel> </div>
          
         <div class="TabbedPanelsContent">
         
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="85%" valign="top"> <asp:Label ID="Label_Description" runat="server" CssClass="err" Text="" Visible="False" ></asp:Label> 
                                                    
<asp:TextBox ID="TextBox_Description" runat="server" Height="500px" TextMode="MultiLine" Width="100%" style="width:100%; " ></asp:TextBox> <br />  </td>
    <td valign="top">  <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td valign="top">
                    <asp:TextBox ID="TextBox_Radiology_templates1" runat="server" Width="50%"></asp:TextBox>
                    <asp:Button ID="Button_Radiology_templates" runat="server" Text="Search" Width="45px" /><%=strHiddenFieldTBID_val %></td>
            </tr>
            <tr>
                <td valign="top" >
                    <asp:ListBox ID="ListBox_Radiology_templates" runat="server" AutoPostBack="True"
                        DataSourceID="SqlDataSource_Radiology_templates" DataTextField="Templates_Name"
                        DataValueField="Templates_Description" Height="175px" Width="98%"></asp:ListBox>
                    <asp:SqlDataSource ID="SqlDataSource_Radiology_templates" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_OT_ConnectionString %>"
                        InsertCommand="INSERT INTO Radiology_templates(Templates_Name, Templates_Description, TB_ID) VALUES (@Templates_Name, @Templates_Description, @TB_ID)"
                        SelectCommand="SELECT Radiology_templates_ID, Templates_Name, Templates_Description, TB_ID FROM Radiology_templates WHERE (Templates_Name LIKE @Templates_Name + '%') AND (TB_ID = @TB_ID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="TextBox_Radiology_templates1" DefaultValue="%" Name="Templates_Name"
                                PropertyName="Text" />
                            <asp:ControlParameter ControlID="HiddenField_TBID" DefaultValue="" Name="TB_ID" PropertyName="Value" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:ControlParameter ControlID="TextBox_template_name" Name="Templates_Name" PropertyName="Text" />
                            <asp:ControlParameter ControlID="TextBox_Description" Name="Templates_Description"
                                PropertyName="Text" />
                            <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table></td>
  </tr>
</table>
     
         
        







</div>
         
         </div></div>
        
        

<br />


  <div align="center"  > 
<div align="center" style="margin-top:10px; display:inline-table; " ><asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" />&nbsp;
                  <asp:Button ID="ButtonFinal" runat="server" CssClass="btn1" Text="Approve" />
    <asp:LinkButton ID="LinkButton_Show_Report" runat="server" CssClass="report" Visible="False"><span></span>Show Report</asp:LinkButton>
    <asp:LinkButton ID="LinkButton_Track" runat="server" CssClass="report" Visible="False">Audit History</asp:LinkButton>&nbsp;<asp:Button
        ID="Button_template_Insert" runat="server" CssClass="btn1" Text="Insert Template" /></div></div><br />
      
      
      
        <asp:Panel ID="Panel_template" runat="server" Visible="False" Width="100%">
        <div class="bxmain">
          
          
<table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                <tr>
                    <td width="40%" align="right"  >
                        <strong>Template Name :</strong></td>
                    <td  >
                      <asp:TextBox ID="TextBox_template_name" runat="server"  ></asp:TextBox> 
                  <asp:Button ID="Button2" runat="server"  Text="Insert" /> 
                  <asp:Button
                            ID="Button_close_Template" runat="server" Text="Close" /></td>
            </tr>
              
                
          </table></div>
        </asp:Panel>
       
       
       
       
    </td>
  </tr>
</table>
 
    

                  <asp:SqlDataSource ID="SqlDataSource_Status" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" SelectCommand="pt_select_status"
                      UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE TB_ID =@TB_ID and  Main_ID =@Main_ID" SelectCommandType="StoredProcedure">
                      <UpdateParameters>
                          <asp:ControlParameter ControlID="HiddenField_Edit_Status" Name="Status" PropertyName="Value" />
                          <asp:ControlParameter ControlID="DropDownList_TestName" Name="TB_ID" PropertyName="SelectedValue" />
                          <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" />
                      </UpdateParameters>
                      <SelectParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                          <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
                      </SelectParameters>
                  </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_TG" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
        ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT &#13;&#10;                      Test_Status.Status, CONVERT(varchar, Path_Result_Delivery.Sample_Collection_Date, 107) AS Date_Time, TestGroup.TGName, TestGroup.TGID, &#13;&#10;                      Test_Main_Sub_Grouping.MS_TGID, Path_Result_Delivery.Main_ID, Test_Status.Status_ID&#13;&#10;FROM         Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID LEFT OUTER JOIN&#13;&#10;                      Test_Main_Sub_Grouping ON TestGroup.TGID = Test_Main_Sub_Grouping.TGID&#13;&#10; WHERE (Test_Status.Status_ID = @Status) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Main_ID = @Main_ID) ">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
        InsertCommand="insert_lab_status_record" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status  WHERE (Main_ID = @Main_ID) AND (TB_ID = @TB_ID) ">
        <UpdateParameters>
            <asp:ControlParameter ControlID="DropDownList_Status" DefaultValue="" Name="Status"
                PropertyName="SelectedValue" />
            <asp:QueryStringParameter DefaultValue="" Name="Main_ID" QueryStringField="Main_ID" />
            <asp:ControlParameter ControlID="DropDownList_TestName" DefaultValue="" Name="TB_ID"
                PropertyName="SelectedValue" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter DefaultValue="" Name="Main_ID" QueryStringField="Main_ID"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Status" DefaultValue="" Name="Status"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_TestName" Name="TB_ID" PropertyName="SelectedValue"
                Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSource_Group" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT &#13;&#10;                      &#13;&#10;                      TestGroup.TGName, TestGroup.TGID&#13;&#10;FROM         Investigation_Order_Sub INNER JOIN&#13;&#10;                      Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID RIGHT OUTER JOIN&#13;&#10;                      Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN&#13;&#10;                      Test_Main_Sub_Grouping ON TestGroup.TGID = Test_Main_Sub_Grouping.TGID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID ON Investigation_Order_Sub.TB_ID = Test_Booking_Services.TB_ID AND &#13;&#10;                      Investigation_Order_Main.RegNo = Path_Result_Delivery.Reg_no AND Investigation_Order_Main.YearlyNo = Path_Result_Delivery.Yearly_No&#13;&#10;WHERE     (Test_Status.Status_ID = @Status) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND &#13;&#10;                      (Path_Result_Delivery.Main_ID = @Main_ID)">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenField_Edit_Status" runat="server" />
                  <asp:HiddenField ID="HiddenField_Edit_ID" runat="server" />
 
        <asp:DataList ID="DataListMainGroup" runat="server" DataKeyField="MS_TGID" DataSourceID="SqlDataSourceMainGroup"
            RepeatColumns="4" Style="position: static" Width="100%" Visible="False">
            <ItemTemplate>
                
                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="login_link"
                    Text='<%# Eval("TGName", "{0}") %>' Width="208px"></asp:LinkButton><br />
                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                <asp:HiddenField ID="HiddenField4" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
                <asp:HiddenField ID="HiddenField5" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
            </ItemTemplate>
        </asp:DataList>
    
    <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
            SelectCommand="pt_main_group" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="" Name="payid" SessionField="YearlyNo" />
                <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            </SelectParameters>
        </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenFieldCategory" runat="server" />
                  <asp:HiddenField ID="HiddenFieldMainID" runat="server" />
    <asp:HiddenField ID="HiddenField_TBID" runat="server" />
    <asp:HiddenField ID="HiddenField_Component_Id" runat="server" />
    <asp:HiddenField ID="HiddenField_Component_Value" runat="server" />
    <asp:HiddenField ID="HiddenField_SampleNo" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Message" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_OT_ConnectionString %>"
        InsertCommand="INSERT INTO PT_TestMessages(Sample_No, Sent_Message, Received_Message) VALUES (@Sample_No, @Sent_Message, @Received_Message)"
        SelectCommand="SELECT [Pt_Message_Id], [Sample_No], [Sent_Message], [Received_Message], [Status_Id], [Machine_id] FROM [PT_TestMessages]">
        <InsertParameters>
            <asp:Parameter DefaultValue="1222" Name="Sample_No" />
            <asp:ControlParameter ControlID="TextBox1" Name="Sent_Message" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="Received_Message"
                PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_MachineResults" runat="server" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"
        InsertCommand="INSERT INTO PT_Machine_Results(Component_Id, Sample_No, Component_Value, Status_Id, Result_Datetime) VALUES (@Component_Id, @Sample_No, @Component_Value, @Status_Id, @Result_Datetime)"
        SelectCommand="SELECT [Component_Id], [Sample_No], [Component_Value], [Status_Id], [Result_Datetime] FROM [PT_Machine_Results]">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_Component_Id" Name="Component_Id" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_SampleNo" Name="Sample_No" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Component_Value" Name="Component_Value"
                PropertyName="Value" />
            <asp:Parameter DefaultValue="0" Name="Status_Id" />
            <asp:ControlParameter ControlID="HiddenField_Datetime" DefaultValue="" Name="Result_Datetime"
                PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_MGID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_machine_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_OT_ConnectionString %>"
        SelectCommand="SELECT [Machines_status_ID], [Machines_status] FROM [Machines_Status]"
        UpdateCommand="UPDATE [Admin_Pathology].[dbo].[PT_TestMessages]&#13;&#10;   SET [Status_Id] =1&#13;&#10; Where Sample_No=@SampleNo">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_SampleNo" Name="SampleNo" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
 


 
 


<asp:Label ID="Label1" runat="server" Text="Label" Visible="False" CssClass="err"></asp:Label><br />

                <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                  <asp:SqlDataSource ID="SqlDataSource_UpdateStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Forward_To_Sub_Dept SET status = @status WHERE (Reg_No = @Reg_No) AND (yearly_no = @yearly_no) AND (to_sub_Dept = @to_sub_Dept)">
                      <UpdateParameters>
                          <asp:Parameter DefaultValue="1" Name="status" />
                          <asp:SessionParameter DefaultValue="" Name="Reg_No" SessionField="registrationNo" />
                          <asp:SessionParameter Name="yearly_no" SessionField="YearlyNo" />
                          <asp:Parameter DefaultValue="13" Name="to_sub_Dept" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField3" runat="server" Value="0" /><asp:HiddenField ID="HiddenField_MS_TGID" runat="server" Value="0" /><asp:HiddenField ID="HiddenField_TSGID" runat="server" Value="0" />
                  <asp:HiddenField ID="HiddenField_TGID" runat="server" />
                  <asp:HiddenField ID="HiddenField_TG_ID" runat="server" />
                  <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
                      
        ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" 
        UpdateCommand="UPDATE PatientsLabTest SET Status = @Status WHERE (RegNo = @RegNo) AND (PayID = @PayID)" InsertCommand="INSERT INTO [SMS].[dbo].[PatientSms]
           (
          [phone]
           ,[send_status]
         
           ,[sms_text],
           IsPorted
          )
     VALUES
           (
           @phone
           ,@send_status
           
           ,@sms_text
           ,@IsPorted
           )
">
                      <InsertParameters>
                          <asp:SessionParameter Name="phone" SessionField="PatientMobilephone" />
                          <asp:SessionParameter Name="IsPorted" SessionField="IsPortedNo" />
                          <asp:Parameter DefaultValue="0" Name="send_status" />
                          <asp:SessionParameter DefaultValue="" Name="sms_text" 
                              SessionField="PatientInfo" />
                      </InsertParameters>
                      <UpdateParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                          <asp:Parameter DefaultValue="10" Name="Status" />
                          <asp:SessionParameter DefaultValue="" Name="PayID" SessionField="YearlyNo" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_Update_Status" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" UpdateCommand="Update_Patient_Test_Status" UpdateCommandType="StoredProcedure">
                      <UpdateParameters>
                          <asp:Parameter DefaultValue="10" Name="Status" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                          <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value"
                              Type="Int32" />
                          <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceUpdateTreatment" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" UpdateCommand="UPDATE PatientsLabTest SET Status = @Status WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
                      <UpdateParameters>
                          <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                          <asp:Parameter DefaultValue="6" Name="Status" />
                          <asp:QueryStringParameter DefaultValue="" Name="PayID" QueryStringField="YearlyNo" />
                      </UpdateParameters>
                  </asp:SqlDataSource>   <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
    <asp:HiddenField ID="HiddenField_Datetime" runat="server" />
    <br />
    <asp:HiddenField ID="HiddenField_Page_type" runat="server" />
 
    <asp:Panel ID="Panel_Track" runat="server" Visible="False" Width="100%"   CssClass="lightbox_bg"  >
    <div class="lightbox">
    <h1 class="h1"><span>Audit History</span></h1>
        <asp:GridView ID="GridView_Track" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Track" Width="100%">
            <Columns>
                <asp:BoundField DataField="TB_Name" HeaderText="Test Name" SortExpression="TB_Name" />
                <asp:BoundField DataField="ComponentName" HeaderText="Test Component" SortExpression="ComponentName" />
                <asp:BoundField DataField="TCValue" HeaderText="Component Value" SortExpression="TCValue" />
            </Columns><RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
        <br />

        <asp:SqlDataSource ID="SqlDataSource_Track" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
            ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" SelectCommand="Path_PatientTestResult_Track"
            SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="Reg_No" QueryStringField="Reg_No" Type="String" />
                <asp:QueryStringParameter Name="Yearly_No" QueryStringField="YearlyNo" Type="Decimal" />
                <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Decimal" />
            </SelectParameters>
        </asp:SqlDataSource>
        
     <DIV align="center">   <asp:Button ID="Button_Track_Close" runat="server" Text="Close" /></DIV>
     <br />
</div>
     </asp:Panel>
    
    <asp:Panel ID="Panel_Missing_Component" runat="server" Visible="False" Width="100%"   CssClass="lightbox_bg" >
     <div class="lightbox">
    <h1 class="h1"><span>Missing Values</span></h1>
       
        <asp:Label ID="Label_Missing_Component_Message" runat="server" Text="Your Information has been Saved" CssClass="red"></asp:Label><br />
       <div style="height:320px; width:100%; overflow:auto; overflow-x:hidden;"> <asp:GridView ID="GridView_Missing_Component" runat="server" AutoGenerateColumns="False" Width="100%"
            DataSourceID="SqlDataSource_Missing_Component">
            <Columns>
                <asp:BoundField DataField="TB_Name" HeaderText="Test Name" SortExpression="TB_Name" />
                <asp:BoundField DataField="ComponentName" HeaderText="Test Component" SortExpression="ComponentName" />
            </Columns><RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView></div>
        <br />

        <asp:SqlDataSource ID="SqlDataSource_Missing_Component" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
            ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" SelectCommand="Missing_Component"
            SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="Reg_No" QueryStringField="Reg_No" Type="String" />
                <asp:QueryStringParameter Name="Yearly_No" QueryStringField="YearlyNo" Type="Decimal" />
                <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Decimal" />
            </SelectParameters>
        </asp:SqlDataSource>
       <div align="center"> <asp:Button ID="Button_Missing_Component" runat="server" 
               Text="Close" Height="28px" Width="84px" /></div>
       <br />

       
       </asp:Panel>

<script type="text/javascript">
var cookies = Spry.Utils.Cookie("read","tabbedpanels_tb2");
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
Spry.Utils.addUnLoadListener(function(){
    // save the current value
    Spry.Utils.Cookie('create','tabbedpanels_tb2',TabbedPanels1.getCurrentTabIndex());
});
</script>

    <asp:HiddenField ID="HiddenField_flag" runat="server" />
    









  </asp:Content>