<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Path_WorkList.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Pathology_Path_WorkList" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 <div class="bxmain">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="40%" align="right">  Main Group : </td>
    <td width="60%"><asp:DropDownList ID="DropDownListMain" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceMainGroup"
                    DataTextField="TGName" DataValueField="TGID" >
        </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right"> Test Booking Name : </td>
    <td> <asp:DropDownList ID="DropDownListTest" runat="server"  AutoPostBack="True" DataSourceID="SqlDataSourceTestName" DataTextField="TB_Name" DataValueField="TB_ID">
                </asp:DropDownList></td>
  </tr>
  <tr>
    <td align="right"> Test Name : </td>
    <td> <asp:DropDownList ID="DropDownListTestName" runat="server" DataSourceID="SqlDataSource2"
                    DataTextField="TestName" DataValueField="TID" AutoPostBack="True">
                </asp:DropDownList></td>
  </tr>
</table></div>

 <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                    ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT TGID, TGName FROM TestGroup">
                </asp:SqlDataSource>
 <asp:SqlDataSource ID="SqlDataSourceTestName" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT Test_Booking.TB_Name, Test_Booking.TB_ID, Test.TGID FROM Test_Services INNER JOIN Test ON Test_Services.Test_ID = Test.TID INNER JOIN Test_Booking ON Test_Services.TB_ID = Test_Booking.TB_ID WHERE (Test.TGID = @TGID) AND (Test_Booking.TB_ID IN (SELECT TB_ID FROM Test_Booking_Services WHERE (Status = 1) AND (Main_ID IS NOT NULL)))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownListMain" Name="TGID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
 <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT DISTINCT TID, TestName&#13;&#10;FROM         Test&#13;&#10;WHERE     (TID IN&#13;&#10;                          ((SELECT     Test_Services.Test_ID&#13;&#10;                              FROM         Test_Booking_Services INNER JOIN&#13;&#10;                                                    Test_Services ON Test_Booking_Services.TB_ID = Test_Services.TB_ID&#13;&#10;                              WHERE     (Test_Booking_Services.Status = 1) AND (Test_Booking_Services.Main_ID IS NOT NULL)))) AND (TGID = @TGID)&#13;&#10;">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownListMain" Name="TGID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
<br />
 <asp:GridView ID="GridViewTest" runat="server" CssClass="Grid_1" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <Columns>
                        <asp:BoundField DataField="Main_ID" HeaderText="Main ID" InsertVisible="False" ReadOnly="True"
                            SortExpression="Main_ID" />
                        <asp:BoundField DataField="Reg_no" HeaderText="Registration No." SortExpression="Reg_no" Visible="False" />
                        <asp:BoundField DataField="Yearly_No" HeaderText="Visit No." SortExpression="Yearly_No" />
                        <asp:BoundField DataField="TSGName" HeaderText="Test Sub Group Name" SortExpression="TSGName" />
                        <asp:BoundField DataField="ComponentName" HeaderText="ComponentName" SortExpression="ComponentName" />
                        <asp:TemplateField>
                            <ItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt" Width="100px" Text='<%# Eval("TCValue", "{0}") %>' MaxLength='<%# Bind("MaxLength") %>'></asp:TextBox>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBox1"
                                    ErrorMessage="Enter Correct Value" MaximumValue='<%# Eval("Max_Value") %>' MinimumValue='<%# Eval("Min_Value") %>'
                                    Type="Integer"></asp:RangeValidator>
                                
                                <asp:HiddenField ID="HiddenFieldRegNo" runat="server" Value='<%# Bind("Reg_no", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldVisitNo" runat="server" Value='<%# Bind("Yearly_No", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldMainID" runat="server" Value='<%# Bind("Main_ID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldDeptID" runat="server" Value='<%# Eval("From_Dept_ID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldSubDeptID" runat="server" Value='<%# Bind("From_SubDept_ID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldTGID" runat="server" Value='<%# Bind("TGID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldTCID" runat="server" Value='<%# Bind("TCID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldTID" runat="server" Value='<%# Eval("TID", "{0}") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="TCValue" HeaderText="Value" SortExpression="TCValue" Visible="False" />
                        <asp:BoundField DataField="TC_Range_Unit" HeaderText="Range" SortExpression="TC_Range_Unit" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" Text="Save" CssClass="btn1" CommandName="Select"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                                    </asp:GridView>                
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="Pathology_patient_workinglist"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListMain" DefaultValue="10" Name="TGID"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListTest" DefaultValue="" Name="TB_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListTestName" DefaultValue="0" Name="Test_Id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
<br />

            
   </asp:Content>