<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Report_Reciver.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="Report_Reciver" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
#nav {display:none;}

</style>
<script src="../images/highlight.js" type="text/javascript"></script>

<script language ="javascript" type ="text/javascript" >
function Validation()
{
        var PFName = document.getElementById("textboxrfname").value;
        var PMName = document.getElementById("textboxrmname").value;
        var RFName = document.getElementById("textboxrffname").value;
        var RMName = document.getElementById("textboxrfmname").value;
        if(PFName.length!=0)  
        {      
            for (i=0;i<PFName.length;i++)
            {
                if(PFName.charAt(i)>=0 || PFName.charAt(i)<=9)
                {
                alert("Integer not allowed in Patient Relative  First Name");
                document.getElementById("textboxrfname").focus();
                return false;
                }
            }
        }    
        if(PMName.length!=0)        
        {
            for (i=0;i<PMName.length;i++)
            {
                if(PMName.charAt(i)>=0 || PMName.charAt(i)<=9)
                {
                alert("Integer not allowed in Patient Relative  First Name");
                document.getElementById("textboxrmname").focus();
                return false;
                }
            }
        }    
        if(RFName.length!=0)        
        {
            for (i=0;i<RFName.length;i++)
            {
                if(RFName.charAt(i)>=0 || RFName.charAt(i)<=9)
                {
                alert("Integer not allowed in Patient Relative  First Name");
                document.getElementById("textboxrffname").focus();
                return false;
                }
            }
        }
        if(RMName.length!=0)        
        {
            for (i=0;i<RMName.length;i++)
            {
                if(RMName.charAt(i)>=0 || RMName.charAt(i)<=9)
                {
                alert("Integer not allowed in Patient Relative  First Name");
                document.getElementById("textboxrfmname").focus();
                return false;
                }
            }
        } 
}

</script>

 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 
<asp:Label ID="Label_Message" runat="server" CssClass="err" ></asp:Label>
<br />
<asp:ScriptManager ID="ScriptManager2" runat="server">
                            <Services>
                                <asp:ServiceReference Path="AutoComplete.asmx" />
                            </Services>
    </asp:ScriptManager>
            <asp:LinkButton ID="LinkButton_PatientConsumption" runat="server" OnClick="LinkButton_PatientConsumption_Click">Patient Consumption</asp:LinkButton><br />

  <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Grid"
            Width="100%" cssclass="Grid_1" DataKeyNames="TGID">
                    <Columns>
                      <asp:BoundField DataField="RegNo" SortExpression="RegNo" HeaderText="Registration No" Visible="False"></asp:BoundField>
                      <asp:BoundField DataField="YearlyNo" SortExpression="YearlyNo" HeaderText="Visit No" Visible="False"></asp:BoundField>
                        <asp:BoundField DataField="Main_ID" HeaderText="Main_ID" InsertVisible="False" SortExpression="Main_ID" />
                        <asp:BoundField DataField="PFName" HeaderText="PFName" SortExpression="PFName" />
                        <asp:BoundField DataField="PMName" HeaderText="PMName" SortExpression="PMName" />
                        <asp:BoundField DataField="PLName" HeaderText="PLName" SortExpression="PLName" />
                        <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
                        <asp:BoundField DataField="PatientName" HeaderText="Relation Name" SortExpression="PatientName" />
                        <asp:BoundField DataField="TGName" HeaderText="Group Name" SortExpression="TGName" />
                        <asp:BoundField DataField="Date_Time" HeaderText="Booking Date" SortExpression="Date_Time" />
                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                        <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
                        <asp:BoundField DataField="TB_Name" HeaderText="Test Booking Name" SortExpression="TB_Name" />
                      <asp:TemplateField>
                        <ItemTemplate>
                          <asp:CheckBox ID="CheckBox1" runat="server" />                      
                          <asp:HiddenField ID="HiddenFieldTCID" runat="server" Value='<%# Bind("TGID", "{0}") %>' />
                          <asp:HiddenField ID="HiddenField1" runat="server" />
                          <asp:HiddenField ID="HiddenFieldTID" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                            <asp:HiddenField ID="HiddenField_Main_ID" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                           
                            <asp:HiddenField ID="HiddenField_TBID" runat="server" Value='<%# Eval("TB_ID", "{0}") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
      </Columns>
                    <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                    <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
    </asp:GridView>
                  <asp:SqlDataSource ID="SqlDataSource_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
            
        ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" 
        SelectCommand="SELECT DISTINCT &#13;&#10;                      Path_Result_Delivery.Yearly_No AS YearlyNo, Path_Result_Delivery.Reg_no AS RegNo, Patient.PFName, Patient.PMName, Patient.PLName, Patient.Relation, &#13;&#10;                      ISNULL(Patient.RFName + ' ', '') + ISNULL(Patient.RMName + ' ', '') + ISNULL(Patient.RLName + ' ', '') AS PatientName, Test_Status.Status, CONVERT(varchar, &#13;&#10;                      Path_Result_Delivery.Sample_Collection_Date, 107) AS Date_Time, TestGroup.TGName, TestGroup.TGID, Path_Result_Delivery.Main_ID, Department.Dept_Name, &#13;&#10;                      Test_Booking.TB_Name, Test_Booking.TB_ID&#13;&#10;FROM         Test_Booking INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN&#13;&#10;                      Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN&#13;&#10;                      Payment INNER JOIN&#13;&#10;                      Patient ON Payment.RegNo = Patient.RegNo ON Path_Result_Delivery.Yearly_No = Payment.PayID ON &#13;&#10;                      Test_Booking.TB_ID = Test_Booking_Services.TB_ID LEFT OUTER JOIN&#13;&#10;                      Department ON Path_Result_Delivery.From_Dept_ID = Department.Dept_ID&#13;&#10;WHERE     (Test_Status.Status_ID = @Status_Id) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND &#13;&#10;                      (Path_Result_Delivery.Main_ID = @Main_ID)&#13;&#10;" UpdateCommand="UPDATE    Test_Booking_Services
