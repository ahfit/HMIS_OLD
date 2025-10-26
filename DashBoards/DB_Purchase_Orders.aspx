<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_Purchase_Orders, App_Web_csihqmfb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<style type="text/css">
    
    .bxmain2 {
    background: url("../images_mega/bxbg4.png") repeat-y scroll right bottom #E7E5F4;
    border: 1px solid #D2BFEA;
    border-radius: 4px;
    margin: 0;
    padding-bottom: 15px;
    padding-top: 10px;
    
    
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
    height: 225px;
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <table width="100%" border="0" cellspacing="0" cellpadding="0"  >
  <tr>
    <td width="50%" valign="top">

    <div class="bxmain2 margin_right10 inner_content" style="height:250px;">
        <h2><span>Purchase Orders</span></h2>
            <div class="data_scroll">     
                <asp:GridView ID="gvPOReceived" AutoGenerateColumns="false" runat="server" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="PO_ID" HeaderText="PO #" ItemStyle-CssClass="AmountAlign" />
                        <asp:BoundField DataField="Company_Name" HeaderText="Company Name" ItemStyle-CssClass="AmountAlign" />
                        <asp:BoundField DataField="Received_Qty_Perc" HeaderText="RCVD. Qty. %" ItemStyle-CssClass="AmountAlign" />
                        <asp:BoundField DataField="Received_Cost_Perc" HeaderText="RCVD. Cost %" ItemStyle-CssClass="AmountAlign" />
                    </Columns>
                </asp:GridView>

            
            </div>
     </div> 
    
 
   
    <br />
    </td>
       
    
    <td width="50%" valign="top">
    
       <div class="bxmain2 margin_right10 inner_content" style="height:250px;">
           <h2><span  >Pending Purchase Orders</span></h2> 
                <div class="data_scroll" style="height:225px;">
                <asp:GridView ID="gvPOPendingApproval" AutoGenerateColumns="false" runat="server" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="PO_ID" HeaderText="PO #" HeaderStyle-Width="30%" ItemStyle-CssClass="AmountAlign" />
                        <asp:BoundField DataField="Company_Name" HeaderText="Company Name" ItemStyle-CssClass="AmountAlign" />
                        <asp:BoundField DataField="Received_Qty_Perc" HeaderText="RCVD. Qty. %" ItemStyle-CssClass="AmountAlign" />
                        <asp:BoundField DataField="Received_Cost_Perc" HeaderText="RCVD. Cost %" ItemStyle-CssClass="AmountAlign" />
                    </Columns>
                </asp:GridView>
                </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
