<%@ Page  Language="C#" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="true" CodeFile="PatientICDCodeDiagnosis.aspx.cs" Inherits="Pt_EMR_PatientICDCodeDiagnosis" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script type="text/javascript">
          function ClientItemSelected(sender, e) {
              var value = e.get_value();            
              document.getElementById('ctl00_ContentPlaceHolder1_txtboxDiagnoseName').value = value


          }

          function autoComplete1_OnClientPopulating(sender, args) {

              $('[id$="txtboxDiagnoseName"]').text($('[id$="hfId"]').val())
               
          }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <table class="table table-condensed" width="100%">
        <tr>
            <td class="col-md-3 text-right">
                Diagnosis Type
            </td>
            <td class="col-md-4">
                <asp:DropDownList ID="ddllist" runat="server"  ></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="col-md-3 text-right">
                ICD Code
            </td>
            <td class="col-md-4">

                <asp:TextBox ID="txtboxICDCodes"   runat="server" ></asp:TextBox>

                 <asp:AutoCompleteExtender  ID="Auto_Names_Extender" runat="server" ServiceMethod="SearchNames"
                        MinimumPrefixLength="2" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtboxICDCodes" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected"
                     
                     >
                    </asp:AutoCompleteExtender>
            </td>
        </tr>
        <tr>
            <td class="col-md-3 text-right">
                Diagnose Name
            </td>
            <td class="col-md-4">
                <asp:TextBox ID="txtboxDiagnoseName"   runat="server" ></asp:TextBox>
            </td>
        </tr>
           <tr>
            <td class="col-md-3 text-right">
               Remarks
            </td>
            <td class="col-md-4">
                <asp:TextBox ID="txtboxRemarks" TextMode="MultiLine" Height="60px" Width="300px"   runat="server" ></asp:TextBox>
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hfId" />
    <br />
    <div style="text-align:center">
        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" />
    </div>
</asp:Content>

