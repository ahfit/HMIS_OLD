<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_billing.master" AutoEventWireup="true" CodeFile="~/Patient Billing/Patient_Search_Discount_New.aspx.cs" Inherits="Patient_Billing_Patient_Search_Discount_New" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /* Table Border & Padding */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }

        /* Header Row */
        .header-style {
            background-color: lightgray;
            color: white;
            font-weight: bold;
            font-size: 16px;
            padding: 10px;
            text-align: center;
        }

        /* Alternating Row Colors */
        .row-white {
            background-color: #ffffff;
        }

        .row-gray {
            background-color: #f2f2f2;
        }

        /* Cell Text Centering */
        .cell-center {
            text-align: left;
            padding: 8px;
        }

        /* Stylish Paging */
        .pager-style a, .pager-style span {
            display: inline-block;
            padding: 8px 12px;
            margin: 2px;
            border: 1px solid #007BFF;
            color: #007BFF;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
        }

        .pager-style span {
            background-color: #007BFF;
            color: white;
        }

        .pager-style a:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%">
        <span>
            <h2>Patient Search For Discount</h2>
        </span>
        <div>
            <asp:GridView ID="GridView_View_Payments" runat="server" AutoGenerateColumns="False"
                CssClass="Grid_1" DataSourceID="SqlDataSource_For_View" DataKeyNames="SPS_ID"
                Width="100%" ShowFooter="True" AllowPaging="True">
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
                            <asp:HiddenField ID="HiddenFieldRegNo" runat="server" Value='<%# Eval("RegNo") %>' />
                            <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" Value='<%# Eval("YearlyNo") %>' />
                            <asp:HiddenField ID="HiddenFieldS_id" runat="server" Value='<%# Eval("S_ID") %>' />
                            <asp:HiddenField ID="HiddenFieldDiscount" runat="server" Value='<%# Eval("Discount") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="S_Amount" HeaderText="Amount" SortExpression="S_Amount" />
                    <asp:BoundField DataField="Doctor" HeaderText="Doctor" SortExpression="Doctor" />
                    <asp:BoundField DataField="Discount" HeaderText="Disount" SortExpression="Discount" />
                    <asp:BoundField DataField="NetAmount" HeaderText="Discounted Amount" SortExpression="NetAmount" />


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
                            <asp:LinkButton ID="lbtn_cancel" runat="server" CausesValidation="False" CommandName="Select"
                                Text="Approve" Visible='<%# Eval("Column1") %>' OnClick="lbtn_cancel_Click"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SPS_ID" HeaderText="SPS_ID" InsertVisible="False" SortExpression="SPS_ID"
                        Visible="False" />
                    <asp:BoundField DataField="P_SID" HeaderText="P_SID" SortExpression="P_SID" Visible="False" />
                    <asp:BoundField DataField="TokenNo" HeaderText="Token #" SortExpression="TokenNo" Visible="False" />
                    <asp:BoundField DataField="CCDATE" HeaderText="Closed Date" SortExpression="CCDATE" Visible="False" />
                </Columns>
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                <FooterStyle CssClass="myfooter" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource_For_View" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="Payment_GetPaidServices_New" SelectCommandType="StoredProcedure"
                UpdateCommand="Cancel_Paid_Payment" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
                    <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payid" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="GridView_View_Payments" Name="SPS_ID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="HiddenField_P_SID" Name="P_SID" PropertyName="Value"
                        Type="Int32" />
                    <asp:Parameter DefaultValue="Request For Refund" Name="Status" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField_P_SID" runat="server" />
            <asp:SqlDataSource ID="SqlDataSourceRefundRequest" runat="server" CancelSelectOnNullParameter="False"
                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" InsertCommand="InsertRefund"
                InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
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
            <asp:Label ID="lblError" runat="server" ForeColor="Red" />
        </div>
        <div>
            <asp:Panel ID="Panel_Discount" runat="server" Visible="false">
                <table class="table table-bordered tbl_form lightbox" style="display: block; width: 40%; margin-top: -20px">
                    <tr>
                        <td colspan="2">
                            <asp:RadioButtonList ID="RadioButtonList2" runat="server" AutoPostBack="True" RepeatDirection="Horizontal"
                                Visible="False">
                                <asp:ListItem Selected="True" Value="Is_Consultant">Consultant</asp:ListItem>
                                <asp:ListItem Value="2">Administrator</asp:ListItem>
                            </asp:RadioButtonList>
                            <div class="inner_content">
                                <h2>
                                    <span>Discount Request ... </span>
                                </h2>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div style="padding: 10px; margin-bottom: 10px;">
                                <asp:Label ID="lblDiscountMsg" runat="server" Style="padding: 6px 10px; color: Red; font-size: 13px; border: solid 1px #ccc; border-radius: 15px; font-weight: bold;"></asp:Label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Hospital:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList_Hospital" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceHospital"
                                DataTextField="Hospital_Name" DataValueField="Hospital_ID">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceHospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                SelectCommand="SELECT Hospital_ID, Hospital_Name FROM Hospital ORDER BY Hospital_Name"></asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr align="right">
                        <td align="right">Forword To:
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="DropDownList_Consultant" runat="server" DataSourceID="SqlDataSourceEmployee"
                                DataTextField="Employee Name" DataValueField="EmpID">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; width: 200px">Attachments :
                        </td>
                        <td style="text-align: left">
                            <asp:FileUpload ID="fileUploadReDoc" runat="server" AllowMultiple="true" Style="width: 90%; margin: auto" />
                            <asp:Label ID="lblmsg" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBillingConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT Employee.EmpID,ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name] FROM Employee JOIN 
                                                DiscountAuthorities DA ON DA.EmpId=Employee.EmpID ORDER BY EFName">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Hospital" Name="Hospital_ID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <tr>
                        <td style="width: 98px; height: 24px; text-align: right">Description:
                        </td>
                        <td style="width: 100px; height: 24px">
                            <asp:TextBox ID="TextBox_Description" runat="server" Height="55px" TextMode="MultiLine"
                                Width="231px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 98px; height: 24px; text-align: right"></td>
                        <td style="width: 100px; height: 24px">
                            <asp:Button ID="Button_ForwardDisReq" runat="server" Text="Forward" OnClick="Button_ForwardDisReq_Click1"/>
                            <asp:Button ID="Button3" runat="server" Text="Close" OnClick="Button3_Click" />

                            <asp:HiddenField ID="HiddenField_SubDeptId" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                InsertCommand="INSERT INTO Forward_To_Sub_Dept (Reg_No, yearly_no, to_sub_Dept, by_doctor, by_sub_dept_id, forward_date, request_type_id, To_Emp_Id, Description,FileName,AfterBill) VALUES     (@Reg_No,@yearly_no,@to_sub_Dept,@by_doctor,@by_sub_dept_id,getdate(),@request_type_id,@To_Emp_Id,@Description,@FileName,1)"
                                SelectCommand="SELECT [Reg_No], [yearly_no], [to_sub_Dept], [by_doctor], [by_sub_dept_id], [forward_date], [request_type_id], [To_Emp_Id], [Description] FROM [Forward_To_Sub_Dept]"
                                UpdateCommand="UPDATE Discount_Main SET SPM_ID = @SPM_ID WHERE     (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (Payment_Status = 0)">
                                <InsertParameters>
                                    <asp:QueryStringParameter Name="Reg_No" QueryStringField="regno" />
                                    <asp:QueryStringParameter Name="yearly_no" QueryStringField="payid" />
                                    <asp:ControlParameter ControlID="HiddenField_SubDeptId" Name="to_sub_Dept" PropertyName="Value" />
                                    <asp:SessionParameter Name="by_doctor" SessionField="Emp_Id" />
                                    <asp:ControlParameter ControlID="HiddenField_BySubDeptId" Name="by_sub_dept_id" PropertyName="Value" />
                                    <asp:Parameter DefaultValue="15" Name="request_type_id" />
                                    <asp:ControlParameter ControlID="DropDownList_Consultant" Name="To_Emp_Id" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="HFFileName" Name="FileName" PropertyName="Value" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="HiddenField_smpID" Name="SPM_ID" PropertyName="Value" />
                                    <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                                    <asp:QueryStringParameter Name="YearlyNo" QueryStringField="Payid" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_BySubDeptId" runat="server" />
                            <asp:HiddenField ID="HFFileName" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </div>
</asp:Content>

