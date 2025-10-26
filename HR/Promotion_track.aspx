<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="HR_Promotion_track, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
            height: 272px;
        }
        .style2
        {
            text-align: right;
            width: 254px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <h1 style="color: Maroon; font-size: medium">
            Employee Promotion Track</h1>
    </div>
    <br />
    <div class="bxmain">
        <table class="style1">
            <tr>
                <td class="style2">
                    Entry Date:
                </td>
                <td>
                    <igsch:WebDateChooser ID="entrydatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                        Visible="true">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Current&nbsp; Designation:
                </td>
                <td>
                    <asp:DropDownList ID="ddlistfromdesig" runat="server" DataSourceID="sdscurrentdesignation"
                        DataTextField="Designation_Name" DataValueField="DesignationID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    To Designation:
                </td>
                <td>
                    <asp:DropDownList ID="ddlisttodesig" runat="server" DataSourceID="SqlDataSource1"
                        DataTextField="Designation_Name" DataValueField="Designation_ID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Promotion Order Date:
                </td>
                <td>
                    <igsch:WebDateChooser ID="ProOrderDateChooser1" Width="250px" runat="server" CssClass="drop_date"
                        Visible="true">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Will Effected On:
                </td>
                <td>
                    <igsch:WebDateChooser ID="WEFONDateChooser2" Width="250px" runat="server" CssClass="drop_date"
                        Visible="true">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Status
                </td>
                <td>
                    <asp:TextBox ID="tbxstatus" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Promotion Year:
                </td>
                <td>
                    <asp:TextBox ID="tbxproyear" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Summary:<br />
                </td>
                <td>
                    <asp:TextBox ID="tbxSummary" runat="server" Height="40px" TextMode="MultiLine" Width="300px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="btnsave" runat="server" Text="Save" OnClick="btnsave_Click" />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="SELECT Designation_ID, Designation_Name FROM Designation"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdscurrentdesignation" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                        SelectCommand="SELECT Employee.EmpID, Employee.DesignationID, Designation.Designation_Name FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.EmpID = @empid)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="empid" QueryStringField="empid" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        InsertCommand="usp_InsertIntoPromotionT"
                        
                        SelectCommand="SELECT Employee_Promotion_Track.Promotion_ID, Employee_Promotion_Track.Status, Employee_Promotion_Track.Promotion_Order_Date, Employee_Promotion_Track.Promotion_WEF_Date, Employee_Promotion_Track.Case_Summary, Employee_Promotion_Track.Promotion_Year, Employee_Promotion_Track.Entry_Date, Des_to.Designation_Name AS New_Des, Des_from.Designation_Name AS Old_Desg, Employee_Promotion_Track.Emp_ID FROM Employee_Promotion_Track INNER JOIN Designation AS Des_from ON Employee_Promotion_Track.From_Designation_ID = Des_from.Designation_ID INNER JOIN Designation AS Des_to ON Employee_Promotion_Track.To_Designation_ID = Des_to.Designation_ID WHERE (Employee_Promotion_Track.Emp_ID = @empid)" 
                        InsertCommandType="StoredProcedure">
                        <InsertParameters>
                            <asp:QueryStringParameter Name="empid" QueryStringField="empid" />
                            <asp:Parameter Name="fromdesg" />
                            <asp:Parameter Name="todesg" />
                            <asp:Parameter Name="status" />
                            <asp:Parameter Name="prorder" />
                            <asp:Parameter Name="WEF" />
                            <asp:Parameter Name="summary" />
                            <asp:Parameter Name="proyear" />
                            <asp:Parameter Name="entrydate" />
                            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:QueryStringParameter Name="empid" QueryStringField="empid" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Promotion_ID"
        EmptyDataText="No Record Found" DataSourceID="SqlDataSource2" Width="100%">
        <Columns>
            <asp:BoundField DataField="Promotion_ID" HeaderText="Promotion_ID" InsertVisible="False"
                ReadOnly="True" SortExpression="Promotion_ID" Visible="false" />
            <asp:BoundField DataField="Emp_ID" HeaderText="Emp_ID" Visible="false" SortExpression="Emp_ID" />
            <asp:BoundField DataField="Entry_Date" HeaderText="Entry Date" DataFormatString="{0:dd/MM/yyyy}"
                SortExpression="Entry_Date" />
            <asp:BoundField DataField="Old_Desg" HeaderText="From Designation" SortExpression="Old_Desg" />
            <asp:BoundField DataField="New_Des" HeaderText="To Designation" SortExpression="New_Des" />
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <asp:BoundField DataField="Promotion_Order_Date" DataFormatString="{0:dd/MM/yyyy}"
                HeaderText="Promotion Order Date" SortExpression="Promotion_Order_Date" />
            <asp:BoundField DataField="Promotion_WEF_Date" HeaderText="Will Effected On" DataFormatString="{0:dd/MM/yyyy}"
                SortExpression="Promotion_WEF_Date" />
            <asp:BoundField DataField="Promotion_Year" HeaderText="Promotion Year" SortExpression="Promotion_Year" />
            <asp:BoundField DataField="Case_Summary" HeaderText="Summary" SortExpression="Case_Summary" />
        </Columns>
    </asp:GridView>
</asp:Content>
