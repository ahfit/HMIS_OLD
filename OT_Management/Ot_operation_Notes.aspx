<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_billing.master" CodeFile="Ot_operation_Notes.aspx.vb" Inherits="Operation_Theater_Ot_operation_Notes" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
<script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
<script src="../css_hacims/ck.js" type="text/javascript"></script>

     <style type="text/css">

         

     </style>

<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
      <script type="text/javascript">


          function showModal() {
              $("#myModal").modal('show');
          }


    </script>

<script language ="javascript" type ="text/javascript" >

function Validation()
{
    var Delay_For = document.getElementById("TextBox_CanDelay_For").value;
    if (Delay_For.length != 0)
    {
        if((parseInt(Delay_For) - 0) != parseInt(Delay_For))
        {
        alert("Enter Integer only");
        document.getElementById("TextBox_CanDelay_For").focus();
        return false;
        }
    }
//    else if (Delay_For.length == 0)
//    {
//        alert("Please Enter Can Delay For Value");
//        document.getElementById("TextBox_CanDelay_For").focus();
//        return false;
//    }
    

}

</script>
 <style type="text/css">
     .input_txt{
         height:24px;
     }
 </style>
 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<asp:ScriptManager ID="ScriptManager2" runat="server">
<Services>
             <asp:ServiceReference Path="../autocomplete.asmx" />
             </Services>
    </asp:ScriptManager>
       
<cc1:AutoCompleteExtender ID="AutoComplete_ListOperationName" runat="server" CompletionInterval="10"
                      CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="ListOperationName"
                      ServicePath="../AutoComplete.asmx" TargetControlID="TextBox_Operation">
              </cc1:AutoCompleteExtender>       

     <h1 style="margin-bottom:9px;" class="title">OT Notes </h1>
<table   width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td style="display:none" class="leftnav" valign="top" >
<asp:Label Visible="false" ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1b" runat="server" Visible="False"></asp:Panel>
<asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label></td>
<td  style="width:auto;" valign="top" >
     
  
  
   <div id="TabbedPanels1" class="TabbedPanels">
          <ul class="TabbedPanelsTabGroup" style="margin-left:10px;">
             <li style="display:none;" class="TabbedPanelsTab" tabindex="0">Form</li> 
            <li class="TabbedPanelsTab" tabindex="0">Notes</li>
            <li class="TabbedPanelsTab" tabindex="0">Staff</li>
            <li style="display:none" class="TabbedPanelsTab" tabindex="0">ADD Procedure
            </li>
            </ul>
    

          <div class="TabbedPanelsContentGroup" style="height:auto;">
            <div style="display:none;" class="TabbedPanelsContent"> 
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class=""  >
       
  <tr>
    <td valign="top" style="width: 20%">
      <asp:SqlDataSource ID="SqlDataSource_OT_Procedure" runat="server"  ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>" SelectCommand="SELECT Procedure_Name.Procedure_Name, Pt_Recommended_Procedures.Procedure_id FROM Pt_Recommended_Procedures INNER JOIN Procedure_Name ON Pt_Recommended_Procedures.Procedure_id = Procedure_Name.Procedure_id INNER JOIN OT_Operation_List ON Pt_Recommended_Procedures.OP_Recommended_Id = OT_Operation_List.Op_Recommended_Id WHERE (OT_Operation_List.Operation_List_Id = @Operation_List_ID)">
                  <SelectParameters>
                      <asp:SessionParameter Name="Operation_List_ID" SessionField="Operation_List_Id" />
                  </SelectParameters>
              </asp:SqlDataSource>
    <asp:DataList ID="dtlOpeartionNotes" runat="server" DataSourceID="SqlDataSource_OT_Procedure" RepeatDirection="Horizontal" DataKeyField="Procedure_id" Height="28px">
                  <ItemTemplate>
                      Procedure :
                      <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" Text='<%# Eval("Procedure_Name") %>'></asp:LinkButton>                   
                  </ItemTemplate>
              </asp:DataList>
    
    <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_ListBox"
                                DataTextField="MH_Heading" DataValueField="MH_Code" Height="170px" 
                                Width="98%"></asp:ListBox></td>
    <td valign="top"> <asp:Panel ID="Panel1" runat="server"  HorizontalAlign="Left"></asp:Panel>
     <br />
