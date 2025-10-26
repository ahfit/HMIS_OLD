<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="Patient_Billing__UpdateAdminServiceMerging, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="bxmain inner_content" style="width: 100%;">
         <h2><span>Update Service</span></h2>

         <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">

             <tr>
                <td width="20%" align="right">Category :  </td>
                <td>
                    <asp:DropDownList ID="ddlOldCategory" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" runat="server" >
                    </asp:DropDownList>
                </td>


                   <td width="20%" align="right">Update Category :  </td>
                <td>
                    <asp:DropDownList ID="ddlNewcategory" AutoPostBack="true"  runat="server" >
                    </asp:DropDownList>
                </td>

            </tr>

                <tr>
                <td width="20%" align="right"> Services :  </td>
                <td>
                    <asp:DropDownList ID="ddlOldServices" runat="server" >
                    </asp:DropDownList>
                </td>

                     <td width="20%" align="right">Update Services :  </td>
                <td>
                    <asp:DropDownList ID="ddlNewService" runat="server" >
                    </asp:DropDownList>
                </td>

            </tr>

              

</table>
         </div>
    <div style="text-align: center; margin-top: 1%">
        <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="Update" Style="height: 5%"   />
                  </div>

    <div style="margin-top:2%">
     <asp:GridView ID="gridview" runat="server"  AutoGenerateColumns="false"  >
                        <Columns>
                           
                             <asp:TemplateField HeaderText="Emp Name">
                                 <ItemTemplate>
                                    <asp:Label ID="groupLabel" Text='<%# Bind("Name") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>

                              <asp:TemplateField HeaderText="DATE">
                                 <ItemTemplate>
                                    <asp:Label ID="groupLabel1" Text='<%# Bind("DATE") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Deleted S_ID">
                                 <ItemTemplate>
                                    <asp:Label ID="groupLabel1" Text='<%# Bind("S_ID") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>


                            </Columns>
         </asp:GridView>
    </div>
</asp:Content>

