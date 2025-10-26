<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="DashBoards_BankCheckBookRecord, App_Web_ymbcbbcj" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="jquery-1.12.3.js">

   $(document).read

    </script>
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



      <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span></span></h2>
            <div class="sub-title">
        <table style="width: 80%; margin: 0 auto;">
            <tr>
               <td class="text-right">Bank :</td>
                <td class="text-right">
                    <asp:DropDownList  ID="ddlbank" AutoPostBack="true" OnSelectedIndexChanged="ddlbank_SelectedIndexChanged" runat="server"></asp:DropDownList></td>
            </tr>
             <tr>
                <td class="text-right">Branch :</td>
               <td class="text-right">
                    <asp:DropDownList OnSelectedIndexChanged="ddlbranch_SelectedIndexChanged" AutoPostBack="true" ID="ddlbranch" runat="server"></asp:DropDownList></td>
            </tr>
              <tr>
               <td class="text-right">Account :</td>
               <td class="text-right">
                    <asp:DropDownList ID="ddlAccount" runat="server"></asp:DropDownList></td>
                   <td class="text-right"> Max Serial:</td>
                <td>
                    <asp:TextBox ID="txtMax" Enabled="false"   runat="server"></asp:TextBox>
                </td>
            </tr>  
            
                <tr>
                <td class="text-right">Serial Start :</td>
                <td>
                    <asp:TextBox ID="txtserialstrt" AutoPostBack="true" OnTextChanged="txtserialstrt_TextChanged"  runat="server"></asp:TextBox>
               <asp:Label runat="server" ID="lblSerial" Visible="false" ></asp:Label>
                    
                     </td>
                <td class="text-right">Serial End :</td>
                <td>
                    <asp:TextBox ID="txtserialEnd"  runat="server"></asp:TextBox>
                </td>
            </tr>                                  
            <tr>
                <td class="text-right">Start Date :
                </td>
                <td>
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
                <td class="text-right" >End Date :
                </td>
                <td>
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>            
            </table>

              <div style="text-align: center; margin-top: 1%">
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Style="height: 5%"  />
                    <asp:Label ID="lblMsg" Text="" runat="server"></asp:Label>
                    </div>     
                 </div>
           

           </div>


        
       <div style="margin-top:2%">

     <asp:GridView ID="gridview" runat="server" Width="100%" AutoGenerateColumns="false"  >
         <Columns>

             <asp:TemplateField HeaderText="Bank Name">
                 <ItemTemplate>
                     <asp:Label ID="lblitemcode" Text='<%# Bind("Bank_Name") %>' runat="server" />
                 </ItemTemplate>
                 </asp:TemplateField>

               <asp:TemplateField HeaderText="Branch Name">
                 <ItemTemplate>
                     <asp:Label ID="lblitemcode" Text='<%# Bind("Branch_Name") %>' runat="server" />
                 </ItemTemplate>
                 </asp:TemplateField>

         
               <asp:TemplateField HeaderText="Account#">
                 <ItemTemplate>
                     <asp:Label ID="lblitemcode3" Text='<%# Bind("Account_No") %>' runat="server" />
                 </ItemTemplate>
                 </asp:TemplateField>
               <asp:TemplateField HeaderText="Serial Start">
                 <ItemTemplate>
                     <asp:Label ID="lblitemcode4" Text='<%# Bind("SerialStart") %>' runat="server" />
                 </ItemTemplate>
                 </asp:TemplateField>
               <asp:TemplateField HeaderText="Serial End">
                 <ItemTemplate>
                     <asp:Label ID="lblitemcode5" Text='<%# Bind("SerialEnd") %>' runat="server" />
                 </ItemTemplate>
                 </asp:TemplateField>
         

             </Columns>
         </asp:GridView>
       
    </div> 
        
  










</asp:Content>

