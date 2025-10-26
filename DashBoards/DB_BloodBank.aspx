<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_BloodBank, App_Web_0myvw0cp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
            <td width="50%" valign="top">
                <div class="bxmain2 margin_right10 inner_content" style="height: 350px;">
                    <h2>
                        <span>Product Avaliable Stock</span>
                    </h2>
                    <div class="data_scroll" style="height:330px;">
                        
                        
                        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" 
                            Width="100%" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Component_Name" HeaderText="Products" 
                                    SortExpression="Component_Name" />
                                <asp:BoundField DataField="Stock" HeaderText="Stock" ReadOnly="True" 
                                    SortExpression="Stock" />
                                <asp:BoundField DataField="Reserved" HeaderText="Reserved" ReadOnly="True" 
                                    SortExpression="Reserved" />
                                <asp:BoundField DataField="Available" HeaderText="Available" ReadOnly="True" 
                                    SortExpression="Available" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>" SelectCommand="SELECT     Blood_Component.Component_Name, COUNT(Donor_Product_Formation.Product_Formation_Id) AS Stock, count(Blood_Bag_Reservation.Blood_Bag_Reservation_id) as Reserved,COUNT(Donor_Product_Formation.Product_Formation_Id) - count(Blood_Bag_Reservation.Blood_Bag_Reservation_id) as Available 
FROM         Donor_Product_Formation INNER JOIN
                      Blood_Component ON Donor_Product_Formation.Component_Id = Blood_Component.Component_id LEFT OUTER JOIN
                      Blood_Bag_Reservation ON Donor_Product_Formation.Product_Formation_Id = Blood_Bag_Reservation.Product_Formation_Id
WHERE     (Donor_Product_Formation.Is_Disposed = 0) AND (Donor_Product_Formation.Is_Issued = 0)
GROUP BY Blood_Component.Component_Name"></asp:SqlDataSource>
                        
                        
                    </div>
                </div>
                <br />
            </td>
            <td width="50%">
                <div class="bxmain3 margin_right10 inner_content" style="height: 355px;">
                    <h2>
                        <span>Avaliable Stock</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center; height:330px;">
                        
                        <asp:Chart ID="Chart1" runat="server" Height="320px" Width="550px" 
                            DataSourceID="SqlDataSource1">
                            <Series>
                                <asp:Series Name="Series1" ChartType="StackedBar" 
                                    CustomProperties="DrawingStyle=Emboss, CollectedSliceExploded=True, 3DLabelLineSize=200, PieLabelStyle=Outside" 
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                    IsVisibleInLegend="False" IsXValueIndexed="True" Palette="Pastel" XValueMember="Component_Name" 
                                    YValueMembers="Available">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <Area3DStyle Enable3D="true" />
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                        
                    </div>
                </div>
                <br />
            </td>
        </tr>
        
        <tr>
            <td width="50%">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Blood Donations</span>
                    </h2>
                    <div class="data_scroll">
                        
                        <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2" 
                            Width="100%" AutoGenerateColumns="False" DataKeyNames="Type_Of_Donor">
                            <Columns>
                                <asp:BoundField DataField="Type_Of_Donor" HeaderText="Donors" 
                                    ReadOnly="True" SortExpression="Type_Of_Donor" />
                                <asp:BoundField DataField="Ready For Assesment" 
                                    HeaderText="Ready For Assesment" ReadOnly="True" 
                                    SortExpression="Ready For Assesment" />
                                <asp:BoundField DataField="Assesment Done" HeaderText="Assesment Done" 
                                    ReadOnly="True" SortExpression="Assesment Done" />
                                <asp:BoundField DataField="Bleeded" HeaderText="Bleeded" ReadOnly="True" 
                                    SortExpression="Bleeded" />
                                <asp:BoundField DataField="Product Formation Done" 
                                    HeaderText="Product Formation Done" ReadOnly="True" 
                                    SortExpression="Product Formation Done" />
                                    <asp:BoundField DataField="Total" HeaderText="Total" 
                                    ReadOnly="True" SortExpression="Total" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                         SelectCommand="select Type_Of_Donor,
sum(case when DonorStatus=1 then Total_Donor else 0 end) as [Ready For Assesment],
sum(case when DonorStatus=2 then Total_Donor else 0 end) as [Assesment Done],
sum(case when DonorStatus=3 then Total_Donor else 0 end) as [Bleeded],
sum(case when DonorStatus=4 then Total_Donor else 0 end) as [Product Formation Done],

sum(case when DonorStatus=1 then Total_Donor else 0 end)+
sum(case when DonorStatus=2 then Total_Donor else 0 end)+
sum(case when DonorStatus=3 then Total_Donor else 0 end)+
sum(case when DonorStatus=4 then Total_Donor else 0 end) as Total


from(


SELECT     Donor_Type.Type_Of_Donor, COUNT(Blood_Donor_Visit.Visit_Id) AS Total_Donor, Blood_Donor_Visit.Status AS DonorStatus
FROM         Blood_Donor_Visit INNER JOIN
                      Donor_Detail ON Blood_Donor_Visit.Donor_RegNo = Donor_Detail.Donor_Registration_No INNER JOIN
                      Donor_Type ON Donor_Detail.Type_Of_Donor = Donor_Type.Type_Of_Donor
GROUP BY Donor_Type.Type_Of_Donor, Blood_Donor_Visit.Status
      )Sub
group by  Type_Of_Donor" ></asp:SqlDataSource>
                        
                    </div>
                </div>
            </td>
            <td width="50%" valign="top">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2>
                        <span>Blood Donations</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center;">
                        
                        <asp:Chart ID="Chart2" runat="server" Height="220px" Width="560px" 
                            DataSourceID="SqlDataSource2">
                            <Series>
                                <asp:Series Name="Series1" XValueMember="Type_Of_Donor" 
                                    YValueMembers="Total" IsValueShownAsLabel="True" 
                                    IsXValueIndexed="True" 
                                    CustomProperties="BarLabelStyle=Center, DrawingStyle=Emboss, DrawSideBySide=True, LabelStyle=Center" 
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" 
                                    Palette="Pastel" ChartType="StackedBar">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <Area3DStyle Enable3D="true" />
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                        
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
