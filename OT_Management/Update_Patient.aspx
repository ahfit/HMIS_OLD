<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Update_Patient.aspx.vb" Inherits="Update_Patient" %>





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
<asp:Image ID="Image1" runat="server" Height="120px" Width="100px" Visible="False" />
<strong>Update &raquo;&nbsp;Patient Registration </strong><br /><br />


<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >
              <!--DWLayoutTable-->
                          <tr><td><br class="break"/></td></tr>
              <tr>
                <td width="20%" align="right" valign="middle" >
                  <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
Title : </td>
                <td valign="middle" width="30%" >
                  <asp:RadioButtonList CssClass="" ID="Prefix" runat="server" RepeatColumns="3" RepeatLayout="Flow" 
                        RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True">Mr.</asp:ListItem>
                    <asp:ListItem>Miss</asp:ListItem>
                    <asp:ListItem>Mrs.</asp:ListItem>
                  </asp:RadioButtonList>
</td>
                
                <td align="right" valign="middle" width="20%">Age : </td>
                <td  valign="middle" width="30%"><asp:TextBox CssClass="input_txt" ID="TextBox5" runat="server" Width="123px"></asp:TextBox>
                  <asp:DropDownList ID="DropDownList_BIndicator" runat="server" CssClass="" >
                    <asp:ListItem>Years</asp:ListItem>
                    <asp:ListItem>Months</asp:ListItem>
                    <asp:ListItem>Days</asp:ListItem>
                  </asp:DropDownList></td>
              <td rowspan="7" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
              
              </table>
              </td>
              </tr>
              <tr>
                <td align="right" valign="middle">First Name : </td>
                        <td valign="middle">
                          <asp:TextBox CssClass="input_txt" ID="TextBox_PFName" runat="server" Width="195px"></asp:TextBox>
</td>
                        <td align="right" valign="middle">Gender : </td>
                        <td valign="middle"><asp:DropDownList ID="DropDownList_Gender" runat="server" Width="200px" CssClass="" 
                        DataSourceID="SqlDataSource_Gender" DataTextField="Gender" 
                        DataValueField="Gender_ID"> </asp:DropDownList></td>
                    </tr>
              <tr>
                <td align="right" valign="middle">Last Name : </td>
                        <td valign="middle">
                          <asp:TextBox CssClass="input_txt" ID="TextBox_PLName" runat="server" Width="195px"></asp:TextBox>
</td>
                        <td align="right" valign="middle">Refer From : </td>
                        <td valign="middle"><asp:TextBox CssClass="input_txt" ID="TextBox_Refer_From" runat="server" Width="195px"></asp:TextBox></td>
                    </tr>
              <tr>
                <td  align="right" valign="middle" >Relation : </td>
                        <td valign="middle">
                          <asp:RadioButtonList CssClass="" ID="RadioButtonList_Relation" runat="server" RepeatColumns="3"  RepeatLayout="Flow" 
                        RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True">S/O</asp:ListItem>
                            <asp:ListItem>D/O</asp:ListItem>
                            <asp:ListItem>W/O</asp:ListItem>
                          </asp:RadioButtonList>
</td>
                        <td align="right" valign="middle">Referral Department : </td>
                        <td valign="middle"><asp:DropDownList ID="DropDownList_Department" runat="server" Width="200px" CssClass="" 
                        DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name" 
                        DataValueField="Dept_ID"> </asp:DropDownList></td>
                    </tr>
              <tr>
                <td  align="right" valign="middle">First Name : </td>
                        <td valign="top">
                          <asp:TextBox CssClass="input_txt" ID="TextBox_RFName" runat="server" Width="195px"></asp:TextBox>
</td>
                        <td align="right" valign="middle">CNIC No. :</td>
                        <td valign="top"><asp:TextBox CssClass="input_txt" ID="TextBox_CNIC1" runat="server" Width="195px"></asp:TextBox></td>
                      </tr>
              <tr>
                <td  align="right" valign="middle">Last Name : </td>
                        <td valign="top">
                          <asp:TextBox CssClass="input_txt" ID="TextBox_RLName" runat="server" Width="195px"></asp:TextBox>
</td>
                        <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                        <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      </tr>
              
                           <tr><td><br class="break"/></td></tr>
              
              </table>
              <br />
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >
              <!--DWLayoutTable-->
             <tr><td><br class="break"/></td></tr>
              <tr>
                <td align="right" valign="middle" width="20%">Country : </td>
                        <td valign="middle" width="30%" >
                          <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                              <asp:DropDownList ID="DropDownList_Country" runat="server" CssClass="" 
    Width="200px" AutoPostBack="True" DataSourceID="SqlDataSource_Country" DataTextField="CountryName" 
                                DataValueField="CountryCode"> </asp:DropDownList>
                            </ContentTemplate>
                          </asp:UpdatePanel>
</td>
                        
                        <td align="right" valign="middle" width="20%">Province :</td>
                        <td  width="30%" valign="middle"><asp:UpdatePanel ID="UpdatePanel3" runat="server">
                          <ContentTemplate>
                            <asp:DropDownList ID="DropDownList_Province" runat="server" 
    Width="200px" AutoPostBack="True" DataSourceID="SqlDataSource_Province" DataTextField="ProvinceName" CssClass="" 
                                DataValueField="ProvinceCode"> </asp:DropDownList>
                          </ContentTemplate>
                        </asp:UpdatePanel></td>
                      </tr>
              <tr>
                <td  align="right" valign="middle">District : </td>
                        <td valign="top">
                          <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                              <asp:DropDownList ID="DropDownList_District" runat="server" CssClass="" 
    Height="16px" Width="200px" AutoPostBack="True" DataSourceID="SqlDataSource_District" 
                                DataTextField="DistrictName" DataValueField="DistrictCode"> </asp:DropDownList>
                            </ContentTemplate>
                          </asp:UpdatePanel>
