<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Other_Documents, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.Misc.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebChart.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebChart" TagPrefix="igchart" %>


 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     
     


<div class="bxmain">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="41%" align="right">Attach Documents :</td>
    <td width="59%"> 
      <asp:FileUpload ID="FileUpload1" runat="server" Height="20px"
              Width="248px" />
    </td>
  </tr>
  <tr>
    <td align="right">
      Detail : 
    </td>
    <td> 
      <asp:TextBox ID="TextBox_Detail" runat="server" CssClass="input_txt" Width="300px" Height="65px" TextMode="MultiLine"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td> 
      <asp:Button ID="Button_Save" runat="server" Text="Save" />      
    </td>
  </tr>
   
</table>

 
 

 
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Certification] WHERE [Employee_ID] = @Employee_ID AND [Certification_ID] = @Certification_ID"
            InsertCommand="INSERT INTO Other_Documents(emp_ID, Image_name, Image_URL, Detail) VALUES (@emp_ID, @Image_name, @Image_URL, @Detail)"
            SelectCommand="SELECT Other_Documents_ID, emp_ID, Image_name, Image_URL, Detail FROM Other_Documents WHERE (emp_ID = @emp_ID)"
            UpdateCommand="UPDATE [Certification] SET [Certification] = @Certification, [Date_From] = @Date_From, [Date_To] = @Date_To, [Institution] = @Institution, [Detail] = @Detail WHERE [Employee_ID] = @Employee_ID AND [Certification_ID] = @Certification_ID">
      <DeleteParameters>
        <asp:Parameter Name="Employee_ID" Type="Int32" />
        <asp:Parameter Name="Certification_ID" Type="Int32" />
      </DeleteParameters>
      <UpdateParameters>
        <asp:Parameter Name="Certification" />
        <asp:Parameter Name="Date_From" />
        <asp:Parameter Name="Date_To" />
        <asp:Parameter Name="Institution" />
        <asp:Parameter Name="Detail" />
        <asp:Parameter Name="Employee_ID" />
        <asp:Parameter Name="Certification_ID" />
      </UpdateParameters>
      <SelectParameters>
          <asp:SessionParameter Name="emp_ID" SessionField="Enter_emp_ID" />
      </SelectParameters>
      <InsertParameters>
          <asp:SessionParameter Name="emp_ID" SessionField="Enter_emp_ID" />
          <asp:ControlParameter ControlID="HiddenField_fileName" Name="Image_name" PropertyName="Value" />
          <asp:ControlParameter ControlID="HiddenField_file_URL" Name="Image_URL" PropertyName="Value" />
          <asp:ControlParameter ControlID="TextBox_Detail" Name="Detail" PropertyName="Text" />
      </InsertParameters>
    </asp:SqlDataSource>
  <asp:TextBox ID="TextBox_Validity" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';" Visible="False"></asp:TextBox>

<br />
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" >
              
               
                <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
                <asp:HiddenField ID="HiddenField_fileName" runat="server" />
                <asp:HiddenField ID="HiddenField_file_URL" runat="server" />
			<br />
    <asp:Repeater ID="Repeater1" runat="server">
    </asp:Repeater>

</div>
    <asp:GridView ID="GridView2" runat="server" Width="100%">
        <Columns>
            <asp:HyperLinkField />
        </Columns>
    </asp:GridView>
     
</td>
</tr>
</table>

  </asp:Content>