<%@ page language="VB" autoeventwireup="false" inherits="Diagnosis, App_Web_p0fljamz" masterpagefile="~/hacims_masterpage.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

	<link rel="stylesheet" href="../resources/js/jquery.mCustomScrollbar.css??" />
	<script src="../resources/js/jquery.mCustomScrollbar.concat.min.js"></script>

  <script src="../css_hacims/ck.js" type="text/javascript"></script>
  <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
  <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
  
  <script>
  $(document).ready(function(e) {
    
	
	$(".leftMenu_Divcnt").mCustomScrollbar({ axis:"y",theme:"minimal-dark" });
	
});
  
  
  </script>
  
  
  <style type="text/css">
  
  .lightbox {width:250px; height:250px; }
  	.main_bx { margin-top:0px !important; }	
  </style>
   
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="lightbox_bgm"></div>
<div class="slideLeftMenu"><div id="menuScroll"><asp:Label ID="LabelSideMenu" runat="server" Visible="true"></asp:Label></div></div>
 <div class="main_bx">
 
 <div class="leftMenu_div" style="margin-top:47px;">
     		 <div class="leftMenu_divcnt"></div>
   	 </div><!--leftMenu_div-->
 
 
 <div class="pageContent" style="width:100%; padding-left:230px; box-sizing:border-box;">

  <asp:ScriptManager ID="ScriptManager1" runat="server">
    <Services>
      <asp:ServiceReference Path="../autocomplete.asmx" />
    </Services>
  </asp:ScriptManager>
  <cc1:AutoCompleteExtender 
              ID="AutoComplete_Search" 
              runat="server" 
             
              CompletionListCssClass="AutoExtender" 
   		      CompletionListItemCssClass="AutoExtenderList" 
   			  CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
                        
              CompletionInterval="10"  
              CompletionSetCount="12" 
              EnableCaching="true" 
              MinimumPrefixLength="3" 
              ServiceMethod="GetDiagnosisList"
              ServicePath="../AutoComplete.asmx" 
              TargetControlID="TextBox_Diagnosis_search"> </cc1:AutoCompleteExtender>
              
                 
      
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:-10px;">
          <tr>
            <td valign="top" width="50%"><div class="bxmain" style="width:98%;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                  <tr>
                    <td width="15%" align="right" ><strong>Add :</strong></td>
                    <td><asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label>
                      <asp:TextBox ID="TextBox_Diagnosis_search" runat="server"   AutoPostBack="True" CssClass="input_txt" Width="200px"  ></asp:TextBox>
                      &nbsp;
                      <asp:Button ID="Button1" runat="server" Text="New" Width="55px" Style="min-width:55px;"   />
                      <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceListBox" Visible="False"
