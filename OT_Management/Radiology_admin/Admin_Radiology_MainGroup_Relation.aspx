<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_Radiology_MainGroup_Relation.aspx.vb" Inherits="Admin_Radiology_MainGroup_Relation" %>


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
<table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                  <!--DWLayoutTable-->
                  
                  <tr>
                    <td width="21%" align="right" valign="middle"  style="height: 25px"><strong>&nbsp;Radiology Sub Group :&nbsp;</strong></td>
                              <td width="29%" valign="middle" style="height: 25px"><span style="width: 155px">
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="RSGName" DataValueField="RSGID" ID="DropDownListSGName" runat="server" Width="250px" DataSourceID="SqlDataSourceSubGroupname"> </asp:DropDownList>
                              </span></td>
                              <td width="27%" align="right" valign="middle" style="height: 25px"><strong >Area :&nbsp;</strong></td>
                              <td width="23%" valign="middle" style="height: 25px"><span style="width: 155px">
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="RadiologyName" DataValueField="RID" ID="DropDownListRadiology" runat="server" Width="250px" DataSourceID="SqlDataSourceRadiologyValue"> </asp:DropDownList>
                              </span></td>
                    </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><strong><span  style="width: 245px">Organ :&nbsp;</span></strong></td>
                      <td valign="middle"><span style="width: 155px">
                        <asp:DropDownList 
                            DataTextField="MG_Name" DataValueField="Radiology_id" ID="DropDownListMGName" runat="server" Width="250px" DataSourceID="SqlDataSourceMainGroup" AutoPostBack="True"> </asp:DropDownList>
                      </span></td>
                      <td valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="middle"></td>
                    </tr>
                 
                  
                  
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                </table><br /><div align="center"><asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1"  /></div><br />

<asp:SqlDataSource ID="SqlDataSourceSubGroupname" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT [RSGID], [RSGName] FROM [RadiologySubGroup]"> </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceRadiologyValue" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT RadiologyName, RID, RSGID FROM Radiology WHERE (RSGID = @RSGID)">
                    <SelectParameters>
                      <asp:ControlParameter ControlID="DropDownListSGName" Name="RSGID" PropertyName="SelectedValue" />
                    </SelectParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                                SelectCommand="SELECT [MG_Name], [Radiology_id] FROM [Admin_Radiology_MainGroup]"> </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                DeleteCommand="DELETE FROM Radiology_Exam_type_Relation WHERE (id = @id)"
                InsertCommand="INSERT INTO Radiology_Exam_type_Relation(RID, radiology_id) VALUES (@RID, @radiology_id)"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Radiology.RadiologyName, Admin_Radiology_MainGroup.MG_Name, Radiology_Exam_type_Relation.id FROM Admin_Radiology_MainGroup INNER JOIN Radiology_Exam_type_Relation ON Admin_Radiology_MainGroup.Radiology_id = Radiology_Exam_type_Relation.radiology_id INNER JOIN Radiology ON Radiology_Exam_type_Relation.RID = Radiology.RID WHERE (Radiology.RSGID = @RID)">
  <DeleteParameters>
    <asp:ControlParameter ControlID="GridView1" Name="id" PropertyName="SelectedValue" />
  </DeleteParameters>
  <SelectParameters>
    <asp:ControlParameter ControlID="DropDownListSGName" Name="RID" PropertyName="SelectedValue" />
  </SelectParameters>
  <InsertParameters>
    <asp:ControlParameter ControlID="DropDownListRadiology" Name="RID" PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="DropDownListMGName" Name="radiology_id" PropertyName="SelectedValue" />
  </InsertParameters>
</asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                CssClass="Grid_1" DataSourceID="SqlDataSourceSaveInfo"
                Width="100%" DataKeyNames="id">
  <Columns>
      <asp:TemplateField>
          <ItemTemplate>

            <script src="../../Validate.js" type="text/javascript"></script>

              <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                  OnClientClick="return confirmation(this)" />

          </ItemTemplate>
      </asp:TemplateField>
  <asp:BoundField DataField="RadiologyName" HeaderText="RadiologyName" SortExpression="RadiologyName" />
  <asp:BoundField DataField="MG_Name" HeaderText="MG_Name" SortExpression="MG_Name" />
  <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" SortExpression="id"
                                    Visible="False" />
  </Columns>
  <RowStyle CssClass="GridItem" />
  <HeaderStyle CssClass="GridHeader" />
  <AlternatingRowStyle CssClass="GridAltItem" />
  <EditRowStyle CssClass="Selected" />
</asp:GridView>

</div>
</form>
</body>
</html>

