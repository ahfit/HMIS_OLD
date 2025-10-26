<%@ page title="" language="C#" masterpagefile="~/hacims_demo.master" autoeventwireup="true" inherits="Finance_Head_Master, App_Web_ymbcbbcj" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="bxmain inner_content" style="width: 100%;">

        
         <h2><span>Head Master Detail</span></h2>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">

                  <tr>
                <td width="25%" align="right"><b>Expense</b> </td>
                <td>
                    <asp:DropDownList ID="ddlExpense" runat="server" DataTextField="E_Name" DataValueField="E_Code" ></asp:DropDownList>
                </td>
            </tr>



                 <tr>
                   
                          <td align="right" width="15%">
                             <b>Type</b>
                     </td>
          
                          <td>
                             
                             <asp:TextBox ID="txttype" runat="server" ></asp:TextBox>
                     </td>
                   
                 </tr>
                 <tr>
                         <td width="20%" colspan="4" align="center">
                         
                         <asp:Button ID="btnsave" Text="Save" OnClick="btnsave_Click" runat="server" />
                     </td>
                   
                 </tr>

             </table>

          </div>

    <div>

         <asp:GridView ID="gridView1" AutoGenerateColumns="false" runat="server">

                    <Columns>
                        <asp:TemplateField HeaderText="Code">
                            <ItemTemplate>
                                <asp:Label ID="Code" runat="server" Text='<%# Eval("E_Code") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                         <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label ID="dlExpense" runat="server" Text='<%# Eval("E_Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                         <asp:TemplateField HeaderText="Type">
                            <ItemTemplate>
                                <asp:Label ID="txttype" runat="server" Text='<%# Eval("Head_Type") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                         <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate> 
                           <asp:LinkButton ID="btn_delete" Text="Delete" CommandName='<%#Eval("E_Code")%>' runat="server" OnClick="btn_delete_Click"></asp:LinkButton>
                            <%--<asp:HiddenField ID="HiddenField1"  runat="server" />--%>
                      </ItemTemplate>
                    </asp:TemplateField>
                      
                    <asp:TemplateField HeaderText="Edit">
                        <ItemTemplate> 
                           <asp:LinkButton ID="btn_edit" Text="Edit" runat="server" CommandName='<%#Eval("E_Code")%>'  OnClick="btn_edit_Click"></asp:LinkButton>
                           
                      </ItemTemplate>
                    </asp:TemplateField>


                          
                 




                    </Columns>




                </asp:GridView>






    </div>


</asp:Content>

