
<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="ViewPatientDetailForEDept, App_Web_3d5bytc0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />



 
<asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CssClass="Grid_1"
        DataSourceID="SqlDataSource1" Width="100%">
        <RowStyle CssClass="GridItem" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <Fields>
            <asp:TemplateField>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="100px" Width="100px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="RegNo" HeaderText="MR #" SortExpression="RegNo">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="datetime" HeaderText="Date" SortExpression="datetime">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="prefix" HeaderText="prefix" SortExpression="prefix" />
            <asp:BoundField DataField="pmname" HeaderText="pmname" SortExpression="pmname" />
            <asp:BoundField DataField="pfname" HeaderText="pfname" SortExpression="pfname" />
            <asp:BoundField DataField="plname" HeaderText="plname" SortExpression="plname" />
            <asp:BoundField DataField="Patient_Relation" HeaderText="Relation Name" SortExpression="Patient_Relation">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Address1" HeaderText="Address 1" SortExpression="Address1">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Address2" HeaderText="Address 2" SortExpression="Address2" />
            <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
            <asp:BoundField DataField="Province" HeaderText="Province" SortExpression="Province" />
            <asp:BoundField DataField="District" HeaderText="District" SortExpression="District" />
            <asp:BoundField DataField="Tehsil" HeaderText="Tehsil" SortExpression="Tehsil" />
            <asp:BoundField DataField="OtherProvince" HeaderText="OtherProvince" SortExpression="OtherProvince"
                Visible="False">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="OtherDistrict" HeaderText="OtherDistrict" SortExpression="OtherDistrict"
                Visible="False">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="OtherTehsil" HeaderText="OtherTehsil" SortExpression="OtherTehsil"
                Visible="False">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="MobilePhone" HeaderText="Contact #" SortExpression="MobilePhone">
                <HeaderStyle Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Next of Kin Relation" HeaderText="Next of Kin Relation"
                SortExpression="Next of Kin Relation" />
            <asp:BoundField DataField="Next of Kin Name" HeaderText="Next of Kin Name" SortExpression="Next of Kin Name" />
            <asp:BoundField DataField="Next of Kin CNIC" HeaderText="Next of Kin CNIC" SortExpression="Next of Kin CNIC" />
            <asp:BoundField DataField="Next of Kin Mobile No." HeaderText="Next of Kin Mobile No."
                SortExpression="Next of Kin Mobile No." />
        </Fields>
        <HeaderStyle Font-Bold="True" />
        <PagerTemplate>
                
        </PagerTemplate>
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" SelectCommand="SELECT     Payment.DateTime, ISNULL(Patient.Prefix, ' ') AS prefix, ISNULL(Patient.PFName, '') AS pfname, ISNULL(Patient.PMName, '000') AS pmname, &#13;&#10;                      ISNULL(Patient.PLName, '') AS plname, ISNULL(Patient.Relation, '') + ' ' + ISNULL(Patient.RFName, ' ') + ' ' + ISNULL(Patient.RMName, ' ') &#13;&#10;                      + ' ' + ISNULL(Patient.RLName, '') AS [Patient_Relation], CONVERT(varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) / 365) + '  Y  ' + CONVERT(varchar, &#13;&#10;                      DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) % 365 / 30) + '  M  ' + CONVERT(varchar, DATEDIFF(dd, Patient.DateOfBirth, GETDATE()) % 365 % 30) + '  D' AS Age, &#13;&#10;                      Patient.RegNo, Patient.RegDateTime, ISNULL(Patient.House_No, '') as Address1 ,ISNULL(Patient.StreetAddress, '')  as Address2, ISNULL(Patient.Colony, '') AS Address, &#13;&#10;                      ISNULL(Tehsil.TehsilName, '') AS Tehsil, ISNULL(District.DistrictName, '') AS District, ISNULL(Province.ProvinceName, '') AS Province, ISNULL(Country.CountryName, &#13;&#10;                      '') AS Country, Patient.Zipcode, Gender.Gender, Patient.OtherProvince, Patient.OtherDistrict, Patient.OtherTehsil, Patient.HomePhone, Patient.MobilePhone, &#13;&#10;                      Patient.CNIC, Payment.Diagonosis, ISNULL(Patient.RFName, '') + ' ' + ISNULL(Patient.RMName, '') + ' ' + ISNULL(Patient.RLName, '') AS [Relation Name], &#13;&#10;                      Payment.ReferFrom, ISNULL(PatientRelative.RelationWithPatient, '') AS [Next of Kin Relation], ISNULL(PatientRelative.RelativeFName, '') &#13;&#10;                      + ' ' + ISNULL(PatientRelative.RelativeMName, '') + ' ' + ISNULL(PatientRelative.RelativeLName, '') AS [Next of Kin Name], PatientRelative.NIC AS [Next of Kin CNIC], &#13;&#10;                      PatientRelative.Mobile_Phone AS [Next of Kin Mobile No.]&#13;&#10;FROM         Patient LEFT OUTER JOIN&#13;&#10;                      Gender ON Patient.SexID = Gender.Gender_ID LEFT OUTER JOIN&#13;&#10;                      PatientRelative ON Patient.RegNo = PatientRelative.PatientRegNo LEFT OUTER JOIN&#13;&#10;                      Payment ON Patient.RegNo = Payment.RegNo LEFT OUTER JOIN&#13;&#10;                      Tehsil ON Patient.TehsilCode = Tehsil.TehsilCode LEFT OUTER JOIN&#13;&#10;                      Province ON Patient.ProvinceCode = Province.ProvinceCode LEFT OUTER JOIN&#13;&#10;                      District ON Patient.DistrictCode = District.DistrictCode LEFT OUTER JOIN&#13;&#10;                      Country ON Patient.CountryCode = Country.CountryCode&#13;&#10;WHERE     (Patient.RegNo = @RegNo)">
        <SelectParameters>
            <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsEmployeeDependents" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT Reg_No, Party_Desg_Name, Party_Name, Prefix, PFName, PMName, PLName, Relation, RFName, RMName, RLName, Gender, Emp_No, RegistrationType FROM EmployeeDependents WHERE (Reg_No = @Reg_No)">
        <SelectParameters>
            <asp:QueryStringParameter Name="Reg_No" QueryStringField="RegNo" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="grdEmployeeDependents" runat="server" AutoGenerateColumns="False"
        DataSourceID="dsEmployeeDependents" EmptyDataText="Please Register Employee First"
        Width="98%">
        <Columns>
            <asp:TemplateField HeaderText="MR. #" SortExpression="Reg_No">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Reg_No") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblRegNo" runat="server"></asp:Label>
                    <asp:HiddenField ID="hfRegNo" runat="server" Value='<%# Eval("Reg_No") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Patient">
                <ItemTemplate>
                    <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                    <asp:HiddenField ID="hfPrefix" runat="server" Value='<%# Eval("Prefix") %>' />
                    <asp:HiddenField ID="hfPFName" runat="server" Value='<%# Eval("PFName") %>' />
                    <asp:HiddenField ID="hfPMName" runat="server" Value='<%# Eval("PMName") %>' />
                    <asp:HiddenField ID="hfPLName" runat="server" Value='<%# Eval("PLName") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Relation">
                <ItemTemplate>
                    <asp:Label ID="lblRelation" runat="server"></asp:Label>
                    <asp:HiddenField ID="hfRelation" runat="server" Value='<%# Eval("Relation") %>' />
                    <asp:HiddenField ID="hfRFName" runat="server" Value='<%# Eval("RFName") %>' />
                    <asp:HiddenField ID="hfRMName" runat="server" Value='<%# Eval("RMName") %>' />
                    <asp:HiddenField ID="hfRLName" runat="server" Value='<%# Eval("RLName") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Party_Desg_Name" HeaderText="Employee Designation" SortExpression="Party_Desg_Name" />
            <asp:BoundField DataField="Party_Name" HeaderText="Party" SortExpression="Party_Name" />
            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
            <asp:BoundField DataField="Emp_No" HeaderText="Emp #" SortExpression="Emp_No" />
            <asp:TemplateField HeaderText="Registration Type" SortExpression="RegistrationType">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RegistrationType") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblRegistrationType" runat="server" Text='<%# Bind("RegistrationType") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="lblRelationWith" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
<br />


<div align="center"> <asp:Button ID="Button1" runat="server" Text="Print" CssClass="btn1" Visible="False" />
    <asp:Button ID="Button_Back" runat="server" Text="Back" CssClass="btn1" /></div>
<br />

              
  </asp:Content>