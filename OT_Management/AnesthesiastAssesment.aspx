<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AnesthesiastAssesment.aspx.cs" Inherits="OT_Management_AnesthesiastAssesment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .tblInner td {
            border-bottom: solid 1px #ccc;
            line-height: 27px;
        }

        .inner-table-even {
            font-size: 13px;
            background-color:aliceblue;
        }
         .inner-table-even span {
            font-size: 13px;
        }
          .inner-table-odd {
            font-size: 13px;
            background-color:lightblue
        }
         .inner-table-odd span {
            font-size: 13px;
        }
    </style>
    
    <script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>

 <link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
 
 
 <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

      <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td  valign="top" class="leftnav"> <asp:Label ID="LabelSideMenu" runat="server"></asp:Label></td>
      <td style="width:auto;" valign="top">
    <div style="text-align: center">
        <h2 class="title" id="heading" runat="server">Patient Assesment (Anesthetist)</h2>
    </div>

<%--          <div>
              <asp:Label ID="lblMsg" runat="server" Text="No Operation recomended or not admitted yet!"></asp:Label>
          </div>--%>
    <table class="Grid_1">
      

        <tbody>
            <asp:Repeater ID="repeaterOTQuestionsOuter" runat="server" OnItemDataBound="repeaterOTQuestionsOuter_ItemDataBound">
                <ItemTemplate>
                    <tr>
                        <td colspan="3" style="width: 40%; text-align: left; line-height: 27px; background-color: antiquewhite;">
                            <asp:Label ID="name" BorderStyle="Solid" Font-Bold="true" Text='<%# Bind("Name") %>' runat="server" />
                            <asp:HiddenField ID="hfName" runat="server" Value='<%# Eval("Name") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" class="<%# Container.ItemIndex % 2 == 0 ? "inner-table-even" : "inner-table-odd" %>">
                            <asp:Repeater ID="repeaterOTQuestionsInner" runat="server" OnItemDataBound="repeaterOTQuestionsInner_ItemDataBound">
                                <ItemTemplate>
                                    <table class="tblInner" cellspacing="0" border="2" width="100%">
                                        <tr>
                                            <td style="width: 40%; text-align: left">
                                                <asp:Label ID="Label1" Text='<%# Bind("Details") %>' runat="server" />
                                                <asp:HiddenField ID="hfHeadingId" runat="server" Value='<%# Eval("HeadingId") %>' />
                                                <asp:HiddenField ID="hfQuestionId" runat="server" Value='<%# Eval("QuestionId") %>' />
                                                <asp:HiddenField ID="hfAssesmentIdSub" runat="server" Value='<%# Eval("AssesmentIdSub") %>' />
                                            </td>
                                            <td style="width: 10%; text-align: center;">
                                                <asp:RadioButton ID="rdoYes"  GroupName="Question" runat="server" />
                                                <label for="rdoYes">Yes</label>
                                                <asp:RadioButton ID="rdoNo" GroupName="Question" runat="server" />
                                                <label for="rdoNo">No</label>
                                            </td>
                                            
                                            <td style="width: 50%; text-align: center;">
                                                <asp:TextBox ID="txtRemarks" runat="server" autoComplete="Off" Style="width: 98%"></asp:TextBox>
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

          <div style="padding-top:10px;">
              <table style="width:100%;">
                  <tr>
                      <td align="center" style="width:100px;">Remarks:</td>
                      <td>
                          <asp:TextBox ID="txtDrRemarks" runat="server" style="height:100px;width:100%;"></asp:TextBox>
                      </td>
                  </tr>
              </table>
              
              

              
          </div>
      
        <div style="width: 100%; text-align:center;padding-top:10px;">
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />         
            <asp:Label ID="lblmsg" runat="server" Text="" Font-Size="Large" Visible="false"></asp:Label>
        </div>

        <asp:HiddenField ID="hdnAssesmentId" runat="server" Value="0" />
        <asp:HiddenField ID="hdnOTOrderMainId" runat="server" Value="0" />
        <br />
  </td>
    </tr>
  </table>
  
  
<asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>

     <script type="text/javascript">
var cookies = Spry.Utils.Cookie("read","tabbedpanels_pr_complaints");
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
Spry.Utils.addUnLoadListener(function(){
    // save the current value
    Spry.Utils.Cookie('create','tabbedpanels_pr_complaints',TabbedPanels1.getCurrentTabIndex());
});
</script>
</asp:Content>

