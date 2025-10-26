<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="TemplateType.aspx.cs" Inherits="HR_TemplateType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1{
            text-align:right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Template Types</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td class="style1">
                   Type Name :    
                </td>
                <td class="style2">
                         <asp:TextBox ID="txtboxTemplateType" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validator" runat="server"
                        ControlToValidate="txtboxTemplateType" ValidationGroup="mainApp" ErrorMessage="Template Type is Required" Display="Dynamic"
                        ></asp:RequiredFieldValidator>
                    <asp:Button ID="btnClose" ValidationGroup="mainApp" runat="server" Text="Save" OnClick="btnClose_Click" />
                </td>
            </tr>
            </table>
          </div>

    <asp:GridView ID="grd"  runat="server" AutoGenerateColumns="False" DataKeyNames="TemplateTypeID" DataSourceID="datasource">
        <Columns>
            <asp:CommandField  ShowEditButton="True" />
            <asp:BoundField DataField="TemplateTypeID" Visible="false" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="TemplateTypeID" />
            <asp:BoundField DataField="TemplateType" HeaderText="Template Type" SortExpression="TemplateType" />
        </Columns>
      </asp:GridView>

    <asp:SqlDataSource ID="datasource" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" DeleteCommand="DELETE FROM [HR_TemplatesType] WHERE [TemplateTypeID] = @TemplateTypeID" InsertCommand="INSERT INTO [HR_TemplatesType] ([TemplateType]) VALUES (@TemplateType)" SelectCommand="SELECT * FROM [HR_TemplatesType] where Hospital_ID = @HospitalId" UpdateCommand="UPDATE [HR_TemplatesType] SET [TemplateType] = @TemplateType WHERE [TemplateTypeID] = @TemplateTypeID">
        <DeleteParameters>
            <asp:Parameter Name="TemplateTypeID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TemplateType" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="TemplateType" Type="String" />
            <asp:Parameter Name="TemplateTypeID" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter Name="HospitalId" SessionField="HospitalID"/>
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

