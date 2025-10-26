
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>



<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_Physical_Examination_Main_HeadForIframe.aspx.vb"
    ValidateRequest="false"  Inherits="Pt_EMR_Pt_Physical_Examination_Main_HeadForIframe" %>

  <html xmlns="http://www.w3.org/1999/xhtml">
 
 <!doctype html>
 

<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
     <link href="../resources/css/hacimsnew_styles.css??" rel="stylesheet" type="text/css" />
     <script src="../resources/js/jquery-3.4.1.min.js"></script>
  
 
    <script language="javascript" type="text/javascript">
        function ShowPanel(Control_ID) {
            document.getElementById("ctl00_ContentPlaceHolder1_HiddenFieldTextOther").value = Control_ID;
            document.getElementById('ctl00_ContentPlaceHolder1_Div_Text').style.visibility = 'visible';
            //document.getElementById('Div_Text').style.left=event.clientX-100;
            document.getElementById('ctl00_ContentPlaceHolder1_Div_Text').style.top = event.clientY - 100;
            document.getElementById("ctl00_ContentPlaceHolder1_TextBox1").value = document.getElementById(Control_ID).value;
        }
        function Show_Text_Value() {
            var id = document.getElementById("ctl00_ContentPlaceHolder1_HiddenFieldTextOther").value;
            var text = document.getElementById("ctl00_ContentPlaceHolder1_TextBox1").value;
            if (id != "") {
                document.getElementById(id).value = text;
            }
            document.getElementById("ctl00_ContentPlaceHolder1_HiddenFieldTextOther").value = "";
        }
        function showGrowthChart(elem) {            
            var chartId = $.trim($(elem).next().val ());
            window.open("../Patient%20Billing/PatientGrwothChart.aspx?ChartId=" + chartId);
        }
    </script>
    
    
    
    <script type="text/javascript">
        $(document).ready(function () {
            
        });
    </script>
    <script type="text/javascript">       
	
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
    
      </head>
    <body>

