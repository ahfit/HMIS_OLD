<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="skills, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
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
     
     


<div class="bxmain">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right" valign="top">Skills :</td>
    <td> <asp:TextBox ID="TextBox_Languages" runat="server" Height="250px" TextMode="MultiLine" CssClass="input_txt" Width="90%" ></asp:TextBox></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" /></td>
  </tr>
</table>
</div>
 

<br />
              <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Skills] WHERE [Employee_ID] = @Employee_ID" InsertCommand="INSERT INTO [Skills] ([Employee_ID], [skills]) VALUES (@Employee_ID, @skills)"
            SelectCommand="SELECT [Employee_ID], [skills] FROM [Skills] where employee_ID=@employee_ID"
            UpdateCommand="UPDATE [Skills] SET [skills] = @skills WHERE [Employee_ID] = @Employee_ID">
                <DeleteParameters>
                  <asp:Parameter Name="Employee_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                  <asp:Parameter Name="skills" Type="String" />
                  <asp:Parameter Name="Employee_ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                  <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" />
                  <asp:ControlParameter ControlID="TextBox_Languages" Name="skills" PropertyName="Text"
                    Type="String" />
                </InsertParameters>
                  <SelectParameters>
                      <asp:SessionParameter Name="employee_ID" SessionField="Enter_emp_ID" />
                  </SelectParameters>
              </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Employee_ID"
                    DataSourceID="SqlDataSource1" Width="100%" CssClass="Grid_1">
                    <Columns>
                        <asp:TemplateField HeaderText="Skills" SortExpression="skills">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Height="89px" Text='<%# Bind("skills") %>'
                                    TextMode="MultiLine" Width="223px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("skills") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                                    ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                                    OnClientClick="return confirmation_edit(this)" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
<br />
     
</td>
</tr>
</table>


  </asp:Content>