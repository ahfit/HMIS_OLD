<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Assign_pages.aspx.vb" Inherits="Assign_pages"  MasterPageFile ="~/hacims_masterpage_admin.master"%>

  
 <asp:Content ID ="Content1" ContentPlaceHolderID="head" Runat="Server">
 
 
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



 
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



    <script src="validate.js" type="text/javascript"></script>
 
 

<div class="bxmain"><h2><span>Add Pages</span></h2>
 

<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="tbl_form">
  <tr>
    <td width="40%" align="right"> Module : </td>
    <td><asp:TextBox ID="TextBox_Module" runat="server"    ></asp:TextBox>
    <asp:Button ID="Add_Module" runat="server" Text="Add Module"  />
    <asp:Label Visible="false"  ID="Label_Module" runat="server" Text="Label" ></asp:Label></td>
  </tr>

  <tr>
    <td align="right"> Module :</td>
    <td><asp:DropDownList ID="DropDownList_Module" runat="server"
         AutoPostBack="True" DataSourceID="SqlDataSource_Module" DataTextField="Module_Name" DataValueField="Module_Id">
    </asp:DropDownList></td>
    </tr>
  <tr>
    <td align="right"> Page Name :</td>
    <td><asp:TextBox ID="TextBox_Page" runat="server"  ></asp:TextBox></td>
    </tr>
  <tr>
    <td align="right"> Page Url : </td>
    <td><asp:TextBox ID="TextBox_Url" runat="server"  ></asp:TextBox></td>
    </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td><asp:Button ID="Button_Add_Page" runat="server"  Text="Add Page" />    
      <asp:Label ID="Label_Page" runat="server" Text="Label" Visible="False" ></asp:Label></td>
  </tr>
</table>



<br />


    <asp:SqlDataSource ID="SqlDataSource_Module" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
        InsertCommand="Insert_Module" InsertCommandType="StoredProcedure" SelectCommand="Select_Module"
        SelectCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Module" Name="Module_Name" PropertyName="Text"
                Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Page" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
        InsertCommand="Insert_Page" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>"
        SelectCommand="Select_Page" SelectCommandType="StoredProcedure" 
        DeleteCommand="DELETE FROM Admin_User_Module_Pages WHERE (Page_ID = @Page_ID)" 
        UpdateCommand="UPDATE Admin_User_Module_Pages SET Page_Name = @Page_Name, Page_URL = @Page_URL, Priority = @Priority WHERE (Page_ID = @Page_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Module" Name="Module_id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Page_Name" />
            <asp:Parameter Name="Page_URL" />
            <asp:Parameter Name="Page_ID" />
            <asp:Parameter Name="Priority" />
        </UpdateParameters>
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
    
    <asp:GridView ID="GridView_Page" runat="server" AutoGenerateColumns="False"  DataSourceID="SqlDataSource_Page" Width="98%" Style="margin-left:8px;"  DataKeyNames="Page_ID">
        <Columns>
            <asp:BoundField DataField="Module_Name" HeaderText="Module" 
                SortExpression="Module" HeaderImageUrl="Module Name" ReadOnly="True" />
            <asp:BoundField DataField="Page_Name" HeaderText="Page" 
                SortExpression="Page_Name" HeaderImageUrl="Page Name" />
            <asp:BoundField DataField="Page_URL" HeaderText="URL" SortExpression="Page_URL" 
                HeaderImageUrl="URL" />
            <asp:BoundField DataField="Module_ID" HeaderText="Module_ID" SortExpression="Module_ID"
                Visible="False" HeaderImageUrl="Module Name" />
            <asp:BoundField DataField="Priority" HeaderImageUrl="Priority" 
                HeaderText="Priority" SortExpression="Priority" />
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        </Columns><RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />    </asp:GridView>

</div>
    
<br />

<div class="bxmain"><h2><span>Assign Pages</span></h2>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
   <tr>
            <td align="right"><strong>Hospital :</td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
  <tr>
    <td align="right" width="40%">Department: </td>
    <td><asp:DropDownList ID="DropDownListSubDepartment" runat="server" 
            AutoPostBack="True" DataSourceID="SqlDataSource_SubDept"
                                            DataTextField="SubDepartmentDisplayText" 
            DataValueField="subdept_id"   >                                        </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">User Name :</td>
    <td><asp:DropDownList ID="DropDownListUsers" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_For_User"
                                            DataTextField="USER_Name" DataValueField="User_ID"    >                                        </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">Module ID :</td>
    <td><asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_Module"
                                            DataTextField="Module_Name" DataValueField="Module_Id"   AutoPostBack="True">
            </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right">Assign Pages :</td>
    <td> <asp:CheckBoxList     Width="100%"                                         DataTextField="Page_Name" DataValueField="Page_ID" ID="CheckBoxListPages"  runat="server" DataSourceID="SqlDataSourcePages" RepeatDirection="Vertical" RepeatLayout="Flow">                                        </asp:CheckBoxList>
