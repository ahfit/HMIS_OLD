<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="MeritCriteria.aspx.cs" Inherits="HR_MeritCriteria" %>

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
<script type="text/javascript">
    function minmax(min, max) {

        var percentage = $("[id$='txtboxPercentage']").val();
        if (isNaN(parseFloat(percentage))) {
            alert("Please enter numeric values");
            $("[id$='txtboxPercentage']").val("");
            return false;
        }
        if (parseFloat(percentage) < min) {
            alert("Please enter correct digit between (1-100)");
            return false;
        }
        else if (parseFloat(percentage) > max) {
            alert("Please enter correct digit between (1-100)");
            return false;
        }

    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
   <div class="bxmain inner_content" style="width:100%;">
   <h2><span>Manage Qualification</span></h2>
    <table  width="100%">
         <tr>
            <td class="style1">
                Advertisment : 
            </td>
           
            <td class="style2" >
                 <asp:DropDownList ID="DDL_Advertisement" runat="server" autopostback="true" OnSelectedIndexChanged="DDL_Advertisement_SelectedIndexChanged">
                        </asp:DropDownList>
                
            </td>
            
        </tr>

         <tr>
            <td class="style1">
                Post : 
            </td>
           
            <td class="style2" >
                <asp:DropDownList ID="ddlPosts" runat="server">
                        </asp:DropDownList>
                
            </td>
            
        </tr>
        
        <tr>
            <td class="style1">
                Qualification Name : 
            </td>
           
            <td class="style2" >
                <asp:DropDownList runat="server" ID="ddlQualification"></asp:DropDownList>
                
            </td>
            
        </tr>
         <tr>
            <td class="style1">
                 Percentage
            </td>
           
            <td class="style2" >
                <asp:TextBox ID="txtboxPercentage"  runat="server" onblur="return minmax('0','100')" MaxLength="3" ></asp:TextBox><asp:CheckBox ID="chkboxSelect" runat="server" Text="IS Fixed" />
                   <asp:CheckBox ID="CHKAd" runat="server" Text="IS  Additional" />
                <asp:RequiredFieldValidator ID="validator" runat="server" ErrorMessage="*" ValidationGroup="mainApp"  ControlToValidate="txtboxPercentage"></asp:RequiredFieldValidator>
            </td>            
        </tr>

         <tr>
            <td colspan="2" align="center" style="line-height:3">
                 <asp:Button ID="btnSave" runat="server" ValidationGroup="mainApp" Text="Save" onclick="btnSave_Click" />
                <asp:Button ID="btnCancel" runat="server" Visible="false" CausesValidation="false"  Text="Cancel" onclick="btnCancel_Click" />
                 <asp:Label ID="lblmsg" runat="server" Font-Bold="true" Visible="true" ></asp:Label>
                 <asp:HiddenField ID="hfMeritID" runat="server" />
            </td>            
        </tr>



    </table>
    </div>

  <br />
  <br />
             <asp:HiddenField ID="HiddenField1" runat="server" />



    <asp:GridView ID="GridView1" Width="100%" runat="server" AutoGenerateColumns="False"  AllowPaging="True" PageSize="50" >
        <Columns>
                <asp:TemplateField HeaderText="Advertisment Title" InsertVisible="False" 
                SortExpression="ProgramCode">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Ad_Title") %>'></asp:Label>
                </ItemTemplate>
               
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Post" InsertVisible="False" 
                SortExpression="ProgramName">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                </ItemTemplate>
                
            </asp:TemplateField>
           
            <asp:BoundField DataField="Qualification_Name" HeaderText="Qualification"   />
            <asp:BoundField DataField="Percentage" HeaderText="Percentage" InsertVisible="False"
                SortExpression="CreatedBy" />
                <asp:CheckBoxField DataField="IsFixed" HeaderText="Is Fixed" />
                <asp:CheckBoxField DataField="IsAdditional" HeaderText="Is Additional" />
                <asp:TemplateField HeaderText="Detail">
                    <ItemTemplate>
                     <asp:ImageButton ID="btnAdd" runat="server" Text="Add" OnClientClick="return confirm('Do you want to Add in this record?');"
                         ToolTip="Add Detail" Visible= '<%# Eval("vis") %>' CommandArgument='<%# Eval("MeritCriteriaID") %>' onclick="btnAdd_Click"  ImageUrl="~/Images/add.png" Width="16"/>
                    </ItemTemplate>
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Update">
                    <ItemTemplate>
                      <asp:ImageButton ID="btnUpdate" runat="server" Text="Update" OnClientClick="return confirm('Do you want to UPDATE this record?');"
                         ToolTip="Update"   CommandArgument='<%# Eval("MeritCriteriaID") %>' onclick="btnUpdate_Click"  ImageUrl="~/Images/updatebtn.png" Width="16"/>
                            <asp:HiddenField ID="hfqualificationID" runat="server" Value='<%# Eval("Qualification_Id") %>' />
                            <asp:HiddenField ID="hfPercentage" runat="server" Value='<%# Eval("Percentage") %>' />
                           <asp:HiddenField ID="HfIsFixed" runat="server" Value='<%# Eval("IsFixed") %>' />
                            <asp:HiddenField ID="HfIsAdditional" runat="server" Value='<%# Eval("IsAdditional") %>' />
                             
                    </ItemTemplate>
                </asp:TemplateField>
            <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                    <asp:ImageButton ID="imgDelete"  runat="server" OnClientClick="return confirm('Do you want to delete this record?');" CommandArgument='<%#Eval("MeritCriteriaID ")%>' ToolTip="Delete" OnClick="btnDelete_Click"
                   ImageUrl="~/Images/delete.png" Width="16" />
                    
             </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
    </asp:GridView>
   
    <asp:HiddenField ID="hdfProgID" runat="server"  />
        <asp:Panel ID = "Pnl_detail" runat = "server" Visible="false" CssClass ="lightbox_bg">  <%----%>
        <div class ="lightbox"><%----%>
                <asp:GridView ID="Gv_Detail" Width="100%" runat="server" AutoGenerateColumns="False"  
                AllowPaging="True" DataSourceID="Sds_Detail" 
                onprerender="Gv_Detail_PreRender" >
                <Columns>
            <asp:BoundField DataField="ID" HeaderText="Experience Year" />
            <asp:TemplateField>
                <HeaderTemplate>
                   <strong>Enter Marks</strong> 
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="txt_qty" Text = "0" runat="server" min= "0"></asp:TextBox>
                            <asp:HiddenField ID="hfID" runat="server" Value='<%# Eval("ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    
    </asp:GridView> 
           
            <div style = "width :100% ; " align ="center">
                <asp:Button ID="Btn_pnl_Save" runat="server" Text="Save" 
                    onclick="Btn_pnl_Save_Click" />
                <asp:Button ID="Btn_pnl_close" runat="server" Text="cancel" 
                    onclick="Btn_pnl_close_Click" />
            </div>
            <asp:SqlDataSource ID="Sds_Detail" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                SelectCommand="SELECT Day AS ID FROM Day"></asp:SqlDataSource>
            <asp:HiddenField ID="hf_Ad_sub_id" runat="server" />
            <asp:HiddenField ID="hf_experince_year" runat="server" />
            </div>
           
   </asp:Panel>
</asp:Content>