DataTextField="Diagnosis_Name" DataValueField="Diagnosis_id" CssClass="all_listbox" Height="155px" Width="202px" style="margin-top:5px;"> </asp:ListBox></td>
                  </tr>
                </table>
              </div>
              <table cellpadding="0" cellspacing="0" border="0" width="98%"  class="Grid_1" style="margin-top:10px;"  >
                <tr>
                  <th align="left"  > <strong>Provisional Diagnosis</strong></th>
                </tr>
                <tr>
                  <td><ul class="diagnosis_list">
                      <asp:DataList ID="DataList_CurrentVisitDiagnosis" runat="server" DataKeyField="Diagnosis_ID"
                                         DataSourceID="SqlDataSource_DataListCurrnentDiagnosis" Width="100%" >
                        <alternatingitemstyle BackColor="#F0F0F0"></alternatingitemstyle>
                        <ItemTemplate>
                          <li>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("Diagnose Date") %>'></asp:Label>
                            &nbsp;&nbsp;|&nbsp;&nbsp;
                            <asp:Label ID="ICD10_CodeLabel" ToolTip="ICD10 Code name" style="color:#31448d;" runat="server" Text='<%# Eval("[ICD10 Code]") %>'> </asp:Label>
                            &nbsp;&nbsp;<span class="pro">(
                                <asp:LinkButton ID="LinkButton_Provision_Final" runat="server"   CommandName="Select"
                                    Enabled='<%# Eval("EN_DIS") %>' Text='<%# Eval("Final") %>'></asp:LinkButton>
                            <asp:Label ID="ProvisionalLabel" style="font-size:10px;" ToolTip="Provisional" runat="server" 
                                             Text='<%# Eval("Final") %>' Visible="False"></asp:Label>
                            )<asp:LinkButton ID="LinkButton_Cancel" runat="server" CommandArgument='<%# Eval("Diagnosis_ID") %>'
                                    CommandName="remove" Visible='<%# Eval("EN_DIS") %>'>Cancel</asp:LinkButton></span><br />
                            <asp:Label ToolTip="Disease Name" ID="DiseaseNameLabel" 
                                             style="color:#d71635; font-weight:bold; display:inline-block; margin-top:3px; text-transform:capitalize; " runat="server" Text='<%# Eval("DiseaseName") %>'> </asp:Label>
                          </li>
                          <asp:Label ID="YearlyNoLabel" Visible="false" runat="server" Text='<%# Eval("YearlyNo") %>'></asp:Label>
                          <strong>
                          <asp:Label Visible="false" ID="DoctorLabel" runat="server" Text='<%# Eval("Doctor") %>'></asp:Label>
                          </strong>
                          <asp:Label ID="FinalLabel" runat="server" Visible="false" Text='<%# Eval("Final") %>'></asp:Label>
                          <asp:Label ID="Diagnosis_IDLabel" Visible="false" runat="server" Text='<%# Eval("Diagnosis_ID") %>'> </asp:Label>
                        </ItemTemplate>
                      </asp:DataList>
                    </ul></td>
                </tr>
              </table></td>
            <td valign="top" width="50%"><table cellpadding="0" cellspacing="0" border="0" width="100%"  class="Grid_1" style="margin-top:5px;"  >
                <tr>
                  <th align="left" style="height: 28px"  > <strong>Previous Diagnosis</strong></th>
                </tr>
                <tr>
                  <td><ul class="diagnosis_list">
                      <asp:DataList ID="DataList1" runat="server" DataKeyField="Diagnosis_ID"
                                         DataSourceID="SqlDataSource1" Width="100%" >
                        <alternatingitemstyle BackColor="#F0F0F0"></alternatingitemstyle>
                        <ItemTemplate>
                          <li>
                            <asp:Label ID="Label5" runat="server" ToolTip='<%# Eval("Diagnose Date") %>' Text='<%# Eval("Diagnose Date") %>'></asp:Label>
                            &nbsp;| &nbsp;&nbsp;<asp:Label ID="DoctorLabel" runat="server" Text='<%# Eval("Doctor") %>'></asp:Label>
                            <asp:Label ID="ICD10_CodeLabel" runat="server" Style="color: #31448d" Text='<%# Eval("[ICD10 Code]") %>'
                                                     ToolTip="ICD10 Code name"> </asp:Label>
                            <span class="pro">(
                            <asp:Label ID="ProvisionalLabel" style="font-size:10px;" runat="server" Text='<%# Eval("Provisional") %>'
                                                     ToolTip="Provisional"> </asp:Label>
                            )</span><br />
                            <asp:Label ID="DiseaseNameLabel" runat="server" style="color:#d71635; font-weight:bold; display:inline-block; margin-top:3px;"  Text='<%# Eval("DiseaseName") %>' ToolTip="Disease Name"> </asp:Label>
                          </li>
                          <asp:Label ID="YearlyNoLabel" runat="server" Text='<%# Eval("YearlyNo") %>' Visible="false"></asp:Label>&nbsp;<strong>
                          </strong>
                          <asp:Label ID="FinalLabel" runat="server" Text='<%# Eval("Final") %>' Visible="false"></asp:Label>
                          <asp:Label ID="Diagnosis_IDLabel" runat="server" Text='<%# Eval("Diagnosis_ID") %>'
                                                 Visible="false"> </asp:Label>
                        </ItemTemplate>
                      </asp:DataList>
                    </ul></td>
                </tr>
              </table>
                <asp:Panel ID="Panel_Update_Dignosis" runat="server"   Width="100%" CssClass="lightbox_bg" Visible="false">
                  <div class="lightbox">
                  <asp:ImageButton ID="ImageButton_Pnl_Close" runat="server" ImageAlign="Left" ImageUrl="~/images_hacims/icon_delete.gif" style="float:right;" />
                  <table width="100%" border="1" cellspacing="3" cellpadding="3">
  <tr>
    <td align="right">Select :</td>
    <td> <asp:CheckBoxList ID="CheckBoxList_ProvisionFinal" runat="server" RepeatDirection="Horizontal"
                        RepeatLayout="Flow">
                        <asp:ListItem Selected="True">Provision</asp:ListItem>
                        <asp:ListItem>Final</asp:ListItem>
                    </asp:CheckBoxList></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td> <asp:Button ID="Button_Update" runat="server" Text="Update" /></td>
  </tr>
