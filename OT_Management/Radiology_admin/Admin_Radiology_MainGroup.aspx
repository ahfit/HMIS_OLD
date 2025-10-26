<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_Radiology_MainGroup.aspx.vb" Inherits="Administrator_Test_Administrator_Admin_Radiology_MainGroup" %>



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
 
 
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="138" height="37" align="right" valign="middle" ><strong>&nbsp;Main Group Name   :&nbsp; </strong></td>
                              <td width="575" valign="middle"><span style="width: 198px; text-align: left;">
                                <asp:TextBox ID="TextBoxMainGroupName" runat="server" CssClass="d-active" Width="146px"  ></asp:TextBox>
                                <span style="width: 919px; height: 441px; vertical-align: top; text-align: center;">
                              &nbsp;&nbsp;
                              <asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1"  />                              </span></span></td>
                            </tr>
                          
                          

                          
                          
                          
                          
                          
                          
                          
                          
                        </table><br />
<asp:SqlDataSource ID="SqlDataSourceRadiologymainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                DeleteCommand="DELETE FROM radiology_exam_type WHERE (radiology_id = @ID)" InsertCommand="INSERT INTO Admin_Radiology_Exam_MainGroup(MG_Name) VALUES (@radiology_type)"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT MG_Name, MG_Code FROM Admin_Radiology_Exam_MainGroup">
                            <DeleteParameters>
                              <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <InsertParameters>
                              <asp:ControlParameter ControlID="TextBoxMainGroupName" Name="radiology_type" PropertyName="Text" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                        </span>
                          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="radiology_id"
                DataSourceID="SqlDataSourceRadiologymainGroup" Width="100%" CssClass="Grid_1">
                          <Columns>
                          <asp:BoundField DataField="MG_Code" HeaderText="ID" SortExpression="MG_Code" >
                              <HeaderStyle CssClass="GridHeader" />
                          </asp:BoundField>
                          <asp:BoundField DataField="MG_Name" HeaderText="Main Group Name " SortExpression="MG_Name" >
                              <HeaderStyle CssClass="GridHeader" />
                          </asp:BoundField>
                              <asp:TemplateField>
                                  <ItemTemplate>
                                      <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                                          OnClientClick="return confirmation(this)" />

                                      <script src="../../Validate.js" type="text/javascript"></script>

                                  </ItemTemplate>
                              </asp:TemplateField>
                          </Columns>
                          <RowStyle CssClass="GridItem" />
                          <HeaderStyle CssClass="GridHeader" />                        
                          <AlternatingRowStyle CssClass="GridAltItem" />
                        </asp:GridView>
                          <span style="height: 30px">
                          <asp:ImageButton ID="ImageButtonHome" runat="server" ImageUrl="images/image_bt_home.gif" Visible="false" />                                                  </span><span style="height: 30px">
                        <asp:ImageButton ID="ImageButtonBack" runat="server" ImageUrl="images/image_bt_back.gif" Visible="false" />                        
						
                        </span>
                        <asp:ImageButton ID="ImageButtonLogOut" runat="server" ImageUrl="images/image_logout_up.gif" Visible="false" />                        
                        
<br />
<asp:Button ID="Button1" runat="server" Text="Body Parts" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>                                                                        
				  
				    <asp:Button ID="Button2" runat="server" Text="      Projection" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>                                                                                
				  
				    <asp:Button ID="Button3" runat="server" Text="      X-ray Entry" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>                                                                                
				  
				    <asp:Button ID="Button4" runat="server" Text="      Exam Main Group" CssClass="bt5over" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5up'" onmouseout="this.className='bt5over'" Visible="false"/>
				    <asp:Button ID="Button5" runat="server" Text="      Exam Sub Group" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button6" runat="server" Text="      Exam Element Values" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button7" runat="server" Text="      Group Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button8" runat="server" Text="      Sub Group Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button9" runat="server" Text="      Radiology Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button10" runat="server" Text="      Exam Type Relation" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>

</div>
</form>
</body>
</html>
