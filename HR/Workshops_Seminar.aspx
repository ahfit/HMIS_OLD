<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Workshops_Seminar, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
     
     


<div class="bxmain">

<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form">
  <tr>
    <td width="40%" align="right">Workshop/Seminar :</td>
    <td width="60%">  
        <asp:TextBox ID="TextBox_workshop_Seminar" runat="server" CssClass="input_txt"   ></asp:TextBox>
       </td>
  </tr>
  <tr>
    <td align="right"> 
   Venue :
    </td>
    <td>
      <asp:TextBox ID="TextBox_venue" runat="server" CssClass="input_txt"   ></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">Date : 
       
        
       </td>
    <td><igsch:webdatechooser id="WebDateChooser_date" runat="server" Width="202px" NullDateLabel="1/1/2007" Value="2007-01-01"></igsch:webdatechooser>
        <asp:HiddenField ID="HiddenField_date" runat="server" /></td>
  </tr>
  <tr>
    <td align="right">Duration in Days : </td>
    <td>
      <asp:DropDownList ID="DropDownList_days"
              runat="server" Width="100px" CssClass="dropbox">
        <asp:ListItem>1</asp:ListItem>
        <asp:ListItem>2</asp:ListItem>
        <asp:ListItem>3</asp:ListItem>
        <asp:ListItem>4</asp:ListItem>
        <asp:ListItem>5</asp:ListItem>
        <asp:ListItem>6</asp:ListItem>
        <asp:ListItem>7</asp:ListItem>
        <asp:ListItem>8</asp:ListItem>
        <asp:ListItem>9</asp:ListItem>
        <asp:ListItem>10</asp:ListItem>
        <asp:ListItem>11</asp:ListItem>
        <asp:ListItem>12</asp:ListItem>
        <asp:ListItem>13</asp:ListItem>
        <asp:ListItem>14</asp:ListItem>
        <asp:ListItem>15</asp:ListItem>
      </asp:DropDownList>
    </td>
  </tr>
  <tr>
    <td align="right">Organized By : </td>
    <td>
      <asp:TextBox ID="TextBox_organized_BY" runat="server" CssClass="input_txt"   ></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">Attach :</td>
    <td>
      <asp:FileUpload ID="FileUpload1" runat="server" Height="20px" Width="250px" />
    </td>
  </tr>
  <tr>
    <td align="right">Detail  :</td>
    <td>
      <asp:TextBox ID="TextBox_Description" runat="server" CssClass="input_txt"  Width="300px" Height="65px" TextMode="MultiLine"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td>
      <asp:Button CssClass="btn1"  ID="Button_Save" runat="server" Text="Save" />      
    </td>
  </tr>
</table>

 </div>

<br />
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  
                    DataKeyNames="Employee_ID,Workshop_Seminar_ID" DataSourceID="SqlDataSource1"
                    Width="100%">
                    <Columns>
                        <asp:BoundField DataField="Workshop_Seminar" HeaderText="Workshop Seminar" SortExpression="Workshop_Seminar">
                            <ControlStyle CssClass="txt_inside" Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Venue" HeaderText="Venue" SortExpression="Venue">
                            <ControlStyle CssClass="txt_inside" Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date">
                            <ControlStyle CssClass="txt_inside" Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Duration_in_Days" HeaderText="Duration in Days" SortExpression="Duration_in_Days">
                            <ControlStyle CssClass="txt_inside" Width="25px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Organized_By" HeaderText="Organized By" SortExpression="Organized_By">
                            <ControlStyle CssClass="txt_inside" Width="75px" />
                        </asp:BoundField>
                        <asp:HyperLinkField DataNavigateUrlFields="Image_URL" DataNavigateUrlFormatString="Documents/{0}"
                            DataTextField="Image_name" HeaderText="Images" Target="_blank" />
                        <asp:HyperLinkField DataNavigateUrlFields="Workshop_Seminar_ID,Employee_ID" DataNavigateUrlFormatString="~/HR/Workshops_Seminar_view.aspx?Workshop_Seminar_ID={0}&amp;Employee_ID={1}"
                            HeaderText="View Detail" Text="View Detail" />
                    </Columns>
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView><br />

          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Workshops_Seminar] WHERE [Employee_ID] = @Employee_ID AND [Workshop_Seminar_ID] = @Workshop_Seminar_ID"
            InsertCommand="INSERT INTO Workshops_Seminar(Employee_ID, Workshop_Seminar, Venue, Date, Duration_in_Days, Organized_By, Description, Image_name, Image_URL) VALUES (@Employee_ID, @Workshop_Seminar, @Venue, @Date, @Duration_in_Days, @Organized_By, @Description, @Image_name, @Image_URL)"
            SelectCommand="SELECT Employee_ID, Workshop_Seminar_ID, Workshop_Seminar, Venue, CONVERT (varchar, Date, 103) AS Date, Duration_in_Days, Organized_By, Description, Image_name, Image_URL FROM Workshops_Seminar WHERE (Employee_ID = @emp)"
            UpdateCommand="UPDATE [Workshops_Seminar] SET [Workshop_Seminar] = @Workshop_Seminar, [Venue] = @Venue, [Date] = @Date, [Duration_in_Days] = @Duration_in_Days, [Organized_By] = @Organized_By, [Description] = @Description WHERE [Employee_ID] = @Employee_ID AND [Workshop_Seminar_ID] = @Workshop_Seminar_ID">
            <DeleteParameters>
              <asp:Parameter Name="Employee_ID" Type="Int32" />
              <asp:Parameter Name="Workshop_Seminar_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
              <asp:Parameter Name="Workshop_Seminar" Type="String" />
              <asp:Parameter Name="Venue" Type="String" />
              <asp:Parameter Name="Date" Type="DateTime" />
              <asp:Parameter Name="Duration_in_Days" Type="Int32" />
              <asp:Parameter Name="Organized_By" Type="String" />
              <asp:Parameter Name="Description" Type="String" />
              <asp:Parameter Name="Employee_ID" Type="Int32" />
              <asp:Parameter Name="Workshop_Seminar_ID" Type="Int32" />
            </UpdateParameters>
            <SelectParameters>

              <asp:SessionParameter Name="emp" SessionField="enter_emp_ID" />
            </SelectParameters>
            <InsertParameters>
              <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_workshop_Seminar" Name="Workshop_Seminar"
                    PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="TextBox_venue" Name="Venue" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="HiddenField_date" Name="Date" PropertyName="Value"
                    Type="DateTime" />
              <asp:ControlParameter ControlID="DropDownList_days" Name="Duration_in_Days"
                    PropertyName="SelectedValue" Type="Int32" />
              <asp:ControlParameter ControlID="TextBox_organized_BY" Name="Organized_By" PropertyName="Text"
                    Type="String" />
              <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_fileName" Name="Image_name" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_file_URL" Name="Image_URL" PropertyName="Value" />
            </InsertParameters>
          </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_fileName" runat="server" />
                <asp:HiddenField ID="HiddenField_file_URL" runat="server" /><br />
     
</td>
</tr>
</table>

  </asp:Content>