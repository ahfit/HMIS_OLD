<%@ Page Language="VB" AutoEventWireup="false"  MasterPageFile="~/hacims_masterpage.master" CodeFile="NursingLabOrder.aspx.vb" Inherits="NursingLabOrder" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


<script src="../css_hacims/ck.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>

</td>
<td  style="width:auto;" valign="top" >
     
     <asp:Label ID="Label1" runat="server" Visible= "false"></asp:Label> 

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceForDetailView" 

            Width="100%">
            <Columns>
                <asp:BoundField DataField="SampleNo" HeaderText="Sample No" SortExpression="SampleNo" />
                <asp:BoundField DataField="TB_Name" HeaderText="Test" SortExpression="TB_Name" />
                <asp:BoundField DataField="SampleTake" HeaderText="Specimen" SortExpression="SampleTake" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Status") %>' OnCheckedChanged="CheckBox1_CheckedChanged" />
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Lab_Order_id", "{0}") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Completed By" HeaderText="Completed By" SortExpression="Completed By" />
                <asp:BoundField DataField="Lab_Order_id" HeaderText="Lab_Order_id" InsertVisible="False"
                    ReadOnly="True" SortExpression="Lab_Order_id" />
            </Columns><RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

        </asp:GridView>
                       <br />
<div align="center"> <asp:Button CssClass="btn1" ID="ButtonDone" runat="server" Text="Done" /></div>
                        <asp:Panel ID="Panel1" runat="server" Visible="False" ></asp:Panel>
        
     <br />
<asp:Label ID="Label_message" runat="server"></asp:Label> 


                   <asp:SqlDataSource ID="SqlDataSourceForDetailView" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT Patient_Lab_Order_For_Nurse.SampleNo, Test_Booking.TB_Name, TestGroup.SampleTake, TestGroup.TGName, CASE WHEN Patient_Lab_Order_For_Nurse.Status = 'Done' THEN 1 ELSE 0 END AS Status, ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') + '(' + &#13;&#10;CONVERT (VARCHAR(20) ,Patient_Lab_Order_For_Nurse.OrderCompletionDate, 103) + ')' AS [Completed By], Patient_Lab_Order_For_Nurse.Lab_Order_id, Investigation_Order_Main.Investigation_Order_ID, Patient_Lab_Order_For_Nurse.Datetime&#13;&#10;&#13;&#10;FROM Investigation_Order_Main INNER JOIN Patient_Lab_Order_For_Nurse ON Investigation_Order_Main.Investigation_Order_ID = Patient_Lab_Order_For_Nurse.TGID INNER JOIN Investigation_Order_Sub ON Investigation_Order_Main.Investigation_Order_ID = Investigation_Order_Sub.Investigation_Order_ID INNER JOIN Test_Booking ON Investigation_Order_Sub.TB_ID = Test_Booking.TB_ID INNER JOIN Test_Services ON Test_Booking.TB_ID = Test_Services.TB_ID INNER JOIN Test ON Test_Services.Test_ID = Test.TID INNER JOIN TestGroup ON Test.TGID = TestGroup.TGID LEFT OUTER JOIN Employee ON Patient_Lab_Order_For_Nurse.Completed_by = Employee.EmpID WHERE (Patient_Lab_Order_For_Nurse.RegNo = @RegNo) AND (Patient_Lab_Order_For_Nurse.YearlyNo = @YearlyNo)" 
                       UpdateCommand="UPDATE Patient_Lab_Order_For_Nurse SET Status = 'Done', OrderCompletionDate = GETDATE(), Completed_by = @Emp_Id WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (Lab_Order_id = @TGID) ">
                        <SelectParameters>
                            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:SessionParameter Name="Emp_Id" SessionField="Emp_Id" />
                            <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                            <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
                            <asp:ControlParameter ControlID="HiddenField_TGID" Name="TGID" PropertyName="Value" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceUpdateStatus" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" UpdateCommand="UPDATE Nursing_Order_Status SET Lab_Order_Status = 0 WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo)">
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="HiddenFieldRegistrationNo" Name="RegNo" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenField_Yearly_no" Name="YearlyNo" PropertyName="Value" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
                    <asp:HiddenField ID="HiddenFieldRegistrationNo" runat="server" />
                    <asp:HiddenField ID="HiddenField_Yearly_no" runat="server" />
                    <asp:HiddenField ID="HiddenField_TGID" runat="server" />



     
     
</td>
</tr>
</table><asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
 </asp:Content>