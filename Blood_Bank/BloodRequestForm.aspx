<%@ page language="C#" autoeventwireup="true" inherits="BloodRequestForm, App_Web_ob4gay25" masterpagefile="~/hacims_masterpage.master" enableeventvalidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="../css_hacims/ck.js" type="text/javascript"></script>

 <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>



</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
                    <%--   
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server"></rsweb:ReportViewer>
    </div>--%>


 
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
      <tr>
<td class="leftnav" valign="top" >
        
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel2" runat="server" Visible="False"></asp:Panel></td>
      
        <td  style="width:auto;" valign="top" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%" valign="top"><asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                CssClass="Grid_1" DataKeyNames="Component_id" DataSourceID="SqlDataSource_Component"
                Width="100%" OnPreRender="GridView2_PreRender">
                            
                  <Columns>
                    <asp:BoundField DataField="Component_id" HeaderText="Component_id" InsertVisible="False"
                                    ReadOnly="True" SortExpression="Component_id" Visible="False" />
                    <asp:BoundField DataField="Component_Name" HeaderText="Component Name" SortExpression="Component_Name">
                      <ItemStyle CssClass="text_boxtitle" HorizontalAlign="Left" />                      </asp:BoundField>
                    <asp:BoundField DataField="Component_unit" HeaderText="Component_unit" SortExpression="Component_unit"
                                    Visible="False" />
                    <asp:TemplateField HeaderText="PINTS">
                      <ItemTemplate>
                        <asp:TextBox ID="TextBox_potency" runat="server" CssClass="input_txt" 
                              Width="56px" AutoPostBack="True" ontextchanged="TextBox_potency_TextChanged"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox_potency"
                                            ErrorMessage="*" ValidationExpression="\d{1,9}"></asp:RegularExpressionValidator>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("Component_unit", "{0}") %>'></asp:Label>
                        <asp:HiddenField ID="HiddenField_id" runat="server" Value='<%# Eval("Component_id", "{0}") %>' />
                      </ItemTemplate>
                            <ItemStyle  />              
                  </asp:TemplateField>
                    <asp:TemplateField HeaderText="ML">
                      <ItemStyle  />              
                      <ItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt" Width="56px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox1"
                              ErrorMessage="*" ValidationExpression="\d{1,9}"></asp:RegularExpressionValidator>
                      </ItemTemplate>
                  </asp:TemplateField>
      </Columns>
                 <RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />


                  
    </asp:GridView>

<br />

<asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                CssClass="Grid_1" DataKeyNames="Question_Id" DataSourceID="SqlDataSource_Questions"
                Height="1px" Width="100%" OnPreRender="GridView1_PreRender">
                           
                  <Columns>
                    <asp:BoundField DataField="Question_Id" HeaderText="Question_Id" InsertVisible="False"
                        ReadOnly="True" SortExpression="Question_Id" Visible="False" />
                    <asp:BoundField DataField="Question_Text" HeaderText="Questions" SortExpression="Question_Text" >
                      <ItemStyle CssClass="text_boxtitle" HorizontalAlign="Left" />                      </asp:BoundField>
                    <asp:BoundField DataField="Question_Option_1" HeaderText="Question_Option_1" SortExpression="Question_Option_1" Visible="False" />
                    <asp:BoundField DataField="Question_Option_2" HeaderText="Question_Option_2" SortExpression="Question_Option_2" Visible="False" />
                    <asp:TemplateField>
                      <ItemTemplate>
                        <asp:RadioButton ID="RadioButton_yes" runat="server" GroupName="option" />              
                        <asp:Label ID="Label1" runat="server" CssClass="text_labels_two" Text='<%# Eval("Question_Option_1") %>'></asp:Label>
                        <asp:RadioButton ID="RadioButton_No" runat="server" GroupName="option" />              
                        <asp:Label ID="Label2" runat="server" CssClass="text_labels_two" Text='<%# Eval("Question_Option_2") %>'></asp:Label>
                        <asp:HiddenField ID="HiddenField_id" runat="server" Value='<%# Eval("Question_Id", "{0}") %>' />
                      </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />              
                  </asp:TemplateField>
      </Columns>
                <RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />
        
    </asp:GridView></td>
    
    
    <td width="50%" valign="top">
   
   
