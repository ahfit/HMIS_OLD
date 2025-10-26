<%@ page language="VB" masterpagefile="~/hacims_masterpage_billing.master" autoeventwireup="false" CodeFile="~/Patient Billing/Discount.aspx.vb" inherits="Patient_Billing_Discount" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
<script type="text/javascript">


function AddFlag()

{
    SqlDataSource_Discount_Main_Inserted


document.getElementById("Flag").value= document.getElementById("Flag").value + 'PB'; 	

}

    function CheckMaxValue( e )
{        
        var min = e.min;
        var max = e.max;
        var value = e.value;

        if (value< min)
        {
            e.value = min;
        }
        if (value > max) {
            e.value = max;
        }

    }
    function check(e)
    {        
        var a = $(e).closest("tr").find("[id$='txt_doc_dis']");
        CheckMaxValue(a);
    }
 </script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >
  <asp:ScriptManager id="ScriptManager1" runat="server"> </asp:ScriptManager>

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="60%">
        <table cellspacing="0" cellpadding="0" width="100%" border="0" class="tbl_form table-bordered" style="border:2px solid black">
           
                <tr>
                    <td >
                        <asp:RadioButtonList ID="RadioButtonList_Payment_type" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" Visible="True">
                            <asp:ListItem Selected="True" Value="0">Unpaid</asp:ListItem>
                            <asp:ListItem Value="1">Paid</asp:ListItem>
                            <asp:ListItem Value="2">Both</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:DropDownList ID="DropDownList_Type" runat="server" AutoPostBack="True" Visible="False">
                            <asp:ListItem>Rs.</asp:ListItem>
                            <asp:ListItem>%</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="TextBox_Percentage_Discount" runat="server" AutoPostBack="True" Visible="False">0</asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Invalid Percentage" ControlToValidate="TextBox_Percentage_Discount" Type="Integer" MaximumValue="100" MinimumValue="0"></asp:RangeValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Valid Values" ControlToValidate="TextBox_Other_Discount" Display="Dynamic" ValidationExpression="\d*"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="TextBox_Other_Discount" runat="server" AutoPostBack="True" OnTextChanged="TextBox_Other_Discount_TextChanged" Visible="False">0</asp:TextBox></td>
                </tr>
                <tr style="color: #333333">
                    <td align="right" colspan="2" style="text-align: left" valign="top">
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True" Value="1">Individual Discount</asp:ListItem>
                            <asp:ListItem Value="2">Cumulative Discount</asp:ListItem>
                            <asp:ListItem Value="3">Consultant Discount</asp:ListItem>
                        </asp:RadioButtonList></td>
                </tr>
                <tr style="color: #333333">
                    <td align="right" colspan="2" valign="top">
                        <asp:GridView ID="GridView_For_Services" runat="server" Width="100%" DataSourceID="SqlDataSource_For_Grid" AutoGenerateColumns="False" OnSelectedIndexChanged="GridView_For_Services_SelectedIndexChanged" ShowFooter="True">
                            <RowStyle CssClass="GridItem"></RowStyle>
                            <Columns>
                                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" ItemStyle-Width="80px"></asp:BoundField>
                                <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False"></asp:BoundField>
                                <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo" Visible="False"></asp:BoundField>
                                <asp:BoundField DataField="S_Name" HeaderText="Service" SortExpression="S_Name" ItemStyle-Width="260px"></asp:BoundField>
                                <asp:BoundField DataField="S_ID" HeaderText="S_ID" ReadOnly="True" InsertVisible="False" SortExpression="S_ID" Visible="False"></asp:BoundField>
                                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" SortExpression="ID" Visible="False"></asp:BoundField>
                                <asp:BoundField DataField="time" HeaderText="Time" SortExpression="time" Visible="False"></asp:BoundField>

                                <asp:TemplateField HeaderText="Price">
                                    <FooterTemplate>
                                        <asp:Label ID="Label_TotalPrice" runat="server" Text="0" Font-Bold="True" ></asp:Label>
                                    </FooterTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label_Price" runat="server" Text='<%# Eval("Amount", "{0}") %>' ></asp:Label>
                                        <asp:HiddenField ID="HiddenField_DiscountAmount" runat="server" Value="0" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Discount Type">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="DropDownList_Type" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_Type_SelectedIndexChanged" Width="60px">
                                            <asp:ListItem>Rs.</asp:ListItem>
                                            <asp:ListItem>%</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:HiddenField ID="HiddenField_doctor_ID" runat="server" Value='<%# Eval("Doctor_ID", "{0}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount">
                                    <FooterTemplate>
                                        &nbsp;
          
                                    </FooterTemplate>
                                    <ItemTemplate>
                                        &nbsp;
                                        <asp:TextBox ID="TextBox_Discount" runat="server" Width="54px" AutoPostBack="True" OnTextChanged="TextBox_Discount_TextChanged">0</asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Discounted Price">
                                    <ItemTemplate>
                                        <asp:Label ID="Label_Original_Price" runat="server"></asp:Label>
                                        <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Eval("ID", "{0}") %>'></asp:HiddenField>
                                        <asp:HiddenField ID="hf_Doc_MAX_Dis" runat="server" Value='<%# Eval("DOC_Dis_LIMIT", "{0}") %>'></asp:HiddenField>
                                        <asp:HiddenField ID="HiddenFieldDiscountAmount" runat="server" Value="0"></asp:HiddenField>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="Label_DiscountedPriceTotal" runat="server" Font-Bold="True" Text="0"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Doctor Discount">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txt_doc_dis" runat="server" CssClass="DocDis" TextMode="Number" min="0" Text="0" Onblur="CheckMaxValue(this)" Width="40px"> </asp:TextBox><%--max='<%# Eval("DOC_Dis_LIMIT", "{0}") %>'--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DOC_Dis_LIMIT" HeaderText="Doc Max Discount" SortExpression="DOC_Dis_LIMIT" ItemStyle-Width="50px" />
                            </Columns>

                            <HeaderStyle CssClass="GridHeader"></HeaderStyle>

                            <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="color: #333333">
                    <td align="right" colspan="2" valign="top">
                        <table class="tbl_form table-bordered" style="border:2px solid black">
                            <tr>
                                <td style="width: 154px; height: 18px; text-align: right">Total Amount :</td>
                                <td style="width: 89px; height: 18px">
                                    <asp:Label ID="Label_Grand_Total" runat="server" Text="0" Font-Bold="True"></asp:Label></td>
                            </tr>
                            <tr style="font-size: 9pt">
                                <td style="width: 154px; text-align: right">Total Discount :</td>
                                <td style="width: 89px">
                                    <table>
                                        <tr>
                                            <td style="width: 100px">
                                                <asp:Label Style="font-weight: bold; font-size: 14px; color: #ff0000" ID="Label_Total_Discount" runat="server" Text="0" ForeColor="Red" Font-Bold="True"></asp:Label>&nbsp;
                                
                                            </td>
                                            <td style="width: 100px">

                                                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" Visible="False" Width="60px">
                                                    <asp:ListItem>Rs.</asp:ListItem>
                                                    <asp:ListItem>%</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td style="width: 100px">
                                                <asp:TextBox ID="TextBox_ComDiscounnt" runat="server" Visible="False" Width="60px" AutoPostBack="True" OnTextChanged="TextBox_ComDiscounnt_TextChanged1">0</asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 154px; text-align: right">Total Dicounted Amount :</td>
                                <td style="width: 89px">
                                    <asp:Label ID="Label_DiscountedTotal" runat="server" Font-Bold="True" ForeColor="Green"
                                        Text="0"></asp:Label></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="color: #333333">
                    <td align="right">Discount Type :</td>
                    <td>
                        <asp:DropDownList ID="ddl_Discount_Type" runat="server">
                        </asp:DropDownList></td>
                </tr>
                <tr style="color: #333333">
                    <td align="right">Description :</td>
                    <td style="text-align: left">
                        <asp:TextBox ID="TextBox_Description" runat="server" Width="306px" MaxLength="4000" TextMode="MultiLine" Height="75px"></asp:TextBox></td>
                </tr>
                <tr style="color: #333333">
                    <td align="right">Discount By :</td>
                    <td>
                        <asp:DropDownList ID="DropDownList_Discount_By" runat="server" DataSourceID="SqlDataSource_Employee"
                            DataTextField="Employee Name" DataValueField="EmpID" Width="308px">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="right" style="height: 18px"></td>
                    <td style="height: 18px">
                        <asp:Button ID="Button_Save" OnClick="Button_Save_Click" runat="server"
                            Text="Save" Visible="False"></asp:Button>&nbsp;<asp:Button ID="Button1" OnClick="Button1_Click" runat="server" Text="Payment" Visible="False"></asp:Button>
                        <asp:Button ID="Button_Discount" runat="server" Text="Forward"
                            Visible="False" />
                        <asp:Button ID="btn_discount" runat="server" Text="Save Discount" />
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2">


                        <asp:Panel ID="Panel_Discount" runat="server" Visible="False" Width="100%">
                            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                                <tr>
                                    <td align="right" width="40%">Type :</td>
                                    <td>
                                        <asp:RadioButtonList ID="RadioButtonList2" runat="server" AutoPostBack="True" RepeatDirection="Horizontal">
                                            <asp:ListItem Selected="True">Consultant</asp:ListItem>
                                            <asp:ListItem Value="General">Administrator</asp:ListItem>
                                        </asp:RadioButtonList></td>
                                </tr>
                                <tr>
                                    <td align="right">Forward To :</td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList_Consultant" runat="server" DataSourceID="SqlDataSourceEmployee"
                                            DataTextField="Employee Name" DataValueField="EmpID">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                            SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS [Employee Name] FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID WHERE (Employee.Emp_Type = @Emp_Type) AND (Department.Hospital_ID LIKE '%' + @Hosp_Id + '%') ORDER BY [Employee Name]">
                                            <SelectParameters>
                                                <asp:SessionParameter DefaultValue="%" Name="Hosp_Id" SessionField="Hospital_Id" />
                                                <asp:ControlParameter ControlID="RadioButtonList2" Name="Emp_Type" PropertyName="SelectedValue" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Description :</td>
                                    <td>
                                        <asp:TextBox ID="TextBox1" runat="server" Height="55px" TextMode="MultiLine"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:Button ID="Button_ForwardDisReq" runat="server" Text="Forward" />
                                        <asp:Button ID="Button2" runat="server" Text="Cancel" />
                                        <asp:HiddenField ID="HiddenField_SubDeptId" runat="server" />
                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                            InsertCommand="Insert_Forward_To_SubDept_Discount" InsertCommandType="StoredProcedure"
                                            SelectCommand="SELECT [Reg_No], [yearly_no], [to_sub_Dept], [by_doctor], [by_sub_dept_id], [forward_date], [request_type_id], [To_Emp_Id], [Description] FROM [Forward_To_Sub_Dept]">
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
                                        </asp:SqlDataSource>
                                        <asp:HiddenField ID="HiddenField_BySubDeptId" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:HiddenField ID="HiddenField_Discount_ID" runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="HiddenField_Doctor_Amount" runat="server" />
                        <asp:HiddenField ID="HiddenField_Total_Discount" runat="server"></asp:HiddenField>
                    </td>
                </tr>
        </table>

