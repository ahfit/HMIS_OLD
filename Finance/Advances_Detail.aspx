<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Finance_Advances_Detail, App_Web_ymbcbbcj" enabletheming="false" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">

        $('.abc').live("click", function () {

            $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("class", "cba");

        });
        $('.cba').live("click", function () {

            $(this).attr("class", "abc");
            $(this).closest("tr").next().remove();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%;">

         <h2><span>Employees Advance Balance Statement :  </span></h2>
        
            <!-- BEGIN PORTLET-->

                  <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                      
                  <tr>
                <td align="right" width="50%">   Comapny :</td>
                <td align="left" width="50%">

                     <asp:DropDownList ID="ddlFinancialCompanies" runat="server" AutoPostBack="true" DataTextField="Financial_Company_Name"
                                        DataValueField="Financial_Company_Id" CssClass="form-control" OnSelectedIndexChanged="ddlFinancialCompanies_SelectedIndexChanged">
                                    </asp:DropDownList>
                    </td>
                      </tr>

                          <tr>
                <td align="right" width="50%">  Branch : </td>
                <td align="left" width="50%"> 

                       <asp:DropDownList ID="ddlCompanyBranch" runat="server" AutoPostBack="false" DataTextField="Company_Branch_Name"
                                        DataValueField="Company_Branch_Id" CssClass="form-control">
                                    </asp:DropDownList>
                </td>
                    </tr>
    <tr>
                <td align="right" width="50%"> Date: </td>
                <td align="left" width="50%">
                         <igsch:WebDateChooser ID="wdcDate" runat="server" CssClass="form-control" AutoPostBack-ValueChanged="false">
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                </td>
                              </tr>

  <tr>
                <td align="center" colspan="2" width="50%">
                      <asp:Button ID="btnSearch" Text="Search" CssClass="btn btn-primary" 
                                    runat="server" onclick="btnSearch_Click" />
                </td>
            </tr>




                  </table>
         


             <div class="col-md-12 col-sm-12" style="text-align: center;">
                            <asp:Label runat="server" ID="lbl_msg" ForeColor="Red" Font-Size="Medium"></asp:Label>
                        </div>
         </div>



<%--            <div class="portlet">
                <div class="portlet-title">
                    <div class="caption">
                        
                    </div>
                    <div class="tools">
                        <a href="#" class="collapse"></a><a href="#" class="remove"></a>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="form-horizontal">
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label class="col-md-4 control-label">
                                  </label>
                                <div class="col-md-8 col-sm-12">
                                   
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label class="col-md-4 control-label">
                                  </label>
                                <div class="col-md-8 col-sm-12 ">
                                 


                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label class="col-md-4 control-label">
                                   </label>
                                <div class="col-md-8 col-sm-12">
                               
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                             
                            </div>
                        </div>
                        <div class="dt-sc-hr_small ">
                        </div>
                       
                    </div>
                </div>
            </div>--%>
        
  
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
</asp:Content>