<div align="center"> <asp:Button ID="ButtonSave" runat="server" Text="Save"  /></div></td>
  </tr>
  
  </table>     <br>
 
                        <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                            SelectCommand="SELECT MG_Code, MG_Name FROM Admin_OT_MainGroup ORDER BY MG_Name">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource_ListBox" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                            SelectCommand="SELECT MH_Heading, MH_Code FROM Admin_OT_Main_Heading WHERE (Procedure_id = @Procedure_id) ORDER BY Priority">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="dtlOpeartionNotes" Name="Procedure_id" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
     
   
   
   
   </div>                    
   		           
             <div class="TabbedPanelsContent"> 
             <asp:Panel ID="Panel_Noting" runat="server" Width="100%">
     
      
      <div class="bxmain">
        <table border="0" id="tbl" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="30%">
                  <strong>  Performed Date :</strong> </td>
                <td>                    
                    <asp:TextBox ID="WebDateChooser_date" Enabled="false" runat="server" TextMode="Date"></asp:TextBox>
                    <asp:Button style="padding-left:50px;" ID="btnReport" runat="server" Text="Patient Report" OnClick="btnReport_Click" />
                </td>
       
            </tr>
            <tr>
                <td align="right" >
                  <strong>  Start Time :</strong></td>
                <td  >
                   <asp:DropDownList ID="ddlSlotTimeStartTime" AutoPostBack="true" OnSelectedIndexChanged="ddlSlotTimeStartTime_SelectedIndexChanged" runat="server"></asp:DropDownList>
                    
                </td>
            </tr>
            <tr>
                <td align="right" >
                    <strong> End Time :</strong> </td>
                <td  >
                    <asp:DropDownList ID="ddlTimeSlot" runat="server"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong> Anesthesia Type :</strong> </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Anesthesia_Type" Width="366px"  runat="server"  >
                        <asp:ListItem>General</asp:ListItem>
                        <asp:ListItem>Local</asp:ListItem>
                        <asp:ListItem>Spinal</asp:ListItem>
                        <asp:ListItem>Epidural</asp:ListItem>
                        <asp:ListItem>Topical</asp:ListItem>
                        <asp:ListItem>IV Block</asp:ListItem>
                        <asp:ListItem>Standby</asp:ListItem>
                        <asp:ListItem>IV Sedation</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right">
                    <strong> Fluids Incision :</strong> </td>
                <td>
                    <asp:TextBox ID="TextBox_Fluids_Infused" Width="366px" runat="server"   ></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">
                    <strong> Operation Findings :</strong> </td>
                <td>
                    <asp:TextBox ID="TextBox_Operation_Findings" Width="366px" runat="server" 
                         ></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">
                    <strong> Procedure :</strong> </td>
                <td>
                    <asp:TextBox ID="TextBox_Procedure" runat="server" Width="366px"   ></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">
                    <strong> Complication :</strong> </td>
                <td>
                    <asp:TextBox ID="TextBox_Complication" Width="366px" runat="server"  ></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">
                    <strong> Drain :</strong> </td>
                <td>
                    <asp:TextBox ID="TextBox_Drain" runat="server" Width="366px"   ></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">
                    <strong> Specimen Collected :</strong> </td>
                <td>
                    <asp:TextBox ID="TextBox_Specimen_Collected" Width="366px" runat="server" 
                         ></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">
                    <strong> Closure :</strong> </td>
                <td>
                    <asp:TextBox ID="TextBox_Closure" runat="server" Width="600px" Height="205px" TextMode="MultiLine"  ></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">
                    <strong> Description :</strong> </td>
                <td>
                    <asp:TextBox ID="TextBox_Description" Width="600px" Height="205px" runat="server"  TextMode="MultiLine"  ></asp:TextBox></td>
            </tr>
            
            
            <tr>
                <td align="right">
                    <strong> Shift To :</strong> </td>
                <td>
                    <asp:DropDownList Width="366px" ID="DropDownList_Shift_To" runat="server"  >
                        
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right" style="height: 18px">
                </td>
                <td style="height: 18px">
                    <asp:Button ID="Button_Noting" runat="server" Text="Save" /></td>
            </tr>
        </table>
        </div> 
        
        <asp:HiddenField ID="HiddenField_date" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource_PT_Operation_Notes" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
            DeleteCommand="DELETE FROM OT_PT_Performed WHERE (OT_Performed_Id = @OT_Performed_Id)"
            InsertCommand="INSERT INTO OT_PT_Performed(Performed_Datetime, OT_Finding, OT_Procedure, OT_Complication, OT_Closure, OT_Drain, OT_OtherInfo, OT_DataEntry_By, Specimen_Collected, Fluids_Infused, Operation_List_Id, Opertion_StartTime, Operation_EndTime, Anesthesia_Type, Shift_To) VALUES (@Performed_Datetime, @OT_Finding, @OT_Procedure, @OT_Complication, @OT_Closure, @OT_Drain, @OT_OtherInfo, @OT_DataEntry_By, @Specimen_Collected, @Fluids_Infused, @Operation_List_Id, @Opertion_StartTime, @Operation_EndTime, @Anesthesia_Type, @Shift_To)"
            ProviderName="<%$ ConnectionStrings:OperationTheaterConnectionString.ProviderName %>"
            SelectCommand="SELECT OT_Performed_Id, Convert(Varchar,Performed_Datetime,103) as [Performed Date] , OT_Finding, OT_Procedure, OT_Complication, OT_Closure, OT_Drain, OT_OtherInfo, OT_DataEntry_By, Specimen_Collected, Fluids_Infused, Convert(varchar,Opertion_StartTime,103) +' '+Convert(varchar,Opertion_StartTime,108) as [Start Time] , Convert(varchar,Operation_EndTime,103) +' '+Convert(varchar,Operation_EndTime,108) as [End Time]  , Anesthesia_Type, Shift_To FROM OT_PT_Performed WHERE (Operation_List_Id = @Operation_List_Id)"
            UpdateCommand="UPDATE [PT_Operation_Notes] SET [Note_Datetime] = @Note_Datetime, [Incision] = @Incision, [Closure] = @Closure, [OperationFindings] = @OperationFindings, [OP_Recommended_Id] = @OP_Recommended_Id, [Specimen] = @Specimen, [empid] = @empid, [Description] = @Description WHERE [Op_Notes_Id] = @Op_Notes_Id">
            <SelectParameters>
                <asp:SessionParameter Name="Operation_List_Id" SessionField="Operation_List_Id" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="OT_Performed_Id" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Note_Datetime" Type="DateTime" />
                <asp:ControlParameter ControlID="TextBox_Incision" Name="Incision" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Incision" Name="Closure" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Operation_Findings" Name="OperationFindings"
                    PropertyName="Text" Type="String" />
                <asp:QueryStringParameter Name="OP_Recommended_Id" QueryStringField="Op_Recomended_Id"
                    Type="Decimal" />
                <asp:ControlParameter ControlID="TextBox_Specimen" Name="Specimen" PropertyName="Text"
                    Type="String" />
                <asp:SessionParameter Name="empid" SessionField="emp_ID" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text"
                    Type="String" />
                <asp:Parameter Name="Op_Notes_Id" Type="Decimal" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="HiddenField_date" Name="Performed_Datetime" PropertyName="Value" />
                <asp:ControlParameter ControlID="TextBox_Operation_Findings" Name="OT_Finding" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_Procedure" Name="OT_Procedure" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_Complication" Name="OT_Complication" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_Closure" Name="OT_Closure" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_Drain" Name="OT_Drain" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_Description" Name="OT_OtherInfo" PropertyName="Text" />
                <asp:SessionParameter Name="OT_DataEntry_By" SessionField="Emp_ID" />
                <asp:ControlParameter ControlID="TextBox_Specimen_Collected" Name="Specimen_Collected"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_Fluids_Infused" Name="Fluids_Infused" PropertyName="Text" />
                <asp:SessionParameter Name="Operation_List_Id" SessionField="Operation_List_Id" />
                <asp:ControlParameter ControlID="HiddenField_Start_Time" Name="Opertion_StartTime"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_End_Time" Name="Operation_EndTime" PropertyName="Value" />
                <asp:ControlParameter ControlID="DropDownList_Anesthesia_Type" Name="Anesthesia_Type"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList_Shift_To" Name="Shift_To" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_Start_Time" runat="server" />
        <asp:HiddenField ID="HiddenField_End_Time" runat="server" />
      
      <br />

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                DataSourceID="SqlDataSource_PT_Operation_Notes"   Width="100%" DataKeyNames="OT_Performed_Id">
          
            <Columns>
                <asp:BoundField DataField="Performed Date" HeaderText="Performed Date" SortExpression="Performed Date" />
                <asp:BoundField DataField="OT_Finding" HeaderText="Finding" SortExpression="OT_Finding" />
                <asp:BoundField DataField="OT_Procedure" HeaderText="Procedure" SortExpression="OT_Procedure" />
                <asp:BoundField DataField="OT_Complication" HeaderText="Complication" SortExpression="OT_Complication" />
                <asp:BoundField DataField="OT_Closure" HeaderText="Closure" SortExpression="OT_Closure" />
                <asp:BoundField DataField="OT_Drain" HeaderText="Drain" SortExpression="OT_Drain" />
                <asp:BoundField DataField="OT_OtherInfo" HeaderText="Detail" SortExpression="OT_OtherInfo" />
                <asp:BoundField DataField="Specimen_Collected" HeaderText="Specimen Collected" SortExpression="Specimen_Collected" />
                <asp:BoundField DataField="Fluids_Infused" HeaderText="Fluids Infused" SortExpression="Fluids_Infused" />
                <asp:BoundField DataField="Start Time" HeaderText="Start Time" SortExpression="Start Time" />
                <asp:BoundField DataField="End Time" HeaderText="End Time" SortExpression="End Time" />
                <asp:BoundField DataField="Anesthesia_Type" HeaderText="Anesthesia Type" SortExpression="Anesthesia_Type" />
                <asp:BoundField DataField="Shift_To" HeaderText="Shift To" SortExpression="Shift_To" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
           <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
    </asp:Panel></div>   
   			 <div class="TabbedPanelsContent"><asp:Panel ID="Panel_Employee" runat="server" Width="100%">
                    &nbsp;<table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
            <tr>
                <td width="30%" align="right" >
                    Department :</td>
                <td >
                    <asp:UpdatePanel id="UpdatePanel1" runat="server">
                        <contenttemplate>
