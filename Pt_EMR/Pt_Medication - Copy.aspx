<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_Medication.aspx.vb" MasterPageFile="~/hacims_masterpage.master"
    Inherits="Pt_EMR_Pt_Medicationwe" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
         
    </style>
 
    <script type="text/javascript">


        $(function () {

            $('[id$="rd_DrugAllergic"]').change(function () {
                var text = $('[id$="rd_DrugAllergic"] input[type="radio"]:checked').next().text();
                
                if (text == "Yes") {
                    $('[id$="TextBox_specificMedicineAllergic"]').attr('disabled', false);
                    $('[id$="txt_Other"]').attr('disabled', false);
                }
                else {
                    $('[id$="TextBox_specificMedicineAllergic"]').attr('disabled', true);
                    $('[id$="txt_Other"]').attr('disabled', true);
                }
            });
        });
		
		$(document).ready(function(e) {
            $(".pageTitle").html("Medications");
			//var pageheight = $(document).height();
		//  $('.slideLeftMenu').height(pageheight+100);
		  
		  $(document).on("click",".left_usermenu,#lightbox_bgm",function(e){
		  
		  	e.preventDefault();
			    		 
 
   					 // $( ".slideLeftMenu").hide("slide", { direction: "right" }, 1000);	 
					  $('.slideLeftMenu').animate({width: 'toggle'},300);
					//  $('.slideLeftMenu').toggle( "slide" );
					  var ml = $('#lightbox_bgm').css('display');
						  
						if(ml=="none"){  $('#lightbox_bgm').fadeIn();
						 	 
						}else {  $('#lightbox_bgm').fadeOut(); 
					  
					    }					 
		    });
			
			
			
        });
         
    </script>
     
	 <style type="text/css">
	 
	 
	 	
		 
	
	
        .radiobtns {
            font-size: 9px;
            color: #000;
            font-family: tahoma;
        }

        .altedrnate {
            background-color: #C90;
        }
        .auto-style1 {
            width: 171px;
        }
        .auto-style2 {
            border-bottom: #e4e4e4 solid 1px;
            border-left: #bebebe solid 1px;
            border-right: #e4e4e4 solid 1px;
            border-top: #bebebe solid 1px;
            font-size: 12px;
            behavior: url(PIEq.htc);
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border-radius: 2px;
        }
		
		
		.mainpage_tabs { float:left; height:38px; width:100.1%; margin-left:-1px; margin-top:-38px;}
		.mainpage_tabs li { height:38px; width:33%; display:inline-block;   text-align:center; float:left; }
