<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="DischargeSummary.aspx.vb" Inherits="Pt_EMR_DischargeSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Patient%20Billing/jQuery.print.js" type="text/javascript"></script>
    <script type="text/javascript">

        function printDischargeSummary() {
            $("#divDischargeSummaryWrapper").print();
        }       
    </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" class="leftnav">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
            </td> 
            <td style="width: auto;" valign="top">
                <div align="right" id="mprint">
                    <span onclick="printDischargeSummary()" class="print_btn">Print</span>
                    <div id="divDischargeSummaryWrapper">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="center">
                                    <ul style="list-style: none; margin-top: 0px;">
                                        <li style="font-size: 18px; font-weight: bold;">
                                            <asp:Label runat="server" ID="lblHospitalName" Font-Size="Large"></asp:Label>
                                        </li>
                                        <li style="line-height: 18px; font-size: 15px; font-weight: bold;">
                                            <asp:Label ID="lblHospitalAddress" runat="server" Text=""></asp:Label>
                                        </li>
                                        <li style="line-height: 18px; font-size: 13px;">
                                            <asp:Label ID="lblHospitalPhone" runat="server" Text=""></asp:Label>
                                        </li>
                                        <li style="line-height: 18px; font-size: 15px; font-weight: bold;">
                                            <asp:Label ID="Label1" runat="server" Text="Discharge Summary"></asp:Label></li>
                                        <li style="line-height: 18px; font-size: 13px;">
                                            <asp:Label runat="server" ID="lblDate"></asp:Label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="style1">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%" style="margin-top: 8px;
                                        border: solid 1px #d5d2cd; border-collapse: collapse; background-color: #FFFFF;">
                                        <tr>
                                            <td width="20%" align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse;
                                                padding: 3px; font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF;
                                                vertical-align: top;">
                                                <b>Mr # :</b>
                                            </td>
                                            <td width="30%" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblMRNo" runat="server"></asp:Label>
                                            </td>
                                            <td width="20%" align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse;
                                                padding: 3px; font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF;
                                                vertical-align: top;">
                                                <b>Data Of Admission :</b>
                                            </td>
                                            <td width="30%" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblDateAdmission" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <b>File No :</b>
                                            </td>
                                            <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblFileNo" runat="server"></asp:Label>
                                            </td>
                                            <td align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <b>Date Of Discharge :</b>
                                            </td>
                                            <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblDataDischarge" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <b>Patient Name :</b>
                                            </td>
                                            <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                                            </td>
                                            <td align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <b>Ward / Room # :</b>
                                            </td>
                                            <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblWardRoomNo" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <b>Age :</b>
                                            </td>
                                            <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblAge" runat="server"></asp:Label>
                                            </td>
                                            <td align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <b>Admiting Doctor :</b>
                                            </td>
                                            <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblAdmitingDoctor" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <b>Sex :</b>
                                            </td>
                                            <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblGender" runat="server"></asp:Label>
                                            </td>
                                            <td align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <b>Email :</b>
                                            </td>
                                            <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <b>Contact # :</b>
                                            </td>
                                            <td colspan="3" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblContactNo" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <b>Address :</b>
                                            </td>
                                            <td colspan="3" style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px;
                                                font-size: 13px; height: 22px; border-top: 0px; background-color: #FFFFF; vertical-align: top;">
                                                <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h1 style="height: 22px; width: 100%; background-color: #eee; margin: 10px 0; border: #dcdcdc solid 1px;
                                        -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px; -webkit-box-shadow: 0px 1px 0px #dcdcdc;
                                        -moz-box-shadow: 0px 1px 0px #dcdcdc; box-shadow: 0px 1px 0px #dcdcdc;">
                                        <span style="font-size: 13px; color: #1a4796; line-height: 22px; padding-left: 12px;
                                            margin-left: 10px; font-weight: bold; text-shadow: 1px 1px 0px #fff;">Known Allergy
                                            / Other Adverse Reaction</span></h1>
                                    <div style="float: left; width: 46%; margin-left: 2%;">
                                        <h1 style="height: 20px; margin: 10px 0; border-bottom: #dcdcdc dashed 1px; font-size: 13px;
                                            color: brown; font-weight: bold;">
                                            Known Allergy</h1>
                                        <div id="divAllergies" runat="server" style="line-height: 25px;font-size: 13px;">
                                        </div>
                                    </div>
                                    <div style="float: left; width: 48%; margin-left: 3%;">
                                        <h1 style="height: 20px; margin: 10px 0; border-bottom: #dcdcdc dashed 1px; font-size: 13px;
                                            color: brown; font-weight: bold;">
                                            Other Adverse Reaction</h1>
                                        <div id="divAdverseReaction" runat="server" style="line-height: 25px;font-size: 13px;">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h1 style="height: 22px; width: 100%; background-color: #eee; margin-bottom: 10px;
                                        margin-top: 10px; display: block; border: #dcdcdc solid 1px; -webkit-border-radius: 6px;
                                        -moz-border-radius: 6px; border-radius: 6px; -webkit-box-shadow: 0px 1px 0px #dcdcdc;
                                        -moz-box-shadow: 0px 1px 0px #dcdcdc; box-shadow: 0px 1px 0px #dcdcdc;">
                                        <span style="font-size: 13px; color: #1a4796; line-height: 22px; padding-left: 12px;
                                            margin-left: 10px; font-weight: bold; text-shadow: 1px 1px 0px #fff;">Chief Complaint</span></h1>
                                    <table style="width: 98%; border: solid 1px #d5d2cd; border-collapse: collapse; background-color: #FFFFF;
                                        margin: 0 auto;">
                                        <%--<thead>
                                            <tr>
                                                <th style="width: 25%; border: solid 1px #d5d2cd; border-bottom: solid 1px #ccc;
                                                    border-collapse: collapse; background-color: lightblue; padding: 0px; font-size: 11px;
                                                    height: 28px; padding-left: 4px; padding-right: 4px; font-weight: bold; border-bottom: solid 1px #fff;
                                                    text-shadow: 1px 1px 0px #ededed;">
                                                    Complaint
                                                </th>
                                                <th style="border: solid 1px #d5d2cd; border-bottom: solid 1px #ccc; border-collapse: collapse;
                                                    background-color: lightblue; padding: 0px; : 11px; height: 28px; padding-left: 4px;
                                                    padding-right: 4px; font-weight: bold; border-bottom: solid 1px #fff; text-shadow: 1px 1px 0px #ededed;">
                                                    Remarks
                                                </th>
                                            </tr>
                                        </thead>--%>
                                        <tbody id="tbodyComplaintRemarks">
                                            <asp:Repeater ID="rptComplaint" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                            height: 22px; border-top: 0px; background-color: aliceblue; vertical-align: middle;
                                                            line-height: 25px;width:25%;">
                                                            <%# Eval("ParameterName") %>
                                                        </td>
                                                        <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                            height: 22px; border-top: 0px; background-color: aliceblue; vertical-align: middle;
                                                            line-height: 25px;">
                                                            <%# Eval("ParameterValue")%>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h1 style="height: 22px; width: 100%; background-color: #eee; margin-bottom: 10px;
                                        margin-top: 10px; display: block; border: #dcdcdc solid 1px; -webkit-border-radius: 6px;
                                        -moz-border-radius: 6px; border-radius: 6px; -webkit-box-shadow: 0px 1px 0px #dcdcdc;
                                        -moz-box-shadow: 0px 1px 0px #dcdcdc; box-shadow: 0px 1px 0px #dcdcdc;">
                                        <span style="font-size: 13px; color: #1a4796; line-height: 22px; padding-left: 12px;
                                            margin-left: 10px; font-weight: bold; text-shadow: 1px 1px 0px #fff;">History</span></h1>
                                    <table style="width: 98%; border: solid 1px #d5d2cd; border-collapse: collapse; background-color: #FFFFF;
                                        margin: 0 auto;">
                                        <thead>
                                            <tr>
                                                <th style="width: 25%; border: solid 1px #d5d2cd; border-bottom: solid 1px #ccc;
                                                    border-collapse: collapse; background-color: lightblue; padding: 0px; font-size: 11px;
                                                    height: 28px; padding-left: 4px; padding-right: 4px; font-weight: bold; border-bottom: solid 1px #fff;
                                                    text-shadow: 1px 1px 0px #ededed;">
                                                    History
                                                </th>
                                                <th style="border: solid 1px #d5d2cd; border-bottom: solid 1px #ccc; border-collapse: collapse;
                                                    background-color: lightblue; padding: 0px; font-size: 11px; height: 28px; padding-left: 4px;
                                                    padding-right: 4px; font-weight: bold; border-bottom: solid 1px #fff; text-shadow: 1px 1px 0px #ededed;">
                                                    Remarks
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyHistory">
                                            <asp:Repeater ID="rptHistory" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                            height: 22px; border-top: 0px; background-color: aliceblue; vertical-align: middle;
                                                            line-height: 25px;">
                                                            <%# Eval("ParameterName") %>
                                                        </td>
                                                        <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                            height: 22px; border-top: 0px; background-color: aliceblue; vertical-align: middle;
                                                            line-height: 25px;">
                                                            <%# Eval("ParameterValue")%>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h1 style="height: 22px; width: 100%; background-color: #eee; margin: 10px 0; border: #dcdcdc solid 1px;
                                        -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px; -webkit-box-shadow: 0px 1px 0px #dcdcdc;
                                        -moz-box-shadow: 0px 1px 0px #dcdcdc; box-shadow: 0px 1px 0px #dcdcdc;">
                                        <span style="font-size: 13px; color: #1a4796; line-height: 22px; padding-left: 12px;
                                            margin-left: 10px; font-weight: bold; text-shadow: 1px 1px 0px #fff;">Hospital Admited
                                            Diagnosis</span></h1>
                                    <div style="width: 1025px; margin-left: 24px;">
                                        <asp:Repeater runat="server" ID="rptAdmitedDiagnosis">
                                            <ItemTemplate>
                                                <div style="border-bottom: dotted 1px #ddd; padding: 5px 0; font-size: 13px; line-height: 20px;font-size: 13px;">
                                                    <%# Eval("ParameterName") %></div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h1 style="height: 22px; width: 100%; background-color: #eee; margin: 10px 0; border: #dcdcdc solid 1px;
                                        -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px; -webkit-box-shadow: 0px 1px 0px #dcdcdc;
                                        -moz-box-shadow: 0px 1px 0px #dcdcdc; box-shadow: 0px 1px 0px #dcdcdc;">
                                        <span style="font-size: 13px; color: #1a4796; line-height: 22px; padding-left: 12px;
                                            margin-left: 10px; font-weight: bold; text-shadow: 1px 1px 0px #fff;">Outcome</span></h1>
                                    <div style="width: 1025px; margin-left: 24px;">
                                        <asp:Repeater runat="server" ID="rptDischargeDiagnosis">
                                            <ItemTemplate>
                                                <div style="border-bottom: dotted 1px #ddd; padding: 5px 0; font-size: 13px; line-height: 20px;font-size: 13px;">
                                                    <%# Eval("ParameterName") %></div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <h1 style="height: 22px; width: 100%; background-color: #eee; margin: 10px 0; border: #dcdcdc solid 1px;
                                        -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px; -webkit-box-shadow: 0px 1px 0px #dcdcdc;
                                        -moz-box-shadow: 0px 1px 0px #dcdcdc; box-shadow: 0px 1px 0px #dcdcdc;">
                                        <span style="font-size: 13px; color: #1a4796; line-height: 22px; padding-left: 12px;
                                            margin-left: 10px; font-weight: bold; text-shadow: 1px 1px 0px #fff;">Hospital Course</span></h1>
                                    <h1 style="width: 1025px; height: 20px; margin: 10px 0 10px 24px; border-bottom: #dcdcdc dashed 1px;
                                        font-size: 13px; color: brown; font-weight: bold;">
                                        Laboratory Findings</h1>
                                    <div style="width: 1025px; margin-left: 24px;">
                                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                            <tbody>
                                                <asp:Repeater ID="rptTestResultsOuter" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <h1 style="height: 20px; border-bottom: #dcdcdc dotted 1px; font-size: 14px; color: #1a4796;
                                                                    font-weight: bold;margin:10px 0;">
                                                                    <span style="color: mediumseagreen;">
                                                                        <%# Eval("TestName") %></span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table class="tableDischargeSummary" cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                    <thead>
                                                                        <tr class="table-th" style="line-height: 25px;">
                                                                            <th style="text-align: left; width: 30%; font-weight: bold;">
                                                                                Component
                                                                            </th>
                                                                            <th style="text-align: left; width: 25%; font-weight: bold;">
                                                                                Results
                                                                            </th>
                                                                            <th style="text-align: left; width: 25%; font-weight: bold;">
                                                                                Ref. Value
                                                                            </th>
                                                                            <th style="text-align: left; width: 20%; font-weight: bold;">
                                                                                Unit
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <asp:Repeater ID="rptTestResultsInner" runat="server" DataSource='<%#Container.DataItem.Row.GetChildRows("results")%>'>
                                                                            <ItemTemplate>
                                                                                <tr style="line-height: 25px;font-size: 13px;">
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
                                    </div>
                                    <h1 style="width: 1025px; height: 20px; margin: 15px 0 10px 24px; border-bottom: #dcdcdc dashed 1px;
                                        font-size: 13px; color: cornflowerblue; font-weight: bold;">
                                        Radiology Findings</h1>
                                    <div style="width: 1025px; margin-left: 24px;">
                                        <asp:Repeater runat="server" ID="rptRadiologyFindings">
                                            <ItemTemplate>
                                                <div style="font-size: 13px;margin:10px 0;">
                                                    <span style="font-weight: bold; color: darkmagenta; ">
                                                        <%# Eval("ParameterName") %>:</span>
                                                    <%# Eval("ParameterValue") %></div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <h1 style="width: 1025px; height: 20px; margin: 15px 0 10px 24px; border-bottom: #dcdcdc dashed 1px;
                                        font-size: 13px; color: #1a4796; font-weight: bold;">
                                        Medication</h1>
                                    <div style="padding: 5px 0; width: 1025px; margin-left: 24px;">
                                        <table style="border: dotted 1px #ddd; border-radius: 3px; line-height: 27px; width: 90%;
                                            margin: 0 auto;">
                                            <asp:Repeater ID="rptMedication" runat="server">
                                                <ItemTemplate>
                                                    <tr style="font-size: 13px;">
                                                        <td>
                                                            <%# Eval("MedicineName")%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("ParaUrdu")%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("StartDate")%>
                                                            -
                                                            <%# Eval("EndDate")%>
                                                        </td>
                                                        <td>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                    <h1 style="width: 1025px; height: 20px; margin: 15px 0 10px 24px; border-bottom: #dcdcdc dashed 1px;
                                        font-size: 13px; color: teal; font-weight: bold;">
                                        Summary of Consultation</h1>
                                    <div style=" width: 1025px; margin-left: 24px;">
                                        <asp:Repeater runat="server" ID="rptConsultation">
                                            <ItemTemplate>
                                                <div style="font-size: 13px;line-height:20px;">
                                                    <%# Eval("ParameterValue") %></div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <h1 style="width: 1025px; height: 20px; margin: 15px 0 10px 24px; border-bottom: #dcdcdc dashed 1px;
                                        font-size: 13px; color: purple; font-weight: bold;">
                                        Procedure</h1>
                                    <div style="padding: 5px 0; width: 1025px; margin-left: 24px;">
                                        <table id="tblDischargeSummaryProcedures" class="Grid_DischargeSummary" style="width: 98%;
                                            border: solid 1px #d5d2cd; border-collapse: collapse; background-color: #FFFFF;
                                            margin: 0 auto;">
                                            <thead>
                                                <tr>
                                                    <th style="width: 50%; border: solid 1px #d5d2cd; border-bottom: solid 1px #ccc;
                                                        border-collapse: collapse; background-color: lightblue; padding: 0px; font-size: 11px;
                                                        height: 28px; padding-left: 4px; padding-right: 4px; font-weight: bold; border-bottom: solid 1px #fff;
                                                        text-shadow: 1px 1px 0px #ededed;">
                                                        Procedure Name
                                                    </th>
                                                    <th style="border: solid 1px #d5d2cd; border-bottom: solid 1px #ccc; border-collapse: collapse;
                                                        background-color: lightblue; padding: 0px; font-size: 11px; height: 28px; padding-left: 4px;
                                                        padding-right: 4px; font-weight: bold; border-bottom: solid 1px #fff; text-shadow: 1px 1px 0px #ededed;">
                                                        Remarks
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptProcedure" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                                height: 22px; border-top: 0px; background-color: aliceblue; vertical-align: middle;">
                                                                <%# Eval("ParameterName") %>
                                                            </td>
                                                            <td style="border: solid 1px #d5d2cd; border-collapse: collapse; padding: 3px; font-size: 13px;
                                                                height: 22px; border-top: 0px; background-color: aliceblue; vertical-align: middle;">
                                                                <%# Eval("ParameterValue")%>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <h1 style="height: 22px; width: 100%; background-color: #eee; margin: 10px 0; border: #dcdcdc solid 1px;
                                        -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px; -webkit-box-shadow: 0px 1px 0px #dcdcdc;
                                        -moz-box-shadow: 0px 1px 0px #dcdcdc; box-shadow: 0px 1px 0px #dcdcdc;">
                                        <span style="font-size: 13px; color: #1a4796; line-height: 22px; padding-left: 12px;
                                            margin-left: 10px; font-weight: bold; text-shadow: 1px 1px 0px #fff;">Plan Of Care</span></h1>
                                    <h1 style="width: 1025px; color: mediumseagreen; height: 20px; margin: 10px 0 10px 24px;
                                        border-bottom: #dcdcdc dashed 1px; font-size: 13px; font-weight: bold;">
                                        Hospital Discharge Medication</h1>
                                    <div style="width: 1025px; margin-left: 24px;">
                                        <table style="width: 100%;line-height:30px;">
                                            <asp:Repeater ID="rptDischargeMedication" runat="server">
                                                <ItemTemplate>
                                                    <tr style="line-height:25px;">
                                                        <td style="border-bottom: dotted 1px #ddd;font-size: 13px;">
                                                            <%# Eval("ParameterValue") %>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                    <h1 style="width: 1025px; height: 20px; margin: 10px 0 10px 24px; border-bottom: #dcdcdc dashed 1px;
                                        font-size: 13px; color: Maroon; font-weight: bold;">
                                        Instruction</h1>
                                    <div style=" width: 1025px; margin-left: 24px;">
                                        <asp:Repeater runat="server" ID="rptInstruction">
                                            <ItemTemplate>
                                                <div style="padding: 5px 0; font-size: 13px;line-height:20px;">
                                                    <%# Eval("ParameterValue") %></div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h1 style="height: 22px; width: 100%; background-color: #eee; margin: 10px 0; border: #dcdcdc solid 1px;
                                        -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px; -webkit-box-shadow: 0px 1px 0px #dcdcdc;
                                        -moz-box-shadow: 0px 1px 0px #dcdcdc; box-shadow: 0px 1px 0px #dcdcdc;">
                                        <span style="font-size: 13px; color: #1a4796; line-height: 22px; padding-left: 12px;
                                            margin-left: 10px; font-weight: bold; text-shadow: 1px 1px 0px #fff;">Author (Physician)</span></h1>
                                    <div style="margin-left: 25px;font-size: 13px; font-weight:bold;">
                                        <asp:Label ID="lblPhysicianId" runat="server" Style="color: navy;"></asp:Label></div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
