<%@ control language="C#" autoeventwireup="true" inherits="UserControls_AdmitDischarged, App_Web_gvh2jdkn" %>
<asp:FormView ID="fmvAdmitDischarged" runat="server" 
    DataSourceID="dsAdmitDischarged">
    
    
    <ItemTemplate>
        <table style="width: 100%;">
            <tr>
                <td>
                    &nbsp; Admissions :</td>
                <td>
                    &nbsp;<asp:LinkButton ID="AdmissionLabel" runat="server" 
                        Text='<%# Bind("Admission") %>' 
                        PostBackUrl="~/Patient Registration/AdmissionDischargeList.aspx?Status=1" />
&nbsp;</td>
                <td>
                    &nbsp; Discharge:</td>
                <td>
                    <asp:LinkButton ID="DischargeLabel" runat="server" 
                        Text='<%# Bind("Discharge") %>' 
                        PostBackUrl="~/Patient Registration/AdmissionDischargeList.aspx?Status=0" />
                </td>
            </tr>
        </table>
        &nbsp;<br />
        &nbsp;<br />
    </ItemTemplate>
</asp:FormView>
<asp:SqlDataSource ID="dsAdmitDischarged" runat="server" 
    ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>" 
    SelectCommand="SELECT ISNULL((SELECT COUNT(*) AS Expr1 FROM Patient INNER JOIN Payment ON Patient.RegNo = Payment.RegNo WHERE (Payment.PayID = (SELECT MAX(PayID) AS Expr1 FROM Payment AS Payment_1 WHERE (RegNo = Patient.RegNo))) AND (CONVERT (varchar, Payment.DateTime, 103) = CONVERT (varchar, GETDATE(), 103)) AND (Payment.Patient_Type = 'IPD')), 0) AS Admission, ISNULL((SELECT COUNT(*) AS Expr1 FROM Patient AS Patient_1 INNER JOIN Payment AS Payment_2 ON Patient_1.RegNo = Payment_2.RegNo WHERE (Payment_2.PayID = (SELECT MAX(PayID) AS Expr1 FROM Payment AS Payment_1 WHERE (RegNo = Patient_1.RegNo))) AND (CONVERT (varchar, Payment_2.DischargeDateTime, 103) = CONVERT (varchar, GETDATE(), 103)) AND (Payment_2.Patient_Type = 'IPD')), 0) AS Discharge">
</asp:SqlDataSource>

