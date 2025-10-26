<%@ Page Language="VB" AutoEventWireup="false"  MasterPageFile="~/hacims_masterpage.master" CodeFile="Nursing_Notes.aspx.vb" Inherits="Nursing_Nursing_Notes" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


<script type="text/javascript">
function picture()
{
window.open("mlc_mainpic.aspx?reg={0}&yno={1}");
}
</script>
 <script src="../css_hacims/ck.js" type="text/javascript"></script>

 <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div align="right" style="margin-top:-10px; margin-right:5px; display:none;">
 
   
  
    <a href="#" title="Blood Bank"><img src="../images_hacims/bloodbankb.png" width="32" height="32" /></a>
     <a href="#" title="CT Scan"><img src="../images_hacims/ct.png" width="32" height="32" /></a>
      <a href="#" title="ECG"><img src="../images_hacims/ecg1.png" width="32" height="32" /></a>
      
   <a href="#" title="Medical"><img src="../images_hacims/medical.png" width="32" height="32" /></a>
    <a href="#" title="Medical"><img src="../images_hacims/medicalb.png" width="32" height="32" /></a>
     <a href="#" title="Medicine"><img src="../images_hacims/medicine.png" width="32" height="32" /></a>
      <a href="#" title="Red"><img src="../images_hacims/redc.png" width="32" height="32" /></a>
       <a href="#" title="Wheel Chair"><img src="../images_hacims/wheelchairb.png" width="32" height="32" /></a>
        <a href="#" title="X Ray"><img src="../images_hacims/xraya.png" width="32" height="32" /></a>
  
  
  
  </div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
 
</td>
<td  style="width:auto;" valign="top" >
     



<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="25%" style="height: 302px"> 
    
    
    <div class="bx_infos" style="height: 273px">
        <h2>
            <span>Nursing Notes</span></h2>
        <div style="margin-top: 5px; display: block; overflow-x: hidden; overflow: auto;
            width: 100%; height: 240px">
   
            <asp:GridView ID="GridView_Notes" runat="server" AutoGenerateColumns="False" DataKeyNames="Nurse_Record_ID"
                DataSourceID="SqlDataSourceForGrid" Width="100%">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                <tr>
                                    <td style="line-height: 16px;
                                        border: 0px">
                                        <p>
                                            <asp:Label ID="Label3" runat="server" CssClass="small_f" 
                                                Text='<%# Eval("Date", "{0}") %>'></asp:Label>
                                            <asp:Label ID="Label4" runat="server" Font-Bold="True" ForeColor="Red" Text='<%# Eval("Critical") %>'></asp:Label></p>
                                        <p>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" Text='<%# Eval("Nurse", "{0}") %>'></asp:LinkButton></p>
                                        <p>
                                            <span style="color: #900">(<asp:Label ID="Label2" runat="server" Text='<%# Eval("Type", "{0}") %>'></asp:Label>)</span></p>
                                        <span style="margin-top:3px; display: block; margin-bottom: 0px; width: 100%; border-bottom: #e1e1e1 1px dotted;
                                            height: 1px"></span>
                                    </td>
                                </tr>
                            </table>
                            <asp:HiddenField ID="HiddenField_Type" runat="server" Value='<%# Eval("Type") %>' />
                            <asp:HiddenField ID="HiddenField_Clinical_Observation" runat="server" Value='<%# Eval("Clinical_Observation") %>' />
                            <asp:HiddenField ID="HiddenField_Treatment" runat="server" Value='<%# Eval("Treatment") %>' />
                            <asp:HiddenField ID="HiddenField_Status" runat="server" Value='<%# Eval("Critical_Reading") %>' />
                            <asp:HiddenField ID="HiddenField_Date" runat="server" Value='<%# Eval("Date") %>' />
                        </ItemTemplate>
                        <HeaderStyle CssClass="hide" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
   
        </div>
    </div>
    
    
    
    
    </td>
    <td valign="top" width="75%" style="height: 302px">
<div class="bxmain" style="margin-left:10px; width:98%;">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right" width="20%" >Date :</td>
    <td   > <igsch:webdatechooser id="WebDateChooserRecord_Date" runat="server" format="Long" CssClass="drop_date" Width="202px">
