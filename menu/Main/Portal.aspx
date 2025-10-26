<%@ page language="VB" autoeventwireup="false" inherits="Portal, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td style="width: 351px; height: 46px">
                    <asp:Xml ID="XmlPatient_Reg_All_Dept" runat="server" DocumentSource="~/XMLFile/Patinet_Registration_Department.xml"
                        TransformSource="~/XSLFile/MyFile.xsl"></asp:Xml></td>
                <td style="width: 544px; height: 46px">
                    <asp:Xml ID="XmlPatient_Reg_Emerg_Dept" runat="server" DocumentSource="~/XMLFile/Patinet_Registration_Emergency_Department.xml"
                        TransformSource="~/XSLFile/Emergency_Patient_Reg.xsl"></asp:Xml></td>
                <td style="width: 477px; height: 46px">
                    <asp:Xml ID="XmlPatient_Reg_Radiology_Dept" runat="server" DocumentSource="~/XMLFile/Patinet_Registration_Radiology_Department.xml"
                        TransformSource="~/XSLFile/Radiology_Patient_Reg.xsl"></asp:Xml></td>
            </tr>
            <tr>
                <td colspan="3" style="height: 21px">
                    </td>
            </tr>
            <tr>
                <td style="width: 351px">
                    <asp:Xml ID="XmlWard_Addmission" runat="server" DocumentSource="~/XMLFile/WardAddmission.xml" TransformSource="~/XSLFile/WardAddmission.xsl"></asp:Xml></td>
                <td style="width: 544px">
                    <asp:Xml ID="XmlDate_Wise_Revenue" runat="server" DocumentSource="~/XMLFile/Date_Wise_Revenue.xml"
                        TransformSource="~/XSLFile/Date_Wise_Revenue.xsl"></asp:Xml></td>
                <td style="width: 477px">
                    <asp:Xml ID="XmlDate_Wise_Expenditure" runat="server" DocumentSource="~/XMLFile/date_wise_Expenditure.xml"
                        TransformSource="~/XSLFile/date_wise_Expenditure.xsl"></asp:Xml></td>
            </tr>
            <tr>
                <td style="width: 351px">
                    <asp:Xml ID="XmlDate_wise_Cheque_Issuse" runat="server" DocumentSource="~/XMLFile/date_wise_Cheque_issue.xml"
                        TransformSource="~/XSLFile/date_wise_Cheque_issue.xsl"></asp:Xml></td>
                <td style="width: 544px">
                    <asp:Xml ID="XmlDate_Wise_Bank_Balance" runat="server" DocumentSource="~/XMLFile/date_wise_Bank_Balance.xml"
                        TransformSource="~/XSLFile/date_wise_Bank_Balance.xsl"></asp:Xml></td>
                <td style="width: 477px">
                    <asp:Xml ID="XmlAdvertiser_Request" runat="server" DocumentSource="~/XMLFile/advertise_request.xml"
                        TransformSource="~/XSLFile/advertise_request.xsl"></asp:Xml></td>
            </tr>
            <tr>
                <td style="width: 351px; height: 21px">
                    <asp:Xml ID="XmlTransfer_In_Request" runat="server" DocumentSource="~/XMLFile/Transfer_In_request.xml"
                        TransformSource="~/XSLFile/Transfer_In_request.xsl"></asp:Xml></td>
                <td style="width: 544px; height: 21px">
                    <asp:Xml ID="XmlTransfer_Out_View" runat="server" DocumentSource="~/XMLFile/Transfer_Out_view.xml"
                        TransformSource="~/XSLFile/Transfer_Out_view.xsl"></asp:Xml></td>
                <td style="width: 477px; height: 21px">
                    &nbsp;<asp:Xml ID="Xml_Budget_Detail" runat="server" DocumentSource="~/XMLFile/Budget_Detail_xml.xml"
                        TransformSource="~/XSLFile/Budget_Detail_xml.xsl"></asp:Xml></td>
            </tr>
            <tr>
                <td style="width: 351px; height: 21px">
                    &nbsp;<asp:Xml ID="XmlTotal_Medical_Staff" runat="server" DocumentSource="~/XMLFile/Total_Medical_Staff.xml"
                        TransformSource="~/XSLFile/Total_Medical_Staff.xsl"></asp:Xml></td>
                <td style="width: 544px; height: 21px">
                    <asp:Xml ID="XmlTotal_Non_Medical_Staff" runat="server" DocumentSource="~/XMLFile/Total_Non_Medical_Staff.xml"
                        TransformSource="~/XSLFile/Total_Non_Medical_Staff.xsl"></asp:Xml></td>
                <td style="width: 477px; height: 21px">
                    <asp:Xml ID="XmlTender" runat="server" DocumentSource="~/XMLFile/Tender.xml" TransformSource="~/XSLFile/Tander.xsl"></asp:Xml></td>
            </tr>
            <tr>
                <td style="width: 351px; height: 21px">
                    <asp:Xml ID="Xml_VehicleOut" runat="server" DocumentSource="~/XMLFile/VehicleOut.xml"
                        TransformSource="~/XSLFile/Vehicle_Out.xsl"></asp:Xml></td>
                <td style="width: 544px; height: 21px">
                    <asp:Xml ID="Xml_Vehicle_Requisition" runat="server" DocumentSource="~/XMLFile/VehicleRequistion.xml"
                        TransformSource="~/XSLFile/Requisition.xsl"></asp:Xml></td>
                <td style="width: 477px; height: 21px">
                    <asp:Xml ID="Xml_Vehicle_OutofOrder" runat="server" DocumentSource="~/XMLFile/VehicleOut_OfOrder.xml"
                        TransformSource="~/XSLFile/VehicleOutOf_Order.xsl"></asp:Xml></td>
            </tr>
            <tr>
                <td style="width: 351px; height: 21px">
                    </td>
                <td style="width: 544px; height: 21px">
                </td>
                <td style="width: 477px; height: 21px">
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
