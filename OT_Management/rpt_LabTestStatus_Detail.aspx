<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="rpt_LabTestStatus_Detail.aspx.vb" Inherits="Pathology_rpt_LabTestStatus_Detail" %>


<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            text-align: right;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <br />
    </p>
    <table class="diagnosis_list">
        <tr>
            <td class="style1">
                Start Date:&nbsp; </td>
            <td>
                    <igsch:webdatechooser id="WebDateChooser_StartDate" runat="server" 
                        Height="25px" Width="163px"></igsch:webdatechooser>
                <asp:SqlDataSource ID="SqlDataSource_LabTestStatus" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" 
                    SelectCommand="Select_AllTestsStatus_Detail" 
                        SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_StartDate" Name="StartDate" 
                            PropertyName="Value" Type="String" />
                        <asp:ControlParameter ControlID="HiddenField_EndDate" Name="EndDate" 
                            PropertyName="Value" Type="String" />
                        <asp:ControlParameter ControlID="DropDownList_TestGroup" Name="TestGroup_Id" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" 
                            Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style1">
                End
                Date:</td>
            <td>
                    <igsch:webdatechooser id="WebDateChooser_EndDate" runat="server" 
                        Height="25px" Width="163px"></igsch:webdatechooser>
                </td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Test 
                Group : 
                &nbsp;</td>
            <td>
                <asp:DropDownList ID="DropDownList_TestGroup" runat="server" 
                    DataSourceID="SqlDataSource_TestGroup" DataTextField="TGNAME" 
                    DataValueField="TGID" Height="24px" Width="158px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_TestGroup" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:OT_ManagementConnectionString.ProviderName %>" 
                    
                    SelectCommand="SELECT TestGroup.TGID, TestGroup.TGName FROM TestGroup INNER JOIN TestGroup_HospitalWise ON TestGroup.TGID = TestGroup_HospitalWise.TGID WHERE (TestGroup_HospitalWise.Hospital_Id = @Hospital_Id)">
                    <SelectParameters>
                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td>
       <asp:Button ID="Button_Search" runat="server" Text="Search" Width="94px" />
            </td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td>
     <asp:LinkButton ID="LinkButtonx"  class="excel_btn" runat="server" OnClick="LinkButton3_Click"  Text="Excel">Export to Excel</asp:LinkButton> 
                <asp:HiddenField ID="HiddenField_StartDate" runat="server" />
                <asp:HiddenField ID="HiddenField_EndDate" runat="server" />
            </td>
        </tr>
    </table>
    <p>
    </p>


 <asp:GridView ID="GridView_LabTestStatus" runat="server" AutoGenerateColumns="False"
                                 Width="100%" ShowFooter="True" 
        EnableModelValidation="True" DataSourceID="SqlDataSource_LabTestStatus">
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                                <Columns>
                                    <asp:BoundField DataField="TB_Name" HeaderText="Tests/Investigations" 
                                        SortExpression="TB_Name">
                                    <ItemStyle Font-Bold="True" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Appointment" HeaderText="Appointment" 
                                        ReadOnly="True" SortExpression="Appointment" />
                                    <asp:BoundField DataField="Report" HeaderText="Perform Procedure/Reporting" 
                                        ReadOnly="True" SortExpression="Report" />
                                    <asp:BoundField DataField="Consumption" HeaderText="Item Consumption" 
                                        ReadOnly="True" SortExpression="Consumption" />
                                    <asp:BoundField DataField="Retake" HeaderText="Retake" ReadOnly="True" 
                                        SortExpression="Retake" />
                                    <asp:BoundField DataField="Test_Cancel" HeaderText="Test Cancel" 
                                        ReadOnly="True" SortExpression="Test_Cancel" />
                                    <asp:BoundField DataField="UnDelivered_Reports" 
                                        HeaderText="Un Delivered Reports" ReadOnly="True" 
                                        SortExpression="UnDelivered_Reports" />
                                    <asp:BoundField DataField="Deliver_Report" HeaderText="Deliver Report" 
                                        ReadOnly="True" SortExpression="Deliver_Report" />
                                </Columns>
     <FooterStyle CssClass="myfooter" />
                            </asp:GridView>
   
    <p>
    </p>
    <p>
    </p>
</asp:Content>



