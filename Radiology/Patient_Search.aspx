<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Patient_Search.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master"  Inherits="Patient_Search" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

       <script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://digitalbush.com/wp-content/uploads/2013/01/jquery.maskedinput-1.3.1.min_.js"></script>
   <script type="text/javascript" language="javascript">
       $(function () {
           //Define your mask (using 9 to denote any digit)
           $('#ctl00_ContentPlaceHolder1_TextBoxRegNo').mask('99-99-99');
       });
       function txtChangeMR(a) {
           <%--var txt = document.getElementById("<%=TextBoxRegNo.ClientID%>");
         
           if (txt.value.length == 2 || txt.value.length == 5) {
               txt.value = txt.value + "-";
           }--%>
       }

     </script>   
 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script src="validate.js" type="text/javascript"></script>

 
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment" Visible="False"></asp:Label>
 <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label>
<div class="bxmain inner_content" style="width:100%;">

      <div class="bxmain inner_content" style="text-align:left; width:100%;background-color:transparent; border:none; font-weight:bold;">
<h2><span><asp:Label ID="lblHeading" runat="server"  ></asp:Label></span> </h2>
</div>
 
   
 <asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label> 

<h1 class="h1"><span style="background:none; padding:0;"><asp:Label ID="Label_Header" runat="server" ></asp:Label></span></h1>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
  <TR>
    <TD align="right" width="10%" >Patient Name :</TD>
    <TD width="16%"><asp:TextBox id="TextBoxPFName" runat="server"></asp:TextBox></TD>
    <TD align="right" width="16%">Registration # :</TD>
    <TD width="16%">
           <asp:TextBox ID="TextBoxRegNo" TabIndex="1" runat="server" Style="background-color: #f9dde2;" onkeypress="txtChangeMR(this)"  MaxLength="8" ></asp:TextBox>
     </TD>                           
                           
    <TD align="right"width="16%" >Status :</TD>
    <TD width="16%"><asp:DropDownList id="DropDownList_Status" runat="server"></asp:DropDownList></TD>
  </TR>
  <TR>
     <TD align="right" >Age :</TD>
    <TD ><asp:TextBox id="TextBoxAge" runat="server"></asp:TextBox></TD>
    <TD align="right" >Visit # :</TD>
    <TD ><asp:TextBox id="TextBoxYearlyNo" runat="server"></asp:TextBox></TD>
    <TD align="right" >Test Group :</TD>
    <TD ><asp:DropDownList id="DropDownList_Test_Group" runat="server"  OnSelectedIndexChanged="DropDownList_Test_Group_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></TD>
  </TR>
  <TR>
      <TD align="right" style="display:none" >CNIC:</TD>
    <TD style="display:none" >
        <asp:TextBox id="txtCNIC" runat="server"> </asp:TextBox></TD>
    <TD align="right" >Phone # :</TD>

    <TD ><asp:TextBox id="txtMobileNo" runat="server"></asp:TextBox></TD>
    <TD align="right" >Department:</TD>
    <TD >
        <asp:DropDownList id="DropDownList_Department" runat="server">
        </asp:DropDownList></TD>
    <TD align="right" >Test Name :</TD>
    <TD ><asp:DropDownList id="DropDownList_Test_Name" runat="server"></asp:DropDownList></TD>
  </TR>
  <TR>
    <TD align="right" >Registration Date :</TD>
    <TD ><igsch:WebDateChooser style="width: 200px;" id="WebDateChooser1" runat="server" CssClass="drop_date" >
        <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
         </igsch:WebDateChooser></TD>
    <TD align="right" >From Date :</TD>
    <TD ><igsch:WebDateChooser ID="WebDateChooser_FromDate" runat="server" Width="200px" 
                                    CssClass="drop_date">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
<%--        <asp:TextBox ID="WebDateChooser_FromDate" runat="server" style="width:200px" TextMode="Date"></asp:TextBox>--%>
        <%--<igsch:WebDateChooser ID="WebDateChooser_FromDate" runat="server" style="width: 200px;">
        </igsch:WebDateChooser>--%>
      </TD>
    <TD align="right" >To Date :</TD>
    <TD > 
        <igsch:WebDateChooser ID="WebDateChooser_Todate" runat="server" Width="200px" 
                                    CssClass="drop_date">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
<%--        <asp:TextBox ID="WebDateChooser_Todate" runat="server" style="width:200px" TextMode="Date"></asp:TextBox>--%>
        <%--<igsch:WebDateChooser ID="WebDateChooser_Todate" runat="server" style="width: 200px;">
        </igsch:WebDateChooser>--%>
      </TD>
  </TR>
</TABLE><asp:HiddenField id="HiddenField_ID" runat="server"></asp:HiddenField> 
            <asp:HiddenField ID="HiddenField_FromDate" runat="server" />
            <asp:HiddenField ID="HiddenField_ToDate" runat="server" />
</contenttemplate>
    </asp:UpdatePanel>
    <br />
 

 
 
            <asp:Panel ID="Panel2" runat="server"  Width="100%">
               
            </asp:Panel> 
            <br />
    <div style="Width:100%;text-align:center">
        <asp:Label ID="Datelbl" runat="server" ForeColor="Red" Text="" Font-Bold="true" Visible="false"></asp:Label>
    </div> 
<div align="center"><asp:Button ID="Button1" runat="server" Text="Search" /></div>

