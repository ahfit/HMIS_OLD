<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_billing.master" inherits="Patient_Billing_Indoor_Patient_Paymen, App_Web_asx2a3aw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
     <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../css_hacims/ck.js" type="text/javascript"></script>
    <script type = "text/javascript">
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
</script>

    <script type="text/javascript">

 
		
	 

function Validation()
{
//alert("Validation Main");
if (document.getElementById("TextBox_Discount").value-0!=document.getElementById("TextBox_Discount").value)
    {
    alert("Enter Correct Discount");  
    return false;  
    }
if ((document.getElementById("Label_Amount").value-document.getElementById("TextBox_Discount").value)>0)
    {
    alert("Discount is Less Then The Total Account");  
    return false;  
    }
    
    return Validate_Amount();    
}

function enablelist(a)
{
if(a.checked==true)
{
document.getElementById ("dropdownlistDiagnosis").disabled =false;
}
else
{

document.getElementById ("dropdownlistDiagnosis").disabled =true;
}

}

function Validate_Amount()
{
//alert("Validation Sub");
var total_amount = document.getElementById ("TextBox2").value;
var Discount = document.getElementById ("TextBox_Discount").value;
if (total_amount< Discount) 
{
alert("Discount Must Be Less Then Total Amount");
return false;
}
}

    </script>

    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>

    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="40%" valign="top">
                <h1 class="h1">
                    <span>Servics</span>
                </h1>
            </td>
            <td>
                <h1 class="h1">
                    <span>Payment</span>
                </h1>
            </td>
        </tr>
        <tr>
            <td width="50%" valign="top">
                <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"                    
                    SelectCommand="GetPatientServices" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div align="center">&nbsp;<asp:TextBox ID="TXT_Load_patient" runat="server" 
                        AutoPostBack ="true" Visible="False"></asp:TextBox>
                   <div runat = "server" id = "DIV_P_Payment">
                    <asp:Button ID="Button_lab_Test" runat="server" Text="Built voucher forward to LAB" />
                    <asp:Button ID="btnAddLimit" runat="server" Visible="false"  Text="Add Limits" />    
                    <asp:Button ID="btnAddDependent" runat="server" Visible="false" Text="Add Dependent" />                                    
                   </div></div>
                <br />
                <div class = "bxmain" style="width:98%">
                <asp:GridView ID="GridView_For_Services" runat="server" AutoGenerateColumns="False"
                    DataSourceID="SqlDataSource_For_Grid" Width="98%" 
                        EmptyDataText="No Service Assigned">
                    <RowStyle CssClass="GridItem" />
                    <Columns>

                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                        <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
                        <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                            Visible="False" />
                        <asp:BoundField DataField="S_Name" HeaderText="Service" SortExpression="S_Name" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                        <asp:BoundField DataField="S_ID" HeaderText="S_ID" InsertVisible="False" ReadOnly="True"
                            SortExpression="S_ID" Visible="False" />
                        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" SortExpression="ID"
                            Visible="False" />
                        <asp:BoundField DataField="time" HeaderText="Time" SortExpression="time" Visible="False" />
                           <asp:TemplateField HeaderText="Company">
                            <FooterTemplate>
                                <asp:Label ID="Label_f_Company" runat="server" Text="0"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox_company" runat="server" Width="72px" 
                                    Text='<%# Bind("PanelAmount") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Patient">
                            <FooterTemplate>
                                <asp:Label ID="Label_f_Patient" runat="server" Text="0"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox_Patient" runat="server" Text='<%# Bind("Patient_Value") %>' Width="54px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                   
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="CheckBox1_CheckedChanged" /><br />
                                <asp:HiddenField ID="HF_Service_Cat" runat="server"  Value='<%# Eval("S_Category") %>' />
                                <asp:HiddenField ID="HiddenField_SID" runat="server" Value='<%# Bind("S_ID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Bind("ID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldAmount" runat="server" Value='<%# Eval("S_Amount", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_order_ID" runat="server" Value='<%# Eval("Order_Id", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Eval("TB_ID", "{0}") %>' />                                
                                <asp:HiddenField ID="HiddenField_amountval" runat="server" Value='<%# Eval("Amount", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_Party_ID" runat="server" Value='<%# Eval("Party_Id", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_Refer_By_ID" runat="server" Value='<%# Eval("Refer_By_ID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_Refer_By_Other" runat="server" Value='<%# Eval("Refer_From_Other", "{0}") %>' />
                                <asp:HiddenField ID="hf_Consultant_Remarks" runat="server" Value='<%# Eval("COnsultant_Remarks", "{0}") %>' />
                                 <asp:HiddenField ID="hf_Service_discount" runat="server"  Value='<%# Eval("Discount", "{0}") %>' />
                                  <asp:HiddenField ID="HF_RegNo" runat="server"  Value='<%# Eval("RegNo", "{0}") %>' />
                                <asp:HiddenField ID="HF_YearlyNo" runat="server"  Value='<%# Eval("YearlyNo", "{0}") %>' />

                            </ItemTemplate>
                        </asp:TemplateField>
                     
                    </Columns>

                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
               </div>
               
                &nbsp;<br />
                <asp:Panel ID="pnl_Radiology_Sample" runat="server" ScrollBars="Horizontal" Width="98%">
                    <asp:GridView ID="GridView_Rad_Sample_Recieved" runat="server" AutoGenerateColumns="False"
                        CssClass="Grid_1" DataSourceID="SqlDataSource4" Width="100%">
                        <RowStyle CssClass="GridItem" />
                        <Columns>
                            <asp:TemplateField HeaderText="Sr. No.">
                                <ItemTemplate>
                                    <asp:Label ID="Label_SrNo" runat="server" Width="70px"></asp:Label>
                                    <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                                    <asp:HiddenField ID="HF_Order_ID" runat="server" Value='<%# Eval("Order_ID") %>' />
                                    <asp:HiddenField ID="HF_ServiceType" runat="server" Value='<%# Eval("ServiceType") %>' />
                                    <asp:HiddenField ID="HF_Service_Cat" runat="server" 
                                        Value='<%# Eval("S_Category") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Request Date" SortExpression="Request_Date">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Request_Date") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Request_Date") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Request Time" SortExpression="Request_Time">
                                <EditItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Request_Time") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Request_Time") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Suggested By" SortExpression="Employee">
                                <EditItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Employee") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Employee") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Test Category" SortExpression="TGName">
                                <EditItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("TGName") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("TGName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Test Name" SortExpression="TB_Name">
                                <EditItemTemplate>
                                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("TB_Name") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("TB_Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Test Type" SortExpression="TestType_ID">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                                        DataTextField="Test_Type" DataValueField="Test_Type_ID" SelectedValue='<%# Bind("Test_Type_Id") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"
                                        SelectCommand="SELECT Test_Type_ID, Test_Type FROM Test_Type"></asp:SqlDataSource>
                                    <asp:HiddenField ID="HiddenField_TestBookingId" runat="server" Value='<%# Eval("Test_Booking_ID") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Test_Type") %>'></asp:Label>
                                    <asp:HiddenField ID="HiddenField_TestBookingId" runat="server" Value='<%# Eval("Test_Booking_ID") %>' />
                                    <asp:HiddenField ID="HiddenField_Current" runat="server" Value='<%# Eval("Test_Type_Id") %>' />
                                    <asp:HiddenField ID="HF_S_ID" runat="server" Value='<%# Eval("S_ID") %>' />
                                    <asp:HiddenField ID="HF_S_Amount" runat="server" Value='<%# Eval("S_Amount") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Emp_ID" SortExpression="Emp_ID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="Label_EmpID" runat="server" Text='<%# Bind("Emp_ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Select for Payment">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                    <asp:HiddenField ID="HF_SubDeptID" runat="server" Value='<%# Eval("SubDept_Id") %>' />
                                    <asp:HiddenField ID="HF_Dept_ID" runat="server" Value='<%# Eval("DeptId") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>"
                        SelectCommand="[Select_Radiology_For_Payment]" UpdateCommand="Update Investigation_Order_Sub &#13;&#10;set Investigation_Order_Sub.TestType_ID=@Test_Type_Id, Investigation_Order_Sub.Description=@description&#13;&#10;From Investigation_Order_Main INNER JOIN&#13;&#10;                      Investigation_Order_Sub ON Investigation_Order_Main.Investigation_Order_ID = Investigation_Order_Sub.Investigation_Order_ID &#13;&#10;where Investigation_Order_Sub.TB_ID=@TB_ID and Investigation_Order_Main.YearlyNo=@YearlyNo &#13;&#10;                      and Investigation_Order_Main.RegNo=@RegNo&#13;&#10;&#13;&#10;&#13;&#10;UPDATE Test_Booking SET Test_Type_Id = @Test_Type_Id WHERE (TB_ID = @TB_ID)"
                        SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                            <asp:SessionParameter Name="Hospital_Id" SessionField="PatientHospital_ID" Type="Int32" />
                            <asp:SessionParameter Name="Patient_Type_Id" SessionField="Patient_Type_Id" Type="Int32" />
                            <asp:SessionParameter Name="IPD_OPD" SessionField="IPDOPD" Type="String" />
                            <asp:SessionParameter DefaultValue="" Name="Billing_Party_Id" SessionField="PatientBillingParty_Id"
                                Type="Decimal" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="HiddenField2" Name="Test_Type_Id" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenField1" Name="TB_ID" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenField_Description" Name="description" PropertyName="Value" />
                            <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
                            <asp:QueryStringParameter Name="RegNo" QueryStringField="Reg_No" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HF_Rad_Order_ID" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"
                        InsertCommand="INSERT INTO [BasicDataInfo].[dbo].[Patient_Services]&#13;&#10;           ([RegNo]&#13;&#10;           ,[YearlyNo]&#13;&#10;           ,[sdatetime]&#13;&#10;           ,[empid]&#13;&#10;           ,[S_ID]&#13;&#10;           ,[Amount]&#13;&#10;           ,[Payment_Status]&#13;&#10;           ,[Doctor_ID]&#13;&#10;           ,[SubDept_ID]&#13;&#10;           ,[Doctor_Payment]&#13;&#10;           ,[Dept_ID]&#13;&#10;           ,[ResonForCancellation]&#13;&#10;           ,Order_ID)&#13;&#10;  &#13;&#10;&#13;&#10;SELECT     Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No, Path_Result_Delivery.Test_Booking_Date, Path_Result_Delivery.EmpID, Test_Booking.S_Id, &#13;&#10;                      Admin_Services.S_Amount, 0 AS Expr1, NULL AS Expr2, Path_Result_Delivery.To_SubDept_ID, NULL AS Expr3, Path_Result_Delivery.To_Dept_ID, NULL AS Expr4, &#13;&#10;                      Path_Result_Delivery.Main_ID&#13;&#10;FROM         Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN&#13;&#10;                      Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID&#13;&#10;WHERE     (Path_Result_Delivery.Main_ID = @Main_Id)"
                        ProviderName="<%$ ConnectionStrings:Pathology2ConnectionString.ProviderName %>">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_Id" PropertyName="Value" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HF_Rad_FromDept_Id" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSourceRadInsertSub" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        InsertCommand="Insert_Pathology_Test_Total_Amount" InsertCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>"
                        SelectCommand="&#13;&#10;">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value" />
                            <asp:Parameter DefaultValue="0" Name="TOtal_Discount" />
                            <asp:Parameter DefaultValue="0" Name="Total_Paid" />
                            <asp:Parameter DefaultValue="0" Name="Total_AMount" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HF_Rad_FromSubDept_ID" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSource_Rad_Patient_Services" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                        InsertCommand="[Insert_Pathology_Patient_Services]" ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>"
                        UpdateCommand="UPDATE Investigation_Order_Main SET Status = @Status WHERE (Investigation_Order_ID = @Investigation_Order_ID)"
                        InsertCommandType="StoredProcedure">
                        <UpdateParameters>
                            <asp:Parameter DefaultValue="4" Name="Status" />
                            <asp:QueryStringParameter DefaultValue="" Name="Investigation_Order_ID" QueryStringField="Order_id" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HF_Rad_Order_ID" Name="Order_ID" PropertyName="Value"
                                Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Rad_Main_ID" runat="server" />
                    <asp:HiddenField ID="HiddenField8" runat="server" />
                    <asp:HiddenField ID="HiddenField_Consultant_Remarks" runat="server" />
                    <asp:HiddenField ID="hf_SERVICES_discount" runat="server" />
                    <asp:Button ID="Button_Rad_For_Payment" runat="server" Text="Add to Bill" />
                    <asp:Button ID="Button_CheckAll" runat="server" Text="Check All" />
                    <asp:Button ID="Button_Un_Check_All" runat="server" Text="Uncheck All" /></asp:Panel>
            </td>
            <td>
                 <div class="bxmain" style="width:99%">
                <h4>
                    <span style = "text-align :right; width :100%; color :Maroon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Final Bill : 
                    <asp:CheckBox ID = "CKFinal" runat = "server" AutoPostBack="True" /> </span></h4>
                     <div id="div_final" runat="server" style="display:none">
                         <asp:TextBox ID="txt_remarks" runat="server" Height="160px" 
                             TextMode="MultiLine"></asp:TextBox>
                     </div>
                     <p>
                         &nbsp;</p>
                   </div>
                <div class="bxmain"  style="width:99%">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td valign="top" width="50%">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                    <tr>
                                        <td align="Left" width="40%" colspan="2">
                                              <fieldset class="fset_1" style="width: 98%;">
                                    <legend>Payment Status</legend>
                                </fieldset></td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="40%">
                                            Current Payment :</td>
                                        <td>
                                            <asp:TextBox ID="TextBox2" runat="server" CssClass="input_txt" Width="64px" 
                                                SkinID="intdata" Enabled="False"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="Label_advance_Pay" runat="server" Text="Advance Payment :"></asp:Label></td>
                                        <td>
                                            <strong>
                                                <asp:Label ID="Label_Ad_Payment" runat="server" CssClass="txt_bold">0</asp:Label>
                                            </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Discount :&nbsp;</td>
                                        <td>
                                            <asp:Label ID="Label_Discount" runat="server" CssClass="txt_bold" Style="color: #900;
                                                font-size: 12px; font-weight: bold;">0</asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="Label_refund_pay" runat="server" Text="Refund Payment : "></asp:Label>
                                            
                                            </td>
                                        <td>
                                          <div style="float:left;width:20%;    line-height: 22px;">
                                            <asp:Label ID="Label_Refund" runat="server" CssClass="txt_bold" Style="font-weight: bold;">0</asp:Label>
                                            </div>
                                            <div style="float:left;width:80%;">
                                            
                                            <asp:RadioButtonList ID="rdoRefund" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Text="Refund" Value="Refund" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Payable" Value="Payable"></asp:ListItem>
                                            </asp:RadioButtonList>
                                            </div>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Due Payment :
                                        </td>
                                        <td>
                                            <strong>
                                                <asp:Label ID="Label_Remaining_Balance" runat="server" CssClass="txt_bold" Style="color: #060;
                                                    font-size: 12px; font-weight: bold;">0</asp:Label></strong></td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="height: 18px">
                                            <strong>Cash Payment &nbsp;:</strong></td>
                                        <td style="height: 18px">
                                            <asp:Label ID="Label_Cash" runat="server" Style="font-weight: bold;">0</asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" width="50%">
                                <fieldset class="fset_1" style="width: 98%;">
                                    <legend>Advance Payment</legend>
                                </fieldset>
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                                    DataKeyNames="Payment_No" DataSourceID="SqlDataSource2" Width="40%" ShowHeader="false">
                                    <RowStyle CssClass="GridItem" />
                                    <Columns>
                                        <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox_checked" runat="server" AutoPostBack="True" />
                                                <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("Payment_No", "{0}") %>' />
                                                <asp:HiddenField ID="HiddenField_Amount" runat="server" Value='<%# Eval("Amount", "{0}") %>' />
                                                <asp:HiddenField ID="HiddenField_type" runat="server" Value='<%# Eval("Payment_Type", "{0}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT DISTINCT YearlyNo, CONVERT (varchar, Pay_DateTime, 107) AS Date, CONVERT (varchar, Pay_DateTime, 108) AS Time, Amount, Check_No, Bank_Name, Branch_Name, Payment_No, Status, Payment_Type FROM Advance_Payment WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (Status = 0)"
                                    UpdateCommand="usp_UpdateAdvancePayment" UpdateCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
                                        <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payid" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Payment_No" Name="Payment_No" PropertyName="Value" Type="Int32" />
                                        <asp:ControlParameter ControlID="HiddenFieldMainId" Name="SPM_ID" PropertyName="Value" Type="Int32" />
                                        <asp:ControlParameter ControlID="HiddenFieldreturnID" Name="RefundID" PropertyName="Value" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top">
                            <div class="bx_rad" style="width: 100%;">
                                <ul id="tp1">
                                    <li><strong>&nbsp; Credit Card</strong></li><li>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                            <tr>
                                                <td align="right" width="25%">
                                                    Amount :</td>
                                                <td width="25%">
                                                    <asp:TextBox ID="TextBox_Credit_Card" runat="server" AutoPostBack="True" SkinID="intdata"
                                                        Width="100px">0</asp:TextBox></td>
                                                <td align="right" width="25%">
                                                    Card # :</td>
                                                <td width="25%">
                                                    <asp:TextBox ID="TextBox_Credit_Card_No" runat="server" Width="100px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Card Type :</td>
                                                <td>
                                                    <asp:DropDownList ID="DropDownList_Card_Type" runat="server" Width="156px">
                                                        <asp:ListItem>Master Card</asp:ListItem>
                                                        <asp:ListItem>Visa Card</asp:ListItem>
                                                        <asp:ListItem>American Express</asp:ListItem>
                                                    </asp:DropDownList></td>
                                                <td align="right">
                                                    Card Service :</td>
                                                <td>
                                                    <asp:DropDownList ID="DropDownList_Card_Service" runat="server" Width="107px">
                                                        <asp:ListItem>Credit</asp:ListItem>
                                                        <asp:ListItem>Debit</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Bank Name :</td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Bank_Name" runat="server" Width="100px"></asp:TextBox></td>
                                                <td align="right">
                                                    Approval # :</td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_approval_no" runat="server" Width="100px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                </td>
                                                <td>
                                                </td>
                                                <td align="right">
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </li>
                                </ul>
                            </div>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <div class="bx_rad" style="width: 100%;">
                                <ul id="CollapsiblePanel276">
                                    <li><strong>&nbsp; Cheque</strong></li><li>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                            <tr>
                                                <td align="right" width="25%" style="height: 25px">
                                                    Amount :</td>
                                                <td width="25%" style="height: 25px">
                                                    <asp:TextBox ID="TextBox_Cheque" runat="server" AutoPostBack="True" Width="100px">0</asp:TextBox></td>
                                                <td align="right" width="25%" style="height: 25px">
                                                    Cheque # :</td>
                                                <td width="25%" style="height: 25px">
                                                    <asp:TextBox ID="TextBox_Cheque_No" runat="server" Width="100px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Bank Name :</td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Cheque_Branch" runat="server" Width="100px"></asp:TextBox></td>
                                                <td align="right">
                                                    Cheque Date :
                                                </td>
                                                <td>
                                                    <igsch:WebDateChooser ID="WebDateChooser_Cheque_Date" runat="server" CssClass="drop_date"
                                                        Width="102px">
                                                        <CalendarLayout Culture="English (United Kingdom)">
                                                        </CalendarLayout>
                                                    </igsch:WebDateChooser>
                                                </td>
                                            </tr>
                                        </table>
                                    </li>
                                </ul>
                            </div>
                            <br />
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td colspan="2">
                            <asp:Panel ID="Panel_Discount" runat="server" Visible="false">
                                <table style="width:99%">
                                    <tr>
                                        <td colspan="2">
                                            <asp:RadioButtonList ID="RadioButtonList2" runat="server" AutoPostBack="True" 
                                                RepeatDirection="Horizontal" Visible="False">
                                                <asp:ListItem Selected="True" Value="Is_Consultant">Consultant</asp:ListItem>
                                                <asp:ListItem Value="2">Administrator</asp:ListItem>
                                            </asp:RadioButtonList></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Hospital:</td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList_Hospital" runat="server" AutoPostBack="True" 
                                                DataSourceID="SqlDataSourceHospital" DataTextField="Hospital_Name" 
                                                DataValueField="Hospital_ID">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSourceHospital" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                                                SelectCommand="SELECT Hospital_ID, Hospital_Name FROM Hospital ORDER BY Hospital_Name">
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 98px; height: 12px; text-align: right">
                                            Forword To:</td>
                                        <td style="width: 100px; height: 12px">
                                            <asp:DropDownList ID="DropDownList_Consultant" runat="server" DataSourceID="SqlDataSourceEmployee"
                                                DataTextField="Employee Name" DataValueField="EmpID">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                                SelectCommand="SELECT Employee.EmpID,ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name] FROM Employee JOIN PatientBillling.dbo.DiscountAuthorities DA ON DA.EmpId=Employee.EmpID ORDER BY EFName">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="DropDownList_Hospital" Name="Hospital_ID" 
                                                        PropertyName="SelectedValue" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 98px; height: 24px; text-align: right">
                                            Description:</td>
                                        <td style="width: 100px; height: 24px">
                                            <asp:TextBox ID="TextBox_Description" runat="server" Height="55px" TextMode="MultiLine"
                                                Width="231px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 98px; height: 24px; text-align: right">
                                        </td>
                                        <td style="width: 100px; height: 24px">
                                            <asp:Button ID="Button_ForwardDisReq" runat="server" Text="Forward" />
                                            <asp:HiddenField ID="HiddenField_SubDeptId" runat="server" />
                                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                                InsertCommand="INSERT INTO Forward_To_Sub_Dept (Reg_No, yearly_no, to_sub_Dept, by_doctor, by_sub_dept_id, forward_date, request_type_id, To_Emp_Id, Description) VALUES     (@Reg_No,@yearly_no,@to_sub_Dept,@by_doctor,@by_sub_dept_id,getdate(),@request_type_id,@To_Emp_Id,@Description)"
                                                
                                                SelectCommand="SELECT [Reg_No], [yearly_no], [to_sub_Dept], [by_doctor], [by_sub_dept_id], [forward_date], [request_type_id], [To_Emp_Id], [Description] FROM [Forward_To_Sub_Dept]" UpdateCommand="UPDATE Discount_Main SET SPM_ID = @SPM_ID WHERE     (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (Payment_Status = 0)">
                                                <InsertParameters>
                                                    <asp:SessionParameter Name="Reg_No" SessionField="RegistrationNo" />
                                                    <asp:SessionParameter Name="yearly_no" SessionField="YearlyNo" />
                                                    <asp:ControlParameter ControlID="HiddenField_SubDeptId" Name="to_sub_Dept" PropertyName="Value" />
                                                    <asp:SessionParameter Name="by_doctor" SessionField="Emp_Id" />
                                                    <asp:ControlParameter ControlID="HiddenField_BySubDeptId" Name="by_sub_dept_id" PropertyName="Value" />
                                                    <asp:Parameter DefaultValue="15" Name="request_type_id" />
                                                    <asp:ControlParameter ControlID="DropDownList_Consultant" Name="To_Emp_Id" PropertyName="SelectedValue" />
                                                    <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text" />
                                                </InsertParameters>
                                                <UpdateParameters>
                                                    <asp:ControlParameter ControlID="HiddenField_smpID" Name="SPM_ID" 
                                                        PropertyName="Value" />
                                                    <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                                                    <asp:QueryStringParameter Name="YearlyNo" QueryStringField="Payid" />
                                                </UpdateParameters>
                                            </asp:SqlDataSource>
                                            <asp:HiddenField ID="HiddenField_BySubDeptId" runat="server" />
                                        </td>
                                        <td><asp:Button ID="btnForwardAndPrint" OnClientClick="SetTarget();" runat="server" Text="Forward And Print" /></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                    </tr>
                </table>
                <div class="bxmain"  style="width:99%">
                    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                        <tr>
                            <td align="right" width="40%">
                                Panel :</td>
                            <td>
                                <asp:TextBox ID="TextBox_Panel" runat="server" AutoPostBack="True" Enabled="False">0</asp:TextBox></td>
                        </tr>
                        <tr>
                            <td align="right">
                                Company :</td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Company" runat="server" DataSourceID="SqlDataSource_parties"
                                    DataTextField="Party_Name" DataValueField="Party_Id" Enabled="True">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td align="right" style="height: 18px">
                            </td>
                            <td style="height: 18px">
                                <asp:Button ID="Button1" runat="server" Text="Save" 
                                    OnClientClick="return Validation()" Visible="False" />
                                <asp:Button ID="Button_Report" runat="server" Text="Save &amp; Print" 
                                    OnClientClick="javascript: return confirm('Are you sure you want to Save and print?')" />
 <asp:Button ID="btn_refundReport" runat="server" Text="Refund Report" 
                                    OnClientClick="return Validation()" Visible = "false" />
                                    <asp:HyperLink ID ="hylk_discount" runat = "server" CssClass="btn_hacims" Visible="False" 
                                     >Discount</asp:HyperLink>
                                <asp:Button ID="Button_Discount" runat="server" Text="Discount" Visible = "true" />
                               
                                <asp:Button ID="Btn_Revoke_discount" runat="server" 
                                    OnClientClick="return Validation()" Text="Revoke Discount" 
                                    Visible="False" />
                                <asp:Button ID="Btn_Grant_discount" runat="server" 
                                    OnClientClick="return Validation()" Text="Grant Discount" 
                                    Visible="False" />
                                <asp:SqlDataSource ID="SDS_Grant_Discount" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                                    InsertCommand="INSERT INTO Manual_discount(Reg_No, Yearly_No, PS_ID, Amount, Grant_by, Grant_Time) VALUES (@Reg_No, @Yearly_No, @PS_ID, @Amount, @EMP_ID, GETDATE())" 
                                    UpdateCommand="UPDATE Patient_Services SET Discount = @Discount  WHERE (ID = @ID)">
                                    <InsertParameters>
                                        <asp:Parameter Name="Reg_No" />
                                        <asp:Parameter Name="Yearly_No" />
                                        <asp:Parameter Name="PS_ID" />
                                        <asp:Parameter Name="Amount" />
                                        <asp:SessionParameter Name="EMP_ID" SessionField="emp_id" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="ID" />
                                        <asp:Parameter Name="Discount" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="LabelAmountInsert" runat="server" CssClass="err" Visible="False"></asp:Label></td>
                        </tr>
                    </table>
                    <asp:SqlDataSource ID="SDS_Patient_track" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                        InsertCommand="usp_Patient_forward_to_sebdept" InsertCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
                        <InsertParameters>
                            <asp:QueryStringParameter Name="Reg_No" QueryStringField="regno" Type="String" />
                            <asp:QueryStringParameter Name="yearly_no" QueryStringField="payid" Type="Decimal" />
                            <asp:SessionParameter Name="to_sub_Dept" SessionField="SubDeptID" Type="Int32" />
                            <asp:SessionParameter Name="by_doctor" SessionField="Emp_id" Type="Int32" />
                            <asp:SessionParameter Name="by_sub_dept_id" SessionField="SubDeptID" Type="Int32" />
                            <asp:ControlParameter ControlID="HF_track_date" DefaultValue="" Name="forward_date"
                                PropertyName="Value" Type="DateTime" />
                            <asp:Parameter DefaultValue="7" Name="request_type_id" Type="Int32" />
                            <asp:Parameter DefaultValue="N/A" Name="Description" Type="String" />
                            <asp:SessionParameter Name="To_Emp_Id" SessionField="emp_id" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HF_track_date" runat="server" />
                    <asp:HiddenField ID="HF_PS_ID" runat="server" />
                    <asp:SqlDataSource ID="SDS_Patient_invoice" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString1 %>"
                        InsertCommand="JV_PatientInvoice" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:FinanceConnectionString1.ProviderName %>">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HiddenField_smpID" Name="SO_ID" PropertyName="Value" />
                            <asp:SessionParameter Name="By_Emp_Id" SessionField="Emp_id" />
                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                            <asp:SessionParameter Name="Dept_Id" SessionField="Dept_ID" />
                            <asp:SessionParameter Name="SubDept_Id" SessionField="Subdeptid" />
                            <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SDS_Revoke_discount" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                        InsertCommand="INSERT INTO Revoke_discount(Reg_No, Yearly_No, PS_ID, Amount, Rvoke_by, Revoke_Time) VALUES (@Reg_No, @Yearly_No, @PS_ID, @Amount, @EMP_ID, GETDATE())" 
                        UpdateCommand="UPDATE Patient_Services SET Discount = 0 WHERE (ID = @ID)">
                        <InsertParameters>
                            <asp:Parameter Name="Reg_No" />
                            <asp:Parameter Name="Yearly_No" />
                            <asp:Parameter Name="PS_ID" />
                            <asp:Parameter Name="Amount" />
                            <asp:SessionParameter Name="EMP_ID" SessionField="EMP_ID" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="ID" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <asp:DropDownList ID="DropDownList_Cost_Centre" runat="server" DataSourceID="SqlDataSource_Cost_Centre"
                    DataTextField="Cost_Centre" DataValueField="Cost_Centre_Id" Width="145px" Visible="False">
                </asp:DropDownList>
                <asp:Label ID="Label_Bill_Payed" runat="server" CssClass="txt_bold" Visible="False"></asp:Label>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatColumns="3" RepeatLayout="Flow"
                    Visible="False">
                    <asp:ListItem Selected="True">Paid</asp:ListItem>
                    <asp:ListItem>Free</asp:ListItem>
                    <asp:ListItem>Remaining</asp:ListItem>
                </asp:RadioButtonList>
                <asp:TextBox ID="TextBox_Discount" runat="server" CssClass="input_txt" Width="100px"
                    Visible="False" Wrap="False">0</asp:TextBox>
                <asp:Label ID="Label2" runat="server" CssClass="txt_bold mymargin" Visible="False"
                    Width="85px"></asp:Label>
                <asp:TextBox ID="TextBox_Discount_By" runat="server" CssClass="input_txt" Width="100px"
                    Visible="False" Wrap="False"></asp:TextBox>
                <asp:Label ID="Label_Amount" runat="server" CssClass="txt_bold mymargin" Visible="False"
                    Width="85px"></asp:Label><br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    UpdateCommand="UPDATE Patient_Services SET Payment_Status = 1 WHERE (ID = @ID) &#13;&#10;&#13;&#10;Update Advance_Payment SET Payment_Status=1 Where YearlyNo=@YearlyNo"
                    InsertCommand="Insert_Patient_Refund_Amount" InsertCommandType="StoredProcedure">
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenFieldID" Name="ID" PropertyName="Value" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="Label_Refund" Name="Refund_Amount" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="Label_Ad_Payment" Name="Advance_payment" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="Label_Amount" Name="Current_Payment" PropertyName="Text"
                            Type="Int32" />
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:RadioButtonList ID="RadioButtonList_ReportType" runat="server" RepeatDirection="Horizontal"
                    Visible="False">
                    <asp:ListItem Selected="True" Value="1">Hospital Report</asp:ListItem>
                    <asp:ListItem Value="2">Consultant Report</asp:ListItem>
                </asp:RadioButtonList>
                <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Cost_Centre" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                    SelectCommand="SELECT [Cost_Centre], [Cost_Centre_Id] FROM [Cost_Centre]"></asp:SqlDataSource>
                 <asp:SqlDataSource ID="SqlDataSource_test_Booking_OT" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:OTConnectionString %>" 
                     InsertCommand="Insert_into_Path_Result_Delivery" 
                     InsertCommandType="StoredProcedure" 
                     ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" 
                     UpdateCommand="UPDATE Path_Result_Delivery SET Fee_paid = 1 WHERE (Main_ID = @Main_ID)">
                     <InsertParameters>
                         <asp:SessionParameter Name="Reg_no" SessionField="RegistrationNo" 
                             Type="String" />
                         <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Decimal" />
                         <asp:ControlParameter ControlID="HiddenField_Main_ID_Radiology" DefaultValue="" 
                             Name="Sample_No" PropertyName="Value" Type="Int32" />
                         <asp:Parameter DefaultValue="0" Name="Grand_Discount" Type="Int32" />
                         <asp:Parameter DefaultValue="" Name="Description" Type="String" />
                         <asp:Parameter DefaultValue="0" Name="HospitalOrderNo" Type="Int32" />
                         <asp:SessionParameter Name="From_Dept_ID" SessionField="Dept_ID" Type="Int32" />
                         <asp:SessionParameter Name="From_SubDept_ID" SessionField="SubDeptID" 
                             Type="Int32" />
                         <asp:ControlParameter ControlID="HiddenField_To_Dept_ID" DefaultValue="" 
                             Name="To_Dept_ID" PropertyName="Value" Type="Int32" />
                         <asp:ControlParameter ControlID="HiddenField_To_Sub_Dept_ID" DefaultValue="" 
                             Name="To_SubDept_ID" PropertyName="Value" Type="Int32" />
                         <asp:SessionParameter Name="emp_ID" SessionField="emp_ID" Type="Int32" />
                         <asp:Parameter DefaultValue="12" Name="Status" Type="Int32" />
                         <asp:ControlParameter ControlID="HiddenField_TB_ID" Name="TB_ID" 
                             PropertyName="Value" Type="Int32" />
                         <asp:ControlParameter ControlID="HiddenField_S_ID" Name="S_ID" 
                             PropertyName="Value" Type="Int32" />
                         <asp:ControlParameter ControlID="HiddenField_Mg_ID" Name="Mg_ID" 
                             PropertyName="Value" Type="Int32" />
                         <asp:Parameter Direction="Output" Name="main_ID_Patient" Type="Int32" />
                         <asp:ControlParameter ControlID="HF_PS_ID" Name="PS_ID" PropertyName="Value" 
                             Type="Int32" />
                     </InsertParameters>
                     <UpdateParameters>
                         <asp:ControlParameter ControlID="HiddenField_Main_ID_Radiology" Name="Main_ID" 
                             PropertyName="Value" />
                     </UpdateParameters>
                 </asp:SqlDataSource>
                 <asp:SqlDataSource ID="SqlDataSource_OT_test_booking" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:OTConnectionString %>" 
                     ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" 
                     UpdateCommand="update_status" UpdateCommandType="StoredProcedure">
                     <UpdateParameters>
                         <asp:ControlParameter ControlID="HiddenField_Order_ID" DefaultValue="" 
                             Name="Main_ID" PropertyName="Value" />
                     </UpdateParameters>
                 </asp:SqlDataSource>
                 <br />
                <asp:HiddenField ID="HiddenField_Order_ID" runat="server" />
                <asp:HiddenField ID="HiddenFieldID" runat="server" />
                <asp:HiddenField ID="HiddenFieldreturnID" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceUpdatePayment" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Payment SET DischargeStatus = 1 WHERE (PayID = @PayID) AND (RegNo = @RegNo) AND (DeptID = @DeptID)">
                    <UpdateParameters>
                        <asp:SessionParameter Name="PayID" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                        <asp:ControlParameter ControlID="HiddenFieldDept_id" Name="DeptID" PropertyName="Value" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceCounterClose" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    InsertCommand="Insert_Counter_Close_Sub" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    InsertCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenFieldMainId" Name="Main_Id" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldAmount" Name="Amount" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldPaymentTpye" Name="Amount_Type" PropertyName="Value" />
                        <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />
                        <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:ControlParameter ControlID="DropDownList_Cost_Centre" Name="PaymentCategory"
                            PropertyName="SelectedValue" />
                        <asp:SessionParameter Name="EMP_ID" SessionField="emp_id" Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenFieldreturnID" Name="refund_id" 
                            PropertyName="Value" Type="Decimal" />
                        <asp:ControlParameter ControlID="HiddenField_smpID" Name="SMP_ID" 
                            PropertyName="Value" Type="Int32" />
                        <asp:Parameter Name="Adv_payment_ID" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SDS_Refund" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    InsertCommand="Insert_Patient_Refund_Amount"
                    
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                    InsertCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:ControlParameter ControlID="HiddenFieldAmount" Name="Refund_Amount" PropertyName="Value" />
                        <asp:Parameter DefaultValue="0" Name="Advance_payment" />
                        <asp:Parameter DefaultValue="0" Name="Current_Payment" />
                        <asp:Parameter DefaultValue="" Name="IsRefund" />
                        <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" />
                        <asp:ControlParameter ControlID="HiddenField_smpID" Name="SMP_ID"  PropertyName="Value" />                        
                        <asp:ControlParameter ControlID="HiddenFieldreturnID" Name="Refund_id"  PropertyName="Value" Type="Decimal" Direction="InputOutput" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldMainId" runat="server" />
                <asp:HiddenField ID="HiddenFieldPaymentTpye" runat="server" />
                <asp:HiddenField ID="HiddenField3" runat="server" />
                <asp:HiddenField ID="HiddenFieldAmount" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourcePendingAmount" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    InsertCommand="INSERT INTO Patient_Pending_Payment(YearlyNo, RegNo, Amount) VALUES (@YearlyNo, @RegNo, @Amount)"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                    <InsertParameters>
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                        <asp:ControlParameter ControlID="HiddenFieldAmount" Name="Amount" PropertyName="Value" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_Radiology_test_booking" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>"
                    UpdateCommand="update_status" UpdateCommandType="StoredProcedure">
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenField_Order_ID" DefaultValue="" Name="Main_ID"
                            PropertyName="Value" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Patient_type" runat="server" />
                <asp:HiddenField ID="HiddenField_Service_ID" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Company" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                    SelectCommand="SELECT Account_Title, Account_No FROM Account_Titles WHERE (Entity_Type_Id = 1)">
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_smpID" runat="server" />
                <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                    ID="SqlDataSource_Booking" InsertCommand="INSERT INTO Lab_Status_Record&#13;&#10;                      (TB_ID, Order_ID, Status)&#13;&#10;VALUES     (@TB_ID,@Order_ID,@Status)"
                    ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" runat="server"
                    UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE (Main_ID = @Main_ID)   &#13;&#10;&#13;&#10;">
                    <UpdateParameters>
                        <asp:Parameter DefaultValue="12" Name="Status" />
                        <asp:ControlParameter ControlID="HiddenField_Order_ID" DefaultValue="" Name="Main_ID"
                            PropertyName="Value" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenField_TB_ID" DefaultValue="" Name="TB_ID"
                            PropertyName="Value" />
                        <asp:Parameter DefaultValue="12" Name="Status" />
                        <asp:ControlParameter ControlID="HiddenField_main_ID_patient" DefaultValue="" Name="Order_ID"
                            PropertyName="Value" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="	SELECT     Parties.Party_Id, Parties.Party_Name
	FROM         Parties 
	INNER JOIN Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id 
	LEFT OUTER JOIN Payment ON Patient_Billing_Party.Billing_Party_Id = Payment.Billing_Party_Id

	where RegNo=@RegNo ">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="regNo" QueryStringField="regno" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Party_ID" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Payment_Card_Cheque" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                    DeleteCommand="DELETE FROM [Payment_Card_Cheque] WHERE [Payment_ID] = @Payment_ID"
                    InsertCommand="INSERT INTO [Payment_Card_Cheque] ([SPM_ID], [Mode_of_Payment], [Cheque_Card_No], [Card_Type], [Bank_Name], [Approval_No], [Card_Service]) VALUES (@SPM_ID, @Mode_of_Payment, @Cheque_Card_No, @Card_Type, @Bank_Name, @Approval_No, @Card_Service)"
                    SelectCommand="SELECT [Payment_ID], [SPM_ID], [Mode_of_Payment], [Cheque_Card_No], [Card_Type], [Bank_Name], [Approval_No], [Card_Service] FROM [Payment_Card_Cheque]"
                    UpdateCommand="UPDATE [Payment_Card_Cheque] SET [SPM_ID] = @SPM_ID, [Mode_of_Payment] = @Mode_of_Payment, [Cheque_Card_No] = @Cheque_Card_No, [Card_Type] = @Card_Type, [Bank_Name] = @Bank_Name, [Approval_No] = @Approval_No, [Card_Service] = @Card_Service WHERE [Payment_ID] = @Payment_ID">
                    <DeleteParameters>
                        <asp:Parameter Name="Payment_ID" Type="Decimal" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="SPM_ID" Type="Decimal" />
                        <asp:Parameter Name="Mode_of_Payment" Type="String" />
                        <asp:Parameter Name="Cheque_Card_No" Type="String" />
                        <asp:Parameter Name="Card_Type" Type="String" />
                        <asp:Parameter Name="Bank_Name" Type="String" />
                        <asp:Parameter Name="Approval_No" Type="String" />
                        <asp:Parameter Name="Card_Service" Type="String" />
                        <asp:Parameter Name="Payment_ID" Type="Decimal" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="SPM_ID" Type="Decimal" />
                        <asp:Parameter Name="Mode_of_Payment" Type="String" />
                        <asp:Parameter Name="Cheque_Card_No" Type="String" />
                        <asp:Parameter Name="Card_Type" Type="String" />
                        <asp:Parameter Name="Bank_Name" Type="String" />
                        <asp:Parameter Name="Approval_No" Type="String" />
                        <asp:Parameter Name="Card_Service" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_To_Dept_ID" runat="server" />
                <asp:HiddenField ID="HiddenField_To_Sub_Dept_ID" runat="server" />
                <asp:HiddenField ID="HiddenField_Inves_SubDept_Id" runat="server" />
                <asp:HiddenField ID="HiddenField_Inves_Dept_Id" runat="server" />
                
                 <asp:SqlDataSource ID="sds_final_bill_discharge" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                     InsertCommand="Patient_Discharge_FinalBill" InsertCommandType="StoredProcedure" 
                     ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                     <InsertParameters>
                         <asp:QueryStringParameter Name="Yearly_No" QueryStringField="payid" 
                             Type="Decimal" />
                         <asp:QueryStringParameter Name="Reg_No" QueryStringField="regno" 
                             Type="String" />
                     </InsertParameters>
                 </asp:SqlDataSource>
                 <asp:SqlDataSource ID="SqlDataSourceRefundRequest" runat="server" 
                     CancelSelectOnNullParameter="False" 
                     ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" InsertCommand="
                     if not exists(select * from Refund_Requests where YearlyNo=@YearlyNo and SPM_ID=@SPM_ID and PS_ID=@PS_ID )
begin 
INSERT INTO Refund_Requests
                      (RegNo, YearlyNo, PS_ID, S_ID, SPM_ID, Requested_By, Requested_Date, Amount, Discount)
VALUES     (@RegNo,@YearlyNo,@PS_ID,@S_ID,@SPM_ID,@Requested_By, GETDATE(),@Amount,@Discount) end" 
                     ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                     <InsertParameters>
                         <asp:Parameter Name="RegNo" />
                         <asp:Parameter Name="YearlyNo" />
                         <asp:Parameter Name="PS_ID" />
                         <asp:Parameter Name="S_ID" />
                         <asp:Parameter Name="SPM_ID" />
                         <asp:SessionParameter Name="Requested_By" SessionField="emp_id" />
                         <asp:Parameter Name="Amount" />
                         <asp:Parameter Name="Discount" />
                     </InsertParameters>
                 </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <div align="center">
        <asp:Button ID="Button2" runat="server" Text="View Reciept" Visible="False" /></div>
    <br />
    <asp:GridView ID="GridView_View_Payments" runat="server" AutoGenerateColumns="False"
        CssClass="Grid_1" DataSourceID="SqlDataSource_For_View" DataKeyNames="SPS_ID"
        Width="100%" ShowFooter="True" AllowPaging="True">
        <Columns>
            <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                Visible="False" />
            <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="RegNo,YearlyNo,SPM_ID" DataNavigateUrlFormatString="DuplicatePatientServices.aspx?RegNo={0}&amp;Yearlyno={1}&amp;SPMID={2}"
                DataTextField="SPM_ID" HeaderText="Receipt No." Target="_blank" />
            <asp:BoundField DataField="S_Name" HeaderText="Services" SortExpression="S_Name" />
            <asp:TemplateField HeaderText="Date Time" SortExpression="Date_Time">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Date_Time") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Date_Time") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("P_SID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_mainID" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_Amount" runat="server" Value='<%# Eval("S_Amount", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_SPM_ID" runat="server" Value='<%# Eval("SPM_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldRegNo" runat="server" 
                        Value='<%# Eval("RegNo") %>' />
                    <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" 
                        Value='<%# Eval("YearlyNo") %>' />
                    <asp:HiddenField ID="HiddenFieldS_id" runat="server" 
                        Value='<%# Eval("S_ID") %>' />
                        <asp:HiddenField ID="HiddenFieldDiscount" runat="server" 
                        Value='<%# Eval("Discount") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="S_Amount" HeaderText="Amount" SortExpression="S_Amount" />
            <asp:TemplateField HeaderText="Status" SortExpression="Status">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtn_cancel" runat="server" CausesValidation="False" 
                        CommandName="Select" Text="Cancel" Visible='<%# Eval("Column1") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="SPS_ID" HeaderText="SPS_ID" InsertVisible="False" SortExpression="SPS_ID"
                Visible="False" />
            <asp:BoundField DataField="P_SID" HeaderText="P_SID" SortExpression="P_SID" Visible="False" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <FooterStyle CssClass="myfooter" />
    </asp:GridView>    
    <%--<asp:GridView ID="GridView_View_Payments" runat="server" AutoGenerateColumns="False"
        CssClass="Grid_1" DataSourceID="SqlDataSource_For_View" DataKeyNames="SPS_ID"
        Width="100%" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo"
                Visible="False" />
            <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="RegNo,YearlyNo,SPM_ID" DataNavigateUrlFormatString="DuplicatepatientServices.aspx?RegNo={0}&amp;Yearlyno={1}&amp;SPMID={2}"
                DataTextField="SPM_ID" HeaderText="Receipt No." Target="_blank" />
            <asp:BoundField DataField="S_Name" HeaderText="Services" SortExpression="S_Name" />
            <asp:TemplateField HeaderText="Date Time" SortExpression="Date_Time">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Date_Time") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Date_Time") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("P_SID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_mainID" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_Amount" runat="server" Value='<%# Eval("S_Amount", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField_SPM_ID" runat="server" Value='<%# Eval("SPM_ID", "{0}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="S_Amount" HeaderText="Amount" SortExpression="S_Amount" />
            <asp:BoundField DataField="Status" HeaderText="Payment Status" 
                SortExpression="Status" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" 
                        CommandName="Select" 
                        onclientclick="return confirm('Are you sure you want to refund');" 
                        Text="Cancel"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="SPS_ID" HeaderText="SPS_ID" InsertVisible="False" SortExpression="SPS_ID"
                Visible="False" />
            <asp:BoundField DataField="P_SID" HeaderText="P_SID" SortExpression="P_SID" Visible="False" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <FooterStyle CssClass="myfooter" />
    </asp:GridView>--%>
    <asp:SqlDataSource ID="SqlDataSource_For_View" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT ABC.YearlyNo, ABC.RegNo, ABC.S_Name, ABC.SPS_ID, ABC.Main_ID, convert(bit,1) as Column1 ,ABC.Date_Time, ABC.S_Amount, ABC.P_SID, ABC.SPM_ID, ABC.Expr1, ABC.S_ID, ABC.Status, PS.Discount, dbo.IS_Service_refundable(ABC.P_SID, ABC.Status, ABC.Date_Time, ISNULL(PS.Order_Id, 0)) AS Column1 FROM (SELECT DISTINCT TOP (100) PERCENT Service_Payment_Main.YearlyNo, Service_Payment_Main.RegNo, Admin_Services.S_Name, Service_Payment_Sub.SPS_ID, Service_Payment_Main.Main_ID, Service_Payment_Main.Date_Time, Service_Payment_Sub.Amount AS S_Amount, Service_Payment_Sub.P_SID, Service_Payment_Main.SPM_ID, Service_Payment_Sub.SPM_ID AS Expr1, Admin_Services.S_ID, Service_Payment_Sub.Status FROM Service_Payment_Sub INNER JOIN Service_Payment_Main ON Service_Payment_Sub.SPM_ID = Service_Payment_Main.SPM_ID INNER JOIN Admin_Services ON Service_Payment_Sub.S_ID = Admin_Services.S_ID WHERE (Service_Payment_Main.YearlyNo = @YearlyNo) AND (Service_Payment_Main.RegNo = @RegNo) ORDER BY Service_Payment_Main.SPM_ID DESC) AS ABC LEFT OUTER JOIN Patient_Services AS PS ON ABC.RegNo = PS.RegNo AND ABC.YearlyNo = PS.YearlyNo AND ABC.S_ID = PS.S_ID"
        UpdateCommand="Cancel_Paid_Payment" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="GridView_View_Payments" Name="SPS_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_P_SID" Name="P_SID" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter DefaultValue="Request For Refund" Name="Status" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>
    <asp:HiddenField ID="HiddenField_Sample_number" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_test_Booking_New" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        InsertCommand="Insert_into_Path_Result_Delivery" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Path_Result_Delivery SET Fee_paid = 1 WHERE (Main_ID = @Main_ID)">
        <InsertParameters>
            <asp:SessionParameter Name="Reg_no" SessionField="RegistrationNo" Type="String" />
            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenField_Sample_number" DefaultValue="" Name="Sample_No"
                PropertyName="Value" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Grand_Discount" Type="Int32" />
            <asp:Parameter DefaultValue="" Name="Description" Type="String" />
            <asp:Parameter DefaultValue="0" Name="HospitalOrderNo" Type="Int32" />
            <asp:SessionParameter Name="From_Dept_ID" SessionField="Dept_ID" Type="Int32" />
            <asp:SessionParameter Name="From_SubDept_ID" SessionField="SubDeptID" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Inves_Dept_Id" DefaultValue="" Name="To_Dept_ID"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Inves_SubDept_Id" DefaultValue="14"
                Name="To_SubDept_ID" PropertyName="Value" Type="Int32" />
            <asp:SessionParameter Name="emp_ID" SessionField="emp_ID" Type="Int32" />
            <asp:Parameter DefaultValue="12" Name="Status" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_TB_ID" Name="TB_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_S_ID" Name="S_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Mg_ID" Name="Mg_ID" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter Direction="Output" Name="main_ID_Patient" Type="Int32" DefaultValue="" />
            <asp:ControlParameter ControlID="HiddenField_Doctor_ID" Name="DoctorID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Refer_From" Name="ReferFrom" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Consultant_Remarks" Name="Consultant_Remarks"
                PropertyName="Value" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_main_ID_patient" Name="Main_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_test_Booking_Radiology" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
        InsertCommand="Insert_into_Path_Result_Delivery" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Path_Result_Delivery SET Fee_paid = 1 WHERE (Main_ID = @Main_ID)">
        <InsertParameters>
            <asp:SessionParameter Name="Reg_no" SessionField="RegistrationNo" Type="String" />
            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenField_Main_ID_Radiology" DefaultValue="" Name="Sample_No"
                PropertyName="Value" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Grand_Discount" Type="Int32" />
            <asp:Parameter DefaultValue="" Name="Description" Type="String" />
            <asp:Parameter DefaultValue="0" Name="HospitalOrderNo" Type="Int32" />
            <asp:SessionParameter Name="From_Dept_ID" SessionField="Dept_ID" Type="Int32" />
            <asp:SessionParameter Name="From_SubDept_ID" SessionField="SubDeptID" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_To_Dept_ID" DefaultValue="" Name="To_Dept_ID"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_To_Sub_Dept_ID" DefaultValue="" Name="To_SubDept_ID"
                PropertyName="Value" Type="Int32" />
            <asp:SessionParameter Name="emp_ID" SessionField="emp_ID" Type="Int32" />
            <asp:Parameter DefaultValue="12" Name="Status" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_TB_ID" Name="TB_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_S_ID" Name="S_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Mg_ID" Name="Mg_ID" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter Direction="Output" Name="main_ID_Patient" Type="Int32" />
            <asp:ControlParameter ControlID="HF_PS_ID" Name="PS_ID" PropertyName="Value" 
                Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Main_ID_Radiology" Name="Main_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
     <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
    <br />
    <asp:HiddenField ID="HiddenField_P_SID" runat="server" />
    <asp:HiddenField ID="HiddenFieldSubDepartment" runat="server" />
    <asp:HiddenField ID="HiddenFieldDept_id" runat="server" />
    <asp:HiddenField ID="HiddenField_TB_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_S_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Mg_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_main_ID_patient" runat="server" />
    <asp:HiddenField ID="HiddenField_Main_ID_Radiology" runat="server" />

    <script type="text/javascript">

var cookies = Spry.Utils.Cookie("read","tabbedpanels");

 if (cookies == "true") { 
var tp1 = new Spry.Widget.CollapsiblePanel("tp1",{ contentIsOpen: true } );
} else { 
var tp1 = new Spry.Widget.CollapsiblePanel("tp1",{ contentIsOpen: false } );
 } 

Spry.Utils.addUnLoadListener(function(){
    
 Spry.Utils.Cookie("create","tabbedpanels",tp1.isOpen());
	
});

var cookies2 = Spry.Utils.Cookie("read","tabbedpanels1");

 if (cookies2 == "true") { 
var CollapsiblePanel276 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel276",{ contentIsOpen: true } );
} else { 
var CollapsiblePanel276 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel276",{ contentIsOpen: false } );
 } 

Spry.Utils.addUnLoadListener(function(){
    
 Spry.Utils.Cookie("create","tabbedpanels1",CollapsiblePanel276.isOpen());
	
});

    </script>

    <asp:HiddenField ID="HiddenField_Payment_No" runat="server" />
    <asp:HiddenField ID="HiddenField_paid_by" runat="server" />
    <asp:HiddenField ID="HiddenField_chk" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Discount_Main" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
        InsertCommand="Pro_Discount_Main" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter Name="emp_ID" SessionField="emp_id" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Cancel_Amount" Name="Total_Amount" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Int32" />
            <asp:Parameter Direction="Output" Name="Discount_ID" Type="Decimal" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Cancel_Amount" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Payment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Insert_Patient_Advance" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" />
            <asp:ControlParameter ControlID="HiddenField_Cancel_Amount" Name="Amount" PropertyName="Value" />
            <asp:Parameter Name="Check_No" />
            <asp:Parameter Name="Bank_Name" />
            <asp:Parameter Name="Branch_Name" />
            <asp:Parameter Direction="Output" Name="PaymentNo" Type="Int32" />
            <asp:Parameter Name="Payment_Type" />
            <asp:Parameter Name="ASP_ID" Type="Int32" />
            <asp:Parameter Name="Cheque_Date" Type="DateTime" />
            <asp:Parameter Name="Card_No" Type="String" />
            <asp:Parameter Name="Card_Type" Type="String" />
            <asp:Parameter Name="Card_Service" Type="String" />
            <asp:Parameter Name="Approval_No" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Refer_From" runat="server" />
    <asp:HiddenField ID="HiddenField_Doctor_Discount" runat="server" />
</asp:Content>
