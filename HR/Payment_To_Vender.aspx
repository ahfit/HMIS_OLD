<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Payment_To_Vendor, App_Web_ybbpntbq" title="Voucher Receipts Payments" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            font-size: small;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
        function calculateTax() {            
            var amount = $.trim($("[id$='TXT_Amount']").val()) == "" ? 0 : $.trim($("[id$='TXT_Amount']").val());
            var gst = $.trim($("[id$='txt_tax']").val()) == "" ? 0 : $.trim($("[id$='txt_tax']").val());
            var withHolding = $.trim($("[id$='txt_withHolding']").val()) == "" ? 0 : $.trim($("[id$='txt_withHolding']").val());
            var without = $.trim($("[id$='txt_withoutHolding']").val()) == "" ? 0 : $.trim($("[id$='txt_withoutHolding']").val());
            var cal1 = parseInt((gst / 100) * amount);
            var cal2 = parseInt((withHolding / 100) * amount);
            var cal3 = parseInt((without / 100) * amount);
            $("[id$='txt_Famount']").val(amount - cal1 - cal2 - cal3);

            $("[id$='lblGST']").html(cal1);
            $("[id$='lblIncomeTax']").html(cal2);
            $("[id$='lblOtherTax']").html(cal3);
            $("[id$='hdnFinalAmount']").val($("[id$='txt_Famount']").val());

            $("[id$='hdnGst']").val(cal1);
            $("[id$='hdnIncomeTax']").val(cal2);
            $("[id$='hdnOtherTax']").val(cal3);

             
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table class="style1 table-form">
      <tr>
      <td></td>
      <td>
      <asp:Label ID="lblMsg" runat="server" Visible="false" style="font-weight:bold;font-size:14px;" ></asp:Label>
      </td>
      </tr>
        <tr>
            <td align="right" width="40%">
                Payment :
            </td>
            <td>
                <asp:DropDownList ID="ddl_Expanse" runat="server" AutoPostBack="True" Width="35%"
                    DataSourceID="SDS_Expanse" DataTextField="E_Name" DataValueField="E_Code">
                    <asp:ListItem Value="1">Accounts Payables (Creditors)</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SDS_Expanse" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                    SelectCommand="SELECT E.E_Code,E.E_Name 
FROM Expenditure E Inner Join 
	 Head_Master_Table HMT On E.E_Code=HMT.E_Code 
WHERE HMT.Head_Type='Vendor_Payment'
ORDER BY E_Name Desc"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" width="40%">
                Payment Date :
            </td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_PODate" runat="server" Width="35%">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
                <asp:HiddenField ID="HF_Expance_Date" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="right" width="40%">
                Amount :
            </td>
            <td>
                <asp:TextBox ID="TXT_Amount" runat="server" Width="15%" MaxLength="10" Text="0" SkinID="number"
                    onblur="calculateTax();"></asp:TextBox>
                &nbsp;<span class="style2">Rs.</span>
                            </td>
        </tr>
        <tr>
            <td align="right" class="style2">
               % GST:
            </td>
            <td>
                <asp:TextBox ID="txt_tax" runat="server" Width="30px" Text="0" onblur="calculateTax();"></asp:TextBox>

             <span class="style2"  style="padding-left:20px;">  Calculated Tax Amount: </span>
             
             <%--<asp:Label ID="lblGST" Text="0" runat="server"  style="padding-left:10px; font-weight:bold;"></asp:Label>--%>
             <asp:Label ID="lblGST" runat="server"  style="padding-left:10px; font-weight:bold;"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right" class="style2">
                %WithHolding / Income:
            </td>
            <td>
                <asp:TextBox ID="txt_withHolding" runat="server" Width="30px" Text="0" onblur="calculateTax();"></asp:TextBox>
              <span class="style2"  style="padding-left:20px;">  Calculated Tax Amount: </span>
              <asp:Label ID="lblIncomeTax" runat="server" Text="0" style="padding-left:10px; font-weight:bold;"></asp:Label>              
            </td>
        </tr>
        <tr>
            <td align="right" class="style2">
                % Other:
            </td>
            <td>
                <asp:TextBox ID="txt_withoutHolding" runat="server" Width="30px" Text="0" onblur="calculateTax();"></asp:TextBox>
                <span class="style2" style="padding-left:20px;">  Calculated Tax Amount: </span> 
                <asp:Label ID="lblOtherTax" Text="0" runat="server" style="padding-left:10px; font-weight:bold;"></asp:Label>   
                                
            </td>
        </tr>
        <tr>
            <td align="right" class="style2">
                %Final Amount:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txt_Famount" Enabled="false" Width="70px"></asp:TextBox>
                
            </td>
        </tr>
        <tr>
            <td align="right" width="40%">
                Search Vender :
            </td>
            <td>
                <asp:TextBox ID="TXT_Party_Name" runat="server" AutoPostBack="True" Width="35%" OnTextChanged="TXT_Party_Name_TextChanged"></asp:TextBox>
                <asp:Label ID="LBL_Rec_MSG" runat="server"></asp:Label>
                <br />
                <asp:DropDownList ID="DropDownList_Party" runat="server" Width="35%" DataSourceID="SDS_Employee"
                    DataTextField="Party_Name" DataValueField="Party_Id" AutoPostBack="True">
                </asp:DropDownList>
                <a id="addlink" runat="server" class="add_link box" href="Add_New_Company.aspx" target="_blank">
                    Add</a><asp:SqlDataSource ID="SDS_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand=" SELECT parties.Party_Id, Ltrim(Rtrim(Party_Name)) Party_Name FROM parties 
                    where Party_Name like @P_name  and Party_Name!='' and Party_Name is not null ORDER BY Party_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Hf_PARTY_NAME" DefaultValue="%" Name="P_name" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" width="40%">
                Description :
            </td>
            <td>
                <asp:TextBox ID="TXT_Description" runat="server" Height="100px" TextMode="MultiLine"
                    Width="65%"></asp:TextBox>
            </td>
        </tr>
        <tr>
                    <td align="right">
                        Mode of Payment :</td>
                    <td>
                        <asp:DropDownList ID="ddl_mode_of_payment" runat="server" AutoPostBack="True">
                            <asp:ListItem Value="" Text=""></asp:ListItem>   
                            <asp:ListItem Text="Cash" Value="Cash">Cash</asp:ListItem>                            
                            <asp:ListItem Text="Cheque" Value="Bank" >Cheque</asp:ListItem>

                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align = "right" >
                        Select Accout Head</td>
                    <td>
                        <asp:DropDownList ID="ddl_head" DataTextField ="E_name" DataValueField="E_Code" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                 <tr id="trCheckNo" runat="server" visible="false">
                    <td align="right">
                        
                        Check No :
                        
                    </td>
                    <td>
                        <asp:TextBox ID="txtCheckNo" runat="server"></asp:TextBox>
                    </td>
                </tr>
     <%--   <tr>
            <td align="right" width="40%">
                <asp:Label ID="LabelACNO" runat="server" Text="Account #"></asp:Label>
            </td>
            <td>
                <asp:RadioButtonList ID="RBL_Am_Type" runat="server" AutoPostBack="True" RepeatDirection="Horizontal">
                    <asp:ListItem>Cash</asp:ListItem>
                    <asp:ListItem>Cheque</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td align="right" width="40%">
                <asp:Label ID="LabelAC" runat="server" Text="Account #" Visible="False"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="DDL_AC_NO" runat="server" AutoPostBack="True" DataSourceID="SDS_Bank_Account"
                    DataTextField="Account_No" Width="35%" DataValueField="E_Code" Visible="False">
                </asp:DropDownList>
                <br />
                <asp:SqlDataSource ID="SDS_Bank_Account" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                    SelectCommand="SELECT ' Cash' AS Account_No, 33701 AS E_Code UNION SELECT Account_No, E_Code FROM Bank_Account WHERE (Account_Access LIKE @Account_Access)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HF_Branch_Access" Name="Account_Access" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>--%>
        <tr>
            <td width="40%">
                &nbsp;
            </td>
            <td>
                <asp:Button ID="BTN_Save" runat="server" Text="Save" />
                <asp:Label ID="LBL_MSG" runat="server" ForeColor="Red"></asp:Label>
                <br />
            </td>
        </tr>
        <tr>
            <td width="40%">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:GridView ID="GV_Record" runat="server" Width="100%" AutoGenerateColumns="False"
                    DataSourceID="SDS_GV" EnableModelValidation="True" DataKeyNames="id" EmptyDataText="No record Found"
                    AllowPaging="True" PageSize="30">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                    ImageUrl="~/images/deletebtn.png" Width="10px" OnClientClick='return confirm("Do you want to delete this Record ?");'
                                    Text="Delete" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Expanse" HeaderText="Expanse" SortExpression="Expanse" />
                        <asp:BoundField DataField="Payment_Date" HeaderText="Expance Date" DataFormatString="{0:dd/MM/yyyy}"
                            SortExpression="Date" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                        <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                        <asp:BoundField DataField="Payment_Type" HeaderText="Payment Type" SortExpression="Payment_Type" />
                        <asp:BoundField DataField="Account_No" HeaderText="Account No." SortExpression="Account_No" />
                        <asp:BoundField DataField="Financial_Company_Name" HeaderText="Financial_Company_Name"
                            SortExpression="Financial_Company_Name" />
                        <asp:BoundField DataField="Financial_Company_Id" HeaderText="Financial_Company_Id"
                            SortExpression="Financial_Company_Id" />
                    </Columns>
                </asp:GridView>
                <br />
                <asp:SqlDataSource ID="SDS_GV" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                    InsertCommand="insert_Payment_To_Vender" InsertCommandType="StoredProcedure"
                    SelectCommand="SELECT Expenditure_1.E_Name AS Expanse, Employee.Name, Expenditure.E_Name AS Account_No, Payment_To_Vender.Amount, Group_Financial_Companies.Financial_Company_Name, Payment_To_Vender.Payment_Date, Payment_To_Vender.Payment_Type, Payment_To_Vender.Description, Payment_To_Vender.Dept_ID, Payment_To_Vender.Subdept_ID, Payment_To_Vender.ID, Group_Company_Branches.Company_Branch_Name, Payment_To_Vender.Financial_Company_ID, Payment_To_Vender.Company_Branch_ID FROM Payment_To_Vender INNER JOIN Employee ON Payment_To_Vender.Add_By_Emp_ID = Employee.EmpID INNER JOIN Expenditure AS Expenditure_1 ON Payment_To_Vender.Dr_Ecode = Expenditure_1.E_Code INNER JOIN Group_Financial_Companies ON Payment_To_Vender.Financial_Company_ID = Group_Financial_Companies.Financial_Company_Id INNER JOIN Group_Company_Branches ON Payment_To_Vender.Company_Branch_ID = Group_Company_Branches.Company_Branch_Id LEFT OUTER JOIN Expenditure ON Payment_To_Vender.Cr_Ecode = Expenditure.E_Code WHERE (Payment_To_Vender.Dept_ID = @Dept_ID) AND (Payment_To_Vender.Subdept_ID = @Subdept_ID)"
                    DeleteCommand="delete_Payment_Vender_Rec" DeleteCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="ID" Type="Int32" />
                        <asp:SessionParameter Name="Emp_ID" SessionField="Emp_id" Type="Int32" />
                    </DeleteParameters>
                    <%--<InsertParameters>                                           
                            <asp:ControlParameter ControlID="ddl_Expanse" Name="Dr_Ecode" PropertyName="SelectedValue" Type="Decimal" />                            
                            <asp:ControlParameter ControlID="WebDateChooser_PODate" Name="Payment_Date" PropertyName="Value" Type="DateTime" />
                            <asp:ControlParameter ControlID="TXT_Amount" Name="Amount" PropertyName="Text" Type="Decimal" />
                            <asp:ControlParameter ControlID="txt_tax" Name="GST" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txt_withHolding" Name="IncomeTax" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txt_withoutHolding" Name="OtherTax" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txt_Famount" Name="FinalAmount" PropertyName="Text" Type="Decimal" />                            
                            <asp:ControlParameter ControlID="DropDownList_Party" Name="Vender_Party_Id" PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="ddl_head" Name="Cr_Ecode" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="TXT_Description" Name="Description" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="ddl_mode_of_payment" Name="PaymentType" PropertyName="SelectedValue" Type="String" />                            
                            <asp:ControlParameter ControlID="txtCheckNo" Name="CheckNo" PropertyName="Text" Type="String" />
                            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />                        
                            <asp:SessionParameter Name="Add_By_Emp_ID" SessionField="emp_iD" Type="Int32" />
                            <asp:SessionParameter Name="Subdept_ID" SessionField="SubDeptid" Type="Int32" />

                        
                    </InsertParameters>--%>
                    <SelectParameters>
                        <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" />
                        <asp:SessionParameter Name="Subdept_ID" SessionField="subdeptid" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="Hf_PARTY_NAME" runat="server" />
                <asp:HiddenField ID="hdnFinalAmount" runat="server" />

                <asp:HiddenField ID="hdnGst" runat="server" />
                <asp:HiddenField ID="hdnIncomeTax" runat="server" />
                <asp:HiddenField ID="hdnOtherTax" runat="server" />

                <asp:HiddenField ID="HF_Branch_Access" runat="server" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
    