<form id="form1" runat="server">

 <div class="small_tabs_cnt">
     <ul class="small_tabs">
        <li><a href="#" class="first active" id="show_Form" >Form</a></li>        
        <li><a href="#" class="last" id="show_Remarks">Remarks</a></li>
        </ul>
     </div> 
      <br>
 <div id="cnt_Form">
                <asp:Label ID="Label_message" runat="server"></asp:Label>
                 
                                <div style="padding: 2px 0 20px 20px; display:none;">
                                    <div style="color: Green; font-size: 13px; font-weight: bold; border-bottom: solid 1px #ccc;width:100px;
                                        padding-bottom: 3px;">Growth Charts</div>
                                        <div style="padding-top:10px;">
                                    <asp:DataList ID="dlCharts" runat="server" RepeatDirection="Horizontal">
                                        <ItemTemplate>
                                            <asp:Label ID="lblChart" runat="server" Text='<%# Bind("ChartName") %>' onclick="showGrowthChart(this)"
                                                Style="color: Blue; font-size: 12px; font-weight: bold; cursor: pointer; padding-right: 20px;"></asp:Label>
                                            <asp:HiddenField ID="hdnChartId" runat="server" Value='<%# Bind("ChartId") %>' />
                                        </ItemTemplate>
                                    </asp:DataList>
                                    </div>
                                </div>
                               
                               
                                
                                
                                
                                
                                
                                
                                            <asp:Panel ID="Panel1" runat="server" Width="100%">
                                            
                                            </asp:Panel>
                                            
                                            
                                            
                                            <asp:DataList ID="DataListtemplate" runat="server" DataKeyField="Template_id" DataSourceID="SqlDataSourceTemplate"
                                                RepeatColumns="5" RepeatDirection="Horizontal" Style="position: static" Width="100%"
                                                Visible="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" CssClass="login_link"
                                                        ForeColor="Blue" Style="position: static" Text='<%# Eval("Template_Name", "{0}") %>'></asp:LinkButton>
                                                </ItemTemplate>
                                                <SeparatorStyle BorderWidth="1px" CssClass="griditem" />
                                            </asp:DataList><asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                                SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)"
                                                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                                                    <asp:SessionParameter Name="deptid" SessionField="dept_id" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        
                                        
                                        
                                        
                                        </div>
                                        
                                          <div id="cnt_Remarks" style="display:none;"> 
                                      
                                                        <asp:TextBox ID="TextBox_Remarks" runat="server" Height="150px" Width="98%" TextMode="MultiLine"></asp:TextBox>
                                                   
                                                        <asp:Label ID="Label_Select_All" runat="server" Visible="False">find</asp:Label>
                                                       
                                                       
                                                        <asp:DataList ID="DataList_remarks" runat="server" DataSourceID="SqlDataSource_select_all"
                                                            Width="98%" Style="margin-left: 2px;">
                                                            <ItemTemplate>
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" style="border-bottom: #CCC dotted 1px;">
                                                                    <tr>
                                                                        <td style="padding-bottom: 5px;">
                                                                            <strong>
                                                                                <asp:Label ID="Complaint_NameLabel" runat="server" Text='<%# Eval("MH_Heading") %>'></asp:Label></strong><br />
                                                                            <asp:LinkButton ID="LinkButton_Description" runat="server" CommandName="Select" CssClass="linkc"
                                                                                Text='<%# Eval("Remarks") %>'></asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <asp:HiddenField ID="HiddenField_Complaint_ID" runat="server" Value='<%# Eval("MH_Code", "{0}") %>' />
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                    
                                                    
                                                    
                <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                    SelectCommand="SELECT DISTINCT Admin_Exam_Main_Heading.MH_Heading, Admin_Exam_Main_Heading.Priority, Admin_Exam_Main_Heading.MH_Code FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code WHERE (Admin_Exam_MainHeading_Group.Mg_Code IN (SELECT MainGroup_Id FROM Admin_Template_phy_Elements WHERE (Template_Id = @Template_Id))) AND (Admin_Exam_Main_Heading.Dept_id = @detp_id) ORDER BY Admin_Exam_Main_Heading.Priority"
                    ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenFieldTemplate_id" Name="Template_Id" PropertyName="Value" />
                        <asp:SessionParameter Name="detp_id" SessionField="dept_id" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_select_all" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    InsertCommand="Insert_Patient_Complaint_out" InsertCommandType="StoredProcedure"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="SELECT ISNULL(OPD_Encounter_Form_Remarks.Remarks, '') AS Remarks, Admin_Exam_Main_Heading.MH_Heading, Admin_Exam_Main_Heading.MH_Code FROM OPD_Encounter_Form_Remarks INNER JOIN Admin_Exam_Main_Heading ON OPD_Encounter_Form_Remarks.MH_Code = Admin_Exam_Main_Heading.MH_Code WHERE (OPD_Encounter_Form_Remarks.Yearly_No = @YearlyNo) and Type_val='PHY'">
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
                <asp:SqlDataSource ID="SqlDataSource_OPD_Encounter_Form_Remarks" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                    DeleteCommand="DELETE FROM [OPD_Encounter_Form_Remarks] WHERE [Reg_No] = @Reg_No AND [Yearly_No] = @Yearly_No AND [MH_Code] = @MH_Code"
                    InsertCommand="OPD_Encounter_Form_Remarks_Insert" InsertCommandType="StoredProcedure"
                    SelectCommand="SELECT  [Remarks] FROM [OPD_Encounter_Form_Remarks] where [Reg_No]=@Reg_No and  [Yearly_No]=@Yearly_No and [MH_Code]=@MH_Code and Type_Val='PHY'"
                    UpdateCommand="UPDATE [OPD_Encounter_Form_Remarks] SET [Remarks] = @Remarks WHERE [Reg_No] = @Reg_No AND [Yearly_No] = @Yearly_No AND [MH_Code] = @MH_Code">
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
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                    DataSourceID="SqlDataSourceSaveValue" Width="95%">
                    <Columns>
                        <asp:BoundField DataField="e_Name" HeaderText="Element" SortExpression="e_Name" />
                        <asp:BoundField DataField="Exam_Result" HeaderText="Value" SortExpression="Exam_Result" />
                        <asp:BoundField DataField="Time" HeaderText="Date Time" SortExpression="Time" />
                    </Columns>
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <br />
               
                    <asp:SqlDataSource ID="SqlDataSourceSaveValue" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="SELECT Pt_physical_exam_saveRecord.Exam_Result, admin_Phy_Exam_Elements.e_Name, Pt_physical_exam_saveRecord.Time FROM Pt_physical_exam_saveRecord INNER JOIN Admin_Exam_MainHeading_Group ON Pt_physical_exam_saveRecord.body_system_Id = Admin_Exam_MainHeading_Group.Mg_Code INNER JOIN admin_Phy_Exam_Elements ON Pt_physical_exam_saveRecord.E_ID = admin_Phy_Exam_Elements.e_Code WHERE (Pt_physical_exam_saveRecord.YearlyNo = @YearlyNo) AND (Pt_physical_exam_saveRecord.RegNo = @RegNo) AND (Pt_physical_exam_saveRecord.Ele_Status = 0) AND (Admin_Exam_MainHeading_Group.MH_Code = @MH_Code) ORDER BY admin_Phy_Exam_Elements.e_Name, Pt_physical_exam_saveRecord.Time DESC">
                        <SelectParameters>
                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                            <asp:ControlParameter ControlID="ListBox1" Name="MH_Code" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                    <asp:HiddenField ID="HiddenField3" runat="server" Value="0" />
                    <asp:HiddenField ID="HiddenFieldTemplate_id" runat="server" />
               
                <asp:HiddenField ID="HiddenFieldTextOther" runat="server" />
                <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceMainGroup"
                    DataTextField="MH_Heading" DataValueField="MH_Code" Height="222px" Width="96%"
                    Visible="False"></asp:ListBox>
                <br />
                
                <div style="width: 20%; float: left; clear: right;">
                    &nbsp;
                    <div id="Div_Text" style="border-right: #999999 3px solid; padding-right: 10px; border-top: #999999 3px solid;
                        padding-left: 10px; z-index: 100; left: 552px; visibility: hidden; padding-bottom: 10px;
                        border-left: #999999 3px solid; width: 250px; padding-top: 10px; border-bottom: #999999 3px solid;
                        position: absolute; top: 72px; height: 100px; background-color: #ffffff">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="right">
                                    <asp:Button ID="Button1" runat="server" CssClass="btn_close" Text="" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt" Height="88px" TextMode="MultiLine"
                                        Width="100%"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                  
                </div>
                   
            </div>
            <div align="center">
                    <asp:Button ID="Button_Save" runat="server" Text="Save" />
                     </div>
    <asp:Label ID="LabelFooter" runat="server" Visible="false"  Text=""></asp:Label>
    </form>
      

 </body>
 </html> 