<asp:DropDownList id="DropDownList_Department" runat="server"   DataSourceID="SqlDataSource_Department" DataValueField="Dept_ID" DataTextField="Dept_Name" AutoPostBack="True"></asp:DropDownList>
</contenttemplate>
                  </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td align="right" >
                    Employee :</td>
                <td >
                    <asp:UpdatePanel id="UpdatePanel2" runat="server">
                        <contenttemplate>
<asp:DropDownList id="DropDownList_Employee" runat="server"   DataSourceID="SqlDataSource_Employee" DataValueField="EmpID" DataTextField="Employee Name"></asp:DropDownList>
</contenttemplate>
                  </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td align="right" >
                    Roll :</td>
                <td >
                    <asp:DropDownList ID="DropDownList_Roll" runat="server" DataSourceID="SqlDataSource_Roll"
                        DataTextField="Roll_Name" DataValueField="Roll_Id"  >
                </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right" >
                </td>
                <td >
                <asp:Button ID="Button_Save" runat="server" Text="Save" /></td>
            </tr>
           
        </table> 
        <br />

         <asp:GridView ID="GridView_Ot_Pt_Staff" runat="server" AutoGenerateColumns="False"
                DataSourceID="SqlDataSource_ot_Pt_Staff"   Width="100%" DataKeyNames="OT_Staff_ID">
                        
                        <Columns>
                            <asp:BoundField DataField="Roll_Name" HeaderText="Roll Name" SortExpression="Roll_Name" />
                            <asp:BoundField DataField="Employee Name" HeaderText="Employee Name" SortExpression="Employee Name" />
                            <asp:CommandField ShowDeleteButton="True" />
                        </Columns>
                         <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
          </asp:GridView>
        
        <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT Dept_ID, Dept_Name FROM Department "></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            SelectCommand="SELECT EmpID, Prefix+' '+ isnull(EFName,'') +' '+ isnull(EMName,'') +' '+ isnull(ELName,'') as [Employee Name]  FROM Employee where DeptID=@DeptID">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_Department" Name="DeptID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Roll" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
            SelectCommand="SELECT Roll_Id, Roll_Name FROM OT_Staff_Roll"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_ot_Pt_Staff" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
            DeleteCommand="DELETE FROM [OT_Pt_Staff] WHERE [OT_Staff_ID] = @OT_Staff_ID"
            InsertCommand="INSERT INTO [OT_Pt_Staff] ([OT_Performed_By], [OT_Roll], [Operation_List_Id]) VALUES (@OT_Performed_By, @OT_Roll, @Operation_List_Id)"
            SelectCommand="SELECT OT_Pt_Staff.OT_Staff_ID, OT_Pt_Staff.OT_Performed_By, OT_Pt_Staff.OT_Roll, OT_Pt_Staff.Operation_List_Id, Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS [Employee Name], OT_Staff_Roll.Roll_Name FROM OT_Pt_Staff INNER JOIN OT_Staff_Roll ON OT_Pt_Staff.OT_Roll = OT_Staff_Roll.Roll_Id INNER JOIN Employee ON OT_Pt_Staff.OT_Performed_By = Employee.EmpID WHERE (OT_Pt_Staff.Operation_List_Id = @Operation_List_Id)"
            UpdateCommand="UPDATE [OT_Pt_Staff] SET [OT_Performed_By] = @OT_Performed_By, [OT_Roll] = @OT_Roll, [Operation_List_Id] = @Operation_List_Id WHERE [OT_Staff_ID] = @OT_Staff_ID">
            <SelectParameters>
                <asp:QueryStringParameter Name="Operation_List_Id" QueryStringField="OrderId" Type="Int32"  />                
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="OT_Staff_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="OT_Performed_By" Type="Int32" />
                <asp:Parameter Name="OT_Roll" Type="Int32" />
                <asp:Parameter Name="Operation_List_Id" Type="Decimal" />
                <asp:Parameter Name="OT_Staff_ID" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="DropDownList_Employee" Name="OT_Performed_By" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList_Roll" Name="OT_Roll" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:QueryStringParameter Name="Operation_List_Id" QueryStringField="OrderId" Type="Int32"  />                
            </InsertParameters>
        </asp:SqlDataSource>
    </asp:Panel>
   </div>   
            

