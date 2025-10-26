<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PAthology_Payment.aspx.vb" Inherits="PAthology_Payment" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link href="../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../images/sheet_form.css" rel="stylesheet" type="text/css" />


<script src="../images/highlight.js" type="text/javascript"></script>

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}
</style>
<script language ="javascript" type ="text/javascript" >
function Checks()
{
    var Next_Date;
    var Grand_Discount;
    var Description;
    Next_Date = document.getElementById("Textbox_next_Date").value;
    Grand_Discount = document.getElementById("Textbox_Grand_Discount").value;
    Description = document.getElementById("TextboxDescription").value;
        if ((Next_Date.length==0) || (Next_Date-0 != Next_Date))
        {
        alert("Enter Correct Days(Only Integers)");
        document.getElementById("Textbox_next_Date").focus();
        document.getElementById("Textbox_next_Date").select();
        return false;
        }
       if ((Grand_Discount.length==0) || (Grand_Discount-0 != Grand_Discount))
        {
        alert("Enter Correct Discount(Only Integers)");
        document.getElementById("Textbox_Grand_Discount").focus();
        document.getElementById("Textbox_Grand_Discount").select();
        return false;
        }
        if (Description.length==0)
        {
        alert("Enter Description");
        document.getElementById("TextboxDescription").focus();
        document.getElementById("TextboxDescription").select();
        return false;
        }
        alert("End All");
        return true;
}
function NewWindow()
{
window.open("Patient_Payment_report.aspx","_blank");
}
</script>

</head>

<body><form id="form1" runat = "server">

<div id="forms_items" class="forms_items">


<asp:Label ID="Label_Message" runat="server" CssClass="err"></asp:Label>

                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="PTestID"
                    DataSourceID="SqlDataSourceForGrid" Width="100%" CssClass="Grid_1" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="RegNo" HeaderText="Registration No" SortExpression="RegNo" />
                        <asp:BoundField DataField="PayID" HeaderText="Yearly No" SortExpression="PayID" />
                        <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                        <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                        <asp:BoundField DataField="TGName" HeaderText="Test Group Name" SortExpression="TGName" />
                        <asp:BoundField DataField="TestName" HeaderText="Test Name" SortExpression="TestName" />
                        <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" />
                        <asp:BoundField DataField="PTestID" HeaderText="PTestID" InsertVisible="False" ReadOnly="True"
                            SortExpression="PTestID" Visible="False" />
                        <asp:BoundField DataField="TID" HeaderText="TID" SortExpression="TID" Visible="False" />
                        <asp:TemplateField Visible="False">
                            <ItemTemplate>
                      Rs. <asp:TextBox id="TextBox_Discount" runat="server" Width="36px" >0</asp:TextBox>
                                &nbsp;&nbsp;
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenFieldPrice" runat="server" Value='<%# Bind("Fee", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_RID" runat="server" Value='<%# Bind("TID", "{0}") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
<br />
                <asp:GridView ID="GridView2" runat="server" CssClass="Grid_1" Width="100%" AutoGenerateColumns="False">
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <Columns>
                        <asp:BoundField DataField="Reg_no" HeaderText="Registration No." SortExpression="Reg_no" />
                        <asp:BoundField DataField="Yearly_No" HeaderText="Yearly No." SortExpression="Yearly_No" />
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                        <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" />
                        <asp:BoundField DataField="TGName" HeaderText="Test Group Name" SortExpression="TGName" />
                        <asp:BoundField DataField="TB_Name" HeaderText="Test Name" SortExpression="TB_Name" />
                        <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" />
                    </Columns>
                </asp:GridView>
                <br />
                <asp:Panel ID="Panel_Payment" runat="server" >

<table >
                        <tr>
                            <td >
                                Total Price : </td>
                            <td >
                <asp:TextBox ID="TextBox_Total_Price" runat="server" ReadOnly="true" 
                    BorderStyle="None" BorderWidth="0px" Font-Size="Large" >0</asp:TextBox></td>
                            <td >
                                
