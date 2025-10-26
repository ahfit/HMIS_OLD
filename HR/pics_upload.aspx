<%@ page language="VB" autoeventwireup="false" inherits="HR_pics_upload, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link href="../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../images/sheet_form.css" rel="stylesheet" type="text/css" />


<script src="../images/highlight.js" type="text/javascript"></script>

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}
fieldset{border:#CCCCCC solid 1px; padding:10px; padding-top:-5px;}
.label_1{width:140px;}
</style>

</head>

<body><form id="form1" runat = "server">

<div id="forms_items" class="forms_items">

<ul class="form_ul">

<asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label>
<li class="form_li"><label class="label_1">Attach Image : </label><asp:FileUpload ID="FileUpload_pic" CssClass="input_txt" Width="250px" runat="server" /></li> 

</ul>

<fieldset><legend>Documents</legend>

<asp:ListBox ID="ListBox1" runat="server" Visible="False"></asp:ListBox>
<asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatColumns="7" RepeatDirection="Horizontal" Width="90%" CssClass="chklist"> </asp:CheckBoxList>

</fieldset>

<br />

<ul class="form_ul">

<li class="form_li"><label class="label_1">
    &nbsp;</label><asp:TextBox ID="TextBox_Description" runat="server" CssClass="input_txt" Width="250px" Visible="False"></asp:TextBox></li> 


<li class="form_li"><label class="label_1">&nbsp;</label> <asp:Button ID="Button_Save" runat="server" Text="Save" CssClass="btn1" /><asp:Button  ID="Button1" runat="server" Text="Attach" CssClass="btn1" /> <asp:Label ID="Label1" runat="server" CssClass="err" ></asp:Label></li>


<fieldset><legend>View Documents</legend>

              <asp:SqlDataSource ID="SqlDataSourceDataList" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT category, ISNULL(Description, '') , pic_path FROM Pt_Pic_SaveRecord WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) ">
                  <SelectParameters>
                      <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                      <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                  </SelectParameters>
              </asp:SqlDataSource>

<div style="height:500px; width:120px; overflow:scroll; overflow-x:hidden; overflow-y:scroll; float:left; clear:right;" >
           
<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_other_doc"
                   DataKeyNames="Image_URL" ><Columns>
<asp:TemplateField><ItemTemplate>
<asp:ImageButton id="ImageButton1" onclick="ImageButton1_Click" runat="server" Width="122px" Height="123px" ImageUrl='<%# Eval("Image_URL", "{0}") %>' CommandArgument='<%# Eval("Image_URL", "{0}") %>'></asp:ImageButton><asp:HiddenField id="HiddenField_url" runat="server" Value='<%# Eval("Image_URL", "{0}") %>'></asp:HiddenField> 
</ItemTemplate>
    <ControlStyle CssClass="img_grid" />
</asp:TemplateField>
</Columns>


</asp:GridView>

</div>



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
                  UpdateCommand="UPDATE [Other_Documents] SET [emp_ID] = @emp_ID, [Image_name] = @Image_name, [Image_URL] = @Image_URL, [Detail] = @Detail WHERE [Other_Documents_ID] = @Other_Documents_ID">
                  <DeleteParameters>
                      <asp:Parameter Name="Other_Documents_ID" Type="Int32" />
                  </DeleteParameters>
                  <UpdateParameters>
                      <asp:Parameter Name="emp_ID" Type="Int32" />
                      <asp:Parameter Name="Image_name" Type="String" />
                      <asp:Parameter Name="Image_URL" Type="String" />
                      <asp:Parameter Name="Detail" Type="String" />
                      <asp:Parameter Name="Other_Documents_ID" Type="Int32" />
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
    <asp:HiddenField ID="HiddenField_path" runat="server" />
              <asp:HiddenField ID="HiddenField_send_url" runat="server" />


<div style="float:left;"><div style="width:550px; height:500px; overflow:scroll;"><asp:ImageButton ID="ImageButton_img" runat="server" /></div></div>

</fieldset>

                                                       

</ul>

<br />

</div>

</form>
</body>
</html>