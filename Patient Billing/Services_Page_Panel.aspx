<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/Patient Billing/Services_Page_Panel.aspx.vb" MasterPageFile="~/hacims_masterpage_billing.master"
    Inherits="Patient_Registration_Services_Page" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
            <td valign="top" width="15%">
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
                <div class="bxmain inner_content" style="width:92%; margin-top:20px;">
                    <h2><span>Search Services</span></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr style="display: none">
                            <td align="right">MR. #</td>
                            <td width="61%" align="left">
                                <asp:Label ID="lbl_Mr_No" runat="server" ForeColor="Red"></asp:Label>
                                <br />
                                <asp:TextBox ID="TXT_Load_patient" runat="server" AutoPostBack="true" CssClass="input_txt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Categories:
                            </td>
                            <td width="61%" align="left">
                                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Packages"
                                    DataTextField="Asc_Name" DataValueField="Asc_id">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Search Services :
                            </td>
                            <td>
                                <asp:UpdatePanel ID="pnlSearchService" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox CssClass="input_txt" ID="TextBox_Search_Service" runat="server" Width="200px"
                                            AutoPostBack="True"></asp:TextBox>
                                        <%--                                        <cc1:AutoCompleteExtender ID="AutoComplete_Complaint" runat="server" CompletionInterval="10"
                                            CompletionSetCount="12" EnableCaching="true" UseContextKey="true" MinimumPrefixLength="3"
                                            ServiceMethod="Search_Services_OPD" ServicePath="../AutoComplete.asmx" TargetControlID="TextBox_Search_Service">
                                        </cc1:AutoCompleteExtender>--%>
                                       
                                    </ContentTemplate>
                                     
                                </asp:UpdatePanel>
                                <asp:Label ID="LabelAmountError" runat="server" CssClass="err" Visible="False"></asp:Label>
                                <asp:HiddenField ID="HiddenFieldServiceDate" runat="server" />
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right">Date :
                            </td>
                            <td>
                                <igsch:WebDateChooser ID="WebDateChooser1" runat="server" Width="202px" Format="Long"
                                    CssClass="drop_date">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                        </tr>
                        <tr runat="server" id="pkg" style="display:contents">
                            <td align="right">Package :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Admin_Service_Package" runat="server" Visible="true" AutoPostBack="True" 
                                    DataSourceID="SqlDataSource_Patient_Package" DataTextField="AP_Name" DataValueField="ASP_ID">
                                </asp:DropDownList>
                                <asp:LinkButton ID="lnkPackage" Text="Assign Package" runat="server"></asp:LinkButton>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right">Refer By :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Refer_By" runat="server" DataSourceID="SqlDataSource_Refer_By"
                                    DataTextField="Employee Name" DataValueField="EmpID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right">Refer Other :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_refer_other" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <asp:SqlDataSource ID="SqlDataSource_Patient_Package" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="select '0' as ASP_ID,'' as AP_Name
                        union
                        SELECT     AP.ASP_ID,AP.AP_Name  AS AP_Name
                        FROM         Admin_Service_Package AP
                        JOIN Patient_Package_Selected PP ON PP.PackageID=AP.ASP_ID
                        WHERE PP.VisitNo=@YearlyNo">
                        <SelectParameters>                            
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
                <div style="text-align: center">
                    <asp:Button  ID="btnSaveCheckedServices" runat="server" Text="Save Services" />
                </div>
                <div style="height: 350px;margin-top:1.5%; overflow: auto; overflow-x: hidden; width:350px;">
                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GridView2" runat="server" CssClass="Grid_1" Width="98%" DataSourceID="SqlDataSource_For_Grid"
                                AutoGenerateColumns="False">
                                <RowStyle CssClass="GridItem"></RowStyle>
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            &nbsp;&nbsp;&nbsp;
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:ButtonField CommandName="Select" DataTextField="S_Name"></asp:ButtonField>
                                    <asp:TemplateField HeaderText="Qty">
                                        <ItemTemplate>
                                            <asp:TextBox Width="25px" SkinID="intdata" runat="server" Text="1" ID="txtboxQty"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                        <asp:HiddenField ID="hdfPaSID" runat="server" Value='<%# Bind("SubID", "{0}") %>' />
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("S_Amount") %>' __designer:wfdid="w29"></asp:Label>
                                            <asp:TextBox ID="TextBox_Amount" runat="server" Width="50px"
                                                __designer:wfdid="w33" EnableViewState="true" Enabled='<%# Bind("Edit_Status", "{0}") %>'></asp:TextBox>
                                            &nbsp;&nbsp;
                                            <br />
                                            <%--ontextchanged="TextBox_Amount_TextChanged" ></asp:TextBox>--%>
                                            <asp:Label ID="HiddenField_Edit_Status" runat="server" Text='<%# Bind("Edit_Status", "{0}") %>'
                                                __designer:wfdid="w34"></asp:Label>
                                            <asp:Label ID="HiddenFieldSID" runat="server" Text='<%# Bind("S_ID", "{0}") %>'></asp:Label>
                                            <asp:Label ID="HiddenFieldSAmount" runat="server" Text='<%# Bind("S_Amount", "{0}") %>'>
                                                <asp:HiddenField ID="hdfDiscountPer" runat="server" Value='<%# Bind("Discount_Percentage", "{0}") %>' />
                                                
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Discount_Percentage" HeaderText="Dis. (%)" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkbox" runat="server"  />
                                        </ItemTemplate>
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkboxAll" runat="server" AutoPostBack="true" 
                                                oncheckedchanged="chkboxAll_CheckedChanged"  />
                                        </HeaderTemplate>
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
                    SelectCommand="get_Services_Panel" InsertCommand="Insert_Patient_services_Panel" InsertCommandType="StoredProcedure"
                    SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
                    <SelectParameters>
                        <asp:ControlParameter Name="packageID" ControlID="DropDownList_Admin_Service_Package" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="TextBox_Search_Service" DefaultValue="%" Name="S_Name"
                            PropertyName="Text" />
                        <asp:ControlParameter ControlID="DropDownList1" DefaultValue="%" Name="S_Category"
                            PropertyName="SelectedValue" Size="10" />
                        <asp:QueryStringParameter Name="Reg_No" QueryStringField="regno" />
                        <asp:QueryStringParameter Name="Yearly_No" QueryStringField="payid" />
                        <asp:ControlParameter ControlID="DropDownList_Admin_Service_Package" DefaultValue=""
                            Name="ASP_ID" PropertyName="SelectedValue" />
                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" Type="Int32" />
                        <asp:SessionParameter Name="Patient_Type_Id" SessionField="Patient_type_Id" DefaultValue="0" Type="Int32" />
                        <asp:SessionParameter Name="IPD_OPD" SessionField="IPDOPD" Type="String"  DefaultValue=""/>
                        <asp:SessionParameter Name="Billing_Party_Id" SessionField="BillingParty_Id" DefaultValue="0"
                            Type="Decimal" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                        <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                        <asp:ControlParameter Name="S_ID" Type="Int32" ControlID="HiddenField_SID" PropertyName="Value" />
                        <asp:ControlParameter Name="Amount" Type="Int32" ControlID="HiddenField_amount" PropertyName="Value" />
                        <asp:Parameter DefaultValue="0" Name="Payment_Status" Type="Int16" />
                        <asp:SessionParameter Name="SubDept_ID" SessionField="SubDeptID" Type="Int32" />
                        <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />                        
                        <asp:ControlParameter ControlID="HiddenField_Qty" Name="Qty" PropertyName="Value" Type="Double" />
                        <asp:Parameter Direction="Output" Name="msg" Size="100" Type="String" />
                        <asp:ControlParameter ControlID="DropDownList_Refer_By" Name="Refer_By_ID" PropertyName="SelectedValue" Type="Int32" />                         
                        <asp:ControlParameter ControlID="DropDownList_Admin_Service_Package" Name="PackageId" PropertyName="SelectedValue"
                            Type="Int32" DefaultValue="0" />
                        <asp:ControlParameter ControlID="HiddenField_Refer_Other" Name="Refer_From_Other" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="0" Name="SubID" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldSubDepartment" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Packages" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT 0 AS Asc_id, ' All' AS Asc_Name UNION SELECT CONVERT (varchar, Asc_id) AS Asc_id, Asc_Name FROM Admin_Service_Category WHERE (hospital_id = @hospital_id) AND Active=1 ORDER BY Asc_Name">
                    <SelectParameters>
                        <asp:SessionParameter Name="hospital_id" SessionField="hospitalid" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:HiddenField ID="HiddenField_Qty" runat="server" />
                <asp:HiddenField ID="HiddenField_Refer_Other" runat="server" />
            </td>
            <br>
            <td valign="top"  width="60%">
             <div style="text-align:center; width:100%;">
                               
                                <asp:Button ID="btnShowLimitPage" runat="server" Text="Add Patient Limit" 
                                 CausesValidation="false"/>
                            </div>
                            
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div>
                            <asp:Label ID="Label_msg" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
                            <br />
                            <asp:Panel ID="pnlAmountDis" runat="server" Visible="false">
                                <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                    <tr>
                                        <td align="right" width="25%">
                                            Limit : 
                                        </td>
                                        <td align="left" width="15%">
                                            <asp:TextBox ID="txtAmountDis" runat="server" ></asp:TextBox>
                                        </td>
                                        <td align="right" width="25%">
                                            &nbsp;
                                        </td>
                                        <td align="left" width="25%">
                                            <asp:Button ID="btnDivide" runat="server" Text="Divide" />
                                           
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <br />
                           
                            <asp:GridView Style="margin-left: 10px" ID="GridView_Date_Wise" runat="server" CssClass="Grid_1"
                                Width="96%" DataSourceID="SqlDataSource_Grid2" AutoGenerateColumns="False" ShowFooter="True"
                                DataKeyNames="ID,S_ID">
                                <RowStyle CssClass="GridItem"></RowStyle>
                                <Columns>
                                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
                                    <asp:TemplateField HeaderText="Time" SortExpression="Time" Visible="false">

                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Time") %>'></asp:Label>
                                            
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Services" SortExpression="S_Name">

                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("S_Name") %>'></asp:Label>

                                            <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("S_ID") %>'></asp:HiddenField>
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Payment_Status", "{0}") %>'></asp:HiddenField>
                                            <asp:HiddenField ID="HiddenFieldID" runat="server" Value='<%# Bind("ID", "{0}") %>'></asp:HiddenField>
                                            <asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" Value='<%# Bind("Doctor_ID", "{0}") %>'></asp:HiddenField>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   <%-- <asp:TemplateField HeaderText="Charges">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSAmount" runat="server" Text='<%# Eval("S_Amount", "{0}") %>'></asp:Label>
                                        </ItemTemplate>
                                        
                                    </asp:TemplateField>--%>
                                    <asp:BoundField DataField="S_Amount" HeaderText="Charges" SortExpression="S_Amount">
                                        <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SystemDiscount" HeaderText="System Discount"
                                        SortExpression="SystemDiscount">
                                        <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ManualDiscount" HeaderText="Manual Discount"
                                        SortExpression="ManualDiscount">
                                        <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Doctors">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownList_Doctor" runat="server" Width="100px" DataValueField="EmpID"
                                                DataTextField="Name" AutoPostBack="True"
                                                OnSelectedIndexChanged="DropDownList_Doctor_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <br />
                                            <asp:HiddenField ID="HiddenField_SID2" runat="server" Value='<%# Bind("S_ID", "{0}") %>'></asp:HiddenField>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" ></asp:BoundField>
                                    <asp:TemplateField HeaderText="Panel Amount">
                                        <FooterTemplate>
                                            <asp:Label ID="lblPanelTotalFooter" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPanelAmount" runat="server" Text='<%# Bind("PanelAmount") %>' Style="width: 100px;" ></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Patient Amount">
                                        <FooterTemplate>
                                            <asp:Label ID="lblPatientTotalFooter" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblPatientValue" runat="server" Text='<%# Bind("Patient_Value") %>' Style="width: 100px;" ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="Label_day" runat="server"></asp:Label>
                                        </ItemTemplate>
                                        
                                        <FooterStyle HorizontalAlign="Right" Font-Size="Larger" Font-Bold="True"></FooterStyle>
                                       </asp:TemplateField>

                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="IBtn_Cancel" runat="server" CausesValidation="False"
                                                ImageUrl="~/images_hacims/icon_delete.gif" Text="Cancel"
                                                Visible='<%# Eval("Is_Paid") %>' OnClick="ImageButton1_Click"
                                                OnClientClick="&quot;return confirm('Are you sure you want delete');&quot;" />
                                            <asp:HiddenField ID="hf_id" runat="server" Value='<%# Eval("ID") %>' />
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
                <asp:SqlDataSource ID="SqlDataSource_Grid2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="GetPanelPatientServices" SelectCommandType="StoredProcedure"
                    DeleteCommand="DELETE FROM Patient_Services WHERE (ID = @ID);DELETE FROM Discount_Sub WHERE (ID = @ID); ">
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
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"></asp:SqlDataSource>
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
                <asp:HiddenField ID="HiddenField_SID" runat="server" />

                <div align="center">
                    <asp:Button ID="Button1" runat="server" CssClass="btn1" Text="Exit" Visible="False" />
                    <asp:Button ID="Button2" runat="server" CssClass="btn1" Text="Save & Exit" Visible="false" />
                    <asp:Button ID="Button_Payment" runat="server" CssClass="btn1" Text="Payment"
                        TabIndex="-1" />
                    <asp:Button ID="btnUpdateServices" runat="server" CssClass="btn1" Text="Update"  />
                </div>
                <br />
                <br />
                <asp:HiddenField ID="HiddenField_Flag" runat="server" Value="0" />
                <asp:HiddenField ID="HiddenFieldDID" runat="server" Value="0" />
                <br />
                <asp:HiddenField ID="hidRegNo" runat="server" />
                <asp:HiddenField ID="HidYearlyNo" runat="server" />
            </td>
        </tr>
    </table>
    <br />
    <div class="=lightbox_bg">
        <asp:Panel ID="panel_Package" class="lightbox" Style="width:400px; height: 200px !important" runat="server"
            Visible="false">
            <div>
                <table>
                    <tr>
                        <td align="right" width="35%">Package :
                        </td>
                        <td>
                            <asp:DropDownList ID="DDL_Package" runat="server" AutoPostBack="True"
                                DataSourceID="SqlDataSource_Admin_Service_Package" DataTextField="AP_Name" DataValueField="ASP_ID">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource_Admin_Service_Package" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT     Admin_Service_Package.ASP_ID,
                                        Admin_Service_Package.AP_Name AS AP_Name
                                        FROM         Admin_Service_Package  ">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
                            <asp:QueryStringParameter Name="YearlyNo" QueryStringField="payid" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
                <div style="text-align: center; margin-top: 1%">
                    <asp:Button ID="btnSave" runat="server" Text="Save Package" />
                    <asp:Button ID="btnPrevious" runat="server" Text="Close" />
                    <br />
                    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
