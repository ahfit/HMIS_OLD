<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_Select_Test.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="Pt_Select_Test1" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script language="javascript" type="text/javascript">

function CheckRequiredField(Element_ID,TB_ID)
{
   
    //Bilirubin="TextBoxT0134"
    //Indirect="TextBoxT0136"
    //Direct="TextBoxT01649"
    //Total Proteins="TextBoxT0142"
    //Albumin="TextBoxT0143"
    //Globulin="TextBoxT0144"
    //A/G Ratio="TextBoxT0145"
    
    //Total Lipids="TextBoxT0151"
    //Trigiycerides="TextBoxT0152"
    //Cholesterol="TextBoxT0153"
    //H.D.L.="TextBoxT0154"
    //L.D.L.="TextBoxT0155"
    //V.L.D.L.="TextBoxT0156"
    //Chylomicrons.="TextBoxT0157"
    
    //24 Hr Urine Protein="TextBoxT0216"
    //Serum Creatinine ="TextBoxT0131"
    //Creatinine Clearance ="TextBoxT0132"
    //Blood Urea ="TextBoxT0130"
    
    //alert(Element_ID);
    if(TB_ID==369||TB_ID==94||TB_ID==93||TB_ID==95)
    {
        var Bilirubin = document.getElementById("TextBoxT0134").value;
        var InDirect = document.getElementById("TextBoxT0136").value;
        document.getElementById("TextBoxT01649").value=Bilirubin-InDirect;
        if(document.getElementById("TextBoxT0142").value!="")
        {
            var Globulin=document.getElementById("TextBoxT0142").value - document.getElementById("TextBoxT0143").value;
            document.getElementById("TextBoxT0144").value = Globulin;
            var AGRatio=document.getElementById("TextBoxT0143").value/document.getElementById("TextBoxT0144").value;
            document.getElementById("TextBoxT0145").value=AGRatio;
        }
    }
    else if(TB_ID==378)
    {
        if (document.getElementById("TextBoxT0152").value<450)
        {
            if(document.getElementById("TextBoxT0154").value!="" && document.getElementById("TextBoxT0153").value!="")
            {
                var LDL=document.getElementById("TextBoxT0153").value-document.getElementById("TextBoxT0154").value-(document.getElementById("TextBoxT0152").value/5);
                document.getElementById("TextBoxT0155").value=LDL;
                var VLDL=document.getElementById("TextBoxT0153").value-(document.getElementById("TextBoxT0154").value+LDL);
                document.getElementById("TextBoxT0156").value=VLDL;
            }
        }
    }
    else if(TB_ID==370)
    {
        if(document.getElementById("TextBoxT0131").value.length!=0 && document.getElementById("TextBoxT0216").value.length!=0)
        {
            var a=document.getElementById("TextBoxT0130").value*document.getElementById("TextBoxT0216").value;    
            var b=document.getElementById("TextBoxT0131").value*1440;
            document.getElementById("TextBoxT0132").value=Math.round(a/b);
        }
    }
    return;
}
</script>
  <script src="../css_hacims/autoresize.jquery.min.js" type="text/javascript" ></script>
  <script type="text/javascript">$(document).ready(function(){$("textarea#ctl00_ContentPlaceHolder1_TextBox_Description").autoResize({}); });</script>
  <style type="text/css">
.bx_oplist a {
	color:#1a4796;
	font-size:11px;
}
.bx_oplist a:hover {
	color:#d71635;
}
#nav {
	display:none;
}
      .style1
      {
          width: 130px;
      }
      .btn1
      {}
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:Label ID="Label_message" runat="server"  CssClass="err"></asp:Label>
<asp:DataList ID="DataListtemplate" runat="server" DataKeyField="Template_id" DataSourceID="SqlDataSourceTemplate"
            RepeatColumns="5" RepeatDirection="Horizontal"  Width="100%" Visible="False">
  <ItemTemplate>
    <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" CssClass="login_link"
                    ForeColor="Blue" Text='<%# Eval("Template_Name", "{0}") %>'></asp:LinkButton>
  </ItemTemplate>
  <SeparatorStyle BorderWidth="1px" CssClass="griditem" />
</asp:DataList>
<asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
  <SelectParameters>
    <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
    <asp:SessionParameter Name="deptid" SessionField="dept_id" />
  </SelectParameters>
