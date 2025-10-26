<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="MarkReceptionest.aspx.cs" Inherits="HR_MarkReceptionest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 386px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <table class="style1">
        <tr>
            <td align="right" class="style2">
                <b>Enter ID :</b></td>
            <td>
                <asp:TextBox ID="TextBox_Receptioniest" runat="server"></asp:TextBox>
            </td>
        </tr>
         <tr>
        <td width = "50%" align = "right">
            <strong>Counter Type :</strong></td>
        <td width = "50%" >
            <asp:DropDownList ID="DDL_CounterType" runat="server">
            </asp:DropDownList>
            
        </td>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_markReceptionest" runat="server" Text="Mark Receptionest" 
                    onclick="btn_markReceptionest_Click" />
                <asp:Label ID="lblmg" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <%--<td colspan="1" style="width:20px"></td>--%>
            <td align="center"  colspan="2">
                <asp:GridView  ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound" Width="100%">
              <Columns>
                  <asp:TemplateField HeaderText="Sr#">
                      <ItemTemplate>
                          <%#Container.DataItemIndex+1 %>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Receptionist Id">
                      <ItemTemplate>
                          <asp:Label ID="lblid" runat="server" Text='<%#Bind("id") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Employee Name">
                      <ItemTemplate>
                          <asp:Label ID="lblName" runat="server" Text='<%#Bind("EFName") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField HeaderText="Delete">
                      <ItemTemplate>
                          <asp:LinkButton ID="LinkButton1" CommandArgument='<%#Bind("id") %>' OnClick="LinkButton1_Click" runat="server">Delete</asp:LinkButton>
                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
                      </asp:GridView>
                    
            </td>
        </tr>
       
    </table>

</asp:Content>

