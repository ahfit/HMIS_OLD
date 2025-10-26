<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_Select_Test1.aspx.vb" Inherits="Pt_Select_Test" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link href="../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../images/sheet_form.css" rel="stylesheet" type="text/css" />


<script src="../images/highlight.js" type="text/javascript"></script>

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}
</style>

</head>

<body><form id="form1" runat = "server">

<div id="forms_items" class="forms_items">
<asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label><br />
<asp:DataList ID="DataListtemplate" runat="server" DataKeyField="Template_id" DataSourceID="SqlDataSourceTemplate"
            RepeatColumns="5" RepeatDirection="Horizontal" Width="100%" Visible="False">
            <ItemTemplate>
                <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" CssClass="login_link"
                    ForeColor="Blue" Style="position: static" Text='<%# Eval("Template_Name", "{0}") %>'></asp:LinkButton>
            </ItemTemplate>
            <SeparatorStyle BorderWidth="1px" CssClass="griditem" />
        </asp:DataList><asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                <asp:SessionParameter Name="deptid" SessionField="dept_id" />
            </SelectParameters>
        </asp:SqlDataSource>
<br />

                  <asp:GridView ID="GridView_Test_Status" runat="server" AutoGenerateColumns="False"
                      CssClass="Grid_1" DataSourceID="SqlDataSource_Status" Width="100%">
                      <Columns>
                          <asp:BoundField DataField="TB_Name" HeaderText="Test" ReadOnly="True" SortExpression="TB_Name" />
                          <asp:TemplateField HeaderText="Status" SortExpression="Status">
                              <EditItemTemplate>
                                  <asp:DropDownList ID="DropDownList_Status" runat="server" DataSourceID="SqlDataSource_Status_Edit"
                                      DataTextField="Status" DataValueField="Status_ID" Width="167px">
                                  </asp:DropDownList><br />
                                  <asp:SqlDataSource ID="SqlDataSource_Status_Edit" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                      ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Status, Status_ID FROM Test_Status WHERE (Status_ID = 3) OR (Status_ID = 5) OR (Status_ID = 9)">
                                  </asp:SqlDataSource>
                                  <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Bind("ID", "{0}") %>' />
                              </EditItemTemplate>
                              <ItemTemplate>
                                  <asp:Label ID="Label1" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                              </ItemTemplate>
                          </asp:TemplateField>
                          <asp:CommandField ShowEditButton="True" />
                      </Columns>
                      <RowStyle CssClass="GridItem" />
                      <HeaderStyle CssClass="GridHeader" />
                      <AlternatingRowStyle CssClass="GridAltItem" />
                  </asp:GridView><br />

                  <asp:SqlDataSource ID="SqlDataSource_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Booking.TB_Name, Test_Status.Status, Test_Booking_Services.ID FROM Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID WHERE (Test_Status.Status_ID = 1) AND (Test_Booking_Services.RegNo = @RegNo) AND (Test_Booking_Services.YearlyNo = @YearlyNo)"
                      UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE (ID = @ID)">
                      <UpdateParameters>
                          <asp:ControlParameter ControlID="HiddenField_Edit_Status" Name="Status" PropertyName="Value" />
                          <asp:ControlParameter ControlID="HiddenField_Edit_ID" Name="ID" PropertyName="Value" />
                      </UpdateParameters>
                      <SelectParameters>
                          <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                          <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
                      </SelectParameters>
                  </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenField_Edit_Status" runat="server" />
                  <asp:HiddenField ID="HiddenField_Edit_ID" runat="server" />

        <asp:DataList ID="DataListMainGroup" runat="server" DataKeyField="MS_TGID" DataSourceID="SqlDataSourceMainGroup"
            RepeatColumns="4" Width="100%">
            <ItemTemplate>
                &nbsp;
                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="login_link"
                    Text='<%# Eval("TGName", "{0}") %>' Width="100%"></asp:LinkButton><br />
                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                <asp:HiddenField ID="HiddenField4" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
                <asp:HiddenField ID="HiddenField5" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
            SelectCommand="SELECT DISTINCT &#13;&#10;                      TestGroup.TGName, TestGroup.TGID, Test_Main_Sub_Grouping.MS_TGID, Pt_Pathology_Test_Amount.Main_ID, &#13;&#10;                      MRI_Save_Patient_Next_App.Sample_Collection_Date&#13;&#10;FROM         Pt_Pathology_Test_Amount INNER JOIN&#13;&#10;                      TestSubGroup INNER JOIN&#13;&#10;                      TestGroup ON TestSubGroup.TGID = TestGroup.TGID INNER JOIN&#13;&#10;                      Test ON TestSubGroup.TSGID = Test.TSGID INNER JOIN&#13;&#10;                      Test_Main_Sub_Grouping ON TestGroup.TGID = Test_Main_Sub_Grouping.TGID ON Pt_Pathology_Test_Amount.RID = Test.TID INNER JOIN&#13;&#10;                      MRI_Save_Patient_Next_App ON Pt_Pathology_Test_Amount.Main_ID = MRI_Save_Patient_Next_App.Main_ID AND &#13;&#10;                      Pt_Pathology_Test_Amount.Reg_No = MRI_Save_Patient_Next_App.Reg_no AND &#13;&#10;                      Pt_Pathology_Test_Amount.Yearly_No = MRI_Save_Patient_Next_App.Yearly_No INNER JOIN&#13;&#10;                      Test_Booking_Services ON MRI_Save_Patient_Next_App.Yearly_No = Test_Booking_Services.YearlyNo AND &#13;&#10;                      MRI_Save_Patient_Next_App.Reg_no = Test_Booking_Services.RegNo INNER JOIN&#13;&#10;                      Test_Services ON Test_Booking_Services.TB_ID = Test_Services.TB_ID AND Test.TID = Test_Services.Test_ID INNER JOIN&#13;&#10;                      Test_Booking ON Test_Services.TB_ID = Test_Booking.TB_ID&#13;&#10;WHERE     (Pt_Pathology_Test_Amount.Reg_No = @RegNo) AND (Pt_Pathology_Test_Amount.Yearly_No = @payid) AND (Test_Booking_Services.Status = 1) OR&#13;&#10;                      (Test_Booking_Services.Status = 4)&#13;&#10;ORDER BY MRI_Save_Patient_Next_App.Sample_Collection_Date">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" Name="payid" QueryStringField="YearlyNo" />
                <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
            </SelectParameters>
        </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenFieldCategory" runat="server" />
                  <asp:HiddenField ID="HiddenFieldMainID" runat="server" />
                
                <br />
                <asp:Panel ID="Panel1" runat="server" Width="100%">
                </asp:Panel>