</asp:SqlDataSource>
<%--<asp:ScriptManager id="ScriptManager1" runat="server"> </asp:ScriptManager>--%>
<%--<cc1:AutoCompleteExtender ID="autoComplete_Template" runat="server" CompletionInterval="10"
                      CompletionSetCount="100" EnableCaching="true" MinimumPrefixLength="2" ServiceMethod="Search_Templates"
                      ServicePath="../AutoComplete.asmx" TargetControlID="TextBox_Template"> </cc1:AutoCompleteExtender>--%>
<%--<asp:UpdatePanel id="UpdatePanel1" runat="server" >
  <contenttemplate>--%>
    <TABLE class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border=0>
      <TBODY>
        <TR>
          <TD align=right width="40%">Machine Name : <asp:DropDownList id="DropDownList_machine" runat="server" DataSourceID="SqlDataSource_Mechine" DataValueField="Machine_Id" DataTextField="Machine_Name"></asp:DropDownList> </TD>
          <TD style="WIDTH: 163px">&nbsp;
            <asp:Button id="Button1" runat="server" Text="Upload"></asp:Button></TD>
          <TD style="WIDTH: 70px">Refer From :</TD>
          <TD class="style1"><asp:TextBox id="TextBox_Refer_By" runat="server"></asp:TextBox></TD>
            <td>
                &nbsp;</td>
        </TR>
      </TBODY>
    </TABLE>
    <asp:SqlDataSource id="SqlDataSource_Mechine" runat="server" SelectCommand="SELECT Machine_Id, Machine_Name FROM Lab_Machines" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"></asp:SqlDataSource>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <asp:SqlDataSource id="SqlDataSource_machines_main_ID" runat="server" ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT     PT_TestMessages.Pt_Message_Id, case when PT_TestMessages.Machine_Sample_No=Convert(varchar,Path_Result_Delivery.Main_ID) then  PT_TestMessages.Machine_Sample_No else  PT_TestMessages.Sample_No end as [Sample_No],Lab_Machines.Machine_Name, PT_TestMessages.Machine_Sample_No, &#13;&#10;                      Path_Result_Delivery.Main_ID&#13;&#10;FROM         PT_TestMessages INNER JOIN&#13;&#10;                      Lab_Machines ON PT_TestMessages.Machine_id = Lab_Machines.Machine_Id LEFT OUTER JOIN&#13;&#10;                      Path_Result_Delivery ON PT_TestMessages.Machine_Sample_No = Convert(varchar,Path_Result_Delivery.Main_ID) &#13;&#10;  WHERE (Lab_Machines.Machine_Id = @mID) and (PT_TestMessages.Status_Id=0) " ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>" UpdateCommand="UPDATE PT_TestMessages SET Sample_No = @Sample_No WHERE (Machine_Sample_No = @Sample_No)" InsertCommand="INSERT INTO [PT_TestMessages] ([Sample_No]) VALUES (@Sample_No)" DeleteCommand="DELETE FROM [PT_TestMessages] WHERE [Pt_Message_Id] = @Pt_Message_Id">
      <SelectParameters>
        <asp:ControlParameter ControlID="DropDownList_machine" PropertyName="SelectedValue" Name="mID"></asp:ControlParameter>
      </SelectParameters>
      <DeleteParameters>
        <asp:Parameter Name="Pt_Message_Id" Type="Decimal"></asp:Parameter>
      </DeleteParameters>
      <UpdateParameters>
        <asp:QueryStringParameter QueryStringField="Main_ID" Name="Sample_No" Type="String"></asp:QueryStringParameter>
      </UpdateParameters>
      <InsertParameters>
        <asp:Parameter Name="Sample_No" Type="String"></asp:Parameter>
      </InsertParameters>
    </asp:SqlDataSource>
  <%--</contenttemplate>
