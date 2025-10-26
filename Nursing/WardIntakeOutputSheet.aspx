<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage.master"
    CodeFile="WardIntakeOutputSheet.aspx.cs" Inherits="WardIntakeOutputSheet" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../css_hacims/ck.js" type="text/javascript"></script>

    <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

    <script type="text/javascript">

$(document).ready(function(e) {
if($("#ctl00_ContentPlaceHolder1_TextBox_amount").val()==""){
		
 $("#ctl00_ContentPlaceHolder1_Button4").attr('disabled',true);
 } 
  
$("#ctl00_ContentPlaceHolder1_TextBox_amount").keydown(function(){
	  
	  
	  if($("#ctl00_ContentPlaceHolder1_TextBox_amount").val()!=""){
		
		$("#ctl00_ContentPlaceHolder1_Button4").attr('disabled',false);
	 } 
	  
	  });
 
	
	 if($("#ctl00_ContentPlaceHolder1_TextBox_output_amount").val()==""){
		
		$("#ctl00_ContentPlaceHolder1_Button5").attr('disabled',true);
 } 
  
  $("#ctl00_ContentPlaceHolder1_TextBox_output_amount").keydown(function(){
	  
	  
	  if($("#ctl00_ContentPlaceHolder1_TextBox_output_amount").val()!=""){
		
		$("#ctl00_ContentPlaceHolder1_Button5").attr('disabled',false);
	 } 
	  
	  });
	
	 
	
});

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="leftnav" valign="top">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
                <asp:Panel ID="Panel1" runat="server" Visible="False">
                </asp:Panel>
            </td>
            <td style="width: auto;" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" width="50%">
                            <div class="bxmain">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                    <tr>
                                        <td align="left">
                                            <asp:Panel runat="server" ID="pnlInTake" Visible ="false">
                                                &nbsp;&nbsp;Name :
                                                <asp:TextBox ID="TextBox_name" runat="server" CssClass="input_txt" Width="55px"></asp:TextBox>
                                                Unit :
                                                <asp:TextBox ID="TextBox_unit" runat="server" CssClass="input_txt" Width="55px"></asp:TextBox>&nbsp;<asp:Button
                                                    ID="Button2" runat="server" Text="ADD New" OnClick="Button2_Click1" Width="65px" />
                                                <asp:Button ID="Button7" runat="server" Text="Report" OnClick="Button7_Click" Width="65px" />
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 18px">
                                            <fieldset class="fset_1" style="width:95%">
                                                <legend>INTAKE</legend>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                    <tr>
                                                        <td align="right">
                                                            Date :
                                                        </td>
                                                        <td>
                                                            <igsch:WebDateChooser ID="WebDateChooserIntake" runat="server" Format="Long" CssClass="drop_date"
                                                                Width="182px">
                                                                <CalendarLayout Culture="English (United Kingdom)">
                                                                </CalendarLayout>
                                                            </igsch:WebDateChooser>
                                                        </td>
                                                        <td>
                                                             Shift:  <asp:DropDownList ID="DropDownList1" Enabled="false" Width="80px" runat="server">
                                                        <asp:ListItem Value="1">
                                                            Day
                                                        </asp:ListItem>
                                                          <asp:ListItem Value="2">
                                                              Night
                                                        </asp:ListItem>
                                                                  <asp:ListItem Value="3">
                                                              Morning
                                                        </asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                                
                                                <br />
                                                <asp:DropDownList ID="DropDownList_In_Route" runat="server" CssClass="text_boxtitle"
                                                    DataSourceID="SqlDataSource_In" DataTextField="Description" DataValueField="Id"
                                                    Width="109px">
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="DropDownList_insert_Component" runat="server" DataSourceID="SqlDataSource_intake_Component"
                                                    DataTextField="Name" DataValueField="id" Width="109px">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSource_intake_Component" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                                                    InsertCommand="Patient_Component_insert" InsertCommandType="StoredProcedure"
                                                    ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="SELECT patient_intake_output_component.Name + ' (' + patient_intake_output_component.Unit + ') ' AS Name, patient_intake_output_component.id FROM patient_intake_output_component LEFT OUTER JOIN IO_Component_Department ON patient_intake_output_component.id = IO_Component_Department.component_id WHERE (patient_intake_output_component.Type = 1)">
                                                    <InsertParameters>
                                                        <asp:ControlParameter ControlID="TextBox_name" Name="Name" PropertyName="Text" Type="String" />
                                                        <asp:ControlParameter ControlID="TextBox_unit" Name="Unit" PropertyName="Text" Type="String" />
                                                        <asp:SessionParameter Name="dept_id" SessionField="dapt_id" Type="Int32" />
                                                        <asp:SessionParameter Name="subdept_id" SessionField="Subdeptid" Type="Int32" />
                                                    </InsertParameters>
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="dept_id" SessionField="dept_id" />
                                                        <asp:SessionParameter Name="subdept_id" SessionField="subdeptid" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <asp:TextBox ID="TextBox_amount" runat="server" CssClass="input_txt" Width="53px"></asp:TextBox>
                                                <br />
                                                <br />
                                                <asp:TextBox ID="txtIntake_Remarks" runat="server" Width="245px" TextMode="MultiLine" CausesValidation="false" Height="45px" ></asp:TextBox>
                                                <br />
                                                <asp:Button ID="Button4" runat="server" Text="Save" OnClick="Button4_Click" CssClass="btn1"
                                                    Width="60px" />
                                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="Cancel" CssClass="btn1"
                                                    Width="60px" />
                                            </fieldset>
                                        </td>
                                    </tr>
                                </table>
                                <asp:SqlDataSource ID="SqlDataSource_In" runat="server" ConnectionString="<%$ ConnectionStrings:Pharmacy_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Pharmacy_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT Id, Description FROM Medicine_Route WHERE (Type = 'I')"></asp:SqlDataSource>
                            </div>
                            <br />
                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                Width="100%" OnPreRender="GridView1_PreRender" DataKeyNames="id" DataSourceID="SqlDataSource_intake"
                                OnRowDataBound="GridView1_RowDataBound" PageSize="30" EnableViewState="False"
                                OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                <Columns>
                                    <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                                    <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="id" Visible="False" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:BoundField DataField="Amount" HeaderText="Volume" SortExpression="Amount" />
                                    <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                                    <asp:BoundField HeaderText="Total" />
                                    <asp:BoundField DataField="Remraks" HeaderText="Remraks" SortExpression="Remraks" />
                                </Columns>
                                <RowStyle CssClass="GridItem" Height="8px" />
                                <PagerStyle CssClass="GridPager" />
                                <SelectedRowStyle CssClass="gridselect" />
                                <HeaderStyle CssClass="GridHeader" />
                                <EditRowStyle CssClass="gridedit" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_intake" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                                InsertCommand="Patient_intake_insert_With_Remarks" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>"
                                SelectCommand="Patient_intake_select" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value"
                                        Type="Int32" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="Registration_No"
                                        PropertyName="Value" Type="String" />
                                    <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value"
                                        Type="Int32" />
                                    <asp:ControlParameter ControlID="DropDownList_insert_Component" Name="Component_Id"
                                        PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="TextBox_amount" Name="Amount" PropertyName="Text"
                                        Type="Int32" />
                                    <asp:ControlParameter ControlID="DropDownList_In_Route" Name="Intake_Method" PropertyName="SelectedValue"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="HiddenFieldIntake_DateTime" Name="Date_Time" PropertyName="Value"
                                        Type="DateTime" />
                                    <asp:ControlParameter ControlID="HiddenFieldWhen_Take" Name="When_Take" PropertyName="Value"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="hf_Remarks_ID" Name="pt_Intake_outake_Remark_ID"
                                        PropertyName="Value" Type="Int32" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            
                                                        <asp:SqlDataSource ID="SqlDataSource_intake_Remarks" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                                InsertCommand="INSERT_Patient_Intake_OutTake_Remarks" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" OnInserted="SqlDataSource_intake_Remarks_Inserted">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="hf_Remarks" Name="Remraks" PropertyName="Value"
                                        Type="String" />
                                    <asp:SessionParameter Name="Emp_ID" SessionField="emp_ID" Type="Int32" />
                                    <asp:Parameter Direction="Output" Name="Identity" Type="Int32" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="hf_Remarks" runat="server" />
                            <asp:HiddenField ID="hf_Remarks_ID" runat="server" />
                            

                            <asp:HiddenField ID="HiddenFieldWhen_Take" runat="server" />
                            <asp:HiddenField ID="HiddenFieldIntake_DateTime" runat="server" />
                            <br />
                            <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
                            <br />
                            <asp:GridView ID="GridView_Intake_Summery" runat="server" AutoGenerateColumns="False"
                                CssClass="Grid_1" DataSourceID="SqlDataSource_IntakeSummery" Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:BoundField DataField="When_Take" HeaderText="When Take" SortExpression="When_Take" />
                                    <asp:BoundField DataField="Expr1" HeaderText="Total Volume" SortExpression="Expr1" />
                                    <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                                </Columns>
                                <RowStyle CssClass="GridItem" />
                                <PagerStyle CssClass="GridPager" />
                                <SelectedRowStyle CssClass="gridselect" />
                                <HeaderStyle CssClass="GridHeader" />
                                <EditRowStyle CssClass="gridedit" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                            <br />
                            <asp:SqlDataSource ID="SqlDataSource_IntakeSummery" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                                SelectCommand="Patient_IntakeOutput_Summery" SelectCommandType="StoredProcedure"
                                ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value"
                                        Type="Decimal" />
                                    <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="Reg_NO" PropertyName="Value"
                                        Type="String" />
                                    <asp:Parameter DefaultValue="true" Name="intake_output_Type" Type="Boolean" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <br />
                        </td>
                        <td valign="top" width="50%">
                            <div style="margin-left: 10px;">
                                <div class="bxmain">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                        <tr>
                                            <td align="left">
                                                <asp:Panel runat="server" ID="pnlOutput" Visible="false">
                                                    Name :
                                                    <asp:TextBox ID="TextBox_output_name" runat="server" CssClass="input_txt" Width="55px"></asp:TextBox>
                                                    Unit :
                                                    <asp:TextBox ID="TextBox_output_unit" runat="server" CssClass="input_txt" Width="55px"></asp:TextBox>
                                                    <asp:Button ID="Button3" runat="server" Text="ADD New" OnClick="Button3_Click1" Width="65px" />
                                                    <asp:Button ID="Button8" runat="server" Text="Report" OnClick="Button8_Click" Width="65px" />
                                                </asp:Panel>
                                                &nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td style="height: 18px">
                                                <fieldset class="fset_1" style="width:95%">
                                                    <legend>OUTPUT</legend>
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                        <tr>
                                                            <td align="right">
                                                                Date :
                                                            </td>
                                                            <td>
                                                                <igsch:WebDateChooser ID="WebDateChooserOutPut" runat="server" Format="Long" CssClass="drop_date"
                                                                    Width="182px">
                                                                    <CalendarLayout Culture="English (United Kingdom)">
                                                                    </CalendarLayout>
                                                                </igsch:WebDateChooser>
                                                            </td>
                                                            <td>
                                                                 Shift:  <asp:DropDownList ID="DDLShift" Width="80px" Enabled="false" runat="server">
                                                        <asp:ListItem Value="1">
                                                            Day
                                                        </asp:ListItem>
                                                          <asp:ListItem Value="2">
                                                              Night
                                                        </asp:ListItem>
                                                                     <asp:ListItem Value="3">
                                                              Morning
                                                        </asp:ListItem>
                                                            </asp:DropDownList>
                                                            </td>
                                                         
                                                        </tr>
                                                         
                                                    </table>
                                                   
                                                    <br />
                                               
                                                    <asp:DropDownList ID="DropDownList_route_Out" runat="server" CssClass="text_boxtitle"
                                                        DataSourceID="SqlDataSource_Out" DataTextField="Description" DataValueField="Id"
                                                        Width="109px">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="DropDownList_output" runat="server" DataSourceID="SqlDataSource_output_Component"
                                                        DataTextField="Name" DataValueField="id" Width="109px">
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="SqlDataSource_output_Component" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                                                        InsertCommand="Patient_OutComponent_insert" InsertCommandType="StoredProcedure"
                                                        ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="SELECT Name + ' (' + Unit + ') ' AS Name, id FROM patient_intake_output_component WHERE (Type = 0)">
                                                        <InsertParameters>
                                                            <asp:ControlParameter ControlID="TextBox_output_name" Name="Name" PropertyName="Text"
                                                                Type="String" />
                                                            <asp:ControlParameter ControlID="TextBox_output_unit" Name="Unit" PropertyName="Text"
                                                                Type="String" />
                                                        </InsertParameters>
                                                    </asp:SqlDataSource>
                                                    <asp:TextBox ID="TextBox_output_amount" CssClass="input_txt" runat="server" Width="53px"></asp:TextBox>
                                                    <br />
                                                    <asp:SqlDataSource ID="SqlDataSource_Out" runat="server" ConnectionString="<%$ ConnectionStrings:Pharmacy_ConnectionString %>"
                                                        ProviderName="<%$ ConnectionStrings:Pharmacy_ConnectionString.ProviderName %>"
                                                        SelectCommand="SELECT Id, Description FROM Medicine_Route WHERE (Type = 'O')"></asp:SqlDataSource>
                                                    <br />
                                                    <asp:TextBox ID="txtOutput_Remarks" runat="server" TextMode="MultiLine"
                                                       Width="245px" Height="45px"></asp:TextBox>
                                                 
                                                    <br />
                                                 
                                                    <asp:Button ID="Button5" runat="server" Text="Save" OnClick="Button5_Click" CssClass="btn1"
                                                        Width="60px" />
                                                    <asp:Button ID="Button6" runat="server" Text="Cancel" OnClick="Button6_Click" CssClass="btn1"
                                                        Width="60px" />
                                                    <br />
                                                </fieldset>

                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <br />
                                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                    Width="100%" OnPreRender="GridView2_PreRender" DataKeyNames="id,component_ID"
                                    DataSourceID="SqlDataSource_output" OnRowDataBound="GridView1_RowDataBound1"
                                    PageSize="30" EnableViewState="False" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                    <Columns>
                                        <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                                        <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                                        <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True"
                                            SortExpression="id" Visible="False" />
                                        <asp:ButtonField CommandName="Select" DataTextField="Name" HeaderText="Name" />
                                        <asp:BoundField DataField="Amount" HeaderText="Volume" SortExpression="Amount" />
                                        <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                                        <asp:BoundField HeaderText="Total" />
                                        <asp:BoundField DataField="Remraks" HeaderText="Remraks" SortExpression="Remraks" />
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <PagerStyle CssClass="GridPager" />
                                    <SelectedRowStyle CssClass="gridselect" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <EditRowStyle CssClass="gridedit" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource_output" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                                    InsertCommand="Patient_intake_insert_With_Remarks" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>"
                                    SelectCommand="Patient_output_select" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                        <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value"
                                            Type="Int32" />
                                    </SelectParameters>
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="Registration_No"
                                            PropertyName="Value" Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value"
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="DropDownList_output" DefaultValue="" Name="Component_Id"
                                            PropertyName="SelectedValue" Type="Int32" />
                                        <asp:ControlParameter ControlID="TextBox_output_amount" Name="Amount" PropertyName="Text"
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="HiddenFieldOutput_DateTime" Name="Date_Time" PropertyName="Value"
                                            Type="DateTime" />
                                        <asp:ControlParameter ControlID="HiddenFieldWhen_Take_Output" Name="When_Take" PropertyName="Value"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="DropDownList_route_Out" Name="Intake_Method" PropertyName="SelectedValue"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="hf_Remarks_ID" Name="pt_Intake_outake_Remark_ID"
                                            PropertyName="Value" Type="Int32" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenFieldOutput_DateTime" runat="server" />
                                <asp:HiddenField ID="HiddenFieldWhen_Take_Output" runat="server" />
                                <br />
                                <asp:Label ID="Label2" runat="server" Text="Label" Visible="False"></asp:Label>
                                <br />
                                <asp:GridView ID="GridView_Output_Summery" runat="server" AutoGenerateColumns="False"
                                    DataSourceID="SqlDataSource_OutputSummery" Width="100%">
                                    <Columns>
                                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                        <asp:BoundField DataField="When_Take" HeaderText="When Take" SortExpression="When_Take" />
                                        <asp:BoundField DataField="Expr1" HeaderText="Total Volume" SortExpression="Expr1" />
                                        <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <PagerStyle CssClass="GridPager" />
                                    <SelectedRowStyle CssClass="gridselect" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <EditRowStyle CssClass="gridedit" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <br />
                                <asp:SqlDataSource ID="SqlDataSource_OutputSummery" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                                    SelectCommand="Patient_IntakeOutput_Summery" SelectCommandType="StoredProcedure"
                                    ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="Yearly_No" PropertyName="Value"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="Reg_NO" PropertyName="Value"
                                            Type="String" />
                                        <asp:Parameter DefaultValue="false" Name="intake_output_Type" Type="Boolean" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_Qty" runat="server" />
                                <asp:HiddenField ID="HiddenField_mcode" runat="server" />
                                <asp:HiddenField ID="HiddenField_Yearly_No" runat="server" />
                                <asp:HiddenField ID="HiddenField_Emp_Id" runat="server" />
                                <asp:HiddenField ID="HiddenField_Registration_No" runat="server" />
                                <asp:Label ID="Label_Error" runat="server" ForeColor="Red"></asp:Label><asp:HiddenField
                                    ID="HiddenFieldToolTIp" runat="server" Value="true" />
                                <asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" valign="top">
                            <div class="bxmain">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                    <tr>
                                        <td align="right" width="40%">
                                            Date :</td>
                                        <td>
                                            <igsch:WebDateChooser ID="wdcIntakeOutput" runat="server" Editable="False" CssClass="drop_date"
                                                Width="202px" OnValueChanged="wdcIntakeOutput_ValueChanged">
                                                <AutoPostBack ValueChanged="True"></AutoPostBack>
                                                <CalendarLayout Culture="English (United Kingdom)">
                                                </CalendarLayout>
                                            </igsch:WebDateChooser>
                                            <div style="position: absolute; margin-top: -27px; margin-left: 210px;">
                                                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click" CssClass="report">Detail Report</asp:LinkButton>
                                                <asp:Button ID="Buttonreport" runat="server" Text="Report" OnClick="Buttonreport_Click" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <br />
                            <div>
                                <asp:GridView ID="GridView_Intake" runat="server" AutoGenerateColumns="False" ShowFooter="True"
                                    OnPreRender="GridView_Intake_PreRender" Width="100%">
                                    <Columns>
                                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                                        <asp:BoundField DataField="Time" HeaderText="Time Period" SortExpression="Time" />
                                        <asp:TemplateField HeaderText="Intake">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <table width="100%">
                                                    <tr>
                                                        <td align="center" width="16.6%">
                                                            <asp:Label ID="Label_Total_Oral" runat="server"></asp:Label></td>
                                                        <td align="center" width="16.6%">
                                                            <asp:Label ID="Label_CvpLine" runat="server"></asp:Label></td>
                                                        <td align="center" width="16.6%">
                                                            <asp:Label ID="Label_Total_IV" runat="server"></asp:Label></td>
                                                        <td width="16.6%" align="center">
                                                            <asp:Label ID="Label_Total_NG" runat="server"></asp:Label></td>
                                                        <td align="center" width="16.6%">
                                                            <asp:Label ID="Label_Other" runat="server"></asp:Label></td>
                                                        <td width="16.6%" align="center">
                                                            <asp:Label ID="Label_G_Total" runat="server"></asp:Label></td>
                                                    </tr>
                                                 
                                                </table>
                                            </FooterTemplate>
                                            <HeaderTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                    <tr>
                                                        <td colspan="9" align="center">
                                                            <strong style="color: #03C;">Intake</strong></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="16.6%" align="center">
                                                            <strong>Oral</strong></td>
                                                        <td align="center" width="16.6%">
                                                            <strong>N/G</strong></td>
                                                        <td width="16.6%" align="center">
                                                            <strong>Parenteral</strong></td>
                                                       
                                                        <td align="center" width="16.6%">
                                                            <strong>Other</strong></td>
                                                        <td width="16.6%" align="center">
                                                            <strong>Total Intake</strong></td>
                                                    </tr>
                                                       
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                    <tr>
                                                        <td width="16.6%" align="center">
                                                            <asp:Label ID="Label_O_Qty" runat="server" Text='<%# Eval("Oral") %>'></asp:Label></td>
                                                        <td align="center" width="16.6%">
                                                            <asp:Label ID="Label_CVPLine" runat="server" Text='<%# Eval("Cvp_Line") %>'></asp:Label></td>
                                                        <td width="16.6%" align="center">
                                                            <asp:Label ID="Label_Parenteral_Qty" runat="server" Text='<%# Eval("PARENTERAL") %>'></asp:Label></td>
                                                        <td width="16.6%" align="center">
                                                     
                                                        <td align="center" width="16.6%">
                                                            <asp:Label ID="Label_InOther" runat="server" Text='<%# Eval("In_Other") %>'></asp:Label></td>
                                                        <td width="16.6%" align="center">
                                                            <strong style="color: #03C;">
                                                                <asp:Label ID="Label_IN_Total" runat="server"></asp:Label></strong></td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <ControlStyle />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Output">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                    <tr>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_Tot_Drainage" runat="server"></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_Tot_NGAspiration" runat="server"></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_Tot_Vomit" runat="server"></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                        </td>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_Tot_Stool" runat="server"></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_Tot_Urine" runat="server"></asp:Label></td>
                                                        <td align="center" width="12.5%">
                                                            <asp:Label ID="Label_Tot_Out_Other" runat="server"></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_G_Out_Total" runat="server"></asp:Label></td>
                                                    </tr>
                                                       <tr>

                                                    </tr>
                                                </table>
                                            </FooterTemplate>
                                            <HeaderTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                    <tr>
                                                        <td colspan="8" align="center">
                                                            <strong style="color: #C30;">Output</strong></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="12.5%" align="center">
                                                            <strong>Drainage</strong></td>
                                                        <td width="12.5%" align="center">
                                                            <strong>NG Aspiration</strong></td>
                                                        <td width="12.5%" align="center">
                                                            <strong>Vomit</strong></td>
                                                        <td width="12.5%" align="center">
                                                            <strong>Vomit Color</strong></td>
                                                        <td width="12.5%" align="center">
                                                            <strong>Stool</strong></td>
                                                        <td width="12.5%" align="center">
                                                            <strong>Urine</strong></td>
                                                        <td width="12.5%" align="center">
                                                            <strong>Other</strong></td>
                                                        <td align="center" width="12.5%">
                                                            <strong>Total</strong></td>
                                                    </tr>
                                                    <tr>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                    <tr>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_Drainage" runat="server" Text='<%# Eval("Drainage") %>'></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_NG_Aspiration" runat="server" Text='<%# Eval("NG_Aspiration") %>'></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_Vomit" runat="server" Text='<%# Eval("Vomitus") %>'></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_VomitColor" runat="server" Text='<%# Eval("VomitColor") %>'></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_Stool" runat="server" Text='<%# Eval("Stool") %>'></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                            <asp:Label ID="Label_Urine" runat="server" Text='<%# Eval("Urine") %>'></asp:Label></td>
                                                        <td align="center" width="12.5%">
                                                            <asp:Label ID="Label_Out_Other" runat="server" Text='<%# Eval("Out_Other") %>'></asp:Label></td>
                                                        <td width="12.5%" align="center">
                                                            <strong style="color: #C33;">
                                                                <asp:Label ID="Label_Out_Total" runat="server"></asp:Label></strong></td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <ControlStyle />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Urine">
                                            <HeaderTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                    <tr>
                                                        <td align="center" colspan="5">
                                                            <strong style="color: #960;">Monitoring</strong></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%" align="center">
                                                            <strong>PH</strong></td>
                                                        <td width="20%" align="center">
                                                            <strong>Bld</strong></td>
                                                        <td width="20%" align="center">
                                                            <strong>Sug</strong></td>
                                                        <td width="20%" align="center">
                                                            <strong>Ket</strong></td>
                                                        <td width="20%" align="center">
                                                            <strong>ALB</strong></td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                    <tr>
                                                        <td width="20%" align="center">
                                                            <asp:Label ID="Label_PH" runat="server" Text='<%# Eval("PH") %>'></asp:Label></td>
                                                        <td width="20%" align="center">
                                                            <asp:Label ID="Label_Bld" runat="server" Text='<%# Eval("Bld") %>'></asp:Label></td>
                                                        <td width="20%" align="center">
                                                            <asp:Label ID="Label_Sug" runat="server" Text='<%# Eval("Sug") %>'></asp:Label></td>
                                                        <td width="20%" align="center">
                                                            <asp:Label ID="Label_Ket" runat="server" Text='<%# Eval("Ket") %>'></asp:Label></td>
                                                        <td width="20%" align="center">
                                                            <asp:Label ID="Label_ALB" runat="server" Text='<%# Eval("ALB") %>'></asp:Label></td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <ControlStyle />
                                            <FooterTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                    <tr>
                                                        <td width="20%" align="center">
                                                            <asp:Label ID="Label_Tot_PH" runat="server"></asp:Label></td>
                                                        <td width="20%" align="center">
                                                            <asp:Label ID="Label_Tot_Bld" runat="server"></asp:Label></td>
                                                        <td width="20%" align="center">
                                                            <asp:Label ID="Label_Tot_Sug" runat="server"></asp:Label></td>
                                                        <td width="20%" align="center">
                                                            <asp:Label ID="Label_Tot_Ket" runat="server"></asp:Label></td>
                                                        <td width="20%" align="center">
                                                            <asp:Label ID="Label_Tot_ALB" runat="server"></asp:Label></td>
                                                    </tr>
                                                    <tr>

                                                    </tr>
                                                </table>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Initial" SortExpression="Initial">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Initial") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                    <tr>
                                                        <td align="center" colspan="5">
                                                            <strong style="color: #960;"></strong>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%" align="center">
                                                            <strong>INITIAL</strong></td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Initial") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <FooterStyle CssClass="GridPager" />
                                    <SelectedRowStyle CssClass="gridselect" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <EditRowStyle CssClass="gridedit" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2" valign="top">
                            <br />
                            <asp:Panel ID="Panel_Enter_Detail" runat="server" Visible="False" Width="100%" CssClass="lightbox_bg">
                                <div class="lightbox" style="height: 150px;">
                                    <asp:DataList ID="DataList_SubComponent" runat="server" DataKeyField="SubComponent_ID"
                                        DataSourceID="SqlDataSource_sub_component" RepeatColumns="7" RepeatDirection="Horizontal">
                                        <ItemTemplate>
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Component_NameLabel" runat="server" Text='<%# Eval("Component_Name") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("Value", "{0}") %>' Width="47px"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="HiddenField_SubComponent_ID" runat="server" Value='<%# Eval("SubComponent_ID", "{0}") %>' />
                                        </ItemTemplate>
                                    </asp:DataList>&nbsp;<asp:Button ID="Button_Sub_Value_Save" runat="server" OnClick="Button_Sub_Value_Save_Click"
                                        Text="Save" />
                                    <asp:Button ID="Button_Sub_Value_Cancel" runat="server" OnClick="Button_Sub_Value_Cancel_Click"
                                        Text="Cancel" />
                                    <asp:SqlDataSource ID="SqlDataSource_sub_component" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                                        ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="SELECT Intake_Output_SubComponent.Component_Name, Intake_Output_SubComponent.SubComponent_ID, isnull((SELECT Patient_Intake_Output_SubCompnent_Values.Comp_Value FROM patient_intake_output INNER JOIN Patient_Intake_Output_SubCompnent_Values ON patient_intake_output.id = Patient_Intake_Output_SubCompnent_Values.patient_intake_output_ID WHERE (patient_intake_output.Registration_No = @Registration_No) AND (patient_intake_output.Yearly_No = @Yearly_No) AND (Patient_Intake_Output_SubCompnent_Values.SubComponent_ID = Intake_Output_SubComponent.SubComponent_ID) AND (patient_intake_output.Component_Id = Intake_Output_SubComponent.Component_ID) and patient_intake_output.id=@id1),'') AS Value FROM patient_intake_output_component INNER JOIN Intake_Output_SubComponent ON patient_intake_output_component.id = Intake_Output_SubComponent.Component_ID WHERE (patient_intake_output_component.id = @id)"
                                        InsertCommand="pro_insert_Patient_Intake_Output_SubCompnent_Values" InsertCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="HiddenField_Component_ID" Name="id" PropertyName="Value" />
                                            <asp:SessionParameter Name="Registration_No" SessionField="RegistrationNo" />
                                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
                                            <asp:ControlParameter ControlID="HiddenField_patient_intake_output_ID" Name="id1"
                                                PropertyName="Value" />
                                        </SelectParameters>
                                        <InsertParameters>
                                            <asp:ControlParameter ControlID="HiddenField_patient_intake_output_ID" Name="patient_intake_output_ID"
                                                PropertyName="Value" />
                                            <asp:ControlParameter ControlID="HiddenField_subComponent" Name="SubComponent_ID"
                                                PropertyName="Value" />
                                            <asp:ControlParameter ControlID="HiddenField_Sub_Component_Value" Name="Comp_Value"
                                                PropertyName="Value" />
                                        </InsertParameters>
                                    </asp:SqlDataSource>
                                    <asp:HiddenField ID="HiddenField_subComponent" runat="server" />
                                    <asp:HiddenField ID="HiddenField_Sub_Component_Value" runat="server" />
                                </div>
                            </asp:Panel>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="[Patient_IntakeOutput_Summary_rpt_Detail]"
                                SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:SessionParameter DefaultValue="" Name="yearly_No" SessionField="YearlyNo" Type="Decimal" />
                                    <asp:SessionParameter DefaultValue="" Name="Reg_No" SessionField="RegistrationNo" />
                                    <asp:ControlParameter ControlID="HiddenField_Type" Name="intake_output_Type" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="HiddenField_Date" Name="Date_time" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="HiddenField_Time" DefaultValue="" Name="time" PropertyName="Value"
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_Date" runat="server" />
                            <asp:HiddenField ID="HiddenField_Time" runat="server" />
                            <asp:HiddenField ID="HiddenField_Type" runat="server" />
                            <asp:HiddenField ID="HiddenField_Component_ID" runat="server" />
                            <asp:HiddenField ID="HiddenField_patient_intake_output_ID" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
</asp:Content>
