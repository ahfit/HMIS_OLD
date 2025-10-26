<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_change_name, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panelb" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     
     



 
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%" valign="top"><asp:RadioButtonList ID="RadioButtonList1" runat="server" DataSourceID="SqlDataSource_Document_Type"
                          DataTextField="Document_Name" DataValueField="Document_Type_ID" RepeatColumns="2" Width="98%">
                      </asp:RadioButtonList>&nbsp;<asp:LinkButton ID="LinkButton_add_document_Type" runat="server">Add Document Type</asp:LinkButton></td>
    <td  width="50%" valign="top">    
    
    
    
    <div class="bxmain">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="30%" align="right"><span class="label_1">File No. :</span></td>
    <td width="70%"><span class="form_li">
      <asp:TextBox ID="TextBox_File_No" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
    </span></td>
  </tr>
  <tr>
    <td align="right"><span class="form_li">
      <label class="label_1">Date : </label>
    </span></td>
    <td><span class="form_li">
      <asp:TextBox ID="TextBox_date_day" runat="server" CssClass="input_txt" Width="35px"></asp:TextBox>
-
<asp:TextBox ID="TextBox_Date_Month" runat="server" CssClass="input_txt"  Width="25px"></asp:TextBox>
-
<asp:TextBox ID="TextBox_date_Year" runat="server" CssClass="input_txt" Width="65px"></asp:TextBox>
    </span></td>
  </tr>
  <tr>
    <td align="right"><span class="label_1">Page No. :</span></td>
    <td><span class="form_li">
      <asp:TextBox ID="TextBox_page_no" CssClass="input_txt" runat="server" Width="150px"></asp:TextBox>
    </span></td>
  </tr>
  <tr>
    <td align="right"><span class="label_1">Refrence No. : </span></td>
    <td><span class="form_li">
      <asp:TextBox ID="TextBox_reference_No" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
    </span></td>
  </tr>
  <tr>
    <td align="right"><span class="form_li">
      <label class="label_1">Address To : </label>
    </span></td>
    <td><span class="form_li">
      <asp:TextBox ID="TextBox_Address_To" CssClass="input_txt" runat="server" Width="150px"></asp:TextBox>
    </span></td>
  </tr>
 </table>
    
   </div> 
    </td>
  </tr>
   
</table>

 
  

 

    <asp:Panel ID="Panel1" runat="server" Visible="False" >
 

<table width="100%" border="0" class="tbl_form">
  <tr>
    <td align="right">Document Name : </td>
    <td align="left"><asp:TextBox ID="TextBox_doc_type" CssClass="input_txt" Width="150px"  runat="server"></asp:TextBox>&nbsp; <asp:Button ID="Button_doc_Save" runat="server" Text="Save" CssClass="btn1" />&nbsp;<asp:Button ID="Button_doc_cancel" runat="server" Text="Cancel" CssClass="btn1" /></td>
  </tr>
</table>

<br />

       
        <asp:SqlDataSource ID="SqlDataSource_doc_insert" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Document_Type] WHERE [Document_Type_ID] = @Document_Type_ID"
            InsertCommand="INSERT INTO [Document_Type] ([Document_Name]) VALUES (@Document_Name)"
            SelectCommand="SELECT [Document_Type_ID], [Document_Name] FROM [Document_Type]"
            UpdateCommand="UPDATE [Document_Type] SET [Document_Name] = @Document_Name WHERE [Document_Type_ID] = @Document_Type_ID">
            <DeleteParameters>
                <asp:Parameter Name="Document_Type_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Document_Name" Type="String" />
                <asp:Parameter Name="Document_Type_ID" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox_doc_type" Name="Document_Name" PropertyName="Text"
                    Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
    </asp:Panel>
    
<div align="center"><asp:Button ID="Button_Save_Info" runat="server" Text="Save" CssClass="btn1" /></div> <br />

