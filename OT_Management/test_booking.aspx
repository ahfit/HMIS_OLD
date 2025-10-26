<%@ Page Language="VB" AutoEventWireup="false" CodeFile="test_booking.aspx.vb" Inherits="Test_Booking"  MasterPageFile="~/hacims_masterpage.master" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



<script language="javascript" type="text/javascript">
function OpenNewPage()
{
var regno=document.getElementById("HiddenFieldRegNo").value;
var yearlyno=document.getElementById("HiddenFieldYearlyNo").value;
window.open("","MyWidows")
    
}
</script>

 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
                  <asp:Label ID="Label2" runat="server" ></asp:Label>

<asp:Label CssClass="txt_bold" ForeColor="Red" ID="Label_Message" runat="server" ></asp:Label>
                            <asp:RangeValidator ID="RangeValidator_days" runat="server" ControlToValidate="TextBox_next_Date"
                                CssClass="text_lables_login" Display="Dynamic" ErrorMessage="Enter Correct Days"
                                MaximumValue="100" MinimumValue="0" Type="Integer"></asp:RangeValidator>
          <div class="bxmain">                      
         <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="11%" align="right">Test Type :&nbsp;</td>
    <td  width="39%">  <asp:RadioButtonList ID="RadioButtonList_Type" runat="server" DataSourceID="SqlDataSource_Test_Type"
                                DataTextField="Test_Type" DataValueField="Test_Type_ID" RepeatDirection="Horizontal" RepeatLayout="Flow" 
                                Width="100%" TabIndex="16">
        <asp:ListItem Selected="True">Routine</asp:ListItem>
        <asp:ListItem>Start(Now)</asp:ListItem>
        <asp:ListItem>Urgent(Today)</asp:ListItem>
      </asp:RadioButtonList></td>
    <td  width="25%" align="right">Description :</td>
    <td  width="25%" valign="top"> <asp:TextBox runat="server" TextMode="MultiLine"  ID="TextBoxDescription"   Width="200px" Style="height:55px;" TabIndex="19" /></td>
  </tr>
</table>
                       
        </div>                        
     

<br class="break" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr>
        <td >&nbsp;
            </td>
    </tr>
  <tr>
    <td style="height: 52px">
<span style="float:left; background-image:url(../images/bg_input.jpg); display:block; height:34px; width:385px;">
<br style="line-height:4px;" />
&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Path_codelist.aspx"
        Target="_blank">Code:</asp:HyperLink>&nbsp;<asp:TextBox ID="TextBox6" runat="server" AutoPostBack="True" CssClass="input_txt"
        OnTextChanged="TextBox6_TextChanged" Width="32px"></asp:TextBox>
&nbsp;&nbsp;Name :&nbsp;<asp:TextBox ID="TextBox_Test" runat="server" AutoPostBack="True" Width="120px" CssClass="input_txt" TabIndex="1" ></asp:TextBox>&nbsp;
    <asp:DropDownList ID="DropDownList_Main_Group" runat="server" AutoPostBack="True"
DataSourceID="SqlDataSource_Main_Group" DataTextField="TGName" DataValueField="TGID"
Width="120px"></asp:DropDownList></span><span style="float:right;"><asp:Button ID="Button1" runat="server" CssClass="btn1" OnClientClick="ViewReport()" Text="Back Page" />
<asp:Button ID="btnAdd" runat="server" Text="Print" CssClass="btn1" />
<asp:Button ID="Button_Move_Next" runat="server" Text="Move Next" Visible="False" CssClass="btn1" />
<asp:Button ID="Button6" runat="server" Text="View Report" CssClass="btn1" Visible="False" OnClientClick="ViewReport()" />
<asp:Button ID="BTNcheckAll" runat="server" Text="Check All" Height="22px"  CssClass="btn1" Visible="False" />
<asp:Button ID="BtnUncheckAll" runat="server" Text="UnCheck All" Height="22px"  CssClass="btn1" Visible="False" />
    <asp:Button ID="Button_ForAppointment" runat="server" Text="For Appointment" Height="22px"  CssClass="btn1" />
    <asp:Button ID="Button_ForPayment" runat="server" Text="For Payment" Height="22px"  CssClass="btn1" />
