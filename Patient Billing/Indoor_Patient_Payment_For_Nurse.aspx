<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Indoor_Patient_Payment_For_Nurse.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="Indoor_Patient_Payment_For_Nurse" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="../css_hacims/ck.js" type="text/javascript"></script>

<script type ="text/javascript" >

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

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



 
    <asp:Panel ID="Panel1" runat="server"> </asp:Panel> 
 
 
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
     <td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
         </td>

    <td width="50%" valign="top"> <asp:Panel ID="pnl_Radiology_Sample" runat="server"  Width="100%">
    
 <div align="right">   <asp:Button ID="Button_CheckAll" runat="server" Text="Check All"   />
            <asp:Button ID="Button_Un_Check_All" runat="server" Text="Uncheck All"  /> </div>
    <br />

    
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
                            <asp:HiddenField ID="HiddenField_Current" runat="server" Value='<%# Eval("Test_Type_Id") %>' /><asp:HiddenField ID="HF_S_ID" runat="server" Value='<%# Eval("S_ID") %>' />
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
                ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>" SelectCommand="[Select_Radiology_For_Payment]"
                UpdateCommand="Update Investigation_Order_Sub &#13;&#10;set Investigation_Order_Sub.TestType_ID=@Test_Type_Id, Investigation_Order_Sub.Description=@description&#13;&#10;From Investigation_Order_Main INNER JOIN&#13;&#10;                      Investigation_Order_Sub ON Investigation_Order_Main.Investigation_Order_ID = Investigation_Order_Sub.Investigation_Order_ID &#13;&#10;where Investigation_Order_Sub.TB_ID=@TB_ID and Investigation_Order_Main.YearlyNo=@YearlyNo &#13;&#10;                      and Investigation_Order_Main.RegNo=@RegNo&#13;&#10;&#13;&#10;&#13;&#10;UPDATE Test_Booking SET Test_Type_Id = @Test_Type_Id WHERE (TB_ID = @TB_ID)" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalId" Type="Int32" />
                    <asp:SessionParameter Name="Patient_Type_Id" SessionField="Patient_Type_Id" Type="Int32" />
                    <asp:SessionParameter Name="IPD_OPD" SessionField="IPDOPD" Type="String" />
                    <asp:SessionParameter Name="Billing_Party_Id" SessionField="PatientBillingParty_Id"
                        Type="Decimal" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="HiddenField2" Name="Test_Type_Id" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenField1" Name="TB_ID" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenField_Description" Name="description" PropertyName="Value" />
                    <asp:SessionParameter Name="YearlyNo" SessionField="Yearlyno" />
                    <asp:SessionParameter Name="RegNo" SessionField="registrationno" />
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
                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="&#13;&#10;">
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value" />
                    <asp:Parameter DefaultValue="0" Name="TOtal_Discount" />
                    <asp:Parameter DefaultValue="0" Name="Total_Paid" />
                    <asp:Parameter DefaultValue="0" Name="Total_AMount" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HF_Rad_FromSubDept_ID" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource_Rad_Patient_Services" runat="server" ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>"
                InsertCommand="[Insert_Pathology_Patient_Services]"
                ProviderName="<%$ ConnectionStrings:RadiologyConnectionString.ProviderName %>"
                UpdateCommand="UPDATE Investigation_Order_Main SET Status = @Status WHERE (Investigation_Order_ID = @Investigation_Order_ID)" InsertCommandType="StoredProcedure">
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
            
            </asp:Panel>
   
     </td>
    <td width="10%" valign="top"><div align="center"><br />
        <asp:HiddenField ID="HF_PS_ID" runat="server" />
<br />
<br />
<asp:Button ID="Button_Rad_For_Payment" runat="server" Text="Add to Bill  &raquo;" style="color:#FF0000;" /></div> </td>
    <td  width="40%" valign="top"> <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="GetPatientServices" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            </SelectParameters>
        </asp:SqlDataSource>
       <div align="center"> <asp:Button ID="Button_lab_Test" runat="server" Text="Lab/Radiology" Width="143px" /></div><br />

        <asp:GridView ID="GridView_For_Services" runat="server" AutoGenerateColumns="False"
            DataSourceID="SqlDataSource_For_Grid" Width="98%">
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
                                    Text='<%# Bind("PanelAmount") %>' Enabled="false"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Patient">
                            <FooterTemplate>
                                <asp:Label ID="Label_f_Patient" runat="server" Text="0"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox_Patient" runat="server" Text='<%# Bind("Patient_Value") %>'
                                     Enabled="false" Width="54px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                   
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" Checked="True" Enabled="false" OnCheckedChanged="CheckBox1_CheckedChanged" /><br />
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
        </asp:GridView></td>
  </tr>
</table>

 
 
 
  

<br />

