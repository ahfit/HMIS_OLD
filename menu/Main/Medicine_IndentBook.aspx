<%@ page language="C#" autoeventwireup="true" inherits="MedicineIndentBook, App_Web_3j2dqz20" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link href="../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../images/sheet_form.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="Validate.js"></script>

<script src="../images/highlight.js" type="text/javascript"></script>
<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}
.table_form{ height:30px; }
.table_form td{ padding-left:5px;}
.table_datalist{ border:#CCCCCC solid 1px; border-collapse:collapse; height:30px; background-color:#fafafa; }
.table_datalist td{ padding:3px;}
*{margin:0 0 0 0;}
</style>
<script language="javascript" type="text/javascript">
function CheckRequirment()
{
    if (document.getElementById("TextBox_specificMedicine").value.length==0)
    {
       // alert("Enter Medicine Name");
    //    document.getElementById("TextBox_specificMedicine").focus();
      //  document.getElementById("TextBox_specificeMedicine")
        //return false;        
    }
}
</script>
<script type="text/javascript">
function backto()
{
history.go(-1);
}
</script>

</head>

<body><form id="form1" runat = "server">

<div id="forms_items" class="forms_items">
 <asp:Panel ID="PanelMenu" runat="server" Visible="false"> <asp:Label ID="LabelMenu" runat="server"></asp:Label></asp:Panel><asp:Label ID="Labeb_Requisition_No" runat="server" CssClass="err" ></asp:Label><asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
                <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
    <asp:DropDownList ID="DropDownListStore" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceStore"
        DataTextField="SubDept_Name" DataValueField="SubDept_Id" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"
        Width="261px">
    </asp:DropDownList><br />
    <asp:SqlDataSource ID="SqlDataSourceStore" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE (Dept_Id = 33)">
    </asp:SqlDataSource>

<div style="width:100%; height:1500px;">
<div style="width:26%; float:left; clear:right; height:auto; "> 

<asp:DataList ID="DataList1" runat="server" DataKeyField="Item_Code" DataSourceID="SqlDataSource_Min_Alert"
                                OnSelectedIndexChanged="DataList1_SelectedIndexChanged" Width="100%">
                                <ItemTemplate>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_datalist">
  <tr>
    <td> <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" OnClick="LinkButton1_Click"
                                        Text='<%# Eval("Medicine", "{0}") %>'></asp:LinkButton></td>
  </tr>
  <tr>
    <td> <strong>Stock :&nbsp;</strong><asp:Label ID="StockLabel" CssClass="err" runat="server" Text='<%# Eval("Stock") %>'></asp:Label></td>
  </tr>
</table><br style="line-height:4px;" />

                                </ItemTemplate>
                            </asp:DataList>
                            <br />

                            
                            <asp:SqlDataSource ID="SqlDataSource_Min_Alert" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                SelectCommand="Store_Item_Shortage_Alert" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                                <SelectParameters>
                                    <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" Type="Int32" />
                                    <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource></div>



<div style="width:33%; float:left; clear:right; height:auto; text-align:left; ">

<asp:RadioButtonList ID="RadioButtonList_medkind" runat="server" CssClass="text_boxtitle"
                                RepeatColumns="5" RepeatLayout="Flow">
                                <asp:ListItem Value="i%">INJ</asp:ListItem>
                                <asp:ListItem Value="t%">TAB</asp:ListItem>
                                <asp:ListItem Value="c%">CAP</asp:ListItem>
                                <asp:ListItem Selected="True" Value="%">ANY</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:TextBox ID="TextBox_specificMedicine" Width="150px" runat="server" CssClass="input_txt" OnTextChanged="TextBox_specificMedicine_TextChanged"
                                            ></asp:TextBox>
                                        <asp:Button ID="Button1" runat="server" Text="Search" CssClass="btn1" OnClick="Button1_Click" />
                                        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="ALL"  CssClass="btn1" Visible="False" /><br />

                            <asp:GridView ID="GridViewMedicine" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                                DataSourceID="SqlDataSourceGetMedicine" Width="100%" DataKeyNames="MedCode" OnSelectedIndexChanged="GridViewMedicine_SelectedIndexChanged" OnPreRender="GridViewMedicine_PreRender" Visible="False">
                                <Columns>
                                    <asp:BoundField DataField="MedCode" HeaderText="MedCode" ReadOnly="True" SortExpression="MedCode" Visible="False" />
                                    <asp:ButtonField CommandName="Select" DataTextField="Medicine Name" />
                                    <asp:BoundField DataField="Medicine Name" HeaderText="Medicine Name" SortExpression="Medicine Name" Visible="False" />
                                </Columns>
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>

<div style="width:100%; overflow:scroll; height:auto;">
                            <asp:TreeView ID="TreeView1" runat="server" ExpandDepth="0"
                                OnSelectedNodeChanged="TreeView1_SelectedNodeChanged" PopulateNodesFromClient="False">
                               <NodeStyle CssClass="treelink" />
                            </asp:TreeView>
</div>
                        </div>

<div style="width:40%; float:left; clear:right; height:auto;" >

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    CssClass="Grid_1" PageSize="18" Width="100%" DataSourceID="SqlDataSource_Medicine_Sub" OnPreRender="GridView1_PreRender" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="IB_ID">
                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                                    OnClientClick="return confirmation(this)" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Store_Items" HeaderText="Medicine" ReadOnly="True" SortExpression="Store_Items" />
                        <asp:TemplateField HeaderText="Balance"></asp:TemplateField>
                        <asp:TemplateField HeaderText="QTY">
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Qty", "{0}") %>' Width="65px"></asp:TextBox>
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Item_Code", "{0}") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="IB_ID" HeaderText="IB_ID" ReadOnly="True" SortExpression="IB_ID" />
                    </Columns>
                </asp:GridView>
                <br />
<asp:Button ID="Button4" runat="server" CssClass="btn1" Text="Save & Submit" OnClick="Button4_Click" />
<asp:Button ID="Button_update_QTY" runat="server" CssClass="btn1" OnClick="Button_update_QTY_Click" Text="Update Qty" />
<asp:Button ID="Button3" runat="server" CssClass="btn1" OnClick="Button3_Click" Text="RoleBack" />
                            </div>
                            <br />
                <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label><br />
                            <asp:HiddenField ID="HiddenField_Med_Qty" runat="server" />
                            <asp:HiddenField ID="HiddenField_Med_Code" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource_Submit" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                InsertCommand="INSERT INTO Medicine_Request_Track(IB_ID, By_Emp_ID, By_Dept_ID, Date_Time, Request_Status) VALUES (@IB_ID, @By_Emp_ID, @By_Dept_ID, GETDATE(), 0)"
                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" DeleteCommand="DELETE FROM Store_Indent_Book_Sub WHERE (IB_ID = @IB_ID) AND (Item_Code = @Med_Code)">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="By_Emp_ID" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="HiddenField_Dept_ID" Name="By_Dept_ID" PropertyName="Value" />
                                </InsertParameters>
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Med_Code" PropertyName="Value" />
                                </DeleteParameters>
                            </asp:SqlDataSource>                        
                            <asp:SqlDataSource ID="SqlDataSourceApprove" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                InsertCommand="medicine_order_approve"
                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" InsertCommandType="StoredProcedure" SelectCommand="medicine_order_approve" SelectCommandType="StoredProcedure">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="HiddenField_counter" DefaultValue="" Name="IB_ID"
                                        PropertyName="Value" />
                                    <asp:Parameter DefaultValue="1" Name="Status" />
                                    <asp:Parameter DefaultValue="203" Name="Emp_ID" />
                                    <asp:SessionParameter DefaultValue="" Name="By_Dept_ID" SessionField="dept_id" />
                                    <asp:ControlParameter ControlID="HiddenField_Dept_ID" Name="For_Dept_ID" PropertyName="Value"
                                        Type="Int32" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:Parameter Name="IB_ID" Type="Int32" />
                                    <asp:Parameter Name="Status" Type="Boolean" />
                                    <asp:Parameter Name="Emp_ID" Type="Int32" />
                                    <asp:Parameter Name="By_Dept_ID" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource_Request_Main" runat="server"></asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server"></asp:SqlDataSource>
                
                </div>
</div>
                
<asp:HiddenField ID="HiddenField_Tender_ID" runat="server" />
                <asp:HiddenField ID="HiddenField_counter" runat="server" />
                            <asp:HiddenField ID="HiddenField_YearlyCounter" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource_Medicine_Main" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                DeleteCommand="DELETE FROM Store_Indent_Book_Main WHERE (IB_ID = @IB_ID)"
                                InsertCommand="Insert_Indent_Book_Main"
                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" InsertCommandType="StoredProcedure">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="HiddenField_YearlyCounter" Name="Yearly_Counter"
                                        PropertyName="Value" Type="Int32" />
                                    <asp:SessionParameter Name="From_Dept_ID" SessionField="dept_id" Type="Int32" />
                                    <asp:SessionParameter Name="From_Sub_Dept_ID" SessionField="subdeptid" Type="Int32" />
                                    <asp:ControlParameter ControlID="DropDownListStore" Name="To_Sub_Dept_ID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                    <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource_Medicine_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
                                DeleteCommand="DELETE FROM Store_Indent_Book_Sub WHERE (IB_ID = @IB_ID)" InsertCommand="Insert_Indent_Book_Sub" SelectCommand="Select_Store_Items_Order" UpdateCommand="medicine_order_Update" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" InsertCommandType="StoredProcedure">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
                                </DeleteParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Item_Code" PropertyName="Value"
                                        Type="String" />
                                    <asp:Parameter DefaultValue="10" Name="Item_Qty" Type="Int32" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="HiddenField_Med_Code" Name="Med_Code" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="HiddenField_Med_Qty" Name="Med_Qty" PropertyName="Value" />
                                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>                        
                            <asp:SqlDataSource ID="SqlDataSourceGetMedicine" runat="server" ConnectionString="<%$ ConnectionStrings:Pharmacy_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Pharmacy_ConnectionString.ProviderName %>"
                                SelectCommand="Select_Medicine_For_Department" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="TextBox_specificMedicine" Name="mgname" PropertyName="Text"
                                        Type="String" DefaultValue="%" />
                                    <asp:ControlParameter ControlID="RadioButtonList_medkind" Name="medkind" PropertyName="SelectedValue"
                                        Type="String" />
                                    <asp:Parameter DefaultValue="6" Name="Department" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField2" runat="server" />

                


</form>
</body>
</html>