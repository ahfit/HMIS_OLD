<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NurseServices_Page.aspx.vb" MasterPageFile="~/hacims_masterpage.master"
    Inherits="Nursing_NurseServices_Page" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <script language="javascript" type="text/javascript">
        function OpenWindow() {
            var RegNo = document.getElementById("hidRegNo").value;
            var YearlyNo = document.getElementById("HidYearlyNo").value;
            window.open('Mark_Test_For_Pathology.aspx?registrationNo=' + RegNo + '&YearlyNo=' + YearlyNo, '', 'toolbar=none,width=1000,y=10,x=10');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="../PatientServices.asmx" />
        </Services>
    </asp:ScriptManager>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">

      <tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
 
</td>
<td  style="width:auto;" valign="top" > 

            <td valign="top" width="43%">
                <asp:HiddenField ID="HiddenField_Previous_index" runat="server" Value="-1" />
                <asp:UpdateProgress ID="updProgress" runat="server">
                    <ProgressTemplate>
                        <div style="position: absolute; left: 45%; top: 40%;">
                            <img alt="progress" src="../images/ajaxloader.gif" width="40PX" />
                            <br />
                            Processing...
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div class="bxmain" style="width:99%">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr style="display:none;">
                            <td align="right">
                                MR. #
                            </td>
                            <td width="61%" align="left">
                                <asp:Label ID="lbl_Mr_No" runat="server" ForeColor="Red"></asp:Label>
                                <br />
                                <asp:TextBox ID="TXT_Load_patient" runat="server" AutoPostBack="true" CssClass="input_txt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            Category:
                            </td>
                            <td width="61%" align="left">
                                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Packages"
                                    DataTextField="Asc_Name" DataValueField="Asc_id">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Search Services :
                            </td>
                            <td>
                                <asp:UpdatePanel ID="pnlSearchService" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox CssClass="input_txt" ID="TextBox_Search_Service" runat="server" Width="200px"
                                            AutoPostBack="True"></asp:TextBox>
                                        <cc1:AutoCompleteExtender ID="AutoComplete_Complaint" runat="server" CompletionInterval="10"
                                            CompletionSetCount="12" EnableCaching="true" UseContextKey="true" MinimumPrefixLength="3"
                                            ServiceMethod="Search_Services_OPD" ServicePath="../AutoComplete.asmx" TargetControlID="TextBox_Search_Service">
                                        </cc1:AutoCompleteExtender>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <asp:Label ID="LabelAmountError" runat="server" CssClass="err" Visible="False"></asp:Label>
                                <asp:HiddenField ID="HiddenFieldServiceDate" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Date :
                            </td>
                            <td>
                                <igsch:WebDateChooser ID="WebDateChooser1" runat="server" Width="202px" Format="Long"
                                    CssClass="drop_date">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Package :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Admin_Service_Package" runat="server" AutoPostBack="True"
                                    DataSourceID="SqlDataSource_Admin_Service_Package" DataTextField="AP_Name" DataValueField="ASP_ID">
                                </asp:DropDownList>
                                <asp:LinkButton ID="Label_Amount" runat="server"></asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Refer By :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Refer_By" runat="server" DataSourceID="SqlDataSource_Refer_By"
                                    DataTextField="Employee Name" DataValueField="EmpID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Refer Other :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_refer_other" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <asp:SqlDataSource ID="SqlDataSource_Admin_Service_Package" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT 0 AS ASP_ID, '' AS AP_Name UNION SELECT Admin_Service_Package.ASP_ID, Admin_Service_Package.AP_Name FROM Admin_Service_Package">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
                            <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payid" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_Refer_By" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT     '' AS [Employee Name], 0 AS EmpID
UNION
SELECT     ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name], EmpID
FROM         Employee
WHERE     (Is_Consultant=1)"></asp:SqlDataSource>
                </div>
                <br />
                <div style="height: 400px; overflow: auto; overflow-x: hidden;">
                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GridView2" runat="server" CssClass="Grid_1" Width="98%" DataSourceID="SqlDataSource_For_Grid"
                                AutoGenerateColumns="False" __designer:wfdid="w28">
                                <RowStyle CssClass="GridItem"></RowStyle>
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr #.">
                                        <ItemTemplate>
                                            &nbsp;&nbsp;&nbsp;
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:ButtonField CommandName="Select" Text="Service" DataTextField="S_Name" ></asp:ButtonField>
                                     <asp:TemplateField HeaderText="Qty" >
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtQty" Width="50px" Text="1"  TextMode="Number" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("S_Amount") %>' __designer:wfdid="w29"></asp:Label>
                                            <asp:TextBox ID="TextBox_Amount" runat="server" Width="50px" __designer:wfdid="w33"
                                                EnableViewState="true"></asp:TextBox>
                                            &nbsp;&nbsp;
                                            <br />
                                            <%--ontextchanged="TextBox_Amount_TextChanged" ></asp:TextBox>--%>
                                            <asp:Label ID="HiddenField_Edit_Status" runat="server" Text='<%# Bind("Edit_Status", "{0}") %>'
                                                __designer:wfdid="w34"></asp:Label>
                                            <asp:Label ID="HiddenFieldSID" runat="server" Text='<%# Bind("S_ID", "{0}") %>' __designer:wfdid="w35"></asp:Label>
                                            <asp:Label ID="HiddenFieldSAmount" runat="server" Text='<%# Bind("S_Amount", "{0}") %>'
                                                __designer:wfdid="w36"></asp:Label>
                                            <asp:HiddenField ID="hdnCompanyId" runat="server" Value='<%# Bind("Company_ID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   
                                    <asp:TemplateField HeaderText="Service Type" HeaderStyle-Width="100px" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRateType" runat="server" Text='<%# Bind("ServiceType") %>'> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                                <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    &nbsp;
                </div>
                <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="get_ServicesDepartmentWise" InsertCommand="Insert_Patient_services" InsertCommandType="StoredProcedure"
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="TextBox_Search_Service" DefaultValue="%" Name="S_Name"
                            PropertyName="Text" />
                        <asp:ControlParameter ControlID="DropDownList1" DefaultValue="%" Name="S_Category"
                            PropertyName="SelectedValue" Size="10" />
                        <asp:QueryStringParameter Name="Reg_No" QueryStringField="regno" />
                        <asp:QueryStringParameter Name="Yearly_No" QueryStringField="payid" />
                        <asp:ControlParameter ControlID="DropDownList_Admin_Service_Package" DefaultValue=""
                            Name="ASP_ID" PropertyName="SelectedValue" />
                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" Type="Int32" />
                        <asp:SessionParameter Name="Patient_Type_Id" SessionField="Patient_type_Id" Type="Int32" />
                        <asp:SessionParameter Name="IPD_OPD" SessionField="IPDOPD" Type="String" />
                        <asp:SessionParameter Name="Billing_Party_Id" SessionField="PatientBillingParty_Id"
                            Type="Decimal" />
                        <asp:SessionParameter Name="DeptID" SessionField="Dept_ID" Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                        <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                        <asp:ControlParameter Name="S_ID" Type="Int32" ControlID="HiddenField_SID" PropertyName="Value" />
                        <asp:ControlParameter Name="Amount" Type="Int32" ControlID="HiddenField_amount" PropertyName="Value" />                        
                        <asp:ControlParameter Name="PanelAmount" Type="Int32" ControlID="HiddenField_PanelAmount" PropertyName="Value" />
                        <asp:Parameter DefaultValue="0" Name="Payment_Status" Type="Int16" />
                        <asp:SessionParameter Name="SubDept_ID" SessionField="SubDeptID" Type="Int32" />
                        <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenFieldServiceDate" Name="sdatetime" PropertyName="Value"
                            Type="DateTime" />
                        <asp:ControlParameter ControlID="HiddenField_Qty" Name="Qty" PropertyName="Value"
                            Type="Double" />
                        <asp:Parameter Direction="Output" Name="msg" Size="100" Type="String" />
                        <asp:ControlParameter ControlID="DropDownList_Refer_By" Name="Refer_By_ID" PropertyName="SelectedValue"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenField_Refer_Other" Name="Refer_From_Other"
                            PropertyName="Value" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldSubDepartment" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Packages" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT DISTINCT CONVERT(varchar, Admin_Service_Category.Asc_id) AS Asc_id, Admin_Service_Category.Asc_Name
