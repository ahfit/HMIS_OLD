<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_DeliveryChallanst, App_Web_245irwrw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
       .Grid_1 th
       {
           
           background:none;
           border:1px solid  #D5D2CD;  
           font-size: 11px;
            height: 17px;
       } 
       
       .Grid_1 td 
       {
           padding:2px;
           
       }
        
        
        .tableStyle
        {
            width: 95%;
            margin: auto;
        }
        
        .boxHeaderStyle
        {
            height: 30px;
            padding-left: 5px;
            font-size: 12px;
            text-shadow: 1px 1px 1px #FFFFFF;
            font-weight: bold;
            width: 50%;
            border: 1px solid green;
            background-image: url('../images_mega/mega_menubgn.png');
            background-repeat: repeat-x;
        }
        
        .boxContentStyle
        {
            border: 1px solid black;
            height: 200px;
            vertical-align:top;
        }
        
        .chartContent
        {
            border: 1px solid black;
            height: 200px;
            vertical-align:top;
        }
        
        .headerLinkStyle
        {
            float: right;
            width: 140px;
            text-align: right;
            margin-right: 20px;
            color: #380B61;
            text-decoration: none;
            text-transform: uppercase;
            font-size:8px;
        }
        
        .GridAltItem
        {
            background-color: white;
        }
        
        .GridItem
        {
            background-color: #F0F8FF;
        }
        
        .gridHyperlink
        {
        	text-decoration:none;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table class="tableStyle">
            <tr>
                <td class="boxHeaderStyle">
                    Customer DCs
                </td>
                <td rowspan="2" class="chartContent">
                    <asp:Chart ID="Chart1" runat="server" Height="224px" Width="560px" 
                        Palette="None">
                        <Series>
                            <asp:Series ChartType="Bar" Legend="Legend1" Name="Series1"
                                XValueMember="SubDept_Name" YValueMembers="Total_Consumptions" 
                                CustomProperties="BarLabelStyle=Center" IsValueShownAsLabel="True" 
                                IsXValueIndexed="True" LabelForeColor="White" Palette="BrightPastel" 
                                Font="Microsoft Sans Serif, 8pt, style=Bold">
                                <SmartLabelStyle IsMarkerOverlappingAllowed="True" />
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" >
                            
                                
                         
                            

                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" AutoFitMinFontSize="12" InterlacedRows="True" >
                            </asp:Legend>
                        </Legends>

                    </asp:Chart>
                </td>
            </tr>
            <tr>
                <td class="boxContentStyle">
                    <asp:GridView ID="gvItemsConsumed" Width="100%" runat="server"
                        AutoGenerateColumns="False" onrowdatabound="gvItemsConsumed_RowDataBound" 
                        EnableModelValidation="True">
                        <Columns>
                            <%--<asp:BoundField DataField="SubDept_Name" />--%>
                            <asp:TemplateField HeaderText="Company">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlnkConsumedItems" CssClass="gridHyperlink" runat="server" Text='<%#Eval("SubDept_Name")%>'></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Total_Consumptions" DataFormatString="{0:#,##0}" 
                                ItemStyle-CssClass="AmountAlign" HeaderText="Count" >
            <ItemStyle CssClass="AmountAlign"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Consumed_QTY" DataFormatString="{0:#,##0}" 
                                ItemStyle-CssClass="AmountAlign"  HeaderText="Item Qty">
            <ItemStyle CssClass="AmountAlign"></ItemStyle>
                            </asp:BoundField>
                            <%--<asp:BoundField DataField="Consumed_Amount" DataFormatString="{0:#,##0}" ItemStyle-CssClass="AmountAlign" />--%>
                        </Columns>
                        <RowStyle CssClass="GridAltItem" />
                        <AlternatingRowStyle CssClass="GridItem" />
                    </asp:GridView>
                </td>
            </tr>   
            <tr>
                <td class="boxHeaderStyle">
                    Departmental DCs
                </td>
                <td rowspan="2" class="chartContent">
                    <asp:Chart ID="Chart2" runat="server" Height="224px" Width="560px">
                        <Series>
                            <asp:Series ChartType="Bar" Legend="Legend1" Name="Series1"
                                XValueMember="SubDept_Name" YValueMembers="Total_Requisitions" 
                                CustomProperties="BarLabelStyle=Center" IsValueShownAsLabel="True" 
                                LabelForeColor="White" Palette="BrightPastel" 
                                Font="Microsoft Sans Serif, 8pt, style=Bold">
                                <SmartLabelStyle IsMarkerOverlappingAllowed="True" />
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" >
                            
                                

                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" AutoFitMinFontSize="12" >
                            </asp:Legend>
                        </Legends>

                    </asp:Chart>
                </td>
            </tr>  
            <tr>
                <td class="boxContentStyle">
                    <asp:GridView ID="gvRequisitions" Width="100%" runat="server" ShowHeader="true" 
                        AutoGenerateColumns="false" onrowdatabound="gvRequisitions_RowDataBound">
                        <Columns>
                            <%--<asp:BoundField DataField="SubDept_Name" />--%>
                            <asp:TemplateField HeaderText="Company">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlnkRequisitions" CssClass="gridHyperlink" runat="server" Text='<%#Eval("SubDept_Name")%>'></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Total_Requisitions" DataFormatString="{0:#,##0}" ItemStyle-CssClass="AmountAlign" HeaderText="Count"/>
                            <asp:BoundField DataField="Item_Qty" DataFormatString="{0:#,##0}" ItemStyle-CssClass="AmountAlign"  Headertext="Item Qty"/>
                        </Columns>
                        <RowStyle CssClass="GridAltItem" />
                        <AlternatingRowStyle CssClass="GridItem" />
                    </asp:GridView>
                </td>
                
            </tr>       
        </table>

</asp:Content>

