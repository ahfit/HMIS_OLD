<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="HR_GenericTemplates.aspx.cs" Inherits="HR_HR_GenericTemplates" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript">


         function Close() {
             $('[id$="panel"]').hide();
             return false; 
        }

    </script>


     <style type="text/css">

         .lblStyle{
              white-space: nowrap; 
    width: 50px; 
    overflow: hidden;
    text-overflow: ellipsis; 
    
         }


        .style1
        {
            width: 40%;
            text-align: right;
        }
        
        .style2
        {
            width: 60%;
            text-align: left;
        }
        
        .Panelstyle1
        {
            width: 22%;
            text-align: right;
        }
        
        .Panelstyle2
        {
            width: 22%;
            text-align: left;
        }
    </style>
     <style type="text/css">
       .lightbox {
            height: 670px;
            position: absolute;
            top: 216px;
            width: 1045px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div style="margin-bottom:10px;">
        <asp:Button ID="btnAddGenericTemplate" runat="server" Text="Add" OnClick="btnAddGenericTemplate_Click" />
         <span style="padding-left:20px"><asp:HyperLink Target="_blank" ID="hyperlink" Text="Add Template Type" runat="server" NavigateUrl="~/HR/TemplateType.aspx"></asp:HyperLink>  </span>
    </div>
     <asp:Panel ID="panel" Visible="false" CssClass="lightbox_bg" runat="server">
        <div class="lightbox"  >
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Generic Templates</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td class="style1">
                   Template Name :   
                </td>
                <td class="style2">
                         <asp:TextBox ID="txtboxTemplate" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validator" runat="server"
                        ControlToValidate="txtboxTemplate" ValidationGroup="mainApp" ErrorMessage="Template Name is Required" Display="Dynamic"
                        ></asp:RequiredFieldValidator>
                    <asp:Button ID="btnClose" runat="server" Text="Close"  UseSubmitBehavior="false" OnClientClick="return Close();" />
                </td>
            </tr>
             <tr>
                <td class="style1">
                    Heading Name :
                </td>
                <td class="style2">
                    <asp:TextBox ID="txtboxHeadingName" runat="server" ></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="txtboxHeadingName" ValidationGroup="mainApp" ErrorMessage="Template Heading is Required" Display="Dynamic"
                        ></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr >
                <td class="style1">
                   Template Type : 
                </td>
                <td class="style2">
                    <asp:DropDownList ID="ddlTemplateType" runat="server"></asp:DropDownList>
                </td>
            </tr> 
            </table>
         <div> Body : 
                     <CKEditor:CKEditorControl ID="textboxBody" BasePath="../ckeditor/" runat="server">
                     </CKEditor:CKEditorControl>
                    
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ControlToValidate="textboxBody" ValidationGroup="mainApp" ErrorMessage="Template Body is Required" Display="Dynamic"
                        ></asp:RequiredFieldValidator>
             </div>
                  <div style="text-align:center">
                    <asp:Button  ID="btnSave" runat="server" ValidationGroup="mainApp" Text="Save" OnClick="btnSave_Click" />
                </div>
        
        </div>
            </div>
         </asp:Panel>


    <div>
        <asp:GridView ID="gvd" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Template Name" DataField="TemplateName" />
                <asp:BoundField HeaderText="Heading" DataField="Heading" />
                <asp:BoundField HeaderText="Type" DataField="TemplateType" />
                
                <asp:TemplateField HeaderText="Body">
                    <ItemTemplate>
                      <asp:Label ID="lblBody" CssClass="lblStyle" runat="server" Width="100px" ToolTip='<%# Eval("Body") %>' Text='<%# Eval("Body") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbtn" OnClick="lnkbtn_Click"  CommandName='<%# Eval("Body") %>' Text="Update" runat="server"  ></asp:LinkButton>
                        <asp:HiddenField ID="hfID" runat="server" Value='<%# Eval("ID") %>' />
                        <asp:HiddenField ID="hfTemplateTypeID" runat="server" Value='<%# Eval("TemplateTypeID") %>' />
                        <asp:HiddenField ID="hfTemplateName" runat="server" Value='<%# Eval("TemplateName") %>' />
                        <asp:HiddenField ID="hfTemplateHeading" runat="server" Value='<%# Eval("Heading") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <asp:HiddenField ID="hfHrTemplateIDMain" runat="server" />
</asp:Content>

