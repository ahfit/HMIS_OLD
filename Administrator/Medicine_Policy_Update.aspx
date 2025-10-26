<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Medicine_Policy_Update.aspx.cs" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Administrator_Discount_Policy_Update" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script language="javascript" type="application/javascript">
        $(document).ready(function () {

        });
        function selectMedicine(sender, e) {
            $("[id$='HiddenField_MedCode']").val(e.get_value());
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="../autocomplete.asmx" />
        </Services>
    </asp:ScriptManager>
    <cc1:AutoCompleteExtender ID="GetMedication" runat="server" CompletionInterval="10"
        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
        CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionSetCount="12" OnClientItemSelected="selectMedicine"
        EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetMedication" ServicePath="../AutoComplete.asmx"
        TargetControlID="txtMedicine">
    </cc1:AutoCompleteExtender>

    <div class="inner_content" style="width: 100%;">
        <h2 style="font-size: 17px">Medicine Discount Policy
        </h2>
    </div>

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top">

                <h1 class="h1" style="width: 98%">
                    <span>Select Medicines</span></h1>

                <div class="bxmain" style="width: 98%">
                    <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                        <tr>
                            <td width="24%" align="right">Hospital :</td>
                            <td width="76%">
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_Hospital"
                                    DataTextField="Hospital_Name" DataValueField="Hospital_ID" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital] ORDER BY [Attachment_Name]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Patient Type :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Patient_Type" runat="server" OnSelectedIndexChanged="DropDownList_Patient_Type_SelectedIndexChanged" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="display:none;">
                            <td align="right">Select Medicine :</td>
                            <td>
                                <asp:TextBox ID="txtMedicine" runat="server" CssClass="input_txt" Width="200px" AccessKey="n"></asp:TextBox>
                                <asp:CheckBox ID="CHKAll" runat="server" Text="All" AutoPostBack="true" OnCheckedChanged="CHKAll_CheckedChanged" />

                                <asp:HiddenField ID="HiddenField_MedCode" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Percentage (%) :</td>
                            <td>
                                <asp:TextBox ID="txtPercentage" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>

            <td width="50%" valign="top">
                <h1 class="h1">
                    <span>Medicines (Patient Type Wise)</span></h1>
                <div style="height:400px; overflow-y:auto">
                    <asp:GridView ID="gvdMedicine" runat="server" AutoGenerateColumns="false">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr #">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle Width="8%" HorizontalAlign="Center"/>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Medicine Name" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblMedName" runat="server" Text='<%# Eval("Item_Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Type Name" >
                            <ItemTemplate>
                                <asp:Label ID="lblPatientType" runat="server" Text='<%# Eval("Patient_Type") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Discount (%)">
                            <ItemTemplate>
                                <asp:Label ID="lblPercentage" runat="server" Text='<%# Eval("Percentage") %>'></asp:Label>
                                <asp:HiddenField ID="hfMed_Code" runat="server" Value='<%# Eval("Item_Code") %>' />
                            </ItemTemplate>
                            <ItemStyle Width="8%" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lknbtnDelMed" Text="Delete" runat="server" CommandArgument='<%# Eval("Item_Code") %>' OnClick="lknbtnDelMed_Click"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Width="8%" HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                </div>
            </td>

        </tr>
    </table>

</asp:Content>