.mainpage_tabs li:nth-child(2) { margin-left:.5%; width:33%;    }		
.mainpage_tabs li:nth-child(3) { margin-left:.5%; width:33%;    }
.mainpage_tabs li a { width:100%; color:#999; height:100%; float:left; background:#fff; line-height:38px; text-decoration:none; font-size:16px; border-top-left-radius:5px; border-top-right-radius:5px; border:#dcdcdc solid 1px;   }

.mainpage_tabs li a.active { border-bottom:#fff solid 1px; border-top:#0985cf solid 2px; color:#0985cf; line-height:36px;  font-weight:500;  }
 	
		
		.medication { float:left; width:100%; list-style:none; border-bottom:#ccc dashed 1px; margin-bottom:10px; padding-bottom:10px;}
		.medication li { list-style:none; width:100%;}
		.medication li span { display:block; font-weight:bold; color:#186dc4; }
		.medication li .right_btn_delete { float:right; width:13px; height:13px; margin-top:22px; }
		.medication li .right_btn_delete:hover {    background:url(resources/images/img_del.png) 0px 0px no-repeat; }
		
		
		.grid_medication { border:0;}
		.grid_medication th { font-weight:bold;   }
		.grid_medication td { border:0;  }
		.grid_medication td .drop_down { height:30px;  }
		
		
		
    </style>


    <script type="text/javascript">
        function selectMedicine(sender, e) {
            //$("[id$='HiddenField_MedCode']").val(e.get_value());

            $get("<%=HiddenField_MedCode.ClientID %>").value = e.get_value();
        }

        function selectMedicineAllergic(sender, e) {
		     $("[id$='HiddenField_MedCodeAllergic']").val(e.get_value());
             <%--$get("<%=HiddenField_MedCode.ClientID %>").value = e.get_value();--%>
		 }
    </script>



    <script type="text/javascript">
        $(document).ready(function () {
			
			 
			
			$(document).on("click",".mainpage_tabs li a",function(e){
		  
		  	e.preventDefault();
			$('.mainpage_tabs li a').removeClass('active');
			$(this).addClass('active');
			var thisId = $(this).attr('id').split('_')[0];			 
			$('.hideall').hide();
			$('#'+thisId+'_content').show();
			 
		 
		     }); 
			
			 
            $('.medication li:nth-child(odd)').addClass('alternate');


            $('[id$="ButtonSave"]').click(function () {
                if (($('[id$="TextBox_specificMedicine"]').val().trim() == "") && ($('[id$="ddlDepartmentMedicines"] option:selected').val() == "0")) {
                    alert("Please Selected Medicine First");
                    return false;
                }
            });


            if ($('[id$="hfForAutoPostBack"]').val() == "0") {

                $('[id$="rdbtnMedicines"]').val("Dept");
                $('[id$="ddlDepartmentMedicines"]').show();
                $('[id$="TextBox_specificMedicine"]').hide()
            }
            else {
                $('[id$="ddlDepartmentMedicines"]').hide();
                $('[id$="TextBox_specificMedicine"]').show()
            }

            
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <div id="lightbox_bgm"></div>
<div class="slideLeftMenu"><asp:Label ID="LabelSideMenu" runat="server" Visible="true"></asp:Label></div>
 <div class="main_bx">
         <ul class="mainpage_tabs">
         <li><a href="#" class="active" id="currentMedicine_show" >Current Medicine</a></li>
         <li><a href="#" id="favouriteMedicine_show">Favourite Medicine</a></li>
         <li><a href="#" id="previouseMedicine_show">Previouse Medicine</a></li>
         </ul>
 		 <div class="pageContent">
      
  
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="../autocomplete.asmx" />
        </Services>
    </asp:ScriptManager>
    <cc1:AutoCompleteExtender ID="GetMedication" runat="server" CompletionInterval="10"
        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
        CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionSetCount="12" OnClientItemSelected="selectMedicine"
        EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetMedication" ServicePath="../AutoComplete.asmx"
        TargetControlID="TextBox_specificMedicine">
    </cc1:AutoCompleteExtender>

    <cc1:AutoCompleteExtender ID="GetMedication_hs" runat="server" CompletionInterval="10"
        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
        CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionSetCount="12"
        EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetMedication_hospital"
        ServicePath="../AutoComplete.asmx" TargetControlID="TextBox_specificMedicine_hs">
    </cc1:AutoCompleteExtender>

    <cc1:AutoCompleteExtender ID="GetMedicationAllergic" runat="server" CompletionInterval="10"
        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
        CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionSetCount="12"  OnClientItemSelected="selectMedicineAllergic"
        EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetMedication" ServicePath="../AutoComplete.asmx"
        TargetControlID="TextBox_specificMedicineAllergic">
    </cc1:AutoCompleteExtender>
  
   
                 <asp:Panel ID="Panel1" runat="server" Visible="False">
                 </asp:Panel>
  
   
        
        <div id="currentMedicine_content" class="hideall">
        
         <asp:Button ID="ButtonSearch" runat="server" Text="Search" Width="50px" CausesValidation="False"
                            Visible="False" />
                        <asp:RadioButtonList ID="RadioButtonList_medkind" runat="server" CssClass="radiobtns"
                            RepeatColumns="6" RepeatLayout="Flow" Visible="False">
                            <asp:ListItem Value="i%">INJ</asp:ListItem>
                            <asp:ListItem Value="t%">TAB</asp:ListItem>
                            <asp:ListItem Value="c%">CAP</asp:ListItem>
                            <asp:ListItem Value="ComName">Company</asp:ListItem>
                            <asp:ListItem Selected="True" Value="%">Any</asp:ListItem>
                            <asp:ListItem Value="Sy%">Syrp</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:GridView ID="GridViewMedicine" runat="server" Width="100%" AllowPaging="True"
                            PageSize="5" Visible="False">
                            <Columns>
                                <asp:ButtonField CommandName="select" HeaderText="Select" Text="Select" />
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <AlternatingRowStyle CssClass="GridAltItem" />
                            <PagerStyle CssClass="GridPager" />
                        </asp:GridView>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox_days"
                            ErrorMessage="RequiredFieldValidator" Width="21px">*</asp:RequiredFieldValidator>
                        <asp:Label ID="Label3" runat="server" CssClass="text_boxtitle" Text="Status" Visible="False"></asp:Label>
                        <asp:DropDownList ID="DropDownList_Discharge_status" runat="server" CssClass="text_boxtitle"
                            Visible="False">
                            <asp:ListItem Value="1">Hospital</asp:ListItem>
                            <asp:ListItem Value="0">Discharge</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="TextBox_Medicine" runat="server" Height="1px" Visible="false" Width="1px"></asp:TextBox>&nbsp;
                            <asp:RadioButtonList ID="RadioButtonList_HospitalMed" runat="server" AutoPostBack="True"
                                RepeatColumns="2" Visible="false">
                                <asp:ListItem Selected="True" Value="0">All</asp:ListItem>
                                <asp:ListItem Value="1">Hospital Stock</asp:ListItem>
                            </asp:RadioButtonList>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form"  style="display:none">
                            <tr >
                                <td style="display:none">
                                <asp:RadioButtonList RepeatDirection="Horizontal" ID="rdbtnMedicines" runat="server">
                                    <asp:ListItem Text="All" Selected="True" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Department Specific" Value="Dept"></asp:ListItem>
                                </asp:RadioButtonList>
                                    </td>
                                <td align="right">
                                            <strong>Drug Allergic :</strong>
                                        </td>
                                        <td class="auto-style1">
                                            <asp:RadioButtonList ID="rd_DrugAllergic" runat="server" RepeatDirection="Horizontal"
                                                OnSelectedIndexChanged="rd_DrugAllergic_SelectedIndexChanged" AutoPostBack="false">
                                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                <asp:ListItem  Selected="True" Text="No" Value="0"></asp:ListItem>
                                            </asp:RadioButtonList>
                                            
                                        </td>
                            </tr>
                            <tr>
                                <td>

                                </td>
                                <td align="right">
                                            <strong><asp:Label ID="lblDrugName" runat="server" Text="Drug Name :"></asp:Label></strong>
                                        </td>
                                        <td class="auto-style1">
                                            <asp:TextBox ID="TextBox_specificMedicineAllergic" CssClass="input_txt" Width="200px" runat="server"
                                            AccessKey="n" Enabled="false" AutoPostBack="false"></asp:TextBox>
                                            
                                        </td>
                                        <td align="right">
                                           <strong><asp:Label ID="lblOther" runat="server" Text="Other :" ></asp:Label></strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txt_Other" CssClass="auto-style2" Width="200px" runat="server" Enabled="false"></asp:TextBox>
                                        </td>
                            </tr>
                        </table>


						<div  class="bx_style_1" style="width:100%;">
					
                    
                    
                    
                    
                    
                    
                    
                        <table cellpadding="0" class="grid_medication" cellspacing="0" width="100%"
                            id="TABLE1">
                            <tr>
                                <th align="left">Medicine Name</th>
                                <th align="left">Route</th>
                                <th align="left">Frequency</th>
                                <th align="left">Days</th>
                                <th align="left">Start Date</th>
                                <th>Meal</th>
		 						 <th align="left" colspan="1">Physican Notes</th>

                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:TextBox ID="TextBox_specificMedicine" CssClass="input_txt" Width="98%" runat="server"
                                        AccessKey="n"></asp:TextBox>
                                    <asp:TextBox ID="TextBox_specificMedicine_hs" CssClass="input_txt" Width="98%"
                                        runat="server" AccessKey="n" Visible="false" AutoPostBack="True"></asp:TextBox><br />
                                    <asp:DropDownList Visible="false" Width="100%" ID="ddlDepartmentMedicines" runat="server"></asp:DropDownList>
                                    <asp:Label ID="Label1" CssClass="red" runat="server"></asp:Label>

                                </td>
                                <td valign="top">
                                    <asp:DropDownList ID="DropDownList_route" runat="server" DataSourceID="SqlDataSource_route"
                                        DataTextField="Description" DataValueField="Id" Width="60px">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="DropDownList_dosage" runat="server" DataSourceID="SqlDataSource_dosage"
                                        DataTextField="Name" DataValueField="Name" Width="75px" Visible="False">
                                    </asp:DropDownList></td>
                                <td valign="top">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                        <tr>
                                            <td>

                                                <asp:DropDownList ID="DropDownList_frequencyName" runat="server" AutoPostBack="True"
                                                    DataTextField="Name" DataValueField="id" OnSelectedIndexChanged="DropDownList_frequencyName_SelectedIndexChanged"
                                                    Width="100px">
                                                </asp:DropDownList>


                                                <asp:TextBox ID="TextBox_Frequency" runat="server" style="text-align:center;" AutoPostBack="True" Width="25px">1</asp:TextBox>
                                                <asp:ImageButton Visible="false" ID="ImageButton_Frequency_ShowHide" runat="server" ImageUrl="../images_hacims/add.png" />

                                            </td>
                                        </tr>
                                    </table>
							  
                            
                                    <ul id="CollapsiblePanel1" style="">
                                        <li style="text-align: right;"></li>
                                        <li>

                                            <asp:DataList ID="DataList_Frequency" runat="server" DataKeyField="Frequency_Sub_Id"
                                                DataSourceID="SqlDataSource_FrequencyDataList" RepeatColumns="10"
                                                RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <div class="medbg">
                                                        <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block; font-family: arial; font-size: 9px;"></asp:Label>
                                                        <asp:TextBox ID="TextBox_dosage2" runat="server" Width="30px" Style="height: 12px; display: inline;">1</asp:TextBox>
                                                        <asp:HiddenField ID="HF_F_S_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                                    </div>
                                                </ItemTemplate>
                                            </asp:DataList>

                                        </li>

                                    </ul>
                                </td>
                                <td align="center" valign="top">
                                    <asp:TextBox ID="TextBox_days" runat="server" CssClass="input_txt" Width="25px" AutoPostBack="True">1</asp:TextBox>
                                    <asp:CheckBox ID="CheckBox_CT" runat="server" Text="CT" Visible="False" /></td>
                                <td valign="top">
                                    <igsch:WebDateChooser ID="WebDateChooserStartDate" runat="server" CssClass="drop_date"
                                        Width="100px" Value="2008-01-16" Style="border:#ccc solid 1px;">
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                    <igsch:WebDateChooser ID="WebDateChooserEndDate" CssClass="drop_date" Visible="false"
                                        runat="server" Value="2010-06-17" Width="100px">
                                        <AutoPostBack ValueChanged="True" />
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                </td>
                                <td style="display: none;">
                                    <asp:DropDownList ID="ddlMedicineType" runat="server">
                                        <asp:ListItem Text="Discharge Medicine" Value="Discharge Medicine"></asp:ListItem>
                                        <asp:ListItem Text="Emergency Treatment" Value="Emergency Treatment"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td style="display: none;">
                                    <asp:TextBox ID="txtboxBeforeMeal" TextMode="MultiLine" Style="width: 100%;" runat="server"></asp:TextBox>
                                </td>
                                <td style="display: none;">
                                    <asp:TextBox ID="txtboxAfterMeal" TextMode="MultiLine" Style="width: 100%;" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_Meal" runat="server" Width="87px">
                                        <asp:ListItem Value="NA">NA</asp:ListItem>
                                        <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                        <asp:ListItem Value="After Meal">After</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td valign="top">


                                    <asp:TextBox ID="TextBoxInstruction" TextMode="MultiLine" runat="server" CssClass="input_txt" Height="45px" Width="99%"></asp:TextBox>


                                    <asp:DropDownList ID="DropDownList_Medicine_Advice_Category" runat="server" DataSourceID="SqlDataSource_Medicine_Advice_Category"
                                        Visible="false" DataTextField="Medicine_Advice_Category_Name" DataValueField="Medicine_Advice_Category_ID">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="DropDownList_diution" runat="server"
                                        DataTextField="name" DataValueField="name" Width="65px" Visible="False">
                                    </asp:DropDownList>
                                    <asp:TextBox ID="TextBox_dilution" CssClass="input_txt" runat="server" Width="25px"
                                        Visible="False"></asp:TextBox>
                                    <asp:Label ID="Label_Dilution" runat="server" Text="Dilution" Visible="False"></asp:Label></td>

                                <asp:Label ID="Label_Stock" Visible="false" runat="server"></asp:Label>
                            </tr>
                        </table>
                        </div>
                        
                        
                        
                        
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="mainApp" runat="server" ControlToValidate="TextBox_specificMedicine"
                            ErrorMessage="RequiredFieldValidator" EnableViewState="False">Select Medicine</asp:RequiredFieldValidator>&nbsp;
                            <div align="center">
                                <asp:TextBox ID="TextBox_dosage" runat="server" CssClass="input_txt" Width="25px"
                                    Visible="False">1</asp:TextBox>
                                <asp:Button ID="ButtonSave" runat="server" Text="Save" ValidationGroup="mainApp" CausesValidation="true" />
                                <asp:Button ID="Button_Update" runat="server" Text="Update" CausesValidation="False"
                                    Visible="False" />
                                <asp:Label ID="LabelMessage" runat="server" Font-Bold="True"></asp:Label>
                            </div>

                        <asp:SqlDataSource ID="SqlDataSource_FrequencyDataList" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
                            ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>" SelectCommand="SELECT     Medicine_Frequency.Name, Medicine_Frequency_Detail.Frequency , &#13;&#10;                      Medicine_Frequency_Detail.TimeDuration_Hour, Medicine_Frequency_Detail.Sequence_No, Medicine_Frequency_Detail.Frequency_Sub_Id,&#13;&#10;                      Medicine_Frequency_Detail.Frequency_Id&#13;&#10;FROM         Medicine_Frequency_Detail INNER JOIN&#13;&#10;                      Medicine_Frequency ON Medicine_Frequency_Detail.Frequency_Id = Medicine_Frequency.id&#13;&#10;WHERE     (Medicine_Frequency.id = @id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList_frequencyName" Name="id" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource_Medicine_Advice_Category" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                            SelectCommand="SELECT [Medicine_Advice_Category_ID], [Medicine_Advice_Category_Name] FROM [Medicine_Advice_Category]"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                            SelectCommand="Select_Patient_Prescription_Detail" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                <asp:ControlParameter Name="date" ControlID="HiddenFieldDate" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="GridView_Template_Medicine" runat="server" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSourceForGrid" Width="100%">
                            <Columns>
                                <asp:BoundField DataField="Medicine Name" HeaderText="Medicine Name" SortExpression="Medicine Name" />
                                <asp:BoundField DataField="Meal" HeaderText="Meal" SortExpression="Meal" />
                                <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" Visible="False" />
                                <asp:BoundField DataField="Dosage" HeaderText="Dosage" SortExpression="Dosage" />
                                <asp:BoundField DataField="Doze" HeaderText="Doze" SortExpression="Doze" Visible="False" />
                                <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" />
                                <asp:BoundField DataField="days" HeaderText="Days" SortExpression="days" />
                                <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" />
                                <asp:TemplateField HeaderText="Total Qty" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Label ID="LabelTotalQty" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader2" />
                            <AlternatingRowStyle CssClass="GridAltItem" />
                        </asp:GridView>
                        
                        <asp:DataList Visible="false" ID="DataList_new" runat="server" DataSourceID="SqlDataSource1" Width="100%"
                            DataKeyField="priscription_id">
                            <ItemTemplate>
                                <ul class="medication_cnt">
                                    <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                        class="mname">
                                        <%# Eval("[Medicine Name]") %>
                                    </strong><span>|</span> Dosage : <span class="darkc">
                                        <%# Eval("Doze") %>
                                    </span><span>|</span>Frequency :
                                            <asp:Label ID="Label_Frequency" runat="server" ForeColor="Red" Text="Label"></asp:Label><span
                                                class="darkc"><%#Eval("Dosage")%></span><span>|</span>Start Date : <span class="darkc">
                                                    <%# Eval("[Start Date]") %>
                                                </span><span>|</span>For Days :
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("days") %>'></asp:Label><span
                                                class="darkc"></span><span>|</span><%# Eval("CT") %>&nbsp;
                                            <asp:LinkButton ID="LinkButton_Edit" runat="server" ToolTip="Edit Medicine" CssClass="editit"
                                                CommandName="Select" CausesValidation="False"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton_Delete" runat="server" CausesValidation="False" CommandName="Delete"
                                            CssClass="cancel_btn" ToolTip="Delete Medicine"></asp:LinkButton>
                                        <asp:CheckBox ID="CheckBox_Confirm" runat="server" ToolTip="Confirm Medicine" Checked="True" />
                                        <asp:HiddenField ID="HiddenField_PrescriptionID" runat="server" Value='<%# Eval("priscription_id") %>' />
                                        <asp:HiddenField ID="HiddenField_CT" runat="server" Value='<%# Eval("CT") %>' />
                                        <asp:HiddenField ID="HiddenField_EndDate" runat="server" Value='<%# Eval("[End Date]") %>' />
                                        <asp:HiddenField ID="HiddenField_Start_Date" runat="server" Value='<%# Eval("[Start Date]") %>' />
                                        <asp:HiddenField ID="HiddenField_Dosage" runat="server" Value='<%# Eval("Dosage") %>' />
                                        <asp:HiddenField ID="HiddenField_Doze" runat="server" Value='<%# Eval("Doze") %>' />
                                        <asp:HiddenField ID="HiddenField_MedicineName" runat="server" Value='<%# Eval("[Medicine Name]") %>' />
                                    </li>
                                </ul>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:HiddenField ID="HiddenField2" runat="server" />
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                            SelectCommand="OPD_Encounter_Medication" SelectCommandType="StoredProcedure"
                            DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)">
                            <SelectParameters>
                                <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                                    PropertyName="Value" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                        <div align="center">
                            <asp:Button Visible="false" ID="Button_Confirm" runat="server" Text="Confirm" />
                        </div>
                        
                        <asp:Panel ID="Panel_Confirm" runat="server" Visible="False" Width="100%" CssClass="lightbox_bg"
                            Style="top: 6px">
                            <div class="lightbox">
                                <div align="right">
                                    <asp:ImageButton ID="ImageButton_Close" runat="server" ImageUrl="../images_hacims/img_error.png" />
                                </div>
                                <table width="100%" border="1">
                                    <tr>
                                        <td align="right" width="40%">
                                            <asp:Label ID="Label_Lbl" runat="server" Text="Enter Prescription Code : "></asp:Label></td>
                                        <td>
                                            <asp:TextBox ID="TextBox_Prescription_Code" runat="server" TextMode="Password"></asp:TextBox>
                                            <asp:Button ID="Button_OK" runat="server" Text="Enter" /></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="Label_MSG" runat="server"></asp:Label></td>
                                    </tr>
                                </table>
                                <asp:DataList ID="DataList_Items" runat="server" Width="100%" DataKeyField="priscription_id"
                                    Visible="False">
                                    <ItemTemplate>
                                        <ul class="medication_cnt">
                                            <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                                class="mname">
                                                <%# Eval("[Medicine Name]") %>
                                            </strong><span>|</span> Dosage : <span class="darkc">
                                                <%# Eval("Doze") %>
                                            </span>
                                                <%--     <span>|</span>frequency : <span class="darkc">
                                 <%#eval("dosage")%>
                                </span>  --%>
                                                <span>|</span>Start Date : <span class="darkc">
                                                    <%# Eval("[Start Date]") %>
                                                </span><span>|</span>End Date : <span class="darkc">
                                                    <%# Eval("[End Date]") %>
                                                </span><span>|</span><%# Eval("CT") %><asp:HiddenField ID="HiddenField_PrescriptionID" runat="server" Value='<%# Eval("priscription_id") %>' />
                                            </li>
                                        </ul>
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                        </asp:Panel>
                     
                         
                           <div style="width:100%; text-align:right;">
<asp:LinkButton ID="lnkButtonDetailSlip" runat="server" Text="View Detail Slip" CssClass="plainBtn" PostBackUrl="~/Pt_EMR/MedicineDetailSlip.aspx"></asp:LinkButton> 
<asp:LinkButton ID="lnkReport" runat="server" Text="View Slip" CssClass="plainBtn" PostBackUrl="~/Pt_EMR/MedicineSlip.aspx"></asp:LinkButton> </div>   
                         
                         <h2 class="title_heading" style="margin-bottom:20px;">Confirmed Prescription</h2>
                         
                         
                        <asp:DataList ID="DataList_ConfirmedPrescriptions" runat="server" DataKeyField="priscription_id"
                            DataSourceID="SqlDataSource_Confirmed_Prescriptions"
                            Width="100%">
                            <ItemTemplate>
                                <ul class="medication_cnt">
                               		 <li> <asp:ImageButton ID="btn_delete"
                                                CommandArgument='<%# Eval("priscription_id") %>' runat="server"
                                                ImageUrl="~/resources/images/img_delgray.png" CssClass="right_btn_delete" OnClick="btn_delete_Click" /></li>
                                    <li><span class="mname"><%# Eval("[Medicine_Name]")%></span>
                                        <%#Eval("Para")%>
                                    </li>
                                    <li> 
                                    <%#Eval("para_Urdu")%>
                                        </li >
                                        
                                </ul>
                                <asp:HiddenField ID="HiddenField_PrescriptionID" runat="server" Value='<%# Eval("priscription_id") %>' />
                            </ItemTemplate>
                        </asp:DataList>
                        
                        <div align="center" style="display: none;">
                            <asp:Button ID="btn_MedicationSheet" runat="server" Text="Medication Sheet" /><br />
                            
                        </div>


                        <br />
                        <asp:SqlDataSource ID="SqlDataSource_Confirmed_Prescriptions" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                            SelectCommand="Select_Med_Presc_Urdu" DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)"
                            SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                                    PropertyName="Value" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SDS_Gen_Requisition" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                            InsertCommand="usp_Automatic_Requisition_For_Patient" InsertCommandType="StoredProcedure"
                            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                            <InsertParameters>
                                <asp:SessionParameter Name="Registration_NO" SessionField="RegistrationNo" />
                                <asp:SessionParameter DefaultValue="" Name="Yearly_NO" SessionField="YearlyNo" />
                                <asp:SessionParameter DefaultValue="" Name="Dept_id" SessionField="Dept_id" />
                                <asp:SessionParameter Name="subdeptid" SessionField="Subdeptid" />
                                <asp:SessionParameter Name="ShiftID" SessionField="Shiftid" />
                                <asp:SessionParameter Name="Emp_id" SessionField="Emp_id" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <br />
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="XmlDataSource_Medicine"
                            Visible="false">
                            <ItemTemplate>
                                <ul class="medication_cnt">
                                    <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                        class="mname">
                                        <%#XPath("MedicineName")%>
                                    </strong></li>
                                    <li>Dosage : <span class="darkc">
                                        <%#XPath("Dosage")%>
                                    </span><span>|</span>Frequency : <span class="darkc">
                                        <%#XPath("Dosage")%>
                                    </span><span>|</span>Start Date : <span class="darkc">
                                        <%#XPath("startdate")%>
                                    </span><span>|</span>End Date : <span class="darkc">
                                        <%#XPath("enddate")%>
                                    </span><span>|</span><span class="darkc">
                                        <%#XPath("CT")%>
                                    </span></li>
                                </ul>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:XmlDataSource ID="XmlDataSource_Medicine" runat="server" DataFile="~/Pt_EMR/OPD_Encounter_Medication.xml"
                            XPath="Medicationdatewise/item"></asp:XmlDataSource>
        
        
        </div>
                
        <div id="favouriteMedicine_content" class="hideall" style="display:none;">
        
                            <h2 class="title_heading">Favourite Medicine List</h2>
                         
                         <div style="display:block; text-align:center; width:100%;">
                            <asp:Button ID="btnSaveFavoriteMedicine" OnClick="btnSaveFavoriteMedicine_Click" runat="server" Text="Save " /> 
                            </div>
                            
                           <asp:Label Text="Favourite Medicines Assigned Successfully" Visible="false" ForeColor="Red" Font-Bold="true" ID="lblFavouriteMessage" runat="server"></asp:Label>  
                             
                          
                        <br />
                      
                        <asp:GridView Width="100%" AutoGenerateColumns="false" BackColor="LightBlue" ID="gvdFavouriteMedicine" runat="server" ShowHeader="false" ShowFooter="false" OnRowDataBound="gvdFavouriteMedicine_RowDataBound">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Grid_1">
                                            <tr>
                                                <th style="width: 10px">Select</th>
                                                <th align="center" style="width: 180px">Name</th>
                                                <th style="width: 60px" align="center">Route</th>
                                                <th style="width: 155px" align="center">Frequency</th>
                                                <th style="width: 30px" align="center">Days</th>

                                                <th style="width: 30px">Meal</th>
                                                <th align="center" colspan="1">Physican Notes</th>

                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkboxSelect" runat="server" />
                                                </td>
                                                <td valign="top" style="width: 195px">
                                                    <asp:TextBox Text='<%# Bind("MedicineName") %>' ID="txtboxMedicineName" Enabled="false" CssClass="input_txt" Width="200px" Height="28px" runat="server"></asp:TextBox>
                                                    <asp:HiddenField Value='<%# Eval("MedCode") %>' ID="hfMedCode" runat="server" />
                                                </td>
                                                <td valign="top">
                                                    <asp:DropDownList ID="ddlRoute" Height="28px" runat="server" DataSourceID="SqlDataSource_route"
                                                        DataTextField="Description" DataValueField="Id" Width="60px">
                                                    </asp:DropDownList>
                                                    <asp:HiddenField Value='<%# Eval("Route") %>' ID="hfDDlRuteValue" runat="server" />
                                                </td>
                                                <td valign="top">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                                        <tr>
                                                            <td>
                                                                <asp:DropDownList ID="ddlFrequency" runat="server" AutoPostBack="True"
                                                                    DataTextField="Name" DataValueField="id" OnSelectedIndexChanged="ddlFrequency_SelectedIndexChanged"
                                                                    Width="100px">
                                                                </asp:DropDownList>
                                                                <asp:HiddenField ID="hfFrequencyID" Value='<%# Eval("FrequencyID_FK") %>' runat="server" />

                                                                <asp:HiddenField ID="hfDeptMedID" Value='<%# Eval("DeptMedID") %>' runat="server" />

                                                            </td>
                                                        </tr>
                                                    </table>

                                                    <ul id="CollapsiblePanel1" style="height: 32px;">
                                                        <li style="text-align: right;"></li>
                                                        <li>

                                                            <asp:SqlDataSource ID="SqlDataSourceForFreqency" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
                                                                ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>" SelectCommand="SELECT     Medicine_Frequency.Name,Medicine_Frequency.id, Medicine_Frequency_Detail.Frequency , &#13;&#10;                      Medicine_Frequency_Detail.TimeDuration_Hour, Medicine_Frequency_Detail.Sequence_No, Medicine_Frequency_Detail.Frequency_Sub_Id,&#13;&#10;                      Medicine_Frequency_Detail.Frequency_Id&#13;&#10;FROM         Medicine_Frequency_Detail INNER JOIN&#13;&#10;                      Medicine_Frequency ON Medicine_Frequency_Detail.Frequency_Id = Medicine_Frequency.id&#13;&#10;WHERE     (Medicine_Frequency.id = @id)">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="hfFrequencyID" Name="id" PropertyName="Value" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <%--DataSourceID="SqlDataSourceForFreqency"--%>
                                                            <asp:DataList ID="ddlFrequencyList" Width="183px" runat="server" DataKeyField="Frequency_Sub_Id"
                                                                RepeatColumns="4"
                                                                RepeatDirection="Horizontal">
                                                                <ItemTemplate>
                                                                    <div class="medbg">
                                                                        <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block; font-family: arial; font-size: 9px;"></asp:Label>
                                                                        <asp:TextBox ID="TextBox_dosage2" runat="server" Width="30px" Style="height: 12px; display: inline;">1</asp:TextBox>
                                                                        <asp:HiddenField ID="HF_F_S_Id" runat="server" Value='<%# Eval("id") %>' />
                                                                        <asp:HiddenField ID="Frequency_Sub_ID" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                        </li>

                                                    </ul>
                                                </td>
                                                <td align="center" valign="top">
                                                    <asp:TextBox ID="txtDays" Text='<%# Eval("Days") %>' Height="25px" runat="server" CssClass="input_txt" Width="25px" AutoPostBack="false">1</asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlMeals" runat="server" Height="30px" Width="87px">
                                                        <asp:ListItem Value="NA">NA</asp:ListItem>
                                                        <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                                        <asp:ListItem Value="After Meal">After</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:HiddenField ID="hfMeals" runat="server" Value='<%# Eval("Meal") %>' />
                                                </td>
                                                <td valign="top">


                                                    <asp:TextBox ID="physicanNotes" ForeColor="navy" Text='<%# Eval("PhysicanNotes") %>' TextMode="MultiLine" runat="server" CssClass="input_txt" Height="28px" Width="99%"></asp:TextBox>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
        
        
        </div>   
        
        <div id="previouseMedicine_content" class="hideall" style="display:none;">
        
         
          <span style="display: block; text-align: center; padding-bottom: 10px;">
                            <asp:Button ID="btnSavePreviousMedicine" runat="server" OnClick="btnSavePreviousMedicine_Click" Text="Save Medicine" />
                            <asp:Label Text="Previous Medicines Assigned Successfully" Visible="false" ForeColor="Red" Font-Bold="true" ID="lblMsg" runat="server"></asp:Label>
                        </span>
                        

                        <asp:DataList ID="datalistForPreviousMedicine" OnItemDataBound="datalistForPreviousMedicine_ItemDataBound" runat="server" DataKeyField="priscription_id" Width="100%">
                          
                        	
                            <ItemTemplate>
                               
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="assign" runat="server" ToolTip='<%# Eval("priscription_id") %>' /></td>
                                                <asp:HiddenField ID="hfMedicine_Name" runat="server" Value='<%# Eval("Medicine_Name") %>' />
                                                <asp:HiddenField ID="hfMedicine_Code" runat="server" Value='<%# Eval("MedCode") %>' />
                                                <td style="width: 200px;"><%# Eval("Medicine_Name") %> </td>
                                                <td valign="top">
                                                    <asp:DropDownList ID="DropDownList_routeForPreviousMedicine" runat="server" Style="width: 100%" DataSourceID="SqlDataSource_route"
                                                        DataValueField="Id" DataTextField="Description">
                                                    </asp:DropDownList>
                                                </td>
                                                <td valign="top">
                                                    <table class="tbl_form" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:DropDownList ID="DropDownList_frequencyNameForPreviousMedicine" runat="server" Width="100px" DataSourceID="SqlDataSource_Frequency"
                                                                        AutoPostBack="True" DataValueField="id" DataTextField="Name" OnSelectedIndexChanged="DropDownList_frequencyNameForPreviousMedicine_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="display: none">
                                                                    <asp:TextBox ID="TextBox_FrequencyForPreviousMedicine" runat="server" Width="16px"
                                                                        AutoPostBack="false" CssClass="dataListAltItemStyle " Style="display: none">1</asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <ul id="CollapsiblePanel1">
                                                        <li>
                                                            <asp:DataList ID="DataList_FrequencyForPreviousMedicine" runat="server" RepeatDirection="Horizontal"
                                                                RepeatColumns="10" DataKeyField="Frequency_Sub_Id">
                                                                <ItemTemplate>
                                                                    <asp:HiddenField ID="HF_F_S_IdForPreviousMedicine" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                                                    <div class="medbg">
                                                                        <asp:Label ID="FrequencyLabelForPreviousMedicine" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block; font-family: arial; font-size: 9px;"></asp:Label>
                                                                        <asp:TextBox ID="TextBox_dosage2ForPreviousMedicine" runat="server" Width="30px" Style="height: 12px; display: inline;">1</asp:TextBox>

                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                        </li>
                                                    </ul>
                                                </td>
                                                <td valign="top" align="center">
                                                    <asp:TextBox ID="TextBox_daysForPreviousMedicine" runat="server" CssClass="input_txt" Style="width: 100%" AutoPostBack="true">1</asp:TextBox>

                                                    <td valign="top">
                                                        <igsch:WebDateChooser ID="WebDateChooserPreviousStartDate" runat="server" CssClass="drop_date"
                                                            Width="100px">
                                                            <CalendarLayout Culture="English (United Kingdom)">
                                                            </CalendarLayout>
                                                        </igsch:WebDateChooser>
                                                    </td>



                                                    <td valign="top">
                                                        <asp:DropDownList ID="DropDownList_MealForPreviousMedicine" runat="server" Width="87px" Visible="true">
                                                            <asp:ListItem Value="NA">.NA</asp:ListItem>
                                                            <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                                            <asp:ListItem Value="After Meal">After</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:TextBox Visible="false" ID="txtboxBeforeMealForPreviousMedicine" TextMode="MultiLine" Style="width: 100%; height: 35px;" runat="server"></asp:TextBox>
                                                        <td>
                                                            <asp:TextBox ID="TextBoxInstructionForPreviousMedicine" Style="height: 35px;" runat="server" TextMode="MultiLine" CssClass="input_txt"></asp:TextBox>
                                                            <asp:TextBox Visible="false" ID="txtboxAfterMealForPreviousMedicine" TextMode="MultiLine" Style="width: 100%; height: 35px;" runat="server"></asp:TextBox>
                                                        </td>
                                            </tr>
                                        </tbody>
                                </table>
                                </li>                               
                            </ul>
                            </ItemTemplate>
                        </asp:DataList>
        
        
        </div>
        
             
                
                
                   
                     
                    <asp:RadioButtonList ID="rdoMedicineType" runat="server" RepeatDirection="Horizontal" Visible="false">
                        <asp:ListItem Text="Hospital Medication" Value="Hospital Medication" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Home Medication" Value="Home Medication"></asp:ListItem>
                    </asp:RadioButtonList>
                   
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceForDateList"
                        Width="100%" DataKeyNames="Column1" ShowHeader="False" Style="margin-top: 5px; display: none;">
                        <Columns>
                            <asp:BoundField DataField="Column1" HeaderText="Prescriptions Date" ReadOnly="True"
                                SortExpression="Column1" Visible="False" ShowHeader="False" />
                            <asp:ButtonField CommandName="Select" DataTextField="Column1" HeaderText="Prescription Date"
                                Text="Button" />
                        </Columns>
                        <RowStyle CssClass="GridItem" />
                        <FooterStyle CssClass="GridPager" />
                        <SelectedRowStyle CssClass="gridselect" />
                        <HeaderStyle CssClass="GridHeader" />
                        <EditRowStyle CssClass="gridedit" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceForDateList" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                        SelectCommand="SELECT distinct convert(varchar,date,103) FROM Pt_Prescription_Detail WHERE (Yearly_NO = @Yearly_NO) AND (Registration_NO = @Registration_NO)">
                        <SelectParameters>
                            <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" />
                            <asp:SessionParameter Name="Registration_NO" SessionField="registrationNo" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                     
                    
                <asp:SqlDataSource ID="SqlDataSource_dosage" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                    SelectCommand="SELECT Name FROM Medicine_Dosage" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_frequency" runat="server" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                        SelectCommand="SELECT     id, Name + ' (' + Occasion + ')' AS Name, CASE WHEN dbo.ufn_CountChar(Occasion, '+') > 0 THEN dbo.ufn_CountChar(Occasion, '+') ELSE 1000 END AS count&#13;&#10;FROM         Medicine_Frequency&#13;&#10;WHERE     (IS_Available = 1)"
                        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_route" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="Select_Medicine_Category" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                        SelectCommandType="StoredProcedure">
                       
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Medicine_Category" runat="server" />
                    <asp:HiddenField ID="HiddenField_dosage" runat="server" />
                    <asp:HiddenField ID="HiddenFieldDate" runat="server" />
                    <asp:HiddenField ID="HiddenField_yearly_no" runat="server" />
                    <asp:HiddenField ID="HiddenFieldDose" runat="server" />
                    <asp:HiddenField ID="HiddenField_Dilution" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSource_dilution" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="SELECT name FROM Medicine_Dilution" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"></asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenFieldStartDate" runat="server" />
                    <asp:HiddenField ID="HiddenFieldEndDate" runat="server" />
                    <asp:HiddenField ID="HiddenField_frequency" runat="server" />

                    <asp:HiddenField ID="HiddenField_CT" runat="server" />
                    <asp:HiddenField ID="HiddenField_start_date" runat="server" />
                    <asp:HiddenField ID="HiddenField_end_date" runat="server" />
                    <asp:HiddenField ID="HiddenField_priscription_id" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSource_Frequency_detail" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        InsertCommand="Insert_Patient_Frequency_Detail" InsertCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HiddenField_DL_Dosage" Name="Dosage" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenField_priscription_id" Name="Prescription_Id"
                                PropertyName="Value" Type="Decimal" />
                            <asp:ControlParameter ControlID="HiddenField_Frequency_Sub_Id" Name="Frequency_Sub_Id"
                                PropertyName="Value" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Prescription_Id" runat="server" />
                    <asp:HiddenField ID="HiddenField_Frequency_Sub_Id" runat="server" />
                    <asp:HiddenField ID="HiddenField_DL_Dosage" runat="server" />
                    <asp:HiddenField ID="HiddenField_flag" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        SelectCommand="SELECT [Medicine_Advice_Category_ID], [Medicine_Advice_Category_Name] FROM [Medicine_Advice_Category]"></asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_update_yearly_No" runat="server" />
                    <asp:HiddenField ID="HiddenField_update_Med_code" runat="server" />
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Medicine_Advice_Category_ID", "{0}") %>' />

                    <asp:HiddenField ID="HiddenField_Stop_Prescription_Id" runat="server" />
            
    
    <br />
    <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
    <asp:HiddenField ID="HiddenField_MedCode" runat="server" />
    <asp:HiddenField ID="HiddenField_MedCodeAllergic" runat="server" />

    <%--<input type="hidden" id="HiddenField_MedCode" runat="server" />--%>
    <asp:HiddenField ID="hdnSelectedTab" runat="server" />
 
    <asp:HiddenField ID="hfForAutoPostBack" runat="server" />
    
    
    
        
        </div><!--pageContent-->
  </div><!--main_bx-->
  
    
</asp:Content>
