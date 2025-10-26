<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="diagrams_001_Radiology_Progress, App_Web_mkzldjlk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1">
        <Series>
            <asp:Series ChartType="StackedColumn" Legend="Legend1" Name="Series1"
                                XValueMember="TGName" YValueMembers="OrderPaid" 
                                Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                IsXValueIndexed="True" 
                                
                CustomProperties="MinimumRelativePieSize=40, PieLabelStyle=Outside" 
                YValuesPerPoint="6">
                            </asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1">
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="TGName" HeaderText="TGName" 
                SortExpression="TGName" />
            <asp:BoundField DataField="OrderPaid" HeaderText="OrderPaid" ReadOnly="True" 
                SortExpression="OrderPaid" />
            <asp:BoundField DataField="Remarks" HeaderText="Remarks" ReadOnly="True" 
                SortExpression="Remarks" />
            <asp:BoundField DataField="Reports" HeaderText="Reports" ReadOnly="True" 
                SortExpression="Reports" />
        </Columns>
    </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>" 
                    SelectCommand="usp_GetGroupWiseSummary" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="Dept_Id" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            
               
            
</asp:Content>

