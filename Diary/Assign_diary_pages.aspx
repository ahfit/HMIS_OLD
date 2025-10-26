<%@ page language="VB" autoeventwireup="false" inherits="Assign_diary_pages, App_Web_xvur0m4d" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>

<link href="../css/class_reset.css" rel="stylesheet" 	 type="text/css" />
<link href="../css/class_elements.css" rel="stylesheet" type="text/css" />
<!--[if IE]><link rel="stylesheet" href="../css/class_ie.css" type="text/css" media="screen, projection"/><![endif]-->

<link rel="icon" href="images/favicon.ico" type="image/x-icon">
<script type="text/javascript" src="css/highlight.js"></script>



<style type="text/css">

.span-19{width:740px; }
* html legend { margin:0px 0px 0px 0; padding:0; font-weight:bold; }
body { background-color:#FFF;}

</style>
<script language="JavaScript" type="text/javascript">
function calcHeight1()
{ 

window.parent.document.getElementById('holder3').height = document.body.scrollHeight;
//  var the_height1=
//    document.getElementById('holder1').contentWindow.
//      document.body.scrollHeight;


//  document.getElementById('holder1').height=
//      the_height1;
}

function MM_changeProp(objId,x,theProp,theValue) { //v9.0
  var obj = null; with (document){ if (getElementById)
  obj = getElementById(objId); }
  if (obj){
    if (theValue == true || theValue == false)
      eval("obj.style."+theProp+"="+theValue);
    else eval("obj.style."+theProp+"='"+theValue+"'");
  }
}
function MM_effectAppearFade(targetElement, duration, from, to, toggle)
{
	Spry.Effect.DoFade(targetElement, {duration: duration, from: from, to: to, toggle: toggle});
}
function MM_showHideLayers() { //v9.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) 
  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
</script>


<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
</head>


<body ><form id="form1" runat = "server">










<div id="forms_items" class="forms_items"  >

<fieldset><legend><strong>Add Pages</strong></legend>
<br />

<table width="95%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form">
  <tr>
    <td width="7%" align="right"></td>
    <td colspan="5"><asp:TextBox ID="TextBox_Module" runat="server" CssClass="input_txt"  Width="150px" Visible="False"></asp:TextBox>
    <asp:Button ID="Add_Module" runat="server" Text="Add Module" CssClass="btn_1" Visible="False" /><asp:Label Visible="false"  ID="Label_Module" runat="server" Text="Label" ></asp:Label></td>
  </tr>

  <tr>
    <td align="right"><strong>Module&nbsp;:&nbsp;</strong></td>
    <td width="22%"><asp:DropDownList ID="DropDownList_Module" runat="server"
        Width="154px" AutoPostBack="True" DataSourceID="SqlDataSource_Module" DataTextField="Module_Name" DataValueField="Module_Id">
    </asp:DropDownList></td>
    <td width="13%" align="right"><strong>Page Name&nbsp;:&nbsp;</strong></td>
    <td width="21%"><asp:TextBox ID="TextBox_Page" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox></td>
    <td width="10%" align="right"><strong>Page Url&nbsp;:&nbsp;</strong></td>
    <td width="27%"><asp:TextBox ID="TextBox_Url" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox></td>
  </tr>
</table>


<div align="left" style="margin-top:5px;"> <asp:Button ID="Button_Add_Page" runat="server" CssClass="btn_1" Text="Add Page" style="margin-left:63px;" /> <asp:Label ID="Label_Page" runat="server" Text="Label" Visible="False" ></asp:Label></div><br />


    <asp:SqlDataSource ID="SqlDataSource_Module" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
        InsertCommand="Insert_Module" InsertCommandType="StoredProcedure" SelectCommand="SELECT Module_Name, Module_ID FROM Admin_User_Module WHERE (Module_ID = 207)">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Module" Name="Module_Name" PropertyName="Text"
                Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Page" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
        InsertCommand="Insert_diary_Page" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>"
        SelectCommand="Select_diary_Page" SelectCommandType="StoredProcedure" DeleteCommand="DELETE FROM Admin_User_diary_Pages WHERE (Page_ID = @Page_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Module" Name="Module_id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Page" Name="Page_Name" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_Url" Name="Page_Url" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList_Module" Name="Module_Id" PropertyName="SelectedValue"
                Type="Int32" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="Page_ID" />
        </DeleteParameters>
    </asp:SqlDataSource>
    
    <asp:GridView ID="GridView_Page" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" DataSourceID="SqlDataSource_Page" Width="98%" Style="margin-left:8px;"  DataKeyNames="Page_ID">
        <Columns>
            <asp:BoundField DataField="Module_Name" HeaderText="Module" SortExpression="Module" />
            <asp:BoundField DataField="Page_Name" HeaderText="Page" SortExpression="Page_Name" />
            <asp:BoundField DataField="Page_URL" HeaderText="URL" SortExpression="Page_URL" />
            <asp:BoundField DataField="Module_ID" HeaderText="Module_ID" SortExpression="Module_ID"
                Visible="False" />
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>

</fieldset>
    

<fieldset><legend><strong>Assign Pages</strong></legend>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td align="right">User Name :</td>
    <td><asp:DropDownList ID="DropDownListUsers" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_For_User"
                                            DataTextField="USER_Name" DataValueField="User_ID" CssClass="dropbox" Width="252px">                                        </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">Module ID :</td>
    <td><asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_Module"
                                            DataTextField="Module_Name" DataValueField="Module_Id" Width="252px" CssClass="dropbox" AutoPostBack="True">
            </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">Assign Pages :</td>
    <td> <img src="images/select.gif" style="cursor:hand;" onclick="MM_changeProp('mypanel','','display','block','DIV')" />

<div id="mypanel" style="border:#CCCCCC solid 2px; padding:10px; position:relative; width:98%; padding-right:2px; padding-bottom:2px; padding-top:1px; display:none;">

<div align="right" style="margin-top:5px; margin-right:20px;"><img src="images/bt-close.gif" style="cursor:hand;" onclick="MM_changeProp('mypanel','','display','none','DIV')"/></div></div> <asp:CheckBoxList     Width="100%"                                         DataTextField="Page_Name" DataValueField="Page_ID" ID="CheckBoxListPages" RepeatColumns="3" runat="server" DataSourceID="SqlDataSourcePages">                                        </asp:CheckBoxList>
</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><asp:Button ID="Button_CheckAll" runat="server" CssClass="btn_1" Text="Check All" />
                                        <asp:Button ID="ButtonUnCheck_All" runat="server" CssClass="btn_1" Text="UnCheck All" />
                                        <asp:Button ID="ButtonSave" runat="server" CssClass="btn_1" Text="Save" /></td>
  </tr>
</table>






<br />
                          <asp:SqlDataSource ID="SqlDataSource_For_User" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
            ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>"
            SelectCommand="SELECT ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, ' ') + ' ' + ISNULL(ELName, ' ') AS USER_Name, EmpID AS User_ID FROM Employee ORDER BY USER_Name"> </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourcePages" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
                                DeleteCommand="DELETE FROM Admin_Employee_diary_Pages WHERE (Page_ID = @Page_ID) AND (Emp_ID = @User_ID)"
                                InsertCommand="INSERT INTO Admin_Employee_diary_Pages(Page_ID, EMP_ID,Module_ID) VALUES (@Page_ID, @User_ID,@Module_ID)"
                                ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>"
                                SelectCommand="SELECT Page_ID, Page_Name FROM Admin_User_diary_Pages WHERE (Module_ID = @Module_ID)">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="HiddenFieldPage_ID" Name="Page_ID" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="DropDownListUsers" Name="User_ID" PropertyName="SelectedValue" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="HiddenFieldPage_ID" Name="Page_ID" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="DropDownListUsers" Name="User_ID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropDownList1" Name="Module_ID" PropertyName="SelectedValue" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList1" Name="Module_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldPage_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceMainPages" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
        ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>"
        SelectCommand="SELECT Page_Name, Page_URL FROM Admin_User_Module_Pages" InsertCommand="INSERT INTO Admin_User_Module_Pages(Page_Name, Page_URL, Module_ID) VALUES (@Page_Name, @Page_URL, @Module_ID)">
        <InsertParameters>
            <asp:Parameter Name="Page_Name" />
            <asp:Parameter Name="Page_URL" />
            <asp:Parameter Name="Module_ID" />
        </InsertParameters>
    </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>"
                                SelectCommand="SELECT Admin_User_diary_Pages.Page_Name, ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS [User Name], Admin_Employee_diary_Pages.ID FROM Admin_User_diary_Pages INNER JOIN Admin_Employee_diary_Pages ON Admin_User_diary_Pages.Page_ID = Admin_Employee_diary_Pages.Page_ID INNER JOIN Employee ON Admin_Employee_diary_Pages.Emp_ID = Employee.EmpID WHERE (Employee.EmpID = @User_ID)" DeleteCommand="DELETE FROM Admin_Employee_diary_Pages WHERE (ID = @ID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListUsers" Name="User_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="ID" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUpdateMainPage" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
        ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Login SET MainPage_Id = 138 WHERE (EmpID = @User_Id)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="DropDownListUsers" Name="User_Id" PropertyName="SelectedValue" />
        </UpdateParameters>
    </asp:SqlDataSource>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                                DataKeyNames="id" DataSourceID="SqlDataSourceGrid" Width="98%" Style="margin-left:8px;" >
                                <Columns>
                                    <asp:BoundField DataField="User Name" HeaderText="User Name" ReadOnly="True" SortExpression="User Name" />
                                    <asp:BoundField DataField="Page_Name" HeaderText="Page Name" ReadOnly="True" SortExpression="Page_Name" />
                                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" SortExpression="id" />
                                    <asp:CommandField ShowDeleteButton="True" />
                                </Columns>
                            </asp:GridView>
                            <asp:HiddenField ID="HiddenFieldPriority" runat="server" />

<br />

</fieldset>


</div><!--content end-->




</form>
</body>
</html>