<div align="center"><asp:Button ID="Button2" runat="server" Text="View Recipt" Visible="False"/></div>
 <br />


                <asp:GridView ID="GridView_View_Payments" runat="server" AutoGenerateColumns="False"
                    CssClass="Grid_1" DataSourceID="SqlDataSource_For_View"  DataKeyNames="SPS_ID" Width="100%" ShowFooter="True" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo" Visible="False" />
                        <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
                        <asp:HyperLinkField DataNavigateUrlFields="RegNo,YearlyNo,SPM_ID" DataNavigateUrlFormatString="patientServices.aspx?RegNo={0}&amp;Yearlyno={1}&amp;SPMID={2}"
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
                        <asp:ButtonField CommandName="Select" Text="Cancel" />
                        <asp:BoundField DataField="SPS_ID" HeaderText="SPS_ID" InsertVisible="False" SortExpression="SPS_ID"
                            Visible="False" />
                        <asp:BoundField DataField="P_SID" HeaderText="P_SID" SortExpression="P_SID" Visible="False" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <FooterStyle CssClass="myfooter" />
                </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource_For_View" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT DISTINCT Service_Payment_Main.YearlyNo, Service_Payment_Main.RegNo, Admin_Services.S_Name, Service_Payment_Sub.SPS_ID, Service_Payment_Main.Main_ID, Service_Payment_Main.Date_Time, Service_Payment_Sub.Amount AS S_Amount, Service_Payment_Sub.P_SID, Service_Payment_Main.SPM_ID, Service_Payment_Sub.SPM_ID AS Expr1 FROM Service_Payment_Sub INNER JOIN Service_Payment_Main ON Service_Payment_Sub.SPM_ID = Service_Payment_Main.SPM_ID INNER JOIN Admin_Services ON Service_Payment_Sub.S_ID = Admin_Services.S_ID INNER JOIN Patient_Services ON Service_Payment_Sub.S_ID = Patient_Services.S_ID AND Service_Payment_Main.RegNo = Patient_Services.RegNo AND Service_Payment_Main.YearlyNo = Patient_Services.YearlyNo WHERE (Service_Payment_Main.YearlyNo = @YearlyNo) AND (Service_Payment_Main.RegNo = @RegNo) AND (Service_Payment_Sub.Status <> 'Cancel') ORDER BY Service_Payment_Main.SPM_ID DESC" UpdateCommand="Cancel_Paid_Payment" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="GridView_View_Payments" Name="SPS_ID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="HiddenField_P_SID" Name="P_SID" PropertyName="Value"
                        Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
<br />
<asp:Label ID="Label1" runat="server" CssClass="err" ></asp:Label>
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
            <asp:ControlParameter ControlID="HiddenField_Inves_Dept_Id" DefaultValue="10" Name="To_Dept_ID"
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
            <asp:ControlParameter ControlID="HiddenField_main_ID_patient" DefaultValue="" Direction="Output"
                Name="main_ID_Patient" PropertyName="Value" Type="Int32" />
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
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Main_ID_Radiology" Name="Main_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
<br />
    <asp:HiddenField ID="HiddenField_P_SID" runat="server" />

    <asp:HiddenField ID="HiddenFieldSubDepartment" runat="server" />

    <asp:HiddenField ID="HiddenFieldDept_id" runat="server" />
    <asp:HiddenField ID="HiddenField_TB_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_S_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Mg_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_main_ID_patient" runat="server" />
    <asp:HiddenField ID="HiddenField_Main_ID_Radiology" runat="server" />
    
    
    
 

    <asp:HiddenField ID="HiddenField_Payment_No" runat="server" />
    <asp:HiddenField ID="HiddenField_paid_by" runat="server" />
    <asp:HiddenField ID="HiddenField_chk" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Discount_Main" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
        InsertCommand="Pro_Discount_Main" InsertCommandType="StoredProcedure" >
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
            <asp:SessionParameter Name="RegNo" SessionField="registrationno" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" />
            <asp:ControlParameter ControlID="HiddenField_Cancel_Amount" Name="Amount" PropertyName="Value" />
            <asp:Parameter Name="Check_No" />
            <asp:Parameter Name="Bank_Name" />
            <asp:Parameter Name="Branch_Name" />
            <asp:Parameter Direction="Output" Name="PaymentNo" Type="Int32" />
            <asp:Parameter Name="Payment_Type" />
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
    <asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Refer_From" runat="server" />
    <asp:HiddenField ID="HiddenField_Doctor_Discount" runat="server" />
    <asp:HiddenField ID="HiddenField_Order_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        InsertCommand="INSERT INTO Lab_Status_Record&#13;&#10;                      (TB_ID, Order_ID, Status)&#13;&#10;VALUES     (@TB_ID,@Order_ID,@Status)"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE (Main_ID = @Main_ID)   &#13;&#10;&#13;&#10;">
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
    <asp:HiddenField ID="HiddenField_To_Dept_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_To_Sub_Dept_ID" runat="server" />
    <br />
    <asp:HiddenField ID="HiddenField_Inves_SubDept_Id" runat="server" />
    <asp:HiddenField ID="HiddenField_Inves_Dept_Id" runat="server" />
    <br />
    <br />
    <asp:HiddenField ID="HiddenField_Consultant_Remarks" runat="server" />

    
        <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>
    
  </asp:Content>
