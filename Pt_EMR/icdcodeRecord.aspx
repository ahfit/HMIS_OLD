<%@ Page  Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="icdcodeRecord.aspx.cs" Inherits="Pt_EMR_icdcodeRecord " %>

<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function icdcodeselected(sender, e) {
            $get("<%=txt_Code.ClientID %>").value = e.get_value();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    <Services>
      <asp:ServiceReference Path="../autocomplete.asmx" />
    </Services>
  </asp:ScriptManager>
    <div class="bxmain">
        <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
            <h2><span>Search</span></h2>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                 <tr>
                    <td align="right" width="40%">Visit No :</td>
                    <td align="left" width="60%">
                        <asp:TextBox ID="txtboxVisitno" Height="20px" runat="server"></asp:TextBox>
                </tr>
                <tr>
                    <td align="right" width="40%">Category :</td>
                    <td align="left" width="60%">
                        <asp:DropDownList ID="ddlCategory" Height="20px" runat="server"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="right" width="40%">ICD Name :</td>
                    <td align="left" width="60%">
                        <asp:TextBox ID="txtDisease" Height="20px" runat="server"></asp:TextBox>
                        <span style="color: #ff0000">*
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDisease"
                                ErrorMessage="ICD Name Required"></asp:RequiredFieldValidator>
                        </span>
                        <asp:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionListCssClass="AutoExtender"
                            CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
                            OnClientItemSelected="icdcodeselected" CompletionInterval="10" CompletionSetCount="12"
                            EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetDiagnosisList"
                            TargetControlID="txtDisease">
                        </asp:AutoCompleteExtender>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="40%">ICD Code :</td>
                    <td align="left" width="60%">
                        <asp:TextBox ID="txt_Code" Height="20px" runat="server"></asp:TextBox>
                        <span style="color: #ff0000">*
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_Code"
                                ErrorMessage="ICD Code Required"></asp:RequiredFieldValidator>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="40%">Date :</td>
                    <td align="left" width="60%">
                        <igsch:WebDateChooser ID="StartDate" Height="20px" runat="server"
                            Width="202px">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="40%">Type :</td>
                    <td align="left" width="60%">
                        <asp:TextBox ID="txtType" Height="20px" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="40%">Remarks :</td>
                    <td align="left" width="60%">
                        <asp:TextBox ID="txt_Remarks" TextMode="MultiLine" Height="30px" MaxLength="20" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="40%"></td>
                    <td align="left" width="60%">
                        <asp:Button ID="btnSave" OnClick="btnSave_Click" runat="server" Text="Save" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="bxmain inner_content" style="width: 100%;">
            <asp:GridView ID="gridview" runat="server" Width="100%" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="ICD Code">
                        <ItemTemplate>
                            <asp:Label ID="lblIcdCode" Text='<%# Bind("IcdCode") %>' runat="server" />
                        </ItemTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Category Name">
                        <ItemTemplate>
                            <asp:Label ID="itAsc_Namee" Text='<%# Bind("Asc_Name") %>' runat="server" />
                        </ItemTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="discunt" Text='<%# Bind("Date") %>' runat="server" />
                        </ItemTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remarks">
                        <ItemTemplate>
                            <asp:Label ID="Remarks" Text='<%# Bind("Remarks") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Type">
                        <ItemTemplate>
                            <asp:Label ID="Type" Text='<%# Bind("Type") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