</span>

</td>
  </tr>
</table>
<br class="break" />



<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="40%" style="border:#CCCCCC solid 1px; padding:5px;"> 
   

<asp:GridView ID="GridView_Booking" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
DataKeyNames="TB_ID" DataSourceID="SqlDataSource_Booking" Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="TB_ID" HeaderText="Test Code" InsertVisible="False" ReadOnly="True"
                                        SortExpression="TB_ID" />
                                    <asp:ButtonField CommandName="Select" DataTextField="TB_Name" HeaderText="Test Name " />
                                    <asp:TemplateField HeaderText="TB_Name" SortExpression="TB_Name" Visible="False">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TB_Name") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("TB_Name") %>'></asp:Label>&nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Group Name" SortExpression="TGName">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TGName") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("TGName") %>'></asp:Label> 
                                           
                                            <asp:HiddenField ID="HiddenField_S_amount" runat="server" Value='<%# Eval("S_Amount", "{0}") %>' />
                                            <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Public Price" SortExpression="Public_Price" Visible="False">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Public_Price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Public_Price") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Private Price" SortExpression="Private_Price" Visible="False">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Private_Price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Private_Price") %>'></asp:Label>&nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader2" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                      
                            <asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                InsertCommand="INsert_Test_Booking_Services" InsertCommandType="StoredProcedure"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="Select_TB_Name" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList_Main_Group" Name="MG_ID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="HiddenField_Flag" DefaultValue="" Name="Flag" PropertyName="Value"
                                        Type="Boolean" />
                                    <asp:ControlParameter ControlID="TextBox_Test" DefaultValue="%%" Name="TB_Name" PropertyName="Text"
                                        Type="String" />
                                    <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" Type="Int32" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                                    <asp:SessionParameter DefaultValue="" Name="RegNo" SessionField="registrationNo" />
                                    <asp:ControlParameter ControlID="HiddenField_TBID" DefaultValue="" Name="TB_ID" PropertyName="Value" />
                                    <asp:Parameter DefaultValue="12" Name="Status" Type="Int32" />
                                    <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
                                    <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value"
                                        Type="Int32" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource_Main_Group" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT TestGroup.TGID, TestGroup.TGName, Admin_Dept_Services.Dept_ID FROM Test_Booking LEFT OUTER JOIN Admin_Dept_Services ON Test_Booking.S_Id = Admin_Dept_Services.S_ID LEFT OUTER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID WHERE (Admin_Dept_Services.Dept_ID = @Dept_ID)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Dept_ID" SessionField="dept_ID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_TBID" runat="server" />
                            <asp:HiddenField ID="HiddenField_Flag" runat="server" /></td>
    <td width="60%" valign="top" style="border:#CCCCCC solid 1px; padding:5px;"><asp:Label ID="labelGName" CssClass="err" runat="server" ></asp:Label>
                                <asp:GridView ID="GridView_Services" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Booking_Service"
                                    Width="60%" DataKeyNames="ID" CssClass="Grid_1" ShowFooter="True">
                                    <Columns>
                                        <asp:BoundField DataField="TB_Name" HeaderText="Name" SortExpression="TB_Name" />
                                        <asp:BoundField DataField="TGName" HeaderText="Group Name" SortExpression="TGName" />
                                        <asp:CommandField DeleteText="Cancel" ShowDeleteButton="True" />
                                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                        <asp:TemplateField HeaderText="Appointment Date/Time">
                                            <ItemTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" >
                                                    <tr>
                                                        <td>
                                                            <igsch:WebDateChooser ID="WebDateChooser_Appointment" runat="server" Value="" Width="101px">
                                                                <CalendarLayout Culture="English (United Kingdom)">
                                                                </CalendarLayout>
                                                            </igsch:WebDateChooser>
                                                        </td>
                                                        <td  >
                                                            <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_Appointment" runat="server" CssClass="input_txt"
                                                                DisplayModeFormat="t" EditModeFormat="t" Width="58px">
                                                            </igtxt:WebDateTimeEdit>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Report Date/Time">
                                            <ItemTemplate>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" >
                                                    <tr>
                                                        <td>
                                                            <igsch:WebDateChooser ID="WebDateChooser_Report" runat="server" Width="98px">
                                                                <CalendarLayout Culture="English (United Kingdom)">
                                                                </CalendarLayout>
                                                            </igsch:WebDateChooser>
                                                        </td>
                                                        <td>
                                                            <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_Report" runat="server" DisplayModeFormat="t"
                                                                EditModeFormat="t" Width="67px">
                                                            </igtxt:WebDateTimeEdit>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="Label_total" runat="server"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="ID">
                                            <EditItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount" SortExpression="S_Amount">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("S_Amount") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="Label_amount" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("S_Amount") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource_Booking_Service" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>" SelectCommand="SELECT Test_Booking.TB_Name, TestGroup.TGName, Test_Booking_Services.ID, Test_Status.Status, ISNULL(Admin_Services.S_Amount, 0) AS S_Amount FROM Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID WHERE (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Sample_No = @Sample_No)" DeleteCommand="DELETE FROM Test_Booking_Services WHERE (ID = @ID)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                                        <asp:ControlParameter ControlID="TextBox_Sample_number" Name="Sample_No" PropertyName="Text" />
                                    </SelectParameters>
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="GridView_Services" Name="ID" PropertyName="SelectedValue" />
                                    </DeleteParameters>
                                </asp:SqlDataSource>
        <asp:Button ID="Button_Save" runat="server" Text="Save" Visible="False" /></td>
    
  </tr>
