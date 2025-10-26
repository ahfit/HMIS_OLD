<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="MachineIntegCompWise.aspx.cs" Inherits="Pathology_LabTestSummaryReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
            .hiddencol
              {
                display: none;
              }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="bxmain inner_content" style="width:100%">
           <h2><span>Machine Integration Component Wise</span></h2>
                <table class="style1" style="margin-left:320px">
                  
                    <tr>
                        <td class="style2">
                          Lab Machine :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlMachine" runat="server" AutoPostBack="True" onselectedindexchanged="ddlMachine_SelectedIndexChanged" AppendDataBoundItems="true"
                                DataTextField="Machine_Name" DataValueField="Machine_Id" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                   </tr>
                   <tr>
                        <td class="style2">
                          Test Component :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddTestComponent" runat="server" AppendDataBoundItems="true"
                                DataTextField="ComponentName" DataValueField="TCID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                   </tr>
                    <tr>
                        <td class="style2">
                          Machine Code :
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="machineCode" runat="server"></asp:TextBox>
                        </td>
                   </tr>
                    <tr>
                        <td class="style2">
                          Assay Number :
                        </td>
                        <td class="style3">
                            <asp:TextBox ID="assayNumber" runat="server"></asp:TextBox>
                        </td>
                   </tr>

                    <tr>
                      
                        <td></td>
                    <td colspan="2" align="center" style="padding-top:20px">
                        <asp:Button ID="btnSearch" OnClick="btnAdd_Click" runat="server" Text="Add"  
                             CssClass="btn_1" style="float:right"/>
                      </td>
                    </tr>
    </table>
    </div>
    <div style="width:100%; margin-top:20px;">
          <asp:GridView  CssClass="table table-striped table-bordered" ID="grdcode" runat="server" OnSelectedIndexChanged="grdcode_SelectedIndexChanged" AutoGenerateColumns="False" AllowPaging="True" EmptyDataText="No record found." Width="100%" PageSize="25" >
         <Columns>
                 <asp:BoundField HeaderText="Lab Machine ID" DataField="Lab_M_Id" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" >
                </asp:BoundField>
                <asp:BoundField HeaderText="Machine" DataField="Machine_Name" />
                
                <asp:BoundField HeaderText="Test Component" DataField="ComponentName" />
                
                <asp:BoundField HeaderText="Patient Name" DataField="TCID" Visible="false" />
                <asp:BoundField HeaderText="Machine Code" DataField="MachineCode"  />
                <asp:BoundField HeaderText="Assay Number" DataField="AssayCode"  />
           
    
                <asp:CommandField ShowSelectButton="true" ButtonType="Link" SelectText="Delete" />
            </Columns>
    </asp:GridView>
    </div>
    <div style="width: 100%; margin-top:20px;">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
       <rsweb:ReportViewer ID="ReportViewer1"  runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>



</asp:Content>

