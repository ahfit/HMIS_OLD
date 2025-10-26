<%@ page language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Patient_Billing_PatientBillingParty, App_Web_asx2a3aw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript" src="../Validate.js"></script>
 <script type="text/javascript" src="../css_hacims/jquery.min.js"></script>
<script type="text/javascript" language="javascript">

  $(document).ready(function(e) {
    
	 // $("#ctl00_ContentPlaceHolder1_btnSave").attr('disabled', true); 
	 // $("#ctl00_ContentPlaceHolder1_txtRate").keydown ( function(){  	
		
	 // $("#ctl00_ContentPlaceHolder1_btnSave").attr('disabled', false);
	 //     if( $("#ctl00_ContentPlaceHolder1_txtRate").val()==""){ $("#ctl00_ContentPlaceHolder1_btnSave").attr('disabled', false);}
	 //})
	 
});
</script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="50%">

<div class="bxmain inner_content" style="width:99%;"><span><h2>Patient Billing Party</h2></span>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
        <tr>
            <td align="right" width="25%" style="height: 18px"  >
                Party :</td>
            <td width="25%" style="height: 18px" >
                <asp:DropDownList ID="ddlParties" runat="server" DataSourceID="dsParties" DataTextField="Party_Name" DataValueField="Party_Id" AutoPostBack="True">
                </asp:DropDownList>
                <asp:SqlDataSource ID="dsParties" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" SelectCommand="SELECT [Party_Id], [Party_Name] FROM [Parties]"></asp:SqlDataSource>
            </td>
             
        </tr>
        <tr>
            <td align="right" style="height: 17px"  >
                From Date :</td>
            <td style="height: 17px" >
          <igsch:webdatechooser id="wdcFromDate" runat="server" EnableKeyboardNavigation="True">
              <CalendarLayout Culture="English (United Kingdom)">
              </CalendarLayout>
          </igsch:webdatechooser></td>
        </tr>
        <tr>
            <td align="right"  >
                To Date :</td>
            <td >
          <igsch:webdatechooser id="wdcToDate" runat="server">
              <CalendarLayout Culture="English (United Kingdom)">
              </CalendarLayout>
          </igsch:webdatechooser></td>
        </tr>
        <tr>
            <td align="right"   >
                Rate :</td>
            <td   >
            <asp:TextBox ID="txtRate" runat ="server" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right"   >
            </td>
            <td    >
          <asp:Button ID="btnSave" runat="server" Text="Save"   /></td>
        </tr>
      
  </table></div>
  </td>
    <td valign="top">
    
    
    <div class="bxmain inner_content" ><span><h2>Add Designation</h2></span>
    <table width="100%" border="0" style="height:138px" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="25%" align="right">Designation :</td>
    <td ><asp:TextBox ID="TextBox_Designations" runat="server"></asp:TextBox> 
<asp:Button ID="Button_Save_Dsgn" runat="server" Text="Save" /></td>
  </tr>
</table>
        <asp:Label ID="Label_error" runat="server" ForeColor="#C00000"></asp:Label></div>
<br />

              <asp:SqlDataSource ID="SqlDataSource_Party_dsgn" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>"
                  DeleteCommand="DELETE FROM Party_Designations WHERE (Party_Desg_ID = @Party_Desg_ID)"
                  InsertCommand="INSERT INTO Party_Designations(Party_Desg_Name, Party_ID) VALUES (@Party_Desg_Name, @Party_ID)"
                  ProviderName="<%$ ConnectionStrings:PatientBillingConnectionString.ProviderName %>"
                  SelectCommand="Select_Party_Designation" SelectCommandType="StoredProcedure">
                <SelectParameters>
                  <asp:ControlParameter ControlID="ddlParties" Name="Party_id" PropertyName="SelectedValue"
                          Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                  <asp:ControlParameter ControlID="GridView_dsgn" Name="Party_Desg_ID" PropertyName="SelectedValue" />
                </DeleteParameters>
                <InsertParameters>
                  <asp:ControlParameter ControlID="TextBox_Designations" Name="Party_Desg_Name" PropertyName="Text" />
                  <asp:ControlParameter ControlID="ddlParties" Name="Party_ID" PropertyName="SelectedValue" />
                </InsertParameters>
            </asp:SqlDataSource>
