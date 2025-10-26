<%@ Page Language="VB" AutoEventWireup="false" ValidateRequest="false"  CodeFile="Pt_Select_Test_Consultant.aspx.vb"  MasterPageFile="~/hacims_masterpage_billing.master" Inherits="Pt_Select_Test_Consultant" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%--<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>--%>
  

<%-- <%@ Register assembly="Infragistics2.WebUI.WebHtmlcc1.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebHtmlcc1" tagprefix="ighedit" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
 <%@ Register TagName="InveestigationChartControl" Src="~/Pt_EMR/Controls/RadialogyImageControl.ascx" TagPrefix="INVC" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script type="text/javascript">

            function confirmSave() {
                if (window.confirm("Do you want to Final?")) {
                    return true
                }
                else {
                    return false
                }
            }


    </script>

    <script type="text/javascript" src="../Validate.js"></script>

    <style type="text/css">
        .bx_oplist a {
            color: #1a4796;
            font-size: 11px;
        }

            .bx_oplist a:hover {
                color: #d71635;
            }

        #nav {
            display: none;
        }
    </style>
    <script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
    
    <link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
    <script src="../css_hacims/ck.js" type="text/javascript"></script>

    <%--<link href="redactor-js-master/css/style.css" rel="stylesheet" />--%>
    <%--<script type="text/javascript" src="redactor-js-master/lib/jquery-1.9.0.min.js"></script>--%>


    <script type="text/javascript">
      


        $(document).ready(

            function () {
                $('[id$="TextBox_Description"]').redactor({
                    focus: true,
                    plugins: ['fontsize', 'fullscreen'],
                    //focus: true,
                    //plugins: ['fontsize', 'fullscreen'],
                    //buttons: ['html', 'formatting', 'bold', 'italic', 'link','fontsize'],
                   // formattingTags: ['h2', 'h3', 'p', 'blockquote'],
                    autoresize: false,
                    minHeight: 400
                    
                });
            }
        );
    </script>
   
  

    <script language="javascript" type="text/javascript">
        $(document).ready(function () {

            $(".link_review").colorbox({ width: "1000px", height: "580px", iframe: true });
            $("#ctl00_ContentPlaceHolder1_TextBox_Description").focus();
        });

    </script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >

    <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ScriptManager>
<asp:Label ID="Label_message" runat="server"  CssClass="err"></asp:Label> 
 

<asp:DataList ID="DataListtemplate" runat="server" DataKeyField="Template_id" DataSourceID="SqlDataSourceTemplate"
            RepeatColumns="5" RepeatDirection="Horizontal"  Width="100%" Visible="False">
            <ItemTemplate>
                <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" CssClass="login_link"
                    ForeColor="Blue" Text='<%# Eval("Template_Name", "{0}") %>'></asp:LinkButton>
            </ItemTemplate>
           
        </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                <asp:SessionParameter Name="deptid" SessionField="dept_id" />
            </SelectParameters>
        </asp:SqlDataSource>
   <%-- <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>--%>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" Visible="False">
        <contenttemplate>
