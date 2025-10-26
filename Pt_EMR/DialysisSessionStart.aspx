<%@ Page  Language="C#" MasterPageFile="~/hacims_masterpage_billing.master" AutoEventWireup="true" CodeFile="DialysisSessionStart.aspx.cs" Inherits="Pt_EMR_DialysisSessionStart" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .input_txt {
            width: 100px !Important;
        }
    </style>
    <script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
    <link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {

            $(".link_review").colorbox({ width: "1000px", height: "580px", iframe: true });
            $("#ctl00_ContentPlaceHolder1_TextBox_Remarks").focus();
        });



    </script>
    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
    <style type="text/css">
        .Grid_dynamic table td {
            border: 0;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="../css_hacims/cleditor/jquery.cleditor.css" />
    <script src="../css_hacims/ck.js" type="text/javascript"></script>
    <script type="text/javascript" src="../css_hacims/cleditor/jquery.cleditor.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br /><br />
      Schedules : <asp:DropDownList ID="ddlDialysisSession" runat="server" ></asp:DropDownList>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Pt_EMR/DialysisReport.aspx" Target="_blank" Text="View Report"></asp:HyperLink>

    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:30px;">
       <tr>
            
            <td style="width: auto;" valign="top">
                <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
                    <h2><span>Dialysis Session</span></h2>
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" style="text-align: center;">
                        <tr style="background-color: grey; color: white;">
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Date</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Dialysis #</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Dialyzer</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Dialysis Solution</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Dialysis Machine #</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Priming Solution</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Starting Time</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Finishing Time</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;"></th>
                        </tr>
                        <tr>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtSessionStartDate" runat="server" TextMode="Date" Style="width: 120px !Important;"> </asp:TextBox>

                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtDialysisNo" runat="server" TextMode="Number"></asp:TextBox>

                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtDialyzer" runat="server"></asp:TextBox>

                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtDiaSolution" runat="server"></asp:TextBox>

                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <%--<asp:TextBox ID="txtDiaMachineNo" runat="server"></asp:TextBox>--%>
                                <asp:DropDownList id="ddlDialysisMachineNo" runat="server" ></asp:DropDownList>

                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPriSolution" runat="server"></asp:TextBox>

                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtStartTime" runat="server" TextMode="Time"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtEndTime" runat="server" TextMode="Time"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:Button ID="btnSaveStartSession" runat="server" Text="Save" OnClick="btnSaveStartSession_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="bxmain inner_content" style="width: 100%">
                    <h2><span>Pre Dialysis</span></h2>
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" style="text-align: center;">
                        <tr style="background-color: grey; color: white;">
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Pulse</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">B.P.</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Temp</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">WT</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Respiration</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;"></th>
                        </tr>
                        <tr>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPrePulse" runat="server" TextMode="Number"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPreBP" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPreTemp" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPreWT" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPreRespiration" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:Button ID="btnSavePre" runat="server" Text="Save" OnClick="btnSavePre_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="bxmain inner_content" style="width: 100%;">
                    <h2><span>Intra Dialysis</span></h2>
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" style="text-align: center;">
                        <tr style="background-color: grey; color: white;">
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Time</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Pulse</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">B.P.</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">G.C</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Blood Flow</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">U.F. Target</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">U.F.Rate T.M.P</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">ART Pressure</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">VEN Pressure</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">HEPARIN</th>
                        </tr>
                        <tr>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtIDTime" runat="server" TextMode="Time"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtIDPulse" runat="server" TextMode="Number"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtIDBP" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtIDGC" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtIDBloodFlow" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtIDUFTarget" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtIDUFRate" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtIDARTPre" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtIDVENPre" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtIDHeparin" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="10">
                                <asp:Button ID="btnSaveIntraDia" runat="server" Text="Save" OnClick="btnSaveIntraDia_Click" />
                            </td>
                        </tr>

                    </table>
                    <asp:GridView ID="gvIntraDialysis" runat="server" EmptyDataText="No Record(s) Found." AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="IntraTime" HeaderText="Time" />
                            <asp:BoundField DataField="pulse" HeaderText="Pulse" />
                            <asp:BoundField DataField="BP" HeaderText="B.P." />
                            <asp:BoundField DataField="GC" HeaderText="G.C" />
                            <asp:BoundField DataField="BloodFlow" HeaderText="Blood Flow" />
                            <asp:BoundField DataField="UFTarget" HeaderText="UF Target" />
                            <asp:BoundField DataField="UFRateTMP" HeaderText="U.F. Rate T.M.P" />
                            <asp:BoundField DataField="ArtPressure" HeaderText="Art Pressure" />
                            <asp:BoundField DataField="VenPressure" HeaderText="Ven Pressure" />
                            <asp:BoundField DataField="Heparin" HeaderText="Heparin" />
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="bxmain inner_content" style="width: 100%">
                    <h2><span>Post Dialysis</span></h2>
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" style="text-align: center;">
                        <tr style="background-color: grey; color: white;">
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Pulse</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">B.P.</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Temp</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">WT</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Respiration</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;"></th>
                        </tr>
                        <tr>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPostPulse" runat="server" TextMode="Number"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPostBP" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPostTemp" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPostWT" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:TextBox ID="txtPostRespiration" runat="server"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid; text-align: center;">
                                <asp:Button ID="btnSavePost" runat="server" Text="Save" OnClick="btnSavePost_Click" />
                                <asp:HyperLink ID="hlfReport" runat="server" NavigateUrl="~/Pt_EMR/DialysisReport.aspx" Target="_blank" Text="View Report"></asp:HyperLink>

                            </td>
                        </tr>

                    </table>
                </div>
            </td>
        </tr>
    </table>
    <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
    <script type="text/javascript">
        var cookies = Spry.Utils.Cookie("read", "tabbedpanels_pr_complaints");
        var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
        Spry.Utils.addUnLoadListener(function () {
            // save the current value
            Spry.Utils.Cookie('create', 'tabbedpanels_pr_complaints', TabbedPanels1.getCurrentTabIndex());
        });
    </script>
</asp:Content>

