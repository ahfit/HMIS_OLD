<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_main_group.aspx.vb" Inherits="Admin_main_group" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="../../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../../images/sheet_form.css" rel="stylesheet" type="text/css" />
<script src="../../images/highlight.js" type="text/javascript"></script>
<style type="text/css">
body {
	background-image:none;
	margin-top:0px;
}
html {
	background-image:none;
}
</style>



</head>

<body >

<form id="form1" runat = "server">
 <div id="forms_items" class="forms_items"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" >
      <!--DWLayoutTable-->
      <tr>
        <td width="298" height="24" align="left" valign="middle" class="border_gray"><span ><strong>&nbsp;Organ
          <asp:Label CssClass="text_lables_login" ID="LabelMainGroup" runat="server" ></asp:Label>
        </strong></span></td>
      </tr>
      <tr>
        <td height="35" align="left" valign="middle">&nbsp;&nbsp;
          <asp:TextBox CssClass="d-active" ID="TextBoxMainGroup" runat="server" Width="171px"></asp:TextBox>
          <asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Save" /></td>
      </tr>
      <tr>
        <td height="25" align="left" valign="middle" >&nbsp;&nbsp;
          <asp:DropDownList AutoPostBack="True"  DataTextField="MG_Name" DataValueField="Radiology_ID" ID="DropDownListMainGroup" runat="server" Width="179px" DataSourceID="SqlDataSourceMainGroup"> </asp:DropDownList>
          <br />
          <span style="width: 16px">
            <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>" InsertCommand="INSERT INTO admin_Radiology_MainGroup(MG_Name) VALUES (@MG_Name)" SelectCommand="SELECT MG_Name, Radiology_ID FROM Admin_Radiology_MainGroup
">
              <InsertParameters>
                <asp:ControlParameter ControlID="TextBoxMainGroup" Name="MG_Name" PropertyName="Text" />
              </InsertParameters>
            </asp:SqlDataSource>
          </span></td>
      </tr>
      <tr>
        <td height="32"></td>
      </tr>
    </table></td>
    <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" >
      <!--DWLayoutTable-->
      <tr>
        <td width="298" height="24" align="left" valign="middle" class="border_gray"><strong >&nbsp;Area <span style="width: 111px; height: 50px">
          <asp:Label CssClass="text_lables_login" ID="Labelelement" runat="server" ></asp:Label>
        </span></strong></td>
      </tr>
      <tr>
        <td height="36" valign="middle"><span style="width: 111px; height: 50px"> &nbsp;&nbsp;
          <asp:TextBox CssClass="d-active" ID="TextBoxElement" runat="server" Width="190px"></asp:TextBox>
        </span></td>
      </tr>
      <tr>
        <td valign="middle" style="height: 23px"><span style="width: 111px; height: 50px"> &nbsp;&nbsp;
          <asp:DropDownList  DataTextField="DataTye" DataValueField="DataTye" ID="DropDownListType" runat="server" Width="195px" DataSourceID="SqlDataSourceType"> </asp:DropDownList>
          <asp:LinkButton CssClass="back_link" ID="LinkButton1" runat="server" >Detail</asp:LinkButton>
        </span></td>
      </tr>
      <tr>
        <td height="25" valign="middle"><span style="width: 111px"> &nbsp;&nbsp;
          <asp:DropDownList AutoPostBack="True"  DataTextField="Rd_element_name" DataValueField="Rd_element_id" ID="DropDownListElement" runat="server" Width="196px" DataSourceID="SqlDataSourceElement"> </asp:DropDownList>
          <asp:SqlDataSource ID="SqlDataSourceElement" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>" InsertCommand="INSERT INTO Admin_Radiology_Element(Rd_element_name, rd_element_type, Radiology_id) VALUES (@Rd_element_name, @rd_element_type, @Radiology_id)" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="Select Rd_element_id, Rd_element_name FROM  Admin_Radiology_Element WHERE (Radiology_ID = @MG_Code)">
            <SelectParameters>
              <asp:ControlParameter ControlID="DropDownListMainGroup" Name="MG_Code" PropertyName="SelectedValue" />
            </SelectParameters>
            <InsertParameters>
              <asp:ControlParameter ControlID="TextBoxElement" Name="Rd_element_name" PropertyName="Text" />
              <asp:ControlParameter ControlID="DropDownListElement" Name="rd_element_type" PropertyName="SelectedValue" />
              <asp:ControlParameter ControlID="DropDownListMainGroup" Name="Radiology_id" PropertyName="SelectedValue" />
            </InsertParameters>
          </asp:SqlDataSource>
          <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                        SelectCommand="SELECT [DataTye] FROM [Admin_ASP_Controls]"></asp:SqlDataSource>
          <span style="width: 111px; height: 50px">
            <asp:Button CssClass="btn1" ID="Button2" runat="server" Text="Save" />        
          </span></span></td>
      </tr>
      <tr>
        <td style="height: 6px"></td>
      </tr>
    </table></td>
    <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" >
      <!--DWLayoutTable-->
      <tr>
        <td width="296" height="24" align="left" valign="middle" class="border_gray"><strong >&nbsp;Value </strong></td>
      </tr>
      <tr>
        <td height="37" valign="middle">&nbsp;&nbsp;
          <asp:TextBox CssClass="d-active" ID="TextBoxElementValue" runat="server" Width="171px"></asp:TextBox>
          <asp:Button CssClass="btn1" ID="Button3" runat="server" Text="Save" /></td>
      </tr>
      <tr>
        <td height="35" valign="top"><span style="width: 100px">
          <asp:SqlDataSource ID="SqlDataSourceValue" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                        InsertCommand="INSERT INTO Admin_rd_exam_Elementvalue(Rd_Code, Rd_id, Rd_value) VALUES (@e_Code, @MG_Code, @ev_Value)"
                        ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
            <InsertParameters>
              <asp:ControlParameter ControlID="DropDownListElement" Name="e_Code" PropertyName="SelectedValue" />
              <asp:ControlParameter ControlID="DropDownListMainGroup" Name="MG_Code" PropertyName="SelectedValue" />
              <asp:ControlParameter ControlID="TextBoxElementValue" Name="ev_Value" PropertyName="Text" />
            </InsertParameters>
          </asp:SqlDataSource>
        </span></td>
      </tr>
      <tr>
        <td height="20"></td>
      </tr>
    </table></td>
  </tr>