SET              Status = @Status
WHERE     (TB_ID = @TB_ID) AND (Main_ID = @Main_ID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="RegNo" QueryStringField="Reg_No" />
                        <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
                        <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_Id" />
                        <asp:QueryStringParameter Name="Status_Id" QueryStringField="status_ID" />
                    </SelectParameters>
                      <UpdateParameters>
                          <asp:Parameter DefaultValue="8" Name="Status" />
                          <asp:ControlParameter ControlID="HiddenField_TBID" DefaultValue="" Name="TB_ID" 
                              PropertyName="Value" />
                          <asp:ControlParameter ControlID="HiddenField_Main_Id" Name="Main_ID" 
                              PropertyName="Value" />
                      </UpdateParameters>
    </asp:SqlDataSource><br />

    <asp:SqlDataSource ID="SqlDataSource_ReportingStatus" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
            
        ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" 
         UpdateCommand="UPDATE    Test_Booking_Services
SET              Status = @Status
WHERE     (TB_ID = @TB_ID) AND (Main_ID = @Main_ID)">
                
                      <UpdateParameters>
                          <asp:Parameter DefaultValue="1" Name="Status" />
                          <asp:ControlParameter ControlID="HiddenField_TBID" DefaultValue="" Name="TB_ID" 
                              PropertyName="Value" />
                          <asp:ControlParameter ControlID="HiddenField_Main_Id" Name="Main_ID" 
                              PropertyName="Value" />
                      </UpdateParameters>
    </asp:SqlDataSource>

<h1 class="h1"><span>Reports Deliver to :</span></h1>




<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">

  <tr>

<td width="17%"  align="right" valign="middle" ><strong> First Name :&nbsp; </strong></td>
        <td width="34%" ><asp:TextBox CssClass="input_txt" ID="TextBoxRFName" runat="server"></asp:TextBox></td>
                        <td width="17%" align="right" valign="middle" ><strong> Last Name :&nbsp;</strong></td>
                        <td width="32%" ><asp:TextBox CssClass="input_txt" ID="TextBoxRMName" runat="server"></asp:TextBox></td>
                      </tr>
              <tr>
                <td align="right" valign="middle"  ><strong>Relation&nbsp;:&nbsp;</strong></td>
                <td colspan="3" ><asp:RadioButtonList ID="RBLrelation" runat="server" 
RepeatDirection="Horizontal"
                        TabIndex="9" Width="172px">
                            <asp:ListItem Selected="True">S/O</asp:ListItem>
                            <asp:ListItem>D/O</asp:ListItem>
                            <asp:ListItem>W/O</asp:ListItem>
                </asp:RadioButtonList></td>
                      </tr>
              <tr>
                <td align="right" valign="middle" ><strong> First Name :&nbsp;</strong></td>
                <td ><asp:TextBox CssClass="input_txt" ID="TextBoxRFFName" runat="server"></asp:TextBox></td>
                        <td align="right" valign="middle" ><strong> Last Name :&nbsp;</strong></td>
                        <td ><asp:TextBox CssClass="input_txt" ID="TextBoxRFMName" runat="server"></asp:TextBox></td>
                      </tr>
              <tr>
                <td align="right" valign="middle"  ><strong>CNIC No :&nbsp;</strong></td>
                <td >
                          <asp:TextBox CssClass="input_txt" ID="TextBoxRCINIC" runat="server" ></asp:TextBox></td>
                        <td align="right" valign="middle" ><strong>Description :&nbsp; </strong></td>
                        <td >
                          <asp:TextBox CssClass="input_txt" ID="TextBox_Description" runat="server"></asp:TextBox></td>
  </tr>

</table>
<br />


<div align="center">
    <asp:Button ID="ButtonCrystalReport" runat="server" 
        Text="View Crystal Report" CssClass="btn1" Width="124px" />
        <asp:Button ID="ButtonSavePageReport" runat="server" 
        Text="View Report" CssClass="btn1" Width="109px" />
        <asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1" 
        Width="84px" />&nbsp;<asp:Button ID="Button_Status" runat="server" 
        Text="Change Deliver Status" Width="141px"     onclick="Button_Status_Click"/>

        <asp:Button ID="btnUpdate_ToReporting_Status" runat="server" 
        Text="Change Reporting Status" Width="156px"     
        onclick="btnUpdate_ToReporting_Status_Click"/>
    

    <asp:LinkButton ID="LinkButtonReport" runat="server"  
        Font-Underline="False" CssClass="btn_rpt" Visible="False" 
                          >View  Crystal Report</asp:LinkButton></div><br />
    <asp:HiddenField ID="HiddenField_Main_Id" runat="server" />
<br />
<asp:HiddenField ID="HiddenField_TID" runat="server" />
          <asp:HiddenField ID="HiddenField_TG_ID" runat="server" />
   
          <asp:TextBox ID="TextBox2" runat="server" Visible="False"></asp:TextBox>
          <asp:TextBox ID="TextBox1" runat="server" Visible="False"></asp:TextBox>
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>" ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" UpdateCommand="Update_Patient_Deliver_Status" 
          InsertCommand="INSERT INTO Report_Reciever_Sub (Main_ID, TID) VALUES (@Main_ID,@TID)" UpdateCommandType="StoredProcedure">
            <UpdateParameters>
              <asp:QueryStringParameter Name="Payid" QueryStringField="YearlyNo" />
              <asp:QueryStringParameter Name="RegNo" QueryStringField="Reg_No" />
                <asp:ControlParameter ControlID="HiddenField_TG_ID" Name="TGID" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value"
                    Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
              <asp:ControlParameter ControlID="HiddenField_TID" Name="TID" PropertyName="Value" />
              <asp:ControlParameter ControlID="HiddenField2" Name="Main_ID" PropertyName="Value" />
            </InsertParameters>
    </asp:SqlDataSource>          
            <asp:HiddenField ID="HiddenField2" runat="server" />
            <asp:HiddenField ID="HiddenField_TRM_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_TBID" runat="server" />


 

  </asp:Content>