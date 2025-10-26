<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="FullandFinalSettelement.aspx.cs" Inherits="HR_FullandFinalSettelement" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <div class="bxmain inner_content" style="width:100%">
        <span><h2>Full and Final Settlement</h2></span>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
         <tr>
            <td align="right" class="style1">
                <strong>From Salary Month :</strong></td>
            <td>
                <asp:DropDownList ID="DDLMonth" runat="server"  Width="100px">


                    <asp:ListItem Value="1">January</asp:ListItem>
                            <asp:ListItem Value="2">February</asp:ListItem>
                            <asp:ListItem Value="3">March</asp:ListItem>
                            <asp:ListItem Value="4">April</asp:ListItem>
                            <asp:ListItem Value="5">May</asp:ListItem>
                            <asp:ListItem Value="6">June</asp:ListItem>
                            <asp:ListItem Value="7">July</asp:ListItem>
                            <asp:ListItem Value="8">August</asp:ListItem>
                            <asp:ListItem Value="9">September</asp:ListItem>
                            <asp:ListItem Value="10">October</asp:ListItem>
                            <asp:ListItem Value="11">November</asp:ListItem>
                            <asp:ListItem Value="12">December</asp:ListItem>


                </asp:DropDownList>
                </td>
                  <%-- <igsch:webdatechooser id="WebDateChooser_Start_Date" runat="server" CssClass="drop_down">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:webdatechooser>
        <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />--%>
           </tr>
                <tr>
            <td align="right" class="style1">
                <strong>From Salary Year :</strong></td>
            <td>
                        <asp:DropDownList ID="DDLYear" runat="server"  Width="60px">
                            <asp:ListItem Value="2011">2011</asp:ListItem>
                            <asp:ListItem Value="2012">2012</asp:ListItem>
                            <asp:ListItem Value="2013">2013</asp:ListItem>
                            <asp:ListItem Value="2014">2014</asp:ListItem>
                            <asp:ListItem Value="2015">2015</asp:ListItem>
                            <asp:ListItem Value="2016">2016</asp:ListItem>
                            <asp:ListItem Value="2017">2017</asp:ListItem>
                            <asp:ListItem Value="2018">2018</asp:ListItem>
                            <asp:ListItem Value="2019">2019</asp:ListItem>
                            <asp:ListItem Value="2020">2020</asp:ListItem>
                            <asp:ListItem Value="2021">2021</asp:ListItem>
                            <asp:ListItem Value="2022">2022</asp:ListItem>

                        </asp:DropDownList>
                    </td>
        </tr>
            <td colspan="4" align="center">
                    <asp:Button ID="btnReport" runat="server" Text="Report" OnClick="btnReport_Click"/>
            </table>
    </div>
    <%--<div class="bxmain" style="width:100%">
        
                <asp:GridView ID="GridView1" runat="server">

                </asp:GridView>--%>

            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>


            <rsweb:ReportViewer ID="ReportViewer1" Width="100%"  runat="server"></rsweb:ReportViewer>




    <%--</div>--%>
        <%--</div>--%>
</asp:Content>

