<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_Radiology_Examtype_Relation.aspx.vb" Inherits="Administrator_Admin_Radiology_Examtype_Relation" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

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
                            <td width="138" height="37" align="right" valign="middle" ><strong>&nbsp;Sub Group Name   :&nbsp; </strong></td>
                              <td width="200" valign="middle"><span style="width: 155px">
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="RSGName" DataValueField="RSGID" ID="DropDownListSGName" runat="server" Width="175px" DataSourceID="SqlDataSourceSubGroupname"> </asp:DropDownList>
                              </span></td>
                              <td width="78" align="right" valign="middle"><strong >&nbsp;Value   :&nbsp;</strong></td>
                              <td width="297" valign="middle"><span style="width: 155px">
                                <asp:DropDownList 
                            DataTextField="RadiologyName" DataValueField="RID" ID="DropDownListRadiologyName" runat="server" Width="250px" DataSourceID="SqlDataSourceRadiologyValue"> </asp:DropDownList>
                              </span></td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle"><span  style="width: 245px"><strong>Exame Type   :</strong>&nbsp; </span></td>
                              <td colspan="2" valign="middle"><span style="width: 155px">
                                <asp:DropDownList 
                            DataTextField="radiology_type" DataValueField="radiology_id" ID="DropDownListExamType" runat="server" Width="175px" DataSourceID="SqlDataSourceExamType"> </asp:DropDownList>
                              </span></td>
                              <td valign="middle"><span style="height: 19px">
                                                              
                              </span></td>
      </tr>
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                        </table><br />
<div align="center"><asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="bt1up" /></div>
                        <br />
<asp:SqlDataSource ID="SqlDataSourceSubGroupname" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT RSGID, RSGName FROM RadiologySubGroup"> </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceRadiologyValue" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT RID, RadiologyName, RSGID FROM Radiology WHERE (RSGID = @RSGID)">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListSGName" Name="RSGID" PropertyName="SelectedValue" />
                            </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceExamType" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT radiology_id, radiology_type FROM radiology_exam_type"> </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                DeleteCommand="DELETE FROM Radiology_Exam_type_Relation WHERE (RID = @RID) AND (radiology_id = @Radiology_id)"
                InsertCommand="INSERT INTO Radiology_Exam_type_Relation(RID, radiology_id) VALUES (@RID, @radiology_id)"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Radiology.RadiologyName, RadiologySubGroup.RSGName, radiology_exam_type.radiology_type, Radiology_Exam_type_Relation.radiology_id, Radiology_Exam_type_Relation.RID, Radiology.RSGID FROM radiology_exam_type INNER JOIN Radiology_Exam_type_Relation INNER JOIN Radiology INNER JOIN RadiologySubGroup ON Radiology.RSGID = RadiologySubGroup.RSGID ON Radiology_Exam_type_Relation.RID = Radiology.RID ON radiology_exam_type.radiology_id = Radiology_Exam_type_Relation.radiology_id WHERE (Radiology.RSGID = @RSGID)">
                            <DeleteParameters>
                              <asp:ControlParameter ControlID="GridView1" Name="RID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="GridView1" Name="Radiology_id" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListSGName" Name="RSGID" PropertyName="SelectedValue" />
                            </SelectParameters>
                            <InsertParameters>
                              <asp:ControlParameter ControlID="DropDownListRadiologyName" Name="RID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListExamType" Name="radiology_id" PropertyName="SelectedValue" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                CssClass="Grid_1" DataKeyNames="radiology_id,RID" DataSourceID="SqlDataSourceSaveInfo"
                Width="100%">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                                            OnClientClick="return confirmation(this)" />

                                        <script src="../../Validate.js" type="text/javascript"></script>

                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:BoundField DataField="RSGName" HeaderText="Sub Group Name " SortExpression="RSGName" >
                                <HeaderStyle CssClass="GridHeader" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RadiologyName" HeaderText="Radiology Name" SortExpression="RadiologyName" >
                                <HeaderStyle CssClass="GridHeader" />
                            </asp:BoundField>
                            <asp:BoundField DataField="radiology_type" HeaderText="Radiology Type" SortExpression="radiology_type" >
                                <HeaderStyle CssClass="GridHeader" />
                            </asp:BoundField>
                            <asp:BoundField DataField="radiology_id" HeaderText="radiology_id" SortExpression="radiology_id"
                        Visible="False" >
                                <HeaderStyle CssClass="GridHeader" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RID" HeaderText="RID" SortExpression="RID" Visible="False" >
                                <HeaderStyle CssClass="GridHeader" />
                            </asp:BoundField>
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                              <EditRowStyle CssClass="Selected" />
                          </asp:GridView>
                          <span style="height: 30px">
                          <asp:ImageButton ID="ImageButtonHome" runat="server" ImageUrl="images/image_bt_home.gif" Visible="false" />                                                  </span><span style="height: 30px">
                        <asp:ImageButton ID="ImageButtonBack" runat="server" ImageUrl="images/image_bt_back.gif" Visible="false" />                        
                        </span>
                        <asp:ImageButton ID="ImageButtonLogOut" runat="server" ImageUrl="images/image_logout_up.gif" Visible="false" />                        
                        <br />
<asp:Button ID="Button1" runat="server" Text="      Body Parts" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>                                                                        
				  
				    <asp:Button ID="Button2" runat="server" Text="      Projection" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>                                                                                
				  
				    <asp:Button ID="Button3" runat="server" Text="      X-ray Entry" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>                                                                                
				  
				    <asp:Button ID="Button4" runat="server" Text="      Exam Main Group" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button5" runat="server" Text="      Exam Sub Group" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button6" runat="server" Text="      Exam Element Values" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button7" runat="server" Text="      Group Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button8" runat="server" Text="      Sub Group Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button9" runat="server" Text="      Radiology Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button10" runat="server" Text="      Exam Type Relation" CssClass="bt5over" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5up'" onmouseout="this.className='bt5over'" Visible="false"/>
</div>
</form>
</body>
</html>
