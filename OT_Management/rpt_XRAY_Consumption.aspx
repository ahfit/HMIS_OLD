<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="false" CodeFile="rpt_XRAY_Consumption.aspx.vb" Inherits="Radiology_rpt_XRAY_Consumption" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="Patient%20Billing/jQuery.print.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#hrefPrint").click(function () {
                // Print the DIV.
                $("#printdiv").print();
                return (false);
            });
        });
    </script>
    <style type="text/css">
        @media print
        {
            #logininfo
            {
                display: none;
            }
        
            #ctl00_Panel1
            {
                display: none;
            }
            #hrefPrint
            {
                display: none;
            }
            #LinkButtonx
            {
                display: none;
            }
        }
        
        .style1
        {
            width: 288px;
        }
        .style2
        {
            width: 188px;
        }
        .style3
        {
            width: 288px;
            text-align: right;
            font-weight: bold;
        }
        .style4
        {
            width: 188px;
            text-align: right;
            font-weight: bold;
        }
        .style5
        {
            font-family: "Segoe UI";
            font-size: medium;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        <%-- <strong>--%>
        <br />
        <%--</strong><span class="style5"><strong>Xray </strong></span><br />--%>
    </p>
    <table class="diagnosis_list">
        <tr>
            <td class="style3">
                &nbsp;
            </td>
            <td colspan="2">
                <asp:RadioButtonList ID="RadioButtonList_SpecificDate" runat="server" RepeatColumns="2">
                    <asp:ListItem Selected="True" Value="1">Specific Date</asp:ListItem>
                    <asp:ListItem Value="2">Between Date</asp:ListItem>
                </asp:RadioButtonList>
                <br />
                <br />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style3">
                Start Date:
            </td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_start_Date" runat="server" Width="202px"
                    CssClass="drop_date" AllowNull="False">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
            <td class="style4">
                End Date:
            </td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_End_Date" runat="server" Width="202px" CssClass="drop_date"
                    AllowNull="False">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td class="style3">
                MR #:
            </td>
            <td>
                <asp:TextBox ID="TextBox_MRNO" runat="server"></asp:TextBox>
            </td>
            <td class="style4">
                Visit #:
            </td>
            <td>
                <asp:TextBox ID="TextBox_VisitNo" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style3">
                Patient Type:
            </td>
            <td>
                <asp:DropDownList ID="DropDownList_Pt_Type" runat="server" DataSourceID="SqlDataSource_Pt_Type"
                    DataTextField="Patient_type" DataValueField="ID" Style="margin-left: 0px" Height="29px"
                    Width="185px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_Pt_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="
select 0 as ID , 'All' as Patient_type
union
SELECT DISTINCT Patient_Type.ID, Patient_Type.Patient_type
FROM         Patient_Type INNER JOIN
                      Patient_Type_HospitalWise ON Patient_Type.ID = Patient_Type_HospitalWise.Patient_Type_Id
where Patient_Type_HospitalWise.Hospital_Id=@Hospital_Id">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList_Hospital_Id" Name="Hospital_Id" PropertyName="SelectedValue"
                            DefaultValue="248" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="style4">
                Hospital
            </td>
            <td>
                <asp:DropDownList ID="DropDownList_Hospital_Id" runat="server" DataSourceID="SqlDataSource_Hospital_Id"
                    DataTextField="Hospital_Abb" DataValueField="Hospital_ID" Style="margin-left: 0px"
                    AutoPostBack="True" Height="33px" Width="185px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;
            </td>
            <td>
                <asp:RadioButtonList ID="RadioButtonList_IPDOPD" runat="server" Height="21px" RepeatColumns="3"
                    Width="137px">
                    <asp:ListItem Selected="True" Value="%">All</asp:ListItem>
                    <asp:ListItem>OPD</asp:ListItem>
                    <asp:ListItem>IPD</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td class="style2">
            </td>
            <td>
                <asp:SqlDataSource ID="SqlDataSource_Hospital_Id" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT Hospital_ID, Hospital_Abb FROM Hospital WHERE (Hospital_ID =@Hospital_Id)
ORDER BY Hospital_ID DESC">
                    <SelectParameters>
                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalId" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style3">
                Test Group :
            </td>
            <td>
                <asp:DropDownList ID="DropDownList_TestGroup" runat="server" DataSourceID="SqlDataSource_TestGroup"
                    DataTextField="TGNAME" DataValueField="TGID" Height="24px" Width="158px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_TestGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT TestGroup.TGID, TestGroup.TGName FROM TestGroup INNER JOIN TestGroup_HospitalWise ON TestGroup.TGID = TestGroup_HospitalWise.TGID WHERE (TestGroup_HospitalWise.Hospital_Id = @Hospital_Id)">
                    <SelectParameters>
                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="style2">
                <asp:Button ID="Button_Search" runat="server" Text="Search" Width="96px" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <p>
        <asp:HiddenField ID="HiddenField_StartDate" runat="server" />
        <asp:HiddenField ID="HiddenField_EndDate" runat="server" />
    </p>
    <p>
        <asp:LinkButton ID="LinkButtonx" class="excel_btn" runat="server" OnClick="LinkButton3_Click"
            Text="Excel">Export to Excel</asp:LinkButton>
    </p>
    <a href="javascript:window.print();" id="hrefPrint" title="Print" class="print_btn">
        Print</a>
    <p>
    </p>
    <p>
        <div id="printdiv" class="print">
            <asp:GridView ID="GridView_Adt_Discharge" runat="server" AutoGenerateColumns="False"
                CssClass="Grid_1" Width="100%" ShowFooter="True">
                <Columns>
                    <%--<asp:BoundField DataField="SNo" HeaderText="Sr #" />--%>
                  
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Sr #</HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblSRNO" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:BoundField DataField="Reg_No" HeaderText="MR #"></asp:BoundField>
                    <asp:BoundField DataField="Yearly_No" HeaderText="Visit #"></asp:BoundField>
                    <asp:BoundField DataField="Prefix" HeaderText="Patient Name"></asp:BoundField>
                    <asp:BoundField DataField="Relation" HeaderText="Relation" />
                    <asp:BoundField DataField="RelationName" HeaderText="Relation Name" />
                    <asp:BoundField DataField="Age_Gender" HeaderText="Age/Gender"></asp:BoundField>
                    <asp:BoundField DataField="Patient_type" HeaderText="Patient Type"></asp:BoundField>
                    <asp:BoundField DataField="IPDOPD" HeaderText="IPD/OPD" />
                    <asp:BoundField DataField="Department" HeaderText="Department"></asp:BoundField>
                    <asp:BoundField DataField="TB_Name" HeaderText="Test Name" />
                    <asp:BoundField DataField="BookingDate" HeaderText="Test Booking Date" />
                    <asp:BoundField DataField="AppointmentDate" HeaderText="Appointment Date" />
                    <asp:BoundField DataField="Item_Name" HeaderText="Film Size" />
                    <asp:BoundField DataField="Consumed_QTY" HeaderText="Film QTY" />
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                </Columns>
                <FooterStyle Font-Bold="True" />
            </asp:GridView>
        </div>
    </p>
    <p>
    </p>
    <p>
    </p>
    <p>
    </p>
</asp:Content>
