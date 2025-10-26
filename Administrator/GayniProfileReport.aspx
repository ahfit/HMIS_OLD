<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="GayniProfileReport.aspx.cs" Inherits="Pathology_LabTestSummaryReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .name {
            font-weight: bold;
            text-align: left;
            display: inline-block;
            width: 50px;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
       <script type="text/javascript">
           
           $(document).ready(function () {

               //$("#ctl00_ContentPlaceHolder1_CheckBox_Same_as_Above").removeAttr('checked');
               $("#ctl00_ContentPlaceHolder1_textboxage").click(function () {
                   var ag = $("#ctl00_ContentPlaceHolder1_textboxage:input").val();
                   //ForAge();
                   //showAgedob(ag);
                   changeYear();
                   debugger;

               });


           });



    </script>
       <script type="text/javascript" language="javascript">

        function changeYear() {
            debugger;
            var age = document.getElementById('<%=textboxage.ClientID%>').value;
            var date;
            date = igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').getText();
            var year_type = document.getElementById('<%=DropDownListBIndicator.ClientID%>').value;
            var edit_date = document.getElementById('<%=WebDateTimeEdit_DOB.ClientID%>');

            var strDate = new Date();

            var date_val;

            if (year_type == "Years") {

                strDate.setFullYear(strDate.getFullYear() - age);


            }
            else if (year_type == "Months") {
                strDate.setMonth(strDate.getMonth() - age);

            }
            else if (year_type == "Days") {
                strDate.setDate(strDate.getDate() - age);

            }
            else if (year_type == "Hours") {
                strDate.setHours(date_val = strDate.getHours() - age);

            }


            igedit_getById('<%=WebDateTimeEdit_DOB.ClientID%>').setText(strDate.getDate() + "/" + (strDate.getMonth() + 1) + "/" + strDate.getFullYear());

        }


    </script>
     <div class="bxmain inner_content" style="width:100%">
           <h2><span>Gayni Profile Report</span></h2>
                <table class="style1" style="margin-left:320px">
                
                    <tr>
                        <td class="style2">
                          File No :
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="fileNo" runat="server" ></asp:TextBox>
                        </td>
                   </tr>
                   <tr>
                        <td class="style2">
                            MRNo :
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="mrNo" runat="server" ></asp:TextBox>
                        </td>

                    </tr>
                    <tr>
                        <td class="style2">
                            Mobile No :
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="mobileNo" runat="server" ></asp:TextBox>
                        </td>

                    </tr>
                           <tr>
                        <td class="style2">
                            Starting Date :
                        </td>
                        <td>
                            <igsch:WebDateChooser ID="startDate" runat="server" 
                                Width="202px">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            Ending Date :
                        </td>
                        <td>
                            <igsch:WebDateChooser ID="endDate" runat="server" 
                                Width="202px">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                    </tr>
                    <tr>                      
                        <td></td>
                        <td colspan="2" align="center" style="padding-top:20px">
                            <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search"  
                                 CssClass="btn_1" style="float:right"/>
                        </td>
                   </tr>
    </table>
    </div>
    <br />
    <asp:panel id="divPop" visible="false" runat="server">
    <div class="bxmain inner_content" style="width:100%">
        <h2>Gayni Profile</h2>
        <table class="style1" style="margin-left:20px">
                    <tr>
                        <td class="style2">
                            <label style="width:200px">Patient Name:</label>
                        </td>
                        <td class="style2" style="margin-left:80px;">
                            <asp:TextBox ID="PName" runat="server"></asp:TextBox>
                        </td>
                         <td class="style2" style="margin-left:80px;">
                            <label class="name" style="margin-left:80px;">Relation:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PRelation" runat="server" style="margin-left:80px;"></asp:TextBox>
                        </td>
                        <td class="style2" style="margin-left:100px; width:200px">
                            <label class="name" style="margin-left:80px;">Relation Name:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PRelationName" runat="server" ></asp:TextBox>
                            <asp:TextBox ID="DID" runat="server" Visible="false" ></asp:TextBox>
                        </td>

                    </tr>
                    <tr>
                        <td class="style2">
                          <label>File No:</label>
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="PFileNo" runat="server" ></asp:TextBox>
                        </td>

                        <td class="style2" style="margin-left:80px;">
                            <label class="name" style="margin-left:80px;">MRNo:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PMRNo" runat="server" style="margin-left:80px;"></asp:TextBox>
                        </td>
                         <td class="style2" style="margin-left:200px;">
                            <label class="name" style="margin-left:80px;">Mobile No:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PMobile" runat="server" ></asp:TextBox>
                        </td>
                   </tr>
  
                     <tr>
                        <td class="style2">
                            <label>Service Date:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PServiceDate" runat="server" ></asp:TextBox>
                        </td>
                         <td class="style2" style="margin-left:200px;">
                            <label class="name" style="margin-left:80px;">Consultant:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PCosultant" runat="server" style="margin-left:80px;"></asp:TextBox>
                        </td>
                        <td class="style2" style="margin-left:200px;">
                            <label class="name" style="margin-left:80px;">Age:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PAgee" runat="server" ></asp:TextBox>
                        </td>
                    </tr> 
                     <tr>
                        <td class="style2">
                            <label>Education:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PEdu" runat="server" ></asp:TextBox>
                        </td>
                         <td class="style2" style="margin-left:180px;">
                            <label class="name" style="margin-left:80px;">Blood Group:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PBlood" runat="server" style="margin-left:80px;"></asp:TextBox>
                        </td>
                          <td class="style2" style="margin-left:80px;">
                            <label class="name" style="margin-left:80px;">Past History:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PPH" TextMode="MultiLine" runat="server" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            <label>Obs Hist(G)</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox TextMode="MultiLine" ID="ObsG" runat="server" ></asp:TextBox>
                        </td>
                         <td class="style2" style="margin-left:80px;">
                            <label class="name" style="margin-left:80px;">Obs Hist(P):</label>
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="ObsP" runat="server" style="margin-left:80px;"></asp:TextBox>
                        </td>
                          <td class="style2" style="margin-left:80px;">
                            <label class="name" style="margin-left:80px;">Obs Hist(A)</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="ObsA" runat="server" ></asp:TextBox>
                        </td>

                       
                        
                    </tr>
                    <tr>
                        <td class="style2">
                            <label>Pt Wt in kg:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PPT" runat="server" ></asp:TextBox>
                        </td>
                         <td class="style2" style="margin-left:200px;">
                            <label class="name" style="margin-left:80px;">Locality:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PLocality" TextMode="MultiLine" runat="server" style="margin-left:80px;"></asp:TextBox>
                        </td>
                          <td class="style2" style="margin-left:200px;">
                            <label class="name" style="margin-left:80px;">Distt:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PDist" runat="server" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            <label>DOA:</label>
                        </td>
                        <td class="style3">
                            <igsch:WebDateChooser ID="doa" runat="server" 
                                Width="202px">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                          <%--  <asp:TextBox ID="PDOA" runat="server" ></asp:TextBox>--%>
                        <%--</td>--%>
                         <td class="style2" style="margin-left:80px;">
                            <label class="name" style="margin-left:80px;">Mother Stay Days:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PDays" runat="server" style="margin-left:80px;"></asp:TextBox>
                        </td>
                          <td class="style2" style="margin-left:130px;">
                            <label class="name" style="margin-left:80px;">Medical Condition:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PMC" TextMode="MultiLine" runat="server" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            <label>Case:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PCase" runat="server" ></asp:TextBox>
                        </td>
                         <td class="style2" style="margin-left:200px;">
                            <label class="name" style="margin-left:80px;">Anesthesia:</label>
                        </td>
                        <td style="margin-left:80px;">
                            <asp:DropDownList ID="ddanesthesia" runat="server" style="margin-left:80px;">
                                <asp:ListItem>General</asp:ListItem>
                                <asp:ListItem>Spinal</asp:ListItem>
                            </asp:DropDownList>
                            <%--<asp:TextBox ID="PAnesthesia" runat="server" ></asp:TextBox>--%>
                        </td>
                          <td class="style2" style="margin-left:200px;">
                            <label class="name" style="margin-left:80px;">Indication:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PIndication" TextMode="MultiLine" runat="server" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            <label>Baby Wt:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PBabywt" runat="server" ></asp:TextBox>
                        </td>
                         <td class="style2" style="margin-left:80px;">
                            <label class="name" style="margin-left:80px;">Baby Gender:</label>
                        </td>
                        <td class="style3" style="margin-left:80px;">
                            <asp:DropDownList ID="ddgender" runat="server" style="margin-left:80px;">
                                <asp:ListItem>Male</asp:ListItem>
                                <asp:ListItem>Female</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>
                           <%-- <asp:TextBox ID="PBGender" runat="server" ></asp:TextBox>--%>
                        </td>
                          <td class="style2" style="margin-left:80px;">
                            <label class="name" style="margin-left:80px;">Date Of Delivery:</label>
                        </td>
                        <td class="style3">
                            <igsch:WebDateChooser ID="PDateDelivery" runat="server" 
                                Width="202px">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                    </tr>
                      <tr>
                        <td class="style2">
                            <label>Time Of Delivery:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PTD" runat="server" ></asp:TextBox>
                        </td>
                         <td class="style2" style="margin-left:180px;">
                            <label class="name" style="margin-left:80px;">Apgar Score:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PAS" runat="server" style="margin-left:80px;"></asp:TextBox>
                        </td>
                          <td class="style2" style="margin-left:80px;">
                            <label class="name" style="margin-left:80px;">Baby Outcome:</label>
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="PBOutcome" runat="server" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            <label>N N Adm #:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PAdmNo" runat="server" ></asp:TextBox>
                        </td>
                         <td class="style2">
                            <label class="name" style="margin-left:80px;">Baby Diagnosis:</label>
                        </td>
                        <td class="style3" >
                            <asp:TextBox TextMode="MultiLine" ID="PBDiagnosis" runat="server" style="margin-left:80px;"></asp:TextBox>
                        </td>
                          <td class="style2" >
                            <label class="name" style="margin-left:80px;">Baby Stay Days:</label>
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="PDuration" runat="server" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                         <td class="style2">
                            <label>Family History:</label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="PFH" TextMode="MultiLine" runat="server" ></asp:TextBox>
                        </td>
                    
                    </tr>
                    <tr>
                        <td>
                            <label>Duration Of Marriage:</label>
                        </td>
                        <td class="style3" style="width:300px;">
                            
                                <igtxt:WebDateTimeEdit ID="WebDateTimeEdit_DOB" TabIndex="8" runat="server"
                                    Culture="en-GB" Style="background-color: #f9dde2;">
                                </igtxt:WebDateTimeEdit>
                                <span style="font-size: 10pt; color: #d92542">*</span><asp:HiddenField ID="HiddenField_DOB" runat="server" />
                                <asp:TextBox AccessKey="a" ID="textboxage" TabIndex="8" runat="server" AutoCompleteType="disabled" Style="background-color: #f9dde2;" ValidationGroup = "s"
                                    Width="28px" MaxLength="3"></asp:TextBox>
                                <asp:DropDownList ID="DropDownListBIndicator" TabIndex="9" runat="server" Width="70px"
                                    AccessKey="y">
                                    <asp:ListItem Selected="True">Years</asp:ListItem>
                                    <asp:ListItem>Months</asp:ListItem>
                                    <asp:ListItem>Days</asp:ListItem>
                                    <asp:ListItem>Hours</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" Display="dynamic"
                                    ControlToValidate="textboxage" ErrorMessage="Enter Valid Age" ValidationExpression="[0-9]*">
                                </asp:RegularExpressionValidator>
                          
                        </td>
                        
                    </tr>
                    
                    <tr>
                        <td class="style2">
                        <label>Trims:</label>
                        </td>
                        <td class="style3">
                          <asp:DropDownList ID="ddtrim" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddtrim_SelectedIndexChanged">
                              <asp:ListItem>--Select Trim--</asp:ListItem>
                              <asp:ListItem>1st Trim</asp:ListItem>
                              <asp:ListItem>2nd Trim</asp:ListItem>
                              <asp:ListItem>3rd Trim</asp:ListItem>
                          </asp:DropDownList>
                        </td>
                         <td style="margin-left:200px;">
                              <asp:Label ID="hbl" runat="server" Visible="false" class="name" style="margin-left:80px;">HB g/dl:</asp:Label>
                             <asp:Label ID="lhbl" runat="server" Visible="false" class="name" style="margin-left:80px;">last HB g/dl:</asp:Label>
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="hbt" runat="server" Visible="false" style="margin-left:80px;"></asp:TextBox>
                        </td>
                         <td class="style2" style="margin-left:80px;">
                              <asp:Label ID="ptl" runat="server" Visible="false" class="name" style="margin-left:80px;">Pt Wt in Kg:</asp:Label>
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="ptt" runat="server" Visible="false" ></asp:TextBox>
                        </td>
                        
                       
                    </tr>
                    <tr>
                        <td class="style2" style="margin-left:100px">
                              <asp:Label ID="hl" runat="server" Visible="false" Font-Bold="true" CssClass="name">Hep B , C: </asp:Label>
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="hept" runat="server" Visible="false"></asp:TextBox>
                        </td>
                 
                        <td class="style2" style="margin-left:100px">
                              <asp:Label ID="countLabel" runat="server" Visible="false" Font-Bold="true" style="margin-left:80px;" CssClass="name">Count: </asp:Label>
                        </td>
                        <td class="style3">
                          <asp:TextBox ID="countText" runat="server" Visible="false" style="margin-left:80px;"></asp:TextBox>
                        </td>
                        <td class="style2">
                        <asp:Label ID="trimLabel" runat="server" Visible="false" Font-Bold="true" style="margin-left:80px;" CssClass="name">Select Trim</asp:Label>
                        </td>
                        <td class="style3">
                          <asp:DropDownList ID="ddtrimvisit" Visible="false" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddtrimvisit_SelectedIndexChanged">
                              <asp:ListItem>--Select Trim--</asp:ListItem>
                              <asp:ListItem>1st Trim</asp:ListItem>
                              <asp:ListItem>2nd Trim</asp:ListItem>
                              <asp:ListItem>3rd Trim</asp:ListItem>
                          </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                      
                        <td></td>
                        <td colspan="2" align="center" style="padding-top:20px">
                        <asp:Button ID="Button1" OnClick="btnSave_Click" runat="server" Text="Save"  
                             CssClass="btn_1" style="float:right"/>
                      </td>
                    </tr>
    </table>
    </div>

    <%--  <asp:Button ID="Button1" 
    runat="server" 
    Text="save" OnClick="Button1_Click" 
     />--%>