</table>

                   
                   
                    
               </div>     
                 
                    
                    </asp:Panel>
                    
                    
                    
            </td>
          </tr>
        </table>
        <br />
        <div class="bxmain" style="margin-left:5px; width:97%; display:none;">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
              <td align="right" width="25%">Add New :</td>
              <td><asp:TextBox ID="TextBoxDiagnosis" runat="server"   ></asp:TextBox>
                &nbsp; </td>
            </tr>
            <tr>
              <td align="right">Type :</td>
              <td><asp:CheckBoxList ID="CheckBoxListDiagnosis" RepeatColumns="5" runat="server">
                  <asp:ListItem Value="1">Provisional</asp:ListItem>
                  <asp:ListItem Value="1">Final</asp:ListItem>
                </asp:CheckBoxList></td>
            </tr>
          </table>
        </div>
        <asp:SqlDataSource ID="SqlDataSourceNew" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                InsertCommand="INSERT INTO pt_Diagnosis(emp_id, YearlyNo, RegNo, Past, Provisional, Final, DiseaseName) VALUES (@emp_id, @YearlyNo,@RegNo,@Past, @Provisional, @Final, @DiseaseName)"
                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
          <InsertParameters>
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
            <asp:ControlParameter ControlID="HiddenFieldPastNew" Name="Past" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldProvisionalNew" Name="Provisional" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldFinalNew" Name="Final" PropertyName="Value" />
            <asp:ControlParameter ControlID="TextBoxDiagnosis" Name="DiseaseName" PropertyName="Text" />
          </InsertParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenFieldPastNew" runat="server" />
          <br /><asp:HiddenField ID="HF_Diagnosis_ID" runat="server" />
          <asp:SqlDataSource ID="SqlDataSource_UpdateDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                InsertCommand="INSERT INTO pt_Diagnosis(emp_id, YearlyNo, RegNo, Past, Provisional, Final, DiseaseName) VALUES (@emp_id, @YearlyNo,@RegNo,@Past, @Provisional, @Final, @DiseaseName)"
                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" UpdateCommand="UPDATE    pt_Diagnosis&#13;&#10;SET              Provisional = NULL, Final = 1&#13;&#10;WHERE     (Diagnosis_ID = @Diagnosis_ID)" DeleteCommand="delete&#13;&#10;FROM         pt_Diagnosis&#13;&#10;WHERE     (Diagnosis_ID = @Diagnosis_ID) AND (YearlyNo = @YearlyNo) AND (RegNo = @RegNo)">
              <UpdateParameters>
                  <asp:ControlParameter ControlID="DataList_CurrentVisitDiagnosis" Name="Diagnosis_ID"
                      PropertyName="SelectedValue" />
              </UpdateParameters>
              <InsertParameters>
                  <asp:SessionParameter Name="emp_id" SessionField="emp_id" />
                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                  <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                  <asp:ControlParameter ControlID="HiddenFieldPastNew" Name="Past" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenFieldProvisionalNew" Name="Provisional" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenFieldFinalNew" Name="Final" PropertyName="Value" />
                  <asp:ControlParameter ControlID="TextBoxDiagnosis" Name="DiseaseName" PropertyName="Text" />
              </InsertParameters>
              <DeleteParameters>
                  <asp:ControlParameter ControlID="HF_Diagnosis_ID" Name="Diagnosis_ID" PropertyName="Value" />
                  <asp:SessionParameter Name="YearlyNo" SessionField="yearlyno" />
                  <asp:SessionParameter Name="RegNo" SessionField="registrationno" />
              </DeleteParameters>
          </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenFieldProvisionalNew" runat="server" />
        <asp:HiddenField ID="HiddenFieldFinalNew" runat="server" />
        <asp:SqlDataSource ID="SqlDataSourceListBox" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="SELECT Diagnosis_Name, Diagnosis_id FROM Diagnosis_For_Department WHERE (SudDept_id = @SudDept_id) AND (Dept_id = @Dept_id) AND (Diagnosis_Name LIKE '%' + @Diagnosis + '%')&#13;&#10;Order by Diagnosis_Name">
          <SelectParameters>
            <asp:SessionParameter Name="SudDept_id" SessionField="SubDeptID" />
            <asp:SessionParameter Name="Dept_id" SessionField="Dept_id" />
            <asp:ControlParameter ControlID="TextBox_Diagnosis_search" DefaultValue="%" Name="Diagnosis"
                                  PropertyName="Text" />
          </SelectParameters>
        </asp:SqlDataSource>
        <div class="bxmain" style="margin-left:5px; width:97%; display:none;" >
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="right" width="25%">Search ICD Codewise :</td>
              <td><asp:TextBox ID="TextBoxSearch" runat="server" AccessKey="n"  
            TabIndex="7" Width="302px" ></asp:TextBox>
                <asp:Button ID="SearchButton" runat="server" Text="Search" Width="55px"   /></td>
            </tr>
          </table>
        </div>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" Width="100%"   DataKeyNames="sectionID" AllowPaging="True">
          <Columns>
          <asp:BoundField DataField="sectionID" HeaderText="ICD Code" SortExpression="sectionID" />
          <asp:HyperLinkField DataNavigateUrlFields="sectionID,title" DataNavigateUrlFormatString="~/DiagnosisDetail.aspx?disease={1}&amp;icd={0}"
              DataTextField="sectionID" HeaderText="ICD10 Code" Visible="False" />
          <asp:BoundField DataField="Title" HeaderText="Disease" SortExpression="Title" />
          <asp:TemplateField HeaderText="Past">
            <EditItemTemplate>
              <asp:CheckBox ID="CheckBox1" runat="server" />
            </EditItemTemplate>
            <ItemTemplate>
              <asp:CheckBox ID="CheckBox1" runat="server" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Provisional">
            <EditItemTemplate>
              <asp:CheckBox ID="CheckBox2" runat="server" />
            </EditItemTemplate>
            <ItemTemplate>
              <asp:CheckBox ID="CheckBox2" runat="server" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Final">
            <ItemTemplate>
              <asp:CheckBox ID="CheckBox3" runat="server" />
            </ItemTemplate>
          </asp:TemplateField>
          </Columns>
          <RowStyle CssClass="GridItem" />
          <AlternatingRowStyle CssClass="GridAltItem" />
          <PagerStyle CssClass="GridPager" />
        </asp:GridView>
        <br />
        <asp:SqlDataSource ID="SqlDataSource_DataListCurrnentDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                             ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                             SelectCommand="SELECT DISTINCT pt_Diagnosis.YearlyNo, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + '' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ')' AS Doctor, ISNULL(pt_Diagnosis.DiseaseName, '') AS DiseaseName, ISNULL(pt_Diagnosis.dsCode, '') AS [ICD10 Code], &#13;&#10;CASE WHEN pt_Diagnosis.Provisional = 1 THEN 'Provisional' ELSE '' END AS Provisional, &#13;&#10;case when (CASE WHEN pt_Diagnosis.Provisional = 1 THEN 'Provisional' ELSE '' END  =  'Provisional') then  'Provisional' else&#13;&#10;(case when (CASE WHEN pt_Diagnosis.Final = 1 THEN 'Final' ELSE '' END = 'Final') then 'Final' else '' end) end&#13;&#10;AS Final,&#13;&#10;case when (CASE WHEN pt_Diagnosis.Provisional = 1 THEN 'Provisional' ELSE '' END  =  'Provisional') then  1 else&#13;&#10;(case when (CASE WHEN pt_Diagnosis.Final = 1 THEN 'Final' ELSE '' END = 'Final') then 0 else 1 end) end&#13;&#10;AS EN_DIS,&#13;&#10; pt_Diagnosis.Diagnosis_ID, CONVERT (varchar, pt_Diagnosis.DiagnoseDate, 103) AS [Diagnose Date] FROM Designation RIGHT OUTER JOIN Employee ON Designation.Designation_ID = Employee.DesignationID RIGHT OUTER JOIN pt_Diagnosis ON Employee.EmpID = pt_Diagnosis.emp_id WHERE (pt_Diagnosis.YearlyNo = @yearlyNo) AND (pt_Diagnosis.RegNo = @regno)">
          <SelectParameters>
            <asp:SessionParameter Name="yearlyNo" SessionField="yearlyno" />
            <asp:SessionParameter Name="regno" SessionField="registrationno" />
          </SelectParameters>
        </asp:SqlDataSource>
        <br />
        
        
        
        
        
        <div align="center" style="display:none;">
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                             ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                             SelectCommand="Select_Diagnosis" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
            </SelectParameters>
          </asp:SqlDataSource>
          <asp:Button ID="ButtonSave" runat="server" Text="Save"   />
        </div>
        <br />
        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" style="display:none;"  
                        DataSourceID="SqlDataSourceGridView" Width="100%" DataKeyNames="Diagnosis_ID">
          <Columns>
          <asp:CommandField ShowDeleteButton="True" />
          <asp:TemplateField Visible="False">
            <EditItemTemplate>
              <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />
              &nbsp;
              <asp:ImageButton
                                        ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
            </EditItemTemplate>
            <ItemTemplate>
              <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                                        OnClientClick="return confirmation_edit(this)" />
              &nbsp;
              <asp:ImageButton ID="ImageButton2"
                                            runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif" OnClientClick="return confirmation(this)" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="Diagnosis_ID" HeaderText="Diagnosis ID" InsertVisible="False"
                                ReadOnly="True" SortExpression="Diagnosis_ID" />
          <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                                Visible="False" />
          <asp:BoundField DataField="DiseaseName" HeaderText="Disease Name" SortExpression="DiseaseName" ReadOnly="True" />
          <asp:BoundField DataField="ICD10 Code" HeaderText="ICD10 Code" SortExpression="ICD10 Code" ReadOnly="True" />
          <asp:TemplateField HeaderText="Past" SortExpression="Past">
            <EditItemTemplate>
              <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Bind("Past") %>' />
            </EditItemTemplate>
            <ItemTemplate>
              <asp:Label ID="Label1" runat="server" Text='<%# Bind("Past") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Provisional" SortExpression="Provisional">
            <EditItemTemplate>
              <asp:CheckBox ID="CheckBox5" runat="server" Checked='<%# Bind("Provisional") %>' />
            </EditItemTemplate>
            <ItemTemplate>
              <asp:Label ID="Label2" runat="server" Text='<%# Bind("Provisional") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Final" SortExpression="Final">
            <EditItemTemplate>
              <asp:CheckBox ID="CheckBox6" runat="server" Checked='<%# Bind("Final") %>' />
            </EditItemTemplate>
            <ItemTemplate>
              <asp:Label ID="Label3" runat="server" Text='<%# Bind("Final") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="Doctor" HeaderText="Doctor" SortExpression="Doctor"
                                Visible="False" />
          </Columns>
          <RowStyle CssClass="GridItem" />
          <HeaderStyle CssClass="GridHeader" />
          <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceGridView" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="pt_get_diagnosis"
                        SelectCommandType="StoredProcedure" UpdateCommand="UPDATE pt_Diagnosis SET Past = @Past, Provisional = @Provisional, Final = @Final WHERE (Diagnosis_ID = @Diagnosis_ID)" DeleteCommand="DELETE FROM pt_Diagnosis WHERE (Diagnosis_ID = @Diagnosis_ID)">
          <SelectParameters>
            <asp:SessionParameter Name="COD" SessionField="YearlyNo" Type="String" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
          </SelectParameters>
          <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldPastUpdate" Name="Past" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldProvisonalUpdate" Name="Provisional"
                                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldFinalUpdate" Name="Final" PropertyName="Value" />
            <asp:Parameter Name="Diagnosis_ID" />
          </UpdateParameters>
          <DeleteParameters>
            <asp:Parameter Name="Diagnosis_ID" />
          </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                SelectCommand="SELECT     distinct dbo.ICD10_DiseaseSection.Title,dbo.ICD10_DiseaseSection.sectionID
