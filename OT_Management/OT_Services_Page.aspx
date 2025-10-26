<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/OT_Management/OT_Services_Page.aspx.vb" MasterPageFile="~/hacims_masterpage_billing.master"
    Inherits="OT_Management_OT_Services_Page" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <script language="javascript" type="text/javascript">
        function OpenWindow() {
            var RegNo = document.getElementById("hidRegNo").value;
            var YearlyNo = document.getElementById("HidYearlyNo").value;
            window.open('Mark_Test_For_Pathology.aspx?registrationNo=' + RegNo + '&YearlyNo=' + YearlyNo, '', 'toolbar=none,width=1000,y=10,x=10');
        }
    </script>
    <script type="text/javascript">
        function confirmationLab() {
            if (confirm('Are you sure to forward Lab & Radiology Test ?')) {
                return true;
            } else {
                return false;
            }
        }
   </script>
    <script type="text/javascript">
        function clientShowing(source, args) {
            source._popupBehavior._element.style.zIndex = 100000;
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
            <td valign="top" width="43%">
                <asp:HiddenField ID="HiddenField_Previous_index" runat="server" Value="-1" />
                <asp:UpdateProgress ID="updProgress" runat="server">
                    <ProgressTemplate>
                        <div style="position: absolute; left: 118%; top: 40%;">
                            <img alt="progress" src="../images/ajaxloader.gif" width="40PX" />
                            <br />
                            Processing...
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
               <div class="bxmain inner_content" style="width:99%; margin-top:25px;">
                    <h2><span>Search Service(s)</span></h2>
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
                                Cost Center:</td>
                            <td width="61%" align="left">
                                <asp:DropDownList ID="DDLCostCenter"  runat="server" AutoPostBack="True"  >
                                </asp:DropDownList>
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
                                            ></asp:TextBox>
                                        <cc1:AutoCompleteExtender ID="AutoComplete_Complaint" runat="server" CompletionInterval="10"
                                            CompletionSetCount="12" EnableCaching="true" UseContextKey="true" MinimumPrefixLength="2"
                                            ServiceMethod="SearchItems"  TargetControlID="TextBox_Search_Service">
                                        </cc1:AutoCompleteExtender>
                                        <asp:Button ID="searchbtn" runat="server" Text="Search" OnClick="searchbtn_Click" /> 
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
                                <td align="right"  >
                                    Search Package :
                                </td>
                                <td  >
                                    <asp:TextBox ID="txtHeadName" runat="server" OnTextChanged="btnSearch_Click"   AutoPostBack="true" Width="62%"></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="Auto_Names_Extender"   runat="server" ServiceMethod="SearchPackages"
                        MinimumPrefixLength="2" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtHeadName" FirstRowSelected="true" OnClientShowing="clientShowing" ></asp:AutoCompleteExtender>
                                    <asp:Button Visible="false" Text="Search" OnClick="btnSearch_Click" ID="btnSearch" runat="server" />
                                </td>
                            </tr>
                        <tr>
                            <td align="right">
                                Package :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Admin_Service_Package" runat="server" AutoPostBack="True"
                                      DataTextField="AP_Name" DataValueField="ASP_ID">
                                </asp:DropDownList>


                                <asp:LinkButton ID="lnkrpt" Text="Recommended " OnClick="lnkrpt_Click" runat="server"></asp:LinkButton>
                                <asp:LinkButton ID="Label_Amount" runat="server"></asp:LinkButton>
                                <asp:LinkButton ID="lnkPackage"  Visible="false" Text="Assign Package" runat="server"></asp:LinkButton>
                            </td>
                        </tr>
                        <tr style="display:none" >
                            <td align="right">
                                Refer By :
                            </td>
                            <td >
                                <asp:DropDownList ID="DropDownList_Refer_By" runat="server" DataSourceID="SqlDataSource_Refer_By"
                                    DataTextField="Employee Name" DataValueField="EmpID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="display:none">
                            <td align="right">
                                Refer Other :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_refer_other" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                         <tr  >
                            <td align="right">
                                Level :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlLevels" runat="server" DataSourceID="SqlDataSourceLevels"
                                    DataTextField="Level_Name" DataValueField="Level_ID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                       
                    <asp:SqlDataSource ID="SqlDataSource_Admin_Service_Package" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                       SelectCommand="SELECT 0 as ASP_ID,'' as  AP_Name UNION SELECT     Admin_Service_Package.ASP_ID, Admin_Service_Package.AP_Name AS AP_Name  FROM         Admin_Service_Package --join Patient_Package_Selected on Patient_Package_Selected.PackageID=Admin_Service_Package.ASP_ID where Patient_Package_Selected.VisitNo=@visitno --SELECT     Admin_Service_Package.ASP_ID, Admin_Service_Package.AP_Name AS AP_Name  FROM         Admin_Service_Package where HospitalId=@Hospital_Id ">
                        <SelectParameters>
                            <%--<asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />--%>
                           
                            <asp:QueryStringParameter Name="visitno" QueryStringField="payid" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                   
                    <asp:SqlDataSource ID="SqlDataSource_Refer_By" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT     '' AS [Employee Name], 0 AS EmpID
UNION
SELECT    LTRIM(RTRIM(ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, ''))) AS [Employee Name], EmpID
FROM         Employee
WHERE     (Is_Consultant=1)
                        Order By [Employee Name]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceLevels" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT   [Level_ID] ,[Level_Name] FROM [BasicDataInfo].[dbo].[Packages_Level]"></asp:SqlDataSource>
                </div>
                <br />
                <div style="text-align: right">
                    <asp:Button Visible="false" ID="btnSaveCheckedServices" runat="server" Text="Save Services" />
                </div>
                <div style="height: 400px; overflow: auto; overflow-x: hidden;">
                       <asp:HiddenField ID="hfdBindStatus" runat="server" />
                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                        <ContentTemplate>
                            
                            <asp:GridView ID="GridView2" runat="server" CssClass="Grid_1" Width="98%" DataSourceID="SqlDataSource_For_Grid"
                                AutoGenerateColumns="False" >
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
                                   <asp:TemplateField Visible="false">
                                       <ItemTemplate>
                                           <asp:DropDownList ID="ddlPrePost" runat="server" Width="50px">
                                               <asp:ListItem Text="" Selected="True" Value=""></asp:ListItem>
                                               <asp:ListItem Text="PRE" Value="PRE"></asp:ListItem>
                                               <asp:ListItem Text="POST" Value="POST"></asp:ListItem>
                                           </asp:DropDownList>
                                       </ItemTemplate>
                                   </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Service Type" HeaderStyle-Width="100px" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRateType" runat="server" Text='<%# Bind("ServiceType") %>'> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px" />
                                    </asp:TemplateField>
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
                    SelectCommand="get_Services" InsertCommand="Insert_Patient_services_OTNew" InsertCommandType="StoredProcedure"
                    SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
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
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="DoctorId" Type="Int32" />
                        <asp:ControlParameter ControlID="DDLCostCenter" Name="CostCenter" PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="PrePost" Type="String" DefaultValue="" />
                         <asp:ControlParameter ControlID="ddlLevels"  Name="level_id"       PropertyName="SelectedValue"  Type="Int32" />
                         <asp:ControlParameter ControlID="DropDownList_Admin_Service_Package"   Name="package_id"
                            PropertyName="SelectedValue" Type="Int32"/>
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldSubDepartment" runat="server" />
               <asp:SqlDataSource ID="SqlDataSource_Packages" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="usp_GetCategoryServices" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DDLCostCenter" Name="Cost_Center_Id" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="SdsCategoryAll" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="usp_GetCategoryServicesALL" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DDLCostCenter" Name="Cost_Center_Id" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />

                <asp:HiddenField ID="HiddenField_Refer_Other" runat="server" />
            </td>
            <td valign="top" width="57%">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div >
                            <asp:Label ID="Label_msg" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                            <asp:Label ID="errorlbl" runat="server" Text="" ForeColor="Red" Font-Bold="true" ></asp:Label>
                      
                            <br />
                              <table>

                              </table>




                            <table class="diagnosis_list">
                                <tr  >
                                    <td align="right"><strong>Time In :</strong></td>
                                    <td>
                                        <asp:TextBox ID="TextBox_Timein" runat="server" TextMode="Time" Width="100px" Font-Bold="True"></asp:TextBox>
                                        </td>
                                    <td align="right"><strong>Time Out :</strong></td>
                                    <td>
                                        <asp:TextBox ID="TextBox_Timeout" runat="server"  TextMode="Time"  Width="100px" Font-Bold="True"></asp:TextBox>
                                        </td>
                                    <td style="display:none;" align="right"><strong>Bed # :</strong></td>
                                    <td>
                                        <asp:TextBox ID="TextBox_BedNo" runat="server"  Width="100px" Font-Bold="True" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                               
                                  <tr  >
                                    <td style="display:none" align="right"><strong>Surgeon :</strong></td>
                                       <td style="display:none">
                                           <asp:DropDownList ID="DDLConsultant" runat="server"></asp:DropDownList>
                                        </td>
                                    <td align="right"><strong>Serub Person  :</strong></td>
                                    <td>
                                        <asp:TextBox ID="TextBox_SerubPerson" runat="server"  Width="100px" Font-Bold="True"></asp:TextBox>
                                        </td>
                                    <td align="right"><strong>Circulator :</strong></td>
                                    <td>
                                        <asp:TextBox ID="TextBox_Circulator" runat="server"  Width="100px" Font-Bold="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <strong>OT Number  :</strong>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOTNumber" runat="server" Width="100px" Font-Bold="True"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                           
                            <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                <tr>
                                    <td align="right" style="display:none">Category : </td>
                                    <td align="left" style="display:none">
                                        <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" DataSourceID="SdsCategoryAll" DataTextField="Asc_Name" DataValueField="Asc_id" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <div align="center">
                                            <div id="DIV_P_Payment" runat="server">
                                                <asp:Button ID="Button_lab_Test" runat="server" OnClientClick="return confirmationLab();" Text="Forward To LAB / Radiology " Visible="False" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <asp:GridView ID="GridView_Date_Wise" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" DataKeyNames="ID,S_ID" DataSourceID="SqlDataSource_Grid2" ShowFooter="True" Style="margin-left: 10px" Width="96%">
                                <RowStyle CssClass="GridItem" />
                                <Columns>
                                    <asp:BoundField DataField="Date" HeaderStyle-Width="10%" ItemStyle-Width="10%"  HeaderText="Date" SortExpression="Date" >
                                    <ControlStyle Width="70px" />
                                    <HeaderStyle Width="100px" />
                                    </asp:BoundField>
                                    <asp:TemplateField Visible="false" HeaderText="Time" SortExpression="TIme">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TIme") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("TIme") %>'></asp:Label>
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Payment_Status", "{0}") %>' />
                                           
                                            <%--<asp:HiddenField ID="HiddenField_Doctor_ID" runat="server" Value='<%# Bind("Doctor_ID", "{0}") %>'>
                                            </asp:HiddenField>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Services" HeaderStyle-Width="165px" SortExpression="S_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" Width="60px" runat="server" Text='<%# Bind("S_Name") %>'></asp:TextBox>
                                             
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                              <span style="    background-color: yellow;width: 165px;text-align: center;float: left;">
                                            <asp:Label ID="lblPackageName" runat="server" Text='<%# Eval("AP_Name") %>' Font-Bold="true" Font-Size="Larger" ForeColor="Blue"></asp:Label>
                                                  <asp:HiddenField ID="HiddenFieldID" runat="server" Value='<%# Eval("ID")%>' />
                                           </span>
                                                 <br />
                                            <br />
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("S_Name") %>'></asp:Label>
                                            <%--<asp:Label ID="Label3" runat="server" Text='<%# Bind("S_Name2") %>'></asp:Label>--%>
                                            <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("S_ID") %>' />
                                            <asp:HiddenField ID="HiddenField_PartyId" runat="server" Value='<%# Bind("Billing_party_id") %>' />
                                            <asp:HiddenField ID="HiddenField_Patient_Value" runat="server" Value='<%# Bind("Patient_Value") %>' />
                                            <asp:HiddenField ID="HiddenField_SAmount" runat="server" Value='<%# Bind("S_Amount") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Width="165px" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Charges" Visible="false" HeaderStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCharges" runat="server" Text='<%# Eval("S_Amount") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                       <asp:TemplateField HeaderStyle-Width="20%" ItemStyle-Width="20%">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownList_Doctor" runat="server" AutoPostBack="true" DataTextField="Name" DataValueField="EmpID" OnSelectedIndexChanged="DropDownList_Doctor_SelectedIndexChanged" Visible="False" Width="100px">
                                            </asp:DropDownList>
                                            <cc1:ListSearchExtender ID="ListSearchExtender1" runat="server" TargetControlID="DropDownList_Doctor">
                                            </cc1:ListSearchExtender>
                                            <br />
                                            <asp:HiddenField ID="HiddenField_SID2" runat="server" Value='<%# Bind("S_ID", "{0}") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Width="30px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Charges" HeaderStyle-Width="10%" ItemStyle-Width="10%" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSAmount" runat="server" Text='<%# Bind("S_Amount") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblfinaltotal" Text="0" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <HeaderStyle Width="80px" />
                                    </asp:TemplateField>
                                 
                                    <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" Visible="true" HeaderStyle-Width="5%" ItemStyle-Width="5%"/>
                                    <%--  <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="Label_day" runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Strikeout="True"></FooterStyle>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField  HeaderText="Discount %">
                                        
                                        <ItemTemplate>
                                            <asp:Label ID="lblDiscountPer" runat="server" Text='<%# Bind("DesPer") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false" HeaderText="Discount Rs.">
                                        <FooterTemplate>
                                            <asp:Label ID="Discount_Label" runat="server" Text="Discount_Label"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDiscount" runat="server" Text='<%# Bind("Discount") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField  HeaderText="Actual Amount">
                                        <FooterTemplate >
                                            <asp:Label Visible="false" ID="lblsumtotalcharges" runat="server" Text=""></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotalcharges" runat="server" Text='<%# Bind("totalcharges")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField Visible="false" HeaderText="Patient Amount">
                                        
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Patient_Value") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false" HeaderText="Panel Amount">
                                        <FooterTemplate>
                                            <asp:Label ID="lblPanelTotalFooter" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPanelAmount" runat="server" style="width:100px;" Text='<%# Bind("PanelAmount") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Discount" Visible="false">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkDiscount" runat="server" AutoPostBack="true" OnCheckedChanged="chkDiscount_CheckedChanged1" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ShowHeader="False" HeaderStyle-Width="5%" ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="IBtn_Cancel" runat="server" CausesValidation="False" ImageUrl="~/images_hacims/icon_delete.gif" OnClick="ImageButton1_Click" OnClientClick="&quot;return confirm('Are you sure you want delete');&quot;" Text="Cancel" Visible='<%# Eval("Is_Paid") %>' />
                                            <asp:HiddenField ID="hf_id" runat="server" Value='<%# Eval("ID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="50px" Visible="false">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="CheckBox_Header" runat="server" AutoPostBack="True" Enabled="true" OnCheckedChanged="CheckBox_Header_CheckedChanged" />
                                            <br />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("IsForwarded") %>' Enabled='<%# Eval("Is_Paid") %>' OnCheckedChanged="CheckBox1_CheckedChanged" />
                                            <asp:HiddenField ID="Hf_IsForwarded" runat="server" Value='<%# Eval("IsForwarded")%>' />
                                            <asp:HiddenField ID="Hf_ServiceCategory" runat="server" Value='<%# Eval("S_Category")%>' />
                                            <asp:HiddenField ID="Hf_OrderId" runat="server" Value='<%# Eval("Order_Id")%>' />
                                            <asp:HiddenField ID="hf_SID" runat="server" Value='<%# Eval("S_ID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblS_ID" runat="server" Text='<%# Bind("S_ID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="myfooter" BackColor="#CCFF99" BorderStyle="Solid" />
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                           

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br /><br />
                 <div align="center">
                    <asp:Button ID="Button1" runat="server" CssClass="btn1" Text="Exit" Visible="False" />
                    <asp:Button ID="Button2" runat="server" CssClass="btn1" Text="Save & Exit" 
                        Visible="False" />
                    <asp:Button ID="Button_Payment" runat="server" Visible="false" CssClass="btn1" Text="Payment" TabIndex="-1" />
                    <asp:Button ID="btnUpdateServices" runat="server" CssClass="btn1" Text="Update"  />
                     <asp:Button ID="Button3" runat="server"   CssClass="btn1" Text="Report" OnClick="Button3_Click" TabIndex="-1" />
                </div>
                <asp:SqlDataSource ID="SqlDataSource_Grid2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT  Patient_Services.ID, sub.Rate as totalcharges,    Patient_Services.S_ID,   (sub.Rate-Patient_Services.Amount)  as  Discount,cast(100- Round((Patient_Services.Amount/sub.Rate) *100,2) as varchar)+' %' as DesPer,
                                 case when Admin_Services.S_Name in (Select Ap_Name from Admin_Service_Package) then 'Surgeon Fee' else  Case When ISNULL(Patient_Services.PrePost,'')='' Then Admin_Services.S_Name 
                                    Else Admin_Services.S_Name +' - '+Patient_Services.PrePost End END S_Name, Patient_Services.Amount AS S_Amount, CONVERT(varchar, Patient_Services.sdatetime, 107) AS Date, 
                      CONVERT(varchar, Patient_Services.sdatetime, 108) AS TIme, Patient_Services.ID, Patient_Services.Payment_Status, Admin_Services.S_ID AS Expr1, ISNULL(Patient_Services.Doctor_ID,0) as Doctor_ID, 
                      Admin_Services.S_Name AS S_Name2, ISNULL(Patient_Services.Qty, 1) AS Qty, CONVERT(bit, CASE WHEN Patient_Services.Order_Id IS NOT NULL THEN 0 ELSE 1 END) AS Is_Paid, 
                      isnull(Payment.Billing_party_id,0) as Billing_party_id,isnull(Patient_Services.Patient_Value,0) as Patient_Value,isnull(Patient_Services.PanelAmount,0) as PanelAmount,
                    CONVERT(bit, CASE WHEN Patient_Services.Order_Id IS NOT NULL THEN 1 ELSE 0 END) AS IsForwarded,Admin_Services.S_Category,isnull(Patient_Services.Order_Id,0) As Order_Id
                   ,isnull(Admin_Service_Package.ASP_ID,10000) ASP_ID,isnull(Admin_Service_Package.AP_Name,'Others') AP_Name