</asp:UpdatePanel>--%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="25%"><div class="bxmain" style="width:98%;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
          <tr>
            <td align="right">Test Group :</td>
            <td><asp:DropDownList ID="DropDownList_Test_Group" runat="server" datasourceid="SqlDataSource_TG"
                    DataTextField="TGName" DataValueField="TGID" Width="150px" 
                    AutoPostBack="True"> </asp:DropDownList></td>
          </tr>
          <tr>
            <td align="right">&nbsp;</td>
            <td><asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                <asp:ListItem Value="new">Single</asp:ListItem>
                <asp:ListItem Selected="True" Value="old">Double</asp:ListItem>
              </asp:RadioButtonList></td>
          </tr>
          <tr>
            <td align="right">Test Name :</td>
            <td><asp:DropDownList ID="DropDownList_TestName" runat="server" datasourceid="SqlDataSource_Status"
                    DataTextField="TB_Name" DataValueField="TB_ID" Width="150px"> </asp:DropDownList></td>
          </tr>
          <tr>
            <td align="right">Status :</td>
            <td><asp:DropDownList ID="DropDownList_Status" runat="server" datasourceid="SqlDataSource_Status_Edit"
                                      DataTextField="Status" DataValueField="Status_ID" Width="150px"> </asp:DropDownList>
              <asp:SqlDataSource ID="SqlDataSource_Status_Edit" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                                      ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT Status, Status_ID FROM Test_Status WHERE (Priority < 2) AND (NOT (Priority IS NULL))"> </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Bind("ID", "{0}") %>' /></td>
          </tr>
          <tr>
            <td align="right">&nbsp;</td>
            <td><asp:Button ID="Button_Draw" runat="server" Text="Draw" Width="64px" />
              <asp:Button ID="Button_update" runat="server" Text="Change Status" Width="96px" />
              <asp:Button ID="Button_SampleReport" runat="server" Text="Sample Report"   />
              <asp:LinkButton ID="LinkButton_Attach_Image" runat="server" CssClass="report">Attach Image</asp:LinkButton></td>
          </tr>
        </table>
        <br />
        <asp:DataList ID="DataList1" runat="server" DataKeyField="ID" DataSourceID="SqlDataSource_Status" Width="100%">
          <ItemTemplate>
            <div class="bx_oplist" style="width:94%; margin-left:10px;">
              <ul style="margin-left:10px;">
                <li>
                  <asp:LinkButton ID="LinkButton_TB_ID" runat="server" CommandName="Select" Text='<%# Eval("TB_Name", "{0}") %>'></asp:LinkButton>
                </li>
                <li>Sample # <strong>
                  <asp:Label ID="Sample_No_Label" runat="server" Text='<%# Eval("Sample_No", "{0}") %>'></asp:Label>
                  </strong></li>
              </ul>
              <p>&nbsp; </p>
            </div>
            <asp:HiddenField ID="HiddenField6" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
            <asp:HiddenField ID="HiddenField7" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
            <asp:HiddenField ID="HiddenField8" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
            <asp:HiddenField ID="HiddenFieldTBID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
          </ItemTemplate>
        </asp:DataList>
      </div></td>
    <td valign="top"><div class="bxmain">
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
          <tr>
            <td align="center" >
                <asp:Button ID="Button_Sesch" runat="server" Text="Search" 
                    Height="26px" Visible="False" />
                <asp:DropDownList ID="DropDownList_Patients" runat="server" Height="29px" 
                    Width="493px" DataSourceID="SqlDataSource_Booking" 
                    DataTextField="Sample_No" DataValueField="PatientNo" Visible="False">
                </asp:DropDownList>
              </td>
          </tr>
        </table>
      </div>
      <br />
      <asp:Panel ID="Panel1" runat="server" Width="100%">
        </asp:Panel>
      <br />
      <fieldset class="remarks">
        <legend>
        <asp:Label ID="Label_Description" runat="server" CssClass="err" Text="Description :" Visible="False" ></asp:Label>
        </legend>
        <asp:TextBox ID="TextBox_Description" runat="server" Rows="5" Height="150px" TextMode="MultiLine" Visible="False" Width="100%" ></asp:TextBox>
        <table>
          <tr>
            <td align="right" style="width: 100px"> Templates :</td>
            <td style="width: 100px"><asp:TextBox ID="TextBox_Template" runat="server" 
                    Width="528px" AutoPostBack="True" Visible="False"></asp:TextBox></td>
          </tr>
          <tr>
            <td style="width: 100px"></td>
            <td style="width: 100px"><asp:ListBox ID="ListBox_Template" runat="server" 
                    AutoPostBack="True" DataSourceID="SqlDataSource_Template"
                    DataTextField="Template_Detail" DataValueField="Template_Detail" 
                    Width="538px"></asp:ListBox></td>
          </tr>
        </table>
        <br />
        <div align="center">
            <asp:TextBox ID="TextBox_Mr_No" runat="server" Width="150px" Visible="False"></asp:TextBox>
            <asp:TextBox ID="TextBox_Visit_No" runat="server" Width="150px" Visible="False"></asp:TextBox>
            <asp:TextBox ID="TextBox_Sample_No" runat="server" Width="128px" 
                Visible="False"></asp:TextBox>
          <asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" 
                Width="68px" />
          &nbsp;
          <asp:Button ID="ButtonFinal" runat="server" CssClass="btn1" Text="Final" 
                Height="25px" Width="63px" />
          <asp:LinkButton ID="LinkButton_Show_Report" runat="server" CssClass="report" Visible="False"><span></span>Show Report</asp:LinkButton>
          <asp:LinkButton ID="LinkButton_Track" runat="server" CssClass="report" Visible="False">Audit History</asp:LinkButton>
        </div>
        <br />
      </fieldset>
      <asp:HiddenField ID="HiddenField_MachineTBID" runat="server" />
      <asp:HiddenField ID="HiddenField_ComDataType" runat="server" />
      <asp:HiddenField ID="HiddenField_FloatDigit" runat="server" />
      <asp:SqlDataSource ID="SqlDataSource_Template" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
            SelectCommand="SELECT [Template_Detail]  FROM [Pathology_Templates] where TB_ID=@TB_ID">
        <SelectParameters>
          <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value" />
        </SelectParameters>
      </asp:SqlDataSource>
      </td>
  </tr>
