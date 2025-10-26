<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_Laboratory_Radiology, App_Web_245irwrw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

<style type="text/css">
    
        
            .bxmain2
        {
           /* background: url("../images_mega/bxbg4.png") repeat-y scroll right bottom #E7E5F4;*/
            border: 1px solid #D2BFEA;
            border-radius: 4px;
            margin: 0;
            padding-top: 0;
            border-top:0;
            overflow:hidden;
        }
        
        .margin_right10
        {
            margin-right: 10px;
        }
        .txtright span
        {
            text-align: right;
            display: block;
            margin-right: 5px;
        }
        .boldt
        {
            font-weight: bold;
            text-align: right;
            display: block;
            margin-right: 5px;
        }
        .sel_pos
        {
            position: relative;
            margin-top: -36px;
            float: right;
            margin-right: 10px;
        }
        .splt
        {
            padding-left: 5px;
            padding-right: 5px;
        }
        
        
        .bxmain
        {
            min-height: 175px;
        }
        .bxmain2
        {
            min-height: 175px;
        }
        .bxmain3
        {
            min-height: 175px;
        }
        .bxmain4
        {
            min-height: 175px;
        }
        
        .data_scroll
        {
            height: 225px;
            overflow-x: hidden;
            overflow-y: auto;
            padding:0 10px;
        }
        
        
        .color_b
        {
            color: #000000;
        }
        #forms_items { margin:15px; }
        .ssearch_panell { margin-bottom:20px; overflow:hidden;}
        .ssearch_div1 { margin-right:20px; float:left}
        .ssearch_div2 {float:left; margin-right:15px; }
        .ssreach_label { margin-right:15px; width:70px; line-height:22px; text-align:right; float:left; display:block; font-weight:bold; }
        .ssearch_panell input[type="text"], .ssearch_panell select { border: 1px solid #ccc; background:#ffffff; }
        .ssearch_panell input[type="submit"] {background: url(../images_hacims/img_btn_bg.png) left top repeat-x;
height: 22px !important; line-height:22px !important; cursor: pointer; font-size: 12px; color: #000000; azimuth font-weight:normal !important;
padding:4px 14px; border: #e1e1e1 solid 1px !important; -webkit-border-radius: 4px; azimuth -moz-border-radius: 4px;
border-radius: 4px; behavior: url(PIEq.htc);} 
    
        .chart_panel  { margin-bottom:15px; clear:both;}
        .row { margin-right: -15px; margin-left: -15px;}
        .col-6_r { float:right; width:48%; position: relative; padding-right: 15px; }
        .col-6 { width:48%; float:left; position: relative; padding-left: 15px;}
        .chart_panel h2 { height: 38px; line-height: 38px; background: url(../images_hacims/bhead.gif) 0 0 repeat-x; overflow: hidden; padding:0 0 0 15px; width:auto; font-size: 13px; }
        .chart_panel .Grid_1 th { background: #E6ECEF; font-weight: bold !important; color: #4F4F4F; padding: 3px; text-align: center; font-size: 12px; color: #333; text-shadow: 0 1px 0 #FFFFFF; position: relative; font-weight: normal; border-bottom: 1px solid #AAAAAA; }
        .chart_panel .Grid_1 td { padding:6px; text-transform:capitalize !important;}

  
 .color_b { color:#000000;}
 
    </style>
<script type="text/javascript">

    $(document).ready(function (e) {

        $.fn.commas = function () {
            return this.each(function () {
                $(this).text($(this).text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
            })
        }


        $(".total_payable").html($("#ctl00_ContentPlaceHolder1_GridviewPayable .boldt").text());
        $(".total_receiveable").html($("#ctl00_ContentPlaceHolder1_GridviewReceiveable .boldt").text());

        $("span").commas();

    });

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<div class="chart_panel">
        <div class="row">
            <div class="col-6">
                <div class="bxmain2 inner_content" style="height: 500px;">
                	<h2>Radiology Progress</h2>
                    <div class="data_scroll" style="height:490px;" >  
            
               
                <asp:GridView ID="gvGroupWiseSummary" runat="server" AutoGenerateColumns="False" Width="100%" 
                    DataSourceID="SqlDataSource1" onprerender="gvGroupWiseSummary_PreRender" 
                            ShowFooter="True">
                    <Columns>
                        <asp:BoundField DataField="TGName" HeaderText="Group Name" ItemStyle-CssClass="AmountAlign"
                            SortExpression="TGName" >
<ItemStyle CssClass="AmountAlign"></ItemStyle>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Order Paid" SortExpression="OrderPaid">
                            <EditItemTemplate>
                                <asp:Label ID="Label_OP" runat="server" Text='<%# Eval("OrderPaid") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label_OP" runat="server" Text='<%# Bind("OrderPaid") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="LabelFooter_OP" runat="server" Text="Label"></asp:Label>
                            </FooterTemplate>
                            
                            <ItemStyle CssClass="AmountAlign" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Procedure Performed" SortExpression="Remarks">
                            <EditItemTemplate>
                                <asp:Label ID="Label_PP" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                            </EditItemTemplate>
                           
                            <ItemTemplate>
                                <asp:Label ID="Label_PP" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                            </ItemTemplate>
                             <FooterTemplate>
                                <asp:Label ID="LabelFooter_PP" runat="server" Text="Label"></asp:Label>
                            </FooterTemplate>
                            <ItemStyle CssClass="AmountAlign" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reports" SortExpression="Reports">
                            <EditItemTemplate>
                                <asp:Label ID="Label_Report" runat="server" align="Right"  Text='<%# Eval("Reports") %>'></asp:Label>
                            </EditItemTemplate>
                           
                            <ItemTemplate>
                                <asp:Label ID="Label_Report" runat="server" Text='<%# Bind("Reports") %>'></asp:Label>
                            </ItemTemplate>
                             <FooterTemplate>
                                <asp:Label ID="LabelFooter_Report" runat="server" Text="Label"></asp:Label>
                            </FooterTemplate>
                            <ItemStyle CssClass="AmountAlign" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#FFCC66" HorizontalAlign="Right" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>" 
                    SelectCommand="usp_GetRadiologyGroupWiseSummary" 
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="Dept_Id" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            
               
            </div>
                </div>
            </div>
            <div class="col-6_r">
                <div class="bxmain2 inner_content" style="height: 500px;">
                	<h2>Progress          	<h2>Progress</h2>
                    <div class="data_scroll" style="height:490px; text-align:center; padding-top:10px;">

                    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1"
                        Height="480px" Width="485px">
                        <Series>
                            <asp:Series ChartType="Pie" Legend="Legend1" Name="Series1"
                                XValueMember="TGName" YValueMembers="OrderPaid" 
                                Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                IsXValueIndexed="True" CustomProperties="PieLabelStyle=Outside" 
                                Palette="BrightPastel">
                            </asp:Series>
                        </Series>
                        
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" >
                            
                                
                                
                            <Area3DStyle Enable3D="True" Inclination="45" Rotation="90" LightStyle="Realistic" />

                            </asp:ChartArea>
                            
                            
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" AutoFitMinFontSize="12" Alignment="Center" >
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>

                </div>
                </div>
            </div>
        </div><!-- block -->
        <div style="height:0; line-height:0; font-size:0; clear:both; margin-bottom:15px;"></div>
</div>
</asp:Content>
