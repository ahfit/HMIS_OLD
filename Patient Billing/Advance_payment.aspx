<%@ page language="VB" autoeventwireup="false" CodeFile="~/Patient Billing/Advance_payment.aspx.vb"
 masterpagefile="~/hacims_masterpage_billing.master" inherits="Patient_Billing_Advance_payment"
  enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never"
   maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %><asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script language="javascript" type="text/javascript">
 

$(document).ready(function(e) {
     
	
	$("#ctl00_ContentPlaceHolder1_Button_Save").click(function(){
		
		if($("#ctl00_ContentPlaceHolder1_TextBox_Payment").val()==""){alert("Please Enter Advance Payment");
			$("#ctl00_ContentPlaceHolder1_TextBox_Payment").focus();
			return false;
			}
		 
	 	 
		})
	 
})	
	 
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td align="right" width="40%">
                    Advance Payment :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Payment" runat="server" CssClass="input_txt"  min="0"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="Label" Visible="False"></asp:Label></td>
            </tr>
            <tr>
                <td align="right" width="40%">
                    Department :</td>
                <td>
                    <asp:DropDownList ID="ddlDepartment" runat="server" Width="204px"
                        DataSourceID="dsDepartments" DataTextField="Dept_Name" AutoPostBack="true" 
                        DataValueField="Dept_ID" 
                       >
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Package :</td>
                <td>
                    <asp:DropDownList ID="DropDownList_Admin_Service_Package" runat="server" Width="204px"
                        AutoPostBack="True" DataSourceID="SqlDataSource_Admin_Service_Package" DataTextField="AP_Name"
                        DataValueField="ASP_ID" 
                       >
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right">
                    Description :
                <td>
                    <asp:TextBox ID="TextBox_description" TextMode = "MultiLine" runat="server" CssClass="input_txt"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">
                    Payment Mode :</td>
                <td>
                    <asp:DropDownList ID="DropDownList_Payment_Type" runat="server" Width="204px" 
                        AutoPostBack="True" Enabled="False">
                        <asp:ListItem Selected="True">Cash</asp:ListItem>
                        <asp:ListItem>Cheque</asp:ListItem>
                        <asp:ListItem>Credit Card</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right" colspan="2">
                    <asp:Panel ID="Panel_Bank" runat="server" Visible="False" Width="100%">
                        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                            <tr>
                                <td align="right" width="40%">
                                    Bank Name :</td>
                                <td>
                                    <asp:TextBox ID="TextBox_Bank_Name" runat="server" CssClass="input_txt"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Branch Name :</td>
                                <td>
                                    <asp:TextBox ID="TextBox_Branch_Name" runat="server" CssClass="input_txt"></asp:TextBox></td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="Panel_cheque" runat="server" Width="100%" Visible="False">
                        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                            <tr>
                                <td align="right" width="40%">
                                    Cheque # :</td>
                                <td>
                                    <asp:TextBox ID="TextBox_Cheque_no" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Cheque Date :
                                </td>
                                <td>
                                    <igsch:WebDateChooser ID="WebDateChooser1" runat="server">
                                    </igsch:WebDateChooser>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="Panel_Card" runat="server" Visible="False" Width="100%">
                        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                            <tr>
                                <td align="right" width="40%">
                                    Card # :</td>
                                <td>
                                    <asp:TextBox ID="TextBox_Cradit_Card_No" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Card Type :</td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_Card_Type" runat="server" Width="155px">
                                        <asp:ListItem>Credit Card</asp:ListItem>
                                        <asp:ListItem>Debit Card</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Card Service :</td>
                                <td>
                                    <asp:TextBox ID="TextBox_Card_Service" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Approval # :</td>
                                <td>
                                    <asp:TextBox ID="TextBox_approval_no" runat="server"></asp:TextBox></td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="Button_Save" runat="server" Text="Save" />
                    <asp:Label ID="Label2" runat="server" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <asp:RadioButtonList ID="RadioButtonListCategory" runat="server" RepeatColumns="2"
            RepeatLayout="Flow" Visible="False">
            <asp:ListItem Selected="True">General</asp:ListItem>
            <asp:ListItem>Cardiac</asp:ListItem>
        </asp:RadioButtonList></div>
    <asp:HiddenField ID="HiddenField_cheque_Date" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Admin_Service_Package" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT 0 AS ASP_ID, '' AS AP_Name

 UNION 
 