</td>
    <td valign="top">
    
    
    <DIV style="MARGIN-LEFT: 10px">
    
    <asp:GridView id="GridView_Discount_Main" runat="server" Width="98%" DataSourceID="SqlDataSource_Discount_Main"
         AutoGenerateColumns="False" DataKeyNames="Discount_ID" OnSelectedIndexChanged="GridView_Discount_Main_SelectedIndexChanged" 
        AllowPaging="True" PageSize="15" OnPreRender="GridView_Discount_Main_PreRender" OnRowEditing="GridView_Discount_Main_RowEditing1">
<RowStyle CssClass="GridItem"></RowStyle>
<Columns>
    <asp:BoundField DataField="DateTime" HeaderText="Discount Date" />
<asp:TemplateField HeaderText="Amount"><ItemTemplate>
<asp:LinkButton id="LinkButton1" runat="server" Text='<%# Eval("Amount", "{0}") %>' CommandName="Select" CausesValidation="False"></asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="View Report"><ItemTemplate>
<asp:LinkButton id="LinkButton2" runat="server" CommandName="Edit">Report</asp:LinkButton> <asp:HiddenField id="HiddenField1" runat="server" Value='<%# Eval("Discount_ID", "{0}") %>'></asp:HiddenField>
</ItemTemplate>
</asp:TemplateField>
    <asp:CommandField ShowDeleteButton="True" />
