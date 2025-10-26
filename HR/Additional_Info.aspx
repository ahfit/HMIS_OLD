<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Additional_Info, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


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
 <asp:Panel ID="panel_old" runat ="server" Visible="true"  >
 <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >  <tr>
    <td width="40%" align="right">Objective :</td>
    <td width="60%">
      <asp:TextBox ID="TextBox_objective" runat="server" TextMode="MultiLine"  Height="55px"  Width="248px" ></asp:TextBox>
      <asp:Label ID="Label13" runat="server" CssClass="red"  Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator_objective" runat="server" cssClass="red"
          ControlToValidate="TextBox_objective" ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">Language (English) :</td>
    <td>
      <asp:DropDownList ID="DropDownList_language" runat="server"   Width="250px">
        <asp:ListItem>High Proficiency</asp:ListItem>
        <asp:ListItem>Medium Proficiency</asp:ListItem>
        <asp:ListItem>Low Proficiency</asp:ListItem>
      </asp:DropDownList>
    </td>
  </tr>
  <tr>
    <td align="right">
      <label class="label_1">Strengths : </label>
    </td>
    <td>
      <asp:TextBox ID="TextBox_strengths" runat="server" Height="55px" TextMode="MultiLine"   Width="248px"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">
      <label class="label_1">Awards : </label>
    </td>
    <td>
      <asp:TextBox ID="TextBox_awards" runat="server" TextMode="MultiLine"  Height="55px" Width="248px" ></asp:TextBox>
      <asp:Label ID="Label1" runat="server" CssClass="red"  Text="*"></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_awards" CssClass="red"
          ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">
      <label class="label_1">Hobbies : </label>
    </td>
    <td>
      <asp:TextBox ID="TextBox_hobbies" runat="server" TextMode="MultiLine"   Height="55px" Width="248px" ></asp:TextBox>
      <asp:Label ID="Label2" runat="server" CssClass="red"  Text="*" ></asp:Label>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_hobbies"
        ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td>
      <asp:Button    ID="Button1_Save" runat="server" Text="Save" />      
    </td>
  </tr>
 </table>

</asp:Panel>
 
<asp:Panel ID="panel_new" runat ="server" Visible="False" >
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CssClass="Grid_1"
        DataKeyNames="Employee_ID" DataSourceID="SqlDataSource2" Width="100%">
        <Fields>
            <asp:TemplateField HeaderText="Objective" SortExpression="Objective">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Height="56px" Text='<%# Bind("Objective") %>'
                        TextMode="MultiLine" Width="211px"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Objective") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Objective") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Language" SortExpression="Language">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Height="75px" Text='<%# Bind("Language") %>'
                        TextMode="MultiLine" Width="215px"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Language") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Language") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Strengths" SortExpression="Strengths">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Height="66px" Text='<%# Bind("Strengths") %>'
                        TextMode="MultiLine" Width="218px"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Strengths") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Strengths") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Awards" SortExpression="Awards">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Height="67px" Text='<%# Bind("Awards") %>'
                        TextMode="MultiLine" Width="217px"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Awards") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Awards") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Hobbies" SortExpression="Hobbies">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Height="77px" Text='<%# Bind("Hobbies") %>'
                        TextMode="MultiLine" Width="218px"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Hobbies") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Hobbies") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <EditItemTemplate>
                    <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />
                    <asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                        OnClientClick="return confirmation_edit(this)" />
                    <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                        OnClientClick="return confirmation(this)" />
                </ItemTemplate>
            </asp:TemplateField>
        </Fields>
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
        DeleteCommand="DELETE FROM [Additional_Info] WHERE [Employee_ID] = @Employee_ID"
        InsertCommand="INSERT INTO [Additional_Info] ([Employee_ID], [Objective], [Language], [Strengths], [Awards], [Hobbies], [Expected_Salary]) VALUES (@Employee_ID, @Objective, @Language, @Strengths, @Awards, @Hobbies)"
        SelectCommand="SELECT [Employee_ID], [Objective], [Language], [Strengths], [Awards], [Hobbies] FROM [Additional_Info] WHERE ([Employee_ID] = @Employee_ID)"
        UpdateCommand="UPDATE [Additional_Info] SET [Objective] = @Objective, [Language] = @Language, [Strengths] = @Strengths, [Awards] = @Awards, [Hobbies] = @Hobbies WHERE [Employee_ID] = @Employee_ID">
        <DeleteParameters>
            <asp:Parameter Name="Employee_ID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Objective" Type="String" />
            <asp:Parameter Name="Language" Type="String" />
            <asp:Parameter Name="Strengths" Type="String" />
            <asp:Parameter Name="Awards" Type="String" />
            <asp:Parameter Name="Hobbies" Type="String" />
            <asp:Parameter Name="Employee_ID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Employee_ID" Type="Int32" />
            <asp:Parameter Name="Objective" Type="String" />
            <asp:Parameter Name="Language" Type="String" />
            <asp:Parameter Name="Strengths" Type="String" />
            <asp:Parameter Name="Awards" Type="String" />
            <asp:Parameter Name="Hobbies" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Panel> 
</div>
<br />
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Additional_Info] WHERE [Employee_ID] = @Employee_ID"
            InsertCommand="INSERT INTO [Additional_Info] ([Employee_ID], [Objective], [Language], [Strengths], [Awards], [Hobbies]) VALUES (@Employee_ID, @Objective, @Language, @Strengths, @Awards, @Hobbies)"
            SelectCommand="SELECT [Employee_ID], [Objective], [Language], [Strengths], [Awards], [Hobbies], [Expected_Salary] FROM [Additional_Info]"
            UpdateCommand="UPDATE [Additional_Info] SET [Objective] = @Objective, [Language] = @Language, [Strengths] = @Strengths, [Awards] = @Awards, [Hobbies] = @Hobbies, [Expected_Salary] = @Expected_Salary WHERE [Employee_ID] = @Employee_ID">
            <DeleteParameters>
              <asp:Parameter Name="Employee_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
              <asp:Parameter Name="Objective" Type="String" />
              <asp:Parameter Name="Language" Type="String" />
              <asp:Parameter Name="Strengths" Type="String" />
              <asp:Parameter Name="Awards" Type="String" />
              <asp:Parameter Name="Hobbies" Type="String" />
              <asp:Parameter Name="Expected_Salary" Type="String" />
              <asp:Parameter Name="Employee_ID" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
              <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_objective" Name="Objective" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="DropDownList_language" Name="Language" PropertyName="SelectedValue"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_strengths" Name="Strengths" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_awards" Name="Awards" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_hobbies" Name="Hobbies" PropertyName="Text"
                    Type="String" />
            </InsertParameters>
          </asp:SqlDataSource>
          <br />
     
     
</td>
</tr>
</table>


  </asp:Content>