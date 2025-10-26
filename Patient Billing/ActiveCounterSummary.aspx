<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="Finance_ActiveCounterSummary, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


     <div class="bxmain inner_content" style="width: 100%;">
         <h2><span>Active Counter Summary</span></h2> 
     
           <div class="bxmain inner_content" style="width: 100%; padding:6px">
        
     <asp:GridView ID="GridView1" runat="server"  AutoGenerateColumns="False"  Width="100%">

                   <Columns>
                         <asp:TemplateField HeaderText="Emp ID">
                               
                                 <ItemTemplate>
                                 
                                    <asp:Label ID="EMPid" Text='<%# Bind("emp_id") %>' runat="server" />
                                
                                </ItemTemplate>
                            </asp:TemplateField>

                          
                        <asp:TemplateField HeaderText="Name">

                                 <ItemTemplate>
                                 
                                    <asp:Label ID="lbname" Text='<%# Bind("Name") %>' runat="server" />
                                
                                </ItemTemplate>
                            </asp:TemplateField>


                        <asp:TemplateField HeaderText="amount">
                               
                                 <ItemTemplate>
                                 
                                    <asp:Label ID="amount" Text='<%# Bind("Amount") %>' runat="server" />
                                
                                </ItemTemplate>
                            </asp:TemplateField>


             <%--         <asp:TemplateField HeaderText="View Detail">
                               
                        <%--         <ItemTemplate>

                                     <asp:HyperLink ID="link" runat="server" ></asp:HyperLink>
                                 
                                 <%--  <asp:LinkButton ID="lnkbtn" Text="View" runat="server" CommandName='<%# Bind("emp_id") %>'  OnClick="lnkbtn_Click"></asp:LinkButton>--%>
                                
                               

                            <asp:HyperLinkField DataNavigateUrlFormatString="~/Patient%20Billing/Cash_Book_report.aspx?emp_id={0}" 
                HeaderText="ViewDetail " Target="_blank" Text="View" 
                DataNavigateUrlFields="emp_id" />

                          

                       </Columns>
         </asp:GridView>
                   
           </div>

         </div>


</asp:Content>