<TABLE class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD align=right width="40%"></TD><TD><asp:DropDownList id="DropDownList_machine" runat="server" Visible="False" DataSourceID="SqlDataSource_Mechine" DataValueField="Machine_Id" DataTextField="Machine_Name"></asp:DropDownList> <asp:Button id="Button1" runat="server" Text="Go" Visible="False"></asp:Button> </TD></TR></TBODY></TABLE><asp:SqlDataSource id="SqlDataSource_Mechine" runat="server" SelectCommand="SELECT Machine_Id, Machine_Name FROM Lab_Machines" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"></asp:SqlDataSource> <asp:SqlDataSource id="SqlDataSource_machines_main_ID" runat="server" ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" SelectCommand="SELECT     PT_TestMessages.Pt_Message_Id, case when PT_TestMessages.Machine_Sample_No=Convert(varchar,Path_Result_Delivery.Main_ID) then  PT_TestMessages.Machine_Sample_No else  PT_TestMessages.Sample_No end as [Sample_No],Lab_Machines.Machine_Name, PT_TestMessages.Machine_Sample_No, &#13;&#10;                      Path_Result_Delivery.Main_ID&#13;&#10;FROM         PT_TestMessages INNER JOIN&#13;&#10;                      Lab_Machines ON PT_TestMessages.Machine_id = Lab_Machines.Machine_Id LEFT OUTER JOIN&#13;&#10;                      Path_Result_Delivery ON PT_TestMessages.Machine_Sample_No = Convert(varchar,Path_Result_Delivery.Main_ID) &#13;&#10;  WHERE (Lab_Machines.Machine_Id = @mID) and (PT_TestMessages.Status_Id=0) " ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>" UpdateCommand="UPDATE PT_TestMessages SET Sample_No = @Sample_No WHERE (Machine_Sample_No = @Sample_No)" InsertCommand="INSERT INTO [PT_TestMessages] ([Sample_No]) VALUES (@Sample_No)" DeleteCommand="DELETE FROM [PT_TestMessages] WHERE [Pt_Message_Id] = @Pt_Message_Id"><SelectParameters>
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

      <fieldset class="inner_content" style=" display:none; margin-top: 0.4em;"><table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" style="margin-top:5px;" style="display:none" >
           <tr style="display:none" >
               <td width="30%"    align="right">
                   MR # :</td>
               <td >
                   <asp:TextBox ID="TextBox_Mr_No" runat="server" Width="100px"></asp:TextBox></td>
                   </tr><tr>
               <td  align="right" style="display:none">
                   Visit # :</td>
               <td>
                   <asp:TextBox ID="TextBox_Visit_No" runat="server" Width="100px" style="display:none"></asp:TextBox>
                 <asp:Button ID="Button_Sesch" runat="server" Text="Seach" Width="60px" style="display:none"/>   <asp:TextBox ID="TextBox_Sample_No" runat="server" Width="150px" Visible="False"></asp:TextBox>             </td>
           </tr>
           
       </table> </fieldset>
    
    
    
    
     <div class="bxmain inner_content" style=" margin-top: 0.4em;"style="width:98%;">
         <h2>Search</h2>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right">Test Group :</td>
    <td><asp:DropDownList ID="DropDownList_Test_Group" runat="server" datasourceid="SqlDataSource_TG"
                    DataTextField="TGName" DataValueField="TGID" Width="150px" OnSelectedIndexChanged="DropDownList_Test_Group_SelectedIndexChanged"> </asp:DropDownList></td>
  </tr>
  <tr style="display:none">
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
      <asp:SqlDataSource ID="SqlDataSource_Status_Edit" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                                      ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" SelectCommand="SELECT Status, Status_ID FROM Test_Status WHERE (Priority < 2) AND (NOT (Priority IS NULL))"> </asp:SqlDataSource>
      <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Bind("ID", "{0}") %>' /></td>
  </tr>
        <tr>
    <td align="right">Consultant :</td>
    <td><asp:DropDownList ID="DDlConsultant" runat="server" datasourceid="SqlDataSource_Consultant"
                    DataTextField="EmpName" DataValueField="EmpID" Width="150px"> </asp:DropDownList></td>
  </tr>
  <tr>
     
    <td colspan="2" align="center"><asp:Button ID="Button_Draw" runat="server" Text="Draw" Width="50px" Visible="false" />
     
        <asp:LinkButton ID="LinkButton_Attach_Image" runat="server" CssClass="report" Visible="false">Attach Image</asp:LinkButton></td>
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
        <div id="Contents" style="width: 100%; display: none" runat="server">

        <fieldset class="inner_content" style=" margin-top: 0.4em;"><h2>Details</h2></fieldset>   
 
     <div class="bxmain" style="width:100%;    margin-bottom: 0.3em;">
 
    <table cellpadding="0" cellspacing="0" border="0"  class="tbl_form" 
              >
            <tr>
                <td align="right" width="25%" >
                    Perform Date :</td>
                <td  width="25%">
                  <igsch:webdatechooser id="WebDateChooser_Perform_Date" runat="server" CssClass="drop_date" Width="100px">
                      <CalendarLayout Culture="English (United Kingdom)">
                                                        </CalendarLayout>
                  </igsch:webdatechooser>
                </td>
                <td align="right"  width="25%" >
          Perform Time :</td>
                <td  width="25%">
                    <igtxt:webdatetimeedit id="WebDateTimeEdit_Perform_time" runat="server" editmodeformat="t" CssClass="drop_date" Width="100px"></igtxt:webdatetimeedit>
                </td>
            </tr>
        <tr>
                                <td align="right" width="25%">Attach Images :</td>
                                <td>
                                    <asp:FileUpload ID="FileUpload_pic" CssClass="input_txt" Width="250px" runat="server" />
                                </td>
                                <td align="left">
                                    <asp:Button CssClass="btn1" ID="btnSaveImage" runat="server" Text="Save" Width="112px" />
                                </td>
                            </tr>

            <tr style="display:none">
                <td align="right" style="position: relative;top: 4px;" valign="top" >
                    Duration :
                </td>
                <td valign="top" >
                <asp:TextBox ID="TextBox_Duration" runat="server" Width="65px"></asp:TextBox>
                    <asp:DropDownList ID="DropDownList_Duration_Type" runat="server" Width="80px">
                        <asp:ListItem Value="h">Hours</asp:ListItem>
                        <asp:ListItem Value="m">Minutes</asp:ListItem>
                    </asp:DropDownList>

                </td>
                <td align="right" style="position: relative;top: -7px;" valign="top" >
                    <br />
                    Any Complication :</td>
                <td >
                    <asp:TextBox ID="TextBox_any_Complication" runat="server" Height="21px" 
                        Width="200px" style="margin-top: 0px"></asp:TextBox></td>
          </tr>
        <tr style="display:none">
            <td colspan="4">
         <asp:Panel ID="Panel_image" runat="server"   Width="100%" Wrap="False">
                </asp:Panel>
            </td>
        </tr>
        </table>
         <fieldset class="inner_content" style=" margin-top: 0.4em; "Height="300px" >
              <INVC:InveestigationChartControl runat="server" ID="patientInvestigation" />
        </fieldset>


        <fieldset  class="inner_content" style=" margin-top: 0.4em; "><h2>Templates</h2>
                    <asp:TextBox  ID="TextBox_Radiology_templates1" runat="server" 
                Width="50%" AccessKey="t" Height="30px"></asp:TextBox>
                    <asp:Button  ID="Button_Radiology_templates" runat="server" 
                Text="Search" Width="75px" />
                        <strong __designer:mapid="b6" style="display:none"><asp:Button
        ID="Button_template_Insert" Visible="false" runat="server" CssClass="btn1" Text="Insert Template" /></strong>
            <br />
                        <strong style="display:none" __designer:mapid="b6">Template Name : <asp:TextBox 
                ID="TextBox_template_name" runat="server" Width="376px" ></asp:TextBox> 
                  <asp:Button ID="Button2" runat="server"  Text="Insert" style="display:none" /> 
                  <asp:Button
                            ID="Button_close_Template" runat="server" Text="Close" />
            <br />
            </strong>
            <br />
                    <asp:DropDownList ID="ListBox_Radiology_templates" runat="server" AutoPostBack="True"
                        DataSourceID="SqlDataSource_Radiology_templates" DataTextField="Templates_Name"
                        DataValueField="Templates_Description"  Width="98%"></asp:DropDownList>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource_Radiology_templates" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                        InsertCommand="INSERT INTO Radiology_templates(Templates_Name, Templates_Description, TB_ID) VALUES (@Templates_Name, @Templates_Description, @TB_ID)"
                        SelectCommand="SELECT Radiology_templates_ID, Templates_Name, Templates_Description, TB_ID FROM Radiology_templates WHERE (Templates_Name LIKE '%' + @Templates_Name + '%') AND (TB_ID = @TB_ID)">
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
                </fieldset>


      </div>
         

        <asp:Panel ID="Panel2"  runat="server"  Wrap="False" Width="100%" Direction="RightToLeft">
            <asp:LinkButton ID="LinkButton_PatientConsumption" runat="server" Visible="false">Patient Consumption</asp:LinkButton>
        
        </asp:Panel>
       
       <div style="position:absolute; margin-left:135px;"><asp:Label ID="Label_remarkstitle" runat="server" CssClass="err" style="margin-left:15px; font-weight:bold; line-height:25px; color:#a00593;" ></asp:Label><SPAN style="COLOR:#CCC;">&nbsp;&nbsp;|&nbsp;&nbsp;</SPAN>
       <asp:LinkButton runat="server" ID="print_report" CssClass="print_btn" style="float:right; margin-left:10px;;" Visible="false">Print Report</asp:LinkButton>
          &nbsp; 
           &nbsp; &nbsp; &nbsp;
           <input type="button" style="display:none" value="DICOM" onclick="OpenExe();" />
       </div>
       
        <div id="TabbedPanels1" class="TabbedPanels">
          <ul class="TabbedPanelsTabGroup" style="margin-left:10px;">
            
            <li style="  background: #617b78; color: white;" class="TabbedPanelsTab" tabindex="0">Remarks</li></ul>
            <li style="  background: #617b78; color: white; display:none; " class="TabbedPanelsTab" tabindex="0">Form1</li>
     
       
          <div class="TabbedPanelsContentGroup" style="height:auto;">
            <div class="TabbedPanelsContent"><asp:Panel ID="Panel1" runat="server" Width="100%">
                </asp:Panel> </div>
          
         <div class="TabbedPanelsContent">
         
    <table width="100%" border="0" cellspacing="0" cellpaddInfragistics2ing="0">
  <tr>
    <td width="100%" valign="top"> <asp:Label ID="Label_Description" runat="server" CssClass="err" Text="" Visible="False" ></asp:Label> 
        <CKEditor:CKEditorControl ID="TextBox_Description" BasePath="../ckeditor/" runat="server">
                     </CKEditor:CKEditorControl>
   <%-- <div class="clcc1Toolbar">
            <asp:TextBox ID="TextBox_Description" runat="server" Height="500px"  TextMode="MultiLine"  Width="100%" style="width:100%; " CssClass="remarksbox" ></asp:TextBox> 
                         <br /> 
         </div>  --%>
             <%--<asp:TextBox runat="server" id="TextBox_Description" Height="500px"  TextMode="MultiLine"  Width="100%" style="width:100%; " CssClass="remarksbox"></asp:TextBox>--%>
                         
                                   <%--<asp:TextBox ID="txtcc1" runat="server" Width="300" Height="200" />--%>
            <%--<cc1:Htmlcc1Extender ID="Htmlcc1Extender1" runat="server" TargetControlID="TextBox_Description">
            </cc1:Htmlcc1Extender>--%>
                                 

    </td>
    <td valign="top"> 
         <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td valign="top">
                    &nbsp;</td>
            </tr>
            <tr>
                <td valign="top" >
                    &nbsp;</td>
            </tr>
        </table></td>
  </tr>
