<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" 
    CodeFile="LAB_Investigation_Haematology.aspx.cs" Inherits="Finance_Reports_LAB_Investigation"   %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="cr" %>


<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="cr" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="bxmain">

  <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
        <tr>
            <td align="right" width="25%" >
          Select Hospital :</td>
            <td colspan="3">
                <asp:DropDownList ID="DropDownList_HospitalId" runat="server" DataSourceID="SqlDataSource_Hospital_Id"
                    DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="90%" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_HospitalId_SelectedIndexChanged">
                </asp:DropDownList> <asp:SqlDataSource ID="SqlDataSource_Hospital_Id" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="SELECT Hospital_ID, Hospital_Name +  '( ' + Hospital_Abb + ' ) '  AS Hospital_Name FROM Hospital ORDER BY Hospital_Name">
                </asp:SqlDataSource>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="right" >
                From Date :</td>
            <td >
                <igsch:WebDateChooser ID="WebDateChooser1" runat="server">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
              <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" />
            </td>
            
           
            <td align="right" >
          To Date :</td>
            <td >
                <igsch:WebDateChooser ID="WebDateChooser2" runat="server">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td align="right" >
          Select Category :</td>
            <td >
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                    <asp:ListItem Selected="True" Value="%">All</asp:ListItem>
                    <asp:ListItem Value="IPD">IPD</asp:ListItem>
                    <asp:ListItem Value="OPD">OPD</asp:ListItem>
                </asp:RadioButtonList></td>
            
            <td align="right" >
                <asp:Label ID="Label_Dept" runat="server" Text="Select Department" Visible="False"></asp:Label><asp:SqlDataSource
                    ID="SqlDataSourceSubDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="Select_IPD_OPD_Dept" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_DepartmentId" DefaultValue="0" Name="OPD1_IPD2"
                            PropertyName="Value" Type="Int32" />
                        <asp:ControlParameter ControlID="DropDownList_HospitalId" DefaultValue="0" Name="Hospital_ID"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td >
                &nbsp;&nbsp;
                <asp:HiddenField ID="HiddenField_DepartmentId" runat="server" Value="0" />
                <asp:DropDownList ID="DropDownListSubDepartment" runat="server" AutoPostBack="True"
                    DataSourceID="SqlDataSourceSubDepartmentName" DataTextField="SubDept_Name" DataValueField="SubDept_Id"
                    Visible="False" Width="250px">
                </asp:DropDownList></td>
        </tr>
      <tr>
          <td align="right">
              Select Patient :</td>
          <td>
                <asp:HiddenField ID="HiddenField3" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_TGID" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="SELECT [TGID], [TGName] FROM [TestGroup] ORDER BY [TGName]"></asp:SqlDataSource>
                <asp:DropDownList ID="DropDownList_TGID" runat="server" DataSourceID="SqlDataSource_TGID"
                    DataTextField="TGName" DataValueField="TGID">
                </asp:DropDownList>
          </td>
          <td align="right">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search Test Wise" /></td>
          <td>
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Search Group Wise" /></td>
      </tr>
    </table>
  </div>
         <br />

<div class="rpt_pos">
                <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
  </div>
</asp:Content>

