<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="CreateDemandFromDemands.aspx.cs" Inherits="Store_Demad_CreateDemandFromDemands" %>
 
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Create Demand From Multiple Demands</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="25%">From Department :</td>
                <td align="left" width="25%">
                    <asp:DropDownList ID="ddlSubDept" runat="server" DataValueField="SubDept_Id" DataTextField="SubDept_Name"></asp:DropDownList>
                </td>
                <td align="right" width="25%">From Employee :</td>
                <td align="left" width="25%">
                    <asp:DropDownList ID="ddlEmployee" runat="server" DataValueField="EmpID" DataTextField="Name"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="25%">From Date :</td>
                <td align="left" width="25%">


                    <igsch:WebDateChooser ID="txtStartDate" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser> 
                  
                </td>
                <td align="right" width="25%">To Date :</td>
                <td align="left" width="25%">

                    <igsch:WebDateChooser ID="txtEndDate" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser> 
                   
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnGenDemand" runat="server" Text="Generate Demand" OnClick="btnGenDemand_Click" Visible="false" />
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 10px;">
        <asp:GridView ID="gvSearch" runat="server" Width="100%" AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField HeaderText="Sr. #">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Demand #">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDemandID" runat="server" Text='<%# Eval("Demand_RQ_ID") %>' OnClick="lnkDemandID_Click"
                            CommandArgument='<%# Eval("Demand_RQ_ID") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Date_Time" HeaderText="Date" />
                <asp:BoundField DataField="FromSubDept" HeaderText="From Department" />
                <asp:BoundField DataField="FromEmployee" HeaderText="From Employee" />
                <asp:BoundField DataField="TotalItems" HeaderText="Total Items" />
                <asp:BoundField DataField="TotalQty" HeaderText="Total Qty" />
                <asp:BoundField DataField="EstimatedAmount" HeaderText="Estimated Amount" />
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkAll_CheckedChanged" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chk" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <asp:Panel ID="pnlGen" runat="server" CssClass="lightbox" Visible="false">
        <table border="0" cellpadding="0" cellspacing="0" class="bxmain tbl_form" width="100%">
            <tr>
                <td align="right" width="40%">
                    Send To Department :
                </td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlSendTo" runat="server" DataValueField="SubDept_Id" DataTextField="SubDept_Name"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">
                    Remarks :
                </td>
                <td align="left" width="60%">
                   <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Width="150px" Height="75px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2">
                    <asp:Button ID="btnGenerateNewDemand" runat="server" Text="Generate" OnClick="btnGenerateNewDemand_Click" />
                    <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" />
                    <asp:HiddenField ID="hdfYearlyCounter" runat="server" />
                    <asp:HiddenField ID="hdfNewDemandNo" runat="server" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>