Grand Discount :                             </td>
                            <td >
                                <asp:TextBox AutoPostBack="True" ID="TextBox_Grand_discount" runat ="server" Width="113px" >0</asp:TextBox></td>
                            <td >
                    <asp:DropDownList ID="DropDownList_Discount_Type" runat="server" AutoPostBack="True">
                        <asp:ListItem>Rs.</asp:ListItem>
                        <asp:ListItem>%age</asp:ListItem>
                    </asp:DropDownList></td>
                            <td >
                Payment :                             </td>
                            <td >
              <asp:TextBox CssClass="d-active" ID="TextBox_Grand_total" ReadOnly="True" 
                    runat="server" Width="113px" BorderStyle="None" BorderWidth="0px" 
                    Font-Size="Large">0</asp:TextBox></td>
                        </tr>
                    </table>
                </asp:Panel>
             
             
              
              <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT PatientsLabTest.RegNo, PatientsLabTest.PayID, PatientsLabTest.TID, Test.TestName, CONVERT (varchar, PatientsLabTest.DateTime, 107) AS Date, CONVERT (varchar, PatientsLabTest.DateTime, 108) AS Time, Test.Fee, PatientsLabTest.PTestID, TestGroup.TGName FROM Test INNER JOIN PatientsLabTest ON Test.TID = PatientsLabTest.TID INNER JOIN TestGroup ON Test.TGID = TestGroup.TGID WHERE (PatientsLabTest.PayID = @YearlyNo) AND (PatientsLabTest.RegNo = @RegNo) AND (PatientsLabTest.Status = 'Not Done')" insertcommand="INSERT INTO Pt_Pathology_Test_Amount(Reg_No, Yearly_No, RID, total_fee, Discount, fee_paid, Main_ID) VALUES (@Reg_No, @Yearly_No, @RID, @total_fee, @Discount, @fee_paid, @main_id)" DeleteCommand="DELETE FROM PatientsLabTest WHERE (PTestID = @PTestID)"><SelectParameters>
                <asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
                <asp:SessionParameter SessionField="RegistrationNo" Name="RegNo"></asp:SessionParameter>
                </SelectParameters>
                <InsertParameters>
                  <asp:SessionParameter SessionField="RegistrationNo" Name="Reg_No"></asp:SessionParameter>
                  <asp:SessionParameter SessionField="YearlyNo" Name="Yearly_No"></asp:SessionParameter>
                  <asp:ControlParameter PropertyName="Value" Name="RID" ControlID="HiddenField_Radiology_ID"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="total_fee" ControlID="HiddenField_Total_Fee"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Discount" ControlID="HiddenField_Discount"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="fee_paid" ControlID="HiddenField_Fee_Paid"></asp:ControlParameter>
                  <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="main_id" PropertyName="Value" />
                  </InsertParameters>
                <DeleteParameters>
                  <asp:ControlParameter ControlID="GridView5" Name="PTestID" PropertyName="SelectedValue" />
                  </DeleteParameters>
                </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_Appointment_Date" runat="server" />
              <asp:HiddenField ID="HiddenFieldAppointment_Time" runat="server" />
              <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
              <asp:HiddenField ID="HiddenField_Radiology_ID" runat="server" />
              <asp:HiddenField ID="HiddenField_Total_Fee" runat="server" />
              <asp:HiddenField ID="HiddenField_Discount" runat="server" />
              <asp:HiddenField ID="HiddenField_Fee_Paid" runat="server" /><asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
              <asp:HiddenField ID="HiddenFieldTotalAmount" runat="server" />
              <asp:HiddenField ID="HiddenFieldTotalPaid" runat="server" />
              <asp:HiddenField ID="HiddenFieldTotal_Discount" runat="server" />
              <asp:SqlDataSource ID="SqlDataSourceInsertSub" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    InsertCommand="Insert_Pathology_Test_Total_Amount"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="&#13;&#10;" InsertCommandType="StoredProcedure">
                <InsertParameters>
                  <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenFieldTotal_Discount" Name="TOtal_Discount" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenFieldTotalPaid" Name="Total_Paid" PropertyName="Value" />
                  <asp:ControlParameter ControlID="HiddenFieldTotalAmount" Name="Total_AMount" PropertyName="Value" />
                  </InsertParameters>
                </asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSource_Appointment" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString12 %>"
                    InsertCommand="INSERT INTO Path_Result_Delivery(Reg_no, Yearly_No, Next_App_Date, Next_App_Time, Report_Deliverd) VALUES (@Reg_no, @Yearly_No, @Next_App_Date, @Next_App_Time, @Report_Deliverd)"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="&#13;&#10;">
                <InsertParameters>
                  <asp:SessionParameter SessionField="RegistrationNo" Name="Reg_no"></asp:SessionParameter>
                  <asp:SessionParameter SessionField="YearlyNo" Name="Yearly_No"></asp:SessionParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Next_App_Date" ControlID="HiddenField_Appointment_Date"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Next_App_Time" ControlID="HiddenFieldAppointment_Time"></asp:ControlParameter>
                  <asp:ControlParameter PropertyName="Value" Name="Report_Deliverd" ControlID="HiddenField_Report_Date"></asp:ControlParameter>
                  </InsertParameters>
                </asp:SqlDataSource>            
                <asp:HiddenField ID="HiddenFieldDiscount" runat="server" />

<div align="center"><asp:Button ID="Button1" runat="server" Text="Next" UseSubmitBehavior="False" CssClass="btn1"  Visible="False" />
                <asp:Button ID="ButtonSave" runat="server" Text="Save" UseSubmitBehavior="False" CssClass="btn1" width="76px" /></div>
<br />
<br />


</div>

</form>
</body>
</html>