<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Pathology_AdminServicesVsAccountHeader, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        tr {
            line-height:2;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style="width:100%;"><span><h2>Map Admin Services</h2></span>

<table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
      
        <tr>
            <td align="right" style="width:40%;" >
                                       Category :</td>
            <td >
                <asp:DropDownList ID="ddlCatageory" runat="server"   AutoPostBack="true"
                     OnSelectedIndexChanged="ddlCatageory_SelectedIndexChanged" >
                </asp:DropDownList></td>
        </tr>     
      <tr>
            <td align="right" style="width:40%;" >
                Service Name :</td>
            <td >
                <asp:TextBox ID="txtboxTBName" runat="server"></asp:TextBox>
        </tr>            
        <tr>
            <td >
            </td>
            <td >
                <asp:Button ID="Button_Search" OnClick="Button_Search_Click"   runat="server" Text="Search" /> 

               <asp:Label ID="Lblmsg" Font-Size="Medium" runat="server" Visible="false" ForeColor="Green"></asp:Label>
                </td>        
        </tr>
    </table> 

        <div>
            <asp:GridView ID="gvdServices" CssClass="Grid_1" AutoGenerateColumns="false" runat="server" OnRowDataBound="gvdServices_RowDataBound">
               <Columns>
                   <asp:TemplateField HeaderText="Admin Service">
                       <ItemTemplate>
                           <asp:Label ID="lblServceCatageory" Text='<%# Eval("S_Name") %>' runat="server"></asp:Label>

                       </ItemTemplate>
                   </asp:TemplateField>
                   <asp:TemplateField HeaderText="Amount">
                       <ItemTemplate>
                           
                           <asp:TextBox ID="txtboxTBName" runat="server" Text='<%# Bind("S_Amount") %>'></asp:TextBox>
                       </ItemTemplate>
                   </asp:TemplateField>



                      <asp:TemplateField HeaderText="Category">
                       <ItemTemplate>
                           
                           <asp:TextBox ID="txtboxCat" runat="server" Text='<%# Bind("Asc_Name") %>'></asp:TextBox>
                       </ItemTemplate>
                   </asp:TemplateField>

                   <asp:TemplateField HeaderText="Expenditure">
                       <ItemTemplate>
                            <asp:DropDownList ID="ddl" runat="server" ></asp:DropDownList>          
           <%--               <%-- <asp:HiddenField ID="hfTB_ID" Value='<%# Eval("TB_ID ") %>' runat="server" />--%>
                           <asp:HiddenField ID="hdSid" Value='<%# Eval("S_ID ") %>' runat="server" />

                            <asp:HiddenField ID="hfEcode" Value='<%# Eval("E_Code ") %>' runat="server" />

                           

                       </ItemTemplate>
                   </asp:TemplateField>     
                   <asp:TemplateField HeaderText="Update Service">
                       <ItemTemplate>
                           <asp:Button ID="btnUpdate" OnClick="btnUpdate_Click" runat="server" Text="Update" />
                       </ItemTemplate>
                   </asp:TemplateField>                   


               </Columns>
            </asp:GridView>
        </div>



    </div>

</asp:Content>