</table>
<asp:SqlDataSource ID="SqlDataSource_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="pt_select_status"
                      UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE TB_ID =@TB_ID and  Main_ID =@Main_ID" SelectCommandType="StoredProcedure">
  <UpdateParameters>
    <asp:ControlParameter ControlID="HiddenField_Edit_Status" Name="Status" PropertyName="Value" />
    <asp:ControlParameter ControlID="DropDownList_TestName" Name="TB_ID" PropertyName="SelectedValue" />
    <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" />
  </UpdateParameters>
  <SelectParameters>
    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
    <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
    <asp:QueryStringParameter DefaultValue="" Name="Status" QueryStringField="Status"
                              Type="Int32" />
    <asp:QueryStringParameter Name="Sample_No" QueryStringField="sample_No" Type="String" />
      <asp:ControlParameter ControlID="DropDownList_Test_Group" Name="TG_ID" 
          PropertyName="SelectedValue" Type="Int32" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_TG" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT 
                      Test_Status.Status, CONVERT(varchar, Path_Result_Delivery.Sample_Collection_Date, 107) AS Date_Time, TestGroup.TGName, TestGroup.TGID, 
                      Test_Main_Sub_Grouping.MS_TGID, Path_Result_Delivery.Main_ID, Test_Status.Status_ID, Investigation_Order_Sub.Description AS [Clinical Notes], 
                      TestGroup.Priority
