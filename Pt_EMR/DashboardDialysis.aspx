<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DashboardDialysis.aspx.vb"
    MasterPageFile="~/hacims_masterpage_admin.master" Inherits="DashboardDialysis" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="tdc_resources/js/jquery.cookie.js"></script>
    <style type="text/css">
        a > span {
            padding-right: 10px;
        }

        p > a {
            font-size: 15px;
            font-weight: bold;
        }

        .cr_reading {
            border-bottom: #CCC dotted 1px;
            width: 100%;
            padding-bottom: 2px;
            padding-top: 4px;
        }

            .cr_reading ul {
                width: 100%;
            }

            .cr_reading li {
                display: block;
                height: auto;
                line-height: 17px;
                background: url(images_hacims/img_bullet-2.png) 0 6px no-repeat;
                padding-left: 10px;
                width: 100%;
            }

        .bno {
            color: #C00;
            border-left: #bfbfbf solid 1px;
            margin-left: 5px;
            padding-left: 5px;
        }

        .bnb {
            color: #333;
            border-left: #bfbfbf solid 1px;
            margin-left: 5px;
            padding-left: 5px;
        }

        .bnc {
            color: #0e5b87;
            margin-left: 2px;
            padding-left: 2px;
        }

        .cr_reading .detail {
            color: #999;
            background: none;
            padding-left: 0;
        }

        .bx_infos_patients {
            width: 94%;
        }

        .rd_tests {
        }

            .rd_tests ul {
            }

            .rd_tests li {
                display: block;
                line-height: 17px;
                background: url(images_hacims/img_bullet-2.png) 0 6px no-repeat;
                height: auto;
                width: 100%;
                margin-left: 0px;
                margin-top: 3px;
                border: #d6d6d6 solid 1px;
                background: #fff;
                -moz-border-radius: 4px;
            }

        .tcount {
            color: #015aae;
            padding-left: 4px;
        }

        .information_block {
            height: auto;
            width: 94%;
            border: #e0e0e0 solid 1px;
            background: #fff url(../images_hacims/bxinfobg.png) bottom left repeat-y;
            -webkit-border-radius: 8px;
            -moz-border-radius: 8px;
            border-radius: 8px;
            padding-left: 5px;
            padding-right: 5px;
        }

        .title_a {
            width: auto;
            height: auto;
            font-weight: bold;
            font-size: 11px;
            border-left: #e0e0e0 solid 1px;
            border-right: #e0e0e0 solid 1px;
            margin-top: -7px;
            position: absolute;
            background-color: #FFF;
            padding-left: 6px;
            padding-right: 6px;
            margin-left: 10px;
        }

        .slc_link li a {
            color: #e93349;
            font-size: 12px;
        }

        A.ic_addmsg {
            background: url(images_hacims/ic_adm.png) 0 5px no-repeat;
            margin-left: 10px;
            padding-left: 20px;
            font-size: 11px;
        }

            A.ic_addmsg:hover {
                color: #003399;
            }

        A.ic_addmet {
            background: url(images_hacims/ic_admet.png) 0 3px no-repeat;
            margin-left: 10px;
            padding-left: 20px;
            font-size: 11px;
        }

            A.ic_addmet:hover {
                color: #003399;
            }

        .lightbox {
            height: auto;
        }

        .bx_rad {
            color: white;
            height: auto;
            width: 95%;
            display: inline-block;
            margin-left: 0px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            behavior: url(PIEq.htc);
            float: left;
            clear: right;
            margin-bottom: 5px;
            -moz-box-shadow: 1px 1px 1px #bcbcbc;
            box-shadow: 1px 1px 1px #bcbcbc;
            background-color: #5bc0de;
            padding-top: 4px;
            padding-bottom: 4px;
            margin-left: 1em;
        }

        .links_bx {
            margin-top: -6px;
        }

        .tbl_form td {
            border: 0px;
            border-style: none;
            border-color: inherit;
            border-width: 0px;
            border-collapse: collapse;
            padding-left: 2px;
            padding-top: 2px;
            height: 18px;
            font-weight: bold;
            font-size: 12px;
            color: #fff;
        }

        .tbl_form tr {
            border: 0px;
            border-collapse: collapse;
            text-align: left;
            line-height: 20px;
        }

        .Grid_1 td {
            border-left: 1px solid #000000;
            border-right: 1px solid #060606;
            border-bottom: 1px solid #000000;
            border-collapse: collapse;
            padding: 3px;
            font-size: 12px;
            vertical-align: top;
            border-top-style: none;
            border-top-color: inherit;
            border-top-width: 0px;
            background: url(../images_hacims/img_oplistt.jpg);
        }

        .Grid_1 th {
            background: #ff9022a8;
        }
        .Grid_1 tr td {
            padding-left: 0;
                text-align: center;
        }
    </style>

    <script src="SpryAssets/mycollaps.js" type="text/javascript"></script>
    <link href="SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <script src="css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
    <link href="css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">

        function openpage() { window.location.href = "Pt_EMR/Investigation_Results.aspx"; }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="border: #F7F7F7 solid 1px; background: #e8e9df; border-radius: 4px; width: 100%; padding: 5px; margin-bottom: 10px; padding-left: 25px;">
        <asp:TextBox ID="txtMrNo" runat="server" Placeholder="MR #: TDC-######-##" Text=""></asp:TextBox>
        <asp:TextBox ID="txtMobileNo" runat="server" Placeholder="Phone #: 03#########" Text=""></asp:TextBox>
        <asp:TextBox ID="txtDate" TextMode="Date" runat="server" Style="color: black; width: 130px;"></asp:TextBox>
      
        <asp:DropDownList ID="ddlCheckUpStatus" runat="server" Visible="false">
            <asp:ListItem Text="All" Value="0"></asp:ListItem>
            <asp:ListItem Text="Assesment Pending" Value="1"></asp:ListItem>            
            <asp:ListItem Text="Assesment Complete" Value="4"></asp:ListItem>

        </asp:DropDownList>
        <asp:Button ID="btnSearch" runat="server" CssClass="btn1" Text="Search" OnClick="btnSearch_Click"></asp:Button>
    </div>

    <asp:GridView CssClass="Grid_1" ID="gvdLoadData" runat="server" AutoGenerateColumns="False" Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="S.NO">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                    <asp:HiddenField ID="HiddenField_EmpId" runat="server"
                        Value='' />
                    <asp:HiddenField ID="HiddenField_Status" runat="server"
                        Value='<%# Eval("CheckUpStatus")%>' />
                      <asp:HiddenField ID="hfRegno" runat="server" Value='<%# Eval("RegNo")%>' />
                    <asp:HiddenField ID="hfYearly_No" runat="server" Value='<%# Eval("Yearly_No")%>' />
                </ItemTemplate>

            </asp:TemplateField>
            
            <asp:BoundField HeaderText="Arival" DataField="Arival" />
            <asp:BoundField HeaderText="Waiting" DataField="Waiting" Visible="false" />
            <asp:BoundField HeaderText="Patient Name" DataField="patient" />
            <asp:BoundField HeaderText="Relation" DataField="Relation" />

            <asp:TemplateField HeaderText="Create">
                <ItemTemplate>
                    <asp:LinkButton Text="Create" ID="lnkbtnCreate" OnClick="lnkbtnCreate_Click" ToolTip='<%# Eval("RegNo") %>' CommandArgument='<%# Eval("RegNo") %>' runat="server"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Start Session">
                <ItemTemplate>
                    <asp:LinkButton Text="Start Session" ID="lnkbtnStartSession" OnClick="lnkbtnStartSession_Click" ToolTip='<%# Eval("Yearly_No")%>' CommandArgument='<%# Eval("Yearly_No") %>' runat="server"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField HeaderText="Relation Name" DataField="RelationName" />                        
            <asp:BoundField HeaderText="MR#" DataField="RegNo" />            
            <asp:BoundField HeaderText="Visit #" DataField="Yearly_No" />                              
            <asp:BoundField HeaderText="Cat" DataField="Patient_type" />
            <asp:BoundField HeaderText="Consultant" DataField="ConsultantName" />
            <%--<asp:BoundField HeaderText="Package" DataField="Package" />--%>
            <asp:TemplateField HeaderText="Seen" Visible="false">                
                <ItemTemplate>
                  

                    
                    <asp:LinkButton ID="lnkbtnCheckupStatus" OnClick="lnkbtnCheckupStatus_Click" ToolTip='<%# Eval("RegNo") %>' CommandArgument='<%# Eval("Yearly_No") %>' runat="server"></asp:LinkButton>
                    <asp:HiddenField ID="hf" runat="server" Value='<%# Eval("DischargeStatus") %>' />
                    <asp:Image ID="imgCheckComplete" runat="server" ImageUrl="~/images/CheckComplete.png" Visible="false" />
                    <asp:Image ID="imgLabConducted" runat="server" ImageUrl="~/images/LabConducted.png" Visible="false" />
                    <asp:Image ID="imgAssesment" runat="server" Width="40px" Height="40px" ImageUrl="~/images/Assesment.Jpg" Visible="false" />
                     <asp:Image ID="imgLabPending" runat="server" ImageUrl="~/images/LabPending.Jpg" Visible="false" />
                </ItemTemplate>

                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:ButtonField CommandName="Delete" Text="delete"></asp:ButtonField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
    <br />

    

    <asp:SqlDataSource ID="SqlDataSourceInsert_Message_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        InsertCommand="Insert_Emp_Message_Sub" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldMessage_ID" Name="Msg_Id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldMessageTo" DefaultValue="" Name="Emp_To"
                PropertyName="Value" Type="Int32" />
            <asp:Parameter DefaultValue="true" Name="Msg_Status" Type="Boolean" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceInsert_Message_Main" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        InsertCommand="Insert_Emp_Message_Main" InsertCommandType="StoredProcedure" SelectCommand="SELECT  TOP(20)   Msg_text, CONVERT(varchar,Msg_Date,107) AS Msg_Date,dbo.GET_Msg_ToRecipeantNames(emm.Msg_id) AS Recipents&#13;&#10;FROM         Emp_Messages_Main AS emm&#13;&#10;WHERE emm.By_Emp = @By_Emp&#13;&#10;ORDER BY emm.Msg_Date DESC ">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBoxMessageText" Name="Msg_text" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenFieldDate" Name="Msg_Date" PropertyName="Value"
                Type="DateTime" />
            <asp:SessionParameter Name="By_Emp" SessionField="emp_id" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="Msg_Type" Type="Int32" />
            <asp:Parameter DefaultValue="" Direction="InputOutput" Name="Message_Id" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="By_Emp" SessionField="Emp_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    &nbsp;<asp:HiddenField ID="HiddenFieldMessageToStr" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="HiddenFieldDate" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="HiddenFieldMessage_ID" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="HiddenFieldMessageTo" runat="server"></asp:HiddenField>

    <script type="text/javascript">
