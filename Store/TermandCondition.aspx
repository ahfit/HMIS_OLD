<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="TermandCondition.aspx.cs" Inherits="Store_TermandCondition" %>

<script runat="server">

    protected void btn_markReceptionest_Click(object sender, EventArgs e)
    {

    }
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 50%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="bxmain inner_content" style="width:100%;"">
        <h2>
            <span>Add Terms & Conditions</span>
        </h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
        
       
        <tr>
            <td align="right" class="style2">
                <b>Terms & Conditions :</b></td>
            <td>
                <asp:TextBox ID="TextBox_Terms_Conditions" runat="server" TextMode="MultiLine" Width="350px" Height="100px" ></asp:TextBox>
            </td>
        </tr>
        
        <tr>
            <td align="center" colspan="2">
                <asp:Button ID="btn_Save" runat="server" Text="Save" OnClick="btn_Save_Click" />
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
              <asp:Label ID="lblmg" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <%--<td colspan="1" style="width:20px"></td>--%>
            <td align="center"  colspan="2">
                <asp:GridView  ID="GridView1" AutoGenerateColumns="false" runat="server"  Width="100%">
              <Columns>
                   <asp:TemplateField HeaderText="Delete">
                      <ItemTemplate>
                          <asp:ImageButton ID="ibDelete" runat="server" AlternateText="Delete" ImageUrl="~/images/delete.png" 
                              CommandArgument='<%# Eval("ID") %>' OnClick="ibDelete_Click" />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Sr. #">
                      <ItemTemplate>
                          <%#Container.DataItemIndex+1 %>
                      </ItemTemplate>
                  </asp:TemplateField>
                  
                  <asp:TemplateField HeaderText="Terms & Conditions">
                      <ItemTemplate>
                          <asp:Label ID="lblName" runat="server" Text='<%#Bind("Terms_Conditions") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  
              </Columns>
                      </asp:GridView>
                    
            </td>
        </tr>
       
    </table>
    </div>
    

</asp:Content>