</table>
<br />
<br />
<asp:TreeView ID="TreeView1" runat="server" Visible="false" > </asp:TreeView>
<div style="display:none">
    &nbsp; &nbsp; &nbsp;

                      <asp:HiddenField ID="HiddenField_Sample_collection" runat="server" />
                      <asp:HiddenField ID="HiddenField_Report_Date" runat="server" />
                      <asp:HiddenField ID="HiddenFieldMain_ID" runat="server" />
                      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString12.ProviderName %>" SelectCommand="Select @PFNAME = PFNAME from patient"> </asp:SqlDataSource>
                      <asp:HiddenField ID="HiddenField2" runat="server" /><asp:SqlDataSource ID="SqlDataSource_Test_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        SelectCommand="SELECT Test_Type, Test_Type_ID FROM Test_Type" ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>">
                      </asp:SqlDataSource>
                        <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />

                        <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
    &nbsp;&nbsp;

                      <asp:SqlDataSource ID="ForTestGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        SelectCommand="SELECT     Test_Main_Sub_Grouping.MSTG_Name, Test_Main_Sub_Grouping.MS_TGID&#13;&#10;FROM         Test_Main_Sub_Grouping INNER JOIN&#13;&#10;                      TestGroup ON Test_Main_Sub_Grouping.TGID = TestGroup.TGID&#13;&#10;order by Test_Main_Sub_Grouping .priority asc&#13;&#10;"></asp:SqlDataSource>
                      <asp:SqlDataSource ID="ForTestSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        
                        SelectCommand="SELECT isnull(TestSubGroup.TSGName,'') as TSGName, TestSubGroup.TSGID, &#13;&#10;isnull(TestGroup.TGName,'') as TGName &#13;&#10;FROM TestSubGroup INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID &#13;&#10;WHERE (TestSubGroup.MS_TGID = @TGID)&#13;&#10;order by TestSubGroup.Sort_order asc" 
                        ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="Dropdownlist2" Name="TGID" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:SqlDataSource ID="ForTest" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        SelectCommand="SELECT Test.TestName, Test.TID FROM Test INNER JOIN Test_Main_Sub_Grouping ON Test.TGID = Test_Main_Sub_Grouping.TGID WHERE (Test.Active = @Active) AND (Test_Main_Sub_Grouping.MS_TGID = @TGID) ">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="DropDownList2" Name="TGID" PropertyName="SelectedValue"
                      Type="Int32" DefaultValue="%%" />
                            <asp:Parameter DefaultValue="1" Name="Active" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:HiddenField ID="HiddenFieldTestSubGroup" runat="server" />
                      <asp:SqlDataSource ID="SqlDataSourcefortsetSG" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                SelectCommand="SELECT [TID], [TestName] FROM [Test] WHERE ([TSGID] = @TSGID)">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="HiddenField_for_test" Name="TSGID" PropertyName="Value"
                        Type="Int32" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                      <asp:HiddenField ID="HiddenField_for_test" runat="server" />
    <asp:HiddenField ID="HiddenFieldTotalAmount" runat="server" />
    <asp:HiddenField ID="HiddenFieldTotalPaid" runat="server" />
    <asp:HiddenField ID="HiddenFieldTotal_Discount" runat="server" />

