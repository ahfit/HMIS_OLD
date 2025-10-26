<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Report_Reciver.aspx.vb"
    MasterPageFile="~/hacims_masterpagePatientLab.master" Inherits="Report_Reciver" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        #nav
        {
            display: none;
        }
    </style>
    <script src="../images/highlight.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function Validation() {
            var PFName = document.getElementById("textboxrfname").value;
            var PMName = document.getElementById("textboxrmname").value;
            var RFName = document.getElementById("textboxrffname").value;
            var RMName = document.getElementById("textboxrfmname").value;
            if (PFName.length != 0) {
                for (i = 0; i < PFName.length; i++) {
                    if (PFName.charAt(i) >= 0 || PFName.charAt(i) <= 9) {
                        alert("Integer not allowed in Patient Relative  First Name");
                        document.getElementById("textboxrfname").focus();
                        return false;
                    }
                }
            }
            if (PMName.length != 0) {
                for (i = 0; i < PMName.length; i++) {
                    if (PMName.charAt(i) >= 0 || PMName.charAt(i) <= 9) {
                        alert("Integer not allowed in Patient Relative  First Name");
                        document.getElementById("textboxrmname").focus();
                        return false;
                    }
                }
            }
            if (RFName.length != 0) {
                for (i = 0; i < RFName.length; i++) {
                    if (RFName.charAt(i) >= 0 || RFName.charAt(i) <= 9) {
                        alert("Integer not allowed in Patient Relative  First Name");
                        document.getElementById("textboxrffname").focus();
                        return false;
                    }
                }
            }
            if (RMName.length != 0) {
                for (i = 0; i < RMName.length; i++) {
                    if (RMName.charAt(i) >= 0 || RMName.charAt(i) <= 9) {
                        alert("Integer not allowed in Patient Relative  First Name");
                        document.getElementById("textboxrfmname").focus();
                        return false;
                    }
                }
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="Label_Message" runat="server" CssClass="err"></asp:Label>
    <br />
    <asp:ScriptManager ID="ScriptManager2" runat="server">
        <Services>
            <asp:ServiceReference Path="AutoComplete.asmx" />
        </Services>
    </asp:ScriptManager>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Grid"
                Width="100%" CssClass="Grid_1" DataKeyNames="TGID">
                <Columns>
                    <asp:BoundField DataField="RegNo" SortExpression="RegNo" HeaderText="Registration No"
                        Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="YearlyNo" SortExpression="YearlyNo" HeaderText="Visit No"
                        Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="Main_ID" HeaderText="Main_ID" InsertVisible="False" SortExpression="Main_ID" />
                    <asp:BoundField DataField="PFName" HeaderText="PFName" SortExpression="PFName" />
                    <asp:BoundField DataField="PMName" HeaderText="PMName" SortExpression="PMName" />
                    <asp:BoundField DataField="PLName" HeaderText="PLName" SortExpression="PLName" />
                    <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
                    <asp:BoundField DataField="PatientName" HeaderText="Relation Name" SortExpression="PatientName" />
                    <asp:BoundField DataField="TGName" HeaderText="Group Name" SortExpression="TGName" />
                    <asp:BoundField DataField="Date_Time" HeaderText="Booking Date" SortExpression="Date_Time" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
                    <asp:BoundField DataField="TB_Name" HeaderText="Test Booking Name" SortExpression="TB_Name" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                            <asp:HiddenField ID="HiddenFieldTGID" runat="server" Value='<%# Bind("TGID", "{0}") %>' />
                            <asp:HiddenField ID="HiddenField_Main_ID" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                            <asp:HiddenField ID="HiddenField_TBID" runat="server" Value='<%# Eval("TB_ID", "{0}") %>' />
                            <asp:HiddenField ID="HiddenField_TBName" runat="server" Value='<%# Eval("TB_Name", "{0}") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div style="text-align: right;">
        <asp:Button ID="btnSendEmail" runat="server" Text="Send Email"  Visible="False"/>
        <asp:Button ID="btn_send_sms" runat="server" Text="Send SMS" Visible="False" 
            CausesValidation="False" />
        <asp:Button ID="Button1" runat="server" Text="Change Status" 
            CausesValidation="False" />
        <asp:Button ID="btn_back" runat="server" Text="Return" 
            CausesValidation="False" />
        <br />
        <br />
        <br />
    </div>
    <asp:SqlDataSource ID="SqlDataSource_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT &#13;&#10;                      Path_Result_Delivery.Yearly_No AS YearlyNo, Path_Result_Delivery.Reg_no AS RegNo, Patient.PFName, Patient.PMName, Patient.PLName, Patient.Relation, &#13;&#10;                      ISNULL(Patient.RFName + ' ', '') + ISNULL(Patient.RMName + ' ', '') + ISNULL(Patient.RLName + ' ', '') AS PatientName, Test_Status.Status, CONVERT(varchar, &#13;&#10;                      Path_Result_Delivery.Sample_Collection_Date, 107) AS Date_Time, TestGroup.TGName, TestGroup.TGID, Path_Result_Delivery.Main_ID, Department.Dept_Name, &#13;&#10;                      Test_Booking.TB_Name, Test_Booking.TB_ID&#13;&#10;FROM         Test_Booking INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN&#13;&#10;                      Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN&#13;&#10;                      Payment INNER JOIN&#13;&#10;                      Patient ON Payment.RegNo = Patient.RegNo ON Path_Result_Delivery.Yearly_No = Payment.PayID ON &#13;&#10;                      Test_Booking.TB_ID = Test_Booking_Services.TB_ID LEFT OUTER JOIN&#13;&#10;                      Department ON Path_Result_Delivery.From_Dept_ID = Department.Dept_ID&#13;&#10;WHERE     (Test_Status.Status_ID = @Status_Id) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND &#13;&#10;                      (Path_Result_Delivery.Main_ID = @Main_ID)&#13;&#10;">
        <SelectParameters>
            <asp:QueryStringParameter Name="Status_Id" QueryStringField="status" />
            <asp:QueryStringParameter Name="RegNo" QueryStringField="Reg_No" />
            <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
            <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_Id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Panel ID="pnl_status" runat="server" Visible="False" CssClass="lightbox" Width="750px"
        Height="100px">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button_update" runat="server" Text="Update Status" Width="94px" />
        <asp:DropDownList ID="DropDownList_Status" runat="server" DataSourceID="SqlDataSource_Status_Edit"
            DataTextField="Status" DataValueField="Status_ID" Width="150px">
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnClose" runat="server" Text="Close" />
        <asp:SqlDataSource ID="SqlDataSource_Status_Edit" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT Status, Status_ID FROM Test_Status WHERE  (NOT (Priority IS NULL))">
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_Edit_Status" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="pt_select_status"
            UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE TB_ID =@TB_ID and  Main_ID =@Main_ID&#13;&#10;&#13;&#10;update     Path_PatientTestResult_Main &#13;&#10;set Status_by=''&#13;&#10;where trmId=@trmId  and Main_ID=@Main_ID"
            SelectCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:ControlParameter ControlID="HiddenField_Edit_Status" Name="Status" PropertyName="Value" />
                <asp:ControlParameter ControlID="HF_TBID" Name="TB_ID" PropertyName="Value" />
                <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" />
                <asp:ControlParameter ControlID="HiddenField_trim_ID" Name="trmId" PropertyName="Value"
                    DefaultValue="0" />
            </UpdateParameters>
            <SelectParameters>
                <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                <asp:QueryStringParameter DefaultValue="" Name="Status" QueryStringField="Status"
                    Type="Int32" />
                <asp:QueryStringParameter Name="Sample_No" QueryStringField="sample_no" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
            InsertCommand="insert_lab_status_record" InsertCommandType="StoredProcedure"
            ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status  WHERE (Main_ID = @Main_ID) AND (TB_ID = @TB_ID) ">
            <UpdateParameters>
                <asp:ControlParameter ControlID="DropDownList_Status" DefaultValue="" Name="Status"
                    PropertyName="SelectedValue" />
                <asp:QueryStringParameter DefaultValue="" Name="Main_ID" QueryStringField="Main_ID" />
                <asp:ControlParameter ControlID="HiddenField_TBID" DefaultValue="" Name="TB_ID" PropertyName="Value" />
            </UpdateParameters>
            <InsertParameters>
                <asp:QueryStringParameter DefaultValue="" Name="Main_ID" QueryStringField="Main_ID"
                    Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_Status" DefaultValue="" Name="Status"
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value"
                    Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HF_TBID" runat="server" />
        <asp:HiddenField ID="HiddenField_trim_ID" runat="server" />
        <br />
    </asp:Panel>
    <br />
    <h1 class="h1">
        <span>Reports Deliver to :</span></h1>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
        <tr>
            <td width="17%" align="right" valign="middle">
                <strong>First Name :&nbsp; </strong>
            </td>
            <td width="34%">
                <asp:TextBox CssClass="input_txt" ID="TextBoxRFName" runat="server"></asp:TextBox>
            </td>
            <td width="17%" align="right" valign="middle">
                <strong>Last Name :&nbsp;</strong>
            </td>
            <td width="32%">
                <asp:TextBox CssClass="input_txt" ID="TextBoxRMName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" valign="middle">
                <strong>Relation&nbsp;:&nbsp;</strong>
            </td>
            <td colspan="3">
                <asp:RadioButtonList ID="RBLrelation" runat="server" RepeatDirection="Horizontal"
                    TabIndex="9" Width="172px">
                    <asp:ListItem Selected="True">S/O</asp:ListItem>
                    <asp:ListItem>D/O</asp:ListItem>
                    <asp:ListItem>W/O</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td align="right" valign="middle">
                <strong>First Name :&nbsp;</strong>
            </td>
            <td>
                <asp:TextBox CssClass="input_txt" ID="TextBoxRFFName" runat="server"></asp:TextBox>
            </td>
            <td align="right" valign="middle">
                <strong>Last Name :&nbsp;</strong>
            </td>
            <td>
                <asp:TextBox CssClass="input_txt" ID="TextBoxRFMName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" valign="middle">
                <strong>CNIC No :&nbsp;</strong>
            </td>
            <td>
                <asp:TextBox CssClass="input_txt" ID="TextBoxRCINIC" runat="server"></asp:TextBox>
            </td>
            <td align="right" valign="middle">
                <strong>Description :&nbsp; </strong>
            </td>
            <td>
                <asp:TextBox CssClass="input_txt" ID="TextBox_Description" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
    <br />
    <div align="center">
        <asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1" 
            CausesValidation="False" />&nbsp;
        <asp:LinkButton ID="LinkButtonReport" runat="server" Font-Underline="False" 
            CssClass="btn_grid" CausesValidation="False">View Report</asp:LinkButton></div>
    <br />
    <asp:HiddenField ID="HiddenField_Main_Id" runat="server" />
    <br />
    <asp:HiddenField ID="HiddenField_TBID" runat="server" />
    <asp:HiddenField ID="HiddenField_TG_ID" runat="server" />
    <asp:TextBox ID="TextBox2" runat="server" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TextBox1" runat="server" Visible="False"></asp:TextBox>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Pathology2ConnectionString.ProviderName %>"
        UpdateCommand="Update_Patient_Deliver_Status" InsertCommand="INSERT INTO Report_Reciever_Sub (Main_ID, TBID) VALUES (@Main_ID,@TID)"
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:QueryStringParameter Name="Payid" QueryStringField="YearlyNo" />
            <asp:QueryStringParameter Name="RegNo" QueryStringField="Reg_No" />
            <asp:ControlParameter ControlID="HiddenField_TG_ID" Name="TGID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter DefaultValue="6" Name="Status" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Main_Id" DefaultValue="" Name="Main_ID"
                PropertyName="Value" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_TBID" Name="TID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Report_Reciecer_id" Name="Main_ID" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Report_Reciecer_id" runat="server" />
    <asp:HiddenField ID="HiddenField_TRM_ID" runat="server" />
    <asp:Panel ID="pnlSendEmail" runat="server" CssClass="lightbox" Visible="false" Height="200px">
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="40%">
                    Email Address :
                </td>
                <td align="left">
                    <asp:TextBox ID="txtEmail" runat="server" required></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                        ErrorMessage="Enter Valid Email Address" ControlToValidate="txtEmail" 
                        Display="Dynamic" SetFocusOnError="True" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSend" runat="server" Text="Send" />
                    <asp:Button ID="btnClosePnl" runat="server" Text="Close" />
                    <asp:Label ID="lblEmailMsg" runat="server" Visible="false"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
