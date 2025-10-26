<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="SubDept, App_Web_pvcsvhw1" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script type="text/javascript">
     function ClientItemSelected(sender, e) {
         alert(e.get_value());
         $get("<%=HFD_F_Head.ClientID %>").value = e.get_value();
   }

    </script>
<script language="javascript" type="text/javascript">
 $(document).ready(function(e) {
     
	
	$("#ctl00_ContentPlaceHolder1_btnSave").click(function(){
		
		if($("#ctl00_ContentPlaceHolder1_TextBox_SubDept_Name").val()==""){alert("Please Enter Sub Department Name");
			$("#ctl00_ContentPlaceHolder1_TextBox_SubDept_Name").focus();
			return false;
			}
		if($("#ctl00_ContentPlaceHolder1_TextBox_PhoneNo").val()==""){alert("Please Enter Phone Number");
			$("#ctl00_ContentPlaceHolder1_TextBox_PhoneNo").focus();
			return false;
			}
		
	 	 
		})
	 
})	
  
</script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="bxmain inner_content" style="width:100%;">

      <div class="bxmain inner_content" style="text-align:left; width:100%;background-color:transparent; border:none; font-weight:bold;">
<h2><span>Add Subdepartment </span> </h2>


     
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
    <tr>
        <td align="right" width="40%"  >
            Hospital Name :</td>
        <td   >
            
            <asp:DropDownList ID="DropDownList_Hospital" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Hospital"
                DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="400px" style="text-transform:uppercase;">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
        </td>
    </tr>

                  <tr>
                    <td  align="right"  >Department : </td>
                    <td  >
                                <asp:DropDownList CssClass="text_dropdown" Width="400px" DataTextField="Dept_Name" DataValueField="Dept_ID" ID="ddlDepartment" runat="server"
                         DataSourceID="SqlDataSourceDepartment"  AutoPostBack="True" style="text-transform:uppercase;"> </asp:DropDownList>
                    </td>
      </tr>
                  <tr>
                    <td  align="right"  >Sub Department Name :</td>
                      <td >
                        <asp:TextBox ID="TextBox_SubDept_Name" runat="server"  SkinId="captxt" Style="background-color: #f9dde2;"></asp:TextBox><span class="marks">*</span>
</td>
                    </tr>
                  <tr>
                    <td  align="right"  >Cost Centre :</td>
                      <td >
                <asp:TextBox ID="TXT_Financial_Head" runat="server" MaxLength="10"  BackColor="LightPink" Height="21px" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RFV_F_Head" runat="server" ControlToValidate ="TXT_Financial_Head" ErrorMessage="Cost Centre is Compulsory..." ValidationGroup ="A"></asp:RequiredFieldValidator>
                
                          <asp:AutoCompleteExtender ID="Auto_Head_Find" runat="server" ServiceMethod="SearchFinacial_Head"
                                        MinimumPrefixLength="1" CompletionInterval="100" CompletionSetCount="10"
                                        TargetControlID="TXT_Financial_Head" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected">
                </asp:AutoCompleteExtender>
                           <asp:HiddenField ID ="HFD_F_Head" runat ="server" Value ="0" />
</td>
                    </tr>
      <tr>
          <td align="right">
              Sub Department Type</td>
          <td>
              <asp:DropDownList ID="ddlSubDept_Type" dataTextField="Subdept_Type_Name" DataValueField="SubDept_Type_Id" DataSourceID="SqlDataSource_SubDeptType" runat="server">
                  
              </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_SubDeptType" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="select SubDept_Type_Id,Subdept_Type_Name from SubDepartment_Types where is_Active=1"></asp:SqlDataSource>
                     
          </td>
      </tr>
                  <tr>
                    <td align="right"  >Location :</td>
                      <td >
                        <asp:TextBox ID="txtLocation" runat="server" SkinId="captxt"  ></asp:TextBox>
</td>
                    </tr>
                  <tr>
                    <td align="right"  >Phone # :</td>
                      <td >
                         
                        <asp:TextBox
                                  ID="TextBox_PhoneNo" runat="server" Style="background-color: #f9dde2;" SkinId="intdata"  ></asp:TextBox><span class="marks">*</span>