FROM         Investigation_Order_Sub INNER JOIN
                      Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID RIGHT OUTER JOIN
                      Test_Booking_Services INNER JOIN
                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN
                      Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN
                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN
                      Test_Main_Sub_Grouping ON TestGroup.TGID = Test_Main_Sub_Grouping.TGID INNER JOIN
                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID ON Investigation_Order_Sub.TB_ID = Test_Booking_Services.TB_ID AND 
                      Investigation_Order_Main.RegNo = Path_Result_Delivery.Reg_no AND Investigation_Order_Main.YearlyNo = Path_Result_Delivery.Yearly_No
  WHERE     (Test_Status.Status_ID = @Status) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND 
                      (Path_Result_Delivery.Main_ID = @Main_ID) AND (Test_Booking_Services.Sample_No = @Sample_No)

  order by  TestGroup.Priority">
  <SelectParameters>
    <asp:QueryStringParameter DefaultValue="" Name="Status" QueryStringField="Status"
                Type="Int32" />
    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
    <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
    <asp:QueryStringParameter DefaultValue="" Name="Sample_No" QueryStringField="sample_no" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        InsertCommand="insert_lab_status_record" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" 
        UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status  WHERE (Main_ID = @Main_ID) AND (TB_ID = @TB_ID) " 
        SelectCommand="Search_hospital_Pt_group_wise_Dropdown" 
        SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:QueryStringParameter Name="Status_ID" QueryStringField="status" 
            Type="Int32" />
        <asp:SessionParameter DefaultValue="1087" Name="to_dept" SessionField="Dept_id" 
            Type="Int32" />
        <asp:SessionParameter DefaultValue="1087" Name="to_Subdept" 
            SessionField="SubDeptId" Type="Int32" />
        <asp:ControlParameter ControlID="DropDownList_Test_Group" Name="TestGroup_Id" 
            PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
  <UpdateParameters>
    <asp:ControlParameter ControlID="DropDownList_Status" DefaultValue="" Name="Status"
                PropertyName="SelectedValue" />
    <asp:QueryStringParameter DefaultValue="" Name="Main_ID" QueryStringField="Main_ID" />
    <asp:ControlParameter ControlID="DropDownList_TestName" DefaultValue="" Name="TB_ID"
                PropertyName="SelectedValue" />
  </UpdateParameters>
  <InsertParameters>
    <asp:QueryStringParameter DefaultValue="" Name="Main_ID" QueryStringField="Main_ID"
                Type="Int32" />
    <asp:ControlParameter ControlID="DropDownList_Status" DefaultValue="" Name="Status"
                PropertyName="SelectedValue" Type="Int32" />
    <asp:ControlParameter ControlID="DropDownList_TestName" Name="TB_ID" PropertyName="SelectedValue"
                Type="Int32" />
      <asp:SessionParameter Name="Emp_Id" SessionField="Emp_Id" Type="Int32" />
      <asp:ControlParameter ControlID="HiddenField_SystemIP" Name="System_IP" 
          PropertyName="Value" Type="String" />
  </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_Group" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT &#13;&#10;                      &#13;&#10;                      TestGroup.TGName, TestGroup.TGID&#13;&#10;FROM         Investigation_Order_Sub INNER JOIN&#13;&#10;                      Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID RIGHT OUTER JOIN&#13;&#10;                      Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN&#13;&#10;                      Test_Main_Sub_Grouping ON TestGroup.TGID = Test_Main_Sub_Grouping.TGID INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID ON Investigation_Order_Sub.TB_ID = Test_Booking_Services.TB_ID AND &#13;&#10;                      Investigation_Order_Main.RegNo = Path_Result_Delivery.Reg_no AND Investigation_Order_Main.YearlyNo = Path_Result_Delivery.Yearly_No&#13;&#10;WHERE     (Test_Status.Status_ID = @Status) AND (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND &#13;&#10;                      (Path_Result_Delivery.Main_ID = @Main_ID)">
  <SelectParameters>
    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
    <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
    <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="HiddenField_Edit_Status" runat="server" />
<asp:HiddenField ID="HiddenField_Edit_ID" runat="server" />
<asp:DataList ID="DataListMainGroup" runat="server" DataKeyField="MS_TGID" DataSourceID="SqlDataSourceMainGroup"
            RepeatColumns="4" Style="position: static" Width="100%" Visible="False">
  <ItemTemplate>
    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="login_link"
                    Text='<%# Eval("TGName", "{0}") %>' Width="208px"></asp:LinkButton>
    <br />
    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
    <asp:HiddenField ID="HiddenField4" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
    <asp:HiddenField ID="HiddenField5" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
  </ItemTemplate>
</asp:DataList>
<asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
            SelectCommand="pt_main_group" SelectCommandType="StoredProcedure">
  <SelectParameters>
    <asp:SessionParameter DefaultValue="" Name="payid" SessionField="YearlyNo" />
    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="HiddenFieldCategory" runat="server" />