</td>
  </tr>
</table>

  
  
  
  
    

        <table width="100%" border="0" cellspacing="0" style="padding-top:10px;" cellpadding="0">
          <tr>
            <td width="50%" valign="top"><asp:GridView ID="grdPateintBillingParty" runat="server" AutoGenerateColumns="False" DataSourceID="dsPatientBillingParty" DataKeyNames="id" Width="99%">
              <columns>

                  
                  <asp:BoundField DataField="Party_Name" HeaderText="Party Name"  />
                <asp:BoundField DataField="Start_Date" HeaderText="Start Date" SortExpression="Start_Date" />
                <asp:BoundField DataField="End_Date" HeaderText="End Date" SortExpression="End_Date" />
                <asp:BoundField DataField="Percentage" HeaderText="Percentage" SortExpression="Percentage" />
                <asp:TemplateField>
                  <itemtemplate>
                    <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"
                                    onclientclick="return confirmation(this)" ToolTip="Delete" OnClick="ImageButton2_Click" />            
                  </itemtemplate>
                </asp:TemplateField>
              </columns>
              <RowStyle CssClass="GridItem" />
              <footerstyle CssClass="GridPager" />            
              <SelectedRowStyle CssClass="gridselect" />
              <headerstyle CssClass="GridHeader" />            
              <EditRowStyle CssClass="gridedit" />
              <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView></td>
            <td valign="top">
                <asp:GridView ID="GridView_dsgn" runat="server" AutoGenerateColumns="False"  
                  DataKeyNames="Party_Desg_ID" DataSourceID="SqlDataSource_Party_dsgn" Width="99%">
              <columns>
                <asp:BoundField DataField="Party_Desg_ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                          SortExpression="Party_Desg_ID" Visible="False" />
                <asp:BoundField DataField="Party_Name" HeaderText="Party" SortExpression="Party_Name"
                          Visible="False" />
                <asp:BoundField DataField="Party_Desg_Name" HeaderText="Designation" SortExpression="Party_Desg_Name" />
                <asp:TemplateField>
                  <itemtemplate>
                    <asp:ImageButton ID="ImageButton" runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"
                                    onclientclick="return confirmation(this)" ToolTip="Delete" OnClick="ImageButton2_Click" />            
                  </itemtemplate>
                </asp:TemplateField>
              </columns>
              <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>

            </td>
          </tr>
        </table>
  <asp:SqlDataSource ID="dsPatientBillingParty" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                    InsertCommand="INSERT INTO Patient_Billing_Party(Billing_Party_Id, Start_Date, End_Date, Percentage,  Party_Id) VALUES (@Billing_Party_Id, @Start_Date, @End_Date, @Rates_Percentage, @Billing_Party_Id)"
                    SelectCommand="SELECT   id,  Parties.Party_Name,convert(varchar(10),Start_Date,103) as Start_Date, convert(Varchar(10),End_Date,103) as End_Date, Percentage  FROM         Patient_Billing_Party inner join Parties on Parties.Party_Id=Patient_Billing_Party.Party_Id WHERE     (Billing_Party_Id = @id)" DeleteCommand="DELETE FROM Patient_Billing_Party WHERE (id = @id)">
                    <InsertParameters>
                        <asp:ControlParameter Name="Billing_Party_Id" ControlID="ddlParties" PropertyName="SelectedValue" />
                        <asp:ControlParameter Name="Start_Date" ControlID="HiddenField_Start_date" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_end_date" Name="End_Date" PropertyName="Value" />
                        <asp:ControlParameter ControlID="txtRate" Name="Rates_Percentage" PropertyName="Text" />
                    </InsertParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="grdPateintBillingParty" Name="id" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlParties" Name="id" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Start_date" runat="server" />
                <asp:HiddenField ID="HiddenField_end_date" runat="server" />
            
</asp:Content>



 

