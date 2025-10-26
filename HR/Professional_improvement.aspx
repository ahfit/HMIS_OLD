<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="HR_PAcedmic_improvement, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 101px;
        }
        .style2
        {
            width: 236px;
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <h1 style="color:  Maroon; font-size:medium" >
            Employee Professional Improvement</h1>
    </div>
    <br />
    <div class="bxmain">
        <table class="ui-accordion">
            <tr>
                <td class="style2">
                    Certificate Name:
                </td>
                <td class="style1">
                    <asp:TextBox ID="tbxcertificate" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Recommended Institute:
                </td>
                <td class="style1">
                    <asp:TextBox ID="tbxinstitute" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Recommended By:
                </td>
                <td class="style1">
                    <asp:DropDownList ID="ddrecby" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Recommend Date:
                </td>
                <td class="style1">
                    <igsch:WebDateChooser ID="recdatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                        Visible="true">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Recommended Till:
                </td>
                <td class="style1">
                    <igsch:WebDateChooser ID="Rectillwebchooser" Width="250px" runat="server" CssClass="drop_date"
                        Visible="true">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Remarks:
                </td>
                <td class="style1">
                    <asp:TextBox ID="tbxremarks" runat="server" Height="50px" TextMode="MultiLine" Width="400px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;
                </td>
                <td class="style1">
                    <asp:Button ID="btnsave" runat="server" Text="Save" OnClick="btnsave_Click" />
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
        SelectCommand="SELECT ProfessionalQualificationImprovement.PrfQualificationImpID, ProfessionalQualificationImprovement.EmpID, ProfessionalQualificationImprovement.RecommendedBy, ProfessionalQualificationImprovement.RcmCertDegName, ProfessionalQualificationImprovement.RcmInstitute, ProfessionalQualificationImprovement.RcmDate, ProfessionalQualificationImprovement.MaxImproveDate, ProfessionalQualificationImprovement.Remarks, Employee.Name FROM ProfessionalQualificationImprovement LEFT OUTER JOIN Employee ON ProfessionalQualificationImprovement.RecommendedBy = Employee.EmpID WHERE (ProfessionalQualificationImprovement.EmpID = @empid)"
        InsertCommand="INSERT INTO ProfessionalQualificationImprovement(EmpID, RecommendedBy, RcmCertDegName, RcmInstitute, RcmDate, MaxImproveDate, Remarks) VALUES (@empid, @recby, @recdeg, @recinsti, @recdate, @rectill, @remarks)">
        <InsertParameters>
            <asp:QueryStringParameter Name="empid" QueryStringField="empid" />
            <asp:Parameter Name="recby" />
            <asp:Parameter Name="recdeg" />
            <asp:Parameter Name="recinsti" />
            <asp:Parameter Name="recdate" />
            <asp:Parameter Name="remarks" />
            <asp:Parameter Name="rectill" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="empid" QueryStringField="empid" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT EmpID, ISNULL(EFName,'') + ' ' + ISNULL(EMName,'') + ' ' + ISNULL(ELName,'') AS Name FROM Employee">
    </asp:SqlDataSource>
    <br />
    <br />
 
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource2" Width="100%"
            EmptyDataText="No Record Found" AutoGenerateColumns="False" DataKeyNames="PrfQualificationImpID">
            <Columns>
                <asp:BoundField DataField="PrfQualificationImpID" HeaderText="PrfQualificationImpID"
                    InsertVisible="False" ReadOnly="True" SortExpression="PrfQualificationImpID"
                    Visible="false" />
                <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" Visible="false" />
                <asp:BoundField DataField="RcmCertDegName" HeaderText="Degree" SortExpression="RcmCertDegName" />
                <asp:BoundField DataField="RcmInstitute" HeaderText="Institute" SortExpression="RcmInstitute" />
                <asp:BoundField DataField="Name" HeaderText="Recommended By" SortExpression="Name" />
                <asp:BoundField DataField="RcmDate" HeaderText="Rec. Start Date" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="RcmDate" />
                <asp:BoundField DataField="MaxImproveDate" HeaderText="Rec. End Date" DataFormatString="{0:dd/MM/yyyy}"
                    SortExpression="MaxImproveDate" />
                <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
            </Columns>
        </asp:GridView>

</asp:Content>
