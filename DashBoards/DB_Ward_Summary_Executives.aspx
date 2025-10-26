<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="DashBoards_DB_Ward_Summary_Executives, App_Web_442qjtxu" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .bxmain2
        {
            background: url("../images_mega/bxbg4.png") repeat-y scroll right bottom #E7E5F4;
            border: 1px solid #D2BFEA;
            border-radius: 4px;
            margin: 0;
            padding-bottom: 15px;
            padding-top: 10px;
            height: 350px;
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
            height: 330px;
            overflow-x: hidden;
            overflow-y: auto;
            width: 99%;
            padding-left: 5px;
        }
        
        
        .color_b
        {
            color: #000000;
        }
        
        .style1
        {
            font-size: 11px;
        }
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
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top">
                <div class="bxmain2 margin_right10 inner_content">
                    <h2>
                        <span>Ward Wise Patients Summary</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvWardExecutiveSummary" AutoGenerateColumns="false" Width="100%"
                            runat="server">
                            <Columns>
                                <asp:BoundField DataField="Ward_Name" HeaderText="Ward" ItemStyle-CssClass="AmountAlign" />
                                <asp:BoundField DataField="Total_Beds" HeaderText="Total Beds" ItemStyle-CssClass="AmountAlign" />
                                <asp:BoundField DataField="Previous_Bookings_Count" HeaderText="Previous" ItemStyle-CssClass="AmountAlign" />
                                <asp:BoundField DataField="Today_Bookings_Count" HeaderText="Admission" ItemStyle-CssClass="AmountAlign" />
                                <asp:BoundField DataField="Discharge_Count" HeaderText="Discharge" ItemStyle-CssClass="AmountAlign" />
                                <asp:BoundField DataField="Total_Present" HeaderText="Present" ItemStyle-CssClass="AmountAlign" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <br />
            </td>
        </tr>
        
        <tr>
            <td>
                <div class="bxmain2 margin_right10 inner_content">
                    <h2>
                        <span>Tests</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvLabTests" AutoGenerateColumns="true" Width="100%" runat="server">
                        </asp:GridView>
                    </div>
                </div>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <div class="bxmain2 margin_right10 inner_content">
                    <h2>
                        <span>Operations Summary</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvOperationsSummary" AutoGenerateColumns="true" Width="100%" runat="server">
                        </asp:GridView>
                    </div>
                </div>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <div class="bxmain2 margin_right10 inner_content">
                    <h2>
                        <span>Procedures Summary</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvProcedureSummary" AutoGenerateColumns="true" Width="100%" runat="server">
                        </asp:GridView>
                    </div>
                </div>
                <br />
            </td>
        </tr>
    </table>
</asp:Content>