<div class="bxmain" style="margin-left:10px; width:96%;">
    <p>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" >
 
    <tr>
        <td align="right" width="35%">
            Blood Group :</td>
        <td width="65%">
            <asp:Label ID="Label_BloodGroup" runat="server" Text="  " CssClass="red"></asp:Label></td>
    </tr>
  <tr>
    <td align="right">Blood Bag :&nbsp; </td>
    <td ><asp:TextBox ID="TextBox_bags" Enabled="false" runat="server" OnTextChanged="TextBox_bags_TextChanged" CssClass="input_txt" Width="50px" ></asp:TextBox><strong>&nbsp;Quantity</strong>&nbsp;
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_bags"
ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
</td>
  </tr>
  <tr>
    <td align="right">When Need :&nbsp; </td>
    <td><asp:TextBox ID="TextBox_when_Need" TextMode="Date" runat="server" CssClass="input_txt" ></asp:TextBox>
       
                  <asp:Label ID="Label5" runat="server" CssClass="err" ></asp:Label>
        <asp:DataList ID="DataList_DateWhen" runat="server" OnSelectedIndexChanged="DataList_DateWhen_SelectedIndexChanged"
            RepeatDirection="Horizontal" RepeatLayout="Flow" >
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton_Date" runat="server" Text='<%# Eval("ExpectedOPDate") %>' CommandName="select"></asp:LinkButton>
            </ItemTemplate>
        </asp:DataList></td>
  </tr>
  <tr>
    <td align="right">Sample No :&nbsp;</td>
    <td><asp:Label ID="Label_sample_No" runat="server" CssClass="err" ></asp:Label>
        </td>
  </tr>
</table></p>

</div>
<br />

   <div align="center" ><asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Save" />              
                        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click"  Text="Cancel"  CausesValidation="False"/>              </div> 

    </td>
  </tr>
</table>

<br />
                  <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                CssClass="Grid_1" DataKeyNames="Blood_Request_Id" DataSourceID="SqlDataSource_blood_waiting_List"
                OnPreRender="GridView3_PreRender" PageSize="15" Width="100%">
                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />              
                    <Columns>
                      <asp:BoundField DataField="Blood_Request_Id" HeaderText="Blood_Request_Id" InsertVisible="False"
                        ReadOnly="True" SortExpression="Blood_Request_Id" Visible="False" />
                      <asp:BoundField DataField="Registration_No" HeaderText="Registration_No" SortExpression="Registration_No"
                        Visible="False" />
                      <asp:BoundField DataField="Yearly_No" HeaderText="Yearly_No" SortExpression="Yearly_No"
                        Visible="False" />
                        <asp:BoundField DataField="Prefix" HeaderText="Prefix" SortExpression="Prefix" />
                        <asp:BoundField DataField="PFName" HeaderText="PFName" SortExpression="PFName" />
                        <asp:BoundField DataField="pmname" HeaderText="pmname" SortExpression="pmname" />
                        <asp:BoundField DataField="plname" HeaderText="plname" SortExpression="plname" />
                      <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
                      <asp:BoundField DataField="Relation1" HeaderText="Relation Name" ReadOnly="True"
                        SortExpression="Relation1" />
                      <asp:BoundField DataField="Data_Time" HeaderText="Date &amp; Time" ReadOnly="True"
                        SortExpression="Relation1" />
                      <asp:BoundField DataField="Sample_No" HeaderText="Sample No" ReadOnly="True" SortExpression="Relation1" />
                      <asp:BoundField DataField="Bag_Qty" HeaderText="Bag Qty" ReadOnly="True" SortExpression="Bag_Qty" />
                        <asp:BoundField DataField="BloodGroup" HeaderText="BloodGroup" SortExpression="BloodGroup" />
                    </Columns>
                  <RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />
         
    </asp:GridView>
  </ContentTemplate>
