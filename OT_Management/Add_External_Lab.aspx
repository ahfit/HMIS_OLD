<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="true"
    CodeFile="Add_External_Lab.aspx.cs" Inherits="Radiology_Add_External_Lab"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
 <style type="text/css">
 
 .small_f {color:#f08f68 ; font-size:10px; }
  #nav {display:none; }
  .leftnav {display:none;}
 #header {display:none;}
 #navigation {display:none;}
#p_info {display:none;}
 #footer {display:none;}
   A.rpt_link {display:none;}
   .hinfo {display:none; }
 </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td style="width: 100px">
                External Lab Name</td>
            <td style="width: 100px">
                <asp:TextBox ID="txtLabName" runat="server"></asp:TextBox></td>
            <td style="width: 339px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 339px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
            <td colspan="2">
                <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" Width="65px" />&nbsp;
                <asp:Label ID="lblMessage" runat="server"></asp:Label></td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource_Save" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        InsertCommand="INSERT_Admin_External_Lab" InsertCommandType="StoredProcedure"
        OnInserted="SqlDataSource_Save_Inserted" SelectCommand="SELECT [External_Lab_ID], [External_Lab] FROM [Admin_External_Lab]" DeleteCommand="DELETE FROM Admin_External_Lab WHERE External_Lab_ID = @External_Lab_ID">
        <InsertParameters>
            <asp:ControlParameter ControlID="txtLabName" Name="External_Lab" PropertyName="Text"
                Type="String" />
            <asp:Parameter Direction="Output" Name="Identity" Type="Int32" />
        </InsertParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_Lab_ID" Name="External_Lab_ID" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <br />
    <asp:GridView ID="gvExternalLab" runat="server" AutoGenerateColumns="False" DataKeyNames="External_Lab_ID"
        DataSourceID="SqlDataSource_Save">
        <Columns>
            <asp:TemplateField HeaderText="Sr. No.">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="External_Lab" HeaderText="External Lab Name" SortExpression="External_Lab" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnDelete" runat="server" CommandArgument='<%# Eval("External_Lab_ID", "{0}") %>'
                        OnClick="lbtnDelete_Click">Delete</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:HiddenField ID="HiddenField_Lab_ID" runat="server" />
</asp:Content>
