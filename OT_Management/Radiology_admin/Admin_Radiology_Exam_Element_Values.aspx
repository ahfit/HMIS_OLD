<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_Radiology_Exam_Element_Values.aspx.vb" Inherits="Administrator_Admin_Gestational_Ultrasound_ElementValues" %>



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
                            <td width="138" height="37" align="right" valign="middle" ><strong>&nbsp;Main Group Name   :&nbsp; </strong></td>
                              <td colspan="2" valign="middle"><span style="text-align: left">
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="radiology_type" DataValueField="radiology_id" ID="DropDownListMainGroup" runat="server"
                            Width="240px" DataSourceID="SqlDataSourceMainGroup" Style="position: static"> </asp:DropDownList>
                              </span></td>
                              <td width="370" align="right" valign="middle"><strong >&nbsp;Sub Group   :&nbsp;</strong></td>
                              <td width="214" valign="middle"><span style="height: 20px; text-align: left">
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="Rd_element_name" DataValueField="Rd_element_id" ID="DropDownListSubGroup" runat="server" Width="200px" DataSourceID="SqlDataSourceElementValue"> </asp:DropDownList>
                              </span></td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle"><span  style="width: 245px"><strong>Element Value  :</strong>&nbsp; </span></td>
                              <td width="156" valign="middle"><span style="height: 20px; text-align: left">
                                <asp:TextBox ID="TextBoxElementValue" runat="server" CssClass="d-active" Width="146px"  ></asp:TextBox>
                              </span></td>
                              <td colspan="3" valign="middle"><span style="height: 19px">
                              &nbsp;</span></td>
                            </tr>
                         
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                        </table>
                        <br />

    
    <div align="center">
                        <asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1"  />                        
</div>
    
    
    
    
    <asp:GridView ID="GridViewElementValue" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceForGrid"
                            Width="100%" CssClass="Grid_1" DataKeyNames="Rd_id">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                                            OnClientClick="return confirmation(this)" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:BoundField DataField="radiology_type" HeaderText="Main Group" SortExpression="radiology_type" >
                                <HeaderStyle CssClass="GridHeader" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Rd_element_name" HeaderText="Sub Group Name" SortExpression="Rd_element_name" >
                                <HeaderStyle CssClass="GridHeader" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Rd_id" HeaderText="Rd_id" InsertVisible="False" ReadOnly="True"
                                    SortExpression="Rd_id" Visible="False" >
                                <HeaderStyle CssClass="GridHeader" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Rd_value" HeaderText="Element Value" SortExpression="Rd_value" >
                                <HeaderStyle CssClass="GridHeader" />
                            </asp:BoundField>
      </Columns>
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
                        </span><span style="vertical-align: top; width: 839px; height: 526px; text-align: center">
                        <asp:SqlDataSource ID="SqlDataSourceElementValue" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                InsertCommand="INSERT INTO Admin_rd_exam_Elemenvalue(Rd_Code, Rd_value) VALUES (@Rd_Code, @Rd_value)"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Rd_element_name, Rd_element_id FROM Admin_Rd_Exam_type WHERE (Radiology_id = @id)">
                          <InsertParameters>
                            <asp:ControlParameter ControlID="DropDownListSubGroup" Name="Rd_Code" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="TextBoxElementValue" Name="Rd_value" PropertyName="Text" />
                          </InsertParameters>
                          <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListMainGroup" Name="id" PropertyName="SelectedValue" />
                          </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" SelectCommand="SELECT     Admin_Radiology_Element.Rd_element_name, Admin_rd_exam_Elementvalue.Rd_id, Admin_rd_exam_Elementvalue.Rd_value, &#13;&#10;                      Admin_Radiology_Exam_MainGroup.MG_Name&#13;&#10;FROM         Admin_rd_exam_Elementvalue INNER JOIN&#13;&#10;                      Admin_Radiology_Element ON Admin_rd_exam_Elementvalue.Rd_Code = Admin_Radiology_Element.Rd_element_id INNER JOIN&#13;&#10;                      Admin_Radiology_Exam_MainGroup ON Admin_Radiology_Element.Radiology_id = Admin_Radiology_Exam_MainGroup.Radiology_id&#13;&#10;WHERE     (Admin_Radiology_Element.Radiology_id = @Radiology_ID) AND (Admin_rd_exam_Elementvalue.Rd_Code = @Rd_Code)" DeleteCommand="DELETE FROM Admin_rd_exam_Elemenvalue WHERE (Rd_id = @Rd_ID)">
                          <DeleteParameters>
                            <asp:ControlParameter ControlID="GridViewElementValue" Name="Rd_ID" PropertyName="SelectedValue" />
                          </DeleteParameters>
                          <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListMainGroup" Name="Radiology_ID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DropDownListSubGroup" Name="Rd_Code" PropertyName="SelectedValue" />
                          </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT [radiology_type], [radiology_id] FROM [radiology_exam_type]"> </asp:SqlDataSource>
                        <asp:HiddenField ID="HiddenFieldForSubGroup" runat="server" />
                        </span>
                        <asp:ImageButton ID="ImageButtonhome" runat="server" Height="30" ImageUrl="images/image_bt_home.gif"
                          Width="64" Visible="false" />
                        <asp:ImageButton ID="ImageButtonback" runat="server" Height="30" ImageUrl="images/image_bt_back.gif"
                          Width="66"  Visible="false"/>
                        <asp:ImageButton ID="ImageButtonlogout" runat="server" Height="30" ImageUrl="images/image_logout_up.gif"
                          Width="71"  Visible="false"/><br />
<asp:Button ID="Button1" runat="server" Text="      Body Parts" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'"/>                                                                        
				  
				    <asp:Button ID="Button2" runat="server" Text="      Projection" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false" />                                                                                
				  
				    <asp:Button ID="Button3" runat="server" Text="      X-ray Entry" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'"  Visible="false"/>                                                                                
				  
				    <asp:Button ID="Button4" runat="server" Text="      Exam Main Group" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'"  Visible="false"/>
				    <asp:Button ID="Button5" runat="server" Text="      Exam Sub Group" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'"  Visible="false"/>
				    <asp:Button ID="Button6" runat="server" Text="      Exam Element Values" CssClass="bt5over" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5up'" onmouseout="this.className='bt5over'"  Visible="false"/>
				    <asp:Button ID="Button7" runat="server" Text="      Group Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'"  Visible="false"/>
				    <asp:Button ID="Button8" runat="server" Text="      Sub Group Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'"  Visible="false"/>
				    <asp:Button ID="Button9" runat="server" Text="      Radiology Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'"  Visible="false"/>
				    <asp:Button ID="Button10" runat="server" Text="      Exam Type Relation" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'"  Visible="false"/>
</div>
</form>
</body>
</html>