</asp:UpdatePanel>

                  <asp:SqlDataSource ID="SqlDataSource_blood_waiting_List" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="BloodBank_Patient_Order" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                    <SelectParameters>
                      <asp:Parameter DefaultValue="10" Name="request_type_id" Type="Int32" />
                        <asp:SessionParameter DefaultValue="" Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
                        <asp:SessionParameter Name="Registration_No" SessionField="registrationno" Type="String" />
                    </SelectParameters>
    </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_bags_detail" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                    SelectCommand="SELECT Donor_Detail.Prefix + ' ' + Donor_Detail.First_Name + ' ' + Donor_Detail.Middle_Name AS [Donor Name], Donor_Detail.Relation, Donor_Detail.Relation_First_Name + ' ' + Donor_Detail.Relation_Middle_Name AS [Relation Name], Donor_Transfusion_Detail.Bag_No AS [Bag No], Donor_Blood_Group_Marked.Group_Name + ' ' + Donor_Blood_Group_Marked.Rh_Factor AS [Blood Group], Donor_Transfusion_Detail.Patient_Registration_No FROM Donor_Transfusion_Detail INNER JOIN Donor_Bags ON Donor_Transfusion_Detail.Bag_No = Donor_Bags.Bag_No INNER JOIN Donor_Detail ON Donor_Bags.Donor_Registration_No = Donor_Detail.Donor_Registration_No INNER JOIN Donor_Blood_Group_Marked ON Donor_Detail.Donor_Registration_No = Donor_Blood_Group_Marked.Donor_Registration_No WHERE (Donor_Transfusion_Detail.Patient_Registration_No = @Patient_Registration_No)" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                    <SelectParameters>
                      <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="Patient_Registration_No"
                            PropertyName="Value" />
                    </SelectParameters>
    </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_Component" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT [Component_id], [Component_Name], [Component_unit] FROM [Blood_Component]" OnSelecting="SqlDataSource_Component_Selecting" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"> </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_Component_Insert" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                InsertCommand="BloodBank_Request_Component_mark" InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                    <InsertParameters>
                      <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Blood_Request_Id"
                            PropertyName="Value" Type="Int32" />
                      <asp:ControlParameter ControlID="HiddenField_Comp_Id" Name="Component_id" PropertyName="Value"
                            Type="Int32" />
                      <asp:ControlParameter ControlID="HiddenField_Comp_Potency" Name="PotencyML" PropertyName="Value"
                            Type="String" />
                             <asp:Parameter DefaultValue="400" Name="Potency"  Type="String" />
                        <asp:Parameter DefaultValue="ML" Name="Unit" Type="String"  />
                        <asp:Parameter DefaultValue="1" Name="Qty" Type="Int32"  />
                    </InsertParameters>
    </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_forward" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                InsertCommand="pt_bloodBank_PatientForward" InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
                    <InsertParameters>
                      <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="RegNo" PropertyName="Value"
                        Type="String" />
                      <asp:ControlParameter ControlID="HiddenField_Emp_Id" Name="EmpID" PropertyName="Value"
                        Type="Int32" />
                      <asp:ControlParameter ControlID="HiddenField_Yearly_No" Name="PayID" PropertyName="Value"
                        Type="Decimal" />
                      <asp:Parameter DefaultValue="17" Name="ToSubDept" Type="Int32" />
                      <asp:ControlParameter ControlID="HiddenField_Dept_Id" DefaultValue="" Name="SendingDept"
                        PropertyName="Value" Type="Int32" />
                      <asp:Parameter DefaultValue="10" Name="iRequestTypeTo" Type="Int32" />
                      <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="dumypointer"
                    PropertyName="Value" Type="Int32" />
                    </InsertParameters>
    </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_Question_Insert" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                InsertCommand="BloodBank_Request_Question_mark" InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                    <InsertParameters>
                      <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Blood_Request_Id"
                        PropertyName="Value" Type="Int32" />
                      <asp:ControlParameter ControlID="HiddenField_Question_Id" Name="Question_Id" PropertyName="Value"
                        Type="Int32" />
                      <asp:ControlParameter ControlID="HiddenField_Question_Ans" Name="Question_Ans" PropertyName="Value"
                        Type="Boolean" />
                    </InsertParameters>
    </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_Questions" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT [Question_Id], [Question_Text], [Question_Option_1], [Question_Option_2] FROM [Blood_Question]" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"> </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenField_Yearly_No" runat="server" />
                  <asp:HiddenField ID="HiddenField_Emp_Id" runat="server" />
                  <asp:HiddenField ID="HiddenField_Dept_Id" runat="server" />
                  <asp:HiddenField ID="HiddenField_Comp_Id" runat="server" />
                  <asp:HiddenField ID="HiddenField_Comp_Potency" runat="server" />
                  <asp:HiddenField ID="HiddenField_Question_Id" runat="server" />
                  <asp:HiddenField ID="HiddenField_Question_Ans" runat="server" />
                  <asp:HiddenField ID="HiddenField_Blood_Request_Id" runat="server" />
                  <asp:HiddenField ID="HiddenField_Registration_No" runat="server" /><br />

<asp:Label CssClass="err" ID="Label_Error" runat="server"></asp:Label><asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" /><br />
<br />
</td></tr></table>

 
<asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>
  </asp:Content>