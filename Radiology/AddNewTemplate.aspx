<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="AddNewTemplate.aspx.cs" Inherits="Radiology_AddNewTemplate" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    

    <script type="text/javascript">
        $(document).ready(
            function () {
                $('[id$="TextBox_Description"]').redactor();
                $("#ctl00_ContentPlaceHolder1_TextBox_Description").clcc1({ width: "98%" });
            }
        );
        function ClientItemSelected(sender, e) {
            $get("<%=hdftest.ClientID %>").value = e.get_value();
        }
    </script>
    <script type="text/javascript">
    </script>
    <style type="text/css">
        .style1 {
            width: 40%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>

    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Insert/ Modify Radiology Template</span></h2>

        <table class="tbl_form">
            <tr>
                <td align="right" class="style1">
                    <strong>Test :</strong> </td>
                <td colspan="2">
                    <asp:TextBox runat="server" ID="txtGroup" AutoPostBack="true" OnTextChanged="DDL_Test_SelectedIndexChanged" />
                    <ajx:AutoCompleteExtender TargetControlID="txtGroup" ID="autoextender1" runat="server" ServiceMethod="GetRadioTest"
                        MinimumPrefixLength="2" OnClientItemSelected="ClientItemSelected">
                    </ajx:AutoCompleteExtender>
                    <asp:HiddenField runat="server" ID="hdftest" />
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Template :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Template" runat="server" 
                        CssClass="drop_down" DataTextField="Templates_Name"
                        DataValueField="Radiology_templates_ID" AutoPostBack="True" OnSelectedIndexChanged="DDL_Template_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:Button Text="Delete Template" ID="btnDelTem" OnClick="btnDelTem_Click" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Template Name :</strong></td>
                <td colspan="2">

                    <asp:TextBox runat="server" ID="txtTemplate" />
                    <asp:Button Text="Clear Fields" ID="btnclear" OnClick="btnclear_Click" runat="server" />
                </td>
            </tr>
            <tr>

                <td colspan="2">

                    <CKEditor:CKEditorControl ID="TextBox_Description" BasePath="../ckeditor/" runat="server">
                     </CKEditor:CKEditorControl>
                    
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button Text="Save" ID="btnSave" OnClick="btnSave_Click" runat="server" />
                     <asp:Button Text="Report" ID="btnReport" OnClick="btnReport_Click" runat="server" />
                    <asp:Label ID="lblMsg" Text="Saved Successfully" ForeColor="Green" Visible="false" Font-Bold="true" runat="server" />

                </td>
            </tr>
        </table>
    </div>
    <div>

        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"
            Height="500px">
        </rsweb:ReportViewer>
    </div>
</asp:Content>