</asp:panel>
    <div style="width:100%; margin-top:20px;">
          <asp:GridView  CssClass="table table-striped table-bordered" ID="grdcode" runat="server" DataKeyNames="RegNo" OnSelectedIndexChanged="grdcode_SelectedIndexChanged" AutoGenerateColumns="False" AllowPaging="True" EmptyDataText="No record found." Width="100%" PageSize="25" >
         <Columns>
                <asp:BoundField HeaderText="File No" DataField="PayID" />
                <asp:BoundField HeaderText="Registration No" DataField="RegNo" />
                <asp:BoundField HeaderText="Patient Name" DataField="FullName" />
                <asp:BoundField HeaderText="Relation" DataField="Relation" />
                <asp:BoundField HeaderText="Relation Name" DataField="RFName" />
                <asp:BoundField HeaderText="Mobile Phone" DataField="MobilePhone" />
                <asp:BoundField HeaderText="Service Date" DataField="ServiceDate" />
                <asp:BoundField HeaderText="Consultant" DataField="Consultant" />
           
              <asp:TemplateField HeaderText="Hospital Experience" SortExpression="Status"  ControlStyle-Width="80px">
                    <ItemTemplate>
                    <asp:TextBox ID="abc" runat="server" ></asp:TextBox>
                    </ItemTemplate>  
                </asp:TemplateField>
    
                <asp:CommandField ShowSelectButton="true" ButtonType="Link" SelectText="Save" />
            </Columns>
    </asp:GridView>
    </div>
    <div style="width: 100%; margin-top:20px;">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
       <rsweb:ReportViewer ID="ReportViewer1"  runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>



</asp:Content>