</table>
<br />

                    <asp:GridView ID="GridViewMain" runat="server" AutoGenerateColumns="False" DataKeyNames="Radiology_id"
                        DataSourceID="SqlDataSourceForGrid" Width="100%" CssClass="Grid_1">
                        <Columns>
                            <asp:BoundField DataField="MG_Name" HeaderText="Organ" SortExpression="MG_Name" />
                            <asp:BoundField DataField="Rd_element_name" HeaderText="Element" SortExpression="Rd_element_name" />
                            <asp:BoundField DataField="rd_element_type" HeaderText="Element Type" SortExpression="rd_element_type" />
                            <asp:BoundField DataField="ToolTip" HeaderText="ToolTip" SortExpression="ToolTip" />
                            <asp:BoundField DataField="priority" HeaderText="Priority" SortExpression="priority" />
                            <asp:BoundField DataField="Rd_element_id" HeaderText="Rd_element_id" SortExpression="Rd_element_id" Visible="False" />
                            <asp:BoundField DataField="Rd_value" HeaderText="Rd_value" SortExpression="Rd_value" Visible="False" />
                            <asp:BoundField DataField="Text_BeforeElement" HeaderText="Text Before Element" SortExpression="Text_BeforeElement" />
                            <asp:BoundField DataField="Text_AfterElement" HeaderText="Text After Element" SortExpression="Text_AfterElement" />
                            <asp:BoundField DataField="Group_para_Start" HeaderText="Start of Para" SortExpression="Group_para_Start" />
                            <asp:BoundField DataField="Report_Sub_Group" HeaderText="Report Sub Group" SortExpression="Report_Sub_Group" />
                          
                        </Columns>    <EditRowStyle CssClass="GridItem" />
                  <HeaderStyle CssClass="GridHeader" />                
                  <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT Admin_Radiology_Element.Rd_element_name, Admin_Radiology_Elementvalue.Rd_element_id, Admin_Radiology_Elementvalue.Rd_value, Admin_Radiology_MainGroup.Radiology_id, Admin_Radiology_MainGroup.MG_Name, Admin_Radiology_Element.priority, Admin_Radiology_Element.ToolTip, Admin_Radiology_Element.rd_element_type, Admin_Radiology_Element.Text_BeforeElement, Admin_Radiology_Element.Text_AfterElement, Admin_Radiology_Element.Group_para_Start, Admin_Radiology_Element.Report_Sub_Group FROM Admin_Radiology_Element INNER JOIN Admin_Radiology_Elementvalue ON Admin_Radiology_Element.Rd_element_id = Admin_Radiology_Elementvalue.Rd_element_id INNER JOIN Admin_Radiology_MainGroup ON Admin_Radiology_Element.Radiology_id = Admin_Radiology_MainGroup.Radiology_id WHERE (Admin_Radiology_Element.Radiology_id = @Radiology_ID) AND (Admin_Radiology_Elementvalue.Rd_element_id = @Rd_Code)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownListMainGroup" DefaultValue="" Name="Radiology_ID"
                                    PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownListElement" DefaultValue="" Name="Rd_Code"
                                    PropertyName="SelectedValue" />
                              </SelectParameters>
                                                    </asp:SqlDataSource><br />
<br />

</div>
</form>
</body>
</html>

