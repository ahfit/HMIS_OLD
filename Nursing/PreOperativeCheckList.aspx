<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PreOperativeCheckList.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master"
    Inherits="Patient_RegistrationPreOperativeCheckList" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
  

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain PageHeading">
    
    Pre-Operative CheckList
    
</div>
  <%-- <div class="bx_infos" style="height: 273px">

    </div>--%>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText ="SR#">
                <ItemTemplate >
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText ="Query">
                <ItemTemplate >
                    <asp:Label ID="lblqustion" runat ="server" Text='<%# Bind("QName") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField1" runat="server" Value ='<%# Bind("id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField >
                <ItemTemplate >
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection ="Horizontal">
                        <asp:ListItem Value="1">Yes</asp:ListItem>
                         <asp:ListItem Value="2">No</asp:ListItem>
                         <asp:ListItem Value="0">N/A</asp:ListItem>
                    </asp:RadioButtonList>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        
    </asp:GridView>
                
                <div>
                    <table style="width: 100%; border: #d6d6d6 solid 1px; background: #ececec url(../images_hacims/img_gridbg.png) bottom left repeat-x;" >
                    
                        <tr>
                            <td>
                    <asp:Label ID="bl" Style="margin-right:30px" runat="server" Text="Baseline Vital Sign :"></asp:Label>
                   <asp:Label ID="BLVT" Style="margin-left:30px"  runat="server" Text="BP"></asp:Label>
                             &nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtBP" runat="server" ReadOnly ="true" ></asp:TextBox>
                             &nbsp;&nbsp;&nbsp; <asp:Label ID="lblPulse" runat="server" Text="Pulse"></asp:Label>
                               <asp:TextBox ID="txtPulse" runat="server" ReadOnly ="true" ></asp:TextBox>
                                &nbsp;&nbsp;&nbsp;<asp:Label ID="lblTemp" runat="server" Text="Temp"></asp:Label>
                              <asp:TextBox ID="txtTemp" runat="server" ReadOnly ="true"></asp:TextBox>
                           
                              </td>   
                          </tr>
                        <tr><td>
                                 <asp:Button ID="Button1" runat="server" Style=" margin-top: 10px; height: 33px; padding: 4px 25px 11px 25px;border: 1.5px solid darkgrey; box-shadow: 1px 1px darkgrey;font-size: 16px;" Text="Save" OnClick="Button1_Click" />    
                            <asp:Button ID="Button2" runat="server" Style=" margin-top: 10px; height: 33px; padding: 4px 25px 11px 25px;border: 1.5px solid darkgrey; box-shadow: 1px 1px darkgrey;font-size: 16px;" Text="Report" OnClick="Button2_Click" />    
                         
                             </td></tr>
                       
                        </table>
                </div>
  </asp:Content>