<div style="display:none" class="TabbedPanelsContent">

 <asp:Panel ID="Panel2" runat="server" width="100%">
        <table cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td colspan="2">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr> 
                            <td valign="top"  colspan="2"><strong>Operation List</strong>
                                </td>
                          
                        </tr>
                        <tr>
                            <td valign="top" colspan="2">
                                
                                <asp:ListBox ID="ListBox_OperationName" runat="server" CssClass="input_txt" Height="75px"
                                    Width="98%"></asp:ListBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right" style="height: 18px" width="35%">
                    Operation&nbsp; :&nbsp;
                </td>
                <td style="height: 18px">
                    <asp:TextBox ID="TextBox_Operation" runat="server" AutoPostBack="True" CssClass="input_txt"
                        TabIndex="7" Width="294px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="Button_Save_Proceedure" runat="server" CssClass="btn1" Text="Save" />
                    <asp:Label ID="Label_Message" runat="server" CssClass="err"></asp:Label>
                    <asp:SqlDataSource ID="SqlDataSourceOperationName" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                        SelectCommand="SELECT Procedure_id, Procedure_Name FROM Procedure_Name WHERE (dept_id = @dept_id) ">
                        <SelectParameters>
                            <asp:SessionParameter Name="dept_id" SessionField="dept_id" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_Group_Names" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT [Group_Name] FROM [Blood_Group]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_Save_Info" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                        InsertCommand="Insert_ot_Operation" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:OperationTheaterConnectionString.ProviderName %>">
                        <InsertParameters>
                            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                            <asp:SessionParameter Name="Order_by_Doctor" SessionField="Emp_ID" />
                            <asp:ControlParameter ControlID="DropDownListOperationName" Name="Operation" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="TextBox_Advice" Name="Advice" PropertyName="Text" />
                            <asp:ControlParameter ControlID="DropDownList_Urgency" Name="Urgency" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="TextBox_CanDelay_For" Name="CanDelayFor" PropertyName="Text" />
                            <asp:ControlParameter ControlID="DropDownList_Fit_Status" Name="Fit_Status" PropertyName="SelectedValue" />
                            <asp:Parameter DefaultValue="4" Name="to_sub_Dept" Type="Int32" />
                            <asp:SessionParameter DefaultValue="" Name="by_sub_dept_id" SessionField="SubDeptID"
                                Type="Int32" />
                            <asp:Parameter DefaultValue="false" Name="status" Type="Boolean" />
                            <asp:Parameter DefaultValue="1" Name="request_type_id" Type="Int32" />
                            <asp:ControlParameter ControlID="txt_Day_Stay" Name="NoEDStay" PropertyName="Text"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DDL_AnaesType" Name="AnaesthesiaType" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="RBL_BloodReqired" DefaultValue="" Name="BloodRequired"
                                PropertyName="SelectedValue" Type="Boolean" />
                            <asp:ControlParameter ControlID="DDL_OPDays" Name="OT_Day" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DDL_OPTheatre" Name="OT_Room" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownListShift" Name="ShiftID" PropertyName="SelectedValue"
                                Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceOPTheatre" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                        SelectCommand="SELECT    distinct  BasicDataInfo.dbo.SubDepartment.SubDept_Name, BasicDataInfo.dbo.SubDepartment.SubDept_Id&#13;&#10;FROM         OT_Days INNER JOIN&#13;&#10;                      BasicDataInfo.dbo.SubDepartment ON OT_Days.OperationTheatreId = BasicDataInfo.dbo.SubDepartment.SubDept_Id&#13;&#10;WHERE     (OT_Days.Dept_id = @Dept_id) AND (OT_Days.SubDept_id = @SubDept_id)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenFieldDeptID" Name="Dept_id" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenFieldSubDeptID" Name="SubDept_id" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceOTDays" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                        SelectCommand="SELECT DISTINCT BasicDataInfo.dbo.Week_Day.Day_ID, BasicDataInfo.dbo.Week_Day.Day_Name FROM OT_Days INNER JOIN BasicDataInfo.dbo.Week_Day ON OT_Days.Day = BasicDataInfo.dbo.Week_Day.Day_ID WHERE (OT_Days.Dept_id = @Dept_id) AND (OT_Days.SubDept_id = @SubDept_id)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenFieldDeptID" Name="Dept_id" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenFieldSubDeptID" Name="SubDept_id" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    &nbsp;
                    <asp:HiddenField ID="HiddenFieldDeptID" runat="server" />
                    <asp:HiddenField ID="HiddenFieldSubDeptID" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSource_Operation_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                        SelectCommand="SELECT ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS [Recomended By], Pt_Operation_Recommended.RegNo, Pt_Operation_Recommended.YearlyNo, Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName, ISNULL(Patient.Relation, '') + ' ' + ISNULL(Patient.RFName, '') + ' ' + ISNULL(Patient.RMName, '') + ' ' + ISNULL(Patient.RLName, '') AS Relation, Pt_Operation_Recommended.Advice, Pt_Operation_Recommended.Urgency, '' AS Procedure_Name, CONVERT (varchar, Pt_Operation_Recommended.ExpectedOPDate, 103) AS ExpectedOpDate, Week_Day.Day_Name + ' ( ' + ISNULL(Shift.ShiftName, '') + ' )' AS [Operation Day], ISNULL(Department.Dept_Name, '') + '-->' + ISNULL(SubDepartment.SubDept_Name, '') AS department, Pt_Operation_Recommended.AnaesthesiaType, Pt_Operation_Recommended.Order_by_Doctor, Hospital_Wards.Ward_Name, Hospital_Wards.Bed_No, Pt_Operation_Recommended.CanDelayFor, CONVERT (varchar, Pt_Operation_Recommended.Entry_Date, 103) AS Entry_Date, Pt_Operation_Recommended.OP_Recommended_Id FROM Department INNER JOIN SubDepartment ON Department.Dept_ID = SubDepartment.Dept_Id RIGHT OUTER JOIN Shift INNER JOIN Pt_Operation_Recommended INNER JOIN Employee ON Pt_Operation_Recommended.Order_by_Doctor = Employee.EmpID INNER JOIN Patient ON Pt_Operation_Recommended.RegNo = Patient.RegNo INNER JOIN Week_Day ON Pt_Operation_Recommended.OT_Day = Week_Day.Day_ID ON Shift.ShiftID = Pt_Operation_Recommended.ShiftID LEFT OUTER JOIN Hospital_Wards INNER JOIN Pt_Assign_Bed ON Hospital_Wards.Bed_id = Pt_Assign_Bed.Bed_id ON Pt_Operation_Recommended.RegNo = Pt_Assign_Bed.Reg_No AND Pt_Operation_Recommended.YearlyNo = Pt_Assign_Bed.Yearly_No ON SubDepartment.SubDept_Id = Pt_Operation_Recommended.OT_Room WHERE (Pt_Operation_Recommended.RegNo = @Reg_No) AND (Pt_Operation_Recommended.YearlyNo = @Yearly_No) AND (CONVERT (varchar, Pt_Operation_Recommended.ExpectedOPDate, 103) = @date) ORDER BY Pt_Operation_Recommended.OP_Recommended_Id">
                        <SelectParameters>
                            <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" Type="String" />
                            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="String" />
                            <asp:ControlParameter ControlID="HiddenField_select_date" Name="date" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_OP_Recommended_Id" runat="server" />
                    <asp:HiddenField ID="HiddenField_select_date" runat="server" />
                    &nbsp; &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>


