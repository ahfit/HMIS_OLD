<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Department, App_Web_pvcsvhw1" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
<script type="text/javascript" src="../../css_hacims/maskito.js"></script>
<script type="text/javascript" src="../../Validate.js"></script>
<script type="application/javascript">

$(document).ready(function () { 

   $("#ctl00_ContentPlaceHolder1_TextBox_PhoneNo").mask("99-99-9999999");

   $("#ctl00_ContentPlaceHolder1_Textbox_FaxNo").mask("99-99-9999999");

  
     
   $("#ctl00_ContentPlaceHolder1_save").click(function(){
	var ph = $("#ctl00_ContentPlaceHolder1_TextBox_PhoneNo:input").val();
		if (ph ==0  ) {    alert ("Please Enter Phone Number ")  
						   $('#ctl00_ContentPlaceHolder1_TextBox_PhoneNo').focus(); return false;   }  
						   
		var hn = $("#ctl00_ContentPlaceHolder1_TextBox_Hospital:input").val();
		if (hn ==0  ) {    alert ("Please Enter Hospital Name ")  
						   $('#ctl00_ContentPlaceHolder1_TextBox_Hospital').focus();  return false; }  				   
						   
	  
   });   
 });   
</script> 
 
 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="bxmain inner_content">

  <div class="bxmain inner_content" style="text-align:left; width:100%;background-color:transparent; border:none; font-weight:bold;">
