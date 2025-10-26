<%@ Page Language="VB" AutoEventWireup="false" validateRequest="false" 
    CodeFile="pt_History_Main_HeadingForIframe.aspx.vb"    Inherits="Pt_EMR_pt_History_Main_HeadingForIframe" %>
 <%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <!doctype html>
<html>

<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
     <link href="../resources/css/hacimsnew_styles.css??" rel="stylesheet" type="text/css" />
     <script src="../resources/js/jquery-3.4.1.min.js"></script>
    </head>
    <body>
 
<script language="javascript" type="text/javascript">
function ShowPanel(Control_ID)
{
   document.getElementById("ctl00_ContentPlaceHolder1_HiddenFieldTextOther").value=Control_ID;
   document.getElementById('Div_Text').style.visibility = 'visible';
   //document.getElementById('Div_Text').style.left=event.clientX-100;
   document.getElementById('Div_Text').style.top=event.clientY-100;
   document.getElementById("ctl00_ContentPlaceHolder1_TextBox1").value=document.getElementById(Control_ID).value;
}
function Show_Text_Value()
{
    var id =document.getElementById("ctl00_ContentPlaceHolder1_HiddenFieldTextOther").value;
    var text=document.getElementById("ctl00_ContentPlaceHolder1_TextBox1").value;
    if (id!="")
    {
        document.getElementById(id).value=text;
    }
    document.getElementById("ctl00_ContentPlaceHolder1_HiddenFieldTextOther").value="";
}

</script>

 
	
	
<script type="text/javascript">

$(document).ready(function(){

  		$(document).on("click","#show_Form",function(e){
		  
		  	  e.preventDefault();
			   			 $("#cnt_Remarks").hide(); 
						 $("#cnt_Form").show(); 
						 $("#show_Remarks").removeClass('active');
			 			 $(this).addClass('active');	
		      });
		$(document).on("click","#show_Remarks",function(e){
		  
		  	  e.preventDefault();
			   			 $("#cnt_Form").hide(); 
						 $("#cnt_Remarks").show(); 
						 $("#show_Form").removeClass('active');
			 			 $(this).addClass('active');	
		      });	  

});

  
</script>
 

<style type="text/css">

