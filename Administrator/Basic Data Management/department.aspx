<%@ Page Language="VB" AutoEventWireup="false"   MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Department.aspx.vb" Inherits="Department" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
 
 

<script language="javascript" type="text/javascript">

$(document).ready(function(e) {
     
	
	$("#ctl00_ContentPlaceHolder1_save").click(function(){
		
		if($("#ctl00_ContentPlaceHolder1_TextBoxDepartmentName").val()==""){alert("Please Enter Department Name");
			$("#ctl00_ContentPlaceHolder1_TextBoxDepartmentName").focus();
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
    <div class="bxmain inner_content"><span><h2>Add Department</h2></span>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
    <tr>
        <td align="right">
            Hospital :
        </td>
        <td width="60%">
            <asp:DropDownList ID="DropDownList_Hospital" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Hospital"
                DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="285px">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
        </td>
    </tr>


                  <tr>
                    <td align="right"> <asp:Label ID="Label2" runat="server" ForeColor="Red" Text="*"></asp:Label>Department Name  :</td>
                              <td   ><asp:TextBox ID="TextBoxDepartmentName" runat="server" SkinId="captxt" Style="background-color: #f9dde2;"  ></asp:TextBox>
                    
                                  <asp:Button ID="ButtonSearch" runat="server"  Text="Search" /></td>
      </tr>
                  <tr>
                    <td align="right"   >Dept Type : </td>
                    <td ><asp:DropDownList ID="DropDownList_Type" DataTextField="Dept_Type_Name" DataValueField="Dept_Type_Name" runat="server" DataSourceID="SqlDataSource_DeptType" > </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_DeptType" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="select Dept_Type_Id,Dept_Type_Name from Department_Types where is_Active=1"></asp:SqlDataSource>
                     
                    <asp:DropDownList CssClass="text_dropdown" DataTextField="EmployeeName"
                              DataValueField="EmpID" ID="HODept" runat="server"  datasourceid="SqlDataSourceEmployee" Visible="False"> </asp:DropDownList></td>
                  </tr>
                  <tr>
                    <td align="right"   >Location  :</td>
                      <td ><asp:TextBox ID="TextBoxLocation" runat="server"  SkinId="captxt" ></asp:TextBox></td>
                    </tr>
                  <tr>
                    <td align="right"    >Phone #   :</td>
                      <td  >
                       
  <asp:TextBox ID="TextBox_PhoneNo" runat="server"   MaxLength="7" SkinId="intdata" Style="background-color: #f9dde2;" ></asp:TextBox><span class="marks">*</span>
                           </td>
                    </tr>
                  <tr>
                    <td   align="right"   >Fax #   :</td>
                      <td > 
  <asp:TextBox ID="Textbox_FaxNo" runat="server"   MaxLength="7" ></asp:TextBox></td>
                    </tr>                  
                  <tr>
                    <td align="right"    ></td>
                    <td  ><asp:Button   ID="save" runat="server" Text="Save" />
            <asp:Button ID="btn_export" runat="server" OnClick="btn_export_Click" Text="Export" visible="false"/>
                    <asp:Label CssClass="err" ID="Label1" runat="server"></asp:Label></td>
                  </tr>
                    
                  
                </table></div><br />
                  
<asp:HiddenField ID="HiddenFieldPhoneNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldFaxNo" runat="server" />

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Dept_ID"
                    DataSourceID="SqlDataSourceGridView" AllowPaging="True"   Width="100%" PageSize="25">
              <Columns>
                  <asp:TemplateField>
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
              <asp:BoundField DataField="Dept_Name" HeaderText="Department Name" SortExpression="Dept_Name" />
              <asp:BoundField DataField="Dept_Location" HeaderText="Location" SortExpression="Dept_Location" ReadOnly="True" />
              <asp:BoundField DataField="Dept_PhoneNo" HeaderText="PhoneNo" SortExpression="Dept_PhoneNo" ReadOnly="True" />
              <asp:BoundField DataField="Dept_FaxNo" HeaderText="FaxNo" SortExpression="Dept_FaxNo" ReadOnly="True" />
              <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True"
                            SortExpression="EmpID" Visible="False" />
                  <asp:TemplateField HeaderText="Head of Department" SortExpression="Name" Visible="False">
                      <EditItemTemplate>
                          <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>' Visible="False"></asp:TextBox>
                          <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceEmployee"
                              DataTextField="EmployeeName" DataValueField="EmpID" SelectedValue='<%# Bind("EmpID", "{0}") %>'
                              Width="196px">
                          </asp:DropDownList><br />
                      </EditItemTemplate>
                      <ItemTemplate>
                          <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>

                          <asp:Label ID="lblHOspItalid" runat="server" Text='<%# Eval("Hospital_ID") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
              <asp:BoundField DataField="Dept_ID" HeaderText="Dept_ID" InsertVisible="False" ReadOnly="True"
                            SortExpression="Dept_ID" Visible="False" />
                  <asp:TemplateField HeaderText="Type" SortExpression="Dept_type">
                      <EditItemTemplate>
                          <asp:DropDownList ID="DropDownList_Edit_Type" runat="server" SelectedValue='<%# Bind("Dept_type") %>'
                              Width="208px">
                              <asp:ListItem Selected="True" Value="0">Administrative</asp:ListItem>
                              <asp:ListItem Value="1">Clinical</asp:ListItem>
                              <asp:ListItem Value="2">Surgery</asp:ListItem>
                              <asp:ListItem>NULL</asp:ListItem>
                          </asp:DropDownList>
                      </EditItemTemplate>
                      <ItemTemplate>
                          &nbsp;<asp:Label ID="Label4" runat="server" Text='<%# Bind("Dept_type") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
              <RowStyle CssClass="GridItem" />
              <HeaderStyle CssClass="GridHeader" />            
              <AlternatingRowStyle CssClass="GridAltItem" />
              <PagerStyle CssClass="GridPager"  />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="Select_Dept_new" DeleteCommand="Delete_Dept" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Department SET Head_of_Department = @Head_of_Department, Dept_Name = @Dept_Name, Dept_type = @Dept_Type, Dept_Location = @Location, Dept_PhoneNo = @Phone, Dept_FaxNo = @FaxNo WHERE (Dept_ID = @Dept_ID)" SelectCommandType="StoredProcedure" InsertCommand="[Insert_Department]" InsertCommandType="StoredProcedure" DeleteCommandType="StoredProcedure">
              <DeleteParameters>
                <asp:ControlParameter ControlID="GridView1" Name="Dept_ID" PropertyName="SelectedValue" />
              </DeleteParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="HiddenFieldHead" Name="Head_of_Department" PropertyName="Value" />
                    <asp:ControlParameter ControlID="TextBoxDepartmentName" Name="Dept_Name" PropertyName="Text" />
                    <asp:ControlParameter ControlID="GridView1" Name="Dept_ID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList_Type" Name="Dept_Type" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="TextBoxLocation" Name="Location" PropertyName="Text" />
                    <asp:ControlParameter ControlID="TextBox_PhoneNo" Name="Phone" PropertyName="Text" />
                    <asp:ControlParameter ControlID="Textbox_FaxNo" Name="FaxNo" PropertyName="Text" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_Dept" Name="mywhere" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="DropDownList_Hospital" Name="Hospital_ID" PropertyName="SelectedValue"
                        Type="Int32" />
                </SelectParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBoxDepartmentName" Name="DeptName" PropertyName="Text" />
                    <asp:ControlParameter ControlID="TextBoxLocation" Name="Location" PropertyName="Text" />
                    <asp:ControlParameter ControlID="HiddenFieldPhoneNo" Name="PhoneNo" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenFieldFaxNo" Name="FaxNo" PropertyName="Value" />
                    <asp:SessionParameter DefaultValue="" Name="Empid" SessionField="emp_id" />
                    <asp:ControlParameter ControlID="DropDownList_Type" Name="Type" Type="String"  />
                    <asp:ControlParameter ControlID="DropDownList_Hospital" Name="Hospital_Id" PropertyName="SelectedValue" />
                </InsertParameters>
            </asp:SqlDataSource>
    
            <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="SELECT ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, ' ') + ' ' + ISNULL(ELName, ' ') AS EmployeeName, EmpID FROM Employee WHERE (PayScale > @PayScale) AND (ActiveStatus = 1)&#13;&#10;Order by EmployeeName" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
              <SelectParameters>
                <asp:Parameter DefaultValue="15" Name="PayScale" Type="Int32" />
              </SelectParameters>
            </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldDepartmentName" runat="server" />
                <asp:HiddenField ID="HiddenFieldHead" runat="server" />
                <asp:HiddenField ID="HiddenFieldID" runat="server" />
    <asp:HiddenField ID="HiddenField_Type" runat="server" />
    <br />
    <asp:HiddenField ID="HiddenField_Dept" runat="server" />
            <br />

 </asp:Content>
 