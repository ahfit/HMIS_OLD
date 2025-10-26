<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Patient Billing/Employee_Cash_Submitted_Report.aspx.cs" Inherits="Patient_Billing_Employee_Cash_Submitted_Report" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="divlabel" class="bxmain inner_content" runat="server">
        <table width="100%">
            <tr>
                <td style="text-align:center; width:100%" >
                 <h2 id="h2label" runat="server" style="background-color:whitesmoke"> <asp:Label CssClass="lblaligncentre" ID="lblEmployee"  runat="server" Text="" Visible="true"></asp:Label></h2>
                </td>
       </table>

    </div>
    <div width="100%" class="bxmain inner_content" id="grdvisiblefalse" runat="server">
        <h2><span>Old Cash Book Report</span></h2>
        <table width="100%">
            <tr>
                <td align="right" width="50%">
                    <asp:Label ID="Lblselctemp" runat="server" Text="<b>Employee Name : </b>"></asp:Label>
                </td>



                <td width="50%">
                    <asp:DropDownList ID="DDL_Employee" runat="server" DataSourceID="SDS_Employee"
                        DataTextField="NAME" DataValueField="EmpID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="SELECT     ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS NAME, Employee.EmpID
FROM         Employee INNER JOIN
                      Receptionist ON Employee.EmpID = Receptionist.Receptionist_id
