<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="Sample_Slip.aspx.cs"
    Inherits="Pathology_Sample_Slip" MasterPageFile="~/hacims_masterpage.master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



    <script src="../Patient%20Billing/jquery-1.8.2.js" type="text/javascript"></script>
    <script src="/Patient%20Billing/jQuery.print.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {

            var cln = $("#divMain").clone();
            $("#divClone").html(cln);
            $(".divCopy:last").html("Patient Copy");
            $("#hrefPrint").click(function () {
                // Print the DIV.



                var mywindow = window.open('', 'my div', 'height=400,width=600');
                mywindow.document.write('<html><head><title>my div</title>');
               
                mywindow.document.write('</head><body >');
                mywindow.document.write($("#printdiv").html());
                mywindow.document.write('</body></html>');

                mywindow.document.close(); // necessary for ie >= 10
                mywindow.focus(); // necessary for ie >= 10

                mywindow.print();
                mywindow.close();
                
               // $("#printdiv").print();
                return (false);
            });
        });
    </script>
    <style type="text/css">
        @media print
        {
            #logininfo
            {
                display: none;
            }
        
            #ctl00_Panel1
            {
                display: none;
            }
            #footer
            {
                display: none;
            }
        
            #hrefPrint
            {
                display: none;
            }
        #ctl00_hospital
         {
                display: none;
            }
            #ctl00_Image1
              {
                display: none;
            }
            #p_info
            {
                display: none;
            }
            
            
        
        }
    </style>
  <%--  <style>
