<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AddemployeeAppraisal.aspx.cs" Inherits="HR_AddemployeeAppraisal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--<meta http-equiv="Refresh" content=";url=EmployeeAppraisalRequest.aspx" />--%>
    <script type="text/javascript" src="jquery-1.12.3.js"></script>
   <script type="text/javascript">
       $(document).ready(function () {

           $('[id$="lblWeightage"]').keyup(function () {
               var tr = $(this).closest('tr');
               var labelToalMarks = tr.find('[id$="name"]');
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
        .auto-style2 {
            width: 24%;
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
                    <asp:DropDownList ID="ddlFinancialYear"  Enabled="false" runat="server" AutoPostBack="true" ></asp:DropDownList>
                </td>
                <td width="20%" align="right">Department :  </td>
                <td class="radio-Type" align="left">
                    <asp:DropDownList ID="DropDownListSubDepartment" Enabled="false" AutoPostBack="true" OnSelectedIndexChanged="DropDownListSubDepartment_SelectedIndexChanged" runat="server"></asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td width="20%" align="right">Employee :  </td>
                <td class="radio-Type" align="left">
                    <asp:DropDownList ID="ddlEmployee" Enabled="false" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                </td>
           
                <td width="20%" align="right">Designation :  </td>
                <td class="radio-Type" align="left">
                    <asp:DropDownList Enabled="false" ID="ddlDesignation" runat="server"></asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td width="20%" align="right">Appraisal Heading :  </td>
                <td>
                    <asp:DropDownList ID="ddlHeading" runat="server" Enabled="false" AutoPostBack="true" OnSelectedIndexChanged="ddlHeading_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                  <td width="20%" align="right"></td>
                <td 
                </td>
            </tr>
              <tr>
                <td width="20%" align="right">Title:  </td>
                <td>
                    <asp:DropDownList ID="ddltitle" runat="server" Enabled="false" AutoPostBack="true" >
                    </asp:DropDownList>
                </td>
                  <td width="20%" align="right"></td>
                <td 
                </td>
            </tr>
           
            <tr>
                <td align="center" colspan="4" >
                    <asp:Button ID="btnView" runat="server" CssClass="btn btn-info btn-lg" OnClick="btnView_Click" Text="Save" />
                    <asp:Label ID="lblmsg" runat="server" Visible="false" Font-Bold="true" Font-Size="Large" ForeColor="Green"></asp:Label>
                    <asp:Button ID="btnforward" runat="server" CssClass="btn btn-info btn-lg" Enabled="false"  Text="Forward" OnClick="btnforward_Click" />
                    <asp:Label ID="Lblforward" runat="server" Visible="false" Font-Bold="true" Font-Size="Large" ForeColor="Green"></asp:Label>
                     <asp:Label ID="Label1" runat="server" Visible="false" Font-Bold="true" Font-Size="Large" ForeColor="Green"></asp:Label>
                </td>
            
                <td align="left" colspan="4" >
                    &nbsp;</td>
            </tr>
        </table>
            <table class="table  table-form   Grid_1"  style="margin: 0 auto; background-color: #ffffff; width: 90%;margin-top:20px;">
        <asp:GridView ID="gridFatorsDetails" runat="server" AutoGenerateColumns="false" Width="100%" OnRowDataBound="gridFatorsDetails_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Details" HeaderStyle-HorizontalAlign="Center" >
                                 <ItemTemplate>
                                      <asp:HiddenField runat="server" ID="hfEmployeeAppraisalID" Value='<%# Bind("EmployeeAppraisalID") %>' /> 
                                     <asp:HiddenField runat="server" ID="hfdid" Value='<%# Bind("EmployeeAppraisalSubID") %>' />  
                                      <asp:HiddenField runat="server" ID="hffactorid" Value='<%# Bind("FactorId") %>' /> 
                                    <asp:Label runat="server" ID="lbldetails" Text='<%# Bind("Detail") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Weightage"  HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="name" Text='<%# Bind("marks") %>' runat="server" />
                                     <asp:HiddenField runat="server" ID="lblmarks" Value='<%# Bind("marks") %>' />
                                     <asp:HiddenField runat="server" ID="hffactordetailedid" Value='<%# Bind("FactorDetailId") %>' /> 
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Marks"  HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                           <asp:TextBox ID="lblWeightage" runat="server" Text='<%# Bind("Wheightage") %>'> </asp:TextBox>
                                     <asp:HiddenField runat="server" ID="hfWheightage" Value='<%# Bind("Wheightage") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Bind("Remarks") %>'> </asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--  <asp:TemplateField HeaderText="Select">
                                  <HeaderTemplate>
                                    <asp:CheckBox ID="chkall" runat="server" OnCheckedChanged="ckall_CheckedChanged" AutoPostBack="true"> </asp:CheckBox>
                                  </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="lblEMployPID" runat="server" ToolTip='<%# Bind("EmployeeAppraisalID") %>'> </asp:CheckBox>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                        </Columns>



                    </asp:GridView>     
                   
            </table>

    </div>
</asp:Content>