</Columns>

<SelectedRowStyle CssClass="gridselect"></SelectedRowStyle>

<HeaderStyle CssClass="GridHeader"></HeaderStyle>

<EditRowStyle CssClass="gridedit"></EditRowStyle>

<AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
</asp:GridView> 

<BR />

<asp:GridView id="GridView_Discount_Sub" runat="server" Width="98%" DataSourceID="SqlDataSource_Discount_Sub" AutoGenerateColumns="False" DataKeyNames="Discount_Sub_ID" AllowPaging="True" PageSize="15" OnPreRender="GridView_Discount_Sub_PreRender">
        <Columns>
        <asp:BoundField DataField="S_Name" HeaderText="Service Name" SortExpression="S_Name"></asp:BoundField>
        <asp:BoundField DataField="Discount_Sub_Amount" HeaderText="Amount" SortExpression="Discount_Sub_Amount"></asp:BoundField>
        </Columns><RowStyle CssClass="GridItem" />
 
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
      </asp:GridView>
      
      
      </DIV>
    
    
     </td>
  </tr>
</table>

 
 
 
 
 
 
 <BR />
    
    <asp:SqlDataSource id="SqlDataSource_For_Grid" runat="server" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
         SelectCommandType="StoredProcedure" SelectCommand="Search_Discount" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
        <SelectParameters>
          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
          <asp:ControlParameter ControlID="RadioButtonList1" PropertyName="SelectedValue" Name="Status" Type="Int32"></asp:ControlParameter>
            <asp:ControlParameter ControlID="RadioButtonList_Payment_type" PropertyName="SelectedValue" Name="PaymentType" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
      </asp:SqlDataSource>
    <asp:SqlDataSource id="SqlDataSource_Discount_Main" 
        runat="server" 
        SelectCommand="SELECT Convert(varchar,DiscountDate,107)as DateTime, Total_Amount AS Amount, Discount_ID FROM Discount_Main WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo)  &#13;&#10;&#13;&#10;Order by Discount_ID desc" 
        ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" 
        InsertCommandType="StoredProcedure" InsertCommand="Pro_Discount_Main" 
        OnInserted="SqlDataSource_Discount_Main_Inserted" 
        DeleteCommand="DELETE FROM Discount_Main WHERE (Discount_ID = @Discount_ID);DELETE FROM Discount_Sub WHERE (Discount_ID = @Discount_ID)"><SelectParameters>
