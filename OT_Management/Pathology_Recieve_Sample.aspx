<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pathology_Recieve_Sample.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="Pathology_Recieve_Sample" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<script language="javascript" type="text/javascript">
function OpenNewPage()
{
var regno=document.getElementById("HiddenFieldRegNo").value;
var yearlyno=document.getElementById("HiddenFieldYearlyNo").value;
window.open("","MyWidows")
    
}
</script>
<style type="text/css">

#nav {display:none; }

</style>

 </asp:Content>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
 
<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_DropDownList"
                    DataTextField="SubDept_Name" DataValueField="SubDept_Id" Visible="False" Width="257px">
    </asp:DropDownList><br />

<div class="bxmain">
<table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                  

                    <tr>
                        <td width="25%" align="right" >
                            Sample No. :                        </td>
                        <td width="25%" >
                      <asp:TextBox ID="TextBox_Sample_number" runat="server" CssClass="input_txt" ReadOnly="True" Width="150px"></asp:TextBox></td>
                        <td width="25%" align="right" >                             Description :                        </td>
                  <td rowspan="3" valign="top" width="25%">
                <asp:TextBox ID="TextBoxDescription" runat="server" Style="height:73px" TextMode="MultiLine" Width="150px"></asp:TextBox>
                        </td>
      </tr>
                    <tr>
                        <td align="right">
                            Report Date :
                        </td>
                        <td> <igsch:WebDateChooser ID="WebDateChooser1" runat="server" Width="152px"> </igsch:WebDateChooser>
                        </td>
                        <td align="right">
                      </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Collect Report After :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_next_Date" runat="server" CssClass="input_txt" Width="50px">0</asp:TextBox>
                            <asp:DropDownList ID="DropDownList2" runat="server" Width="96px">
                                <asp:ListItem>Hours</asp:ListItem>
                                <asp:ListItem>Days</asp:ListItem>
                            </asp:DropDownList></td>
                        <td align="right">
                      </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Test Type :
                        </td>
                        <td colspan="3">
                            <asp:RadioButtonList ID="RadioButtonList_Type" runat="server" DataSourceID="SqlDataSource_Test_Type"
                                DataTextField="Test_Type" DataValueField="Test_Type_ID" RepeatDirection="Horizontal"
                                RepeatLayout="Flow" Width="100%">
                                <asp:ListItem Selected="True">Routine</asp:ListItem>
                                <asp:ListItem>Start(Now)</asp:ListItem>
                                <asp:ListItem>Urgent(Today)</asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                   

    </table></div><br />

                <asp:GridView ID="GridView_Sample_Recieved" runat="server" AutoGenerateColumns="False"
                     Width="100%" DataSourceID="SqlDataSource_For_Grid">
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <Columns>
                        <asp:TemplateField HeaderText="Sr. No.">
                            <ItemTemplate>
                                <asp:Label ID="Label_SrNo" runat="server" Width="70px"></asp:Label>
                                <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Request_Date" HeaderText="Request Date" ReadOnly="True"
                            SortExpression="Request_Date" />
                        <asp:BoundField DataField="Request_Time" HeaderText="Request Time" ReadOnly="True"
                            SortExpression="Request_Time" />
                        <asp:BoundField DataField="Employee" HeaderText="Suggested By" ReadOnly="True" SortExpression="Employee" />
                        <asp:BoundField DataField="TGName" HeaderText="Test Category" SortExpression="TGName" />
                        <asp:BoundField DataField="TB_Name" HeaderText="Test Name" SortExpression="TB_Name" />
                        <asp:BoundField DataField="Emp_ID" HeaderText="Emp_ID" SortExpression="Emp_ID" Visible="False" />
                        <asp:TemplateField HeaderText="Specimen Received">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT     CONVERT(varchar, Radiology_Order_main.Date_Time, 107) AS Request_Date, CONVERT(varchar, Radiology_Order_main.Date_Time, 108) AS Request_Time, &#13;&#10;                      TestGroup.TGName, Test_Booking.TB_Name, Radiology_Order_main.Emp_ID, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') &#13;&#10;                      + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Employee, Radiology_Order_Sub.TB_ID&#13;&#10;FROM         Employee RIGHT OUTER JOIN&#13;&#10;                      Test_Booking INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN&#13;&#10;                      Radiology_Order_Sub INNER JOIN&#13;&#10;                      Radiology_Order_main ON Radiology_Order_Sub.Order_ID = Radiology_Order_main.Order_ID ON &#13;&#10;                      Test_Booking.TB_ID = Radiology_Order_Sub.TB_ID LEFT OUTER JOIN&#13;&#10;                      Group_SubDept ON TestGroup.TGID = Group_SubDept.Group_id ON Employee.EmpID = Radiology_Order_main.Emp_ID&#13;&#10;WHERE     (Radiology_Order_main.RegNo = @RegNo) AND (Radiology_Order_main.YearlyNo = @YearlyNo) AND (Radiology_Order_main.Order_ID = @Order_ID) AND &#13;&#10;                      (Radiology_Order_Sub.TB_ID NOT IN&#13;&#10;                          (SELECT     Test_Booking_Services.TB_ID&#13;&#10;                            FROM          Path_Result_Delivery INNER JOIN&#13;&#10;                                                   Test_Booking_Services ON Path_Result_Delivery.Main_ID = Test_Booking_Services.Main_ID&#13;&#10;                            WHERE      (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND &#13;&#10;                                                   (Path_Result_Delivery.HospitalOrderNo = @Order_ID)))">
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:QueryStringParameter Name="Order_ID" QueryStringField="Order_id" />
                    </SelectParameters>
                </asp:SqlDataSource>
