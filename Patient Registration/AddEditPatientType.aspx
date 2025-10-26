<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AddEditPatientType.aspx.cs" Inherits="Patient_Registration_AddEditPatientType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%"><span><h2>Add Patient Type</h2></span>
    <table class="diagnosis_list">
        <tr>
            <td align="right"><strong>Add Edit Patient Type :</strong></td>
            <td>
                <asp:TextBox ID="Txt_EditPatientType" runat="server" Width="202px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:Button ID="btn_markReceptionest" runat="server" Text="Add Edit Patient Type" 
                    onclick="btn_markReceptionest_Click" />
                <asp:Label ID="lblmg" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        </table>
        </div>
        <div>
                <asp:GridView  ID="GridView1" AutoGenerateColumns="false" runat="server" Width="100%">
              <Columns>
                  
                  <asp:TemplateField HeaderText="Type ID">
                      <ItemTemplate>
                          <asp:Label ID="lblid" runat="server" Text='<%#Bind("ID") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Edit Patient Type">
                      <ItemTemplate>
                          <asp:Label ID="lblName" runat="server" Text='<%#Bind("EditType") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delete">
             <ItemTemplate>
                    <asp:LinkButton ID="del" Text="Delete" CommandName='<%# Bind("ID") %>' runat="server" OnClick="deleteRecord" > </asp:LinkButton>
                </ItemTemplate>
           
                 </asp:TemplateField>
              </Columns>
                      </asp:GridView>
                    <asp:HiddenField runat="server" id = "HF_Status"></asp:HiddenField>  
            </div>
</asp:Content>

