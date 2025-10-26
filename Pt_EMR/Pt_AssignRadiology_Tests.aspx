<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Pt_AssignRadiology_Tests.aspx.vb" MasterPageFile="~/hacims_masterpage.master" Inherits="Pt_AssignRadiology_Tests_1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register TagName="InveestigationChartControl" Src="~/Pt_EMR/Controls/InveestigationChartControlForRadialogy.ascx" TagPrefix="INVC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	<link rel="stylesheet" href="../resources/js/jquery.mCustomScrollbar.css??" />
	<script src="../resources/js/jquery.mCustomScrollbar.concat.min.js"></script>


    <script type="text/JavaScript">
        function ViewReport() {
            //alert("sdfsd");
            window.open("PatalogyTestReport.aspx", "MyWindow", "");
            return false;
        }

    </script>
     
    <script src="../pt_emr/jquery.imgzoom.js"></script>
    <%--<script src="jquery.imgzoom.pack.js"></script>--%>

    <style type="text/css">
        
    </style>


    <script language="javascript" type="text/JavaScript">
        $(document).ready(function () {
			
			$(".leftMenu_Divcnt").mCustomScrollbar({ axis:"y",theme:"minimal-dark" });
			
			
            $('#prevs').click(function () {
                location.reload();
            });
			
			$(document).on("click",".mainpage_tabs li a",function(e){
		  
		  	e.preventDefault();
			$('.mainpage_tabs li a').removeClass('active');
			$(this).addClass('active');
			var thisId = $(this).attr('id').split('_')[0];			 
			$('.hideall').hide();
			$('#'+thisId+'_content').show();
			 
		 
		     });  
			 
			// var pageheight = $(document).height();
		//  $('.slideLeftMenu').height(pageheight+100);
		  
		  
			
			
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div id="lightbox_bgm"></div>
<div class="slideLeftMenu"><div id="menuScroll"><asp:Label ID="LabelSideMenu" runat="server" Visible="true"></asp:Label></div></div>
<div class="main_bx">
         <ul class="mainpage_tabs" style="padding-left:218px; box-sizing:border-box;">
         <li><a href="#" class="active" id="addInvestigation_show">Add Investigation</a></li>
         <li><a href="#" id="investigationResults_show">Investigation Results</a></li>      
         </ul>
         
           <div class="leftMenu_div">
     		 <div class="leftMenu_divcnt"></div>
   	 </div><!--leftMenu_div-->
         
 		 <div class="pageContent" style="width:100%; padding-left:230px; box-sizing:border-box;">




    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="../autocomplete.asmx" />
        </Services>
    </asp:ScriptManager>



    <asp:Panel ID="Panel2" runat="server" Width="100%"></asp:Panel>
    <asp:Label ID="Label2" runat="server" CssClass="err"></asp:Label>

			 
                <asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
	
 <div id="addInvestigation_content" class="hideall">
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>


                                    <cc1:AutoCompleteExtender ID="Get_Radiology_Test" runat="server" CompletionInterval="10"
                                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
                                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionSetCount="12" EnableCaching="true"
                                        MinimumPrefixLength="3" ServiceMethod="Get_Radiology_Test" ServicePath="../AutoComplete.asmx"
                                        TargetControlID="TextBox_Test" BehaviorID="Get_Radiology_Test">
                                    </cc1:AutoCompleteExtender>
                               
                               
                                   
                       <div class="bx_left">            
           <asp:DataList ID="DataList1" runat="server" Width="100%" Visible="true" DataSourceID="ForTestGroup"
                                                                            DataKeyField="TGID" RepeatColumns="3" RepeatDirection="Horizontal" SelectedItemStyle-CssClass="link_datalist_sel">
                                                                            <SelectedItemStyle CssClass="link_datalist_sel"></SelectedItemStyle>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Eval("TGName", "{0}") %>' CssClass="link_datalist" CommandName="Select" CommandArgument='<%# Eval("TGID", "{0}") %>'></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:DataList>                        
                    
                                      <asp:TextBox AccessKey="n" ID="TextBox_Test" runat="server" Width="100%" Style="margin-top:12px; background:#fff url(../resources/images/img_search.svg) 99% 6px no-repeat; background-size:16px; padding-right:10px; " PlaceHolder="Enter Test Name" AutoPostBack="True"></asp:TextBox>  
                            
                    <div class="bx_01" style="width:100%; float:none; margin-left:0px; margin-top:10px; min-height:260px; height:260px; overflow:auto; overflow-x:hidden;">         
                     <asp:CheckBoxList ID="CheckBoxList_Rad_Test" Font-Size="12px" ForeColor="Black" runat="server" DataSourceID="SqlDataSource_Test_booking_new" AutoPostBack="True" RepeatLayout="Flow" DataTextField="TB_Name" DataValueField="TB_ID">
                                                            </asp:CheckBoxList>
                    </div>                                        
                                                            
                                                            
                                                            <asp:HiddenField ID="HiddenField_TestType" runat="server"></asp:HiddenField>
                                                            <asp:SqlDataSource ID="SqlDataSource_Test_Type" runat="server" SelectCommand="SELECT Test_Type, Test_Type_ID FROM Test_Type" ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"></asp:SqlDataSource>       
                             
                     <asp:SqlDataSource ID="SqlDataSource_Test_booking_new" runat="server"
                                                        SelectCommand="SELECT Test_Booking.TB_Name, Test_Booking.TB_ID, TestGroup.TGName FROM TestGroup INNER JOIN Test_Booking ON TestGroup.TGID = Test_Booking.MG_ID where (TestGroup.TGID LIKE @MG_ID) and (Test_Booking.TB_Name like '%' +@TB_Name + '%')" ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="HiddenFieldTestSubGroup" PropertyName="Value" DefaultValue="999" Name="MG_ID"></asp:ControlParameter>
                                                            <%-- <asp:Parameter Name="MG_ID" DefaultValue="%" />--%>
                                                            <asp:ControlParameter ControlID="TextBox_Test" PropertyName="Text" DefaultValue="%" Name="TB_Name"></asp:ControlParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                    <asp:HiddenField ID="HiddenFieldGender" runat="server"></asp:HiddenField>  
                      
                      
                      
                                   
                 </div><!--bx_left-->
                 
                    
              <!-- ///////////////////////////////////////////////////////////////////////-->
               
                 
                   <div class="bx_right">
                   
                     <asp:Label ID="labelGName" runat="server" CssClass="err"></asp:Label>
                      <asp:DropDownList ID="DropDownListCategory" runat="server" Width="150px" Visible="False" AutoPostBack="True">
                                                        <asp:ListItem>Section</asp:ListItem>
                                                        <asp:ListItem>Specimen</asp:ListItem>
                                                    </asp:DropDownList>
                     <div class="bxmain" style="width: 99%; display: none">
                                                        <table class="tbl_form" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                            <tbody>

                                                                <tr>
                                                                    <td valign="top" align="right">
                                                                    Comments :</tdtd>
                                                  <td valign="top">
                                                      <asp:TextBox Style="height: 35px" ID="TextBox_Instructions" TabIndex="19" runat="server" Width="98%" TextMode="MultiLine"></asp:TextBox></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                     
                        <asp:Label ID="lblMsg" runat="server" Style="font-size: 13px; font-weight: bold;"></asp:Label>            
                              
                    <asp:GridView ID="GridViewTest_Assign" runat="server" CssClass="Grid_1" Width="100%" AutoGenerateColumns="False" ShowFooter="True">
                                                        <RowStyle CssClass="GridItem" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="TestName" SortExpression="TestName">

                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label_TestName" runat="server" Text='<%# Bind("TestName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Urgent" SortExpression="Test Type">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkUrgent" runat="server" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>


                                                            <asp:TemplateField HeaderText="Description" SortExpression="Description">

                                                                <ItemTemplate>
                                                                    &nbsp;<asp:TextBox ID="TextBox_Description" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>

                                                                    <asp:HiddenField ID="hdnTID" runat="server" Value='<%# Eval("TID") %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Charges" Visible="false">

                                                                <FooterStyle HorizontalAlign="Right" />
                                                                <FooterTemplate>
                                                                    <asp:Label ID="Label_Total_Charges" runat="server" Text="Label"></asp:Label>
                                                                </FooterTemplate>
                                                                <ItemStyle HorizontalAlign="Right" />
                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label_charges" runat="server" Text='<%# Bind("Charges") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Is Inside Hospital" Visible="false">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="CheckBox_Is_Inside_Hospital" runat="server" Checked='<%# Eval("IS_inside_Hospital_Test") %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:CommandField ShowEditButton="True" Visible="false" />
                                                            <asp:ButtonField CommandName="select" Text="Cancel" />
                                                        </Columns>
                                                        <HeaderStyle CssClass="GridHeader" />
                                                        <AlternatingRowStyle CssClass="GridAltItem" />
                                                    </asp:GridView>
                                                    
                                                    <div align="center" style="padding:10px;">
                                                        <asp:Button ID="btnAdd" runat="server" Text="Save" CssClass="btn1"></asp:Button>
                                                    </div>          
                              
                                   <asp:GridView ID="GridView_PatientAssignedTests" runat="server" CssClass="Grid_1" Width="100%" AutoGenerateColumns="False" ShowFooter="false">
                        <RowStyle CssClass="GridItem"></RowStyle>
                        <Columns>
                            <asp:TemplateField HeaderText="Test Name" SortExpression="TestName">                               
                                <ItemTemplate>
                                    <asp:Label ID="Label_TestName" runat="server" Text='<%# Bind("TestName") %>' ></asp:Label>                                    
                                </ItemTemplate>
                            </asp:TemplateField>                            
                            <asp:TemplateField HeaderText="Urgent" SortExpression="Test Type">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkUrgent"  runat="server" Checked='<%# Bind("TestType") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>                          
                            <asp:TemplateField HeaderText="Special Inst">                            
                                <ItemTemplate>  
                                       <asp:Label ID="Label_Description" runat="server" Text='<%# Bind("Instructions") %>' ></asp:Label>                                                                
                                    <asp:HiddenField ID="hdnTID" runat="server" Value='<%# Eval("TID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>                                                                                    
                            
                        </Columns>
                    </asp:GridView>
                   </div>                  
                                                
                                                
                                                
        <asp:TreeView ID="TreeView1" runat="server" Visible="False"></asp:TreeView>
        <asp:Panel ID="Panel_Register_Test" runat="server" Visible="False">
            <br />

            <asp:SqlDataSource ID="SqlDataSource_MG_Name" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_connstr %>"
                InsertCommand="INSERT INTO Test_Booking(TB_Name, Private_Price, Public_Price, MG_ID,S_Id) VALUES (@TB_Name, @Private_Price, @Public_Price, @MG_ID,@S_Id)"
                ProviderName="<%$ ConnectionStrings:Admin_Radiology_connstr.ProviderName %>"
                SelectCommand="SELECT TGName, TGID FROM TestGroup ">
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBox_TBNAme" Name="TB_Name" PropertyName="Text" />
                    <asp:Parameter DefaultValue="0" Name="Private_Price" />
                    <asp:Parameter DefaultValue="0" Name="Public_Price" />
                    <asp:ControlParameter ControlID="DropDownList_MGName" Name="MG_ID" PropertyName="SelectedValue" />
                    <asp:Parameter DefaultValue="0" Name="S_Id" />
                </InsertParameters>
            </asp:SqlDataSource>
         
            <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                <tbody>
                    <tr style="display: none">
                        <td colspan="2">
                            <strong>Test is not Registered in Hospital.</strong></td>
                    </tr>
                    <tr>
                        <td align="right" width="25%">Main Group :
                        </td>
                        <td width="25%">&nbsp;
                <asp:DropDownList ID="DropDownList_MGName" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_MG_Name"
                    DataTextField="TGName" DataValueField="TGID" Width="200px">
                </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td align="right">Name :</td>
                        <td>
                            <asp:TextBox ID="TextBox_TBNAme" runat="server" CssClass="input_txt" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="right"></td>
                        <td>
                            <asp:Button ID="Button_Save_TestBooking" runat="server" OnClick="Button_Save_TestBooking_Click"
                                Text="Save" Width="88px" />
                            <asp:Button ID="Button_Pnl_Cancel" runat="server" OnClick="Button_Pnl_Cancel_Click"
                                Text="Cancel" /></td>
                    </tr>
                </tbody>
            </table>
          
            
        </asp:Panel>
        <asp:SqlDataSource ID="SqlDataSourceRadiology" runat="server" SelectCommandType="StoredProcedure" SelectCommand="pt_Radiology_Select_Tests" ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                                                            <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                               
                                    
                                    <asp:HiddenField ID="HiddenField_Sample_collection" runat="server"></asp:HiddenField>
                                    <asp:HiddenField ID="HiddenField_Report_Date" runat="server"></asp:HiddenField>
                                    <asp:HiddenField ID="HiddenFieldMain_ID" runat="server"></asp:HiddenField>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="Select @PFNAME = PFNAME from patient" ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" ConnectionString="<%$ ConnectionStrings:LGHConnectionString12 %>"></asp:SqlDataSource>
                                    <asp:HiddenField ID="HiddenField2" runat="server"></asp:HiddenField>
                                    <asp:SqlDataSource ID="ForTestGroup" runat="server" SelectCommand="SELECT TGName, TGID FROM TestGroup order by Priority " ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="ForTestSubGroup" runat="server" SelectCommand="SELECT isnull(TestSubGroup.TSGName,'') as TSGName, TestSubGroup.TSGID, isnull(TestGroup.TGName,'') as TGName FROM TestSubGroup INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID WHERE (TestSubGroup.TGID = @TGID)" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" ConnectionString="Data Source=DEMO\HACIMS;Initial Catalog=Admin_Radiology;User ID=sa;Password=123;Max Pool Size=900;">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="DataList1" Name="TGID" PropertyName="SelectedValue"
                                                Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource ID="ForTest" runat="server" SelectCommand="SELECT [TestName], [TID] FROM [Test] WHERE ([TGID] = @TGID)" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" ConnectionString="Data Source=DEMO\HACIMS;Initial Catalog=Admin_Radiology;User ID=sa;Password=123;Max Pool Size=900;">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="HiddenFieldTestSubGroup" Name="TGID" PropertyName="Value"
                                                Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:HiddenField ID="HiddenFieldTestSubGroup" runat="server"></asp:HiddenField>
                                    <asp:SqlDataSource ID="SqlDataSourcefortsetSG" runat="server" SelectCommand="SELECT [TID], [TestName] FROM [Test] WHERE ([TSGID] = @TSGID)" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" ConnectionString="Data Source=DEMO\HACIMS;Initial Catalog=Admin_Radiology;User ID=sa;Password=123;Max Pool Size=900;">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="HiddenField_for_test" Name="TSGID" PropertyName="Value"
                                                Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:HiddenField ID="HiddenField_for_test" runat="server"></asp:HiddenField>
                                </ContentTemplate>

                            </asp:UpdatePanel>

</div>

 <div id="investigationResults_content" class="hideall" style="display:none;">
  <INVC:InveestigationChartControl runat="server" ID="patientInvestigation" />
</div>
 
    <asp:Label ID="LabelFooter" runat="server" Text="" Visible="false"></asp:Label>

    <asp:SqlDataSource ID="SqlDataSourceRadiologyPreviousTest_Parent" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        SelectCommand="select distinct abc.*,ISNULL(e.EFName,'')+' '+ISNULL(e.ELName,'') as DoctorName from (

SELECT distinct CONVERT(varchar, Date_Time, 103) AS DateTime,emp_id,YearlyNo FROM  
   Radiology_Order_Main WHERE   RegNo=@RegNo
  )abc inner join Employee e on e.EmpID=abc.emp_id order by abc.DateTime desc

	">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />

        </SelectParameters>
    </asp:SqlDataSource>


   
  
       </div><!--pageContent-->
  </div><!--main_bx-->
      

</asp:Content>