</table>
     
         
        







</div>
         
         </div></div>
        
        

<br />


  <div align="center"  > 
<div align="center" style="margin-top:10px; display:inline-table; " >
   
    <asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" />&nbsp;
                  <asp:Button ID="ButtonFinal" runat="server" CssClass="btn1" Text="Approve" Width="105px" />
    <asp:Button ID="btnReject" runat="server" CssClass="btn1" Text="Not Approved" Width="150px" OnClick="btnReject_Click"/>
    <asp:LinkButton ID="LinkButton_Track" runat="server" CssClass="report" Visible="False">Audit History</asp:LinkButton>
    <asp:LinkButton ID="LinkButton_print_without_Header" runat="server" CssClass="print_btn" Style="width: 150px; background: #617b78;float: right;margin-left: 10px; color: white; padding: 0em 0em 2.1em 0em;border-radius: 3px; line-height: 2.2em;text-decoration: none; ">Report Without Header</asp:LinkButton>
    
    <asp:LinkButton ID="LinkButton_print" runat="server" CssClass="print_btn" Style="width: 150px; background: #617b78;float: right;margin-left: 10px; color: white; padding: 0em 0em 2.1em 0em;border-radius: 3px; line-height: 2.2em;text-decoration: none; display:none;">Report With Header</asp:LinkButton>
     <asp:Button ID="Button_update" runat="server" Text="Change Status" Width="105px" Visible="false"/> 
    <asp:LinkButton ID="LinkButton_Show_Report" runat="server" CssClass="btn_hacims" Height="25px"  ><span></span>Show Report</asp:LinkButton>