WHERE     (Employee.ActiveStatus = 1)
order by NAME ">
                        <SelectParameters>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td width="50%" align="right">Start Date :
                </td>
                <td width="50%">
                    <igsch:WebDateChooser ID="WebDateChooser_Sdate" runat="server"
                        Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>

                    <asp:DropDownList ID="DDL_Hospital" runat="server" DataSourceID="SDS_Hospital" Visible="false"
                        DataTextField="Hospital_Name" DataValueField="Hospital_ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Hospital" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td width="50%" align="right">End Date :
                </td>
                <td width="50%">
                    <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server"
                        Width="202px" OnValueChanged="WebDateChooser_Date_ValueChanged">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                        <AutoPostBack ValueChanged="True" />
                    </igsch:WebDateChooser>

                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">

                    <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" />

                </td>

            </tr>
            <tr style="display: none;">
                <td colspan="2" align="center">

                    <asp:Button ID="BTn_Deposit" runat="server" Text="Deposit" Width="100px"
                        OnClick="BTn_Deposit_Click" />
                    <asp:Button ID="Btn_Approve" runat="server" Text="Approve" Width="100px" OnClick="Btn_Approve_Click" />
                </td>

            </tr>
            <tr>
                <td colspan="2" align="center">&nbsp;</td>

            </tr>
            <tr>
                <td colspan="2" align="center">

                    <asp:GridView ID="Gv_Report" runat="server"
                        AutoGenerateColumns="False" Width="100%"
                        ShowFooter="true"
                        DataSourceID="SDS_Report" OnPreRender="Gv_Report_PreRender">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1%>
                                </ItemTemplate>
                                <ItemStyle Width="8%" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Receipt" HeaderText="Receipt(From - To)" ReadOnly="True"
                                SortExpression="Receipt" Visible="False" />
                            <asp:BoundField DataField="Receiving_Amount_ID" HeaderText="Token #"
                                SortExpression="Receiving_Amount_ID" />
                            <asp:BoundField DataField="Hospital_Name" HeaderText="Hospital Name"
                                SortExpression="Hospital_Name" Visible="False" />
                            <asp:BoundField DataField="Department" HeaderText="Department" ReadOnly="True"
                                SortExpression="Department" />
                            <asp:BoundField DataField="Shift" HeaderText="Shift" SortExpression="Shift" />

                            <asp:TemplateField HeaderText="Total Amount" SortExpression="TotalAmount">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Amount" runat="server" Text='<%# Bind("TotalAmount") %>'></asp:Label>
                                    <asp:HiddenField ID="hf_token_no" runat="server"
                                        Value='<%# Eval("Receiving_Amount_ID") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("TotalAmount") %>'></asp:Label>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lbl_total" runat="server" Visible="true" Text="0"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Column1" HeaderText="Date" ReadOnly="True"
                                SortExpression="Column1" Visible="false" />


                            <asp:BoundField DataField="Closed_By" HeaderText="Closed By"
                                SortExpression="Closed_By" />
                            <asp:BoundField DataField="DateTime" HeaderText="Date" DataFormatString="{0:d}" />

                            <asp:BoundField DataField="Shift_ID" HeaderText="Shift_ID"
                                InsertVisible="False" ReadOnly="True" SortExpression="Shift_ID" Visible="false" />
                            <asp:BoundField DataField="SubDept_Id" HeaderText="SubDept_Id"
                                SortExpression="SubDept_Id" Visible="false" />
                            <asp:HyperLinkField Target="_blank" Text="Over All Detail"
                                DataNavigateUrlFields="Hospital_ID,SubDept_ID,Shift_ID,CC_Date,VStatus,emp_id,Entry_Voucher_Trans_ID,Receiving_Amount_ID"
                                DataNavigateUrlFormatString="Cash_Deposit_To_Bank.aspx?Hid={0}&amp;SDID={1}&amp;ShID={2}&amp;Dt={3}&amp;VS={4}&amp;EID={5}&amp;VID={6}&amp;PID={7}" />
                            <asp:HyperLinkField Target="_blank" Text="Service Wise Detail"
                                DataNavigateUrlFields="Dept_ID,SubDept_ID,Shift_ID,CC_Date,VStatus,emp_id,Entry_Voucher_Trans_ID,Receiving_Amount_ID"
                                DataNavigateUrlFormatString="CC_Deposited_Detail.aspx?Hid={0}&amp;SDID={1}&amp;ShID={2}&amp;Dt={3}&amp;VS={4}&amp;EID={5}&amp;VID={6}&amp;PID={7}"
                                Visible="False" />
                            <asp:TemplateField HeaderText="View Voucher" Visible="False">
                                <HeaderTemplate>
                                    <asp:CheckBox ID="CHK_approve" runat="server" AutoPostBack="True"
                                        Text="Approve " TextAlign="Left"
                                        OnCheckedChanged="CHK_approve_CheckedChanged" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton1_Click"
                                        Text='<%# Eval("Entry_Voucher_Trans_ID") %>'></asp:LinkButton>
                                    <asp:CheckBox ID="Chk_EV" runat="server" Visible='<%# Eval("Status_V_Vis") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View Bank Voucher" Visible="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"
                                        Text='<%# Eval("Voucher_Trans_ID") %>'></asp:LinkButton>
                                    <asp:CheckBox ID="Chk_add" runat="server" Visible='<%# Eval("Status_Vis") %>' />
                                    <asp:HiddenField ID="hf_Shift_ID" runat="server"
                                        Value='<%# Eval("Shift_ID") %>' />
                                    <asp:HiddenField ID="HF_Subdept_id" runat="server"
                                        Value='<%# Eval("SubDept_Id") %>' />
                                    <asp:HiddenField ID="Hf_Hospital" runat="server"
                                        Value='<%# Eval("Hospital_ID") %>' />
                                    <asp:HiddenField ID="HF_Department" runat="server"
                                        Value='<%# Eval("Dept_Id") %>' />
                                    <asp:HiddenField ID="HF_emp_id" runat="server"
                                        Value='<%# Eval("emp_id") %>' />
                                    <asp:HiddenField ID="HF_Ent_Voucher" runat="server"
                                        Value='<%# Eval("Entry_Voucher_Trans_ID") %>' />
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="Chk_Head" runat="server" AutoPostBack="True"
                                        OnCheckedChanged="Chk_Head_CheckedChanged" Text="Bank Voucher"
                                        TextAlign="Left" />
                                </HeaderTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SDS_Report" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="Employee_Cash_Submitted"
                        CancelSelectOnNullParameter="False"
                        SelectCommandType="StoredProcedure"
                        UpdateCommand="Cash_Submitted_Bank_Update" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter Name="SDate" Type="DateTime" />
                            <asp:Parameter Name="EDate" Type="DateTime" />

                            <asp:Parameter Name="Emp_id" Type="Int32" />

                            <asp:Parameter Name="Hos_ID" Type="Int32" />

                        </SelectParameters>
                        <UpdateParameters>
                            <%--<asp:Parameter Name="EntryVoucher_Trans_ID" Type="Int32" />--%>
                            <asp:Parameter Name="Deposit_By" Type="Int32" />
                            <asp:Parameter Name="Subdept_id" Type="Int32" />
                            <asp:Parameter Name="shift_id" Type="Int32" />
                            <asp:Parameter Name="Submitted_Date" Type="DateTime" />
                            <asp:Parameter Name="EntryVoucher_Trans_ID" Type="Int32" />
                            <asp:Parameter Direction="InputOutput" Name="Voucher_Trans_ID" Type="Decimal" />
                            <asp:Parameter Name="Emp_id" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                </td>

            </tr>
            <tr>
                <td colspan="2" align="center">

                    <asp:Panel ID="Panel1" runat="server" Visible="false">
                        <%--CssClass ="lightbox"--%>
                        <table>
                            <tr>
                                <td>Total Amount:
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_TotalAmount" runat="server" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Bank:
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList1" runat="server"
                                        DataSourceID="SqlDataSource_expenditure" DataTextField="E_Name"
                                        DataValueField="E_Code">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Description:
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_Description" runat="server" Height="125px"
                                        TextMode="MultiLine" Width="250px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click"
                                        Text="Deposit" />
                                    <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Cancel" />

                                    <asp:Label ID="LBl_Msg" runat="server" ForeColor="#FF0066"></asp:Label>

                                </td>
                            </tr>
                        </table>
                        <asp:SqlDataSource ID="SDS_Deposit" runat="server"
                            ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                            InsertCommand="JV_Counter_Close_To_Bank" InsertCommandType="StoredProcedure"
                            ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
                            OnInserted="SDS_Deposit_Inserted"
                            UpdateCommand="Cash_Submitted_Bank_Update" UpdateCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:SessionParameter Name="Emp_id" SessionField="Emp_id" Type="Int32" />
                                <asp:SessionParameter Name="Subdept_id" SessionField="SubDeptid" Type="Int32" />
                                <asp:ControlParameter ControlID="txt_TotalAmount" Name="Total_Amount"
                                    PropertyName="Text" Type="Decimal" />
                                <asp:SessionParameter Name="shift_id" SessionField="ShiftID" Type="Int32" />
                                <asp:ControlParameter ControlID="DropDownList1" Name="BankHead"
                                    PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="txt_Description" Name="DepositDescription"
                                    PropertyName="Text" Type="String" />
                                <asp:Parameter Direction="InputOutput" Name="Voucher_Trans_ID" Type="Decimal" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="HF_Voucher_Trans_ID" runat="server" />
                        <br />
                        <asp:SqlDataSource ID="SqlDataSource_expenditure" runat="server"
                            ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                            DeleteCommand="DELETE FROM [Expenditure] WHERE [E_Code] = @E_Code"
                            InsertCommand="INSERT INTO [Expenditure] ([E_Code], [E_Name], [ESH_Code]) VALUES (@E_Code, @E_Name, @ESH_Code)"
                            ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
                            SelectCommand="SELECT Expenditure.E_Code, Expenditure.E_Name, SUM(CASE WHEN Reciept_Disbursement_Detail.Cr_Dr_Action_Id = 1 THEN Amount ELSE 0 END) - SUM(CASE WHEN Reciept_Disbursement_Detail.Cr_Dr_Action_Id = 2 THEN Amount ELSE 0 END) AS Balance FROM Expenditure INNER JOIN Bank_Account ON Expenditure.E_Code = Bank_Account.E_Code INNER JOIN Bank_Account_BranchWise ON Bank_Account.Account_ID = Bank_Account_BranchWise.Account_ID LEFT OUTER JOIN Reciept_Disbursement_Detail ON Expenditure.E_Code = Reciept_Disbursement_Detail.Account_Head_id WHERE (Expenditure.ESH_Code = '3301') AND (Bank_Account_BranchWise.Company_Branch_ID = @Company_Branch_ID) GROUP BY Expenditure.E_Code, Expenditure.E_Name"
                            UpdateCommand="UPDATE [Expenditure] SET [E_Name] = @E_Name, [ESH_Code] = @ESH_Code WHERE [E_Code] = @E_Code">
                            <DeleteParameters>
                                <asp:Parameter Name="E_Code" Type="String" />
                            </DeleteParameters>
                            <SelectParameters>
                                <asp:SessionParameter Name="Company_Branch_ID"
                                    SessionField="Company_branch_id" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="E_Name" Type="String" />
                                <asp:Parameter Name="ESH_Code" Type="String" />
                                <asp:Parameter Name="E_Code" Type="String" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:ControlParameter ControlID="TextBox_E_Code" Name="E_Code"
                                    PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="TextBox_E_Name" Name="E_Name"
                                    PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="DropDownList_Sub_ESH_name" Name="ESH_Code"
                                    PropertyName="SelectedValue" Type="String" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>



                    <asp:SqlDataSource ID="SDS_Voucher" runat="server"
                        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString1 %>"
                        InsertCommand="JV_Counter_Close_Advance" InsertCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:FinanceConnectionString1.ProviderName %>"
                        CancelSelectOnNullParameter="False">
                        <InsertParameters>
                            <asp:SessionParameter Name="By_Emp_Id" SessionField="emp_id" Type="Int32" />
                            <asp:Parameter Name="Dept_Id" Type="Int32" />
                            <asp:Parameter Name="SubDept_Id" Type="Int32" />
                            <asp:Parameter Name="shift_id" Type="Int32" />
                            <asp:Parameter Name="CCdate" Type="String" />
                            <asp:Parameter DefaultValue="0" Name="Receiving_Amount_ID" Type="Int32" />
                            <asp:Parameter DefaultValue="" Name="CC_Emp_Id" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>

                </td>

            </tr>
        </table>


    </div>

</asp:Content>

