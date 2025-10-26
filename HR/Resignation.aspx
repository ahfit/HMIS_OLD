<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="HR_Resignation, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            text-align:right;
            width: 256px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain"> <h1 style="color:  Maroon; font-size:medium" >Employee Resignation</h1></div>
<br />
<div class="bxmain">
    <table class="ui-accordion">
        <tr>
            <td class="style1">
                Resignation Type :</td>
            <td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource3" DataTextField="Resignation_type" 
                    DataValueField="Resignation_type_id" RepeatDirection="Horizontal">
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Resign Date:</td>
            <td>
              <igsch:WebDateChooser ID="resgdatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                            Visible="true">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser></td>
        </tr>
        <tr>
            <td class="style1">
                Last Work Day:</td>
            <td>
                <igsch:WebDateChooser ID="lastworkdaywebchooser" Width="250px" runat="server" CssClass="drop_date"
                            Visible="true">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser></td>
        </tr>
        <tr>
            <td class="style1">
                Notice Period:</td>
            <td>
                <asp:TextBox ID="tbxnoticeperiod" runat="server" placeholder="In months"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Is Approved:</td>
            <td>
                <asp:CheckBox ID="chkbxapproved" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="style1">
                Approve Date:</td>
            <td>
                <igsch:WebDateChooser ID="approvdatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                            Visible="true">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser></td>
        </tr>
        <tr>
            <td class="style1">
                Approved By:</td>
            <td>
                <asp:DropDownList ID="ddlistappeoveby" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="EmpID">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Resign Reason:</td>
            <td>
                <asp:TextBox ID="tbxresgreason" runat="server" Height="50px" 
                    TextMode="MultiLine" Width="300px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" BorderColor="#FF6600" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Remarks:</td>
            <td>
                <asp:TextBox ID="tbxremarks" runat="server" Height="50px" TextMode="MultiLine" 
                    Width="300px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                </td>
            <td>
                <asp:Button ID="btnsave" runat="server" Text="Save" onclick="btnsave_Click" />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    SelectCommand="SELECT EmpID, ISNULL(EFName,'') + ' ' + ISNULL(EMName,'') + ' ' + ISNULL(ELName,'') AS Name FROM Employee
where EmpID in (1,2470)">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                    SelectCommand="SELECT     Resignation_type_id, Resignation_type
FROM         Resignation_type">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                    InsertCommand="usp_insertresign" InsertCommandType="StoredProcedure" 
                    
                    
                    
                    
                    
                    SelectCommand="SELECT     Resignation.EmpRsgnID, Resignation.EmpID, Resignation.RsgnDate, Resignation.LastWorkingDate, Resignation.RsgnApprDate, Resignation.RsgnApprBy, 
                      Resignation.NoticePeriod, Resignation.RsgnApproved, Resignation.RsgnReason, Resignation.Remarks, Employee.Name, Reg_Emp.Name AS res_name, 
                      Resignation_type.Resignation_type AS Resignation_type
FROM         Resignation INNER JOIN
                      Employee AS Reg_Emp ON Resignation.EmpID = Reg_Emp.EmpID LEFT OUTER JOIN
                      Resignation_type ON Resignation.Resignation_Type = Resignation_type.Resignation_type_id LEFT OUTER JOIN
                      Employee ON Resignation.RsgnApprBy = Employee.EmpID
WHERE     (Resignation.EmpID = @empid)">
                    <InsertParameters>
                        <asp:QueryStringParameter Name="EmpID" QueryStringField="empid" Type="Int32" />
                        <asp:Parameter Name="RsgnDate" Type="DateTime" />
                        <asp:Parameter Name="LastWorkingDate" Type="DateTime" />
                        <asp:Parameter Name="NoticePeriod" Type="String" />
                        <asp:Parameter Name="RsgnApproved" Type="Boolean" />
                        <asp:Parameter Name="RsgnApprDate" Type="DateTime" />
                        <asp:Parameter Name="RsgnApprBy" Type="Int32" />
                        <asp:Parameter Name="RsgnReason" Type="String" />
                        <asp:Parameter Name="Remarks" Type="String" />
                        <asp:Parameter Name="Resignation_type" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:QueryStringParameter Name="empid" QueryStringField="empid" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table><br />
 </div>
    <br/>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  
                    DataKeyNames="EmpRsgnID" DataSourceID="SqlDataSource2" 
        Width="100%" EmptyDataText="No Record Found">
                    <Columns>
                     <asp:BoundField DataField="res_name" HeaderText="Employee" 
                            SortExpression="res_name" />
                        <asp:BoundField DataField="EmpRsgnID" HeaderText="EmpRsgnID" visible="false"
                            InsertVisible="False" ReadOnly="True" SortExpression="EmpRsgnID" />
                        <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" visible="false"/>
                        <asp:BoundField DataField="RsgnDate" HeaderText="Resign Date"  DataFormatString="{0:dd/MM/yyyy}"
                            SortExpression="RsgnDate" />
                        <asp:BoundField DataField="LastWorkingDate" HeaderText="Last Work Day"  DataFormatString="{0:dd/MM/yyyy}"
                            SortExpression="LastWorkingDate" />
                        <asp:BoundField DataField="NoticePeriod" HeaderText="Notice Period(Month)" 
                            SortExpression="NoticePeriod" />
                        <asp:CheckBoxField DataField="RsgnApproved" HeaderText="Is Approved" 
                            SortExpression="RsgnApproved" />
                        <asp:BoundField DataField="RsgnApprDate" HeaderText="Approve Date"  DataFormatString="{0:dd/MM/yyyy}"
                            SortExpression="RsgnApprDate" />
                        <asp:BoundField DataField="Name" HeaderText="Approved By" 
                            SortExpression="Name" />
                        <asp:BoundField DataField="RsgnReason" HeaderText="Reason" 
                            SortExpression="RsgnReason" />
                             <asp:BoundField DataField="Resignation_Type" HeaderText="Resignation Type" 
                            SortExpression="Resignation_Type" />
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" 
                            SortExpression="Remarks" />

                    </Columns>
                </asp:GridView>
                
</asp:Content>

