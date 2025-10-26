<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InveestigationChartControlForRadialogy.ascx.cs" Inherits="Pt_EMR_Controls_InveestigationChartControlForRadialogy" %>



<link href="css/imgzoom.css" rel="stylesheet" />


<asp:UpdatePanel ID="updatePanel" runat="server">
    <ContentTemplate>
        <div style="float: left; width: 51%;">
            <asp:Button ID="btnVerifyAll" OnClientClick="return verify()" runat="server" Text="Verify" OnClick="btnVerifyAll_Click" />

            <span class="legend legend-Sample-Collection"></span>Ready
             <span class="legend legend-Test-Conducted"></span>Verify
         <asp:Label ID="lblTName" runat="server" Font-Bold="true" ForeColor="Blue" Text=""></asp:Label>

            <div style="float: right; width: 20%;">
                <asp:Button ID="btnPrevTests" runat="server" Text="Previous" OnClick="btnPrevTests_Click" />
            </div>
        </div>

        <div runat="server" style="width: 51%; max-height: 300px; overflow-y: auto; margin-top: 10px; float: left; display: inline" class="bxmain inner_content">

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

                    <asp:TemplateField HeaderText="Verify">
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkVerifyHeader" Text="Verify" AutoPostBack="true" runat="server" OnCheckedChanged="chkVerifyHeader_CheckedChanged" />
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
        <div style="width: 48%; max-height: 300px; float: right; margin-top: 11px; padding-left: 1%;" runat="server" id="divResult" visible="true" class="bxmain inner_content">


            <asp:DataList ID="ddlImages" runat="server" RepeatDirection="Horizontal" RepeatColumns="3" OnItemDataBound="ddlImages_ItemDataBound">
                <ItemTemplate>
                    <div style="margin-left: 15px; border: solid 1px #ccc; border-radius: 10px; text-align: center; width: 100px; height: 100px; padding: 5px; background-color: aliceblue;">
                        <a id="anchorImg" href="~/images/main_figure2.jpg" runat="server">
                            <asp:Image ID="RadImage" CssClass="thumbnail" runat="server" Width="100%" Height="100%" /></a>
                    </div>
                </ItemTemplate>
            </asp:DataList>


        </div>
        <div class="sub-title" style="float: left; width: 100%; padding-top: 10px">
            <h1 class="main-title">Remarks</h1>
        </div>
        <div id="divRemarks" runat="server" style="padding-top: 20px; float: left; width: 98%; border: solid 1px #ccc; border-radius: 5px; margin-bottom: 20px; padding: 1%;">
        </div>

          <div class="=lightbox_bg">
           
            <asp:Panel ID="panel_PrevTests" class="lightbox" Style="height: 500px !important; width: 950px" runat="server" Visible="false">

                <div runat="server" style="width: 51%; height: 300px; overflow-y: auto; margin-top: 10px; float: left; display: inline" class="bxmain inner_content">

                    <asp:GridView ID="GridView_PrevTests" runat="server" AutoGenerateColumns="false" CssClass="Grid_1" Width="100%" >
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
                   
                </Columns>
            </asp:GridView>
                </div>

                <div style="width: 48%; height: 300px; overflow-y: auto; float: right; margin-top: 11px; padding-left: 1%; overflow: auto" runat="server" id="divResultPrev" visible="true" class="bxmain inner_content">
                    <asp:Label ID="LabelTestNamePrev" Visible="false" runat="server" Font-Bold="true" ForeColor="Blue" Text=""></asp:Label>
                    <asp:DataList ID="ddlImagesPrev" runat="server" RepeatDirection="Horizontal" RepeatColumns="3" OnItemDataBound="ddlImages_ItemDataBound">
                <ItemTemplate>
                    <div style="margin-left: 15px; border: solid 1px #ccc; border-radius: 10px; text-align: center; width: 100px; height: 100px; padding: 5px; background-color: aliceblue;">
                        <a id="anchorImg" href="~/images/main_figure2.jpg" runat="server">
                            <asp:Image ID="RadImage" CssClass="thumbnail" runat="server" Width="100%" Height="100%" /></a>
                    </div>
                </ItemTemplate>
            </asp:DataList>

                </div>
                  <div class="sub-title" style="float: left; width: 100%; padding-top: 10px">
            <h1 class="main-title">Remarks</h1>
        </div>
        <div id="divRemarksPrev" runat="server" style="padding-top: 20px; float: left; width: 98%; border: solid 1px #ccc; border-radius: 5px; margin-bottom: 20px; padding: 1%;">
        </div>
                <div style="text-align:center;float:left;width:100%;">
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
    function enlargeImage() {

        $('img.thumbnail').imgZoom();
    }

</script>
