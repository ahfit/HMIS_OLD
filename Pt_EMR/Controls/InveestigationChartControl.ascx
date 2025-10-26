<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InveestigationChartControl.ascx.cs" Inherits="Pt_EMR_InveestigationChartControl" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<%--<asp:ScriptManager ID="scriptManager" runat="server"></asp:ScriptManager>--%>

<asp:UpdatePanel ID="updatePanel" runat="server">
    <ContentTemplate>
        <div style="float:left;width: 51%;">
            <asp:Button ID="btnVerifyAll" OnClientClick="return verify()" runat="server" Text="Verify" OnClick="btnVerifyAll_Click" />

            <%--<span class="legend legend-Advice"></span>Advice--%>
            <%--<span class="legend legend-Sample-Collection"></span>Sample Collect
        <span class="legend legend-Sample-Received"></span>Sample Received
        <span class="legend legend-Result-Entry"></span>Result Entry
        <span class="legend legend-Test-Conducted"></span>Test Conducted
        <%--<span class="legend legend-Un-Delivered"></span>Un Delivered
        <span class="legend legend-Delivered"></span>Delivered
        <span class="legend legend-Test-Cancel"></span>Canceled--%>

            <span class="legend legend-Sample-Collection"></span>Ready
             <span class="legend legend-Test-Conducted"></span>Verify
        
            <div style="float:right;width: 20%;">
                <asp:Button ID="btnPrevTests" runat="server" Text="Previous" OnClick="btnPrevTests_Click" />
            </div>
        </div>

        <div runat="server" style="width: 51%; height: 300px; overflow-y: auto; margin-top: 10px; float: left; display: inline" class="bxmain inner_content">

            <asp:GridView ID="repaterSub" runat="server" AutoGenerateColumns="false" CssClass="Grid_1" Width="100%" OnRowDataBound="repaterSub_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="lblDate" runat="server" Text='<%# Eval("VistiDateTime") %>'></asp:Label>

                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Test Name">
                        <ItemTemplate>
                            <span style="width: 80%; float: left">
                                <asp:LinkButton ID="lnkbtnTestName" OnClick="lnkbtnTestName_Click" runat="server" CommandArgument='<%# Eval("TestId") %>' ToolTip='<%# Eval("YearlyNo") %>' Text='<%# Eval("TestName") %>'></asp:LinkButton>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Lab #" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblLabNo" runat="server" Text='<%# Eval("Order_Id") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Comparision">
                        <ItemTemplate>
                            <span style="float: left; text-decoration: none; width: 15%">
                                <asp:LinkButton ID="lnkbtnComparsion" Text="Comparsion" Font-Bold="true" OnClick="lnkbtnComparsion_Click" CommandArgument='<%# Eval("TestId") %>' runat="server"></asp:LinkButton>
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Verified">
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkVerifyHeader" Text="Verified" AutoPostBack="true" runat="server" OnCheckedChanged="chkVerifyHeader_CheckedChanged" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkVerify" CssClass="chkVerify" runat="server" />
                            <asp:Label ID="lblVerified" Visible="false" runat="server"></asp:Label>

                            <asp:HiddenField ID="hfPrimaryConsultant" runat="server" Value='<%# Eval("PrimaryConsultant") %>' />
                            <asp:HiddenField ID="hfSecondaryConsultant" runat="server" Value='<%# Eval("SecondaryConsultant") %>' />

                            <asp:HiddenField ID="hdnPsId" Value='<%# Eval("PsId") %>' runat="server" />
                            <asp:HiddenField ID="hdnYearlyNo" Value='<%# Eval("YearlyNo") %>' runat="server" />
                        </ItemTemplate>

                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div style="width: 48%; height: 300px; overflow-y: auto; float: right; margin-top: 11px; padding-left: 1%; overflow: auto" runat="server" id="divResult" visible="true" class="bxmain inner_content">
            <asp:Label ID="lblTName" Visible="false" runat="server" Font-Bold="true" ForeColor="Blue" Text=""></asp:Label>
            <asp:GridView ID="SubRepeater" runat="server" AutoGenerateColumns="false" CssClass="Grid_1" Width="100%">
                <Columns>

                    <asp:TemplateField HeaderText="Component Name">
                        <ItemTemplate>
                            <asp:Label ID="lblComponentName" runat="server" Text='<%# Eval("ComponentName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ref Value">
                        <ItemTemplate>
                            <asp:Label ID="lblRefValue" runat="server" Text='<%# Eval("RefValue") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Patient Value">
                        <ItemTemplate>
                            <asp:Label ID="lblPatientValue" runat="server" Text='<%# Eval("PatientValue") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>
        <div class="=lightbox_bg">
            <asp:Panel ID="panel_Report" class="lightbox" Style="height: 500px !important;z-index:999999; width: 950px" runat="server" Visible="false">
                
                <div style="width: 100%; text-align: center">
                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" ShowBackButton="false" ShowExportControls="false"
                        ShowFindControls="false" ShowPrintButton="false" ShowToolBar="false">
                    </rsweb:ReportViewer>
                    <asp:Button ID="btnclose_Panel" runat="server" Text="Close" OnClick="btnclose_Panel_Click" />
                </div>

            </asp:Panel>
            <asp:Panel ID="panel_PrevTests" class="lightbox" Style="height: 500px !important; width: 950px" runat="server" Visible="false">

                <div runat="server" style="width: 51%; height: 300px; overflow-y: auto; margin-top: 10px; float: left; display: inline" class="bxmain inner_content">

                    <asp:GridView ID="GridView_PrevTests" runat="server" AutoGenerateColumns="false" CssClass="Grid_1" Width="100%">
                        <Columns>
                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblDate" runat="server" Text='<%# Eval("VistiDateTime") %>'></asp:Label>

                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Test Name">
                                <ItemTemplate>
                                    <span style="width: 80%; float: left">
                                        <asp:LinkButton ID="lnkbtnTestNamePrev" OnClick="lnkbtnTestNamePrev_Click" runat="server" CommandArgument='<%# Eval("TestId") %>' ToolTip='<%# Eval("YearlyNo") %>' Text='<%# Eval("TestName") %>'></asp:LinkButton>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Lab #" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblLabNo" runat="server" Text='<%# Eval("Order_Id") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                           
                            <asp:TemplateField HeaderText="Comparision">
                                <ItemTemplate>
                                    <span style="float: left; text-decoration: none; width: 15%">
                                        <asp:LinkButton ID="lnkbtnComparsion" Text="Comparsion" Font-Bold="true" OnClick="lnkbtnComparsion_Click" CommandArgument='<%# Eval("TestId") %>' runat="server"></asp:LinkButton>
                                    </span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                           
                        </Columns>
                    </asp:GridView>
                </div>

                <div style="width: 48%; height: 300px; overflow-y: auto; float: right; margin-top: 11px; padding-left: 1%; overflow: auto" runat="server" id="divResultPrev" visible="true" class="bxmain inner_content">
                    <asp:Label ID="Label1" Visible="false" runat="server" Font-Bold="true" ForeColor="Blue" Text=""></asp:Label>
                    <asp:GridView ID="GridView_PrevTestResults" runat="server" AutoGenerateColumns="false" CssClass="Grid_1" Width="100%">
                        <Columns>

                            <asp:TemplateField HeaderText="Component Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblComponentName" runat="server" Text='<%# Eval("ComponentName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ref Value">
                                <ItemTemplate>
                                    <asp:Label ID="lblRefValue" runat="server" Text='<%# Eval("RefValue") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Patient Value">
                                <ItemTemplate>
                                    <asp:Label ID="lblPatientValue" runat="server" Text='<%# Eval("PatientValue") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                </div>

                <div style="text-align:center">
                      <asp:Button ID="Button_ClosePrevTest" runat="server" Text="Close" OnClick="Button_ClosePrevTest_Panel_Click" />
                </div>
            </asp:Panel>

        </div>
    </ContentTemplate>
</asp:UpdatePanel>


<style type="text/css">
    .lnkbtn {
        text-decoration: none;
        font-size: 15px;
        color: #7000ff;
        font-family: 'Iskoola Pota';
        padding-left: 10px;
    }
</style>
<script type="text/javascript">
    function closepopup() {
        $("#ctl00_ContentPlaceHolder1_panel_Report").hide();
    }
    function verify() {
        if ($("[id$='patientInvestigation_repaterSub']").find(".chkVerify input:checked").length == 0) {
            alert("Please select at least 1 Test");
            return false;
        }
    }
</script>
