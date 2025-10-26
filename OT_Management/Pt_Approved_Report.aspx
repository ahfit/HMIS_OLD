<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_Approved_Report.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="Pt_Approved_Report" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


<script language="javascript" type="text/javascript">
function OpenNewPage()
{
var regno=document.getElementById("HiddenFieldRegNo").value;
var yearlyno=document.getElementById("HiddenFieldYearlyNo").value;
window.open("","MyWidows")
    
}
</script>
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
<div id="forms_items" class="bxmain">
<br />

<asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label>
<br />
<table cellpadding="0" cellspacing="0" class="tbl_form"  >
                    <tr>
                        <td width="11%" align="right" style="height: 25px" >
                            <strong>Yearly No :&nbsp;</strong></td>
                  <td width="22%" style="height: 25px" >
                    <asp:Label ID="Label_YearlyNo" runat="server" ></asp:Label></td>
                  <td width="10%" align="right" style="height: 25px" >
                            <strong>Reg. No. :&nbsp; </strong>                        </td>
                  <td width="25%" style="height: 25px" >
                    <asp:Label ID="Label_Reg_No" runat="server" ></asp:Label></td>
                  <td width="10%" align="right" style="height: 25px" >
                            <strong>Suggested By :&nbsp;</strong></td>
                  <td width="22%" style="height: 25px" >
                    <asp:Label ID="Label_Suggested_by" runat="server" ></asp:Label></td>
      </tr>
                    <tr>
                        <td align="right" style="height: 26px" >
                            <strong>Initiated Date :&nbsp;</strong></td>
                        <td style="height: 26px" >
                            <asp:Label ID="Label_Init_Date" runat="server" ></asp:Label></td>
                        <td align="right" style="height: 26px" >
                            <strong>Report Date :&nbsp;</strong></td>
                        <td style="height: 26px" >
                            <asp:Label ID="Label_Rep_Date" runat="server" ></asp:Label></td>
                        <td align="right" style="height: 26px" >
                            <strong>Status :&nbsp;</strong></td>
                        <td style="height: 26px" >
                            <asp:Label ID="Label_Status" runat="server" ></asp:Label></td>
                    </tr>
    </table> <br />
    <asp:DataList ID="DataListMainGroup" runat="server" DataKeyField="trmId" DataSourceID="SqlDataSource_For_DataList"
                    RepeatColumns="5" Visible="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="link_datalist"
                            Text='<%# Eval("TGName", "{0}") %>' ></asp:LinkButton>&nbsp;|&nbsp;
                    </ItemTemplate>
    </asp:DataList><asp:GridView ID="GridViewMain" runat="server" AutoGenerateColumns="False"
        CssClass="Grid_1" DataKeyNames="TGID" DataSourceID="SqlDataSource_Status" Width="100%">
        <Columns>
            <asp:BoundField DataField="TB_Name" HeaderText="Test" ReadOnly="True" SortExpression="TB_Name" />
            <asp:TemplateField HeaderText="Status" SortExpression="Status">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList_Status" runat="server" DataSourceID="SqlDataSource_Status_Edit"
                        DataTextField="Status" DataValueField="Status_ID" Width="167px">
                    </asp:DropDownList><br />
                    <asp:SqlDataSource ID="SqlDataSource_Status_Edit" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Status, Status_ID FROM Test_Status WHERE (Status_ID = 3) OR (Status_ID = 5) OR (Status_ID = 9)">
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Bind("ID", "{0}") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="Date_Time" HeaderText="Date Time" ReadOnly="True" SortExpression="Date_Time" />
            <asp:TemplateField ShowHeader="False" HeaderText="Test Group Name">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Select"
                        Text='<%# Eval("TGName") %>'></asp:LinkButton><br />
                    <asp:HiddenField ID="HiddenField6" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField7" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField8" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldTBID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TGName" HeaderText="Test Group Name" ReadOnly="True" SortExpression="TGName" Visible="False" />
            <asp:BoundField DataField="Sample No." HeaderText="Sample No." SortExpression="Sample No." ReadOnly="True" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="pt_select_status"
        SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE (ID = @ID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Edit_Status" Name="Status" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Edit_ID" Name="ID" PropertyName="Value" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
            <asp:Parameter DefaultValue="6" Name="Status" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldMainID" runat="server" />
    <asp:HiddenField ID="HiddenField_TBID" runat="server" />
    <asp:HiddenField ID="HiddenField_TGID" runat="server" />
    <asp:HiddenField ID="HiddenField_Edit_Status" runat="server" />
    <asp:HiddenField ID="HiddenFieldGender_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Edit_ID" runat="server" />
    <br />
                <asp:GridView ID="GridView_Test_Status" runat="server" AutoGenerateColumns="False"
                    CssClass="Grid_1" DataSourceID="SqlDataSource_For_Grid" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr. No.">
                            <ItemTemplate>
                                <asp:Label ID="Label_sr" runat="server" Width="63px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="TGName" HeaderText="Group Name" SortExpression="TGName"
                            Visible="False" />
                        <asp:BoundField DataField="ComponentName" HeaderText="Component Name" SortExpression="ComponentName" />
                        <asp:BoundField DataField="TCValue" HeaderText="Value" SortExpression="TCValue" />
                        <asp:TemplateField HeaderText="Normal">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" />
                                <asp:HiddenField ID="HiddenField_trm_id" runat="server" Value='<%# Bind("trmId", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_TCID" runat="server" Value='<%# Bind("TCID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_TID" runat="server" Value='<%# Bind("TID", "{0}") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Employee_Name" HeaderText="Entered By" SortExpression="Employee_Name" />
                        <asp:TemplateField HeaderText="Remark" SortExpression="Remark">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Remark") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" AutoPostBack="True" OnTextChanged="TextBox2_TextChanged" Text='<%# Bind("Remark", "{0}") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <br />
<asp:Label ID="Label_Description" runat="server" CssClass="err"  Text="Report :" Visible="False"></asp:Label><br />
               <br />
<asp:TextBox ID="TextBox_Description" runat="server" Height="150px"
                    Rows="5" TextMode="MultiLine" Visible="False" Width="100%"></asp:TextBox><br /> 
                   <br />
 
<DIV align="center">                    
<asp:Button ID="Button_Save" runat="server" CssClass="btn2" Text="Approved" /> &nbsp;<asp:Button ID="Button_Reject" runat="server" CssClass="btn1" Text="Reject" /></DIV>


<br />

<asp:SqlDataSource
                    ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT TestGroup.TGName, TestComponent.ComponentName, path_PatientTestResult.TCValue, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Employee_Name, path_PatientTestResult.Remark, path_PatientTestResult.AbNormal, Path_PatientTestResult_Main.trmId, TestComponent.TCID, TestComponent.TID, Path_PatientTestResult_Main.Main_ID FROM TestComponent INNER JOIN Path_PatientTestResult_Main INNER JOIN path_PatientTestResult ON Path_PatientTestResult_Main.trmId = path_PatientTestResult.trmID ON TestComponent.TCID = path_PatientTestResult.TCId INNER JOIN TestGroup INNER JOIN Test ON TestGroup.TGID = Test.TGID ON TestComponent.TID = Test.TID LEFT OUTER JOIN Employee ON path_PatientTestResult.Emp_ID = Employee.EmpID WHERE (Path_PatientTestResult_Main.RegNo = @RegNo) AND (Path_PatientTestResult_Main.YearlyNo = @YearlyNo) AND (Path_PatientTestResult_Main.TGID = @TGID) AND (Path_PatientTestResult_Main.Main_ID = @Main_ID) AND (Path_PatientTestResult_Main.TB_ID = @TB_ID)"
                    UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (Test_Booking_Services.Status = 6) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Main_ID = @Main_ID) AND (Test_Booking_Services.TB_ID = @TB_ID)">
                    <UpdateParameters>
                        <asp:Parameter DefaultValue="10" Name="Status" />
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:ControlParameter ControlID="HiddenFieldMainID" DefaultValue="" Name="Main_ID"
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_TBID" DefaultValue="" Name="TB_ID" PropertyName="Value" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:ControlParameter ControlID="HiddenField_TGID" Name="TGID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldMainID" Name="Main_ID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value" />
                    </SelectParameters>
    </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_For_DataList" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT Path_PatientTestResult_Main.trmId, TestGroup.TGName, TestGroup.TGID FROM Path_PatientTestResult_Main INNER JOIN TestGroup ON Path_PatientTestResult_Main.TGID = TestGroup.TGID WHERE (Path_PatientTestResult_Main.RegNo = @RegNo) AND (Path_PatientTestResult_Main.YearlyNo = @YearlyNo) AND (Path_PatientTestResult_Main.Main_ID = @Main_ID)"
                    UpdateCommand="UPDATE Path_PatientTestResult_Main SET Report = @Report, Approved_By = @Approved_By WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (TGID = @TGID) AND (Main_ID = @Main_ID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="TextBox_Description" Name="Report" PropertyName="Text" />
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:ControlParameter ControlID="HiddenField_TGID" Name="TGID" PropertyName="Value" />
                        <asp:SessionParameter Name="Approved_By" SessionField="emp_id" />
                        <asp:ControlParameter ControlID="HiddenFieldMainID" Name="Main_ID" PropertyName="Value" />
                    </UpdateParameters>
                </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceupdatestatus" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        SelectCommand="UPDATE    Treatment.dbo.Investigation_Order_Main&#13;&#10;SET              Treatment.dbo.Investigation_Order_Main.Status = 12&#13;&#10;WHERE     (Treatment.dbo.Investigation_Order_Main.Investigation_Order_ID in (SELECT     HospitalOrderNo&#13;&#10;FROM         Path_Result_Delivery&#13;&#10;WHERE     (Main_ID = @Main_ID)))"
        UpdateCommand="UPDATE    Treatment.dbo.Investigation_Order_Main&#13;&#10;SET              Treatment.dbo.Investigation_Order_Main.Status = 12&#13;&#10;WHERE     (Treatment.dbo.Investigation_Order_Main.Investigation_Order_ID in (SELECT     HospitalOrderNo&#13;&#10;FROM         Path_Result_Delivery&#13;&#10;WHERE     (Main_ID = @Main_ID)))">
        <UpdateParameters>
            <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>
  
  </asp:Content>