<asp:SessionParameter SessionField="RegistrationNo" Name="RegNo"></asp:SessionParameter>
<asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
</SelectParameters>
<InsertParameters>
<asp:SessionParameter SessionField="emp_id" Name="emp_ID" Type="Int32"></asp:SessionParameter>
<asp:ControlParameter ControlID="HiddenField_Total_Discount" PropertyName="Value" Name="Total_Amount" Type="Int32"></asp:ControlParameter>
<asp:ControlParameter ControlID="TextBox_Description" PropertyName="Text" Name="Description" Type="String"></asp:ControlParameter>
<asp:SessionParameter SessionField="RegistrationNo" Name="RegNo" Type="String"></asp:SessionParameter>
<asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo" Type="Int32"></asp:SessionParameter>
    <asp:ControlParameter ControlID="ddl_Discount_Type" Name="Discount_Type" Type="String" PropertyName="SelectedValue" />
<asp:Parameter Direction="InputOutput" Name="Discount_ID" Type="Decimal"></asp:Parameter>
    <asp:ControlParameter ControlID="DropDownList_Discount_By" Name="Discount_By" PropertyName="SelectedValue"
        Type="String" />
    <asp:ControlParameter ControlID="Label_Grand_Total" Name="T_SumAmount" PropertyName="Text" Type="Int32" />
   
    <asp:QueryStringParameter Name="Request_ID" QueryStringField="requestid" Type="Int32" />
   <asp:ControlParameter ControlID="HiddenField_ID" PropertyName="Value" Name="ID" Type="Decimal"></asp:ControlParameter>
    <asp:ControlParameter ControlID="RadioButtonList_Payment_type" PropertyName="SelectedValue" Name="PaymentType" Type="Int32"></asp:ControlParameter>
</InsertParameters>
</asp:SqlDataSource>
    <%-- <asp:SqlDataSource id="SqlDataSource_Discount_Main" 
        runat="server" 
        SelectCommand="SELECT Convert(varchar,DiscountDate,107)as DateTime, Total_Amount AS Amount, Discount_ID FROM Discount_Main WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo)  &#13;&#10;&#13;&#10;Order by Discount_ID desc" 
        ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" 
        InsertCommandType="StoredProcedure" InsertCommand="Pro_Discount_Main" 
        OnInserted="SqlDataSource_Discount_Main_Inserted" 
        DeleteCommand="DELETE FROM Discount_Main WHERE (Discount_ID = @Discount_ID)"><SelectParameters>
