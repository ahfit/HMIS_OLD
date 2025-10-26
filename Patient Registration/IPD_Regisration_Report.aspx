<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="IPD_Regisration_Report, App_Web_v1lhzben" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type ="text/javascript">

    var gAutoPrint = true; // Flag for whether or not to automatically call the print function 
    function printSpecial() {

        if (document.getElementById != null) {
            if (document.getElementById("btn_print").value = "close") {
                window.close();
            } else {
                document.getElementById("btn_print").value = "close";
            }
            var html = '<HTML>\n<HEAD>\n';
            if (document.getElementsByTagName != null) {
                var headTags = document.getElementsByTagName("head");
                if (headTags.length > 0) html += headTags[0].innerHTML;
            }
            if (gAutoPrint) {
                if (navigator.appName == "Microsoft Internet Explorer") {
                    html += '\n</HEAD>\n<'
                    html += 'BODY onLoad="PrintCommandObject.ExecWB(6, -1);">\n';
                }
                else {
                    html += '\n</HEAD>\n<BODY>\n';
                }
            }
            else {
                html += '\n</HEAD>\n<BODY>\n';
            }

            var printReadyElem = document.getElementById("ctl00_ContentPlaceHolder1_ReportViewer1_ctl10");
            if (printReadyElem != null) {
                html += printReadyElem.innerHTML;
            }
            else {
                alert("Could not find the printReady section in the HTML");
                return;
            }
            if (gAutoPrint) {
                if (navigator.appName == "Microsoft Internet Explorer") {
                    html += '<OBJECT ID="PrintCommandObject" WIDTH=0 HEIGHT=0 '
                    html += 'CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT >\n</BODY>\n</HTML>';
                }
                else {
                    html += '\n</BODY>\n</HTML>';
                }
            }
            else {
                html += '\n</BODY>\n</HTML>';
            }
            var printWin = window.open("", "printSpecial");
            printWin.document.open();
            printWin.document.write(html);

            printWin.setTimeout("window.close()", 9000);
            if (navigator.appName != "Microsoft Internet Explorer") {
                document.body.innerHTML = originalContents;
            }
            printWin.document.close();
            if (gAutoPrint) {
                if (navigator.appName != "Microsoft Internet Explorer") {

                    printWin.print();
                }
            }
        }
        else {
            alert("Sorry, the print ready feature is only available in modern browsers.");
        }
        printWin.close();
    }

    function Set_focus() {
        document.getElementById("btn_print").focus();
    }

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
        
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:SqlDataSource ID="sds_report" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" SelectCommand="SELECT     Payment.PayID, Payment.ReferFrom, Payment.RegNo, Payment.PatientType, CONVERT(varchar, Payment.DateTime, 103) AS Dte, CONVERT(varchar, 
                      Payment.DateTime, 108) AS Time, Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName, Patient.Relation, ISNULL(Patient.RFName, '') 
                      + ' ' + ISNULL(Patient.RMName, '') + ' ' + ISNULL(Patient.RLName, '') AS PR_Name, CONVERT(varchar, Patient.Age) + ' ' + Patient.AgeType AS Age, Gender.Gender, 
                      Payment.Refer_Department, Patient.House_No, ISNULL(Department.Dept_Name, '') AS Dept_Name,ISNULL(Employee.EFName, '') 
                      + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Doctor, Department_1.Dept_Name AS Department, 
                      SubDepartment.SubDept_Name AS SubDepartment, ISNULL(admin_Hospital_Wards.Ward_Name, '') AS Ward_Name, AP.Amount, AP.Payment_No, AP.Payment_Type, 
                      left(Convert(varchar,Patient.CNIC),5)+'-'+SubString(Convert(varchar,Patient.CNIC),6,7) +'-'+  right(Convert(varchar,Patient.CNIC),1) AS CNIC
FROM         Department AS Department_1 INNER JOIN
                      Payment INNER JOIN
                      Patient ON Payment.RegNo = Patient.RegNo INNER JOIN
                      Gender ON Patient.SexID = Gender.Gender_ID ON Department_1.Dept_ID = Payment.DeptID LEFT OUTER JOIN
                      admin_Hospital_Wards ON Payment.Ward_Id = admin_Hospital_Wards.Ward_id LEFT OUTER JOIN
                      Employee ON Payment.DoctorID = Employee.EmpID LEFT OUTER JOIN
                      Department INNER JOIN
                      SubDepartment ON Department.Dept_ID = SubDepartment.Dept_Id ON Payment.SubDept_id = SubDepartment.SubDept_Id LEFT OUTER JOIN
                      BasicDataInfo.dbo.Advance_Payment AS AP ON AP.RegNo = Payment.RegNo AND AP.YearlyNo = Payment.PayID
WHERE     (Payment.RegNo = @RegNo) AND (Payment.PayID = @PayID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="hf_reg_no" Name="RegNo" PropertyName="Value" />
            <asp:ControlParameter ControlID="hf_year_no" Name="PayID" 
                PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <input type="button" value="print" onclick="printSpecial()" id = "btn_print" autofocus="autofocus" onload ="Set_focus()"><br />
<rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
</rsweb:ReportViewer>

    

    <asp:HiddenField ID="hf_reg_no" runat="server" />
    <asp:HiddenField ID="hf_year_no" runat="server" />
    <asp:HiddenField ID="HF_Employee_Name" runat="server" />
    

</asp:Content>


