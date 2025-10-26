<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Report_Reciver.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="Report_Reciver" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
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
    </asp:ScriptManager><br />

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
                        <asp:BoundField DataField="P_Status" HeaderText="Payment Status" SortExpression="P_Status" />
                        <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
                        <asp:BoundField DataField="TB_Name" HeaderText="Test Booking Name" SortExpression="TB_Name" />
                      <asp:TemplateField>
                        <ItemTemplate>
                          <asp:CheckBox ID="CheckBox1" runat="server" Visible='<%# Bind("Chk_vis") %>' />                      
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
                  <br />

<h1 class="h1"><span>Reports Deliver to :</span></h1>
    <asp:SqlDataSource ID="SqlDataSource_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT  PRD.Yearly_No AS YearlyNo, PRD.Reg_no AS RegNo, Pt.PFName, Pt.PMName, Pt.PLName, Pt.Relation, ISNULL(Pt.RFName + ' ', '') + ISNULL(Pt.RMName + ' ', '') + ISNULL(Pt.RLName + ' ', '') AS PatientName, TS.Status, 
                         CONVERT(varchar, PRD.Sample_Collection_Date, 107) AS Date_Time, TG.TGName, TG.TGID, PRD.Main_ID, D.Dept_Name, TB.TB_Name, TB.TB_ID, isnull(SS.Status, 'Paid')  AS P_status, CONVERT(bit, CASE WHEN isnull(SS.Status, 'Paid') 
                         = 'paid' THEN 1 ELSE 0 END) AS Chk_vis
FROM            Test_Booking AS TB INNER JOIN
                         TestGroup AS TG ON TB.MG_ID = TG.TGID INNER JOIN
                         Test_Booking_Services AS TBS INNER JOIN
                         Test_Status AS TS ON TBS.Status = TS.Status_ID INNER JOIN
                         Path_Result_Delivery AS PRD ON TBS.Main_ID = PRD.Main_ID INNER JOIN
                         Payment AS Py INNER JOIN
                         Patient AS Pt ON Py.RegNo = Pt.RegNo ON PRD.Yearly_No = Py.PayID ON TB.TB_ID = TBS.TB_ID LEFT OUTER JOIN
                         Department AS D ON PRD.From_Dept_ID = D.Dept_ID LEFT OUTER JOIN
                         BasicDataInfo.dbo.Service_Payment_Sub AS SS ON SS.P_SID = TBS.PS_ID
WHERE        (TS.Status_ID = @Status_Id) AND (PRD.Reg_no = @RegNo) AND (PRD.Yearly_No = @YearlyNo) AND (PRD.Main_ID = @Main_ID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="RegNo" QueryStringField="Reg_No" />
                        <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
                        <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_Id" />
                        <asp:QueryStringParameter Name="Status_Id" QueryStringField="status_ID" />
                    </SelectParameters>
    </asp:SqlDataSource>




<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" runat="server" id="tblreportTo">

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


<div align="center"><asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1" />&nbsp;                
<asp:LinkButton ID="LinkButtonReport" runat="server"  Font-Underline="False" CssClass="btn_rpt" >View Report</asp:LinkButton></div><br />
    <asp:HiddenField ID="HiddenField_Main_Id" runat="server" />
<br />
<asp:HiddenField ID="HiddenField_TID" runat="server" />
          <asp:HiddenField ID="HiddenField_TG_ID" runat="server" />
   
          <asp:TextBox ID="TextBox2" runat="server" Visible="False"></asp:TextBox>
          <asp:TextBox ID="TextBox1" runat="server" Visible="False"></asp:TextBox>
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" UpdateCommand="Update_Patient_Deliver_Status" InsertCommand="INSERT INTO Report_Reciever_Sub (Main_ID, TID) VALUES (@Main_ID,@TID)" UpdateCommandType="StoredProcedure">
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