body { background:#fff; }

 .small_tabs_cnt {text-align:center; background:red1; width:100%; height:32px; display:block;}
	  .small_tabs { list-style:none; width:auto;    }
	  .small_tabs li { float:left1;     list-style:none; height:35px; width:auto; display:inline-block; }
	  .small_tabs li a {    height:30px; display:block; padding-left:15px; padding-right:15px; line-height:30px; text-align:center; color:#555; font-weight:bold; border:#ccc solid 1px; text-decoration:none; font-size:14px; background-image: linear-gradient(#fff 10%, #eaeaea); margin-right:-3px;    }
	   .small_tabs li a.active { background:#006dae; color:#fff; box-shadow:inset 0px 0px 12px #00253c;     }
	   
	   
	  .small_tabs li a.first { border-bottom-left-radius:25px;  border-top-left-radius:25px; border-right:rgba(255,255,255,.2) solid 1px;    }
	 .small_tabs li a.last { border-bottom-right-radius:25px;  border-top-right-radius:25px;  border-left:rgba(255,255,255,.2) solid 1px;     }
		
</style>
 
    
 
<form id="form1" runat="server">
   
      <div class="small_tabs_cnt">
     <ul class="small_tabs">
        <li><a href="#" class="first active" id="show_Form" >Form</a></li>        
        <li><a href="#" class="last" id="show_Remarks">Remarks</a></li>
        </ul>
     </div> 
      <br>

          <asp:Panel ID="Panel2" runat="server" Visible="False"></asp:Panel> 
         
         <asp:Label ID="Label_message" runat="server" ></asp:Label>
       
       
       
               
  			 <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
          
          <asp:DataList ID="DataListtemplate" runat="server" DataKeyField="Template_id" datasourceid="SqlDataSourceTemplate"
            RepeatColumns="5" RepeatDirection="Horizontal" Visible="False" >
            <itemtemplate>
              <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" CssClass="login_link"
                    ForeColor="Blue"  Text='<%# Eval("Template_Name", "{0}") %>'></asp:LinkButton>
            </itemtemplate>
            <SeparatorStyle BorderWidth="1px" CssClass="griditem" />
          </asp:DataList>
          
           <div id="cnt_Form">
          <asp:Panel ID="Panel_history" runat="server" Width="100%">
            </asp:Panel>
          <asp:Panel ID="Panel1" runat="server" Width="100%">
            </asp:Panel> 
            
            </div>
            
            
            <div id="cnt_Remarks" style="display:none;"> 
            
                            <asp:TextBox ID="TextBox_Remarks" runat="server" Height="150px" Width="100%" TextMode="MultiLine"></asp:TextBox>
                       
        
                            <asp:Label ID="Label_Select_All" runat="server" ></asp:Label>
                            <asp:DataList ID="DataList_remarks" runat="server" DataSourceID="SqlDataSource_select_all" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="Complaint_NameLabel" runat="server" Text='<%# Eval("MH_Heading") %>'></asp:Label><br />
                                    <asp:LinkButton ID="LinkButton_Description" runat="server" CommandName="Select" Text='<%# Eval("Remarks") %>'></asp:LinkButton>
                                    <asp:HiddenField ID="HiddenField_Complaint_ID" runat="server" Value='<%# Eval("MH_Code", "{0}") %>' />
                                </ItemTemplate>
                            </asp:DataList>
                          
            </div>
    
         
       
<div align="center"><br /><asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" Visible="False" style="margin-top:12px;"  /></div>
    
         

         <asp:SqlDataSource ID="SqlDataSource_OPD_Encounter_Form_Remarks"
                    runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                    DeleteCommand="DELETE FROM [OPD_Encounter_Form_Remarks] WHERE [Reg_No] = @Reg_No AND [Yearly_No] = @Yearly_No AND [MH_Code] = @MH_Code"
                    InsertCommand="OPD_Encounter_Form_Remarks_Insert" InsertCommandType="StoredProcedure"
                    SelectCommand="SELECT  [Remarks] FROM [OPD_Encounter_Form_Remarks] where [Reg_No]=@Reg_No and  [Yearly_No]=@Yearly_No and [MH_Code]=@MH_Code and type_val='HIS'"
                    UpdateCommand="UPDATE [OPD_Encounter_Form_Remarks] SET [Remarks] = @Remarks WHERE [Reg_No] = @Reg_No AND [Yearly_No] = @Yearly_No AND [MH_Code] = @MH_Code">
                    <SelectParameters>
                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                        <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" />
                        <asp:ControlParameter ControlID="HiddenField_MG_CODE" Name="MH_Code" PropertyName="Value" />
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
                        <asp:ControlParameter ControlID="HiddenField_MG_CODE" Name="MH_Code" PropertyName="Value"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_Remarks" Name="Remarks" PropertyName="Text"
                            Type="String" />
                        <asp:Parameter DefaultValue="HIS" Name="type" />
                    </InsertParameters>
                </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=nabeel-pc;Initial Catalog=Treatment;User ID=sa;Password=123;Max Pool Size=2000;"
            InsertCommand="Insert_Patient_Complaint_out" InsertCommandType="StoredProcedure"
            ProviderName="System.Data.SqlClient" SelectCommand="SELECT  Pt_Presenting_Complaint_saveRecord.Description,Admin_Complaint_MainGroup.Complaint_Name  FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @YearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo)">
            <SelectParameters>
                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
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
          
           
              <asp:SqlDataSource ID="SqlDataSource_select_all" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                  InsertCommand="Insert_Patient_Complaint_out" InsertCommandType="StoredProcedure"
                  ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="SELECT OPD_Encounter_Form_Remarks.Remarks, Admin_History_Main_Heading.MH_Heading, Admin_History_Main_Heading.MH_Code FROM OPD_Encounter_Form_Remarks INNER JOIN Admin_History_Main_Heading ON OPD_Encounter_Form_Remarks.MH_Code = Admin_History_Main_Heading.MH_Code WHERE (OPD_Encounter_Form_Remarks.Reg_No = @RegNo) AND (OPD_Encounter_Form_Remarks.Yearly_No = @YearlyNo) and type_val='HIS'">
                  <SelectParameters>
                      <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                      <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
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
              
      

          <asp:GridView ID="GridViewSaveValue" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        DataSourceID="SqlDataSourceSaveValues" Width="100%">
            <columns>
            <asp:BoundField DataField="e_Name" HeaderText="Element" SortExpression="e_Name" />
            <asp:BoundField DataField="ev_Code" HeaderText="Value" SortExpression="ev_Code" />
            <asp:BoundField DataField="DateTme" HeaderText="Date Tme" SortExpression="DateTme" />
            </columns>
            <headerstyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
          </asp:GridView>
          <asp:SqlDataSource ID="SqlDataSourceSaveValues" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        SelectCommand="SELECT     admin_History_Elements.e_Name, Pt_history_SaveRecord.ev_Code, Pt_history_SaveRecord.DateTme, &#13;&#10;                      Admin_History_Elememt_Assign_To_Group.MG_Code, Admin_History_MainHeading_Group.MH_Code, &#13;&#10;                      Admin_History_MainHeading_Group.Mg_Code AS Expr1&#13;&#10;FROM         Pt_history_SaveRecord INNER JOIN&#13;&#10;                      admin_History_Elements ON Pt_history_SaveRecord.e_Code = admin_History_Elements.e_Code INNER JOIN&#13;&#10;                      Admin_History_Elememt_Assign_To_Group ON Pt_history_SaveRecord.e_Code = Admin_History_Elememt_Assign_To_Group.e_Code AND &#13;&#10;                      Pt_history_SaveRecord.MG_Code = Admin_History_Elememt_Assign_To_Group.MG_Code INNER JOIN&#13;&#10;                      Admin_History_MainHeading_Group ON Pt_history_SaveRecord.MG_Code = Admin_History_MainHeading_Group.Mg_Code&#13;&#10;WHERE     (Pt_history_SaveRecord.YearlyNo = @YearlyNo) AND (Pt_history_SaveRecord.RegNo = @RegNo)AND &#13;&#10;                      (Admin_History_MainHeading_Group.MH_Code = @MH_Code) AND (Pt_history_SaveRecord.Ele_Status = 0)&#13;&#10;ORDER BY admin_History_Elements.e_Name, Pt_history_SaveRecord.DateTme DESC">
            <SelectParameters>
              <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
              <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
              <asp:ControlParameter ControlID="ListBox1" Name="MH_Code" PropertyName="SelectedValue" />
            </SelectParameters>
          </asp:SqlDataSource>
       
          <asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
            SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)
and (Admin_Assign_Template.dept_id = @deptid)" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
            <SelectParameters>
              <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
              <asp:SessionParameter Name="deptid" SessionField="dept_id" />
            </SelectParameters>
          </asp:SqlDataSource>
          <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
          <asp:HiddenField ID="HiddenField3" runat="server" />
         
         
         
          <div align="center" class="popdes"   id="Div_Text" style="display:none;">
             
          
              <asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt"  Height="88px" TextMode="MultiLine" Width="100%"></asp:TextBox>
                  <asp:Button ID="Button1" runat="server" Text="Close" CssClass="btn_close" ></asp:Button>  
               
          </div>
          
          
          
          
          <asp:HiddenField ID="HiddenFieldTextOther" runat="server" />
          <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
            SelectCommand="SELECT DISTINCT Admin_History_Main_Heading.MH_Heading, Admin_History_Main_Heading.Priority, Admin_History_Main_Heading.MH_Code FROM Admin_History_Main_Heading INNER JOIN Admin_History_MainHeading_Group ON Admin_History_Main_Heading.MH_Code = Admin_History_MainHeading_Group.MH_Code WHERE (Admin_History_MainHeading_Group.Mg_Code IN (SELECT MainGroup_Id FROM Admin_Template_History_Elements WHERE (Template_Id = @Template_Id))) AND (Admin_History_Main_Heading.Dept_id = @Dept_id) ORDER BY Admin_History_Main_Heading.Priority" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
            <SelectParameters>
              <asp:ControlParameter ControlID="HiddenFieldTemplate_ID" Name="Template_Id" PropertyName="Value" />
              <asp:SessionParameter Name="Dept_id" SessionField="dept_id" />
            </SelectParameters>
          </asp:SqlDataSource>
          <asp:HiddenField ID="HiddenFieldTemplate_ID" runat="server" />
          <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField_MG_CODE" runat="server" />
          <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSourceMainGroup" Visible="False"> </asp:GridView>
          <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" datasourceid="SqlDataSourceMainGroup"
            DataTextField="MH_Heading" DataValueField="MH_Code" Height="222px" Width="96%" Visible="False"></asp:ListBox>
          <asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
         
  
<asp:Label ID="LabelFooter" runat="server" Text="" Visible="false"></asp:Label>
 </form>   
 

 </body>
 </html> 