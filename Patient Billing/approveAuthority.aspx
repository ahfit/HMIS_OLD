<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Patient_Billing_approveAuthority, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style=" padding-bottom:10p;"><span><h2>Approve Authority</h2></span>
    <table width="100%">
        <tr>
            <td style="width:30% ;text-align:right;">
                <asp:Label ID="Label1" runat="server" Text="Employee Name"></asp:Label> </td>

             <td style="width:30% ;text-align:left;">
                 <asp:DropDownList ID="ddleMPLOYEE"  runat="server">
                     
                 </asp:DropDownList>
                 </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center;padding-top:10px;">
                 <asp:Button Text="Save" ID="BtnSave" runat="server" OnClick="BtnSave_Click"  />

                <asp:Label ID="Lblmsg" Font-Size="Medium" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                
            </td>
        </tr>


    </table>
    </div>
    <div style=" margin-top:10px;  padding-top:10px;"  class="bxmain inner_content"><span><h2>Employee's List</h2></span>

    <asp:GridView ID="gridviewEPLOYEE" runat="server" AutoGenerateColumns="false" >
        <Columns>
                                         
            <asp:TemplateField HeaderText="Employee Name">
            <ItemTemplate>
                 <asp:Label ID="label1" Text='<%# Bind("Name") %>' runat="server" />
                </ItemTemplate>
                  </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Emp Id">
                  <ItemTemplate>
                 <asp:Label ID="label2" Text='<%# Bind("EmpID") %>' runat="server" />
                </ItemTemplate>
                            
                 </asp:TemplateField>
                 
               <asp:TemplateField HeaderText="Delete">
             <ItemTemplate>
                    <asp:LinkButton ID="del" Text="Delete" CommandName='<%# Bind("EmpID") %>' runat="server" OnClick="deleteRecord" > </asp:LinkButton>
                </ItemTemplate>
           
                 </asp:TemplateField>
        </Columns>
       
       


        </asp:GridView>
        </div>


    </asp:Content>