<br />
              <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid_1" OnSorting="GridViewSearch_Sorting" AllowSorting="True" 
                  OnPageIndexChanging="GridView2_PageIndexChanging"
                        EmptyDataText="No data" Width="100%" PageSize="20" AutoGenerateColumns="False">
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />              
                <AlternatingRowStyle CssClass="GridAltItem" />
                  <Columns>
                      
                      <asp:TemplateField HeaderStyle-Width="140px">
                          <ItemTemplate>
                              <asp:HiddenField runat="server" ID="hfTB_ID" Value='<%# Eval("TB_ID")%>' />
                              <asp:HiddenField runat="server" ID="hfStatus" Value='<%# Eval("CStatus")%>' />
                              <asp:HiddenField runat="server" ID="hfMain_ID" Value='<%# Eval("Main_ID")%>' />
                              <asp:HiddenField runat="server" ID="hfMG_ID" Value='<%# Eval("MG_ID")%>' />
                              <asp:LinkButton ID="LinkButton1" runat="server"  Text='<%# Eval("Grid_Title")%>' PostBackUrl='<%# Eval("URL") %>' ></asp:LinkButton>&nbsp;
                              <asp:LinkButton ID="LinkButton2" runat="server" Text="Send for Modify"  Visible="false" OnClick="LinkButton2_Click"  ></asp:LinkButton>&nbsp;
                         
                               </ItemTemplate>

<HeaderStyle Width="145px"></HeaderStyle>
                      </asp:TemplateField>

            <asp:TemplateField HeaderText="MR #" SortExpression="RegNo" HeaderStyle-Width="60px">
                      <ItemTemplate>
                          <asp:Label ID="lblRegNo" runat="server" Text='<%# Eval("RegNo")%>'></asp:Label>
                      </ItemTemplate>

<HeaderStyle Width="115">

</HeaderStyle>
                </asp:TemplateField>
          

                  <asp:TemplateField HeaderText="Visit #" SortExpression="Yearly_No">
                      <ItemTemplate>
                          <asp:Label ID="lblYearlyNo" runat="server" Text='<%# Eval("PayID")%>'></asp:Label>
                      </ItemTemplate>

                  </asp:TemplateField>


                         <asp:TemplateField HeaderText="Patient" SortExpression="pfname" HeaderStyle-Width="250px">
                      <ItemTemplate>
                          <asp:Label ID="lblPatient" runat="server" Text='<%# Eval("pfname")%>'></asp:Label>
                      </ItemTemplate>

<HeaderStyle Width="250px"></HeaderStyle>
                  </asp:TemplateField>
                         <asp:TemplateField HeaderText="Relation" SortExpression="Relation">
                      <ItemTemplate>
                          <asp:Label ID="lblRelation" runat="server" Text='<%# Eval("Relation")%>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                        <asp:TemplateField HeaderText="Relation Name" SortExpression="Relation Name">
                      <ItemTemplate>
                          <asp:Label ID="lblRelationName" runat="server" Text='<%# Eval("Relation Name")%>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                       <asp:TemplateField HeaderText="Age" ControlStyle-Width="90px" SortExpression="Age">
                      <ItemTemplate>
                          <asp:Label ID="lblAge" runat="server" Text='<%# Eval("Age")%>'></asp:Label>
                      </ItemTemplate>

<ControlStyle Width="90px"></ControlStyle>
                  </asp:TemplateField>
                        <asp:TemplateField HeaderText="Test Name" SortExpression="S_Name">
                      <ItemTemplate>
                          <asp:Label ID="lbltestName" runat="server" Text='<%# Eval("S_Name")%>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                      <asp:TemplateField HeaderText="Appointment Date" SortExpression="Test Booking Date" HeaderStyle-Width="135px" Visible="false">
                      <ItemTemplate>
                          <asp:Label ID="lbltest1" runat="server" Text='<%# Eval("Test Booking Date")%>'></asp:Label>
                      </ItemTemplate>
<HeaderStyle Width="135px"></HeaderStyle>
                  </asp:TemplateField>

                <asp:TemplateField HeaderText="Appointment Date" SortExpression="Appointment Date" HeaderStyle-Width="135px">
                      <ItemTemplate>
                          <asp:Label ID="lblDate" runat="server" Text='<%# Eval("Appointment Date")%>'></asp:Label>
                      </ItemTemplate>

<HeaderStyle Width="135px"></HeaderStyle>

                  </asp:TemplateField>
                        <asp:TemplateField HeaderText="Department" SortExpression="Department">
                      <ItemTemplate>
                          <asp:Label ID="lblDept" runat="server" Text='<%# Eval("Department")%>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                     <asp:HyperLinkField HeaderStyle-Width="90px" DataNavigateUrlFields="RegNo,PayID,MG_ID,Main_ID,TB_ID" Target="_blank" Text="View Report"
                            DataNavigateUrlFormatString="Administrator/Patient_Result_Report.aspx?RegNo={0}&YearlyNo={1}&TGID={2}&Main_ID={3}&TB_ID={4}&Header=1" >

                    

<HeaderStyle Width="90px"></HeaderStyle>
                      </asp:HyperLinkField>

                    

                      <%--  <asp:TemplateField HeaderText="Status" SortExpression="Status">
                      <ItemTemplate>
                          <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status")%>' ></asp:Label>
                           <asp:HiddenField runat="server" Value='<%# Eval("PayID")%>' ID="hfYearlyNo" />
                             <asp:HiddenField runat="server" Value='<%# Eval("Main_ID")%>' ID="HfMainID" />
                      </ItemTemplate>
                  </asp:TemplateField>--%>
                         


<%--                      <asp:TemplateField HeaderText="view Uploaded Images">
                          <ItemTemplate>
                              <asp:LinkButton ID="lnk_images" runat="server" CommandArgument= '<%# Eval("PayID")%>'  ToolTip='<%# Eval("Registration No")%>'  OnClick="lnk_images_Click">view</asp:LinkButton>
                          </ItemTemplate>
                      </asp:TemplateField>--%>
                         


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