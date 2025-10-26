<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="DB_Patient_Executive.aspx.vb" Inherits="DashBoards_DB_Patient_Executive" %>


<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
    
    .bxmain2 {
    background: url("../images_mega/bxbg4.png") repeat-y scroll right bottom #E7E5F4;
    border: 1px solid #D2BFEA;
    border-radius: 4px;
    margin: 0;
    padding-bottom: 15px;
    padding-top: 10px;
    height:530px;
    
}

 .margin_right10 { margin-right:10px; }
 .txtright span {text-align:right; display:block; margin-right:5px;     }
 .boldt { font-weight:bold; text-align:right; display:block; margin-right:5px; }
 .sel_pos { position:relative; margin-top:-36px; float:right; margin-right:10px; }
 .splt {padding-left:5px; padding-right:5px; }
 
 
 .bxmain { min-height:175px;  }
 .bxmain2 { min-height:175px;}
 .bxmain3 { min-height:175px;}
 .bxmain4 { min-height:175px;} 
 
 .data_scroll {
    height: 505px;
    overflow-x: hidden;
    overflow-y: auto;
    width: 99%;
    padding-left:5px;
}

  
 .color_b { color:#000000;}
 
    #forms_items { margin:15px; }
        .ssearch_panell { margin-bottom:20px; overflow:hidden; border: #d6d6d6 solid 1px; background: #f7f7f7; padding:10px; webkit-border-radius: 4px; azimuth -moz-border-radius: 4px;}
        .ssearch_div1 { margin-right:20px; float:left}
        .ssearch_div2 {float:left; margin-right:15px; }
        .ssreach_label { margin-right:15px; width:70px; line-height:22px; text-align:right; float:left; display:block; font-weight:bold; }
        .ssearch_panell input[type="text"], .ssearch_panell select { border: 1px solid #ccc; background:#ffffff; }
        .ssearch_panell input[type="submit"] {background: url(../images_hacims/img_btn_bg.png) left top repeat-x;
 
</style>
<script type="text/javascript">

    $(document).ready(function (e) {

        $.fn.commas = function () {
            return this.each(function () {
                $(this).text($(this).text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
            })
        }


        $(".total_payable").html($("#ctl00_ContentPlaceHolder1_GridviewPayable .boldt").text());
        $(".total_receiveable").html($("#ctl00_ContentPlaceHolder1_GridviewReceiveable .boldt").text());

        $("span").commas();

    });

</script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
            <div class="ssearch_panell">
                <div class="ssearch_div1">
                    <label class="ssreach_label">
                    From Date:</label>

                    <igsch:webdatechooser id="WebDateChooser_date_From" runat="server" width="180px">
                        <calendarlayout culture="English (United Kingdom)">
                        </calendarlayout>
                   </igsch:webdatechooser>
                </div>
                <div class="ssearch_div2">
                    <label class="ssreach_label">
                    To Date:</label>
                    <igsch:webdatechooser id="WebDateChooser_Date_To" runat="server" width="180px">
                    <calendarlayout culture="English (United Kingdom)">
                    </calendarlayout>
                  </igsch:webdatechooser>
                </div>
                <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Size="Medium" 
                    OnClick="Button1_Click" Text="Search" Width="90px" />
            </div>
        </div>
<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
  <tr>
    <td valign="top">

    <div class="bxmain2 margin_right10 inner_content" >
        <h2><span>Department Wise Patients Summary</span></h2>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        
        <p>&nbsp;</p>
        <p>&nbsp;</p>
            <div class="data_scroll">     
                <asp:GridView ID="gvPatientExecutiveSummary" AutoGenerateColumns="False" 
                    Width="100%" runat="server" EmptyDataText="No Record(s) Found." 
                    ShowFooter="True">
                <Columns>
                    <asp:TemplateField HeaderText="Department">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Dept_Name") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="Label7" runat="server" Font-Bold="True" 
                                Font-Names="Times New Roman" Font-Size="Medium" Text="Total :"></asp:Label>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbl_department" runat="server" Text='<%# Bind("Dept_Name") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="AmountAlign" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="In-Door Patients">
                        <ItemTemplate>
                            <asp:Label ID="lbl_In_Pa" runat="server" 
                                Text='<%# Bind("Indoor_Patient_Count") %>'></asp:Label>
                        </ItemTemplate> 
                        <FooterTemplate>
                            <asp:Label ID="lbl_T_I_Pa" runat="server" >
                               </asp:Label>
                        </FooterTemplate>
                       
                        <ItemStyle CssClass="AmountAlign" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Out-Door Patients">
                       <ItemTemplate>
                            <asp:Label ID="lbl_Out_Pa" runat="server" 
                                Text='<%# Bind("Outdoor_Patient_Count") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                           <asp:Label ID="lbl_T_Out_Pa" runat="server" ></asp:Label>
                        </FooterTemplate>
                        
                        <ItemStyle CssClass="AmountAlign" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Previous Admission">
                        
                        
                        
                        <ItemTemplate>
                            <asp:Label ID="lbl_Prv_Ad" runat="server" 
                                Text='<%# Bind("Previous_Admissions") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lbl_T_Prv_Ad" runat="server" ></asp:Label>
                        </FooterTemplate>
                        <ItemStyle CssClass="AmountAlign" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="New Admission">
                  
                        
                  
                        <ItemTemplate>
                           <asp:label ID="lbl_Today_Ad" runat="server" 
                                Text='<%# Bind("Today_Admissions") %>'></asp:label>
                        </ItemTemplate>
                            <FooterTemplate>
                            <asp:label ID="lbl_T_Today_Ad" runat="server"></asp:label>
                        </FooterTemplate>
                        <ItemStyle CssClass="AmountAlign" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Discharge">
                       
                        <ItemTemplate>
                            <asp:Label ID="lbl_Discharge" runat="server" Text='<%# Bind("Discharge") %>'></asp:Label>
                        </ItemTemplate>
                           <FooterTemplate>
                            <asp:label ID="lbl_T_Discharge" runat="server"></asp:label>
                        </FooterTemplate>
                        <ItemStyle CssClass="AmountAlign" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Present" HeaderText="Present"  
                        ItemStyle-CssClass="AmountAlign" Visible="False">
<ItemStyle CssClass="AmountAlign"></ItemStyle>
                    </asp:BoundField>
                </Columns>
    
                    <EmptyDataRowStyle CssClass="errmsg" />
    
                    <FooterStyle BackColor="#FFFFCC" CssClass="AmountAlign" Font-Bold="True" 
                        ForeColor="#333399" />
    
                <PagerStyle CssClass="GridPager" />
                </asp:GridView>
            </div>
     </div> 
   
    </td>
  </tr>
</table>


    

</asp:Content>

