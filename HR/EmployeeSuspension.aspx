<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EmployeeSuspension.aspx.cs" Inherits="HR_EmployeeSuspension" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .bxmain tr {
            line-height: 2;
        }

        .style1 {
            text-align: right;
            width: 256px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <h1 style="color: Maroon; font-size: medium">Employee Suspension</h1>
    </div>
    <br />

    <div style="margin-bottom:10px;">
        <asp:Button ID="btnAddSuspension" runat="server" Text="Add" OnClick="btnAddSuspension_Click" />
    </div>

    <asp:Panel ID="panel" Visible="false" CssClass="lightbox_bg" runat="server">
        <div class="lightbox" >
            <div style="width:100%" class="bxmain">
                <table class="ui-accordion" width="100%">
                    <tr>
                        <td align="left" colspan="2">
                            <asp:Button ID="btnClose" Text="Close" runat="server" OnClick="btnClose_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">From Date:</td>
                        <td>
                            <igsch:WebDateChooser ID="Suspensiondatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                                Visible="true">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">To Date:</td>
                        <td>
                            <igsch:WebDateChooser ID="lastworkdaywebchooser" Width="250px" runat="server" CssClass="drop_date"
                                Visible="true">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">Suspension By:</td>
                        <td>
                            <asp:DropDownList ID="ddlistappeoveby" runat="server"
                                DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="EmpID">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                                ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                SelectCommand="SELECT EmpID, ISNULL(EFName,'') + ' ' + ISNULL(EMName,'') + ' ' + ISNULL(ELName,'') AS Name FROM Employee
 "></asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">Suspension Reason:</td>
                        <td>
                            <asp:TextBox ID="tbxresgreason" runat="server" Height="50px"
                                TextMode="MultiLine" Width="300px"></asp:TextBox>
                            <asp:Label ID="Label1" runat="server" BorderColor="#FF6600" Font-Bold="True"></asp:Label>
                        </td>
                    </tr>
                    <tr style="padding-top: 5px">
                        <td class="style1">Remarks:</td>
                        <td>
                            <asp:TextBox ID="tbxremarks" runat="server" Height="50px" TextMode="MultiLine"
                                Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="padding-top: 5px">
                        <td class="style1">Status:</td>
                        <td>
                            <asp:DropDownList ID="ddllistSuspension" runat="server">
                                <asp:ListItem Value="0" Text="Suspension"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Rejoin"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="padding-top: 5px;padding-left:10px;">
                        <td colspan="2" align="center">
                            <asp:Button ID="btnSave" OnClick="btnSave_Click" runat="server" Text="Save" />
                        </td>
                    </tr>
                    

                </table>
                <div>
                          <div style="width:100%;overflow:auto;height:110px ">
                            <asp:GridView ID="gvHistory" Width="100%" runat="server" AutoGenerateColumns="false" EmptyDataText="No Record Found" >
                                  <Columns>
                <asp:TemplateField HeaderText="Emp Name">
                    <ItemTemplate>
                        <asp:Label ID="lblEmpName1" runat="server" Text='<%# Eval("EmpName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Approve By">
                    <ItemTemplate>
                        <asp:Label ID="ApprovedBY1" runat="server" Text='<%# Eval("ApproveBy") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="From Date">
                    <ItemTemplate>
                        <asp:Label ID="FromDate1" runat="server" Text='<%# Eval("FromDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="To Date">
                    <ItemTemplate>
                        <asp:Label ID="ToDate1" runat="server" Text='<%# Eval("ToDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="SuspensionStatus1" runat="server" Text='<%# Eval("Status") %>'></asp:Label>                       
                    </ItemTemplate>
                </asp:TemplateField>
                 


            </Columns>
                            </asp:GridView>
                                </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    
        <asp:GridView ID="grdEmpSuspension" runat="server" EmptyDataText="No Record Found . . ." AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField HeaderText="Emp Name">
                    <ItemTemplate>
                        <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("EmpName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Approve By">
                    <ItemTemplate>
                        <asp:Label ID="ApprovedBY" runat="server" Text='<%# Eval("ApproveBy") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="From Date">
                    <ItemTemplate>
                        <asp:Label ID="FromDate" runat="server" Text='<%# Eval("FromDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="To Date">
                    <ItemTemplate>
                        <asp:Label ID="ToDate" runat="server" Text='<%# Eval("ToDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="SuspensionStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>                       
                    </ItemTemplate>
                </asp:TemplateField>
                 


            </Columns>
        </asp:GridView>
    


</asp:Content>

