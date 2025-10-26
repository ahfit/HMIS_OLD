<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Pathology_AdminServices_Vs_TestBooking, App_Web_dwve4450" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


        
    <div class="bxmain inner_content" style="text-align:left; width:100%; background-color:transparent; border:none; font-weight:bold;">

          <h2><span>Admin Services Vs TestBooking</span></h2>
        </div>

       <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" style="padding-top:5px">

       <tr style ="display:none">
           <td  align="right" width="40%">  Main Category   </td>
           
           <td width="60%">
               <asp:DropDownList ID="ddlmainCat" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlmainCat_SelectedIndexChanged" ></asp:DropDownList>
           </td>
       </tr>


           <tr>
           <td  align="right" width="40%">  Category  </td>
           
           <td width="60%">
               <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" 
                   onselectedindexchanged="ddlCategory_SelectedIndexChanged"></asp:DropDownList>
           </td>
       </tr>


           <tr>
    <td align="right" width="40%">Servic Name</td>
    <td>
          <asp:TextBox  ID="serviceText"   runat="server" Width="50%" OnTextChanged="serviceText_TextChanged" AutoPostBack="true"> </asp:TextBox>
                                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="ServiceName"
                                        MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="serviceText" FirstRowSelected="true" >
                                    </asp:AutoCompleteExtender>
    </td>
</tr>



         </table> 


    <div style="margin-top:10px">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" style="padding-top:5px">
             <tr>
                <td>

<asp:GridView ID="GridAdminService" runat="server" AutoGenerateColumns="False" BackColor="White" 
                        BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" 
                        CssClass="Grid_dynamic" ForeColor="Black" GridLines="Vertical" Width="100%" >
    <AlternatingRowStyle BackColor="#CCCCCC" />
<Columns>
    <asp:TemplateField HeaderText="Main Category">
            <ItemTemplate>
            <asp:Label ID="lblmainCategory" Text='<%# Bind("Main_Category") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Category">
            <ItemTemplate>
            <asp:Label ID="lblCategory" Text='<%# Bind("Category") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>


        <asp:TemplateField HeaderText="Service Name">
            <ItemTemplate>
            <asp:Label ID="lblservicename" Text='<%# Bind("ServiceName") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

        <asp:TemplateField HeaderText="Code">
            <ItemTemplate>
            <asp:Label ID="lblcode" Text='<%# Bind("Code") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

        <asp:TemplateField HeaderText="Test Code">
            <ItemTemplate>
            <asp:Label ID="lbltestcode" Text='<%# Bind("TestCode") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>


    <asp:TemplateField HeaderText="Test Name">
            <ItemTemplate>
            <asp:Label ID="lbltestcode" Text='<%# Bind("TestName") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

</Columns>
    <FooterStyle BackColor="#CCCCCC" />
    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
    <SortedAscendingCellStyle BackColor="#F1F1F1" />
    <SortedAscendingHeaderStyle BackColor="#808080" />
    <SortedDescendingCellStyle BackColor="#CAC9C9" />
    <SortedDescendingHeaderStyle BackColor="#383838" />
</asp:GridView>
 </td>
            </tr>

    

        </table>


    </div>


</asp:Content>

