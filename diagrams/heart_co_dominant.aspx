<%@ page language="VB" autoeventwireup="false" inherits="heart_co_dominant, App_Web_ntfdmjyx" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 
<script src="Scripts/swfobject_modified.js" type="text/javascript"></script>
</head>
<body>
    

    
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="HiddenField_client_querry" runat="server" />
        &nbsp;<asp:SqlDataSource ID="SqlDataSource_insert_dermatomes" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
            InsertCommand="dermatomes_insert" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
            UpdateCommand="dermatomes_update" UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:SessionParameter DefaultValue=" " Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
                <asp:SessionParameter DefaultValue="" Name="registration_No" SessionField="registrationNo"
                    Type="String" />
                <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Int32" />
                <asp:SessionParameter Name="dept_id" SessionField="dept_id" Type="Int32" />
                <asp:SessionParameter Name="From_called" SessionField="From" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_client_querry" Name="ClientQueryString"
                    PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_DiagramID" Name="Diagram_ID" PropertyName="Value"
                    Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
                <asp:SessionParameter Name="registration_No" SessionField="registrationNo" Type="String" />
                <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Int32" />
                <asp:SessionParameter Name="dept_id" SessionField="dept_id" Type="Int32" />
                <asp:SessionParameter Name="From_called" SessionField="From" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_client_querry" Name="ClientQueryString"
                    PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_DiagramID" DefaultValue="" Name="Diagram_ID"
                    PropertyName="Value" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_select_dermatomes" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
            SelectCommand="dermatomes_select" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" Type="Int32" />
                <asp:SessionParameter Name="registration_No" SessionField="registrationNo" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_DiagramID" DefaultValue="" Name="Diagram_ID"
                    PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_DiagramID" runat="server" Value="6" />
        <br />
        <asp:Label ID="Label_flash" runat="server"></asp:Label></div>
    </form>
</body>
</html>