</div>
    <asp:SqlDataSource ID="SqlDataSourceInsertSub" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        InsertCommand="Insert_Pathology_Test_Total_Amount" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="&#13;&#10;">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldTotal_Discount" Name="TOtal_Discount"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldTotalPaid" Name="Total_Paid" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldTotalAmount" Name="Total_AMount" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_PatientServices" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        InsertCommand="INSERT INTO [BasicDataInfo].[dbo].[Patient_Services]&#13;&#10;           ([RegNo]&#13;&#10;           ,[YearlyNo]&#13;&#10;           ,[sdatetime]&#13;&#10;           ,[empid]&#13;&#10;           ,[S_ID]&#13;&#10;           ,[Amount]&#13;&#10;           ,[Payment_Status]&#13;&#10;           ,[Doctor_ID]&#13;&#10;           ,[SubDept_ID]&#13;&#10;           ,[Doctor_Payment]&#13;&#10;           ,[Dept_ID]&#13;&#10;           ,[ResonForCancellation]&#13;&#10;           ,Order_ID)&#13;&#10;  &#13;&#10;&#13;&#10;SELECT     Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No, Path_Result_Delivery.Test_Booking_Date, Path_Result_Delivery.EmpID, Test_Booking.S_Id, &#13;&#10;                      Admin_Services.S_Amount, 0 AS Expr1, NULL AS Expr2, Path_Result_Delivery.To_SubDept_ID, NULL AS Expr3, Path_Result_Delivery.To_Dept_ID, NULL AS Expr4, &#13;&#10;                      Path_Result_Delivery.Main_ID&#13;&#10;FROM         Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN&#13;&#10;                      Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID&#13;&#10;WHERE     (Path_Result_Delivery.Main_ID = @Main_Id)"
        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldMain_ID" Name="Main_Id" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        Visible="False" Width="100%">
        <Columns>
            <asp:BoundField DataField="Reg_no" HeaderText="Registration No." SortExpression="Reg_no" />
            <asp:BoundField DataField="Yearly_No" HeaderText="Yearly No." SortExpression="Yearly_No" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" />
            <asp:BoundField DataField="TGName" HeaderText="Test Group Name" SortExpression="TGName" />
            <asp:BoundField DataField="TB_Name" HeaderText="Test Name" SortExpression="TB_Name" />
            <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