FROM            Admin_Service_Category INNER JOIN
                         Admin_Services ON Admin_Service_Category.Asc_id = Admin_Services.S_Category INNER JOIN
                         Admin_Dept_Services ON Admin_Services.S_ID = Admin_Dept_Services.S_ID
						 where Admin_Dept_Services.Dept_ID=@DeptID
ORDER BY  Asc_id,Asc_Name">
                   <SelectParameters>
                    <asp:SessionParameter Name="DeptID" SessionField="dept_id" Type="Int32" />
                       </SelectParameters>
                </asp:SqlDataSource>
                <br />

                <asp:HiddenField ID="HiddenField_Refer_Other" runat="server" />
            </td>
            <td valign="top" width="57%">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div >
                            <asp:Label ID="Label_msg" runat="server" ForeColor="Red"></asp:Label>
                            <br />
                            <asp:GridView Style="margin-left: 10px" ID="GridView_Date_Wise" runat="server" CssClass="Grid_1"
                                Width="96%" DataSourceID="SqlDataSource_Grid2" AutoGenerateColumns="False" ShowFooter="True"
                                DataKeyNames="ID,S_ID">
                                <RowStyle CssClass="GridItem"></RowStyle>
                                <Columns>
                                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
                                    <asp:TemplateField HeaderText="Time" SortExpression="TIme">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TIme") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("TIme") %>'></asp:Label>
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Payment_Status", "{0}") %>'>
                                            </asp:HiddenField>
                                            <asp:HiddenField ID="HiddenFieldID" runat="server" Value='<%# Bind("ID", "{0}") %>'>
                                            </asp:HiddenField>
                                            <%--<asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" Value='<%# Bind("Doctor_ID", "{0}") %>'>
                                            </asp:HiddenField>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Services" SortExpression="S_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("S_Name") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("S_Name") %>'></asp:Label>
                                            <%--<asp:Label ID="Label3" runat="server" Text='<%# Bind("S_Name2") %>'></asp:Label>--%>
                                            <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("S_ID") %>' />
                                            <asp:HiddenField ID="HiddenField_PartyId" runat="server" Value='<%# Bind("Billing_party_id") %>' />
                                            <asp:HiddenField ID="HiddenField_Patient_Value" runat="server" Value='<%# Bind("Patient_Value") %>' />
                                            <asp:HiddenField ID="HiddenField_SAmount" runat="server" Value='<%# Bind("S_Amount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>                                    
                                    <asp:TemplateField HeaderText="Charges" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCharges" runat="server" Text='<%# Eval("S_Amount") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Charges" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSAmount" runat="server" Text='<%# Bind("S_Amount") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownList_Doctor" runat="server" Width="100px" DataValueField="EmpID"
                                                DataTextField="Name"  AutoPostBack="true"
                                                Visible="False" OnSelectedIndexChanged="DropDownList_Doctor_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <cc1:ListSearchExtender ID="ListSearchExtender1" runat="server" TargetControlID="DropDownList_Doctor">
                                            </cc1:ListSearchExtender>
                                            <br />
                                            <asp:HiddenField ID="HiddenField_SID2" runat="server" Value='<%# Bind("S_ID", "{0}") %>'>
                                            </asp:HiddenField>
                                           
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" Visible="False">
                                    </asp:BoundField>
                                  <%--  <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="Label_day" runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Strikeout="True"></FooterStyle>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Discount Rs.">
                                        <FooterTemplate>
                                            <asp:Label ID="Discount_Label" runat="server" Text="Discount_Label"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDiscount" runat="server" Text='<%# Bind("Discount") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Patient Amount">
                                        <FooterTemplate>
                                            <asp:Label ID="Amount_Label" runat="server" Text="Amount_Label"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Patient_Value") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Panel Amount">
                                        <FooterTemplate>
                                            <asp:Label ID="lblPanelTotalFooter" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPanelAmount" runat="server" Text='<%# Bind("PanelAmount") %>' style="width:100px;"></asp:TextBox>                                            
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Discount" Visible="false">
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkDiscount" AutoPostBack="true" OnCheckedChanged="chkDiscount_CheckedChanged1" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" HeaderText="Delete">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="IBtn_Cancel" runat="server" CausesValidation="False" ImageUrl="~/images_hacims/icon_delete.gif"
                                                Text="Cancel" Visible='<%# Eval("Is_Paid") %>' OnClick="ImageButton1_Click" OnClientClick="&quot;return confirm('Are you sure you want delete');&quot;" />
                                            <asp:HiddenField ID="hf_id" runat="server" Value='<%# Eval("ID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblS_ID" runat="server" Text='<%# Bind("S_ID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="myfooter"></FooterStyle>
                                <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                                <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
                            </asp:GridView>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br /><br />
                 <div align="center">
                    <asp:Button ID="Button1" runat="server" CssClass="btn1" Text="Exit" Visible="False" />
                    <asp:Button ID="Button2" runat="server" CssClass="btn1" Text="Save & Exit" 
                        Visible="False" />
                    <asp:Button ID="Button_Payment" runat="server" CssClass="btn1" Text="Payment" TabIndex="-1" Visible="false" />
                    <asp:Button ID="btnUpdateServices" runat="server" CssClass="btn1" Text="Update" Visible="false"  />
                </div>
                <asp:SqlDataSource ID="SqlDataSource_Grid2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT     Patient_Services.S_ID, Patient_Services.Discount, Admin_Services.S_Name, Patient_Services.Amount AS S_Amount, CONVERT(varchar, Patient_Services.sdatetime, 107) AS Date, 
                      CONVERT(varchar, Patient_Services.sdatetime, 108) AS TIme, Patient_Services.ID, Patient_Services.Payment_Status, Admin_Services.S_ID AS Expr1, ISNULL(Patient_Services.Doctor_ID,0) as Doctor_ID, 
                      Admin_Services.S_Name AS S_Name2, ISNULL(Patient_Services.Qty, 1) AS Qty, CONVERT(bit, CASE WHEN Patient_Services.Order_Id IS NOT NULL THEN 0 ELSE 1 END) AS Is_Paid, 
                      isnull(Payment.Billing_party_id,0) as Billing_party_id,isnull(Patient_Services.Patient_Value,0) as Patient_Value,isnull(Patient_Services.PanelAmount,0) as PanelAmount