<h1 class="h1"><span>View Documents</span></h1>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="25%"><div style="height:400px; width:98%; overflow:auto; overflow-x:hidden;" >
           
              <asp:SqlDataSource ID="SqlDataSourceDataList" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT category, ISNULL(Description, '') , pic_path FROM Pt_Pic_SaveRecord WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) ">
                  <SelectParameters>
                      <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                      <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                  </SelectParameters>
              </asp:SqlDataSource>

              <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_other_doc"
                  Width="23px"  DataKeyNames="Image_URL">
                  <Columns>
                      <asp:TemplateField>
                          <ItemTemplate>
								<asp:ImageButton ID="ImageButton1" runat="server" CommandArgument='<%# Eval("Image_URL", "{0}") %>'
                                  Height="123px" ImageUrl='<%# Eval("Image_URL", "{0}") %>' OnClick="ImageButton1_Click"
                                  Width="122px" AlternateText='<%# Eval("Other_Documents_ID","{0}") %>' /><asp:HiddenField ID="HiddenField_url" runat="server" Value='<%# Eval("Image_URL", "{0}") %>' />
                          </ItemTemplate>
                      </asp:TemplateField>
                  </Columns>
                  <RowStyle CssClass="GridItem" />
                  <HeaderStyle CssClass="GridHeader" />
                  <AlternatingRowStyle CssClass="GridAltItem" />
              </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSource_Document_Type" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                  SelectCommand="SELECT [Document_Type_ID], [Document_Name] FROM [Document_Type]">
              </asp:SqlDataSource>

              <asp:HiddenField ID="HiddenField_date" runat="server" />
              <asp:HiddenField ID="HiddenField_Other_Document_ID" runat="server" />
              <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
              </asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  InsertCommand="INSERT INTO Pt_Pic_SaveRecord(YearlyNo, RegNo, category, pic_path, Description) VALUES (@YearlyNo, @RegNo, @category, @pic_path, @Description)"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                  <InsertParameters>
                      <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                      <asp:SessionParameter DefaultValue="" Name="RegNo" SessionField="registrationNo" />
                      <asp:ControlParameter ControlID="DropDownListCategory" Name="category" PropertyName="SelectedValue" />
                      <asp:ControlParameter ControlID="HiddenFieldfileupload" Name="pic_path" PropertyName="Value" />
                      <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text" />
                  </InsertParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldfileupload" runat="server" />
              <asp:SqlDataSource ID="SqlDataSource_other_doc" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                  DeleteCommand="DELETE FROM [Other_Documents] WHERE [Other_Documents_ID] = @Other_Documents_ID"
                  InsertCommand="INSERT INTO [Other_Documents] ([emp_ID], [Image_name], [Image_URL]) VALUES (@emp_ID, @Image_name, @Image_URL)"
                  SelectCommand="SELECT Other_Documents_ID, emp_ID, Image_name, @abc + Image_URL AS [Image_URL], Detail FROM Other_Documents WHERE (emp_ID = @emp_ID)"
                  UpdateCommand="UPDATE Other_Documents SET file_No = @file_No, Page_No = @Page_No, Date_of_document = @Date_of_document, Address_To = @Address_To, Document_Type_ID = @Document_Type_ID, Reference_No = @Reference_No WHERE (Other_Documents_ID = @Other_Documents_ID)">
                  <DeleteParameters>
                      <asp:Parameter Name="Other_Documents_ID" Type="Int32" />
                  </DeleteParameters>
                  <UpdateParameters>
                      <asp:ControlParameter ControlID="TextBox_File_No" Name="file_No" PropertyName="Text" />
                      <asp:ControlParameter ControlID="TextBox_page_no" Name="Page_No" PropertyName="Text" />
                      <asp:ControlParameter ControlID="HiddenField_date" Name="Date_of_document" PropertyName="Value"
                          Type="DateTime" />
                      <asp:ControlParameter ControlID="TextBox_Address_To" Name="Address_To" PropertyName="Text" />
                      <asp:ControlParameter ControlID="RadioButtonList1" Name="Document_Type_ID" PropertyName="SelectedValue" />
                      <asp:ControlParameter ControlID="TextBox_reference_No" Name="Reference_No" PropertyName="Text" />
                      <asp:ControlParameter ControlID="HiddenField_Other_Document_ID" Name="Other_Documents_ID"
                          PropertyName="Value" />
                  </UpdateParameters>
                  <SelectParameters>
                      <asp:SessionParameter Name="emp_ID" SessionField="enter_emp_ID" />
                      <asp:ControlParameter ControlID="HiddenField_send_url" Name="abc" PropertyName="Value" />
                  </SelectParameters>
                  <InsertParameters>
                      <asp:SessionParameter Name="emp_ID" SessionField="Enter_emp_ID" Type="Int32" />
                      <asp:ControlParameter ControlID="HiddenField_name" Name="Image_name" PropertyName="Value"
                          Type="String" />
                      <asp:ControlParameter ControlID="HiddenField_url" Name="Image_URL" PropertyName="Value"
                          Type="String" />
                      <asp:Parameter Name="Detail" Type="String" />
                  </InsertParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_name" runat="server" />
              <asp:HiddenField ID="HiddenField_url" runat="server" />
              <asp:HiddenField ID="HiddenField_send_url" runat="server" />
</div></td>
    <td valign="top" >
    
    
    <div style="width:535px; height:500px; overflow:auto; ">
      <asp:ImageButton ID="ImageButton_img" runat="server"     />      
    </div>
    
    
    
    </td>
  </tr>
</table>
<br>


      
</td>
</tr>
</table>


                                                       
  </asp:Content>