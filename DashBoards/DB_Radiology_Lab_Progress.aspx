<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_Radiology_Lab_Progress, App_Web_csihqmfb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
    
    .bxmain2 {
    background: url("../images_mega/bxbg4.png") repeat-y scroll right bottom #E7E5F4;
    border: 1px solid #D2BFEA;
    border-radius: 4px;
    margin: 0;
    padding-bottom: 15px;
    padding-top: 10px;
    heigth: 510px;
    
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
    height: 490px;
    overflow-x: hidden;
    overflow-y: auto;
    width: 99%;
    padding-left:5px;
    
}

  
 .color_b { color:#000000;}
 
    .style1
    {
        font-size: 11px;
    }
 
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

<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
  <tr>
    <td width="50%" valign="top">

    <div class="bxmain2 margin_right10 inner_content" >
        <h2 style="padding-bottom:10px;">
            <span>Lab Progress</span>
        </h2>
            <div class="data_scroll" >  
            
               
                <asp:GridView ID="gvGroupWiseSummary" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource1">
                    <Columns>
                        <asp:BoundField DataField="TGName" HeaderText="Group Name" HeaderStyle-Width="40%" ItemStyle-CssClass="AmountAlign"
                            SortExpression="TGName" />
                        <asp:BoundField DataField="OrderPaid" HeaderText="Sample Collection" ReadOnly="True" HeaderStyle-Width="20%" ItemStyle-CssClass="AmountAlign"
                            SortExpression="OrderPaid" />
                        <asp:BoundField DataField="Remarks" HeaderText="Result Entry" ReadOnly="True" HeaderStyle-Width="20%" ItemStyle-CssClass="AmountAlign"
                            SortExpression="Remarks" />
                        <asp:BoundField DataField="Reports" HeaderText="Reports" ReadOnly="True" HeaderStyle-Width="20%" ItemStyle-CssClass="AmountAlign"
                            SortExpression="Reports" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:RadiologyConnectionString %>" 
                    SelectCommand="[usp_GetRadiologyGroupWiseSummary]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="Dept_Id" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            
               
            </div>
            </div>
             <br />
         
    </td>
       
    
    <td width="50%" valign="top">
    
       <div class="bxmain3 margin_right10 inner_content" style="height:525px;">
           <h2 style="padding-bottom:10px;"><span  > Lab Progress</span></h2> 
                <div class="data_scroll" style="height:490px;  padding-top:10px; text-align:center;">

                    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" IsSoftShadows="true"
                        Height="480px" Width="485px" >
                        <Series>
                            <asp:Series ChartType="Pie" Legend="Legend1" Name="Series1"
                                XValueMember="TGName" YValueMembers="OrderPaid" 
                                Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                IsXValueIndexed="True" 
                                CustomProperties="MinimumRelativePieSize=40, PieLabelStyle=Outside">
                            </asp:Series>
                        </Series>
                        
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" >
                            
                                
                                
                            <Area3DStyle Enable3D="True" Inclination="45" Rotation="90" LightStyle="Realistic" />

                            </asp:ChartArea>
                            
                            
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" AutoFitMinFontSize="12" Alignment="Center" >
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>

                </div>
            </div>

           
                </td>

        </tr>
    </table>
</asp:Content>