FROM         Payment INNER JOIN
                      Admin_Services INNER JOIN
                      Patient_Services ON Admin_Services.S_ID = Patient_Services.S_ID ON Payment.PayID = Patient_Services.YearlyNo LEFT OUTER JOIN
                      Test_Booking ON Admin_Services.S_ID = Test_Booking.S_Id
WHERE     (Patient_Services.RegNo = @RegNo) AND (Patient_Services.YearlyNo = @YearlyNo) 
AND (Patient_Services.Payment_Status = 0) AND (Patient_Services.Order_Id IS NULL)
ORDER BY Date DESC, time DESC" DeleteCommand="DELETE FROM Patient_Services WHERE (ID = @ID) 
delete from Discount_Sub where ID=@ID">
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="HiddenField_ID" Name="ID" PropertyName="Value" />
                    </DeleteParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_ID" runat="server" />
                <asp:Label ID="Label_count" runat="server" CssClass="err"></asp:Label>
                <asp:HiddenField ID="HiddenFieldS_ID" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceDeleteProcedure" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                </asp:SqlDataSource>
                <br />
                <asp:SqlDataSource ID="SqlDataSource_For_Grid_Services" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT Admin_Services.S_Name, Admin_Services.S_Amount, CONVERT (varchar, Patient_Services.sdatetime, 107) AS Date, CONVERT (varchar, Patient_Services.sdatetime, 108) AS TIme, Patient_Services.Payment_Status FROM Patient_Services INNER JOIN Admin_Services ON Patient_Services.S_ID = Admin_Services.S_ID WHERE (Patient_Services.RegNo = @RegNo) AND (Patient_Services.YearlyNo = @YearlyNo) ORDER BY Admin_Services.S_Name">
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_amount" runat="server" />
                 <asp:HiddenField ID="HiddenField_Qty" runat="server" />
                <asp:HiddenField ID="HiddenField_PanelAmount" runat="server" />
                <%--<asp:HiddenField ID="HiddenField_PatientValue" runat="server" />--%>

                <asp:HiddenField ID="HiddenField_SID" runat="server" />
               
                
                <asp:HiddenField ID="HiddenField_Flag" runat="server" Value="0" />
                <asp:HiddenField ID="HiddenFieldDID" runat="server" Value="0" />
                <br />
                <asp:HiddenField ID="hidRegNo" runat="server" />
                <asp:HiddenField ID="HidYearlyNo" runat="server" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource runat="server" ID="sdsForDiscountUpdate" UpdateCommand="UPDATE Patient_Services SET  Discount = 0 WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (S_ID = @S_ID) AND (ID = @ID)"
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        InsertCommand="Set_Service_discount" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:QueryStringParameter Name="yearlyNo" QueryStringField="payid" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
            <asp:Parameter Name="S_id" Type="Int32" />
            <asp:SessionParameter Name="Hospital_Id" SessionField="Hospitalid" Type="Int32" />
            <asp:Parameter Name="Amount" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payid" />
            <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
            <asp:ControlParameter ControlID="hdfS_ID" Name="S_ID" PropertyName="Value" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
    <asp:HiddenField runat="server" ID="hdfS_ID" />
</asp:Content>
