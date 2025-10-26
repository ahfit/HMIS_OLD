<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_PatientEpisodes.aspx.vb" MasterPageFile="~/hacims_masterpage.master"
    Inherits="Pt_EMR_Pt_PatientEpisodes" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
   <script type="text/javascript" src="jquery-1.12.3.js"></script>
    <script type="text/javascript" src="jquery-ui.js"></script>

    <script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>

    <link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />

    <script src="../css_hacims/ck.js" type="text/javascript"></script>

    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" class="leftnav" style="display: none;">
                <asp:Label ID="LabelSideMenu" runat="server" Visible="false"></asp:Label>
                <asp:Panel ID="Panel1" runat="server" Visible="False">
                </asp:Panel>
            </td>
            <td valign="top" style="width: 972px">

                <asp:GridView ID="gv_PatientVisits" runat="server" AutoGenerateColumns="False"
                    DataSourceID="sds_PatientVisits" Width="100%">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkBtnView" runat="server" Text="View" CommandArgument='<%# Eval("VisitNo") %>' CommandName='<%# Eval("RegNo") %>' OnClick="lnkBtnView_Click">
                                </asp:LinkButton>
                                
                            </ItemTemplate>
                            <ItemStyle Width="5%" />
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkBtnPrint" runat="server" Text="Print" CommandArgument='<%# Eval("VisitNo") %>' CommandName='<%# Eval("RegNo") %>' OnClick="lnkBtnPrint_Click">
                                </asp:LinkButton>
                                <asp:HiddenField ID="HfRegNo" runat="server" Value="" />
                            </ItemTemplate>
                            <ItemStyle Width="5%" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Appointmant_DateTime" HeaderText="Date" ItemStyle-HorizontalAlign="Center" SortExpression="Appointmant_DateTime" />
                        <asp:BoundField DataField="Appointment_Time" HeaderText="Time" ItemStyle-HorizontalAlign="Center" SortExpression="Appointment_Time" />
                        <asp:BoundField DataField="ForDoctor" HeaderText="Scheduled To See" ItemStyle-HorizontalAlign="Center" SortExpression="ForDoctor" />
                        <asp:BoundField DataField="Nature" HeaderText="Visit Type" ItemStyle-HorizontalAlign="Center" SortExpression="Nature" />
                        <asp:BoundField DataField="CarePackage" HeaderText="Care Package" ItemStyle-HorizontalAlign="Center" SortExpression="CarePackage" />
                        <asp:BoundField DataField="Status_Name" HeaderText="Status" ItemStyle-HorizontalAlign="Center" SortExpression="Status_Name" />
                        <%--<asp:BoundField DataField="VisitDate" HeaderText="Visit Date"  ItemStyle-HorizontalAlign="Center" SortExpression="VisitDate" />
                                    <asp:BoundField DataField="PhysicianNotes" HeaderText="Physician Notes" SortExpression="PhysicianNotes" />
                                    <asp:BoundField DataField="ReferalNotes" HeaderText="Referal Notes" SortExpression="ReferalNotes" />--%>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader2" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
            </td>
        </tr>
    </table>

    <div style="margin-top: 5%">
        <asp:GridView ID="GridView1" Visible="false" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField HeaderText="MR #" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lblRegNo" runat="server" Text='<%# Bind("RegNo") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="10%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Visit #" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lblVisitNo" runat="server" Text='<%# Bind("PayID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Doctor Name">
                    <ItemTemplate>
                        <asp:Label ID="lblDRName" runat="server" Text='<%# Bind("[Doctor Name]") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="10%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Department">
                    <ItemTemplate>
                        <asp:Label ID="lblDept" runat="server" Text='<%# Bind("Dept_Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Admit Date">
                    <ItemTemplate>
                        <asp:Label ID="lblAdmitDate" runat="server" Text='<%# Bind("AdmitDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category">
                    <ItemTemplate>
                        <asp:Label ID="lblPtype" runat="server" Text='<%# Bind("Patient_type") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="7%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Medicine">
                    <ItemTemplate>
                        <asp:Label ID="lblMedicine" runat="server" Text='<%# Bind("Medicine") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="14%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Diagnosis">
                    <ItemTemplate>
                        <asp:Label ID="lblDiagnosis" runat="server" Text='<%# Bind("Diagnosis") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="14%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Laboratory">
                    <ItemTemplate>
                        <asp:Label ID="lblLaboratory" runat="server" Text='<%# Bind("Laboratory") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="20%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Radiology">
                    <ItemTemplate>
                        <asp:Label ID="lblRadiology" runat="server" Text='<%# Bind("Radiology") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="18%" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <asp:SqlDataSource ID="sds_PatientVisits" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="Usp_GetPatientVisitDetailsForEpisodes" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
        </SelectParameters>

    </asp:SqlDataSource>
    <br />
    <asp:Label ID="LabelFooter" runat="server" Text="Label" Visible="false"></asp:Label>
    <%--<asp:HiddenField ID="HiddenField_MedCode" runat="server" />--%>

    <input type="hidden" id="HiddenField_MedCode" runat="server" />

    <script type="text/javascript">
        var cookies = Spry.Utils.Cookie("read", "tabbedpanels_medication");
        var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
        Spry.Utils.addUnLoadListener(function () {
            // save the current value
            Spry.Utils.Cookie('create', 'tabbedpanels_medication', TabbedPanels1.getCurrentTabIndex());
        });

    </script>

    <script type="text/javascript">

    var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", { contentIsOpen: true });
    //
    </script>
    <asp:HiddenField ID="hfForAutoPostBack" runat="server" />
</asp:Content>