</div></div><br />
      
         </div>
      
        <asp:Panel ID="Panel_template" runat="server" Visible="False" Width="100%">
        <div class="bxmain">
          
          
            </div>
        </asp:Panel>
       
       
       
       
    </td>
  </tr>
</table>
 
     <asp:SqlDataSource ID="SqlDataSource_Consultant" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>" 
         SelectCommand="SELECT 0 AS EmpID, 'Select Consultant' AS EmpName UNION SELECT EmpID, ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS EmpName FROM BasicDataInfo.dbo.Employee WHERE (Is_Consultant = 1) AND (DeptID = 27)">
     </asp:SqlDataSource>

                  <asp:SqlDataSource ID="SqlDataSource_Status" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>" SelectCommand="pt_select_status"
                      UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE TB_ID =@TB_ID and  Main_ID =@Main_ID" SelectCommandType="StoredProcedure">
                      <UpdateParameters>
                          <asp:ControlParameter ControlID="HiddenField_Edit_Status" Name="Status" PropertyName="Value" />
                          <asp:ControlParameter ControlID="DropDownList_TestName" Name="TB_ID" PropertyName="SelectedValue" />
                          <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" />
                      </UpdateParameters>
                      <SelectParameters>
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                          <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                           <asp:QueryStringParameter Name="Status" QueryStringField="Status_Id" Type="Int32" />
                          <%--<asp:Parameter DefaultValue="Status" Name="Status" Type="Int32" />--%>
                          <asp:ControlParameter Name="TGID" ControlID="DropDownList_Test_Group" Type="String" PropertyName="SelectedValue" />
                          
                          <asp:ControlParameter Name="TB_ID" ControlID="DropDownList_TestName" Type="String" PropertyName="SelectedValue" />
                      </SelectParameters>
                  </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_TG" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT  Test_Status.Status, CONVERT(varchar, Path_Result_Delivery.Sample_Collection_Date, 107) AS Date_Time, Admin_Service_Category.Asc_Name as TGName, TestGroup.TGID,  Test_Main_Sub_Grouping.MS_TGID, Path_Result_Delivery.Main_ID, Test_Status.Status_ID FROM   Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID inner join Admin_Services on Admin_Services.S_ID=Test_Booking.S_ID  INNER JOIN Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID inner join Admin_Service_Category on Admin_Service_Category.Asc_id=Admin_Services.S_Category  LEFT OUTER JOIN Test_Main_Sub_Grouping ON TestGroup.TGID = Test_Main_Sub_Grouping.TGID WHERE  (Test_Status.Status_ID = @Status) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Main_ID = @Main_ID) ">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
            <asp:QueryStringParameter Name="Status" QueryStringField="status_id" Type="Int32" />
            
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
        InsertCommand="insert_lab_status_record" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status  WHERE (Main_ID = @Main_ID) AND (TB_ID = @TB_ID) ">
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
    
    <asp:SqlDataSource ID="SqlDataSource_Group" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT &#13;&#10;                      &#13;&#10;                      TestGroup.TGName, TestGroup.TGID&#13;&#10;FROM         Investigation_Order_Sub INNER JOIN&#13;&#10;                      Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID RIGHT OUTER JOIN&#13;&#10;                      Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN&#13;&#10;                      Test_Main_Sub_Grouping ON TestGroup.TGID = Test_Main_Sub_Grouping.TGID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID ON Investigation_Order_Sub.TB_ID = Test_Booking_Services.TB_ID AND &#13;&#10;                      Investigation_Order_Main.RegNo = Path_Result_Delivery.Reg_no AND Investigation_Order_Main.YearlyNo = Path_Result_Delivery.Yearly_No&#13;&#10;WHERE     (Test_Status.Status_ID = @Status) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND &#13;&#10;                      (Path_Result_Delivery.Main_ID = @Main_ID)">
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
    
    <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
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
    <asp:SqlDataSource ID="SqlDataSource_Message" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
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
    <asp:SqlDataSource ID="SqlDataSource_machine_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
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
                  <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" UpdateCommand="UPDATE PatientsLabTest SET Status = @Status WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
                      <UpdateParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                           <asp:ControlParameter ControlID="HfTestStatus" Name="Status" PropertyName="Value"/>
                         <%-- <asp:Parameter DefaultValue="6" Name="Status" />--%>
                          <asp:SessionParameter DefaultValue="" Name="PayID" SessionField="YearlyNo" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_Update_Status" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" UpdateCommand="Update_Patient_Test_Status_consultant" UpdateCommandType="StoredProcedure">
                      <UpdateParameters>
                          <asp:ControlParameter ControlID="HfTestStatus" Name="Status" PropertyName="Value"/>
                          <%--<asp:Parameter DefaultValue="10" Name="Status" />--%>
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                          <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value"
                              Type="Int32" />
                          <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                          <asp:SessionParameter Name="approve_by" SessionField="emp_id" Type="Int32" />
                         <asp:ControlParameter ControlID="DDlConsultant" PropertyName="SelectedValue" Name="consultant"></asp:ControlParameter>
                          <asp:Parameter DefaultValue="" Name="Consultant_Remarks" Type="String" />
                          <asp:Parameter DefaultValue="true" Name="Consultant_Status" Type="Boolean" />
                          <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                          <asp:ControlParameter ControlID="TextBox_Description" DefaultValue="" Name="Report" PropertyName="Text" Type="String" />
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

        <asp:SqlDataSource ID="SqlDataSource_Track" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
            ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" SelectCommand="Path_PatientTestResult_Track"
            SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="Reg_No" QueryStringField="Reg_No" Type="String" />
                <asp:QueryStringParameter Name="Yearly_No" QueryStringField="YearlyNo" Type="Decimal" />
                <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Decimal" />
                <asp:QueryStringParameter Name="TB_ID" QueryStringField="TBID" type="Decimal" />
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

        <asp:SqlDataSource ID="SqlDataSource_Missing_Component" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
            ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" SelectCommand="Missing_Component"
            SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="Reg_No" QueryStringField="Reg_No" Type="String" />
                <asp:QueryStringParameter Name="Yearly_No" QueryStringField="YearlyNo" Type="Decimal" />
                <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Decimal" />
            </SelectParameters>
        </asp:SqlDataSource>
       <div align="center"> <asp:Button ID="Button_Missing_Component" runat="server" Text="Close" /></div>
       <br />

       
       </asp:Panel>

    <asp:panel id = "pnlRemarks" runat = "Server" CssClass = "lightbox_bg" Visible = "false">
