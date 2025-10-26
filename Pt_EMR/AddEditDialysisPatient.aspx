<%@ Page  Language="C#" MasterPageFile="~/hacims_masterpage_billing.master" AutoEventWireup="true" CodeFile="AddEditDialysisPatient.aspx.cs" Inherits="Dialysis_AddEditDialysisPatient" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        textarea {
            resize: none;
        }
        /*.drop_down
        {
            width:120px !Important;
        }*/
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
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:30px;">
        <tr>
            
            <td style="width: auto;" valign="top">
                <div class="bxmain inner_content" style="width: 98%; margin-bottom: 10px;">
                    <h2><span>Dialysis Patient Information</span></h2>
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                        <tr>
                            <td align="right" width="20%">Date : 
                            </td>
                            <td align="left" width="30%">
                                <asp:TextBox ID="txtRegDate" runat="server" TextMode="Date"></asp:TextBox>
                            </td>
                            <td align="right" width="20%">Ideal Body Weight : 
                            </td>
                            <td align="left" width="30%">
                                <asp:TextBox ID="txtWeight" runat="server" Width="202px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="20%">Blood Group : 
                            </td>
                            <td align="left" width="30%">
                                <asp:DropDownList ID="ddlBloodGroup" runat="server">
                                    <asp:ListItem Selected="True" Text="----- Select -----" Value="Not Done"></asp:ListItem>
                                    <asp:ListItem Text="A +ve" Value="A +ve"></asp:ListItem>
                                    <asp:ListItem Text="B +ve" Value="B +ve"></asp:ListItem>
                                    <asp:ListItem Text="AB +ve" Value="AB +ve"></asp:ListItem>
                                    <asp:ListItem Text="O +ve" Value="O +ve"></asp:ListItem>
                                    <asp:ListItem Text="A -ve" Value="A -ve"></asp:ListItem>
                                    <asp:ListItem Text="B -ve" Value="B -ve"></asp:ListItem>
                                    <asp:ListItem Text="AB -ve" Value="AB -ve"></asp:ListItem>
                                    <asp:ListItem Text="O -ve" Value="O -ve"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="right" width="20%">Cause of Renal Failure : 
                            </td>
                            <td align="left" width="30%">
                                <asp:DropDownList ID="ddlFailureCause" runat="server" Width="204px">
                                    <asp:ListItem Enabled="true" Text="------ Select -----" Value="No"></asp:ListItem>
                                    <asp:ListItem Text="End Stage Renal Disease (ESRD)" Value="End Stage Renal Disease (ESRD)"></asp:ListItem>
                                    <asp:ListItem Text="Acute Renal Failure (ARF) / Acute on CRF" Value="Acute Renal Failure (ARF) / Acute on CRF"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="20%">Diagnosis : 
                            </td>
                            <td align="left" colspan="3" width="80%">
                                <asp:TextBox ID="txtDiagnosis" runat="server" TextMode="MultiLine" Width="82%" Height="40px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>

                            <td align="center" colspan="4" width="100%">
                                <asp:Button ID="btnSaveMainDialysis" runat="server" Text="Save" OnClick="btnSaveMainDialysis_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="bxmain inner_content" style="width: 98%; margin-bottom: 10px; max-height:200px; overflow-x:auto;">
                    <h2><span>Hepatitis Serology</span></h2>
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="99%" style="border-color: black; border-width: 1px; border-style: solid; margin-bottom:5px;">
                        <tr style="background-color: grey; color: white;">
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Date</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">HBsAg</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Anti HCV</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">Anti HBs</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">HCV PCR</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;">HBoV</th>
                            <th style="font-weight: bold; text-align: center; border-color: black; border-width: 1px; border-style: solid;"></th>
                        </tr>
                        <tr style="text-align:center;">
                            <td style="border-color: black; border-width: 1px; border-style: solid;">
                                <asp:TextBox ID="txtHSDate" runat="server" TextMode="Date" Width="120px"></asp:TextBox>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid;">
                                <asp:DropDownList ID="ddlHBsAg" runat="server" Width="120px">
                                    <asp:ListItem Selected="True" Text="" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Recative" Value="Recative"></asp:ListItem>
                                    <asp:ListItem Text="Non-Recative" Value="Non-Recative"></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid;">
                                <asp:DropDownList ID="ddlAntiHCV" runat="server" Width="120px">
                                    <asp:ListItem Selected="True" Text="" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Recative" Value="Recative"></asp:ListItem>
                                    <asp:ListItem Text="Non-Recative" Value="Non-Recative"></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid;">
                                <asp:DropDownList ID="ddlAntiHBs" runat="server" Width="120px">
                                    <asp:ListItem Selected="True" Text="" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Recative" Value="Recative"></asp:ListItem>
                                    <asp:ListItem Text="Non-Recative" Value="Non-Recative"></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid;">
                                <asp:DropDownList ID="ddlHCVPCR" runat="server" Width="120px">
                                    <asp:ListItem Selected="True" Text="" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Recative" Value="Recative"></asp:ListItem>
                                    <asp:ListItem Text="Non-Recative" Value="Non-Recative"></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid;">
                                <asp:DropDownList ID="ddlHBoV" runat="server" Width="120px">
                                    <asp:ListItem Selected="True" Text="" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Recative" Value="Recative"></asp:ListItem>
                                    <asp:ListItem Text="Non-Recative" Value="Non-Recative"></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="border-color: black; border-width: 1px; border-style: solid;">
                                <asp:Button ID="btnSaveHepatitisSerology" runat="server" Text="Save" OnClick="btnSaveHepatitisSerology_Click" />
                            </td>
                        </tr>
                        
                    </table>
                    <asp:GridView ID="gvHepatitisSerolorgy" runat="server" AutoGenerateColumns="false">
                        <Columns>
                           
                            <asp:BoundField DataField="HSDate" HeaderText="Date" />
                            <asp:BoundField DataField="HBsAg" HeaderText="HBsAg" />
                            <asp:BoundField DataField="AntiHCV" HeaderText="Anti HCV" />
                            <asp:BoundField DataField="AntiHBs" HeaderText="Anti HBs" />
                            <asp:BoundField DataField="HCVPCR" HeaderText="HCV PCR" />
                            <asp:BoundField DataField="HBoV" HeaderText="HBoV" />
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="bxmain inner_content" style="width: 98%">
                    <h2><span>Schedule</span></h2>
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                        <tr>
                            <td align="right" width="20%">Schedule Start Date : 
                            </td>
                            <td align="left" width="30%">
                                <igsch:WebDateChooser ID="wdcSStartDate" runat="server" CssClass="drop_down" Width="202px">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                            <td align="right" width="20%">Schedule End Date : 
                            </td>
                            <td align="left" width="30%">
                                <igsch:WebDateChooser ID="wdcSEndDate" runat="server" CssClass="drop_down" Width="202px">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="20%">Days : 
                            </td>
                            <td align="left" width="30%">
                                <asp:CheckBoxList ID="chkDays" runat="server" RepeatDirection="Horizontal" DataTextField="Day_Name" DataValueField="Day_ID">
                                </asp:CheckBoxList>
                            </td>
                            <td align="right" width="20%">Shift : 
                            </td>
                            <td align="left" width="30%">
                                <asp:DropDownList ID="ddlShift" runat="server" DataValueField="ShiftID" DataTextField="ShiftName">
                                </asp:DropDownList>
                                
                            </td>
                        </tr>
                        <tr style="margin-top: 10px;">
                            <td align="center" colspan="4">
                                <asp:Button ID="btnSaveScheduler" runat="server" Text="Save" OnClick="btnSaveScheduler_Click" />
                                <asp:Button ID="btnSaveAll" runat="server" Text="Save All" OnClick="btnSaveAll_Click" />                               
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