</td>
                        <td align="right" valign="middle">Tehsil :</td>
                        <td valign="middle"><asp:UpdatePanel ID="UpdatePanel4" runat="server">
                          <ContentTemplate>
                            <asp:DropDownList ID="DropDownList_Tehsil" runat="server" CssClass="" 
    Width="200px" DataSourceID="SqlDataSource_Tehsil" DataTextField="TehsilName" 
                                DataValueField="TehsilCode"> </asp:DropDownList>
                          </ContentTemplate>
                        </asp:UpdatePanel></td>
                      </tr>
              <tr>
                <td  align="right" valign="middle">Street / Block : </td>
                        <td valign="middle">
                          <asp:TextBox CssClass="input_txt" ID="TextBox_Street_Block" runat="server" Width="195px"></asp:TextBox>
</td>
                        <td align="right" valign="middle">Town / Village : </td>
                        <td valign="middle"><asp:TextBox CssClass="input_txt" ID="TextBox_Town" runat="server" Width="195px"></asp:TextBox></td>
                    </tr>
              <tr>
                <td  align="right" valign="middle">Postal Code : </td>
                        <td valign="middle">
                          <asp:TextBox CssClass="input_txt" ID="TextBox_Postal_Code" runat="server" Width="195px"></asp:TextBox>
</td>
                        <td align="right" valign="middle">House No. :</td>
                        <td valign="top"><asp:TextBox CssClass="input_txt" ID="TextBox_House_No" runat="server" Width="195px"></asp:TextBox></td>
                    </tr>
              <tr>
                <td  align="right" valign="middle">Phone No. : </td>
                        <td valign="top">
                          <asp:TextBox CssClass="input_txt" ID="TextBox_PHone_No" runat="server" Width="195px"></asp:TextBox>
</td>
                        <td align="right" valign="middle">Mobile No. :</td>
                        <td valign="middle"><asp:TextBox CssClass="input_txt" ID="TextBox_Mobile_No" runat="server" Width="195px"></asp:TextBox></td>
                      </tr>
             <tr><td><br class="break"/></td></tr>
              
              
            </table>
<br />

<div align="center">  <asp:Button ID="Button_Update" runat="server" Text="Update" CssClass="btn2" />                  

                <asp:SqlDataSource ID="SqlDataSource_Country" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT CountryName, CountryCode FROM Country"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_Province" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT ProvinceName, ProvinceCode FROM Province WHERE (CountryCode = @CountryCode)">
                  <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList_Country" Name="CountryCode" 
                PropertyName="SelectedValue" />
                  </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_District" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT DistrictName, DistrictCode FROM DISTRICT WHERE (ProvinceCode = @ProvinceCode)">
                  <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList_Province" Name="ProvinceCode" 
                PropertyName="SelectedValue" />
                  </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_Tehsil" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT TehsilName, TehsilCode FROM TEHSIL WHERE (districtCode = @districtCode)">
                  <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList_District" Name="districtCode" 
                PropertyName="SelectedValue" />
                  </SelectParameters>
                </asp:SqlDataSource>
                
                <asp:SqlDataSource ID="SqlDataSource_Gender" runat="server" 
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT Gender_ID, Gender FROM Gender" 
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"></asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Date_Of_Birth" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT Dept_Name, Dept_ID FROM Department"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" 
                        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" 
                        ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" 
                        UpdateCommand="Update_PatientInfo" UpdateCommandType="StoredProcedure">
                  <UpdateParameters>
                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" 
                Type="String" />
                    <asp:ControlParameter ControlID="Prefix" Name="Prefix" 
                PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="HiddenFieldPFName" Name="PFName" 
                PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="HiddenFieldPMName" Name="PMName" 
                PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="RadioButtonList_Relation" Name="Relation" 
                PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_RFName" Name="RFName" 
                PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_RLName" Name="RMName" 
                PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="DropDownList_Gender" Name="SexID" 
                PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="TextBox5" Name="Age" PropertyName="Text" 
                Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownList_Country" Name="CountryCode" 
                PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownList_Province" Name="ProvinceCode" 
                PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownList_District" Name="DistrictCode" 
                PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownList_Tehsil" Name="TehsilCode" 
                PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="TextBox_Postal_Code" Name="Zipcode" 
                PropertyName="Text" Type="Decimal" />
                    <asp:ControlParameter ControlID="TextBox_Street_Block" Name="StreetAddress" 
                PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_Town" Name="Colony" 
                PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_PHone_No" Name="HomePhone" 
                PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_Mobile_No" Name="MobilePhone" 
                PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_CNIC1" Name="CNIC" PropertyName="Text" 
                Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_Date_Of_Birth" Name="DateOfBirth" 
                PropertyName="Value" Type="DateTime" />
                    <asp:ControlParameter ControlID="DropDownList_BIndicator" Name="AgeType" 
                PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_House_No" Name="HouseNo" 
                PropertyName="Text" Type="Int32" />
                      <asp:ControlParameter ControlID="DropDownList_Department" Name="ReferFrom" PropertyName="SelectedValue"
                          Type="String" />
                  </UpdateParameters>
                </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenFieldPFName" runat="server" />
                    <asp:HiddenField ID="HiddenFieldPMName" runat="server" /></div><br />
<br />



</div>

</form>
</body>
</html>