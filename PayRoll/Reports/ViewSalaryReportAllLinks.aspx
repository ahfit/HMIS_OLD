<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage.master" autoeventwireup="false" inherits="PayRoll_ViewSalaryReportAllLinks, App_Web_0baqw4fh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="bxmain">
        <h2>Salary Reports</h2>

        <div style="width:100%;">
        <table style="text-align: center;width:80%;margin:auto;">
        <tr>
            <td class="style2" style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=1" ID="HyperLink2"
                    runat="server" ToolTip="Account Head Summary" 
                    ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
            <td class="style2" style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=2" ID="HyperLink3"
                    runat="server" ToolTip="Account Head Detail" 
                    ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
            <td class="style2" style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=3" ID="HyperLink6"
                    runat="server" ToolTip="Department Wise Summary" 
                    ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=1" ID="hlnkAllSurveyForms"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Account Head Summary"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=2" Style="text-decoration: none;
                    font-weight: bold; font-size: 12px; padding-bottom: 5px; color: Blue;" ID="hlnkSurveyFormUsers"
                    runat="server" Text="Account Head Detail"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=3" Style="text-decoration: none;
                    font-weight: bold; font-size: 12px; padding-bottom: 5px; color: Blue;" ID="HyperLink19"
                    runat="server" Text="Department Wise Summary"></asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td class="style2" style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=4" ID="HyperLink4"
                    runat="server" Text="Department Wise Detail" 
                    ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px" class="style2">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=5" ID="HyperLink5"
                    runat="server" Text="Designation Wise Summary" 
                    ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px" class="style2">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=6" ID="HyperLink20"
                    runat="server" Text="Designation Wise Detail" 
                    ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=4" ID="hlnkSurveyFormSummary"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Department Wise Detail"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=5" Style="text-decoration: none;
                    font-weight: bold; font-size: 12px; padding-bottom: 5px; color: Blue;" ID="HyperLink1"
                    runat="server" Text="Designation Wise Summary"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=6" Style="text-decoration: none;
                    font-weight: bold; font-size: 12px; padding-bottom: 5px; color: Blue;" ID="HyperLink21"
                    runat="server" Text="Class Students"></asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=7" ID="HyperLink8"
                    runat="server" Text="Course List" ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=8" ID="HyperLink9"
                    runat="server" Text="Degree Program" ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx??RepId=9" ID="HyperLink22"
                    runat="server" Text="Degree Program" ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=7" ID="HyperLink7"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Course List"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=8" ID="HyperLink10"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Degree Program"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=9" ID="HyperLink23"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Degree Program"></asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td style="padding: 0px 0px 0px 120px" class="style2">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=10" ID="HyperLink11"
                    runat="server" Text="This Month Visit" ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=11" ID="HyperLink12"
                    runat="server" Text="Semester List" ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=12" ID="HyperLink24"
                    runat="server" Text="Semester List" ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=10" ID="HyperLink13"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Degree Program Semester"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=11" ID="HyperLink14"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Semester List"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=12" ID="HyperLink25"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Semester List"></asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td style="padding: 0px 0px 0px 120px" class="style2">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=13" ID="HyperLink15"
                    runat="server" Text="Student List" ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=14" ID="HyperLink16"
                    runat="server" Text="Teacher List" ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=15" ID="HyperLink26"
                    runat="server" Text="Teacher List" ImageUrl="~/images/Report-100-x-100.png"></asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=13" ID="HyperLink17"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Student List"></asp:HyperLink>
            </td>
            <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=14" ID="HyperLink18"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Teacher List"></asp:HyperLink>
            </td>
             <td style="padding: 0px 0px 0px 120px">
                <asp:HyperLink NavigateUrl="~/PayRoll/ViewSalaryReports.aspx?RepId=15" ID="HyperLink27"
                    Style="text-decoration: none; font-weight: bold; font-size: 12px; padding-bottom: 5px;
                    color: Blue;" runat="server" Text="Teacher List"></asp:HyperLink>
            </td>
        </tr>
    </table>
    </div>

    </div>
    
    
</asp:Content>
