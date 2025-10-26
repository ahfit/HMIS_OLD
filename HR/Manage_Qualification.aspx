<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Manage_Qualification.aspx.cs" Inherits="HR_Manage_Qualification" MasterPageFile="~/hacims_masterpage_admin.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<style type="text/css">
    .style1
    {
        text-align:right;
        width:50%;
    }
    .style2
    {
        text-align:left;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
   <div class="bxmain inner_content" style="width:100%;">
   <h2><span>Manage Qualification</span></h2>
    <table  width="100%">
        <tr>
            <td class="style1">
                Qualification Name : 
            </td>
           
            <td class="style2" >
                <asp:TextBox ID="txtQualiName" runat="server" MaxLength="100"></asp:TextBox>
                 <asp:Button ID="btnSave" runat="server" Text="Save"  Width="100px" OnClick="btnSave_Click" />
                
            </td>
            
        </tr>
        <tr>
         <tr>
            <td>
                <br />
                <br />


            </td>
        </tr>
    </table>
    </div>

  <br />
  <br />
             <asp:HiddenField ID="HiddenField1" runat="server" />



    <asp:GridView ID="GridView1" Width="100%" runat="server" AutoGenerateColumns="False"  AllowPaging="True" PageSize="50" >
        <Columns>
                <asp:TemplateField HeaderText="Program Code" InsertVisible="False" 
                SortExpression="ProgramCode">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Qualification_Id") %>'></asp:Label>
                </ItemTemplate>
               
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Name" InsertVisible="False" 
                SortExpression="ProgramName">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Qualification_Name") %>'></asp:Label>
                </ItemTemplate>
                
            </asp:TemplateField>
           
            <asp:BoundField DataField="Created_On" HeaderText="Created On" InsertVisible="False"
                SortExpression="CreatedOn" />
            <asp:BoundField DataField="Created_By" HeaderText="Created By" InsertVisible="False"
                SortExpression="CreatedBy" />
                <asp:TemplateField HeaderText="Update">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" Text="Update" 
                            CommandArgument='<%# Eval("Qualification_Id") %>' onclick="btnUpdate_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                    <asp:ImageButton ID="imgDelete"  runat="server" OnClientClick="return confirm('Do you want to delete this record?');" CommandArgument='<%#Eval("Qualification_Id ")%>' ToolTip="Delete" OnClick="btnDelete_Click"
                   ImageUrl="~/Images/delete.png" Width="16" />
                    
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
    </asp:GridView>
   
    <asp:HiddenField ID="hdfProgID" runat="server" />
        
        
   
</asp:Content>