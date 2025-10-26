<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_Procurement, App_Web_0myvw0cp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
  <tr>
    <td width="50%" valign="top">

    <div class="bxmain2 margin_right10 inner_content" style="height:250px; ">
        <h2><span>
            Top 10 Item Suppliers Quantity Wise
        </span></h2>
            <div class="data_scroll">
                <asp:GridView ID="gvTop10ItemSupplierQtyWise" AutoGenerateColumns="false" runat="server" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="Party_Name" HeaderText="Party Name" />
                        <asp:BoundField DataField="Total_Qty" HeaderText="Total Quantity" ItemStyle-CssClass="AmountAlign" />
                        <asp:BoundField DataField="Total_Amount" HeaderText="Total Amount" ItemStyle-CssClass="AmountAlign" />
                    </Columns>
                </asp:GridView>
                        </div>
     </div> 
    <br>
    </td>
            <td width="50%" valign="top">
  <div class="bxmain3 margin_right10 inner_content" style="height:255px;">
           <h2><span   >Top 10 Item Suppliers Amount Wise</span></h2>      
          <div class="data_scroll" >
                <asp:GridView ID="gvTop10ItemSupplierAmtWise" AutoGenerateColumns="false" runat="server" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="Party_Name" HeaderText="Party Name" />
                        <asp:BoundField DataField="Total_Qty" HeaderText="Total Quantity" ItemStyle-CssClass="AmountAlign" />
                        <asp:BoundField DataField="Total_Amount" HeaderText="Total Amount" ItemStyle-CssClass="AmountAlign" />
                    </Columns>
                </asp:GridView>
            </div>

    </div>
    <br>
            </td>
        </tr>
        <tr>
    <td width="50%" >

    <div class="bxmain2 margin_right10 inner_content" style="height:250px; ">
        <h2><span>
            Top 10 Item PO Quantity Wise
        </span></h2>
            <div class="data_scroll">
                <asp:GridView ID="gvTop10POQtyWise" AutoGenerateColumns="false" runat="server" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="PO_ID" HeaderText="PO ID" />
                        <asp:BoundField DataField="Party_Name" HeaderText="Party Name" />
                        <asp:BoundField DataField="PO_Date" HeaderText="PO Date" />
                        <asp:BoundField DataField="Total_Qty" HeaderText="Total Qty" ItemStyle-CssClass="AmountAlign" />
                        <asp:BoundField DataField="Total_Amount" HeaderText="Total Amount"  ItemStyle-CssClass="AmountAlign" />
                    </Columns>
                </asp:GridView>
                </div>

    </div>
            </td>
            <td width="50%" valign="top">
            <div class="bxmain3 margin_right10 inner_content" style="height:255px;">
           <h2><span   >Top 10 Item PO Amount Wise</span></h2>      
          <div class="data_scroll" >
                <asp:GridView ID="gvTop10POAmtWise" AutoGenerateColumns="false" runat="server" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="PO_ID" HeaderText="PO ID" />
                        <asp:BoundField DataField="Party_Name" HeaderText="Party Name" />
                        <asp:BoundField DataField="PO_Date" HeaderText="PO Date" />
                        <asp:BoundField DataField="Total_Qty" HeaderText="Total Qty" ItemStyle-CssClass="AmountAlign" />
                        <asp:BoundField DataField="Total_Amount" HeaderText="Total Amount"  ItemStyle-CssClass="AmountAlign" />
                    </Columns>
                </asp:GridView>
            </div>
            </div>
            </td>
        </tr>
    </table>

</asp:Content>