FROM         dbo.ICD10_DiseaseSection 

WHERE     (dbo.ICD10_DiseaseSection.Title like '%' + @abc +'%')
order by ICD10_DiseaseSection.sectionID" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
          <SelectParameters>
            <asp:ControlParameter ControlID="TextBoxSearch" Name="abc" PropertyName="Text" />
          </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenFieldDiagnosis" runat="server" />
        <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        InsertCommand="INSERT INTO pt_Diagnosis(emp_id, YearlyNo, RegNo, dsCode, Past, Provisional, DiseaseName, diseaseCode) VALUES (@emp_id, @YearlyNo, @RegNo, @dsCode, @Past, @Provisional, @DiseaseName, @diseaseCode)"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
          <InsertParameters>
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
            <asp:ControlParameter ControlID="HiddenFieldDiagnosis" Name="dsCode" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldPast" Name="Past" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldProvisional" Name="Provisional" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldDisease" Name="DiseaseName" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldDiagnosis" Name="diseaseCode" PropertyName="Value" />
          </InsertParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenFieldPast" runat="server" />
        <asp:HiddenField ID="HiddenFieldProvisional" runat="server" />
        <asp:HiddenField ID="HiddenFieldDisease" runat="server" />
        <asp:HiddenField ID="HiddenFieldFinal" runat="server" />
        <asp:HiddenField ID="HiddenFieldPastUpdate" runat="server" />
        <asp:HiddenField ID="HiddenFieldProvisonalUpdate" runat="server" />
        <asp:HiddenField ID="HiddenFieldFinalUpdate" runat="server" />
        <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" />
        <asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
        <br />
        <br />
        <br /> 
  <asp:Label ID="LabelFooter" runat="server" Text="" Visible="false"></asp:Label>
  
      
        </div><!--pageContent-->
  </div><!--main_bx-->
  
  
</asp:Content>