<asp:HiddenField ID="HiddenFieldMainID" runat="server" />
<asp:HiddenField ID="HiddenField_TBID" runat="server" />
<asp:HiddenField ID="HiddenField_Component_Id" runat="server" />
<asp:HiddenField ID="HiddenField_Component_Value" runat="server" />
<asp:HiddenField ID="HiddenField_SampleNo" runat="server" />
<asp:SqlDataSource ID="SqlDataSource_Message" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        InsertCommand="INSERT INTO PT_TestMessages(Sample_No, Sent_Message, Received_Message) VALUES (@Sample_No, @Sent_Message, @Received_Message)"
        SelectCommand="SELECT [Pt_Message_Id], [Sample_No], [Sent_Message], [Received_Message], [Status_Id], [Machine_id] FROM [PT_TestMessages]">
  <InsertParameters>
    <asp:Parameter DefaultValue="1222" Name="Sample_No" />
    <asp:ControlParameter ControlID="TextBox1" Name="Sent_Message" PropertyName="Text" />
    <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="Received_Message"
                PropertyName="Text" />
  </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_MachineResults" runat="server" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"
        InsertCommand="INSERT INTO PT_Machine_Results(Component_Id, Sample_No, Component_Value, Status_Id, Result_Datetime, TB_Id, Main_Id) VALUES (@Component_Id, @Sample_No, @Component_Value, @Status_Id, @Result_Datetime,@TB_Id, @Main_Id)"
        SelectCommand="SELECT [Component_Id], [Sample_No], [Component_Value], [Status_Id], [Result_Datetime] FROM [PT_Machine_Results]">
  <InsertParameters>
    <asp:ControlParameter ControlID="HiddenField_Component_Id" Name="Component_Id" PropertyName="Value" />
    <asp:ControlParameter ControlID="HiddenField_SampleNo" Name="Sample_No" PropertyName="Value" />
    <asp:ControlParameter ControlID="HiddenField_Component_Value" Name="Component_Value"
                PropertyName="Value" />
    <asp:Parameter DefaultValue="0" Name="Status_Id" />
    <asp:ControlParameter ControlID="HiddenField_Datetime" DefaultValue="" Name="Result_Datetime"
                PropertyName="Value" />
    <asp:ControlParameter ControlID="HiddenField_MachineTBID" Name="TB_Id" PropertyName="Value" />
    <asp:QueryStringParameter Name="Main_Id" QueryStringField="Main_Id" />
  </InsertParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="HiddenField_MGID" runat="server" />
<asp:SqlDataSource ID="SqlDataSource_machine_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        SelectCommand="SELECT [Machines_status_ID], [Machines_status] FROM [Machines_Status]"
        UpdateCommand="UPDATE [Admin_Pathology].[dbo].[PT_TestMessages]&#13;&#10;   SET [Status_Id] =1&#13;&#10; Where Sample_No=@SampleNo">
  <UpdateParameters>
    <asp:ControlParameter ControlID="HiddenField_SampleNo" Name="SampleNo" PropertyName="Value" />
  </UpdateParameters>
</asp:SqlDataSource>
<asp:Label ID="Label1" runat="server" Text="Label" Visible="False" CssClass="err"></asp:Label>
<br />
<asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
<asp:SqlDataSource ID="SqlDataSource_UpdateStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Forward_To_Sub_Dept SET status = @status WHERE (Reg_No = @Reg_No) AND (yearly_no = @yearly_no) AND (to_sub_Dept = @to_sub_Dept)">
  <UpdateParameters>
    <asp:Parameter DefaultValue="1" Name="status" />
    <asp:SessionParameter DefaultValue="" Name="Reg_No" SessionField="registrationNo" />
    <asp:SessionParameter Name="yearly_no" SessionField="YearlyNo" />
    <asp:Parameter DefaultValue="13" Name="to_sub_Dept" />
  </UpdateParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="HiddenField3" runat="server" Value="0" />
<asp:HiddenField ID="HiddenField_MS_TGID" runat="server" Value="0" />
<asp:HiddenField ID="HiddenField_TSGID" runat="server" Value="0" />
<asp:HiddenField ID="HiddenField_TGID" runat="server" />
<asp:HiddenField ID="HiddenField_TG_ID" runat="server" />
<asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" UpdateCommand="UPDATE PatientsLabTest SET Status = @Status WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
  <UpdateParameters>
    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
    <asp:Parameter DefaultValue="6" Name="Status" />
    <asp:SessionParameter DefaultValue="" Name="PayID" SessionField="YearlyNo" />
  </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_Update_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" UpdateCommand="Update_Patient_Test_Status" UpdateCommandType="StoredProcedure">
  <UpdateParameters>
    <asp:Parameter DefaultValue="6" Name="Status" />
    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
    <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value"
                              Type="Int32" />
    <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
    <asp:QueryStringParameter Name="Old_Status" QueryStringField="Status" Type="Int32" />
      <asp:SessionParameter DefaultValue="0" Name="Emp_Id" SessionField="Emp_Id" 
          Type="Int32" />
      <asp:ControlParameter ControlID="HiddenField_SystemIP" DefaultValue="0" 
          Name="System_IP" PropertyName="Value" Type="String" />
  </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceUpdateTreatment" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" UpdateCommand="UPDATE PatientsLabTest SET Status = @Status WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
  <UpdateParameters>
    <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
    <asp:Parameter DefaultValue="6" Name="Status" />
    <asp:QueryStringParameter DefaultValue="" Name="PayID" QueryStringField="YearlyNo" />
  </UpdateParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" />
<asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
&nbsp;<asp:HiddenField ID="HiddenField_SystemIP" runat="server" />
      &nbsp;<asp:HiddenField ID="HiddenField_Datetime" runat="server" />
<asp:HiddenField ID="HiddenField_TID" runat="server" />
<br />
<asp:HiddenField ID="HiddenField_Page_type" runat="server" />
<asp:HiddenField ID="HiddenField_Flag" runat="server" Value="0" />
<asp:Panel ID="Panel_Track" runat="server" Visible="False" Width="100%"   CssClass="lightbox_bg"  >
  <div class="lightbox">
    <h1 class="h1"><span>Audit History</span></h1>
    <div style="height:320px; width:100%; overflow:auto; overflow-x:hidden;">
      <asp:GridView ID="GridView_Track" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Track" Width="100%">
        <Columns>
        <asp:BoundField DataField="TB_Name" HeaderText="Test Name" SortExpression="TB_Name" />
        <asp:BoundField DataField="Edited_By" HeaderText="Edited By" SortExpression="Edited_By" />
        <asp:BoundField DataField="ComponentName" HeaderText="Test Component" SortExpression="ComponentName" />
        <asp:BoundField DataField="TCValue" HeaderText="Component Value" SortExpression="TCValue" />
        <asp:BoundField DataField="EditedAt" HeaderText="Edited At" SortExpression="EditedAt" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <FooterStyle CssClass="GridPager" />
        <SelectedRowStyle CssClass="gridselect" />
        <HeaderStyle CssClass="GridHeader" />
        <EditRowStyle CssClass="gridedit" />
        <AlternatingRowStyle CssClass="GridAltItem" />
      </asp:GridView>
    </div>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Track" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="Path_PatientTestResult_Track"
            SelectCommandType="StoredProcedure">
      <SelectParameters>
        <asp:QueryStringParameter Name="Reg_No" QueryStringField="Reg_No" Type="String" />
        <asp:QueryStringParameter Name="Yearly_No" QueryStringField="YearlyNo" Type="Decimal" />
        <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Decimal" />
        <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value" />
      </SelectParameters>
    </asp:SqlDataSource>
    <DIV align="center">
      <asp:Button ID="Button_Track_Close" runat="server" Text="Close" />
    </DIV>
    <br />
  </div>
  </asp:Panel>
<asp:Panel ID="Panel_Missing_Component" runat="server" Visible="False" Width="100%"   CssClass="lightbox_bg" >
<div class="lightbox">
  <h1 class="h1"><span>Missing Values</span></h1>
  <asp:Label ID="Label_Missing_Component_Message" runat="server" Text="Your Information has been Saved" CssClass="red"></asp:Label>
  <br />
  <div style="height:320px; width:100%; overflow:auto; overflow-x:hidden;">
    <asp:GridView ID="GridView_Missing_Component" runat="server" AutoGenerateColumns="False" Width="100%"
            DataSourceID="SqlDataSource_Missing_Component">
      <Columns>
      <asp:BoundField DataField="TB_Name" HeaderText="Test Name" SortExpression="TB_Name" />
      <asp:BoundField DataField="ComponentName" HeaderText="Test Component" SortExpression="ComponentName" />
      </Columns>
      <RowStyle CssClass="GridItem" />
      <FooterStyle CssClass="GridPager" />
      <SelectedRowStyle CssClass="gridselect" />
      <HeaderStyle CssClass="GridHeader" />
      <EditRowStyle CssClass="gridedit" />
      <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
  </div>
  <br />
  <asp:SqlDataSource ID="SqlDataSource_Missing_Component" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="Missing_Component"
            SelectCommandType="StoredProcedure">
    <SelectParameters>
      <asp:QueryStringParameter Name="Reg_No" QueryStringField="Reg_No" Type="String" />
      <asp:QueryStringParameter Name="Yearly_No" QueryStringField="YearlyNo" Type="Decimal" />
      <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Decimal" />
    </SelectParameters>
  </asp:SqlDataSource>
  <div align="center">
    <asp:Button ID="Button_Missing_Component" runat="server" Text="Close" />
  </div>
  <br />
    </asp:Panel>
<asp:HiddenField ID="HiddenField_Description" runat="server" />
</asp:Content>
