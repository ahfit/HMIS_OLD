<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Template, App_Web_lwhdjlgh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">




<script language ="javascript" type="text/javascript" >

 $(document).ready(function(e) {
     
	
	$("#ctl00_ContentPlaceHolder1_ButtonSave").click(function(){
		
		if($("#ctl00_ContentPlaceHolder1_TextBoxname").val()==""){
			
			
			alert("Please Enter Template Name");
			$("#ctl00_ContentPlaceHolder1_TextBoxname").focus();
			return false;
			}
		
	 	 
		})
	 
})	
 

</script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                           
                          <tr>
                            <td align="right" width="40%"  > Template Name  : </td>
                              <td  align="left">
                                <asp:TextBox ID="TextBoxname" runat="server" Style="background-color: #f9dde2;"    >
                              </asp:TextBox>
&nbsp;
                                <asp:Button ID="ButtonSave" runat="server"  Text="Save"  />                                
</td>
                            </tr>
                            
                        </table></div><br />
 <asp:Label CssClass="err" ID="Label_message" runat="server" >
                        </asp:Label> 

                          <asp:Label CssClass="err" Font-Bold="True" ID="LabelEmpName" runat="server" >
                        </asp:Label>
                                <asp:Label CssClass="err"  ID="Label1" runat="server" >
                        </asp:Label><br />

                          <asp:GridView ID="GridViewMGName" runat="server" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSource_Template" Width="100%" CssClass="Grid_1" AllowPaging="True" DataKeyNames="Template_Id" PageSize="25">
                            <FooterStyle CssClass="GridPager" />                          
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif"  ToolTip="Update" />&nbsp;<asp:ImageButton
                                            ID="ImageButton4" runat="server" CommandName="Cancel"  ImageUrl="~/images_hacims/icon_err.gif"  ToolTip="Cancel"  />
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif"   ToolTip="Edit"
                                            OnClientClick="return confirmation_edit(this)" />&nbsp;<asp:ImageButton ID="ImageButton2"
                                                runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"   ToolTip="Delete" OnClientClick="return confirmation(this)" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Template_Id" HeaderText="Template_Id" InsertVisible="False"
                                    ReadOnly="True" SortExpression="Template_Id" Visible="False" />
                                <asp:BoundField DataField="Template_Name" HeaderText="Template Name" SortExpression="Template_Name" />
                            </Columns>
                            <RowStyle CssClass="GridItem"/>
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" /><PagerStyle CssClass="GridPager"   />
                          </asp:GridView>
                            
                            <asp:SqlDataSource ID="SqlDataSource_Template" runat="server" ConflictDetection="CompareAllValues"
                                ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" DeleteCommand="DELETE FROM [Admin_Template] WHERE [Template_Id] = @original_Template_Id AND [Template_Name] = @original_Template_Name"
                                InsertCommand="INSERT INTO [Admin_Template] ([Template_Name]) VALUES (@Template_Name)"
                                OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Admin_Template]  where active=1"
                                UpdateCommand="UPDATE [Admin_Template] SET [Template_Name] = @Template_Name WHERE [Template_Id] = @original_Template_Id AND [Template_Name] = @original_Template_Name" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                                <DeleteParameters>
                                    <asp:Parameter Name="original_Template_Id" Type="Int32" />
                                    <asp:Parameter Name="original_Template_Name" Type="String" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Template_Name" Type="String" />
                                    <asp:Parameter Name="original_Template_Id" Type="Int32" />
                                    <asp:Parameter Name="original_Template_Name" Type="String" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBoxname" Name="Template_Name" PropertyName="Text"
                                        Type="String" />
                                </InsertParameters>
                            </asp:SqlDataSource><br />
<br />



  </asp:Content>