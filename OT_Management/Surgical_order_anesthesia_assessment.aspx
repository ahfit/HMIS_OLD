<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="false"
    CodeFile="Surgical_order_anesthesia_assessment.aspx.vb" Inherits="Surgical_order_anesthesia_assessment" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style9
        {
        }
        .style10
        {
            width: 233px;
            height: 18px;
        }
        .style11
        {
            height: 18px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="leftnav" valign="top">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
                <asp:Panel ID="Panel1" runat="server" Visible="False">
                </asp:Panel>
            </td>
            <td style="width: 956px;" valign="top">
                <asp:Panel ID="Panel_Admission_Only" runat="server" Width="100%" Font-Size="X-Large">
                    <br />
                    <br />
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <br />
                    <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        Anesthesia Assessment </b>
                    <br />
                    <table cellspacing="1" class="tbl_form">
                        <tr>
                            <td class="style9" style="font-size: large; font-weight: bold;" colspan="2">
                                <asp:GridView ID="GridView_Radiology" runat="server" 
                                    AutoGenerateColumns="False" CssClass="Grid_1" 
                                    DataSourceID="SqlDataSourceRadiology" Width="100%" DataKeyNames="TB_ID">
                                    <Columns>
                                        <asp:BoundField DataField="Doctor" HeaderText="Doctor" 
                                            SortExpression="Doctor" ReadOnly="True" />
                                        <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" SortExpression="TB_ID" ReadOnly="True" Visible="False" />
                                        <asp:BoundField DataField="Date_Time" HeaderText="Date Time" 
                                            SortExpression="Date_Time" />
                                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" Visible="False" />
                                        <asp:BoundField DataField="Clinical_Information" HeaderText="Clinical_Information" SortExpression="Clinical_Information" />
                                        <asp:BoundField DataField="ModeOfOperation" HeaderText="Mode Of Operation" 
                                            SortExpression="ModeOfOperation" />
                                        <asp:BoundField DataField="ModeOfAdmission" HeaderText="Mode Of Admission" 
                                            SortExpression="ModeOfAdmission" />
                                        <asp:CheckBoxField DataField="AnesthesiaOpinion" HeaderText="Anesthesia Opinion" SortExpression="AnesthesiaOpinion" />
                                        <asp:BoundField DataField="AdviceToPatient" SortExpression="AdviceToPatient" HeaderText="Advice To Patient" />
                                        <asp:BoundField DataField="DateOfOperation" SortExpression="DateOfOperation" HeaderText="Date  OfOperation" />
                                        <asp:BoundField DataField="Date_Of_admission" SortExpression="Date_Of_admission" HeaderText="Date Of Admission" />
                                        <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo" Visible="False" />
                                        <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" Visible="False" />
                                        <asp:BoundField DataField="Order_ID" HeaderText="Order_ID" SortExpression="Order_ID" Visible="False" />
                                    </Columns>
                                    <HeaderStyle CssClass="GridHeader" />
                                    <SelectedRowStyle CssClass="RowItem" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                &nbsp; &nbsp;<asp:SqlDataSource ID="SqlDataSourceRadiology" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>" 
                                    ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" 
                                    SelectCommand="pt_Radiology_Select_Tests" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" 
                                            Type="String" />
                                        <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
                                        <asp:QueryStringParameter Name="Order_Id" QueryStringField="Order_Id" 
                                            Type="Decimal" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <br />
&nbsp;<asp:SqlDataSource ID="SqlDataSource_Anesthesia_Type" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>" 
                                    ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" 
                                    SelectCommand="SELECT 
      [Anesthesia_Id]
,[Anesthesia_Name]
  FROM dbo.[Anesthesia_Type]">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9" align="right" style="font-size: large; font-weight: bold;">
                                Anesthesia Type: &nbsp;
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAnesthesia_Typ" runat="server" DataSourceID="SqlDataSource_Anesthesia_Type"
                                    DataTextField="Anesthesia_Name" DataValueField="Anesthesia_Id" AutoPostBack="True"
                                    Height="25px" Width="228px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9" align="right" style="font-size: large; font-weight: bold;">
                                ASA:
                            </td>
                            <td>
                                &nbsp;
                                <asp:TextBox ID="txtAsa" runat="server" Width="119px"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtAsa"
                                    runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9" align="right" style="font-size: large; font-weight: bold;">
                                Urgency:
                            </td>
                            <td>
                                &nbsp;
                                <asp:TextBox ID="txtUrgency" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style10" align="right" style="font-size: large; font-weight: bold;">
                                Consultant :
                            </td>
                            <td class="style11">
                                &nbsp;
                                <asp:DropDownList ID="DropDownListConsultant" runat="server" DataSourceID="SqlDataSource_Employee"
                                    DataTextField="Employee Name" DataValueField="EmpID" AutoPostBack="False" Height="25px"
                                    Width="228px">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS [Employee Name] FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID WHERE (Employee.Empid = 401) AND (Department.Hospital_ID = @HospitalId)  ORDER BY [Employee Name]">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="HospitalId" SessionField="HospitalId" Type="Int32" />
                                        <%--<asp:SessionParameter DefaultValue="" Name="dept_id" SessionField="dept_id" />--%>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9" align="right" style="font-size: large; font-weight: bold;">
                                Fit/Unfit:
                            </td>
                            <td>
                                &nbsp; &nbsp;
                                <%--  <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                                    <asp:ListItem>Fit</asp:ListItem>
                                    <asp:ListItem>UnFit</asp:ListItem>
                                </asp:RadioButtonList>--%>
                                <asp:CheckBox ID="chkFitUnfit" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style9" align="right" style="font-size: large; font-weight: bold;">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="style9" align="right" style="font-size: large; font-weight: bold;">
                                Remarks:
                            </td>
                            <td>
                                &nbsp;
                                <asp:TextBox ID="TextBox_patientadvice" runat="server" Height="75px" TextMode="MultiLine"
                                    Width="79%" MaxLength="9000"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9" style="font-size: large; font-weight: bold;">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="style9" style="font-size: large; font-weight: bold;">
                                &nbsp;
                            </td>
                            <td>
                                <asp:SqlDataSource ID="SqlDataSource_WardAdmission" runat="server" ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"
                                    InsertCommand="Insert_Surgical_order_anesthesia_assessment" InsertCommandType="StoredProcedure"
                                    SelectCommand="select 1">
                                    <InsertParameters>
                                        <%-- <asp:Parameter DefaultValue="0" Name="SOA_Assement_ID" Type="Int32" />--%>
                                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                                        <asp:ControlParameter ControlID="TextBox_patientadvice" DefaultValue="" Name="Remarks"
                                            PropertyName="Text" Type="String" />
                                        <asp:ControlParameter ControlID="txtAsa" DefaultValue="" Name="ASA" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtUrgency" DefaultValue="" Name="Urgency" PropertyName="Text"
                                            Type="String" />
                                        <asp:Parameter DefaultValue="0" Name="Status" Type="Int32" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="String" />
                                        <asp:ControlParameter ControlID="DropDownListConsultant" Name="Consultant" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="ddlAnesthesia_Typ" Name="Anesthesia_Id" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="chkFitUnfit" Name="Fit_Unfit" PropertyName="Checked"
                                            Type="Int32" />
                                        <asp:QueryStringParameter Name="Order_Id" QueryStringField="Order_Id" 
                                            Type="Int32" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_Date" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style9" style="font-size: large; font-weight: bold;">
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="Button_Save" runat="server" Text="Save" Width="95px" />
                                <asp:Label ID="Label_Message" runat="server" CssClass="err"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9" style="font-size: large; font-weight: bold;">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style9" style="font-size: large; font-weight: bold;">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style9" style="font-size: large; font-weight: bold;">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style9" style="font-size: large; font-weight: bold;">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style9" style="font-size: large; font-weight: bold;">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style9" style="font-size: large; font-weight: bold;">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                </asp:Panel>
            </td>
    </table>
    <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>
</asp:Content>