</td>
                    </tr>
                  <tr>
                    <td align="right"  >Fax # :</td>
                      <td >
                       
                        <asp:TextBox
                                ID="TextBox_FaxNo" runat="server"  ></asp:TextBox>
                      </td>
                    </tr>
                  <tr>
                    <td align="right"  ></td>
                    <td ><asp:Button ID="btnSave" runat="server" Text="Save" />
                        <asp:Button ID="Button_export" runat="server" Text="Export" Visible="false" />
                    <asp:Label ID="LabelSave" runat="server"   ></asp:Label></td>
                  </tr>
                
                                    
                </table></div><br />
 <div style="width:70%;margin:auto"><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceSubDeptSave" Width="100%" CssClass="Grid_1" DataKeyNames="SubDept_Id">
                <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />              
                <Columns>
                    <asp:TemplateField>
                    <ItemStyle Width="60px" />
                        <EditItemTemplate>
                            <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif"  ToolTip="Update" /><asp:ImageButton
                                ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images_hacims/icon_err.gif"  ToolTip="Cancel" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Select" ImageUrl="~/images_hacims/icon_edit.gif"   ToolTip="Edit"
                                OnClientClick="return confirmation_edit(this)" /><asp:ImageButton ID="ImageButton2"
                                    runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"   ToolTip="Delete" OnClientClick="return confirmation(this)" />
                        </ItemTemplate>
                    </asp:TemplateField>
                <asp:BoundField DataField="SubDept_Id" HeaderText="SubDept_Id" InsertVisible="False"
                    ReadOnly="True" SortExpression="SubDept_Id" Visible="False" />
                    <asp:TemplateField HeaderText="Department" SortExpression="Dept_ Name">
                    <ItemStyle Width="100px" />
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Dept_Name") %>' Visible="False"></asp:TextBox>
                            <asp:DropDownList ID="DropDownListDepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                                DataTextField="Dept_Name" DataValueField="Dept_ID" SelectedValue='<%# Bind("Dept_Id", "{0}") %>'
                                Width="148px">
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Dept_Name") %>'></asp:Label>
                            <asp:Label ID="lblDeptId" Visible="false" runat="server" Text='<%# Bind("Dept_Id") %>'></asp:Label>
                            <asp:Label ID="lblSubDeptType" Visible="false" runat="server" Text='<%# Bind("SubDept_Type") %>'></asp:Label>
                            
                            
                            
                        </ItemTemplate>
                    </asp:TemplateField>
                <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Department" SortExpression="SubDept_Name" >
                    <ItemStyle Width="100px" />
                </asp:BoundField>
                     <asp:BoundField DataField="CostCenterName" HeaderText="Cost Centre" ItemStyle-Width="150px"
                    SortExpression="CostCenterName" />
                <asp:BoundField DataField="SubDept_Location" HeaderText="Location" ItemStyle-Width="150px"
                    SortExpression="SubDept_Location" />
                    <asp:BoundField DataField="SubDept_PhoneNo" HeaderText="Phone No." ItemStyle-Width="150px" SortExpression="SubDept_PhoneNo">
                        <ItemStyle Width="12px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="SubDept_FaxNo" HeaderText="Fax No." SortExpression="SubDept_FaxNo" ItemStyle-Width="100px" />
                   
                <asp:BoundField DataField="Dept_Id" HeaderText="Dept_Id" SortExpression="Dept_Id"
                    Visible="False" />
                </Columns>
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />              
                <AlternatingRowStyle CssClass="GridAltItem" />
              </asp:GridView>
              </div>

              <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="Select_Hospital_Dept" SelectCommandType="StoredProcedure"> 
                  <SelectParameters>
                      <asp:ControlParameter ControlID="DropDownList_Hospital" Name="Hospital_Id" PropertyName="SelectedValue"
                          Type="Int32" />
                  </SelectParameters>
              </asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSourceSubDeptSave" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" InsertCommand="Insert_SubDept" InsertCommandType="StoredProcedure" SelectCommand="Select_SubDept" SelectCommandType="StoredProcedure" DeleteCommand="Delete_SubDept" ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" UpdateCommand="UPDATE SubDepartment SET SubDept_Name = @SubDept_Name, Dept_Id = @Dept_Id,SubDept_Location=@location, SubDept_PhoneNo = @SubDept_PhoneNo, Priority = @Priority, SubDept_FaxNo = @SubDept_FaxNo,SubDept_Type=@SubDept_Type,CostCentre_Id=@CostCentre_Id WHERE (SubDept_Id = @SubDept_Id);" DeleteCommandType="StoredProcedure">
                <InsertParameters>
                  <asp:ControlParameter ControlID="ddlDepartment" Name="Dept_Id" PropertyName="SelectedValue"
                    Type="Int32" />
                  <asp:ControlParameter ControlID="TextBox_SubDept_Name" Name="SubDept_Name" PropertyName="Text"
                    Type="String" />
                  <asp:ControlParameter ControlID="txtLocation" Name="SubDept_Location" PropertyName="Text"
                    Type="String" />
                  <asp:ControlParameter ControlID="HiddenFieldPhoneNo" Name="SubDept_PhoneNo" PropertyName="Value"
                    Type="String" />
                  <asp:ControlParameter ControlID="HiddenFieldFaxNo" Name="SubDept_FaxNo" PropertyName="Value"
                    Type="String" />
                    <asp:ControlParameter ControlID="ddlSubDept_Type" Name="SubDept_Type" PropertyName="SelectedValue"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="HFD_F_Head" Name="CostCentre" PropertyName="Value" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                  <asp:ControlParameter ControlID="ddlDepartment" Name="Dept_Id" PropertyName="SelectedValue"
                    Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="SubDept_Id" PropertyName="SelectedValue" />
                </DeleteParameters>
                  <UpdateParameters>
                      <asp:ControlParameter ControlID="TextBox_SubDept_Name" Name="SubDept_Name" PropertyName="Text" />
                      <asp:Parameter Name="Dept_Id" Type="String" />
                      <asp:ControlParameter ControlID="TextBox_PhoneNo" Name="SubDept_PhoneNo" PropertyName="Text" />
                      <asp:ControlParameter ControlID="HiddenFieldPriority" Name="Priority" PropertyName="Value" />
                      <asp:ControlParameter ControlID="HFD_F_Head" Name="Cost Centre" PropertyName="Value" />
                      <asp:ControlParameter ControlID="GridView1" Name="SubDept_Id" PropertyName="SelectedValue" />
                      <asp:ControlParameter ControlID="TextBox_FaxNo" Name="SubDept_FaxNo" PropertyName="Text" />
                      <asp:Parameter  Name="location" Type="String" />                      
                      <asp:ControlParameter ControlID="ddlSubDept_Type" Name="SubDept_Type" PropertyName="SelectedValue"   Type="Int32" />
                  </UpdateParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldPhoneNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldFaxNo" runat="server" />
                <asp:HiddenField ID="HiddenFieldSubDeptName" runat="server" />
                <asp:HiddenField ID="HiddenField_PhoneNo" runat="server" />
                <asp:HiddenField ID="HiddenFieldDept_Id" runat="server" />
                <asp:HiddenField ID="HiddenFieldPriority" runat="server" />
                <asp:HiddenField ID="HiddenField_FaxNo" runat="server" /> <br />

<br />
  </asp:Content>