<CalendarLayout Culture="English (United Kingdom)"></CalendarLayout>
</igsch:webdatechooser></td>
  </tr>
    <tr>
        <td align="right"  >
            Type :
        </td>
        <td >
            <asp:DropDownList ID="DropDownList_Notes_Type" runat="server" >
                <asp:ListItem>Handing Over</asp:ListItem>
                <asp:ListItem>Receiving</asp:ListItem>
                <asp:ListItem>Discharge</asp:ListItem>
                <asp:ListItem>Death</asp:ListItem>
            </asp:DropDownList></td>
    </tr>
  <tr>
    <td align="right" valign="top" >Treatment :</td>
    <td><asp:TextBox ID="TextBox_Treatment" runat="server"  CssClass="input_txt" Height="55px" TextMode="MultiLine"
        Width="95%"></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right" valign="top" >Clinical Observation :</td>
    <td><asp:TextBox ID="TextBox_Observation" runat="server" CssClass="input_txt" Height="55px" TextMode="MultiLine"
            Width="95%"></asp:TextBox></td>
  </tr>
  
  <tr>
    <td >&nbsp;</td>
  <td><asp:Button  ID="Button1" runat="server" Text="Save"  />
      <asp:HyperLink ID="HyperLink1" runat="server" CssClass="report" NavigateUrl="~/Patient Billing/PatientFaceSheetReport.aspx">Detail Report</asp:HyperLink>&nbsp;<asp:CheckBox 
          ID="CheckBox_Status" runat="server" Text="Critical" CssClass="red" /></td>
  </tr>
  
  
</table>
</div>
</td>
  </tr>
</table>

 



  <br />


<asp:HiddenField ID="HiddenField_description" runat="server" />
   
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Visible="False" 
        DataSourceID="SqlDataSourceForGrid" Width="100%">
        <Columns>
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="Treatment" HeaderText="Treatment" SortExpression="Treatment" />
            <asp:TemplateField HeaderText="Clinical Observations" SortExpression="Clinical_Observation">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Clinical_Observation") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Clinical_Observation") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Nurse" HeaderText="Nurse" SortExpression="Nurse" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSource_Insert_Notes" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>" InsertCommand="INSERT INTO Nurse_Record(YearlyNo, RegNo, Treatment, Clinical_Observation, Date_Time, Critical_Reading,Emp_Id,Type) VALUES (@YearlyNo, @RegNo, @Treatment, @Clinical_Observation, @Date_Time, @Critical_Reading,@Emp_Id,@Type)" ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" >
                              <InsertParameters>
                                  <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                  <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                  <asp:ControlParameter ControlID="TextBox_Treatment" Name="Treatment" PropertyName="Text" />
                                  <asp:ControlParameter ControlID="TextBox_Observation" Name="Clinical_Observation"
                                      PropertyName="Text" />
                                  <asp:ControlParameter ControlID="HiddenField_DateTime" Name="Date_Time" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="CheckBox_Status" Name="Critical_Reading" 
                                      PropertyName="Checked" />
                                  <asp:SessionParameter Name="Emp_Id" SessionField="Emp_Id" />
                                  <asp:ControlParameter ControlID="DropDownList_Notes_Type" Name="Type" PropertyName="SelectedValue" />
                              </InsertParameters>
                          </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Critical" runat="server" />
    <br />
    <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
        ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="SELECT     Nurse_Record.Date_Time AS Date, Nurse_Record.Clinical_Observation, Nurse_Record.Treatment, &#13;&#10;                      Employee.Prefix + ' ' + Employee.EFName + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS Nurse, Nurse_Record.Type, &#13;&#10;                      Nurse_Record.Nurse_Record_ID, Nurse_Record.Critical_Reading, CASE when Nurse_Record.Critical_Reading=1 THEN ('(Critical)') ELSE '' END AS Critical  &#13;&#10;FROM         Nurse_Record INNER JOIN&#13;&#10;                      Employee ON Nurse_Record.Emp_Id = Employee.EmpID&#13;&#10;WHERE     (Nurse_Record.YearlyNo = @YearlyNo) AND (Nurse_Record.RegNo = @RegNo)&#13;&#10;ORDER BY Date DESC">
        <SelectParameters>
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_DateTime" runat="server" />
     
     
</td>
</tr>
</table>

<asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
 </asp:Content>