</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><asp:Button ID="Button_CheckAll" runat="server"  Text="Check All" />
                                        <asp:Button ID="ButtonUnCheck_All" runat="server"  Text="UnCheck All" />
                                        <asp:Button ID="ButtonSave" runat="server"  Text="Save" /></td>
  </tr>
</table>






            <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" 
                ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>" 
                SelectCommand="SELECT Department.Dept_ID, Department.Dept_Name, SubDepartment.SubDept_Id, SubDepartment.SubDept_Name, ISNULL(SubDepartment.SubDept_Name, '') + ' ( ' + ISNULL(Department.Dept_Name, '') + ' ) ' AS SubDepartmentDisplayText, Department.Hospital_ID FROM SubDepartment LEFT OUTER JOIN Department ON Department.Dept_ID = SubDepartment.Dept_Id WHERE (Department.Hospital_ID = @HospitalID) ORDER BY SubDepartment.SubDept_Name">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddl_Hospital" Name="HospitalID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>






<br />
                          <asp:SqlDataSource ID="SqlDataSource_For_User" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
            ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>"
            
                SelectCommand="SELECT ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') + ' { ' + ISNULL(Login.UserName, '--') + ' }' AS USER_Name, Employee.EmpID AS User_ID FROM Employee LEFT OUTER JOIN Login ON Employee.EmpID = Login.EmpID WHERE Employee.ActiveStatus=1 and (Employee.SubDeptId = @SubDeptId)">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" 
                                      PropertyName="SelectedValue" />
                              </SelectParameters>
            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourcePages" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
                                DeleteCommand="DELETE FROM Admin_Employee_Module_Pages WHERE (Page_ID = @Page_ID) AND (Emp_ID = @User_ID)"
                                InsertCommand="INSERT INTO Admin_Employee_Module_Pages(Page_ID, EMP_ID,Module_ID) VALUES (@Page_ID, @User_ID,@Module_ID)"
                                ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>"
                                SelectCommand="SELECT Page_ID, Page_Name FROM Admin_User_Module_Pages WHERE (Module_ID = @Module_ID)">
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
        SelectCommand="SELECT Page_Name, Page_URL FROM Admin_User_Module_Pages" InsertCommand="INSERT INTO Admin_User_Module_Pages(Page_Name, Page_URL, Module_ID,Module_Type) VALUES (@Page_Name, @Page_URL, @Module_ID,'false')">
        <InsertParameters>
            <asp:Parameter Name="Page_Name" />
            <asp:Parameter Name="Page_URL" />
            <asp:Parameter Name="Module_ID" />
        </InsertParameters>
    </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceGrid" 
        runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>"
                                
        SelectCommand="SELECT Admin_User_Module_Pages.Page_Name, ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS [User Name], Admin_Employee_Module_Pages.ID, Admin_User_Module_Pages.Page_URL FROM Admin_User_Module_Pages INNER JOIN Admin_Employee_Module_Pages ON Admin_User_Module_Pages.Page_ID = Admin_Employee_Module_Pages.Page_ID INNER JOIN Employee ON Admin_Employee_Module_Pages.Emp_ID = Employee.EmpID WHERE (Employee.EmpID = @User_ID) and (Admin_User_Module_Pages.module_id =@module_id)" 
        DeleteCommand="DELETE FROM Admin_Employee_Module_Pages WHERE (ID = @ID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListUsers" Name="User_ID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropDownList1" Name="module_id" 
                                        PropertyName="SelectedValue" />
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
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                DataKeyNames="id" DataSourceID="SqlDataSourceGrid" Width="98%" Style="margin-left:8px;" >
                                <Columns>
                                    <asp:BoundField DataField="User Name" HeaderText="User Name" ReadOnly="True" SortExpression="User Name" />
                                    <asp:BoundField DataField="Page_Name" HeaderText="Page Name" ReadOnly="True" SortExpression="Page_Name" />
                                    <asp:BoundField DataField="Page_URL" HeaderText="Page Url" 
                                        SortExpression="Page_URL" />
                                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" SortExpression="id" />
                                    <asp:CommandField ShowDeleteButton="True" />
                                </Columns>
                            </asp:GridView>
                            <asp:HiddenField ID="HiddenFieldPriority" runat="server" />

<br />

</div>


 






</asp:Content>