<asp:SessionParameter SessionField="RegistrationNo" Name="RegNo"></asp:SessionParameter>
<asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
</SelectParameters>
<InsertParameters>
<asp:SessionParameter SessionField="emp_id" Name="emp_ID" Type="Int32"></asp:SessionParameter>
<asp:ControlParameter ControlID="HiddenField_Total_Discount" PropertyName="Value" Name="Total_Amount" Type="Int32"></asp:ControlParameter>
<asp:ControlParameter ControlID="TextBox_Description" PropertyName="Text" Name="Description" Type="String"></asp:ControlParameter>
<asp:SessionParameter SessionField="RegistrationNo" Name="RegNo" Type="String"></asp:SessionParameter>
<asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo" Type="Int32"></asp:SessionParameter>
    <asp:ControlParameter ControlID="ddl_Discount_Type" Name="Discount_Type" PropertyName="SelectedValue" />
<asp:Parameter Direction="InputOutput" Name="Discount_ID" Type="Decimal"></asp:Parameter>
    <asp:ControlParameter ControlID="DropDownList_Discount_By" Name="Discount_By" PropertyName="SelectedValue"
        Type="String" />
    <asp:ControlParameter ControlID="Label_Grand_Total" Name="T_SumAmount" PropertyName="Text" Type="Int32" />
</InsertParameters>
</asp:SqlDataSource>--%>
    
    
     <asp:SqlDataSource id="SqlDataSource_Discount_Sub" runat="server" SelectCommand="SELECT Discount_Sub.Discount_Sub_ID, Discount_Sub.Discount_Sub_Amount, Discount_Sub.ID, Discount_Sub.Discount_ID, Admin_Services.S_Name FROM Discount_Sub INNER JOIN Patient_Services ON Discount_Sub.ID = Patient_Services.ID INNER JOIN Admin_Services ON Patient_Services.S_ID = Admin_Services.S_ID WHERE (Discount_Sub.Discount_ID = @Discount_ID) AND (Patient_Services.RegNo = @RegNo) AND (Patient_Services.YearlyNo = @YearlyNo)" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" InsertCommandType="StoredProcedure" InsertCommand="Pro_Discount_Sub"><SelectParameters>
<asp:ControlParameter ControlID="GridView_Discount_Main" PropertyName="SelectedValue" Name="Discount_ID"></asp:ControlParameter>
<asp:SessionParameter SessionField="RegistrationNo" Name="RegNo"></asp:SessionParameter>
<asp:SessionParameter SessionField="YearlyNo" Name="YearlyNo"></asp:SessionParameter>
</SelectParameters>
<InsertParameters>
<asp:ControlParameter ControlID="HiddenField_Discount_ID" PropertyName="Value" Name="Discount_ID" Type="Decimal"></asp:ControlParameter>
<asp:ControlParameter ControlID="HiddenField_ID" PropertyName="Value" Name="ID" Type="Decimal"></asp:ControlParameter>
<asp:ControlParameter ControlID="HiddenField_Amount" PropertyName="Value" Name="Discount_Sub_Amount"></asp:ControlParameter>
    <asp:ControlParameter ControlID="HiddenField_Doctor_Amount" Name="Consultant_Discount"
        PropertyName="Value" Type="Double" />
    <asp:ControlParameter ControlID="HiddenField_Doctor_ID" Name="Doctor_ID" PropertyName="Value"
        Type="Int32" />
    <asp:ControlParameter ControlID="RadioButtonList_Payment_type" PropertyName="SelectedValue" Name="PaymentType" Type="Int32"></asp:ControlParameter>
</InsertParameters>
</asp:SqlDataSource> &nbsp;
    <asp:HiddenField id="HiddenField_Amount" runat="server"></asp:HiddenField> <asp:HiddenField id="HiddenField_ID" runat="server"></asp:HiddenField> <asp:HiddenField id="HiddenField_bill_Amount" runat="server"></asp:HiddenField> &nbsp;
    <asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" />
    &nbsp;
    <asp:HiddenField ID="Flag" runat="server" Value="1" />

  <br />
    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT Employee.EmpID,ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name] FROM Employee JOIN PatientBillling.dbo.DiscountAuthorities DA ON DA.EmpId=Employee.EmpID ORDER BY EFName">
    </asp:SqlDataSource>
   
</asp:Content>