<!-- 
select {font-size:12px;}
A:link {text-decoration: none; color: blue}
A:visited {text-decoration: none; color: purple}
A:active {text-decoration: red}
A:hover {text-decoration: underline; color:red}
-->
</style>--%>
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<%--<body>--%>

    <div style="float: right; margin-right: 10px;" class="exp">
        <span class="splt">|</span> <a href="javascript:window.print();" id="hrefPrint" title="Print"
            style="float: right; margin-right: 10px; clear: right;" class="print_btn">Print</a>
    </div>

    <div id="printdiv">
    <div id="divMain" style="border: solid 1px #666; width: 850px; padding: 10px;margin: 0 auto;">
        <div style="text-align: center; font-weight: bold; font-size: 22px; padding: 5px 0;">
            <%=Hospital_Name %></div>
        <div style="text-align: center; font-weight: bold; font-size: 19px; padding: 5px 0;"">
           <%-- <%=Dept_Name%>--%>
            Consent Form

        </div>
        <%--<div class="divCopy" style="text-align: center; font-weight: bold; font-size: 13px; padding: 5px 0;"">
            Office Copy</div>--%>
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 130px;">
                    Patient Name:
                </td>
                <td style="width: 340px;">
                    <%=PatNameInfo%>
                </td>
                <td style="width: 130px;">
                    Medical Record #:
                </td>
                <td style="width: 200px;">
                    <%=MedicalRecord_RegNo_withEnc%>
                </td>
            </tr>
            <tr>
                <td>
                    Age / Gender:
                </td>
                <td>
                    <%=val_Age_Gender%>
                </td>
                <td>
                    Hospital Visit #:
                </td>
                <td>
                    <%=Yearly_No%>
                </td>
            </tr>
            <tr>
                <td>
                    Contact #:
                </td>
                <td>
                    <%=MobilePhone%>
                </td>
                <td>
                    Receipt #:
                </td>
                <td>
                    <%=ReceiptNo_SPM_ID%>
                </td>
            </tr>
            <tr>
                <td>
                    Request Date::
                </td>
                <td>
                    <%=Test_Booking_Date%>
                </td>
                <td>
                    Patient Type:
                </td>
                <td>
                    <%=PatientType%>
                </td>
            </tr>
        </table>
        
            
                
                
                        
                        <br />
                        
                        <table class="Grid_1" style="width:850px;">
                        <tr>
                        <th style="width:250px">Investigation Name</th>
                        <th style="width:200px">Appointment Date</th>
                        <th style="width:200px">Report time</th>
                        <th style="width:200px">Remarks</th>
                        <th style="width:200px">Doctor</th>
                        <th style="width:200px">Anesthesia</th>
                        <th style="width:200px">OT Department</th>
                        
                        </tr>
                        <tbody>
                        
                            <asp:Repeater runat="server" ID="rptPatientServicesBill">
                            <ItemTemplate>
                            <tr>
          
          
                            <td >
                              <asp:Label ID="lblTBname" runat="server" Text='<%# Eval("TB_Name")%>'></asp:Label>
                            </td>
                            <td style="text-align:center;">
                             <asp:Label ID="lblcollecttime" runat="server" Text='<%# Eval("Collection_Time")%>' />
                            </td>
                            <td style="text-align:center;">
                              <asp:Label ID="lblreporttime" runat="server" Text='<%# Eval("Report time")%>' />
                            </td>
                            <td>
                               <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description")%>' />
                            </td>

                               <td>
                               <asp:Label ID="lbldoctor" runat="server" Text='<%# Eval("DoctorName")%>' />
                            </td>

                              <td >
                               <asp:Label ID="lblAnesthesia_Desc" runat="server" Text='<%# Eval("Anesthesia_Desc")%>' />
                            </td>

                              <td >
                               <asp:Label ID="Label1" runat="server" Text='<%# Eval("OT_Dept_Name")%>' />
                            </td>
                            
                            
                            </tr>
                            <tr>
                            <td colspan="2" style="font-weight:bold; text-align:center;">English Instructions</td>
                             <td colspan="5" style="font-weight:bold; text-align:center;">Urdu Instructions</td>
                            </tr>
                            <tr>
                            <td colspan="2"><%# Eval("EnglishInst")%></td>
                             <td colspan="5" style="text-align:right;"><%# Eval("UrduInst")%></td>
                            </tr>
                                 <tr>
                            <td colspan="8" style="border-right:none;">
                             <div style="font-weight: bold;padding-top: 5px;">
                              &nbsp;&nbsp;  Name of the  Patient _________________________________________________________________________________________________________________________________
                                 <br /><br />&nbsp; 1. I hereby autorized the doctor of <%=Hospital_Name %> to perform the following procedures / Operations.<br /><br />
                                  <div  style="margin-right:0px;"> <img alt="image" src="../OTConsentForm/iMAGREEFORFOLLOWINGOP.png" ALIGN=RIGHT /></div><br />
                                 <div>
                                     
                                     <img alt="image2" src="../OTConsentForm/nOTES.png" />
                                     <br />
                                     <br />
                                   &nbsp;&nbsp;  Signature of Patient _______________________________ Date __________________________ Time ____________________________
                                     <br />
                                     <br />
                                     <br />
                                     <br/>
                                     &nbsp;&nbsp;In case of minor,signature of guardian(i am only legal guardian at the moment)
                                     <br/>
                                     <br/>
                                      <br/>
                                     
                                    &nbsp;&nbsp; Witness
                                     <br/>
                                     <br/>
                                      <br/>
                                    
                                    &nbsp;&nbsp; 1. Sig ____________________________________ Name _______________________________ Designation/Relation ______________________________
                                     <br/>
                                     <br/>
                                     <br/>
                                    &nbsp;&nbsp; 2. Sig ____________________________________ Name _______________________________ Designation/Relation ______________________________
                                     <br/>
                                     <br/>
                                 </div>

</div>
                            </tr>
                           
                            </ItemTemplate>
                           <FooterTemplate>
                            <tr>
                            <td colspan="7" style="border-right:none;">
                             <div style="font-weight: bold;">
                                            <span>Print Date:</span> 
                                            <span  style="padding:10px;">
                                                <%=DateTime.Now.ToShortDateString()  %>
                                                <%=DateTime.Now.ToShortTimeString()%></span>
                                        
                                          <span class="cls_datetime" style="padding-left:90px;">By:
                                            <%=loginUserName%></span>
                                        </td> 
                                       </div>
                            </tr>
                           </FooterTemplate>
                            </asp:Repeater>
                        </tbody>
                        </table>
                       

    
    </div>
  <%--  <div id="divClone" style="margin: 20px auto 0 auto;">
    </div>--%>
    </div>
    
    <script type="text/javascript">
        var currentZoom = parent.ltop.currentZoom;
        if (currentZoom != undefined)
            document.body.style.zoom = currentZoom / 100;

       
    </script>
<%--</body>--%>
</asp:Content>