FROM         Payment INNER JOIN
                      Admin_Services INNER JOIN
                      Patient_Services ON Admin_Services.S_ID = Patient_Services.S_ID ON Payment.PayID = Patient_Services.YearlyNo LEFT OUTER JOIN
                      Test_Booking ON Admin_Services.S_ID = Test_Booking.S_Id 
                    left join Admin_Service_Package on Admin_Service_Package.ASP_ID=Patient_Services.ASP_ID
					 left join Admin_Service_Package_Sub sub on sub.ASP_ID=Admin_Service_Package.ASP_ID and Patient_Services.S_ID=sub.S_ID
WHERE     (Patient_Services.RegNo = @RegNo) AND (Patient_Services.YearlyNo = @YearlyNo) and Patient_Services.SubDept_ID=@SubdeptID
AND (Patient_Services.Payment_Status = 0) 
                     
                    and (Admin_Services.S_Category = @CategoryId or @CategoryId = 0)
ORDER BY isnull(SUB.Priority,100) ASC, Date DESC" DeleteCommand="DELETE FROM Patient_Services WHERE (ID = @ID) 
delete from Discount_Sub where ID=@ID">
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="SubdeptID" SessionField="SubDeptID" />
                        <asp:ControlParameter ControlID="ddlCategory" Name="CategoryId" PropertyName="SelectedValue"/>
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
    <asp:HiddenField runat="server" ID="hdfS_ID" />
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
                                 DataTextField="AP_Name" DataValueField="ASP_ID">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT 0 as ASP_ID,'' as  AP_Name UNION SELECT     Admin_Service_Package.ASP_ID, Admin_Service_Package.AP_Name AS AP_Name  FROM         Admin_Service_Package join Patient_Package_Selected on Patient_Package_Selected.PackageID=Admin_Service_Package.ASP_ID where Patient_Package_Selected.VisitNo=@visitno --SELECT     Admin_Service_Package.ASP_ID, Admin_Service_Package.AP_Name AS AP_Name  FROM         Admin_Service_Package where HospitalId=@Hospital_Id ">
                        <SelectParameters>
                            <%--<asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />--%>
                           
                            <asp:QueryStringParameter Name="visitno" QueryStringField="payid" />
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