<br />

<div align="center">
    <asp:SqlDataSource ID="SqlDataSource_PatientServices" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        InsertCommand="INSERT INTO [BasicDataInfo].[dbo].[Patient_Services]&#13;&#10;           ([RegNo]&#13;&#10;           ,[YearlyNo]&#13;&#10;           ,[sdatetime]&#13;&#10;           ,[empid]&#13;&#10;           ,[S_ID]&#13;&#10;           ,[Amount]&#13;&#10;           ,[Payment_Status]&#13;&#10;           ,[Doctor_ID]&#13;&#10;           ,[SubDept_ID]&#13;&#10;           ,[Doctor_Payment]&#13;&#10;           ,[Dept_ID]&#13;&#10;           ,[ResonForCancellation]&#13;&#10;           ,Order_ID)&#13;&#10;  &#13;&#10;&#13;&#10;SELECT     Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No, Path_Result_Delivery.Test_Booking_Date, Path_Result_Delivery.EmpID, Test_Booking.S_Id, &#13;&#10;                      Admin_Services.S_Amount, 0 AS Expr1, NULL AS Expr2, Path_Result_Delivery.To_SubDept_ID, NULL AS Expr3, Path_Result_Delivery.To_Dept_ID, NULL AS Expr4, &#13;&#10;                      Path_Result_Delivery.Main_ID&#13;&#10;FROM         Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN&#13;&#10;                      Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID&#13;&#10;WHERE     (Path_Result_Delivery.Main_ID = @Main_Id)"
        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_Id" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" CssClass="btn1" Text="For Appointment" />&nbsp;
    <asp:Button ID="Button_Save" runat="server" Text="For Payment"   /> <asp:Button ID="Button_Check_All" runat="server" Text="Check All"   /><asp:Button ID="Button_Uncheck_All" runat="server" Text="Uncheck All"   /></div>
<br />
    <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Investigation_Order_Main SET Status = @Status WHERE (Investigation_Order_ID = @Investigation_Order_ID)">
        <UpdateParameters>
            <asp:Parameter DefaultValue="4" Name="Status" />
            <asp:QueryStringParameter DefaultValue="" Name="Investigation_Order_ID" QueryStringField="Order_id" />
        </UpdateParameters>
    </asp:SqlDataSource>
<br />
 


                <asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_DropDownList" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT SubDept_Name, SubDept_Id, Dept_Id FROM SubDepartment WHERE (Dept_Id = 10)">
                </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_integrationMain_Id" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Integration" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        InsertCommand="INSERT INTO [BasicDataInfo].[dbo].[Patient_Services]&#13;&#10;           ([RegNo]&#13;&#10;           ,[YearlyNo]&#13;&#10;           ,[sdatetime]&#13;&#10;           ,[empid]&#13;&#10;           ,[S_ID]&#13;&#10;           ,[Amount]&#13;&#10;           ,[Payment_Status]&#13;&#10;          &#13;&#10;           ,[SubDept_ID]&#13;&#10;         &#13;&#10;           ,[Dept_ID]&#13;&#10;           )&#13;&#10;     SELECT     Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No, Path_Result_Delivery.Sample_Collection_Date, Path_Result_Delivery.EmpID, &#13;&#10;                      Admin_Services.S_ID, Test_Booking.Public_Price, 1 AS Expr1, Path_Result_Delivery.To_SubDept_ID, Path_Result_Delivery.To_Dept_ID&#13;&#10;FROM         Path_Result_Delivery INNER JOIN&#13;&#10;                      Test_Booking_Services ON Path_Result_Delivery.Main_ID = Test_Booking_Services.Main_ID INNER JOIN&#13;&#10;                      Admin_Services INNER JOIN&#13;&#10;                      Test_Booking ON Admin_Services.S_ID = Test_Booking.S_Id ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID&#13;&#10;where Path_Result_Delivery.Main_Id=@Main_Id"
        SelectCommand="a">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldMain_ID" DefaultValue="" Name="Main_Id"
                PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldTotalAmount" runat="server" />
                <asp:HiddenField ID="HiddenFieldTotalPaid" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceInsertSub" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    InsertCommand="Insert_Pathology_Test_Total_Amount" InsertCommandType="StoredProcedure"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="&#13;&#10;">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldTotal_Discount" Name="TOtal_Discount"
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldTotalPaid" Name="Total_Paid" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldTotalAmount" Name="Total_AMount" PropertyName="Value" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldTotal_Discount" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Test_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Type, Test_Type_ID FROM Test_Type">
                </asp:SqlDataSource>
            

  </asp:Content>