<div class = "lightbox">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Remarks For Not-Approved</span></h2>

        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
            <tr>
                <td width="20%" align="right">Remarks :  </td>
                <td> 
                   <asp:TextBox ID="txtRemraks" runat="server" Width="400px" TextMode="MultiLine" Height="100px"></asp:TextBox>
                </td>
        </tr>
            <tr>
                <td width="20%" align="right"></td>
                <td> 
                   <asp:Button ID="btnSaveRemarks" runat="server" Text="Revert To Reporting" OnClick="btnSaveRemarks_Click"/>
                    <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click"/>
                </td>
        </tr>
  </table>
        </div>
</div>

</asp:panel>

    <asp:SqlDataSource ID="sdsRemarks" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" InsertCommand="usp_InsertNotApprovedRemarks" InsertCommandType="StoredProcedure">
                      <InsertParameters>
                          <asp:QueryStringParameter Name="MainId" QueryStringField="Main_ID"/>
                          <asp:QueryStringParameter Name="TBID" QueryStringField="TB_ID"/>
                          <asp:ControlParameter ControlID="DDlConsultant" Name="EnterBy" PropertyName="SelectedValue"/>
                          <asp:ControlParameter ControlID="txtRemraks" Name="Details" PropertyName="text"/>
                      </InsertParameters>
                  </asp:SqlDataSource>

<script type="text/javascript">
var cookies = Spry.Utils.Cookie("read","tabbedpanels_tb2");
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
Spry.Utils.addUnLoadListener(function(){
    // save the current value
    Spry.Utils.Cookie('create','tabbedpanels_tb2',TabbedPanels1.getCurrentTabIndex());
});
</script>

    <asp:HiddenField ID="HiddenField_flag" runat="server" />
    <asp:HiddenField ID="HfTestStatus" runat="server"/>






  </asp:Content>