<asp:TextBox CssClass="input_txt" ID="TextBox_Sample_number" runat="server" Width="150px" TabIndex="12" Visible="False"></asp:TextBox><igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Value="" Width="152px" TabIndex="13" Visible="False">
                    <CalendarLayout NextMonthImageUrl="ig_cal_blueN0.gif" PrevMonthImageUrl="ig_cal_blueP0.gif" 
                                    ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                      <TodayDayStyle BackgroundImage="ig_cal_blue1.gif" />
                      <FooterStyle BackgroundImage="ig_cal_blue2.gif" Font-Size="8pt" ForeColor="#505080"
                                        Height="16pt" />            
                      <SelectedDayStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="White" />
                      <DayStyle BackgroundImage="ig_cal_blue3.gif" BorderColor="SteelBlue" BorderStyle="Solid"
                                        BorderWidth="1px" />
                      <NextPrevStyle BackgroundImage="ig_cal_blue1.gif" />
                      <OtherMonthDayStyle ForeColor="SlateGray" />
                      <DayHeaderStyle BackgroundImage="ig_cal_blue2.gif" Font-Bold="True" Font-Size="8pt"
                                        ForeColor="#606090" Height="1pt" />
                      <TitleStyle BackColor="#CCDDFF" BackgroundImage="ig_cal_blue1.gif" Font-Bold="True"
                                        Font-Size="10pt" ForeColor="#505080" Height="18pt" />
                      <CalendarStyle BackColor="#CCDDFF" BorderColor="SteelBlue" BorderStyle="Solid" BorderWidth="1px"
                                        Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                        Font-Size="9pt" Font-Strikeout="False" Font-Underline="False"> </CalendarStyle>
                    </CalendarLayout>
                  </igsch:WebDateChooser><asp:TextBox CssClass="input_txt" ID="TextBox_next_Date" runat="server" Width="50px" TabIndex="14" Visible="False">5</asp:TextBox><asp:DropDownList ID="DropDownList1" runat="server" Width="96px" TabIndex="15" Visible="False">
                            <asp:ListItem>Hours</asp:ListItem>
                            <asp:ListItem>Days</asp:ListItem>
                          </asp:DropDownList><asp:Label ID="LabelRelation" runat="server" CssClass="text_boxtitle" ></asp:Label><asp:Label ID="LabelRName" runat="server" CssClass="text_boxtitle" ></asp:Label><asp:TextBox ID="TextBox_Grand_discount_1" runat="server" Visible="False" Width="113px">0</asp:TextBox><asp:Label ID="Label3" runat="server" Width="211px"></asp:Label><asp:Label CssClass="text_lables3" ID="Label1" runat="server"></asp:Label><asp:DropDownList ID="DropDownList2" runat="server" 
                              AutoPostBack="True" DataSourceID="ForTestGroup"
                          DataTextField="MSTG_Name" DataValueField="MS_TGID" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"
                          Width="240px" Visible="False"> </asp:DropDownList><asp:Label ID="LabelDOB" runat="server" Width="123px" Visible="False"></asp:Label><asp:Label ID="LabelCNIC" runat="server" Width="125px" Visible="False"></asp:Label><asp:TextBox id="TextBox_Total_Price" tabIndex=12 runat="server" ReadOnly="true" Font-Size="Large" BorderWidth="0px" BorderStyle="None" Visible="False">0</asp:TextBox><asp:TextBox id="TextBox_Grand_discount" tabIndex=17 runat="server" Width="113px" AutoPostBack="True" Visible="False">0</asp:TextBox><asp:DropDownList id="DropDownList_Discount_Type" tabIndex=18 runat="server" AutoPostBack="True" Visible="False">
                       <asp:ListItem>Rs.</asp:ListItem>
                       <asp:ListItem>%age</asp:ListItem>
                     </asp:DropDownList><asp:TextBox id="TextBox_Grand_total" tabIndex=12 runat="server" CssClass="d-active" Width="113px" ReadOnly="True" Font-Size="Large" BorderWidth="0px" BorderStyle="None" Visible="False">0</asp:TextBox>
  </asp:Content>