<h2><span>Add Hospital</span> </h2>
</div>

       
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
 


                  <tr>
                    <td align="right" width="40%"   >
                        Hospital Name  :</td>
                              <td   ><asp:TextBox ID="TextBox_Hospital" runat="server" Width="350px" Style="text-transform:uppercase; background-color: #f9dde2;" 
                                ></asp:TextBox>
                    <span class="marks">*</span>
                                  </td>
      </tr>
    <tr>
        <td align="right"  >Abbreviation :</td>
        <td  >
            <asp:TextBox ID="TextBox_Abbr" runat="server"  Width="100px"></asp:TextBox></td>
    </tr>
                  <tr>
                    <td align="right" valign="top"   >Address  :</td>
                      <td  ><asp:TextBox ID="TextBoxLocation" runat="server" Width="200px"  Height="50px" TextMode="MultiLine" ></asp:TextBox></td>
                    </tr>
    <tr>
        <td align="right"  >
            City :</td>
        <td  >
            <asp:DropDownList ID="DropDownList_City" runat="server" DataSourceID="SqlDataSource_City"
                DataTextField="TehsilName" DataValueField="TehsilCode" >
            </asp:DropDownList></td>
    </tr>
                  <tr>
                    <td align="right"   >Phone #   :</td>
                      <td  >
                   <asp:TextBox ID="TextBox_PhoneNo" runat="server"  Style="background-color: #f9dde2;"  ></asp:TextBox>
                       <span class="marks">*</span></td>
                    </tr>
                  <tr>
                    <td  align="right"   >Fax #   :</td>
                      <td >
                         <asp:TextBox ID="Textbox_FaxNo" runat="server"    ></asp:TextBox></td>
                    </tr>
                 
    <tr>
        <td align="right"   >
            Logo Image:</td>
        <td >
          <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
            <asp:HiddenField ID="HiddenField_ContentType" runat="server" />
            <asp:HiddenField ID="HiddenField_FileName" runat="server" />
        </td>
    </tr>
      
      <tr>
          <td align="right">
          </td>
          <td>
            <asp:Button  ID="save" runat="server" Text="Save"    />  
            <asp:Label CssClass="err" ID="Label1" runat="server"></asp:Label></td>
      </tr>
      <tr>
          <td align="right">
          </td>
          <td>
          </td>
      </tr>
                 
                
                  
                  </table>
                </div>
                  <br />

    <asp:GridView ID="GridView_Hospital" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        CssClass="Grid_1" DataKeyNames="Hospital_Id" DataSourceID="SqlDataSourceGridView"
        PageSize="25" Width="100%">
        <RowStyle CssClass="GridItem" />
        <Columns>
            <asp:TemplateField>
                <EditItemTemplate>
                    <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif"
                        ToolTip="Update" /><asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel"
                            ImageUrl="~/images_hacims/icon_err.gif" ToolTip="Cancel" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Select" ImageUrl="~/images_hacims/icon_edit.gif"
                        OnClientClick="return confirmation_edit(this)" ToolTip="Edit" /><asp:ImageButton
                            ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"
                            OnClientClick="return confirmation(this)" ToolTip="Delete" />
                    <asp:HiddenField ID="HF_Hospital_ID" runat="server" Value='<%# Eval("Hospital_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
           
            <asp:BoundField DataField="Hospital_Name" HeaderText="Hospital" SortExpression="Hospital_Name" />
            <asp:BoundField DataField="Hospital_Abb" HeaderText="Abbreviation" SortExpression="Hospital_Abb" />
            <asp:BoundField DataField="Hospital_Address" HeaderText="Address" SortExpression="Hospital_Address" />
             <asp:TemplateField HeaderText="City" SortExpression="DistrictName">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_CityDrop"
                        DataTextField="TehsilName" DataValueField="TehsilCode" SelectedValue='<%# Eval("Tehsil_ID") %>'>
                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource_CityDrop" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT     TehsilName, TehsilCode&#13;&#10;FROM         (SELECT     ' ' AS TehsilName, 0 AS TehsilCode&#13;&#10;                       UNION&#13;&#10;                       SELECT     TehsilName, TehsilCode&#13;&#10;                       FROM         TEHSIL) AS temp&#13;&#10;ORDER BY TehsilName">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("TehsilName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Hospital_Phone" HeaderText="Phone" SortExpression="Hospital_Phone" />
            <asp:BoundField DataField="Hospital_FaxNo" HeaderText="FaxNo" SortExpression="Hospital_FaxNo" />
        </Columns>
        <PagerStyle CssClass="GridPager" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
 <br />
     
    <asp:HiddenField ID="HiddenField_TehsilID" runat="server" />
    <asp:HiddenField ID="HiddenField_Phone" runat="server" />
    <asp:HiddenField ID="HiddenField_Fax" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_WithoutLogo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        DeleteCommand="[Delete_Hospital]" InsertCommand="INSERT INTO Hospital(Hospital_Name, Hospital_Abb, Hospital_Address, Hospital_Phone, Hospital_FaxNo, Tehsil_ID, Attachment, Attachment_ContentType, Attachment_Name) VALUES (@Hospital_Name, @Hospital_Abb, @Hospital_Address, @Hospital_Phone, @Hospital_FaxNo, @Tehsil_ID, @Attachment, @Attachment_ContentType, @Attachment_Name)"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select_Hospital" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Hospital SET Hospital_Name = @Hospital_Name, Hospital_Abb = @Hospital_Abb, Hospital_Address = @Hospital_Address, Hospital_Phone = @Hospital_Phone, Hospital_FaxNo = @Hospital_FaxNo, Tehsil_ID = @Tehsil_ID WHERE (Hospital_ID = @Hospital_Id)" DeleteCommandType="StoredProcedure"><DeleteParameters>
            <asp:ControlParameter ControlID="GridView_Hospital" Name="Hospital_ID" PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="TextBox_Hospital" Name="Hospital_Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_Abbr" Name="Hospital_Abb" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBoxLocation" Name="Hospital_Address" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_PhoneNo" Name="Hospital_Phone" PropertyName="Text" />
            <asp:ControlParameter ControlID="Textbox_FaxNo" Name="Hospital_FaxNo" PropertyName="Text" />
            <asp:ControlParameter ControlID="DropDownList_City" Name="Tehsil_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="GridView_Hospital" Name="Hospital_Id" PropertyName="SelectedValue" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Hospital" Name="Hospital_Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_Abbr" Name="Hospital_Abb" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBoxLocation" Name="Hospital_Address" PropertyName="Text" />
            <asp:ControlParameter ControlID="HiddenField_Phone" Name="Hospital_Phone" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Fax" Name="Hospital_FaxNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_City" Name="Tehsil_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="FileUpload1" Name="Attachment" PropertyName="FileBytes" />
            <asp:ControlParameter ControlID="HiddenField_FileName" Name="Attachment_Name" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_ContentType" Name="Attachment_ContentType"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="TextBox_Hospital" Name="Hospital_Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_Abbr" Name="Hospital_Abb" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBoxLocation" Name="Hospital_Address" PropertyName="Text" />
            <asp:ControlParameter ControlID="HiddenField_Phone" Name="Hospital_Phone" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Fax" Name="Hospital_FaxNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_City" Name="Tehsil_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="FileUpload1" Name="Attachment" PropertyName="FileBytes" />
            <asp:ControlParameter ControlID="HiddenField_FileName" Name="Attachment_Name" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_ContentType" Name="Attachment_ContentType"
                PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    &nbsp;
       
    <asp:SqlDataSource ID="SqlDataSource_City" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT      TehsilName,TehsilCode FROM         TEHSIL order by TehsilName">
    </asp:SqlDataSource><asp:SqlDataSource ID="SqlDataSourceGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        DeleteCommand="[Delete_Hospital]" InsertCommand="INSERT INTO Hospital(Hospital_Name, Hospital_Abb, Hospital_Address, Hospital_Phone, Hospital_FaxNo, Tehsil_ID, Attachment, Attachment_ContentType, Attachment_Name) VALUES (@Hospital_Name, @Hospital_Abb, @Hospital_Address, @Hospital_Phone, @Hospital_FaxNo, @Tehsil_ID, @Attachment, @Attachment_ContentType, @Attachment_Name)"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select_Hospital" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Hospital SET Hospital_Name = @Hospital_Name, Hospital_Abb = @Hospital_Abb, Hospital_Address = @Hospital_Address, Hospital_Phone = @Hospital_Phone, Hospital_FaxNo = @Hospital_FaxNo, Tehsil_ID = @Tehsil_ID, Attachment = @Attachment, Attachment_ContentType = @Attachment_ContentType, Attachment_Name = @Attachment_Name WHERE (Hospital_ID = @Hospital_Id)" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView_Hospital" Name="Hospital_ID" PropertyName="SelectedValue" />
            
            <asp:Parameter Name="is_Deleted" Direction="Output" Type="Boolean" DefaultValue="False" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="TextBox_Hospital" Name="Hospital_Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_Abbr" Name="Hospital_Abb" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBoxLocation" Name="Hospital_Address" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_PhoneNo" Name="Hospital_Phone" PropertyName="Text" />
            <asp:ControlParameter ControlID="Textbox_FaxNo" Name="Hospital_FaxNo" PropertyName="Text" />
            <asp:ControlParameter ControlID="DropDownList_City" Name="Tehsil_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="GridView_Hospital" Name="Hospital_Id" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="FileUpload1" Name="Attachment" PropertyName="FileBytes" />
            <asp:ControlParameter ControlID="HiddenField_ContentType" Name="Attachment_ContentType"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_FileName" Name="Attachment_Name" PropertyName="Value" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Hospital" Name="Hospital_Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_Abbr" Name="Hospital_Abb" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBoxLocation" Name="Hospital_Address" PropertyName="Text" />
            <asp:ControlParameter ControlID="HiddenField_Phone" Name="Hospital_Phone" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Fax" Name="Hospital_FaxNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_City" Name="Tehsil_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="FileUpload1" Name="Attachment" PropertyName="FileBytes" />
            <asp:ControlParameter ControlID="HiddenField_FileName" Name="Attachment_Name" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_ContentType" Name="Attachment_ContentType"
                PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
    <asp:HiddenField ID="HiddenField_Hospital_ID" runat="server" />
    <br />
    <asp:HiddenField ID="HiddenField_Dept" runat="server" />
            <br />

 </asp:Content>
 