</div>

 </div></div>


   
   
   
   
   
   
    
  
                <asp:HiddenField ID="HiddenField_Performed_By" runat="server" />
   
                <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:OperationTheaterConnectionString.ProviderName %>"
                    SelectCommand="SELECT CONVERT (varchar, OperationNotes.datetime, 107) AS Date, CONVERT (varchar, OperationNotes.datetime, 108) AS Time, OperationNotes.OperationFindings, OperationNotes.PostOperationInstructions, OperationNotes.isBiopsy, Procedure_Name.Procedure_Name, Incision.name FROM Incision INNER JOIN OperationNotes ON Incision.id = OperationNotes.Incision INNER JOIN Procedure_Name ON OperationNotes.OperationName = Procedure_Name.Procedure_id WHERE (OperationNotes.regno = @regno)">
                    <SelectParameters>
                        <asp:SessionParameter Name="regno" SessionField="registrationNo" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField3" runat="server" Value="0" />
                <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
 
 
 
 
 
 
 <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Patient OT Status</h4>
                </div>
                <div class="modal-body">
                    <asp:Label Font-Size="16px" ID="lblMessage" runat="server"></asp:Label>
                </div>

            </div>
        </div>
    </div>
 
 
 
 
 
 
 
 
 
 

    <br />
    
    
     
</td>
</tr>
</table>
 <script type="text/javascript">
var cookies = Spry.Utils.Cookie("read","tabbedpanels_ot1");
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
Spry.Utils.addUnLoadListener(function(){
    // save the current value
    Spry.Utils.Cookie('create','tabbedpanels_ot1',TabbedPanels1.getCurrentTabIndex());
});



</script>
  


</asp:Content>