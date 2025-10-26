<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Radiology_Para_Report.aspx.vb"
    MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Radiology_Radiology_Para_Report" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css" media="screen">
        .datalift
        {
            font-size: 10px;
            padding: 4px;
            text-align: left;
        }
        .dataright
        {
            font-size: 10px;
            padding: 4px;
            text-align: right;
        }
        .data
        {
            font-size: 11px;
            font-weight: bold;
            text-align: center;
        }
        
        .font_rpt table td p
        {
            line-height: 14px !important;
            margin-bottom: 0px !important;
        }
        
        body
        {
            font-family: arial;
        }
        .hr
        {
            border-top: #999 solid 2px;
            width: 100%;
            padding-top: 5px;
            padding-bottom: 5px;
            margin-top: 5px;
        }
        /* #footer {display:none;}
  #header{display:none;}*/
        .tbl_form
        {
            font-size: 10px;
        }
        .font_rpt
        {
            font-size: 12px;
            width: 100%;
            line-height: 14px;
        }
        
        p
        {
            list-style: none;
        }
        ul
        {
            padding: 0;
            margin: 0;
            list-style: none;
            margin-left: 12px;
        }
        ul li
        {
            line-height: 15px;
            font-size: 11px;
            list-style: none;
        }
        
        
        h1
        {
            font-size: 15px;
            font-weight: bold;
            color: #000;
        }
    </style>
    <style type="text/css" media="print">
        .data
        {
            font-size: 10px;
            padding: 4px;
            text-align: center;
        }
        .datalift
        {
            font-size: 10px;
            padding: 4px;
            text-align: left;
        }
        .dataright
        {
            font-size: 10px;
            padding: 4px;
            text-align: right;
        }
        
        .font_rpt table td p
        {
            line-height: 14px !important;
            margin-bottom: -8px !important;
        }
        
        body
        {
            font-family: arial;
        }
        .hr
        {
            border-top: #999 solid 1px;
            width: 100%;
            padding-top: 5px;
            padding-bottom: 5px;
            margin-top: 5px;
        }
        #footer
        {
            display: none;
        }
        #header
        {
            display: none;
        }
        .hinfo
        {
            display: none;
        }
        .tbl_form
        {
            font-size: 10px;
        }
        .font_rpt
        {
            font-size: 12px;
            width: 100%;
            line-height: 14px;
        }
        .table p
        {
            font-size: 12px;
            width: 100%;
            line-height: 14px;
        }
        ul
        {
            padding: 0;
            margin: 0;
            list-style: none;
            margin-left: 12px;
        }
        ul li
        {
            line-height: 15px;
            font-size: 11px;
            list-style: none;
        }
        h1
        {
            font-size: 15px;
            font-weight: bold;
            color: #000;
        }
        .Grid_1
        {
            font-size: 11px;
            font-weight: normal;
        }
        #navigation
        {
            display: none;
        }
        .leftnav
        {
            display: none;
        }
        #p_info
        {
            display: none;
        }
        .printTable
        {
            font-family: Calibri;
            font-size: 100px;
        }
        .printTable td
        {
            font-family: Calibri;
            font-size: 10px;
            height: 16px;
            padding-right: 3px;
        }
        .fieldset
        {
            display: block;
        }
        #mprint
        {
            display: none;
        }
        
        .medication
        {
            margin-left: -40px;
            margin-top: 5px;
            margin-bottom: 5px;
        }
        .liness
        {
            min-height: 50px;
        }
    </style>
    <script type="text/javascript">
        function printData() {
            var divToPrint = document.getElementById("printTable");
            newWin = window.open("");
            newWin.document.write(divToPrint.outerHTML);
            newWin.print();
            newWin.close();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" id="printTable">
        <thead>
            <tr>
                <td height="182" valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="25%" align="Right" valign="top">
                                <asp:Image ID="Image1" runat="server" Visible="false"  />
                            </td>
                            <td width="50%" valign="top" align="left">
                                <ul>
                                    <li><strong>
                                        <asp:Label ID="Hospital_Name" runat="server" Text="Hospital_Name" Font-Bold="True"
                                            style="font-size:Large;font-weight:bold;"></asp:Label>
                                            
                                            <asp:Label ID="lbladd" runat="server" Text="Hospital_Name" Font-Bold="True"
                                            style="font-weight:bold;"></asp:Label>

                                            </strong></li></ul>


                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" valign="top">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Grid_1" style="margin-top: 10px;">
                                    <tr>
                                        <td width="16%" align="right">
                                            &nbsp;
                                        </td>
                                        <td align="center" colspan="4" style="font-size: large; font-weight: bold; line-height: 30px">
                                           <%-- Department of Clinical Radiology and Medical Imaging--%>
                                           Operation Notes
                                        </td>
                                        <td width="16%">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="16%" align="right">
                                            <strong>Patient Name :</strong>
                                        </td>
                                        <td width="16%">
                                            <strong>
                                                <asp:Label ID="Label_Patient_Name" runat="server" Text="Patient Name"></asp:Label>&nbsp;</strong>
                                            <asp:Label ID="Label_Relation" runat="server"></asp:Label>
                                            <asp:Label ID="Label_RELATIONNAMEe" runat="server"></asp:Label>
                                        </td>
                                        <td width="16%" align="right">
                                            <strong>Medical Record # :</strong>
                                        </td>
                                        <td width="16%">
                                            <asp:Label ID="Label_RegNo" runat="server"></asp:Label>
                                        </td>
                                        <td width="16%" align="right">
                                            <strong>Patient Type :</strong>
                                        </td>
                                        <td width="16%">
                                            <asp:Label ID="Label_PatientType" runat="server"></asp:Label>
                                            <asp:Label ID="Label_Patient_Type" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <strong>Age/Gender :</strong>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label_Gender" runat="server"></asp:Label>
                                        </td>
                                        <td align="right">
                                            <strong>Hospital Visit :</strong>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label_Yearly_No" runat="server"></asp:Label>
                                        </td>
                                        <td align="right">
                                            <strong>Order Date :</strong>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label_Sample_Collection_Date" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <strong>Contact # :</strong>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label_MobilePhone" runat="server"></asp:Label>
                                        </td>
                                        <td align="right">
                                        </td>
                                        <td>
                                        </td>
                                        <td align="right">
                                            <strong>Performed :</strong>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label_Perform_Date" runat="server" Text="Perform_Date"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="height: 18px">
                                            <strong>Referred By :</strong>
                                        </td>
                                        <td style="height: 18px">
                                            <asp:Label ID="Label_ReferFrom" runat="server"></asp:Label>
                                        </td>
                                        <td align="right" style="height: 18px">
                                            <strong>Reference # :</strong>
                                        </td>
                                        <td style="height: 18px">
                                            &nbsp;
                                        </td>
                                        <td align="right" style="height: 18px">
                                            <strong>Reported :</strong>
                                        </td>
                                        <td style="height: 18px">
                                            <asp:Label ID="Label_End_datetime" runat="server" Text="End_datetime"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <div class="hr">
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center" style="line-height: 30px;">
                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="Large" Font-Underline="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td height="283" valign="top">
                    <asp:Label ID="Label_CNIC" runat="server" Visible="false"></asp:Label>
                    <asp:Label ID="Label_HomePhone" runat="server" Visible="false"></asp:Label>
                    <asp:Label ID="Label_RegDateTime" runat="server" Visible="false"></asp:Label>
                    <asp:Label ID="Label_StreetAddress" runat="server" Visible="false"></asp:Label>
                    <asp:Label ID="Label_Test_Booking_Date" runat="server" Visible="false"></asp:Label>
                    <asp:Label ID="Label_PayID" runat="server" Visible="false"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="Label_Report" runat="server" Text="" CssClass="font_rpt"></asp:Label>
                    <br />
                    <br />
                </td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td width="100%" valign="top">
                    <div align="center" style="display: none;">
                        Electronically verified report, signature(s) not required</div>
                    <div class="hr ">
                        <p align="center">
                            This is system generated report and does not require signature.</p>
                    </div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            
                            
                            <%--  <img alt="" align="middle" src="FooterDrName.png" />--%>
                            
                            

                           
                     
                        
                        </tr>
                    </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td colspan="6">
                                <div class="hr">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="datalift">
                                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                            </td>
                            <td class="data">
                            </td>
                            <td class="data">
                            </td>
                            <td class="data">
                            </td>
                            <td class="data">
                            </td>
                            <td class="dataright">
                                <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </table>
                  
                </td>
            </tr>
        </tfoot>
    </table>
    <div align="right" id="mprint">
        <a href="javascript:window.print()" class="print_btn">Print Preview</a></div>
</asp:Content>
