<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_Plan.aspx.vb" MasterPageFile="~/hacims_masterpage.master"
    Inherits="Pt_EMR_Pt_Plan" ValidateRequest="false" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

<link rel="stylesheet" href="../resources/js/jquery.mCustomScrollbar.css??" />
	<script src="../resources/js/jquery.mCustomScrollbar.concat.min.js"></script>


    <script type="text/javascript">
	
		  $(document).ready(function () {
			  
			    $(".leftMenu_Divcnt").mCustomScrollbar({ axis:"y",theme:"minimal-dark" });
			  
	
        function picture() {
            window.open("mlc_mainpic.aspx?reg={0}&yno={1}");
        }
		
		$(document).on("click",".mainpage_tabs li a",function(e){
		  
		  	e.preventDefault();
			$('.mainpage_tabs li a').removeClass('active');
			$(this).addClass('active');
			var thisId = $(this).attr('id').split('_')[0];			 
			$('.hideall').hide();
			$('#'+thisId+'_content').show();
			 
		 
		     });  
			  
		 //var pageheight = $(document).height();
		//  $('.slideLeftMenu').height(pageheight+100);
		  
		  
			 
			  
		
		 });  
    </script>

<style type="text/css">

.tbl_nborder {border:0;  }
.tbl_nborder td { border:0;   }
.tbl_nborder tr {  border-bottom:#ccc dotted 1px; margin-bottom:5px; padding-top:5px; padding-bottom:5px; display:block;  }
.tbl_nborder td a {  background:url(../resources/images/img_notes.svg) 0px 3px no-repeat; background-size:12px 12px; padding-left:15px;     }
  .main_bx { margin-top:0px !important; }

</style>
     

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div id="lightbox_bgm"></div>
<div class="slideLeftMenu"><div id="menuScroll"><asp:Label ID="LabelSideMenu" runat="server" Visible="true"></asp:Label></div></div>

<div class="main_bx">
          <div class="leftMenu_div" style="margin-top:47px;">
     		 <div class="leftMenu_divcnt"></div>
   	 </div><!--leftMenu_div-->
 		 <div class="pageContent" style="width:100%; padding-left:230px; box-sizing:border-box;">


 
                <asp:Panel ID="Panel1" runat="server" Visible="False">
                </asp:Panel>
                
                
         <div id="viewNotes_content" class="hideall">
         
          <div class="bx_left">
          
          <div class="bx_01" style="width:100%; float:none; margin-left:0px; margin-top:0px; min-height:300px; height:300px; ">  
          <h3>View Physician Notes</h3>
         
          <div style="overflow:auto; overflow-x:hidden; width:100%; height:100%; display:block;">
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_pt_Treatment_Plan"
                                        Width="100%" DataKeyNames="Plan_id" SkinId="tbl_nborder">
                                        <Columns>
                                            <asp:TemplateField>
                                           
                                                <ItemTemplate>
                                          
                                           
           <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CommandArgument='<%# Eval("Date") %>' OnClick="LinkButton1_Click1" Text='<%# Eval("Date", "{0:g}") %>'></asp:LinkButton><span class="spltr"> | </span><asp:Label ID="Label1" runat="server" Style="font-weight:bold;"  ToolTip="Physician" Text='<%# Eval("[Physician Name]", "{0}") %>'></asp:Label><span class="spltr"> | </span><asp:Label ID="Label2" Style="color:#529fed;" runat="server" ToolTip="Department" Text='<%# Eval("Department") %>'></asp:Label> 
  
                                                                 
  <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Plan_Detail") %>' />
                                         
                                                </ItemTemplate>
                                                
                                                <HeaderStyle CssClass="hide" />
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>
                                    </div>
         </div>
        </div>
        
        <div class="bx_right">
        <div class="bx_01" style="width:100%; float:none; margin-left:0px; margin-top:0px; min-height:300px; ">  
          <h3>Add Physician Notes</h3>
         <span class="smargin"></span>
         <asp:TextBox ID="WebHtmlEditor1" CssClass="remarksbox" runat="server" Height="100%"   TextMode="MultiLine"
        Width="100%"></asp:TextBox>
         <br />
         <div align="center">
                                    <asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Save" OnClick="Button1_Click" />
                                    <asp:Button ID="Button2" runat="server" Text="Detail Report" Visible="false" />
                                </div>
                                <br />
                                  <asp:Button ID="btn_transfer" runat="server" Text="Transfer to Ward"
                                    Visible="False" /><br />
        
        
        </div>
        </div>
        
        </div>       
                
         <div id="addNotes_content" class="hideall" style="display:none;">
            			
                       
                        
                        
            		 <br />

                                
                               
         </div>    

					<div class="bx_rad" style="width: 100%; display:none; ">
                    <ul id="CollapsiblePanel1">
                        <li><strong>&nbsp;View Patient Report</strong></li>
                        <li>
                            <div style="background: #fff; overflow: auto; overflow-x: hidden; width: 100%; height: 250px;">
                                <iframe width="100%" height="100%" frameborder="0" src="../PatientFaceSheet.aspx"></iframe>
                            </div>
                        </li>
                    </ul>
                </div>
                
           <div class="drop_doiwn" style="width:100%; display:none;">
                    <div class="in_drop_doiwn" style="width:60%;padding-left: 40%;padding-top:5px;">
                        <asp:DropDownList ID="DropDownList1" runat="server" Width="250px" AutoPostBack="True"
                            DataSourceID="SqlDataSource1" DataTextField="physicianNotes_Category" DataValueField="ID">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                            SelectCommand="SELECT [ID], [physicianNotes_Category] FROM [physician_Instruction]"></asp:SqlDataSource>
                        <asp:HiddenField ID="HF_physician_category_notes" runat="server" />
                    </div>
                    <!--in_drop_doiwn-->
                </div>
                <!--drop_doiwn -->      
            
                <asp:Panel Style="left: 38%; top: 50%" ID="Panel2" runat="server" CssClass="lightbox"
                                Width="75%" Visible="False">
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                <asp:DropDownList ID="DropDownListFloor" runat="server" CssClass="dropbox" Width="250px"
                                    DataValueField="Ward_id" DataTextField="Ward_Name" DataSourceID="SqlDataSourceFloor">
                                </asp:DropDownList>&nbsp;&nbsp;<br />
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<asp:Button ID="btn_shift" runat="server"
                                    Text="Shift" Width="50px" Visible="False"></asp:Button>
                                <asp:Button ID="btn_cancel" runat="server" Text="cancel" Width="70px"></asp:Button>
                                <asp:Button ID="Button_transfer" runat="server" Text="Transfer" Width="70px"></asp:Button>
                                <br />
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                <asp:Label ID="Label4" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:Label><br />
                                <br />
                                <asp:GridView ID="GridView_Employee_info" runat="server" DataSourceID="Sql_forGrid"
                                    AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Patient Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_prefix" runat="server" Text='<%# Eval("Prefix") %>'></asp:Label>
                                                <asp:Label ID="lbl_FName" runat="server" Text='<%# Eval("PFName") %>'></asp:Label>
                                                <asp:Label ID="lbl_MName" runat="server" Text='<%# Eval("PMName") %>'></asp:Label>
                                                <asp:Label ID="lbl_LName" runat="server" Text='<%# Eval("PLName") %>'></asp:Label><br />
                                                <asp:HiddenField ID="HF_P_Name" runat="server" Value='<%# Eval("Patient_Name") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Ward_Name" HeaderText="Ward Name" SortExpression="Ward_Name" />
                                        <asp:BoundField DataField="Yearly_No" HeaderText="Yearly No" SortExpression="Yearly_No" />
                                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                                        <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
                                        <asp:BoundField DataField="Reg_No" HeaderText="Reg No" SortExpression="Reg_No" Visible="False" />
                                        <asp:BoundField DataField="Admitted_BY" HeaderText="Admitted BY" ReadOnly="True"
                                            SortExpression="Admitted_BY" />
                                        <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                                        <asp:BoundField DataField="Patient_Name" HeaderText="Patient_Name" ReadOnly="True"
                                            SortExpression="Patient_Name" Visible="False" />
                                        <asp:BoundField DataField="datetime" HeaderText="Date time" SortExpression="datetime" />
                                        <asp:BoundField DataField="RegDateTime" HeaderText="Reg DateTime" SortExpression="RegDateTime" />
                                    </Columns>
                                </asp:GridView>
                                <asp:Label ID="Label_row" runat="server" Visible="False"></asp:Label>
                                <asp:SqlDataSource ID="Sql_transfer" runat="server" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" InsertCommand="insert_Transfer_Pt_Ward"
                                    InsertCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="DropDownListFloor" Name="Ward_id" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:Parameter DefaultValue="0" Name="Bed_id" Type="String" />
                                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" Type="String" />
                                        <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Decimal" />
                                        <asp:Parameter DefaultValue="false" Name="Pt_Status" Type="Boolean" />
                                        <asp:SessionParameter Name="admission_By" SessionField="emp_id" Type="Int32" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <br />
                                <asp:SqlDataSource ID="Sql_forGrid" runat="server" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT admin_Hospital_Wards.Ward_Name, Pt_Assign_Bed.Yearly_No, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') AS Admitted_BY, Ward_Beds.Location, ISNULL(Patient.PFName, '') AS Patient_Name, Pt_Assign_Bed.datetime, Patient.Age, Patient.RegDateTime, Gender.Gender, Pt_Assign_Bed.Reg_No, Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName FROM Patient INNER JOIN Pt_Assign_Bed ON Patient.RegNo = Pt_Assign_Bed.Reg_No INNER JOIN Gender ON Patient.SexID = Gender.Gender_ID LEFT OUTER JOIN admin_Hospital_Wards ON Pt_Assign_Bed.Ward_id = admin_Hospital_Wards.Ward_id LEFT OUTER JOIN Employee ON Pt_Assign_Bed.admission_By = Employee.EmpID LEFT OUTER JOIN Ward_Beds ON Pt_Assign_Bed.Bed_id = Ward_Beds.Bed_id WHERE (Pt_Assign_Bed.Reg_No = @Reg_No)"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceFloor" runat="server" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT DISTINCT admin_Hospital_Wards.Ward_Name, admin_Hospital_Wards.Ward_id, SubDepartment.SubDept_Id FROM SubDepartment INNER JOIN admin_Hospital_Wards ON SubDepartment.SubDept_Id = admin_Hospital_Wards.SubDept_Id WHERE (admin_Hospital_Wards.isDeleted = 0)"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:Panel>
                
                
                
                <br />
               
                <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="pt_get_diagnosis" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="COD" SessionField="YearlyNo" Type="String" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_description" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Insert_Plan" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    InsertCommand="INSERT INTO pt_Treatment_Plan(Reg_No, Yearly_No, Plan_Detail, emp_id) VALUES (@RegNo, @YearlyNo, @Plan , @empid)"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" />
                <asp:SqlDataSource ID="SqlDataSource_pt_Treatment_Plan" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    SelectCommand="Physician_Notes" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="Reg_no" SessionField="RegistrationNo" Type="String" />
                        <asp:SessionParameter Name="Yearly_no" SessionField="YearlyNo" Type="Decimal" />
                        <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                       
            
    <div style="clear:both;"></div>
 
  </div><!--pageContent-->
  </div><!--main_bx-->
      
</asp:Content>