<!--
    var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1", { contentIsOpen: false });

    //-->
    </script>

    <script type="text/javascript">
<!--
    var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: 0 });
    //-->
    </script>

    <script type="text/javascript">
        var cookies = Spry.Utils.Cookie("read", "tabbedpanels");
        var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1", { defaultTab: cookies ? parseFloat(cookies) : 0 });
        Spry.Utils.addUnLoadListener(function () {
            // save the current value
            Spry.Utils.Cookie('create', 'tabbedpanels', TabbedPanels1.getCurrentTabIndex());
        });

    </script>

    <script type="text/javascript">
<!--
    var TabbedPanels2 = new Spry.Widget.TabbedPanels("TabbedPanels2", { defaultTab: 0 });
    //-->
    </script>

    <script type="text/javascript">


        $(document).ready(function (e) {

            $.cookie("selLink", null, { path: '/' });

        });



        //  var cookies = Spry.Utils.Cookie("read", "tabbedpanels");
        //  var TabbedPanels2 = new Spry.Widget.TabbedPanels("TabbedPanels2", { defaultTab: cookies ? parseFloat(cookies) : 0 });
        //  Spry.Utils.addUnLoadListener(function () {
        // save the current value
        //    Spry.Utils.Cookie('create', 'tabbedpanels', TabbedPanels2.getCurrentTabIndex());
        //  });

    </script>

</asp:Content>
