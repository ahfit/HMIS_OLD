<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="DischargeSummarySegments.aspx.vb" Inherits="Controls_DischargeSummarySegments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartLabortoryFindings#
    <table cellpadding="0" cellspacing="0" style="width: 100%;">
        <tbody>
            <asp:Repeater ID="rptTestResultsOuter" runat="server">
                <ItemTemplate>
                    <tr>  
                        <td>
                            <h1 style="height: 20px; border-bottom: #dcdcdc dashed 1px; font-size: 14px; color: #1a4796;
                                font-weight: bold;">
                                <span style="color: mediumseagreen;">
                                    <%# Eval("TestName") %></span> 
                        </td> 
                    </tr>
                    <tr>
                        <td>
                            <table class="tableDischargeSummary" cellpadding="0" cellspacing="0" style="width: 100%;">
                                <thead>
                                    <tr class="table-th">
                                        <th style="text-align: left; width: 30%;">
                                            Component
                                        </th>
                                        <th style="text-align: left; width: 25%;">
                                            Results
                                        </th>
                                        <th style="text-align: left; width: 25%;">
                                            Ref. Value
                                        </th>
                                        <th style="text-align: left; width: 20%;">
                                            Unit
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptTestResultsInner" runat="server" DataSource='<%#Container.DataItem.Row.GetChildRows("results")%>'>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%#Container.DataItem("ComponentName")%>
                                                </td>
                                                <td>
                                                    <%#Container.DataItem("PatientValue")%>
                                                </td>
                                                <td>
                                                    <%#Container.DataItem("RefValue")%>
                                                </td>
                                                <td>
                                                    <%#Container.DataItem("Unit")%>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>
    #EndLabortoryFindings# #StartRadiologyFindings#
    <asp:Repeater runat="server" ID="rptRadiologyFindings">
        <ItemTemplate>
            <div style="padding-bottom: 10px; font-size: 13px;">
                <span style="font-weight: bold; color: darkmagenta;font-size: 12px;">
                    <%# Eval("ParameterName") %>:</span>
                <%# Eval("ParameterValue") %></div>
        </ItemTemplate>
    </asp:Repeater>
    #EndRadiologyFindings# #StartAllergy#
    <asp:Literal runat="server" ID="ltrAllergy"></asp:Literal>
    #EndAllergy# #StartReaction#  
    <asp:Literal runat="server" ID="ltrReaction"></asp:Literal>
    #EndReaction# #StartDischargeSumaryComplaints#
    <asp:Repeater ID="rptComplaintRemarks" runat="server">
        <ItemTemplate>
            <tr>
                <td style="background-color: aliceblue; vertical-align: middle;line-height: 25px;">
                    <%# Eval("ParameterName") %>
                </td>
                <td style="background-color: aliceblue; vertical-align: middle;line-height: 25px;">
                    <%# Eval("ParameterValue")%>
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    #EndDischargeSumaryComplaints# #StartDischargeSumaryHistory#
    <asp:Repeater ID="rptHistory" runat="server">
        <ItemTemplate>
            <tr>
                <td style="background-color: aliceblue; vertical-align: middle;line-height: 25px;">
                    <%# Eval("ParameterName") %>
                </td>
                <td style="background-color: aliceblue; vertical-align: middle;line-height: 25px;">
                    <%# Eval("ParameterValue")%>
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    #EndDischargeSumaryHistory# #StartComplaintRemarks#
    <asp:Literal runat="server" ID="ltrComplaint"></asp:Literal>
    #EndComplaintRemarks# #StartHistoryRemarks#
    <asp:Literal runat="server" ID="ltrHistoryRemarks"></asp:Literal>
    #EndHistoryRemarks# #StartRadiologyTestResults#
    <asp:Literal runat="server" ID="ltrRadiologyTestResults"></asp:Literal>
    #EndRadiologyTestResults# #StartGetInstructions#
    <asp:Repeater ID="rptInstructions" runat="server">
        <ItemTemplate>
            <tr>
                <td>
                    <%# Eval("EngInstruction")%>
                </td>
                <td>
                    <%# Eval("UrduInstruction")%>
                </td>
                <td style="text-align: center;">
                    <input type="checkbox" id="chkStatus" checked="checked" onclick="changeInstructinStatus('<%# Eval("InstId")%>',this);" />
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    #EndGetInstructions# #StartGetCategory#
    <asp:Literal ID="ltrRoute" runat="server" Text=""></asp:Literal>
    #EndGetCategory# #StartGetRoute#
    <asp:DropDownList ID="DropDownList_route" runat="server" Width="60px">
    </asp:DropDownList>
    #EndGetRoute# #StartFrequencyDetails#
    <asp:DataList ID="DataList_Frequency" runat="server"  RepeatDirection="Horizontal"
        Height="24px" style="border: solid 1px #ccc;">
        <ItemTemplate>
            <div class="medbg">
                <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block;
                    font-family: arial; font-size: 9px;"></asp:Label>
                <asp:TextBox ID="TextBox_dosage2" runat="server" Width="30px" Style="height: 12px;
                    display: inline;">1</asp:TextBox>
                <asp:HiddenField ID="HF_F_S_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
            </div>
        </ItemTemplate>
    </asp:DataList>
    #EndFrequencyDetails# #StartPatientMedications#
    <asp:DataList ID="DataList_ConfirmedPrescriptions" runat="server" Style="margin-left: 15px"
        Width="100%" Height="16px">
        <ItemTemplate> 
            <ul class="medication_cnt">
                <%--<li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                    class="mname">
                    <%# Eval("[Medicine Name]") %>
                    <%#Eval("Para")%>
                </strong>
                    <%#Eval("para_Urdu")%>
                </li>--%>
                <span style="font-weight: bold; color:#000;"><%#Eval("Medication")%></span>                                        
            </ul>
        </ItemTemplate>
    </asp:DataList>
    #EndPatientMedications# #StartPatientDiagnosis#
     <asp:Repeater ID="rptDiagnosis" runat="server">
                        <ItemTemplate>
                            <tr style="line-height:25px;">
                                <td style="border-bottom:dotted 1px #ccc;">
                                    <strong>
                                        <asp:Label ID="lblDiagnosisName" runat="server" Text='<%# Eval("[ICD Name]") %>'></asp:Label>
                                    </strong>                                                                      
                                </td>
                                <td>
                                 <span style="padding-left: 20px;">
                                <asp:CheckBox ID="chkAdmission" runat="server" Text="Admission Diagnosis" />
                                        <asp:CheckBox ID="chkDischarge" runat="server" Text="Discharge Diagnosis" />
                                         </span>
                                        </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
    #EndPatientDiagnosis# #StartGetDischargeInstructions#
    <asp:Repeater runat="server" ID="rptDischargeInstruction">
        <ItemTemplate>
            <tr>
                <td style="background-color: aliceblue; vertical-align: middle;">
                    <%# Eval("ParameterValue") %>
                    <td style="background-color: aliceblue; vertical-align: middle;">
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    #EndGetDischargeInstructions# #StartDiagnosis#
    <asp:Repeater ID="rptDischargeSummaryDiagnosis" runat="server">
        <ItemTemplate>
            <tr>
                <td style="background-color: aliceblue; vertical-align: middle;">
                    <%# Eval("ParameterName") %>
                </td>
                <td style="background-color: aliceblue; vertical-align: middle;">
                    <%# Eval("MainCategory")%>
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    #EndDiagnosis#
</asp:Content>
