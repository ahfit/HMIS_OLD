<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_IssueReceive, App_Web_245irwrw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
                    Issuances
                </td>
                <td rowspan="2" class="chartContent">
                    <asp:Chart ID="Chart1" runat="server" Height="224px" Width="560px">
                        <Series>
                            <asp:Series ChartType="Bar" Legend="Legend1" Name="Series1"
                                XValueMember="SubDept_Name" YValueMembers="Total_Issued" 
                                CustomProperties="BarLabelStyle=Center" 
                                Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                IsXValueIndexed="True" LabelForeColor="White" Palette="BrightPastel">
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
                    <asp:GridView ID="gvIssued" Width="100%" runat="server" ShowHeader="true" 
                        AutoGenerateColumns="false" onrowdatabound="gvIssued_RowDataBound">
                        <Columns>
                            <%--<asp:BoundField DataField="SubDept_Name" />--%>
                            <asp:TemplateField HeaderText="Company">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlnkIssued" CssClass="gridHyperlink" runat="server" Text='<%#Eval("SubDept_Name")%>'></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Total_Issued" DataFormatString="{0:#,##0}" ItemStyle-CssClass="AmountAlign" HeaderText="Count" />
                            <asp:BoundField DataField="Item_Qty" DataFormatString="{0:#,##0}" ItemStyle-CssClass="AmountAlign" HeaderText="Item Qty"/>
                            <%--<asp:BoundField DataField="Item_Cost" DataFormatString="{0:#,##0}" ItemStyle-CssClass="AmountAlign" />--%>
                        </Columns>
                        <RowStyle CssClass="GridAltItem" />
                        <AlternatingRowStyle CssClass="GridItem" />
                    </asp:GridView>
                </td>
            </tr>   
            <tr>
                <td class="boxHeaderStyle">
                    Receivings 
                </td>
                <td rowspan="2" class="chartContent">
                    <asp:Chart ID="Chart2" runat="server" Height="224px" Width="560px">
                        <Series>
                            <asp:Series ChartType="Bar" Legend="Legend1" Name="Series1"
                                XValueMember="SubDept_Name" YValueMembers="Total_Received" 
                                CustomProperties="BarLabelStyle=Center" 
                                Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                IsXValueIndexed="True" LabelForeColor="White" Palette="BrightPastel">
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
                    <asp:GridView ID="gvReceived" Width="100%" runat="server" ShowHeader="true" 
                        AutoGenerateColumns="false" onrowdatabound="gvReceived_RowDataBound">
                        <Columns>
                            <%--<asp:BoundField DataField="SubDept_Name" />--%>
                            <asp:TemplateField HeaderText="Company">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlnkReceived" CssClass="gridHyperlink" runat="server" Text='<%#Eval("SubDept_Name")%>'></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Total_Received" DataFormatString="{0:#,##0}" ItemStyle-CssClass="AmountAlign"  HeaderText ="Count"/>
                            <asp:BoundField DataField="Item_Qty" DataFormatString="{0:#,##0}" ItemStyle-CssClass="AmountAlign" HeaderText="Item Qty"/>
                           <%-- <asp:BoundField DataField="TotalReceiveCost" DataFormatString="{0:#,##0}" ItemStyle-CssClass="AmountAlign" />--%>
                        </Columns>
                        <RowStyle CssClass="GridAltItem" />
                        <AlternatingRowStyle CssClass="GridItem" />
                    </asp:GridView>
                </td>
                
            </tr>       
        </table>
</asp:Content>

