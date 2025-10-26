<%@ page language="VB" autoeventwireup="false" inherits="HR_attach_Documents_Server, App_Web_2qu1gl2y" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" href="../css/page.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="../css/reset.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="../images/sheet_form.css" type="text/css"  media="screen, projection">

<%--<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="blue" href="css/page.css"/>
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="gray" href="css/themes/c_2.css" />
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="white" href="css/themes/c_3.css" />
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="orange" href="css/themes/c_4.css" />
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="purple" href="css/themes/c_5.css" />
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="greenish" href="css/themes/c_6.css" />
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="green" href="css/themes/c_7.css" />--%>
<script type="text/javascript" src="../images/styleswitch.js"></script>
<script type="text/javascript" src="../images/highlight.js"></script>
<style type="text/css">
fieldset{border:#CCCCCC solid 1px; padding:10px;}
.block_1{height:0px;}
.label_1{width:140px;}
.Grid_1 th{font-weight:normal;}

.Grid_Grid{display:inline; }

.Grid_Grid td{display:inline; }
.Grid_Grid tr{display:inline; }
.Grid_Grid th{display:inline; }

.img_grid{ float:left; clear:right; display:inline; }
.grid_img{ border:#CCCCCC solid 2px; margin-bottom:5px;}
</style>

 
<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<table width="100%">
    <tr>
        <td colspan="2">
        <div class="bxmain" style="padding: 17px; width: 65%;">

                <div>

                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="EmpID" DataSourceID="dsEmployeeInfo"
                          HorizontalAlign="Left" Width="100%">
                         <ItemTemplate>
                    
                            <asp:Image ID="Image2" runat="server" Style="position:absolute; margin-left:25px; margin-top:60px;" 
                                            ImageUrl=' <%# Convert.ToString("~/DisplayPic.ashx?Emp_Id=") + Convert.ToString(Eval("EmpID")) %>' 
                                            Width="77px" Height="90px" />  
                    
                        <div class="bxinset radius4">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
     
    <td valign="top">  
    
 <ul class="empinfo">
 <li class="name" style="display:inline;">  <asp:Label ID="Label_EmpName" runat="server"    Text='<%# Eval("[Employee Name]") %>'   ToolTip="Employee Name"></asp:Label></li> <span class="splt">|</span> 
<li style="display:inline;"><asp:Label ID="Designation_NameLabel" runat="server" style="color:#c60c0c; font-weight:bold;"  Text='<%# Bind("Designation_Name") %>'></asp:Label> <asp:Label ID="Designation_NameLabel0" Visible="false" runat="server"  Text='<%# Convert.ToString("( ")+ Convert.ToString(Eval("SubDept_Name"))+Convert.ToString(" )") %>'></asp:Label></li><span class="splt">|</span>
<li class="div" style="display:inline;"><asp:Label ID="Designation_NameLabel1" runat="server" Text='<%# Eval("Dept_Name") %>'  ></asp:Label></li><span class="splt">|</span> 
<li style="display:inline;"> Emp #  <strong><asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpNo") %>'  ToolTip="Patient Registration Number"></asp:Label></strong>
<span class="spl">|</span>
Join Date : <strong><asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' ToolTip="Patient Age"></asp:Label></strong>
<span class="spl">|</span>
 <strong><asp:Label ID="Label_CNIC" runat="server"  Visible="false"  Text='<%# Eval("CNIC") %>' ToolTip="Identity Card #"></asp:Label></strong>
 
<strong><asp:Label ID="LabelGender" Visible="false" runat="server"  Text='<%# Eval("Gender") %>' ToolTip="Patient Gender"></asp:Label></strong>
  </li></ul>                                     


</td>
  </tr>
</table>
</div>
                        
                    </ItemTemplate>
                </asp:FormView>
                
                
                <asp:SqlDataSource ID="dsEmployeeInfo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
            SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <%--<asp:ControlParameter ControlID="HiddenField_Emp_ID" DefaultValue="0" 
                    Name="EmpID" PropertyName="Value" />--%>
                <asp:QueryStringParameter Name="EmpID" DefaultValue="0" QueryStringField="Emp_Id" />
            </SelectParameters>
        </asp:SqlDataSource>

</div>


</div>
        
        
        </td>
    
    </tr>
    
    <tr>
        <td colspan="2"> <h1 class="h1_1">Document View</h1></td>

        
    </tr>

   
    <tr>
        <td>Attach Image : </td>
        <td><asp:FileUpload ID="FileUpload_pic" CssClass="input_txt" Width="250px" runat="server" /> 
         <asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label>
           
         </td>
    </tr>

    <tr>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>Description : </td>
        <td><asp:TextBox ID="TextBox_Description" runat="server" CssClass="input_txt" Width="250px"></asp:TextBox></td>
    </tr>
    
    
    <tr>
        <td colspan="2">
            <div style="height:520px; width:130px; overflow:scroll; overflow-x:hidden; overflow-y:scroll; float:left; clear:right;" >
           
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_other_doc"
                   CssClass="Grid_Grid" DataKeyNames="Image_URL" visible = "false"><Columns>
<asp:TemplateField><ItemTemplate>
<asp:ImageButton id="ImageButton1" onclick="ImageButton1_Click" runat="server" CssClass="grid_img" Width="122px" Height="123px" ImageUrl='<%# Eval("Image_URL", "{0}") %>' CommandArgument='<%# Eval("Image_URL", "{0}") %>'></asp:ImageButton><asp:HiddenField id="HiddenField_url" runat="server" Value='<%# Eval("Image_URL", "{0}") %>'></asp:HiddenField> 
</ItemTemplate>
    <ControlStyle CssClass="img_grid" />
</asp:TemplateField>
</Columns>


</asp:GridView>

            </div>
        
        
        
        
        
        </td>
        
    </tr>
    <tr>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td><asp:Button ID="Button2" runat="server" Text="Button" />
         <asp:Button ID="Button_Save" runat="server" Text="Save"  /><%--CssClass="btn1"--%>
             <asp:Label ID="Label1" runat="server" CssClass="err" ></asp:Label>
         </td>
        <td></td>
    </tr>


</table>


<%--<div class="bxmain" style="padding: 17px; width: 65%;">

<div>

<asp:FormView ID="FormView1" runat="server" DataKeyNames="EmpID" DataSourceID="dsEmployeeInfo"
                    HorizontalAlign="Left" Width="100%">
                    <ItemTemplate>
                    
                  <asp:Image ID="Image2" runat="server" Style="position:absolute; margin-left:25px; margin-top:60px;" 
                                            ImageUrl=' <%# Convert.ToString("~/DisplayPic.ashx?Emp_Id=") + Convert.ToString(Eval("EmpID")) %>' 
                                            Width="77px" Height="90px" />  
                    
                        <div class="bxinset radius4">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
     
    <td valign="top">  
    
 <ul class="empinfo">
 <li class="name" style="display:inline;">  <asp:Label ID="Label_EmpName" runat="server"    Text='<%# Eval("[Employee Name]") %>'   ToolTip="Employee Name"></asp:Label></li> <span class="splt">|</span> 
<li style="display:inline;"><asp:Label ID="Designation_NameLabel" runat="server" style="color:#c60c0c; font-weight:bold;"  Text='<%# Bind("Designation_Name") %>'></asp:Label> <asp:Label ID="Designation_NameLabel0" Visible="false" runat="server"  Text='<%# Convert.ToString("( ")+ Convert.ToString(Eval("SubDept_Name"))+Convert.ToString(" )") %>'></asp:Label></li><span class="splt">|</span>
<li class="div" style="display:inline;"><asp:Label ID="Designation_NameLabel1" runat="server" Text='<%# Eval("Dept_Name") %>'  ></asp:Label></li><span class="splt">|</span> 
<li style="display:inline;"> Emp #  <strong><asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpNo") %>'  ToolTip="Patient Registration Number"></asp:Label></strong>
<span class="spl">|</span>
Join Date : <strong><asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' ToolTip="Patient Age"></asp:Label></strong>
<span class="spl">|</span>
 <strong><asp:Label ID="Label_CNIC" runat="server"  Visible="false"  Text='<%# Eval("CNIC") %>' ToolTip="Identity Card #"></asp:Label></strong>
 
<strong><asp:Label ID="LabelGender" Visible="false" runat="server"  Text='<%# Eval("Gender") %>' ToolTip="Patient Gender"></asp:Label></strong>
  </li></ul>                                     


</td>
  </tr>
</table>
</div>
                        
                    </ItemTemplate>
                </asp:FormView>
                
                
                <asp:SqlDataSource ID="dsEmployeeInfo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
            SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <%--<asp:ControlParameter ControlID="HiddenField_Emp_ID" DefaultValue="0" 
                    Name="EmpID" PropertyName="Value" />--%>
                <asp:QueryStringParameter Name="EmpID" DefaultValue="0" QueryStringField="Emp_Id" />
            </SelectParameters>
        </asp:SqlDataSource>

</div>


</div>--%>
<div id="allcontent" class="container">

<%--<div id="name"   class="span-18 info_h">Welcome ! &nbsp;<span class="txt_black"> <asp:Label ID="LabelDoctorName" runat="server" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment"></asp:Label></span></div>
<div id="date" 	 class="span-6 last date"><asp:Label ID="LabelDate" runat="server" ></asp:Label></div>--%>
<%--<div id="header" class="span-24 header_bg"></div>--%>

<div id="toolbar" 	class="span-24 toolbar">
<ul>


<%--<li><a href="#">Home</a></li>--%>
<%--<li style="float:right; position:relative; margin-right:-50px;"><a href="../login.aspx" style="color:#990000;">Logout</a></li>--%>

</ul>
</div><!--toolbar End-->


<div id="column_3" class="span-24 last">

        <div id="block_info_4" class="block_1">
        <%-- <h1 class="h1_1">Document View</h1>--%>


            <div id="content" class="forms_items">

<div >


    <ul class="form_ul">
       <%-- <asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label>--%>
        <li class="form_li">
            <%--<label class="label_1">Attach Image : </label><asp:FileUpload ID="FileUpload_pic" CssClass="input_txt" Width="250px" runat="server" />--%>
        </li> 
    </ul>

<fieldset><legend>Documents</legend>
<asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatColumns="7" RepeatDirection="Horizontal" Width="90%" CssClass="chklist"> </asp:CheckBoxList>

</fieldset>
<br />

<ul class="form_ul">
<li class="form_li"><%--<label class="label_1">Description : </label> <asp:TextBox ID="TextBox_Description" runat="server" CssClass="input_txt" Width="250px"></asp:TextBox>--%></li> 


<li class="form_li"><label class="label_1">&nbsp;</label> <%--<asp:Button ID="Button_Save" runat="server" Text="Save" CssClass="btn1" />--%>
    <%--<asp:Button ID="Button2" runat="server" Text="Button" />--%>
    <%--<asp:Label ID="Label1" runat="server" CssClass="err" ></asp:Label>--%></li>
</ul>

<fieldset><legend>View Documents</legend>

              <asp:SqlDataSource ID="SqlDataSourceDataList" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT category, ISNULL(Description, '') , pic_path FROM Pt_Pic_SaveRecord WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) ">
                  <SelectParameters>
                      <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                      <asp:SessionParameter DefaultValue="" Name="YearlyNo" SessionField="YearlyNo" />
                  </SelectParameters>
              </asp:SqlDataSource>

<%--<div style="height:520px; width:130px; overflow:scroll; overflow-x:hidden; overflow-y:scroll; float:left; clear:right;" >
           
<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_other_doc"
                   CssClass="Grid_Grid" DataKeyNames="Image_URL" visible = "false"><Columns>
<asp:TemplateField><ItemTemplate>
<asp:ImageButton id="ImageButton1" onclick="ImageButton1_Click" runat="server" CssClass="grid_img" Width="122px" Height="123px" ImageUrl='<%# Eval("Image_URL", "{0}") %>' CommandArgument='<%# Eval("Image_URL", "{0}") %>'></asp:ImageButton><asp:HiddenField id="HiddenField_url" runat="server" Value='<%# Eval("Image_URL", "{0}") %>'></asp:HiddenField> 
</ItemTemplate>
    <ControlStyle CssClass="img_grid" />
</asp:TemplateField>
</Columns>


</asp:GridView>

</div>--%>



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
              <asp:HiddenField ID="HiddenField_send_url" runat="server" />


<div style="float:right;"><asp:ImageButton ID="ImageButton_img" runat="server" Height="700px" Width="725px" /></div>

</fieldset>

           




</div><!--form End-->


</div><!--content End-->






</div>

</div><!--column_3 End-->

<%--<div id="footer" class="footer">Copyright &copy; 2008  All rights reserved.</div>--%>

<!--allcontent End-->



</asp:Content>
