<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="SearchApplicantsQualificationPercentage.aspx.cs"
    Inherits="HR_SearchApplicantsQualificationPercentage" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Interview / Entry Test Result</span></h2>
        <table width="100%" cellspacing="0" cellpadding="0" border="0px">
            <tr>
                <td>
                    <span style="margin-left: 30%;">
                        <label runat="server" class="spacing" id="Label1">
                            Advertisment
                        </label>
                    </span>
                    <asp:DropDownList ID="DDL_Advertisement" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDL_Advertisement_SelectedIndexChanged">
                    </asp:DropDownList>
                    <label runat="server" class="spacing" id="Label2">
                        Post
                    </label>
                    <asp:DropDownList ID="ddlPosts" runat="server" OnSelectedIndexChanged="ddlPosts_SelectedIndexChanged">
                    </asp:DropDownList>
                    <label runat="server" class="spacing" id="Label3">
                        Age Criteria
                    </label>
                    <asp:DropDownList ID="DDL_AgeCriteria" runat="server">
                        <asp:ListItem Text="All" Selected="True" Value="1"></asp:ListItem>
                        <asp:ListItem Text="On Merit" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Over Age" Value="3"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" style="padding-top: 10px;">
                    <asp:Button ID="btnSearch" Text="Search" Visible="true" runat="server" OnClick="btnSearch_Click"
                        CausesValidation="false" />
                    <asp:Button ID="btnReport" Visible="true" Text="Report" runat="server" OnClick="btnReport_Click"
                        CausesValidation="false" />
                    <asp:Button ID="btn_export" Visible="false" Text="Export" runat="server" OnClick="btn_exportClick"
                        CausesValidation="false" />
                    <%--<asp:Button ID="btn_export" runat="server" Text="Export" OnClick= />--%>
                    <%--<asp:Button ID="btnBlankReport" runat="server" Text="Blank Merit Report" OnClick="btnBlankReport_Click"
                        CausesValidation="false" />--%>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:Panel ID="PanelToAddRemarks" runat="server" Visible="false" CssClass="lightbox_bg">
            <div class="lightbox">
                <div style="display: inline; float: left; width: 90%;" class="bxmain inner_content">
                    <table width="100%">
                        <tr>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <td>
                                Remarks:
                            </td>
                            <td>
                                <asp:TextBox ID="txtRemarks" TextMode="MultiLine" Width="350px" Height="200px" runat="server"></asp:TextBox>
                                <asp:Label ID="lblWarning" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
                            </td>
                        </tr>
                        <tr style="line-height: 3;">
                            <td style="padding-left: 20px; text-align: center" colspan="2">
                                <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
                                <asp:Button ID="Button2" runat="server" Text="Close" OnClick="Button2_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </asp:Panel>
    </div>
    <div style="width: 100%;">
        <asp:GridView Width="100%" AutoGenerateColumns="true" ID="GridView_Applicants" runat="server"
            ShowHeaderWhenEmpty="true" OnRowDataBound="GridView_Applicants_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Select">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkbox" runat="server" OnCheckedChanged="chkbox_CheckedChanged" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Remarks">
                    <ItemTemplate>
                        <asp:LinkButton ID="Remarks" runat="server" OnClick="LinkButton1_Click">Remarks</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div style="text-align: center; padding-top: 10px;">
        <asp:Button ID="btnSelect" runat="server" Text="Select" OnClick="btnSelect_Click" />
    </div>
    <div runat="server" id="appDetails" style="width: 100%" class="bxmain inner_content">
        <h2>
            <span style="font-size: 20px;">Selected Candidate's</span></h2>
        <asp:GridView AutoGenerateColumns="false" ID="gvdAApplicants" runat="server" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Un-Select">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkboxUnSelect" runat="server" OnCheckedChanged="chkboxUnSelect_CheckedChanged" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Name" DataField="Name" />
                <asp:BoundField HeaderText="ID" DataField="AppID"/>
                <asp:BoundField HeaderText="CNIC" DataField="CNIC" />
                <asp:BoundField HeaderText="Present address" DataField="Present_address" />
                <asp:BoundField HeaderText="Home Address" DataField="HomeAdd" />
                <asp:BoundField HeaderText="Mobile_Number" DataField="Mobile_Number" />
                <asp:BoundField HeaderText="District Name" DataField="DistrictName" />
                
            </Columns>
        </asp:GridView>
        <div style="text-align: center; padding-top: 10px;">
        <asp:Button ID="BtnUnselect" runat="server" Text="Un-Select" OnClick="BtnUnselect_Click"/>
    </div>
    </div>
    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
    </rsweb:ReportViewer>
</asp:Content>
