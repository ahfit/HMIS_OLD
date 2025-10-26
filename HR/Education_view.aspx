<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Education_view, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     


<asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False"
      DataKeyNames="Employee_ID,Degree_Program_ID" DataSourceID="SqlDataSource1" 
      Width="100%" CssClass="Grid_1">
      <Fields>
          <asp:BoundField DataField="Majors" HeaderText="Majors" SortExpression="Majors" />
          <asp:BoundField DataField="Recognized_Institute" HeaderText="Recognized Institute"
              SortExpression="Recognized_Institute" />
          <asp:TemplateField HeaderText="From Date" SortExpression="From_Date">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("From_Date") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("From_Date") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Bind("From_Date") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="To Date" SortExpression="To_Date">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("To_Date") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("To_Date") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Bind("To_Date") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="Degree_Verified_By" HeaderText="Degree Verified By" SortExpression="Degree_Verified_By" />
          <asp:TemplateField HeaderText="Verification Sent Date" SortExpression="Verification Sent Date">
              <EditItemTemplate>
                  <asp:TextBox ID="txtVerification_Sent_Date" runat="server" Text='<%# Eval("Verification_Sent_Date") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="txtVerification_Sent_Date" runat="server" Text='<%# Bind("Verification_Sent_Date") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="lblVerification_Sent_Date" runat="server" Text='<%# Bind("Verification_Sent_Date") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Verification Received date" SortExpression="Verification_Received_date">
              <EditItemTemplate>
                  <asp:TextBox ID="txtVerification_Received_date" runat="server" Text='<%# Eval("Verification_Received_date") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                  <asp:TextBox ID="txtVerification_Received_date" runat="server" Text='<%# Bind("Verification_Received_date") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="lblVerification_Received_date" runat="server" Text='<%# Bind("Verification_Received_date") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="Verification_Status" HeaderText="Verification Status" SortExpression="Verification_Status" />
          <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
          <asp:BoundField DataField="Grade" HeaderText="Grade" SortExpression="Grade" />
          <asp:BoundField DataField="CGPA" HeaderText="CGPA" SortExpression="CGPA" />
          <asp:CheckBoxField DataField="Distinction" HeaderText="Distinction" SortExpression="Distinction" />
          <asp:BoundField DataField="number" HeaderText="Obtained Marks" SortExpression="number" />
          <asp:BoundField DataField="total" HeaderText="Total Marks" SortExpression="total" />
          <asp:BoundField DataField="Research_Work" HeaderText="Research Work" SortExpression="Research_Work" />
          <asp:TemplateField>
              <EditItemTemplate>
                  <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                      ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
              </EditItemTemplate>
              <ItemTemplate>
                  <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                      OnClientClick="return confirmation_edit(this)" />&nbsp;<asp:ImageButton ID="ImageButton2"
                          runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif" OnClientClick="return confirmation(this)" />
              </ItemTemplate>
          </asp:TemplateField>
      </Fields>
      <RowStyle CssClass="GridItem" />
      <AlternatingRowStyle CssClass="GridAltItem" />
  </asp:DetailsView>

    <asp:HiddenField ID="HiddenField_fromDate" runat="server" />
    <asp:HiddenField ID="HiddenField_todate" runat="server" />
    <asp:HiddenField ID="hfldVerSentDate" runat="server" />
    <asp:HiddenField ID="hfldVerRecDate" runat="server" />
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Education] WHERE [Employee_ID] = @Employee_ID AND [Degree_Program_ID] = @Degree_Program_ID"
            InsertCommand="INSERT INTO [Education] ([Employee_ID], [Degree_Program_ID], [Majors], [Recognized_Institute], [From_Date], [To_Date], [Grade], [CGPA], [Distinction], [number], [total], [Research_Work], [Qualification_Id]) VALUES (@Employee_ID, @Degree_Program_ID, @Majors, @Recognized_Institute, @From_Date, @To_Date, @Grade, @CGPA, @Distinction, @number, @total, @Research_Work, @Qualification_Id)"
            SelectCommand="SELECT [Employee_ID], [Degree_Program_ID], [Majors], [Recognized_Institute], convert(varchar,[From_Date],103) as [From_Date], convert(varchar,[To_Date],103) as [To_Date], [Grade], [CGPA], [Distinction], [number], [total], [Research_Work], [Qualification_Id],Degree_Verified_By,convert(varchar,[Verification_Sent_Date],103) as [Verification_Sent_Date],convert(varchar,[Verification_Received_date],103) as [Verification_Received_date],Verification_Status,Remarks FROM [Education]&#13;&#10;Where Employee_ID=@employee_ID and Degree_Program_ID=@Degree_Program_ID"
            UpdateCommand="UPDATE [Education] SET [Majors] = @Majors, [Recognized_Institute] = @Recognized_Institute, [From_Date] = @From_Date, [To_Date] = @To_Date, [Grade] = @Grade, [CGPA] = @CGPA, [Distinction] = @Distinction, [number] = @number, [total] = @total, [Research_Work] = @Research_Work, [Qualification_Id] = @Qualification_Id, Degree_Verified_By=@Degree_Verified_By,Verification_Sent_Date=@Verification_Sent_Date,Verification_Received_date=@Verification_Received_date,Verification_Status=@Verification_Status,Remarks=@Remarks WHERE [Employee_ID] = @Employee_ID AND [Degree_Program_ID] = @Degree_Program_ID">
            <DeleteParameters>
                <asp:Parameter Name="Employee_ID" Type="Int32" />
                <asp:Parameter Name="Degree_Program_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Majors" Type="String" />
                <asp:Parameter Name="Recognized_Institute" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_fromDate" Name="From_Date" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenField_todate" Name="To_Date" PropertyName="Value"
                    Type="DateTime" />
                <asp:Parameter Name="Grade" Type="String" />
                <asp:Parameter Name="CGPA" Type="Double" />
                <asp:Parameter Name="Distinction" Type="Boolean" />
                <asp:Parameter Name="number" Type="Int32" />
                <asp:Parameter Name="total" Type="Int32" />
                <asp:Parameter Name="Research_Work" Type="String" />
                <asp:Parameter Name="Qualification_Id" Type="Int32" />
                <asp:Parameter Name="Employee_ID" Type="Int32" />
                <asp:Parameter Name="Degree_Program_ID" Type="Int32" />
                <asp:Parameter Name="Degree_Verified_By"  />
                <asp:ControlParameter ControlID="hfldVerSentDate" Name="Verification_Sent_Date" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter ControlID="hfldVerRecDate" Name="Verification_Received_date" PropertyName="Value"
                    Type="DateTime" />
                <asp:Parameter Name="Verification_Status" />
                <asp:Parameter Name="Remarks" />
            </UpdateParameters>
            <InsertParameters>
                <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_Degree_Program" Name="Degree_Program_ID"
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_majors" Name="Majors" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Institute" Name="Recognized_Institute" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField__from_Date" Name="From_Date" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter ControlID="HiddenField_To_Date" Name="To_Date" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter ControlID="DropDownList_grade" Name="Grade" PropertyName="SelectedValue"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_cgpa" Name="CGPA" PropertyName="Text" Type="Double" />
                <asp:ControlParameter ControlID="RadioButtonList_distinction" Name="Distinction"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_Obtained_Marks" Name="number" PropertyName="Text"
                    Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_Total_Marks" Name="total" PropertyName="Text"
                    Type="Int32" />
                <asp:ControlParameter Name="Research_Work" Type="String" ControlID="TextBox_Research_Work" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_Qualification" Name="Qualification_Id"
                    PropertyName="SelectedValue" Type="Int32" />
            </InsertParameters>
              <SelectParameters>
                  <asp:QueryStringParameter Name="employee_ID" QueryStringField="Employee_ID" />
                  <asp:QueryStringParameter Name="Degree_Program_ID" QueryStringField="Degree_Program_ID" />
              </SelectParameters>
          </asp:SqlDataSource>
     
     
</td>
</tr>
</table>
<br />
  </asp:Content>