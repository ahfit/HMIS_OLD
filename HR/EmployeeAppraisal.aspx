<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EmployeeAppraisal.aspx.cs" Inherits="HR_EmployeeAppraisal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="jquery-1.12.3.js"></script>
   <script type="text/javascript">
       $(document).ready(function () {

           $('[id$="txtboxGetMarks"]').keyup(function () {
               var tr = $(this).closest('tr');
               var labelToalMarks = tr.find('[id$="lblWeightage"]');
               if (parseFloat($(this).val()) > parseFloat(labelToalMarks.text())) {
                   alert("Obtained Marks can not be greater than actual marks")
                   $(this).val('0')
               }
           })
       });

       function alternate(id){ 
           if(document.getElementsByTagName){  
               var table = document.getElementById(id);   
               var rows = table.getElementsByTagName("tr");   
               for(i = 0; i < rows.length; i++){           
                   //manipulate rows 
                   if(i % 2 == 0){ 
                       rows[i].className = "even"; 
                   }else{ 
                       rows[i].className = "odd"; 
                   }
               }
           }
       }

      
   </script>

    <style type="text/css">
        #tblInner {
            border:1px solid
        }
        .odd {
            background-color: white;
        }

        .even {
            background-color: gray;
        }
        .auto-style1 {
            height: 34px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
        <div class="bxmain inner_content" style="width: 100%;">
            <h2><span>Employee Probabtion</span></h2>
        
        <table cellpadding="0" cellspacing="0" border="0" style="margin:0 auto;width:75%" class="tbl_form">
            <tr>
                <td width="20%" align="right">Financial Year :  </td>
                <td class="radio-Type" align="left">
                    <asp:DropDownList ID="ddlFinancialYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFinancialYear_SelectedIndexChanged"></asp:DropDownList>
                </td>
                <td width="20%" align="right">Department :  </td>
                <td class="radio-Type" align="left">
                    <asp:DropDownList ID="DropDownListSubDepartment" AutoPostBack="true" OnSelectedIndexChanged="DropDownListSubDepartment_SelectedIndexChanged" runat="server"></asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td width="20%" align="right">Employee :  </td>
                <td class="radio-Type" align="left">
                    <asp:DropDownList ID="ddlEmployee" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                </td>
           
                <td width="20%" align="right">Designation :  </td>
                <td class="radio-Type" align="left">
                    <asp:DropDownList Enabled="false" ID="ddlDesignation" runat="server"></asp:DropDownList>
                </td>
            </tr>
           
            <tr>
                <td align="center" colspan="4" >
                    <asp:Button ID="btnView" runat="server" CssClass="btn btn-info btn-lg" OnClick="btnView_Click" Text="Save" />
                    <asp:Label ID="lblmsg" runat="server" Visible="false" Font-Bold="true" Font-Size="Large" ForeColor="Green"></asp:Label>
                </td>
            </tr>
        </table>
            <asp:Panel ID="Panel1"  runat="server" CssClass="lightbox" Visible="false">
                <div>
                    <table width ="100%">
                        <tr>
                            <td colspan="2" align="center" style="color:red" > <asp:Label ID ="lbl_Ename" runat ="server"></asp:Label> </td>
                        </tr>
                        <tr>
                            <td width="50%" align ="right">Financial Year : </td>
                            <td colspan="2" > <asp:Label ID ="lbl_FinancialYear" runat ="server"></asp:Label> </td>
                        </tr>
                        <tr>
                            <td width="50%" align ="right">Total Weightage : </td>
                            <td> <asp:Label ID ="lbl_waitage" runat ="server"></asp:Label> </td>
                        </tr>
                        <tr>
                            <td width="50%" align ="right">Total Gain : </td>
                            <td> <asp:Label ID ="lbl_gain" runat ="server"></asp:Label> </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:RadioButtonList ID="rdlRemarks" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="Very Bad">Very Bad</asp:ListItem>
                                    <asp:ListItem Value="Bad">Bad</asp:ListItem>
                                    <asp:ListItem Value="Good">Good</asp:ListItem>
                                    <asp:ListItem Value="Very Good">Very Good</asp:ListItem>
                                    <asp:ListItem Value="Excelent">Excelent</asp:ListItem>
                                    
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center" >
                                <br />
                                <asp:Button ID="btnsave" runat="server" CssClass="btn btn-info btn-lg" OnClick="btnsave_Click" Text="Finalize" />
                            <asp:Button ID="Button3" runat="server" onclick="Button3_Click" Text="Cancel" />
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
           
        <table class="table  table-form   Grid_1"  style="margin: 0 auto; background-color: #ffffff; width: 90%;margin-top:20px;">
            <thead>
                <tr>
                    <th style="width: 20%;">Rating Factors</th>
                    <th style="width: 10%;">Factor Weightage</th>
                    <th style="width: 10%;">Employee Score</th>
                    <th style="width: 10%;">Remarks</th>
                </tr>
            </thead>

            <tbody>
                <asp:Repeater ID="repeaterEvaluationOuter" runat="server" OnItemDataBound="repeaterEvaluationOuter_ItemDataBound">
                    <ItemTemplate>
                        <tr>
                            <td colspan="5" style="width: 50%; text-align: left; line-height: 27px; border-bottom: 1px solid black; border-top: 1px solid black; color: maroon">
                                <asp:Label ID="name" BorderStyle="Solid" Font-Bold="true" Text='<%# Bind("Name") %>' runat="server" Font-Size="Large"/>
                                <asp:Label ID="lblFinancialYear" BorderStyle="Solid" Font-Bold="true" Text='<%# " ("+ Eval("Financial_Year") + ")" %>' runat="server" Font-Size="Medium"/>
                                <asp:HiddenField ID="EmpAppraisalID" Value='<%# Eval("EmployeeAppraisalID") %>' runat="server" />
                                <asp:HiddenField ID="hfFactorId" Value='<%# Eval("FactorId") %>' runat="server" />
                                <asp:HiddenField ID="HfFinncialYearId" Value='<%# Bind("Financial_Year_Id") %>' runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="inner-table">
                                <asp:Repeater ID="repeaterEvaluationInner" runat="server">
                                    <ItemTemplate>
                                        <table class="tblInner" cellspacing="0" border="2" width="100%" style="border-bottom: 1px solid black">
                                            <tr>
                                                <td style="width: 30%; text-align: left;">
                                                    <asp:Label ID="Label1" Text='<%# Bind("Detail") %>' runat="server" Font-Size="Medium"/>
                                                    <asp:HiddenField ID="hfFactorId" runat="server" Value='<%# Eval("FactorId") %>' />
                                                    <asp:HiddenField ID="hfFactorDetailId" runat="server" Value='<%# Eval("FactorDetailId") %>' />
                                                    <asp:HiddenField ID="hfEvaluationIdMain" runat="server" Value='<%# Eval("EmployeeAppraisalMain") %>' />
                                                    <asp:HiddenField ID="hfEvaluationIdSub" runat="server" Value='<%# Eval("EmployeeAppraisalSubID") %>' />

                                                </td>
                                                <td style="width: 10%; text-align: center;">
                                                    <asp:Label Text='<%# Bind("FactorWeightage") %>' runat="server" ID="lblWeightage" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td style="width: 10%; text-align: center;">
                                                    <asp:TextBox CssClass="form-control" ID="txtboxGetMarks" Text='<%# Bind("EmployeeScore") %>' TextMode="Number" min="0" runat="server" Font-Size="Medium"></asp:TextBox>
                                                </td>
                                                <td style="width: 10%; text-align: center;">
                                                    <asp:TextBox CssClass="form-control" ID="txtboxRemarks" Text='<%# Bind("Remarks") %>' runat="server" Font-Size="Medium"></asp:TextBox>
                                                </td>

                                            </tr>
                                        </table>
                                    </ItemTemplate>

                                </asp:Repeater>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

    </div>
</asp:Content>

