<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_Finance, App_Web_0myvw0cp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
        <h2><span>Receiveable( <span class="total_receiveable color_b" title="Total Receivables" style="margin-left:0px;"></span> )</span></h2>
            <div class="data_scroll">
    <asp:GridView ID="GridviewReceiveable" runat="server" ShowHeader="false" SkinId="grid_dash" 
                    AutoGenerateColumns="False" Style="margin-left:8px;"
                    DataSourceID="SqlDataSourceRecievables" Width="97%" ShowFooter="True" 
                    onprerender="GridviewReceiveable_PreRender">
                    <Columns>
                        <asp:TemplateField HeaderText="Party Name" ShowHeader="False" SortExpression="E_Name">
                            <FooterTemplate>
                               <strong> Total</strong>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Select"
                                    Text='<%# Eval("E_Name") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Recievable" SortExpression="Recievable">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Recievable") %>'></asp:Label>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lbl_Total_Reciveables" CssClass="boldt" runat="server" Text="0"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_totalRec"   runat="server" Text='<%# Bind("Recievable") %>'></asp:Label>
                            </ItemTemplate>
                           <itemstyle Width="150px" HorizontalAlign="Right" CssClass="txtright" ></itemstyle>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Party_ID" HeaderText="Party_ID" SortExpression="Party_ID" />
                    </Columns>
                </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceRecievables" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
            SelectCommand="PartyReceiveable_Dashboad" 
        ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>" 
        SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:SessionParameter Name="SubDept_Id" SessionField="subdeptid" Type="Int32" />
                <asp:SessionParameter Name="Emp_id" SessionField="emp_id" Type="Int32" />
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        
                        </div>
     </div> 
    <br>
    </td>
            <td width="50%" valign="top">
  <div class="bxmain3 margin_right10 inner_content" style="height:255px;">
           <h2><span  >Payable ( <span class="total_payable color_b" title="Total Payables" style="margin-left:0px;"></span> )</span></h2>      
          <div class="data_scroll" >
    <asp:GridView ID="GridviewPayable" runat="server" ShowHeader="False" 
            AutoGenerateColumns="False" SkinId="grid_dash" 
            DataSourceID="SqlDataSourcePayables" Width="97%" ShowFooter="True" 
            Style="margin-left:8px;" EnableModelValidation="True" 
                  onprerender="GridviewPayable_PreRender">
                    <Columns>
                        <asp:TemplateField HeaderText="Party Name" ShowHeader="False" SortExpression="E_Name">
                           <FooterTemplate>
                             <strong>   Total</strong>
                            </FooterTemplate> 
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="false" CommandName="Select"
                                    Text='<%# Eval("E_Name") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Payable" SortExpression="Payable">
                            <EditItemTemplate>
                                <asp:Label ID="Label2" runat="server"  Text='<%# Eval("Payable") %>'></asp:Label>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lbl_totalPay" runat="server" CssClass="boldt" Text="0"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_Payable" runat="server"  Text='<%# Bind("Payable") %>'></asp:Label>
                            </ItemTemplate>
                              <itemstyle Width="150px" HorizontalAlign="Right" CssClass="txtright" ></itemstyle>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Party_ID" HeaderText="Party_ID" SortExpression="Party_ID" />
                    </Columns>
                </asp:GridView>
                
          <asp:SqlDataSource ID="SqlDataSourcePayables" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>"
                    SelectCommand="PartyPayable_by_Subdept" 
            SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
              <SelectParameters>
                  <asp:SessionParameter Name="SubDept_Id" SessionField="subdeptid" Type="Int32" />
              </SelectParameters>
        </asp:SqlDataSource>
                    
            </div>

    </div>
    <br>
            </td>
        </tr>
        <tr>
    <td width="50%" >

    <div class="bxmain2 margin_right10 inner_content" style="height:250px; ">
        <h2><span>Cash & Cash Equivalents</span></h2>
            <div class="data_scroll">
         <asp:GridView ID="GridView3" runat="server" ShowHeader="False"  
          AutoGenerateColumns="False"  SkinId="grid_dash" Width="97%" Style="margin-left:8px;"
          DataSourceID="SqlDataSource4" EnableModelValidation="True">
             <Columns>
              
                 <asp:TemplateField>
                     <ItemTemplate>
                         <asp:Label ID="Label_Ename" runat="server" Text='<%# Eval("E_Name") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField>
                     <ItemTemplate>
                         <asp:Label ID="Label_BankAmount" runat="server" 
                             Text='<%# Eval("Recievable") %>'></asp:Label>
                     </ItemTemplate>  <itemstyle Width="150px" HorizontalAlign="Right" CssClass="txtright" ></itemstyle>
                 </asp:TemplateField>
                     
                     
             </Columns><RowStyle CssClass="GridItem" />
 
<PagerStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" /> 
      </asp:GridView>       
           <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
               ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
               SelectCommand="Dashboard_HeadSummary" 
          SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
               <SelectParameters>
                   <asp:Parameter DefaultValue="Bank" Name="Head_Cat" Type="String" />
                   <asp:SessionParameter DefaultValue="" Name="SubDept_ID" 
                       SessionField="subdeptid" Type="Int32" />
               </SelectParameters>
           </asp:SqlDataSource>
                </div>

    </div>
            </td>
            <td width="50%" valign="top">
            <div class="bxmain3 margin_right10 inner_content" style="height:255px;">
           <h2><span>Expanses</span></h2>      
          <div class="data_scroll" >
           <asp:GridView ID="GridView2" runat="server" ShowHeader="False" 
                AutoGenerateColumns="False"  SkinId="grid_dash" Width="97%" Style="margin-left:8px;"
          DataSourceID="SDs_Expanse" EnableModelValidation="True">
               <Columns>
                  
                   <asp:TemplateField>
                       <ItemTemplate>
                           <asp:Label ID="Label_Head" runat="server" Text='<%# Eval("E_Name") %>'></asp:Label>
                       </ItemTemplate>
                   </asp:TemplateField>
                   <asp:TemplateField>
                       <ItemTemplate>
                           <asp:Label ID="Label_Amount" runat="server" Text='<%# Eval("Recievable") %>'></asp:Label>
                       </ItemTemplate>  <itemstyle Width="150px" HorizontalAlign="Right" CssClass="txtright" ></itemstyle>
                   </asp:TemplateField>
               </Columns><RowStyle CssClass="GridItem" />
 
<PagerStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" /> 
      </asp:GridView> 
      
          <asp:SqlDataSource ID="SDs_Expanse" runat="server" 
               ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
               SelectCommand="Dashboard_HeadSummary" 
          SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
               <SelectParameters>
                   <asp:Parameter DefaultValue="Expanse" Name="Head_Cat" Type="String" />
                   <asp:SessionParameter DefaultValue="" Name="SubDept_ID" 
                       SessionField="sepdeptid" Type="Int32" />
               </SelectParameters>
           </asp:SqlDataSource>
            </div>
            </div>
            </td>
        </tr>
    </table>

</asp:Content>