SELECT     Admin_Service_Package.ASP_ID, Admin_Service_Package.AP_Name + ' (' + CONVERT(varchar, Admin_Service_Package.Total_Amount) + ')' AS AP_Name
FROM         Admin_Service_Package left outer JOIN
                      Admin_Service_Package_Sub ON Admin_Service_Package_Sub.ASP_ID = Admin_Service_Package.ASP_ID INNER JOIN
                      Department ON Admin_Service_Package.Dept_ID = Department.Dept_ID
                      where Admin_Service_Package.Dept_ID=@Dept_ID">
                      <SelectParameters>
                        <asp:ControlParameter ControlID="ddlDepartment" Name="Dept_ID" 
            PropertyName="SelectedValue" />
                      </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsDepartments" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
        SelectCommand="select 0 as Dept_ID ,'' as Dept_Name union SELECT Dept_ID, Dept_Name FROM Department D where D.Dept_ID in (Select Dept_ID from  Admin_Service_Package ) order by Dept_Name">
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Payment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="INSERT INTO Advance_Payment(RegNo, YearlyNo, Pay_DateTime, Emp_ID, Amount) VALUES (@RegNo, @YearlyNo, GetDate(), @Emp_ID, @Amount)"
        InsertCommand="Insert_Patient_Advance_IPD" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" />
            <asp:ControlParameter ControlID="TextBox_Payment" Name="Amount" PropertyName="Text" />
        </SelectParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" />
            <asp:Parameter Name="Amount" />
            <asp:ControlParameter ControlID="TextBox_Cheque_no" Name="Check_No" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_Bank_Name" Name="Bank_Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_Branch_Name" Name="Branch_Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="DropDownList_Payment_Type" Name="Payment_Type" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_cheque_Date" Name="Cheque_Date" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="TextBox_Cradit_Card_No" Name="Card_No" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList_Card_Type" Name="Card_Type" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_Card_Service" Name="Card_Service" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_approval_no" Name="Approval_No" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList_Admin_Service_Package" Name="ASP_ID"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Direction="Output" Name="PaymentNo" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_description" Name="Discription" 
                PropertyName="Text" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        DataSourceID="SqlDataSource_For_Grid" Width="98%" DataKeyNames="Payment_No,YearlyNo,RegNo,Status">
        <Columns>
            <asp:ButtonField CommandName="Delete" Text="Delete" Visible="False" />
            <asp:BoundField DataField="YearlyNo" HeaderText="File No." SortExpression="YearlyNo" />
            <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
            <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
            <asp:BoundField DataField="Check_No" HeaderText="Check No." SortExpression="Check_No"
                Visible="False" />
            <asp:BoundField DataField="Bank_Name" HeaderText="Bank Name" SortExpression="Bank_Name"
                Visible="False" />
            <asp:BoundField DataField="Branch_Name" HeaderText="Branch Name" SortExpression="Branch_Name"
                Visible="False" />
            <asp:BoundField DataField="Payment_No" HeaderText="Payment_No" InsertVisible="False"
                SortExpression="Payment_No" />
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
             <asp:BoundField DataField="Description" HeaderText="Description" InsertVisible="False"
                SortExpression="Description" />
            <asp:HyperLinkField DataNavigateUrlFields="Payment_No,YearlyNo,RegNo,Status" DataNavigateUrlFormatString="~\Patient Billing\PatientAdvancesReport.aspx?Payment_No={0}&amp;YearlyNo={1}&amp;RegNo={2}&amp;Type=Advance"
                HeaderText="Print" SortExpression="Payment_No" Target="_blank" 
                Text="Print" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT YearlyNo, CONVERT (varchar, Pay_DateTime, 107) AS Date, CONVERT (varchar, Pay_DateTime, 108) AS Time, Amount, Check_No, Bank_Name, Branch_Name, Payment_No, Status, RegNo, Description FROM Advance_Payment WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (Status = 0)"
        
        DeleteCommand="DELETE FROM Advance_Payment WHERE (Payment_No = @Payment_No)">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="Payment_No" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCounterClose" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="INSERT INTO Sub_Counter_Close(Amount, Amount_Type, Dept_Id, SubDept_Id, Date_time, Reg_No, YearlyNo, PaymentCategory, Main_Id, Adv_payment_ID, emp_id) VALUES (@Amount, @Amount_Type, @Dept_Id, @SubDept_Id, GETDATE(), @Reg_No, @YearlyNo, @PaymentCategory, @Main_Id, @Adv_payment_ID, @emp_id)"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        DeleteCommand="DELETE FROM Sub_Counter_Close WHERE (Reg_No = @Reg_No) AND (YearlyNo = @YearlyNo) AND (Main_Id = @Main_Id)">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Payment" Name="Amount" PropertyName="Text" />
            <asp:Parameter DefaultValue="Advance" Name="Amount_Type" />
            <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
            <asp:QueryStringParameter Name="Reg_No" QueryStringField="regno" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:ControlParameter ControlID="RadioButtonListCategory" Name="PaymentCategory"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenFieldMainId" Name="Main_Id" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldMainId" Name="Adv_payment_ID" PropertyName="Value" />
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" />
        </InsertParameters>
        <DeleteParameters>
            <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:ControlParameter ControlID="HiddenFieldPaymentID" Name="Main_Id" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldMainId" runat="server" />
    <asp:HiddenField ID="HiddenFieldPaymentTpye" runat="server" />
    <asp:HiddenField ID="HiddenFieldAmount" runat="server" />
    <asp:HiddenField ID="HiddenFieldPaymentID" runat="server" />
    <br />
    <asp:Label ID="Label_Message" runat="server"></asp:Label><br />
</asp:Content>
