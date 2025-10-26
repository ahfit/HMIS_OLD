<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Blood_Bank_Initial_Assesment, App_Web_lv2mnwrp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <style type="text/css">
 .lightbox {
border: #000 solid 8px;
border-radius: 6px;
-moz-border-radius: 6px;
display: block;
width: 70%;
position: absolute;
top: 170px;
left: 40%;
z-index: 9999;
margin: 0 0 0 -350px;
background-color: #F1E0E0;
}
 .small_f {font-size:9px; color:#999;  }
 </style>
 
 
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="blood_wrap"> 
<div class="bxmain inner_content" style="width:100%;">
<h2><span>Assesment</span></h2>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                        <tr>
                            <td width="40%" align="right"  >
                                Previous Assesment :</td>
                            <td  >
                              <asp:DataList ID="DataList_PrevAssesment" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_Assement" runat="server" CommandName="select" OnClick="LinkButton_Assement_Click"
                                            Text='<%# Eval("Asses_Datetime") %>'></asp:LinkButton>&nbsp;
                                        <asp:HiddenField ID="HiddenField_Assesment_Id" runat="server" Value='<%# Eval("Assesment_Id") %>' />
                                    </ItemTemplate>
                                </asp:DataList></td>
                        </tr>
                    </table></div>
 <br>



<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
<td width="50%" valign="top">
<div class="bxmain inner_content">
<h2><span>Detail</span></h2>


<table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                        <tr>
                            <td align="right" width="35%" >
                                Physical :</td>
                            <td >
                            <asp:Label ID="Label_Pre_Asses" runat="server" Text=" "></asp:Label>
                                <asp:LinkButton ID="LinkButton_PreAsses" runat="server"></asp:LinkButton></td>
                        </tr>
                        <tr>
                            <td align="right" >
                                Assesment :</td>
                            <td >
                            </td>
                        </tr>
                        <tr>
                            <td align="right" >
                                Blood Group :</td>
                            <td >
                                <asp:DropDownList ID="DropDownList_BloodGroup" runat="server" DataSourceID="SqlDataSource_BloodGroup"
                                    DataTextField="Blood_Group" DataValueField="Blood_Group" Width="61px">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td align="right" >
                                Appearance :</td>
                            <td >
                              <asp:DropDownList ID="DropDownList_Apearance" runat="server" Width="150px">
                                    <asp:ListItem Selected="True">Average Built</asp:ListItem>
                                    <asp:ListItem>Thin Built</asp:ListItem>
                                    <asp:ListItem>Obese</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td align="right" >
                                Blood Pressure :</td>
                            <td >
                            <asp:TextBox ID="TextBox_Systolic" runat="server" Width="60px"></asp:TextBox>
                                &nbsp;<asp:RangeValidator ID="RangeValidatorBPHigh" runat="server" ControlToValidate="TextBox_Systolic"
                                    CssClass="small_f" ErrorMessage="Enter High B.P below than 300" MaximumValue="300"
                                    MinimumValue="0" Type="Double"></asp:RangeValidator>/
                                <asp:TextBox ID="TextBox_Diastolic" runat="server" Width="60px"></asp:TextBox>
                                &nbsp;<asp:RangeValidator ID="RangeValidatorBPLow" runat="server" ControlToValidate="TextBox_Diastolic"
                                    CssClass="small_f" ErrorMessage="Enter High B.P below 400" MaximumValue="400"
                                    MinimumValue="0" Type="Double"></asp:RangeValidator><span class="small_f">mm/gh</span><span
                                        class="small_f"> B.P below than 300</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" >
                                BP Category :</td>
                            <td >
                              <asp:DropDownList ID="DropDownList_BP_Category" runat="server" Width="150px">
                                    <asp:ListItem Selected="True">Normal</asp:ListItem>
                                    <asp:ListItem>Hypertension</asp:ListItem>
                                    <asp:ListItem>Hypotension</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            
                                 
                                        <td  align="right" >
                                            Weight kg :</td>
                                        <td >
                                      <asp:TextBox ID="TextBox_Weight" runat="server" Width="60px"></asp:TextBox>&nbsp;above<span
                                                class="small_f"> 45 kg<asp:RangeValidator ID="RangeValidator_Weight" runat="server"
                                                    ControlToValidate="TextBox_Weight" CssClass="small_f" ErrorMessage="Enter Weight b/w 45 and 300"
                                                    MaximumValue="200" MinimumValue="45" Type="Double"></asp:RangeValidator></span></td>
                            </tr>
                        <tr>                         
                          <td   align="right">
                                            Pulse :</td>
                          <td >
                                            <asp:TextBox ID="TextBox_Pulse" runat="server" Width="60px"></asp:TextBox>&nbsp;bpm <span
                                                class="small_f">Pulse b/w 50 &amp;200
                                                <asp:RangeValidator ID="RangeValidatorPulse" runat="server" ControlToValidate="TextBox_Pulse"
                                                    CssClass="small_f" ErrorMessage="Enter Pulse b/w 50 and 200" MaximumValue="200"
                                                    MinimumValue="50" Type="Double"></asp:RangeValidator></span></td>
                                   </tr>
                                    <tr>
                                        <td align="right" >
                                            Temp :</td>
                                        <td >
                                          <asp:TextBox ID="TextBox_Temp" runat="server" Width="60px"></asp:TextBox>&nbsp;F <span
                                                class="small_f">Temp b/w 93 and 107</span><span class="small_f">
                                      <asp:RangeValidator ID="RangeValidator_Temp" runat="server" ControlToValidate="TextBox_Temp"
                                                        CssClass="small_f" ErrorMessage="Enter Temp b/w 93 and 107" MaximumValue="107"
                                                        MinimumValue="93" Type="Double"></asp:RangeValidator></span></td>
                                      </tr>
                                    <tr>                  
                                                        
                                        <td align="right" >
                                            Hb Level :</td>
                                        <td >
                                            <asp:TextBox ID="TextBox_HBLevel" runat="server" Width="60px"></asp:TextBox>Plt</td>
                                    </tr>
                                    <tr>  
                            <td align="right" >
                                Decision :</td>
                            <td >
                                <asp:DropDownList ID="DropDownList_Decision" runat="server" Width="150px">
                                    <asp:ListItem Selected="True">Bleed</asp:ListItem>
                                    <asp:ListItem>Don't Bleed</asp:ListItem>
                                </asp:DropDownList></td>
                         </tr>
                                    <tr>  
                            <td align="right" >
                                Remarks :</td>
                            <td >
                                <asp:TextBox ID="TextBox_Remarks" runat="server" Height="38px" TextMode="MultiLine"
                                    Width="175px"></asp:TextBox></td>
                        </tr>
  </table>
  </div>
  
  </td>
<td valign="top"> <div style="margin-left:10px;" >

 <asp:GridView ID="GridView_Question" Width="98%" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_GridQuestion">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                            <asp:BoundField DataField="Element_Name" HeaderText="Element" SortExpression="Element_Name" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:RadioButtonList ID="RadioButtonList_Ans" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem>Yes</asp:ListItem>
                                        <asp:ListItem Selected="True">No</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:HiddenField ID="HiddenField_Id" runat="server" Value='<%# Eval("ID", "{0}") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:TextBox ID="TextBox_Other" runat="server"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                      </Columns>
  </asp:GridView>
   <asp:Button ID="btnNew" runat="server" Text="New Blood Donors" />
    <asp:Button ID="btnPrevious" runat="server" Text="Previous Blood Donors" />
  </div>
      </td>
  </tr>
</table>

  
  
  
  
  
  
  
                  
                 
                 <br>
   
<div align="center">                    <asp:Button ID="Button_Save" runat="server" Text="Save" />
                    <asp:Button ID="Button_Cancel" runat="server" Text="Cancel" Visible="False" />
                    <asp:Button ID="Button_Edit" runat="server" Text="Add Edit Elements" />
                    <asp:HiddenField ID="HiddenField_NewVisitId" runat="server" /></div>
                  
                  <br>

                  
                    <asp:Panel ID="Panel_AddEditQuestion" runat="server" Visible="False" Width="100%">
<div class="bxmain">                         
                          <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form"   ">
                           
                            <tr>
                                <td align="right"  width="40%">
                                    Question :</td>
                                <td >
                              <asp:TextBox ID="TextBox_Question" runat="server"></asp:TextBox>
                              <asp:Button ID="Button_SaveQuestion" runat="server" Text="Save" /><asp:ImageButton ID="ImageButton_AddEditpanelClose" runat="server"   /></td>
                                <td ></td>
                            </tr>
                            </table></div>
                            <br>

                                   
                                   
                                    <asp:GridView ID="GridView_AddEditQuestion" runat="server" AutoGenerateColumns="False"
                                        DataKeyNames="ID" DataSourceID="SqlDataSource_AddEditQuestion" Width="100%">
                                        <Columns>
                                            <asp:CommandField ShowEditButton="True" />
                                            <asp:BoundField DataField="Element_Name" HeaderText="Question" SortExpression="Element_Name" />
                                            <asp:CheckBoxField DataField="Ele_Req" HeaderText="Visible" SortExpression="Ele_Req" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="SqlDataSource_AddEditQuestion" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                                        InsertCommand="INSERT INTO Donor_Assement_Element(Element_Name, Ele_Req) VALUES (@Element_Name, @Ele_Req)"
                                        SelectCommand="SELECT ID, Element_Name, Ele_Req FROM Donor_Assement_Element"
                                        UpdateCommand="UPDATE Donor_Assement_Element SET Element_Name = @Element_Name, Ele_Req = @Ele_Req WHERE (ID = @ID)">
                                        <DeleteParameters>
                                            <asp:ControlParameter ControlID="GridView_Question" Name="ID" PropertyName="SelectedValue" />
                                        </DeleteParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="Element_Name" />
                                            <asp:Parameter Name="Ele_Req" />
                                            <asp:ControlParameter ControlID="GridView_AddEditQuestion" Name="ID" PropertyName="SelectedValue" />
                                        </UpdateParameters>
                                        <InsertParameters>
                                            <asp:ControlParameter ControlID="TextBox_Question" Name="Element_Name" PropertyName="Text" />
                                            <asp:Parameter DefaultValue="True" Name="Ele_Req" />
                                        </InsertParameters>
                                    </asp:SqlDataSource>
                                
                    </asp:Panel>
                
    <br>
<br>

   
        <asp:SqlDataSource ID="SqlDataSource_BloodGroup" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
            SelectCommand="SELECT Group_Name + ' ' + Rh_Factor as Blood_Group&#13;&#10;FROM         Blood_Group">
        </asp:SqlDataSource>
        
         
        <asp:SqlDataSource ID="SqlDataSource_GridQuestion" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
            SelectCommand="SELECT ID, Element_Name FROM Donor_Assement_Element WHERE (Ele_Req = 1)"></asp:SqlDataSource>
  </div> 
  
  <asp:Panel runat="server" ID="pnlNewDonors" CssClass="lightbox"  ScrollBars="Auto" Visible="false">
        
       
        <h1 class="modalTitle" style="margin: 5;">
            For New Blood Donors </h1>
            <br />
        <div class="inner donate-form">
            <div class="row">
               <asp:GridView runat="server" ID="gvNewDonors" AllowPaging = "True" PageSize="30" CssClass="table table-striped table-bordered table-hover"
                    AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sdsNewDonors">
                   <Columns>
                      <asp:TemplateField HeaderText="Sr. No.">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle Width="50px"></ItemStyle>
                            </asp:TemplateField>

                       <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" Visible="false" 
                           ReadOnly="True" SortExpression="ID" />
                       <asp:BoundField DataField="Element_Name" HeaderText="Element Name" 
                           SortExpression="Element_Name" />
                       <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:RadioButtonList ID="RadioButtonList_NewDonors" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem>Yes</asp:ListItem>
                                        <asp:ListItem >No</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:HiddenField ID="HiddenField_Id" runat="server" Value='<%# Eval("ID", "{0}") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                   </Columns>
               </asp:GridView>
               <asp:SqlDataSource runat="server" ID="sdsNewDonors" 
                    ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>" 
                    SelectCommand="SELECT ID, Element_Name, Ele_Req, Status FROM Donor_Assement_Element WHERE (Status = 1)"></asp:SqlDataSource>
          <div align="center">  
                <asp:Button runat="server" ID="btnSave" Text="Save" 
                    CssClass="btn btn-success" />
                     <asp:Button runat="server" ID="btnCancel" Text="Cancel" 
                    CssClass="btn btn-success" />
            </div>
        </div>
        </div>
    </asp:Panel> 
    
    <asp:Panel runat="server" ID="pnlPreviousDonors" CssClass="lightbox"  ScrollBars="Auto" Visible="false">
        
       
        <h1 class="modalTitle" style="margin: 5;">
            For Previous Blood Donors </h1>
            <br />
        <div class="inner donate-form">
            <div class="row">
               <asp:GridView runat="server" ID="gvPreviousDonors" AllowPaging = "True" 
                    PageSize="30" CssClass="table table-striped table-bordered table-hover"
                    AutoGenerateColumns="False" DataKeyNames="ID" 
                    DataSourceID="sdsPreviousDonors" >
                   
                   <Columns>
                    <asp:TemplateField HeaderText="Sr. No.">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle Width="50px"></ItemStyle>
                            </asp:TemplateField>
                       <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False"  Visible="false"
                           ReadOnly="True" SortExpression="ID" />
                       <asp:BoundField DataField="Element_Name" HeaderText="Element Name" 
                           SortExpression="Element_Name" />
                      <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:RadioButtonList ID="RadioButtonList_PreviousDonors" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem>Yes</asp:ListItem>
                                        <asp:ListItem >No</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:HiddenField ID="HiddenField_Id" runat="server" Value='<%# Eval("ID", "{0}") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                   </Columns>
                   
               </asp:GridView>
               <asp:SqlDataSource runat="server" ID="sdsPreviousDonors" 
                    ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>" 
                    SelectCommand="SELECT ID, Element_Name, Ele_Req, Status FROM Donor_Assement_Element WHERE (Status = 2)"></asp:SqlDataSource>
          <div align="center">  
                <asp:Button runat="server" ID="btnSavePreDonors" Text="Save" 
                    CssClass="btn btn-success" />
                     <asp:Button runat="server" ID="btnPreviousCancel" Text="Cancel" 
                    CssClass="btn btn-success" />
            </div>
        </div>
        </div>
    </asp:Panel>   
 </asp:Content>