<br />

                  <table cellpadding="0" cellspacing="0" class="tbl_form" >
                      <tr>
                          <td align="right" >
                              <asp:Label CssClass="err" ID="Label_Description" runat="server" Text="Description :&nbsp;" Visible="False"
                                  ></asp:Label>
                              <br />                          </td>
                          <td >
                              <asp:TextBox ID="TextBox_Description" runat="server" Rows="5" TextMode="MultiLine"
                                  Visible="False" Width="736px" CssClass="input_txt" style="height:75px;"></asp:TextBox></td>
                      </tr>
                  </table>
<br />

<div align="center">
                <asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" />
                  <asp:Button ID="ButtonFinal" runat="server" CssClass="btn1" Text="Final" /></div><br />
<br />

                <asp:Label ID="Label1" runat="server" Text="Label" CssClass="err"  Visible="False"></asp:Label><br />

                <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                  <asp:SqlDataSource ID="SqlDataSourceUpdateStstus" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Forward_To_Sub_Dept SET status = @status WHERE (Reg_No = @Reg_No) AND (yearly_no = @yearly_no) AND (to_sub_Dept = @to_sub_Dept)">
                      <UpdateParameters>
                          <asp:Parameter DefaultValue="1" Name="status" />
                          <asp:SessionParameter DefaultValue="" Name="Reg_No" SessionField="registrationNo" />
                          <asp:SessionParameter Name="yearly_no" SessionField="YearlyNo" />
                          <asp:Parameter DefaultValue="13" Name="to_sub_Dept" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField3" runat="server" Value="0" /><asp:HiddenField ID="HiddenField_MS_TGID" runat="server" Value="0" /><asp:HiddenField ID="HiddenField_TSGID" runat="server" Value="0" />
                  <asp:HiddenField ID="HiddenField_TGID" runat="server" />
                  <asp:HiddenField ID="HiddenField_TG_ID" runat="server" />
                  <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" UpdateCommand="UPDATE PatientsLabTest SET Status = @Status WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
                      <UpdateParameters>
                          <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                          <asp:Parameter DefaultValue="Complete" Name="Status" />
                          <asp:QueryStringParameter DefaultValue="" Name="PayID" QueryStringField="YearlyNo" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_Update_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (Status = 4)&#13;&#10;&#13;&#10;UPDATE Test_Booking_Services_Treatment SET Status = @Status WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (Status = 4)">
                      <UpdateParameters>
                          <asp:Parameter DefaultValue="7" Name="Status" />
                          <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
                          <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceUpdateTreatment" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" UpdateCommand="UPDATE PatientsLabTest SET Status = @Status WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
                      <UpdateParameters>
                          <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                          <asp:Parameter DefaultValue="Complete" Name="Status" />
                          <asp:QueryStringParameter DefaultValue="" Name="PayID" QueryStringField="YearlyNo" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
        <br />
              
            
            
            
              <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />

                
              


</div>

</form>
</body>
</html>