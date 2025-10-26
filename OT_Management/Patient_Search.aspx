<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Patient_Search.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master"  Inherits="Patient_Search" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 <asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label> 

<h1 class="h1"><span style="background:none; padding:0;"><asp:Label ID="Label_Header" runat="server"  ></asp:Label></span></h1>
    <%--<asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>--%>
    <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>--%>
<table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
  <TR>
    <TD align="right" width="16%" >First Name :</TD>
    <TD width="16%"><asp:TextBox id="TextBoxPFName" runat="server"></asp:TextBox></TD>
    <TD align="right" width="16%">Registration # :</TD>
    <TD width="16%"><asp:TextBox id="TextBoxRegNo" runat="server"></asp:TextBox></TD>
    <TD align="right"width="16%" >Status :</TD>
    <TD width="16%"><asp:DropDownList id="DropDownList_Status" runat="server"></asp:DropDownList></TD>
  </TR>
  <TR>
    <TD align="right" >Middle Name :</TD>
    <TD ><asp:TextBox id="TextBoxPMName" runat="server"></asp:TextBox></TD>
    <TD align="right" >Visit # :</TD>
    <TD ><asp:TextBox id="TextBoxYearlyNo" runat="server"></asp:TextBox></TD>
    <TD align="right" >Test Group :</TD>
    <TD ><asp:DropDownList id="DropDownList_Test_Group" runat="server" OnSelectedIndexChanged="DropDownList_Test_Group_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></TD>
  </TR>
  <TR>
    <TD align="right" >Last Name :</TD>
    <TD ><asp:TextBox id="TextBoxPLName" runat="server"></asp:TextBox></TD>
    <TD align="right" >Age :</TD>
    <TD ><asp:TextBox id="TextBoxAge" runat="server"></asp:TextBox></TD>
    <TD align="right" >Test Name :</TD>
    <TD ><asp:DropDownList id="DropDownList_Test_Name" runat="server"></asp:DropDownList></TD>
  </TR>
  <TR>
    <TD align="right" >Investigation Booking Date :</TD>
    <TD ><igsch:WebDateChooser id="WebDateChooser1" runat="server" CssClass="drop_date"></igsch:WebDateChooser></TD>
    <TD align="right" >Appointment Date: </TD>
    <TD ><igsch:WebDateChooser id="WebDateChooserAppDate" runat="server" 
            CssClass="drop_date"></igsch:WebDateChooser></TD>
    <TD align="right" ></TD>
    <TD ></TD>
  </TR>
</TABLE><asp:HiddenField id="HiddenField_ID" runat="server"></asp:HiddenField> 
<%--</contenttemplate>
    </asp:UpdatePanel>--%>
    <br />
 

 
 
            <asp:Panel ID="Panel2" runat="server"  Width="100%">
                <br />
                <br />
            </asp:Panel> 
            <br />
<div align="center"><asp:Button ID="Button1" runat="server" Text="Search" />
    <asp:Button ID="Button_Excel" runat="server" Height="25px" Text="Excel"  OnClick="Button_Excel_Click"
        Width="78px" />
    </div>

<br />
              <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid_1"
                        EmptyDataText="No data" Width="100%" PageSize="25">
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />              
                <AlternatingRowStyle CssClass="GridAltItem" />
                  <Columns>
                      <asp:TemplateField>
                          <ItemTemplate>
                              <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select"></asp:LinkButton>&nbsp;
                          </ItemTemplate>
                      </asp:TemplateField>
                  </Columns>
                  </asp:GridView>
<br />
 
<asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
              <asp:HiddenField ID="HiddenFieldDate" runat="server" />
              <asp:HiddenField ID="HiddenFieldpfname" runat="server" />
              <asp:HiddenField ID="HiddenField_yearlyno" runat="server" />
              <asp:HiddenField ID="HiddenField_regno" runat="server" />
              <asp:HiddenField ID="HiddenFieldrequestid" runat="server" />
              <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldPMName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRelationFirstName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRelation" runat="server" />
              <asp:HiddenField ID="HiddenFieldRMName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldAge" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourcePatient" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                    InsertCommand="PatientRegistrationNextVisit" InsertCommandType="StoredProcedure"
                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT     Payment.datetime,ISNULL(Patient.Prefix, ' ') + ' ' + ISNULL(Patient.PFName, ' ') + ' ' + ISNULL(Patient.PMName, ' ') + ' ' + ISNULL(Patient.PLName, ' ') +&#13;&#10;                      ISNULL(Patient.Relation, '') + ISNULL(Patient.RFName, ' ') + ' ' + ISNULL(Patient.RMName, ' ') + ' ' + ISNULL(Patient.RLName, ' ') AS Name, &#13;&#10;                      CONVERT(varchar, ISNULL(Patient.Age, ' ')) + ' ' + ISNULL(Patient.AgeType, ' ') AS Age, Patient.RegNo, Patient.RegDateTime, &#13;&#10;                     'H.No.'+ ISNULL(Patient.House_No, ' ') + ' St.No.'&#13;&#10;+ ISNULL(Patient.StreetAddress, '') + ' '+&#13;&#10;ISNULL(Patient.Colony, '') + ' Tehsil '+ISNULL(Tehsil.TehsilName, '')+ ' District '+ &#13;&#10;                       ISNULL(DISTRICT.DistrictName, '') +  ' Province'+&#13;&#10;ISNULL(Province.ProvinceName, '')+ ' '+&#13;&#10; ISNULL(Country.CountryName, '') AS Address, Patient.Zipcode, &#13;&#10;                      PatientSex.SexDescription, Patient.OtherProvince, Patient.OtherDistrict, Patient.OtherTehsil, Patient.HomePhone, Patient.MobilePhone, Patient.CNIC, &#13;&#10;                      payment.diagonosis&#13;&#10;FROM         Patient INNER JOIN&#13;&#10;                      Payment ON Patient.RegNo = Payment.RegNo LEFT OUTER JOIN&#13;&#10;                      Tehsil ON Patient.TehsilCode = Tehsil.TehsilCode LEFT OUTER JOIN&#13;&#10;                      PatientSex ON Patient.SexID = PatientSex.SexID LEFT OUTER JOIN&#13;&#10;                      Province ON Patient.ProvinceCode = Province.ProvinceCode LEFT OUTER JOIN&#13;&#10;                      DISTRICT ON Patient.DistrictCode = DISTRICT.DistrictCode LEFT OUTER JOIN&#13;&#10;                      Country ON Patient.CountryCode = Country.CountryCode&#13;&#10;WHERE (Patient.RegNo = @RegNo)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter DefaultValue="10" Name="DeptID" Type="Int32" />
                        <asp:Parameter DefaultValue="DMC" Name="Status" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="EmpID" SessionField="emp_id" Type="Int32" />
                        <asp:Parameter DefaultValue="Diabetes" Name="Diagonosis" Type="String" />
                        <asp:Parameter DefaultValue="DMC" Name="PatientType" Type="String" />
                        <asp:Parameter DefaultValue="" Name="ReferFrom" Type="String" />
                        <asp:Parameter Direction="InputOutput" Name="paymentid" Type="Decimal" />
                        <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                        <asp:Parameter Name="to_sub_Dept" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
              
                
 
<br />
<br />
  </asp:Content>