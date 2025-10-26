<%@ Page  Language="C#" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="true" CodeFile="InveestigationChart.aspx.cs" Inherits="Pt_EMR_InveestigationChart" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptManager" runat="server"></asp:ScriptManager>
    
            <div runat="server" style="width: 49%; height: 300px; margin-top: 10px; float: left; display: inline" class="bxmain inner_content">
                <h2>
                    <span>Patient Tests</span>
                </h2>

                <div style="width: 100%; height: 500px; overflow: auto;">
                    <%--<asp:Repeater ID="mainRepeater" runat="server" OnItemDataBound="mainRepeater_ItemDataBound">
                        <ItemTemplate>
                            <div style="margin-right: 3px; line-height: 2">
                                <asp:Label ID="hfVisitDetail" Visible="true" Font-Underline="true" ForeColor="SteelBlue" runat="server" Font-Bold="true" Font-Size="15px" Text='<%# Eval("VistiDateTime") %>' ToolTip='<%# Eval("YearlyNo") %>' />
                            </div>--%>
                            <asp:GridView ID="repaterSub" runat="server" AutoGenerateColumns="false" CssClass="Grid_1">
                                <Columns> 
                                    <asp:TemplateField HeaderText="Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text=<%# Eval("VistiDateTime") %>></asp:Label>
                                            
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center"  />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Test Name">
                                        <ItemTemplate>
                                            <span style="width: 80%; float: left">
                                                <asp:LinkButton CssClass="lnkbtn" ID="lnkbtnTestName" OnClick="lnkbtnTestName_Click" runat="server" CommandArgument='<%# Eval("TestId") %>' ToolTip='<%# Eval("YearlyNo") %>' Text='<%# Eval("TestName") %>'></asp:LinkButton>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Comparision">
                                        <ItemTemplate>
                                            <span style="float: left; text-decoration: none; width: 15%">
                                                <asp:LinkButton ID="lnkbtnComparsion" Text="Comparsion" Font-Bold="true" OnClick="lnkbtnComparsion_Click" CommandArgument='<%# Eval("TestId") %>' runat="server"></asp:LinkButton>
                                            </span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center"  />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        <%--</ItemTemplate>
                    </asp:Repeater>--%>
                </div>
            </div>
            <asp:UpdatePanel ID="updatePanel" runat="server">
                <ContentTemplate>
                    <div style="width: 50%; height: 300px; float: right; margin-top: 10px; overflow: auto" runat="server" id="divResult" visible="true" class="bxmain inner_content">
                        <h2><span>Investigation Result Report</span></h2>
                        <asp:Label ID="lblTName" runat="server" Font-Bold="true" ForeColor="Blue" Text=""></asp:Label>
                        <asp:GridView ID="SubRepeater" runat="server" AutoGenerateColumns="false" CssClass="Grid_1">
                            <Columns>
                                <asp:TemplateField HeaderText="SR #">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                    <ItemStyle Width="6%" HorizontalAlign="Center" />
                                </asp:TemplateField>
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
                </ContentTemplate>
            </asp:UpdatePanel>
    
    <div class="=lightbox_bg">
        <asp:Panel ID="panel_Report" class="lightbox" Style="height: 500px !important; width:900px" runat="server" Visible="false">            
             <%--<span class="icon-close" onclick="closepopup()"></span>--%>

            <div style="width: 100%; text-align:center">
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"  ShowBackButton="false"  ShowExportControls="false" 
                    ShowFindControls="false" ShowPrintButton="false" ShowToolBar="false" >
                </rsweb:ReportViewer>
                <asp:Button ID="btnclose_Panel" runat="server" Text="Close" OnClick="btnclose_Panel_Click" />
            </div>
            
        </asp:Panel>
    </div>
</asp:Content>







