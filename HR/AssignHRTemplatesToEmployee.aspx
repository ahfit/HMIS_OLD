<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AssignHRTemplatesToEmployee.aspx.cs" Inherits="HR_AssignHRTemplatesToEmployee" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script type="text/javascript">
           
          function Close() {
              $('[id$="panel"]').hide();
              return false;
          }
    </script>

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
        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
         <span style="padding-left:20px"><asp:HyperLink ID="hyperlink" runat="server" NavigateUrl="~/HR/TemplateType.aspx"></asp:HyperLink>  </span>
    </div>
     <asp:Panel ID="panel" Visible="false" CssClass="lightbox_bg" runat="server">
        <div class="lightbox"   >
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Assign Template To Employee</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right">
                   Template Name :   
                </td>
                <td>
                        
                    <asp:DropDownList OnPreRender="ddlTemplateName_PreRender" AutoPostBack="true" OnSelectedIndexChanged="ddlTemplateName_SelectedIndexChanged" ID="ddlTemplateName" runat="server"></asp:DropDownList>
                    <asp:Button ID="btnClose" runat="server" Text="Close"  UseSubmitBehavior="false" OnClientClick="return Close();" />
                </td>
            </tr>
             <tr>
              <td align="right">
                    Heading Name :
                </td>
                <td>
                    <asp:TextBox ID="txtboxHeadingName" runat="server" Enabled="false"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  
                        ControlToValidate="txtboxHeadingName" ValidationGroup="mainApp" ErrorMessage="Template Heading is Required" Display="Dynamic"
                        ></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr >
                <td align="right">
                   Template Type : 
                </td>
                <td>
                      <asp:TextBox ID="textboxTemplateType" Enabled="false" runat="server" ></asp:TextBox>
                </td>
            </tr> 
            <tr>
                <td align="right">
                   Department : 
                </td>
                <td>
                    <asp:DropDownList OnSelectedIndexChanged="ddlSubdept_SelectedIndexChanged" AutoPostBack="true" ID="ddlSubdept" runat="server" ></asp:DropDownList>
                </td>
            </tr> 
            <tr>
                <td align="right">
                   Employee : 
                </td>
                <td>
                    <asp:DropDownList ID="ddlEmployee" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged" AutoPostBack="true" runat="server" ></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                   Reference No. : 
                </td>
                <td>
                    <asp:TextBox ID="txtReference" runat="server"></asp:TextBox>
                    <asp:TextBox ID="txtCounterYear" runat="server" Enabled="false"></asp:TextBox>
                </td>
            </tr> 
            <tr>
                <td colspan="5">
                    
                      <asp:GridView ID="gvd" runat="server" AutoGenerateColumns="true">            
                      </asp:GridView>
                        
                </td>
            </tr>
             </table>
            <div>
                   Body : 
             
                     <CKEditor:CKEditorControl ID="textboxBody" BasePath="../ckeditor/" runat="server">
                     </CKEditor:CKEditorControl>
                    
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="textboxBody" ValidationGroup="mainApp" ErrorMessage="Template Body is Required" Display="Dynamic"
                        ></asp:RequiredFieldValidator>
             </div> 
            
            <div style="text-align:center">
                    <asp:Button  ID="btnSave" runat="server" ValidationGroup="mainApp" Text="Save" OnClick="btnSave_Click" />
</div>           
           
        </div>
           </div>
         </asp:Panel>
    

    <div class="bxmain" style="width:100%">

        <table width="100%">
            <tr>
                <td align="right">
                    <asp:Label ID="lblTemplateName" runat="server" Font-Bold="true" Text="Template Name :"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlTemplateNameForSearch" runat="server"></asp:DropDownList>
                </td>
                 <td align="right">
                    <asp:Label ID="lblDept" runat="server" Font-Bold="true" Text="Department :"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddLDepartmentForSearch" AutoPostBack="true" OnSelectedIndexChanged="ddLDepartmentForSearch_SelectedIndexChanged" runat="server"></asp:DropDownList>
                </td>
                <td align="right">
                    <asp:Label ID="Label1" runat="server" Text="Employee :" Font-Bold="true"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlEmployeeForSearch" runat="server"></asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>

        <div style="margin-top:10px;">
        <asp:GridView ID="gvdEmployeeDetail" AutoGenerateColumns="false" runat="server">
            <EmptyDataTemplate>
                <div style="color:red;font-size:13px;text-align:center">
                    No Record Found
                </div>
            </EmptyDataTemplate>
            <Columns>
                <asp:BoundField HeaderText="Employee Name" DataField="EmployeeName" />
                <asp:BoundField HeaderText="Relation" DataField="Relation" />
                <asp:BoundField HeaderText="Relation Name" DataField="RelationName" />
                <asp:BoundField HeaderText="CNIC" DataField="CNIC" />
                <asp:BoundField HeaderText="Dept Name" DataField="SubDept_Name" />
                <asp:BoundField HeaderText="Template Name" DataField="TemplateName" />
                <asp:BoundField HeaderText="Template Type" DataField="TemplateType" />  
                <asp:TemplateField HeaderText="Created Date">
                    <ItemTemplate>
                        <asp:Label ID="lblDate" runat="server" Text='<%# Eval("CreatedDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Report">
                <ItemTemplate>
                     <asp:hyperlink id="hpAddAppointment" runat="server" target="_blank" 
                                                 NavigateUrl='<%# String.Format("../HR/EmployeeGenericTemplateReport.aspx?TemplateID={0}&EmpID={1}", Eval("ID"),Eval("EmpID"))%>' 
                                                 Text='Report'></asp:hyperlink>

                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
        </div>
    <asp:HiddenField ID="hfHrTemplateIDMain" runat="server" />
</asp:Content>

