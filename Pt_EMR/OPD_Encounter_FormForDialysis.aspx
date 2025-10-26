<%@ Page Language="VB" AutoEventWireup="true" CodeFile="OPD_Encounter_FormForDialysis.aspx.vb" Inherits="OPD_Encounter_FormForDialysis" MaintainScrollPositionOnPostback="true" MasterPageFile="~/hacims_masterpage.master" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

     
    <script type="text/javascript" src="../Scripts/jquery-ui.js"></script>

     <script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>

    <link href="../css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />

    <script src="../css_hacims/ck.js" type="text/javascript"></script>

    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>

    <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>



    <script type="text/javascript">


        



        

        $(function () {
            $("#MedicineTabs").tabs({
                activate: function () {
                    var selectedTab = $('#MedicineTabs').tabs('option', 'active');
                    $("#<%= hdnSelectedTab.ClientID %>").val(selectedTab);
                },
                active: document.getElementById('<%= hdnSelectedTab.ClientID %>').value
            });
        });

        $(function () {
            $("#Pathology").tabs({
                activate: function () {
                    var selectedTab = $('#Pathology').tabs('option', 'active');
                    $("#<%= hdnSelectedTabforPathology.ClientID %>").val(selectedTab);
                },
                active: document.getElementById('<%= hdnSelectedTabforPathology.ClientID %>').value
            });
        });

        $(function () {
            $("#Radiology").tabs({
                activate: function () {
                    var selectedTab = $('#Radiology').tabs('option', 'active');
                    $("#<%= hdnSelectedTabforRadiology.ClientID %>").val(selectedTab);
                },
                active: document.getElementById('<%= hdnSelectedTabforRadiology.ClientID %>').value
            });
        });



        $(document).ready(function () {

            var tabs = $("#accordian").accordion({
                heightStyle: "content",
                activate: function (event, ui) {
                    localStorage.setItem("accIndex", $(this).accordion("option", "active"))
                },
                active: parseInt(localStorage.getItem("accIndex"))
            });

        });

        $('#LinkpreviusTestPatholog').click(function () {
            alert("ok");
            $('div#prevoiusTest').show();
        }
            );

        $('[id$="DataList_Frequency"]').css('visibility', 'visible')
        $('[id$="PreviousMedicine"]').click(function () {
            $('#CurrentMedicine').css('display', 'none');
        });

        if ($('[id$="hfForAutoPostBack"]').val() == "0") {

            $('[id$="rdbtnMedicines"]').val("Dept");
            $('[id$="ddlDepartmentMedicines"]').show();
            $('[id$="TextBox_specificMedicine"]').hide()
        }
        else {
            $('[id$="ddlDepartmentMedicines"]').hide();
            $('[id$="TextBox_specificMedicine"]').show()
        }


        $('[id$="rdbtnMedicines"]').change(function () {
            var text = $('[id$="rdbtnMedicines"] input[type="radio"]:checked').next().text();

            if (text == "Department Specific") {
                $('[id$="TextBox_specificMedicine"]').val("")
                $('[id$="ddlDepartmentMedicines"]').show()
                $('[id$="TextBox_specificMedicine"]').hide()
            }
            else {
                $('[id$="ddlDepartmentMedicines"]').val("0")
                $('[id$="ddlDepartmentMedicines"]').hide()
                $('[id$="TextBox_specificMedicine"]').show()
            }
        });

        $('[id$="ButtonSaveMedicine"]').click(function () {
            var text = $('[id$="rdbtnMedicines"] input[type="radio"]:checked').next().text();
            if (text == "Department Specific") {
                var value = $('[id$="ddlDepartmentMedicines"] option:selected').val();
                if (value == "0") {
                    alert("Please Select Correct Medicine")
                    return false;
                }
            }

            var MedincineCode = $('#<%=hfName.ClientID%>').val();

            if (MedincineCode == "" || $('[id$="TextBox_specificMedicine"]').val() == "") {
                alert("Please Select Correct Medicine")
                return false;
            }
            //else if (MedincineCode != "" && $('[id$="TextBox_specificMedicine"]').val() != "") {
            //    alert("Please Select Correct Medicine")
            //    return false;
            //}
        });

        $('[id$="ddlDepartmentMedicines"]').change(function () {
            var value = $('[id$="ddlDepartmentMedicines"] option:selected').val();
            if (value == "0") {
                alert("Please Select Correct Medicine")
                return false;
            }
            else {
                $('#<%=hfName.ClientID%>').val(value)
                }
            });





            $('#btnSave').click(function () {

                $.ajax({
                    url: 'OPD_Encounter_Form.aspx/Save',
                    method: 'POST',
                    contentType: 'application/json',
                    dataType: 'json',
                    data: JSON.stringify({
                        consultant: $('[id$="ddlDiabetologistName"] option:selected').val(),
                        stime: $('[id$="txtboxStart"]').val(), etime: $('[id$="txtboxEnd"]').val(),
                        assistant: $('[id$="ddlAssistant"] option:selected').val(), diabetiesType: $('[id$="ddlDiabetiesType"] option:selected').val(),
                        diagnosedTime: $('[id$="txtboxDate"]').val(), age: $('[id$="txtboxAge"]').val(),
                        duration: $('[id$="txtboxDuration"]').val()
                    }),
                    success: function (data) {
                        alert(data.d);
                    }
                });


            });






    </script>


    <script type="text/javascript">
        function ClientItemSelected(sender, e) {
            $get("<%=hfName.ClientID %>").value = e.get_value();
        }
        function ForRadSelected(sender, e) {
            $get("<%=hfForRad.ClientID%>").value = e.get_value();
        }




    </script>


    <style type="text/css">

        #chkList label{
            font-size:10px;
            font-family:sans-serif;
            padding-left:9px;
        }

         #chkList td{
             padding-left:7px;
         }


        #tblDialysisSession th{
            width:120px;
            text-align:center;
        }

        #tblDialysisSession td{
        border-color: black; border-width: 2px; border-style: solid; text-align: center;
        }


        #accordian h3 {
        }

        h3:hover {
            color: white;
        }

        .bxinfo_margin {
            height: auto;
        }

        #accordian h3 {
               padding-left: 30px;
    background: none;
    font: 14px;
    color: #1756c7;
    font-family: sans-serif;
    /* font-style: italic; */
    background-color: #F5F5F5;
    line-height: 28px;
    /* font-weight: bold; */
    font-size: 19px;
        }

        .radiobtns {
            font-size: 9px;
            color: #000;
            font-family: tahoma;
        }

        .altedrnate {
            background-color: #C90;
        }

        .displayNone {
            display: none;
        }
    </style>

    <script language="javascript" type="application/javascript">
        $(document).ready(function () {
            if (window.location.search.indexOf("Medicine") > 0) {
                $('html, body').animate({
                    scrollTop: $("#divMedicine").offset().top
                });
            }
            $('.medication_cnt li:nth-child(odd)').addClass('alternate');
        });

    </script>

    <script language="javascript" type="text/javascript">
        function ShowPanel(Control_ID) {
            document.getElementById("HiddenFieldTextOther").value = Control_ID;
            document.getElementById('Div_Text').style.visibility = 'visible';
            //document.getElementById('Div_Text').style.left=event.clientX-100;
            document.getElementById('Div_Text').style.top = event.clientY - 100;
            document.getElementById("TextBox1").value = document.getElementById(Control_ID).value;
        }

        function Show_Text_Value() {
            var id = document.getElementById("HiddenFieldTextOther").value;
            var text = document.getElementById("TextBox1").value;
            if (id != "") {
                document.getElementById(id).value = text;
            }
            document.getElementById("HiddenFieldTextOther").value = "";
        }

    </script>

    <style type="text/css">
        .bxinfo_margin {
            height: auto;
        }

        .darkc {
            font-size: 9px;
            font-family: arial;
        }

        #nav {
            display: none;
        }

    </style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true">
        <Services>
            <asp:ServiceReference Path="../autocomplete.asmx" />
        </Services>
    </asp:ScriptManager>

    <asp:HiddenField ID="hfForRad" runat="server" />
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" class="leftnav">

                <asp:Label ID="SideMenu" runat="server"></asp:Label>
            </td>





            <td valign="top">

                <div style="text-align:right;padding:8px;">
                    <span runat="server" style="padding-right:40px; color:red;text-transform:uppercase" id="spanMesage"  >Dialysis Session is not started yet ,So patient detail can not be entered</span>                    
                    <asp:Button Text="Create " ID="btnCreateDialysisSession" runat="server" OnClick="btnCreateDialysisSession_Click" />
                
              

                <div id="accordian">                    

                    <h3 runat="server" id="H1">Dialysis Session</h3>
                    <div  style="width:100%;display:block">
                <%--    <table class="inner_content" border="0" cellpadding="0" cellspacing="0" id="tblDialysisSession"   style="text-align: center;width:auto;">
                        <tr style="border:1px solid">
                            <th >Date</th>
                            <th >Dialysis #</th>
                            <th >Dialyzer</th>
                            <th >Dialysis Solution</th>
                            <th >Dialysis Machine #</th>
                            <th >Priming Solution</th>
                            <th >Starting Time</th>
                            <th >Finishing Time</th>                            
                        </tr>
                        <tr>
                            <td >
                                <asp:Label Text="1234123" ID="lblSessionStartDate" runat="server" TextMode="Date" Style="width: 120px !Important;"> </asp:Label>

                            </td>
                            <td >
                                <asp:Label Text="1234123" ID="lblDialysisNo" runat="server" TextMode="Number"></asp:Label>

                            </td>
                            <td >
                                <asp:Label ID="lblDialyzer" Text="1234123" runat="server"></asp:Label>

                            </td>
                            <td style="">
                                <asp:Label ID="lblDiaSolution" Text="1234123" runat="server"></asp:Label>

                            </td>
                            <td >
                                
                                <asp:Label id="lblDialysisMachineNo" Text="1234123" runat="server" ></asp:Label>

                            </td>
                            <td >
                                <asp:Label ID="lblPriSolution" Text="1234123" runat="server"></asp:Label>

                            </td>
                            <td >
                                <asp:Label ID="lblStartTime" runat="server" Text="1234123"  TextMode="Time"></asp:Label>
                            </td>
                            <td >
                                <asp:Label ID="lblEndTime" runat="server" Text="1234123" TextMode="Time"></asp:Label>
                            </td>
                            
                        </tr>
                    </table>--%>

                        <table width="100%">

                            <tr>
                                <td>
                                        <asp:GridView Width="100%" ID="gvdDialysisSession" AutoGenerateColumns="false" runat="server">
                            <Columns>
                                <asp:BoundField HeaderText="RegNo" DataField="RegNo" />
                                <asp:BoundField HeaderText="YearlyNo" DataField="YearlyNo" />
                                <asp:BoundField HeaderText="DIalysisNo" DataField="DIalysisNo" />
                                <asp:BoundField HeaderText="Dialyzer" DataField="Dialyzer" />
                                <asp:BoundField HeaderText="DialysisSolution" DataField="DialysisSolution" />
                                <asp:BoundField HeaderText="MachineNo" DataField="MachineNo" />
                                <asp:BoundField HeaderText="PrimingSolution" DataField="PrimingSolution" />
                                <asp:BoundField HeaderText="StartingTime" DataField="StartingTime" />
                                <asp:BoundField HeaderText="FinishiningTime" DataField="FinishiningTime" />                                
                            </Columns>
                        </asp:GridView> 
                                </td>
                            </tr>



                            <tr>
                                
                                <td>
                                 <h3 style=" color: #111; font-family: 'Open Sans Condensed', sans-serif; font-size: 20px; font-weight: 200; line-height: 30px; margin: 4px 0 4px; padding: 0 30px; text-align: center;">   Pre Dialysis </h3>
                                </td>
                                </tr>
                            <tr>
                                <td>
                                   
                   <asp:GridView Width="100%" ID="GvdPreDialysis" AutoGenerateColumns="false" runat="server">
                            <Columns>
                                
                                
                                <asp:BoundField HeaderText="Pulse" DataField="Pulse" />
                                <asp:BoundField HeaderText="BP" DataField="BP" />
                                <asp:BoundField HeaderText="Temp" DataField="Temp" />
                                <asp:BoundField HeaderText="Wt" DataField="Wt" />
                                <asp:BoundField HeaderText="Respiration" DataField="Respiration" />                                
                                <asp:BoundField HeaderText="Entry Date" DataField="EntryDate" />                                
                            </Columns>
                        </asp:GridView> 
                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                <h3 style=" color: #111; font-family: 'Open Sans Condensed', sans-serif; font-size: 20px; font-weight: 200; line-height: 30px; margin: 4px 0 4px; padding: 0 30px; text-align: center;">   Intra Dialysis </h3>
                                    </td>
                                </tr>
                            <tr>
                                <td>
                                    <div>
                                         <asp:GridView ID="gvIntraDialysis" runat="server" EmptyDataText="No Record(s) Found." AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="IntraTime" HeaderText="Time" />
                            <asp:BoundField DataField="pulse" HeaderText="Pulse" />
                            <asp:BoundField DataField="BP" HeaderText="B.P." />
                            <asp:BoundField DataField="GC" HeaderText="G.C" />
                            <asp:BoundField DataField="BloodFlow" HeaderText="Blood Flow" />
                            <asp:BoundField DataField="UFTarget" HeaderText="UF Target" />
                            <asp:BoundField DataField="UFRateTMP" HeaderText="U.F. Rate T.M.P" />
                            <asp:BoundField DataField="ArtPressure" HeaderText="Art Pressure" />
                            <asp:BoundField DataField="VenPressure" HeaderText="Ven Pressure" />
                            <asp:BoundField DataField="Heparin" HeaderText="Heparin" />
                        </Columns>
                    </asp:GridView>
                                    </div>
                                </td>

                            </tr>
                             <tr>
                                <td>
                              <h3 style=" color: #111; font-family: 'Open Sans Condensed', sans-serif; font-size: 20px; font-weight: 200; line-height: 30px; margin: 4px 0 4px; padding: 0 30px; text-align: center;">   Post Dialysis </h3>
                                    </td>
                                 </tr>
                            <tr>
                                <td>
                                      <asp:GridView Width="100%" ID="gvdPost" AutoGenerateColumns="false" runat="server">
                            <Columns>                                
                                <asp:BoundField HeaderText="Pulse" DataField="Pulse" />
                                <asp:BoundField HeaderText="BP" DataField="BP" />
                                <asp:BoundField HeaderText="Temp" DataField="Temp" />
                                <asp:BoundField HeaderText="Wt" DataField="Wt" />
                                <asp:BoundField HeaderText="Respiration" DataField="Respiration" />                                
                                <asp:BoundField HeaderText="Entry Date" DataField="EntryDate" />                                
                            </Columns>
                        </asp:GridView> 
                                    </td>
                                 </tr>




                        </table>





                    </div>


                    <h3 runat="server" id="H3">Assign Medicine</h3>
                    <div>
                         
                        <div id="MedicineTabs">
                            <ul>
                                <li><a href="#CurrentMedicine">Current Medicine</a></li>
                                <li><a href="#PreviousMedicine">Previous Medicine</a></li>
                            </ul>

                            <div id="CurrentMedicine">
                                <cc1:AutoCompleteExtender ID="GetMedication" runat="server" TargetControlID="TextBox_specificMedicine"
                                    ServicePath="../AutoComplete.asmx" ServiceMethod="GetMedication" MinimumPrefixLength="3"
                                    EnableCaching="true" CompletionSetCount="12" CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
                                    CompletionListItemCssClass="AutoExtenderList" CompletionListCssClass="AutoExtender" OnClientItemSelected="ClientItemSelected"
                                    CompletionInterval="10">
                                </cc1:AutoCompleteExtender>
                                <asp:TextBox ID="TextBox_Medicine" runat="server" Height="1px" Visible="false" Width="1px"></asp:TextBox>
                                <asp:RadioButtonList RepeatDirection="Horizontal" ID="rdbtnMedicines" runat="server">
                                    <asp:ListItem Text="All" Selected="True" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Department Specific" Value="Dept"></asp:ListItem>
                                </asp:RadioButtonList>

                                <asp:RadioButtonList ID="RadioButtonList_HospitalMed" runat="server" Visible="false" AutoPostBack="True"
                                    RepeatColumns="2">
                                    <asp:ListItem Selected="True" Value="0">All</asp:ListItem>
                                    <asp:ListItem Value="1">Hospital Stock</asp:ListItem>
                                </asp:RadioButtonList>
                                <div style="overflow: auto;">
                                    <table style="margin-left: 7px" id="TABLE1" class="Grid_1"
                                        cellspacing="0" cellpadding="0" width="98%">

                                        <tbody>
                                            <tr>
                                                <th style="width: 244px" align="center">Name</th>
                                                <th align="center">Route</th>
                                                <th align="center">Frequency</th>
                                                <th align="center" style="width: 40px">Days</th>
                                                <th align="center">Start Date</th>
                                                <th align="center">Med. Type</th>
                                                <th align="center">Before Meal</th>
                                                <th align="center">After Meal</th>
                                                <th align="center" colspan="1">Comments</th>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <asp:TextBox AccessKey="n" Style="width: 100%" ID="TextBox_specificMedicine" runat="server" CssClass="input_txt" AutoPostBack="false"></asp:TextBox>

                                                    <asp:DropDownList Width="100%" Visible="false" ID="ddlDepartmentMedicines" runat="server"></asp:DropDownList>

                                                    <asp:TextBox AccessKey="n" Style="width: 100%" ID="TextBox_specificMedicine_hs" runat="server" CssClass="input_txt" AutoPostBack="True" Visible="false"></asp:TextBox>
                                                    <br />
                                                    <asp:Label ID="Label1" runat="server" CssClass="red"></asp:Label>
                                                </td>
                                                <td valign="top">
                                                    <asp:DropDownList ID="DropDownList_route" runat="server" Style="width: 100%" DataSourceID="SqlDataSource_route"
                                                        DataValueField="Id" DataTextField="Description">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="DropDownList_dosage" Visible="false" runat="server" Style="width: 100%" DataSourceID="SqlDataSource_dosage"
                                                        DataValueField="Name" DataTextField="Name">
                                                    </asp:DropDownList></td>
                                                <td valign="top">
                                                    <table class="tbl_form" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <asp:DropDownList ID="DropDownList_frequencyName" runat="server" Width="100px" DataSourceID="SqlDataSource_frequency"
                                                                        AutoPostBack="false" DataValueField="id" DataTextField="Name">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="TextBox_Frequency" runat="server" Width="16px"
                                                                        AutoPostBack="True" CssClass="dataListAltItemStyle " Style="display: none">1</asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <ul id="CollapsiblePanel1">
                                                        <li style="text-align: right">
                                                            <asp:ImageButton ID="ImageButton_Frequency_ShowHide" OnClick="ImageButton_Frequency_ShowHide_Click"
                                                                runat="server" ImageUrl="../images_hacims/add.png"></asp:ImageButton></li>
                                                        <li>
                                                            <asp:DataList ID="DataList_Frequency" runat="server" RepeatDirection="Horizontal"
                                                                RepeatColumns="10" DataSourceID="SqlDataSource_FrequencyDataList" DataKeyField="Frequency_Sub_Id"
                                                                Visible="false">
                                                                <ItemTemplate>
                                                                    <div class="medbg">
                                                                        <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block; font-family: arial; font-size: 9px;"></asp:Label>
                                                                        <asp:TextBox ID="TextBox_dosage2" runat="server" Width="30px" Style="height: 12px; display: inline;">1</asp:TextBox>
                                                                        <asp:HiddenField ID="HF_F_S_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                        </li>
                                                    </ul>
                                                </td>
                                                <td valign="top" align="center">
                                                    <asp:TextBox ID="TextBox_days" runat="server" CssClass="input_txt" Style="width: 100%" AutoPostBack="false">1</asp:TextBox>
                                                    <asp:CheckBox ID="CheckBox_CT" runat="server" Text="CT" Visible="False"></asp:CheckBox></td>
                                                <td valign="top">
                                                    <igsch:WebDateChooser ID="WebDateChooserStartDate" runat="server" CssClass="drop_date"
                                                        Width="100px" Value="2008-01-16">
                                                        <CalendarLayout Culture="English (United Kingdom)">
                                                        </CalendarLayout>
                                                    </igsch:WebDateChooser>
                                                    <igsch:WebDateChooser ID="WebDateChooserEndDate" runat="server" CssClass="drop_date"
                                                        Width="100px" Visible="false" Value="2010-06-17">
                                                        <AutoPostBack ValueChanged="True" />
                                                        <CalendarLayout Culture="English (United Kingdom)">
                                                        </CalendarLayout>
                                                    </igsch:WebDateChooser>
                                                </td>

                                                <td>
                                                    <asp:DropDownList ID="ddlMedicineType" runat="server" Style="width: 100%">
                                                        <asp:ListItem Text="Dialysis Medicine" Value="Dialysis"></asp:ListItem>
                                                       
                                                    </asp:DropDownList>
                                                </td>

                                                <td valign="top">
                                                    <asp:DropDownList ID="DropDownList_Meal" runat="server" Width="87px" Visible="false">
                                                        <asp:ListItem Value="NA">.NA</asp:ListItem>
                                                        <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                                        <asp:ListItem Value="After Meal">After</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:TextBox ID="txtboxBeforeMeal" TextMode="MultiLine" Style="width: 100%; height: 35px;" runat="server"></asp:TextBox>
                                                    <asp:DropDownList ID="DropDownList_Medicine_Advice_Category" runat="server" DataSourceID="SqlDataSource_Medicine_Advice_Category"
                                                        Visible="false" DataValueField="Medicine_Advice_Category_ID" DataTextField="Medicine_Advice_Category_Name">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="DropDownList_diution" runat="server" Width="65px" DataSourceID="SqlDataSource_dilution"
                                                        Visible="False" DataValueField="name" DataTextField="name">
                                                    </asp:DropDownList>
                                                    <asp:TextBox ID="TextBox_dilution" runat="server" CssClass="input_txt" Width="25px"
                                                        Visible="False"></asp:TextBox>
                                                    <asp:Label ID="Label_Dilution" runat="server" Text="Dilution" Visible="False"></asp:Label></td>
                                                <td>
                                                    <asp:TextBox ID="txtboxAfterMeal" TextMode="MultiLine" Style="width: 100%; height: 35px;" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TextBoxInstruction" Style="width: 100%; height: 35px;" runat="server" TextMode="MultiLine" CssClass="input_txt" Width="100px"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div align="center" style="padding: 10px;">
                                    <asp:TextBox ID="TextBox_dosage" runat="server" CssClass="input_txt" Width="25px"
                                        Visible="False">1</asp:TextBox>
                                    <asp:Button ID="ButtonSaveMedicine" runat="server" Text="Save" OnClick="ButtonSaveMedicine_Click"
                                        CausesValidation="False"></asp:Button>
                                    <asp:Button ID="Button_UpdateMedicine" runat="server" Text="Update" Visible="False"
                                        OnClick="Button_UpdateMedicine_Click" CausesValidation="False"></asp:Button>
                                    <asp:Label ID="LabelMessageMedicine" runat="server" Font-Bold="True" CssClass="red"></asp:Label>
                                </div>
                                <%--  <asp:UpdatePanel ID="UpdatePanelMedicine" runat="server"  UpdateMode="Conditional"  ChildrenAsTriggers="false">
                                        <ContentTemplate>--%>

                                 <div style="width:100%;" >
                                       <asp:LinkButton ID="lnkButtonDetailSlip" style="float:right;" runat="server" Font-Bold="true" ForeColor="Blue" Text="View Detail Slip" PostBackUrl="~/Pt_EMR/MedicineDetailSlip.aspx"></asp:LinkButton> |
                                            <asp:LinkButton ID="lnkReport" style="float:right;margin-right: 30px;" runat="server" Font-Bold="true" ForeColor="Blue" Text="View Slip" PostBackUrl="~/Pt_EMR/MedicineSlip.aspx"></asp:LinkButton>
                                        
                                          
                                     </div>   

                                <asp:DataList ID="DataList_ConfirmedPrescriptions" runat="server" DataKeyField="priscription_id"
                                    DataSourceID="SqlDataSource_Confirmed_Prescriptions" Style="margin-left: 15px"
                                    Width="90%">
                                    <ItemTemplate>
                                        <ul class="medication_cnt">
                                            <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                                class="mname">
                                                <%# Eval("Medicine_Name") %> 
                                            </strong>
                                                <%#Eval("Para")%>
                                            </li>
                                            <li style="text-align: right;">
                                                <%#Eval("para_Urdu")%>

                                                <asp:HiddenField ID="HiddenField_PrescriptionID" runat="server" Value='<%# Eval("priscription_id") %>' />
                                            </li>
                                            <li style="text-align: right;">
                                                <asp:ImageButton ID="btn_delete"
                                                    CommandArgument='<%# Eval("priscription_id") %>' runat="server"
                                                    ImageUrl="~/images/img_del.gif" OnClick="btn_delete_Click" />
                                            </li>
                                        </ul>

                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="SqlDataSource_Confirmed_Prescriptions" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)"
                                    SelectCommand="Select_Med_Presc_Urdu" SelectCommandType="StoredProcedure"
                                    CancelSelectOnNullParameter="False">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                    </SelectParameters>
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                                            PropertyName="Value" />
                                    </DeleteParameters>
                                </asp:SqlDataSource>
                                <%-- </ContentTemplate>
                                         <Triggers>
                                         <asp:AsyncPostBackTrigger ControlID="ButtonSaveMedicine" EventName="Click" />
                                         </Triggers>
                                    </asp:UpdatePanel>
                                --%>
                                <asp:DataList ID="DataList_old" runat="server" DataSourceID="SqlDataSource2" Width="100%"
                                    Visible="false" DataKeyField="priscription_id">
                                    <ItemStyle CssClass="dataListItemStyle" />
                                    <AlternatingItemStyle CssClass="dataListAltItemStyle" />
                                    <ItemTemplate>
                                        <ul class="medication_cnt">
                                            <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                                class="mname"><%# Eval("[Medicine Name]") %></strong>
                                            </li>
                                            <li>Dosage : <span class="darkc">
                                                <%# Eval("Doze") %>
                                            </span><span>|</span>Frequency : <span class="darkc">
                                                <%# Eval("Qty") %>
                                            </span><span>|</span>Start Date : <span class="darkc">
                                                <%# Eval("[Start Date]") %>
                                            </span><span>|</span>End Date : <span class="darkc">
                                                <%# Eval("[End Date]") %>
                                            </span><span>| <span style="color: #6f6f6f">Doctor : </span>&nbsp;<asp:Label ID="Label5"
                                                runat="server" Text='<%# Eval("DOCTOR") %>'></asp:Label>
                                                |&nbsp;</span><span class="darkc">
                                                    <asp:Label ID="Label_Date" runat="server" Text='<%# Eval("date") %>'></asp:Label>
                                                    <%--<asp:LinkButton ID="LinkButton_Edit" runat="server" CausesValidation="False" CommandName="Select"
                                                    CssClass="editit" ToolTip="Edit Medicine"></asp:LinkButton>--%>
                                                    <asp:HiddenField ID="HiddenField3" runat="server" />
                                                    <%# Eval("CT") %>
                                                </span></li>
                                        </ul>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    SelectCommand="OPD_Encounter_Medication_prev" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="yearlyno" Type="Decimal" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:DataList ID="DataList_new" runat="server" DataSourceID="SqlDataSource1" Width="100%"
                                    Visible="false" DataKeyField="priscription_id">
                                    <ItemTemplate>
                                        <ul class="medication_cnt">
                                            <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                                class="mname">
                                                <%# Eval("[Medicine Name]") %>
                                            </strong><span>|</span> Dosage : <span class="darkc">
                                                <%# Eval("Doze") %>
                                            </span><span>|</span>Frequency :
                                                    <asp:Label ID="Label_Frequency" runat="server" ForeColor="Red" Text="Label"></asp:Label><span
                                                        class="darkc"><%#Eval("Dosage")%></span><span>|</span>Start Date : <span class="darkc">
                                                            <%# Eval("[Start Date]") %>
                                                        </span><span>|</span>For Days :
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("days") %>'></asp:Label><span
                                                        class="darkc"></span><span>|</span><%# Eval("CT") %>&nbsp;
                                                    <asp:LinkButton ID="LinkButton_Edit" runat="server" ToolTip="Edit Medicine" CssClass="editit"
                                                        CommandName="Select" CausesValidation="False"></asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton_Delete" runat="server" CausesValidation="False" CommandName="Delete"
                                                    CssClass="cancel_btn" ToolTip="Delete Medicine"></asp:LinkButton>
                                                <asp:CheckBox ID="CheckBox_Confirm" runat="server" ToolTip="Confirm Medicine" Checked="True" />
                                                <asp:HiddenField ID="HiddenField_PrescriptionID" runat="server" Value='<%# Eval("priscription_id") %>' />
                                                <asp:HiddenField ID="HiddenField_CT" runat="server" Value='<%# Eval("CT") %>' />
                                                <asp:HiddenField ID="HiddenField_EndDate" runat="server" Value='<%# Eval("[End Date]") %>' />
                                                <asp:HiddenField ID="HiddenField_Start_Date" runat="server" Value='<%# Eval("[Start Date]") %>' />
                                                <asp:HiddenField ID="HiddenField_Dosage" runat="server" Value='<%# Eval("Dosage") %>' />
                                                <asp:HiddenField ID="HiddenField_Doze" runat="server" Value='<%# Eval("Doze") %>' />
                                                <asp:HiddenField ID="HiddenField_MedicineName" runat="server" Value='<%# Eval("[Medicine Name]") %>' />
                                            </li>
                                        </ul>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    SelectCommand="OPD_Encounter_Medication" SelectCommandType="StoredProcedure"
                                    DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                    </SelectParameters>
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                                            PropertyName="Value" />
                                    </DeleteParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_Prescription" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    InsertCommand="Insert_Patient_Prescription_Detail" InsertCommandType="StoredProcedure"
                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    UpdateCommand="Update_Patient_Prescription_Detail" UpdateCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" />
                                        <asp:ControlParameter ControlID="HiddenField_MedCode" Name="Med_Code" PropertyName="Value" />
                                        <asp:SessionParameter Name="Registration_NO" SessionField="registrationNo" />
                                        <asp:ControlParameter ControlID="HiddenField_dosage" Name="Dosage" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="DropDownList_route" Name="Route_ID" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="HiddenField_Dilution" Name="Dilution" PropertyName="Value"
                                            DefaultValue="1" />
                                        <asp:ControlParameter ControlID="DropDownList_Meal" Name="Meal" PropertyName="SelectedValue"
                                            DefaultValue="1" />
                                        <asp:ControlParameter ControlID="DropDownList_frequencyName" Name="Frequency_ID"
                                            PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="txtboxBeforeMeal" Name="BeforeMeal" Type="String"
                                            PropertyName="Text" />
                                        <asp:ControlParameter ControlID="txtboxAfterMeal" Name="AfterMeal" Type="String"
                                            PropertyName="Text" />
                                        <asp:ControlParameter ControlID="TextBoxInstruction" Name="Instruction" PropertyName="Text"
                                            DefaultValue="" />
                                        <asp:ControlParameter ControlID="TextBox_days" Name="days" PropertyName="Text" />
                                        <asp:SessionParameter Name="emp_ID" SessionField="emp_id" />
                                        <asp:ControlParameter ControlID="HiddenFieldStartDate" Name="StartDate" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldEndDate" Name="EndDate" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="DropDownList_dosage" Name="Dose"
                                            PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="HiddenField_CT" Name="CT" PropertyName="Value" Type="String" />

                                        <asp:ControlParameter ControlID="DropDownList_diution" Name="Duration" PropertyName="SelectedValue"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="DropDownList_Medicine_Advice_Category" Name="Medicine_Advice_Category_ID"
                                            PropertyName="SelectedValue" Type="Int32" />
                                        <asp:ControlParameter ControlID="ddlMedicineType" Name="MedicineType" PropertyName="SelectedValue" Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Direction="InputOutput"
                                            Name="Prescription_Id" PropertyName="Value" Type="Decimal" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_MedCode" Name="Med_Code" PropertyName="Value"
                                            Type="String" />
                                        <asp:SessionParameter Name="Registration_NO" SessionField="registrationno" Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_dosage" Name="Dosage" PropertyName="Value"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="DropDownList_route" Name="Route_ID" PropertyName="SelectedValue"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_Dilution" Name="Dilution" PropertyName="Value"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="DropDownList_Meal" Name="Meal" PropertyName="SelectedValue"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_frequency" Name="Frequency_ID" PropertyName="Value"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="TextBox_days" Name="days" PropertyName="Text" Type="Int32" />
                                        <asp:SessionParameter Name="emp_ID" SessionField="emp_id" Type="String" />
                                        <asp:ControlParameter ControlID="TextBoxInstruction" Name="Instruction" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_start_date" Name="StartDate" PropertyName="Value"
                                            Type="DateTime" />
                                        <asp:ControlParameter ControlID="HiddenField_end_date" Name="EndDate" PropertyName="Value"
                                            Type="DateTime" />
                                        <asp:ControlParameter ControlID="HiddenFieldDose" Name="Dose" PropertyName="Value"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="HiddenField_CT" Name="CT" PropertyName="Value" Type="String" />
                                        <asp:ControlParameter ControlID="DropDownList_diution" Name="Duration" PropertyName="SelectedValue"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="DropDownList_Medicine_Advice_Category" Name="Medicine_Advice_Category_ID"
                                            PropertyName="SelectedValue" Type="Int32" />

                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:GridView ID="GridView_Template_Medicine" runat="server" AutoGenerateColumns="False"
                                    DataSourceID="SqlDataSourceForGrid" Width="100%" Visible="false">
                                    <Columns>
                                        <asp:BoundField DataField="Medicine Name" HeaderText="Medicine Name" SortExpression="Medicine Name" />
                                        <asp:BoundField DataField="Meal" HeaderText="Meal" SortExpression="Meal" />
                                        <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" Visible="False" />
                                        <asp:BoundField DataField="Dosage" HeaderText="Dosage" SortExpression="Dosage" />
                                        <asp:BoundField DataField="Doze" HeaderText="Doze" SortExpression="Doze" Visible="False" />
                                        <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" />
                                        <asp:BoundField DataField="days" HeaderText="Days" SortExpression="days" />
                                        <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" />
                                        <asp:TemplateField HeaderText="Total Qty" ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:Label ID="LabelTotalQty" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader2" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    SelectCommand="Select_Patient_Prescription_Detail" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                        <asp:ControlParameter Name="date" ControlID="HiddenFieldDate" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceForDateList"
                                    Width="100%" DataKeyNames="Column1" ShowHeader="False" Style="margin-top: 5px; display: none;">
                                    <Columns>
                                        <asp:BoundField DataField="Column1" HeaderText="Prescriptions Date" ReadOnly="True"
                                            SortExpression="Column1" Visible="False" ShowHeader="False" />
                                        <asp:ButtonField CommandName="Select" DataTextField="Column1" HeaderText="Prescription Date"
                                            Text="Button" />
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <FooterStyle CssClass="GridPager" />
                                    <SelectedRowStyle CssClass="gridselect" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <EditRowStyle CssClass="gridedit" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSourceForDateList" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    SelectCommand="SELECT distinct convert(varchar,date,103) FROM Pt_Prescription_Detail WHERE (Yearly_NO = @Yearly_NO) AND (Registration_NO = @Registration_NO)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="Yearly_NO" SessionField="YearlyNo" />
                                        <asp:SessionParameter Name="Registration_NO" SessionField="registrationNo" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_yearly_no" runat="server" />
                                <asp:HiddenField ID="HiddenFieldEndDate" runat="server" />
                                <asp:HiddenField ID="HiddenFieldStartDate" runat="server" />
                                <asp:HiddenField ID="HiddenField_dosage" runat="server" />
                                <asp:HiddenField ID="HiddenField_Dilution" runat="server" />
                                <asp:HiddenField ID="HiddenField_start_date" runat="server" />
                                <asp:HiddenField ID="HiddenField_end_date" runat="server" />
                                <asp:HiddenField ID="HiddenField_CT" runat="server" />

                                <asp:HiddenField ID="HiddenFieldDose" runat="server" />
                                <asp:HiddenField ID="HiddenField_Prescription_Id" runat="server" />
                                <asp:HiddenField ID="HiddenField_Medicine_Category" runat="server" />
                                <asp:HiddenField ID="HiddenField_priscription_id" runat="server" />
                                <asp:HiddenField ID="HiddenField_MedCode" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="HiddenField_DL_Dosage" runat="server" />
                                <asp:HiddenField ID="HiddenField_Frequency_Sub_Id" runat="server" />
                                <asp:HiddenField ID="HiddenField_flag" runat="server" />
                                <asp:HiddenField ID="HiddenFieldDate" runat="server" />

                                <%--<asp:HiddenField ID="HiddenField_priscription_id" runat="server" />                                        --%>
                                <asp:SqlDataSource ID="SqlDataSource_Frequency_detail" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    InsertCommand="Insert_Patient_Frequency_Detail" InsertCommandType="StoredProcedure"
                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="HiddenField_DL_Dosage" Name="Dosage" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="Prescription_Id"
                                            PropertyName="Value" Type="Decimal" />
                                        <asp:ControlParameter ControlID="HiddenField_Frequency_Sub_Id" Name="Frequency_Sub_Id"
                                            PropertyName="Value" Type="Int32" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_route" runat="server" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                                    SelectCommandType="StoredProcedure" SelectCommand="Select_Medicine_Category"
                                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    CancelSelectOnNullParameter="False">
                                    <%-- <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_MedCode" Name="Item_Code" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>--%>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_FrequencyDataList" runat="server" ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>"
                                    SelectCommand="SELECT     Medicine_Frequency.Name, Medicine_Frequency_Detail.Frequency , &#13;&#10;                      Medicine_Frequency_Detail.TimeDuration_Hour, Medicine_Frequency_Detail.Sequence_No, Medicine_Frequency_Detail.Frequency_Sub_Id,&#13;&#10;                      Medicine_Frequency_Detail.Frequency_Id&#13;&#10;FROM         Medicine_Frequency_Detail INNER JOIN&#13;&#10;                      Medicine_Frequency ON Medicine_Frequency_Detail.Frequency_Id = Medicine_Frequency.id&#13;&#10;WHERE     (Medicine_Frequency.id = @id)"
                                    ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_frequencyName" Name="id" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>


                                <asp:SqlDataSource ID="SqlDataSource_FrequencyDataListForPrevious" runat="server" ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>"
                                    SelectCommand="SELECT     Medicine_Frequency.Name, Medicine_Frequency_Detail.Frequency , &#13;&#10;                      Medicine_Frequency_Detail.TimeDuration_Hour, Medicine_Frequency_Detail.Sequence_No, Medicine_Frequency_Detail.Frequency_Sub_Id,&#13;&#10;                      Medicine_Frequency_Detail.Frequency_Id&#13;&#10;FROM         Medicine_Frequency_Detail INNER JOIN&#13;&#10;                      Medicine_Frequency ON Medicine_Frequency_Detail.Frequency_Id = Medicine_Frequency.id&#13;&#10;WHERE     (Medicine_Frequency.id = @id)"
                                    ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>">
                                    <SelectParameters>
                                        <asp:Parameter Name="id" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>



                                <asp:SqlDataSource ID="SqlDataSource_Medicine_Advice_Category" runat="server" SelectCommand="SELECT [Medicine_Advice_Category_ID], [Medicine_Advice_Category_Name] FROM [Medicine_Advice_Category]"
                                    ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_dilution" runat="server" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                                    SelectCommand="SELECT name FROM Medicine_Dilution" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_dosage" runat="server" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                                    SelectCommand="SELECT Name FROM Medicine_Dosage" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_frequency" runat="server" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                                    SelectCommand="SELECT     id, Name + ' (' + Occasion + ')' AS Name, CASE WHEN dbo.ufn_CountChar(Occasion, '+') > 0 THEN dbo.ufn_CountChar(Occasion, '+') ELSE 1000 END AS count&#13;&#10;FROM         Medicine_Frequency&#13;&#10;WHERE     (IS_Available = 1)"
                                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"></asp:SqlDataSource>
                                <asp:GridView Style="display: none" ID="GridView_Medicine" runat="server" CssClass="Grid_1"
                                    Width="100%" DataSourceID="SqlDataSourceMedcine1" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:BoundField DataField="MGName" HeaderText="Medicine" ReadOnly="True" SortExpression="MGName" />
                                        <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                                        <asp:BoundField DataField="Doctor" HeaderText="Doctor" ReadOnly="True" SortExpression="Doctor"
                                            Visible="False" />
                                        <asp:BoundField DataField="Dosage" HeaderText="Dosage" SortExpression="Dosage" />
                                        <asp:BoundField DataField="days" HeaderText="days" SortExpression="days" />
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSourceMedcine1" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                    SelectCommandType="StoredProcedure" SelectCommand="pt_Select_Medicine_Prescription"
                                    ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                    </SelectParameters>
                                </asp:SqlDataSource>




                                <%--                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>--%>
                                <%--<asp:Timer ID="Timer5" runat="server" Interval="50000">
            </asp:Timer>--%>
                                <asp:Repeater ID="Repeater_yimportexport" Visible="false" runat="server" DataSourceID="XmlDataSource_Medicine">
                                    <ItemTemplate>
                                        <ul class="medication_cnt">
                                            <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                                class="mname">
                                                <%#XPath("MedicineName")%>
                                            </strong></li>
                                            <li>Dosage : <span class="darkc">
                                                <%#XPath("Dosage")%>
                                            </span><span>|</span>Frequency : <span class="darkc">
                                                <%#XPath("Qty")%>
                                            </span><span>|</span>Start Date : <span class="darkc">
                                                <%#XPath("startdate")%>
                                            </span><span>|</span>End Date : <span class="darkc">
                                                <%#XPath("enddate")%>
                                            </span></li>
                                        </ul>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <%--  </ContentTemplate>
                    </asp:UpdatePanel>--%>
                                <br />
                                &nbsp;<asp:XmlDataSource ID="XmlDataSource_Medicine" runat="server" XPath="Medicationdatewise/item"
                                    DataFile="~/Pt_EMR/OPD_Encounter_Medication.xml"></asp:XmlDataSource>
                            </div>
                            <div id="PreviousMedicine">

                                <span style="display: block; text-align: right; padding-bottom: 10px;">
                                    <asp:Button ID="btnSavePreviousMedicine" runat="server" OnClick="btnSavePreviousMedicine_Click" Text="Save Previous Medicine" />
                                </span>

                                <asp:DataList ID="datalistForPreviousMedicine" OnItemDataBound="datalistForPreviousMedicine_ItemDataBound" runat="server" DataKeyField="priscription_id"
                                    Style="margin-left: 15px"
                                    Width="90%">
                                    <ItemTemplate>
                                        <table width="100%" class="Grid_1">
                                            <thead>
                                                <tr>
                                                    <th>Select</th>
                                                    <th align="center">Medicine</th>
                                                    <th align="center">Route</th>
                                                    <th align="center">Frequency</th>
                                                    <th align="center" style="width: 40px">Days</th>
                                                    <th align="center">Start Date</th>
                                                    <th align="center">Med. Type</th>
                                                    <th align="center">Before Meal</th>
                                                    <th align="center">After Meal</th>
                                                    <th align="center" colspan="1">Comments</th>
                                                </tr>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="assign" runat="server" ToolTip='<%# Eval("priscription_id") %>' /></td>
                                                        <asp:HiddenField ID="hfMedicine_Name" runat="server" Value='<%# Eval("Medicine_Name") %>' />
                                                        <asp:HiddenField ID="hfMedicine_Code" runat="server" Value='<%# Eval("MedCode") %>' />
                                                        <td style="width: 200px;"><%# Eval("Medicine_Name") %> </td>
                                                        <td valign="top">
                                                            <asp:DropDownList ID="DropDownList_routeForPreviousMedicine" runat="server" Style="width: 100%" DataSourceID="SqlDataSource_route"
                                                                DataValueField="Id" DataTextField="Description">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td valign="top">
                                                            <table class="tbl_form" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="DropDownList_frequencyNameForPreviousMedicine" runat="server" Width="100px" DataSourceID="SqlDataSource_Frequency"
                                                                                AutoPostBack="True" DataValueField="id" DataTextField="Name" OnSelectedIndexChanged="DropDownList_frequencyNameForPreviousMedicine_SelectedIndexChanged">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="TextBox_FrequencyForPreviousMedicine" runat="server" Width="16px"
                                                                                AutoPostBack="false" CssClass="dataListAltItemStyle " Style="display: none">1</asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            <ul id="CollapsiblePanel1">
                                                                <li style="text-align: right">
                                                                    <asp:ImageButton ID="ImageButton_Frequency_ShowHideForPreviousMedicine" OnClick="ImageButton_Frequency_ShowHideForPreviousMedicine_Click"
                                                                        runat="server" ImageUrl="../images_hacims/add.png"></asp:ImageButton></li>
                                                                <li>
                                                                    <asp:DataList ID="DataList_FrequencyForPreviousMedicine" runat="server" RepeatDirection="Horizontal"
                                                                        RepeatColumns="10" DataKeyField="Frequency_Sub_Id">
                                                                        <ItemTemplate>
                                                                            <div class="medbg">
                                                                                <asp:Label ID="FrequencyLabelForPreviousMedicine" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block; font-family: arial; font-size: 9px;"></asp:Label>
                                                                                <asp:TextBox ID="TextBox_dosage2ForPreviousMedicine" runat="server" Width="30px" Style="height: 12px; display: inline;">1</asp:TextBox>
                                                                                <asp:HiddenField ID="HF_F_S_IdForPreviousMedicine" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                                                            </div>
                                                                        </ItemTemplate>
                                                                    </asp:DataList>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                        <td valign="top" align="center">
                                                            <asp:TextBox ID="TextBox_daysForPreviousMedicine" runat="server" CssClass="input_txt" Style="width: 100%" AutoPostBack="true">1</asp:TextBox>

                                                            <td valign="top">
                                                                <igsch:WebDateChooser ID="WebDateChooserPreviousStartDate" runat="server" CssClass="drop_date"
                                                                    Width="100px">
                                                                    <CalendarLayout Culture="English (United Kingdom)">
                                                                    </CalendarLayout>
                                                                </igsch:WebDateChooser>
                                                            </td>

                                                            <td>
                                                                <asp:DropDownList ID="ddlMedicineTypeForPreviousMedicine" runat="server" Style="width: 100%">
                                                                    <asp:ListItem Text="Discharge Medicine" Value="Discharge Medicine"></asp:ListItem>
                                                                    <asp:ListItem Text="Emergency Treatment" Value="Emergency Treatment"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>

                                                            <td valign="top">
                                                                <asp:DropDownList ID="DropDownList_MealForPreviousMedicine" runat="server" Width="87px" Visible="false">
                                                                    <asp:ListItem Value="NA">.NA</asp:ListItem>
                                                                    <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                                                    <asp:ListItem Value="After Meal">After</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:TextBox ID="txtboxBeforeMealForPreviousMedicine" TextMode="MultiLine" Style="width: 100%; height: 35px;" runat="server"></asp:TextBox>
                                                                <td>
                                                                    <asp:TextBox ID="txtboxAfterMealForPreviousMedicine" TextMode="MultiLine" Style="width: 100%; height: 35px;" runat="server"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="TextBoxInstructionForPreviousMedicine" Style="width: 100%; height: 35px;" runat="server" TextMode="MultiLine" CssClass="input_txt" Width="100px"></asp:TextBox>
                                                                </td>
                                                    </tr>
                                                </tbody>
                                        </table>
                                        </li>                               
                            </ul>
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                        </div>

                    </div>

                    <h3 runat="server">Pathology </h3>
                    <div id="Pathology">
                        <ul>
                            <li><a href="#currentTest">Current Test</a></li>
                            <li><a href="#LinkpreviusTestPatholog">Previous Test</a></li>
                        </ul>
                        <%--<asp:UpdatePanel ID="updatepanel5" runat="server"><ContentTemplate>--%>
                        <div id="currentTest">
                            <table class="tbl_form" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tbody>
                                    <tr>
                                        <td style="width: 120px; font-weight: bold;" align="right">Test Name :</td>
                                        <td>
                                            <asp:TextBox AccessKey="n" ID="TextBox_Test" runat="server" Style="width: 65%;" AutoPostBack="false"></asp:TextBox>
                                            <asp:Button Text="Add" ID="btnAddPathology" OnClick="btnAddPathology_Click" runat="server" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <br />
                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" BehaviorID="GetPathTest"
                                TargetControlID="TextBox_Test" ServicePath="../AutoComplete.asmx" ServiceMethod="GetPathTest"
                                MinimumPrefixLength="3" EnableCaching="true" CompletionSetCount="12" CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
                                CompletionListItemCssClass="AutoExtenderList" CompletionListCssClass="AutoExtender"
                                CompletionInterval="10">
                            </cc1:AutoCompleteExtender>
                            <asp:HiddenField ID="HiddenField_MG_ID" runat="server" />
                            <asp:HiddenField ID="HiddenFieldGender" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="HiddenField_Order_ID" runat="server" Value="0"></asp:HiddenField>
                            <asp:DataList ID="DataList_Test" runat="server" DataSourceID="SqlDataSourceTestNew"
                                Width="50%" Style="margin-left: 15px;">
                                <ItemTemplate>
                                    <ul class="medication_cnt">
                                        <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                            class="mname">
                                            <asp:Label ID="Label_TestDate" runat="server" Text='<%# Eval("TestDate") %>'></asp:Label></strong></li>
                                        <asp:DataList ID="DataList_Test_Sub" RepeatDirection="Vertical" RepeatColumns="1" runat="server" DataSourceID="SqlDataSource_Test_Sub">
                                            <ItemTemplate>
                                                <li style="height: auto; padding-bottom: 4px; font-size: 11px; padding-right: 5px;">
                                                    <asp:Label ID="TB_NameLabel" runat="server" Text='<%# Eval("TBName") %>'></asp:Label>:
                                                                <asp:ImageButton CommandArgument='<%# Eval("TB_ID") %>' ImageUrl="~/images_hacims/icon_delete.GIF" OnClick="imgDeletePath_Click" runat="server" ID="imgDeletePath" />
                                                </li>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </ul>
                                    <asp:SqlDataSource ID="SqlDataSource_Test_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                        SelectCommand="SELECT DISTINCT Investigation_Order_Main.Investigation_Order_ID,Investigation_Order_Sub.TB_ID, TestGroup.TGName,Test_Booking.TB_Name as TBName FROM  
                   Test_Booking INNER JOIN 
                    TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN 
                    Investigation_Order_Sub INNER JOIN  
                    Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID ON 
                    Test_Booking.TB_ID = Investigation_Order_Sub.TB_ID  where    (Investigation_Order_Main.YearlyNo = @YearlyNo) AND (Investigation_Order_Main.RegNo = @RegNo) and (CONVERT(varchar,Investigation_Order_Main.Date_Time, 103) = @Date)&#13;&#10;">
                                        <SelectParameters>
                                            <asp:Parameter Name="YearlyNo" />
                                            <asp:Parameter Name="RegNo" />
                                            <asp:Parameter Name="Date" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ItemTemplate>
                            </asp:DataList>
                            <asp:SqlDataSource ID="SqlDataSourceTestNew" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                SelectCommand="  SELECT DISTINCT CONVERT(varchar, Date_Time, 103) AS TestDate FROM     
	     Investigation_Order_Main WHERE     (YearlyNo = @PayID) and (RegNo = @RegNo) and Investigation_Order_ID in (select Investigation_Order_ID from Investigation_Order_Sub)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="PayID" SessionField="YearlyNO" Type="Int32" />
                                    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                SelectCommand="SELECT DISTINCT CONVERT (varchar, Investigation_Order_Main.Date_Time, 103) + ' ' + CONVERT (varchar, Investigation_Order_Main.Date_Time, 108) AS TestAssignDate, TestGroup.TGName, Test_Booking.TB_Name, Path_Result_Delivery.Main_ID, TestGroup.TGID FROM Path_Test_Booking_Services INNER JOIN Path_Result_Delivery ON Path_Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID RIGHT OUTER JOIN Investigation_Order_Sub INNER JOIN Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID INNER JOIN Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID ON Investigation_Order_Sub.TB_ID = Test_Booking.TB_ID ON Path_Result_Delivery.Yearly_No = Investigation_Order_Main.YearlyNo AND Path_Result_Delivery.Reg_no = Investigation_Order_Main.RegNo AND Path_Result_Delivery.HospitalOrderNo = Investigation_Order_Main.Investigation_Order_ID WHERE (Investigation_Order_Main.YearlyNo = @PayID) AND (Investigation_Order_Main.RegNo = @RegNo)"
                                ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                                <SelectParameters>
                                    <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Int32" />
                                    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <%--</ContentTemplate> <!-- Main Update Panel--!>
                            </asp:UpdatePanel>--%>
                        </div>
                        <br />
                        <br />
                        <div id="LinkpreviusTestPatholog">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:DataList ID="DataListForPreviousTestPathology" runat="server" DataSourceID="SqlDataSourcePreviousTestForPathology"
                                            Width="50%" Style="margin-left: 15px;">
                                            <ItemTemplate>
                                                <ul class="medication_cnt">
                                                    <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;"><strong
                                                        class="mname">
                                                        <asp:Label ID="Label_TestDate" runat="server" Text='<%# Eval("TestDate") %>'></asp:Label>
                                                        (<%# Eval("YearlyNo") %>) </strong></li>
                                                    <asp:HiddenField ID="hfForPathologyYearlyNo" runat="server" Value='<%#Eval("YearlyNo") %>' />
                                                    <asp:DataList ID="DataListPreviousTestOfPathology_Sub" RepeatDirection="Vertical" RepeatColumns="1" runat="server">
                                                        <ItemTemplate>
                                                            <li style="height: auto; padding-bottom: 4px; font-size: 11px; padding-right: 5px;">
                                                                <asp:Label ID="TB_NameLabel" runat="server" Text='<%# Eval("TBName") %>'></asp:Label>:                                                                
                                                            </li>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                </ul>
                                                <asp:SqlDataSource ID="SqlDataSource_Test_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                                    SelectCommand="SELECT DISTINCT Investigation_Order_Main.Investigation_Order_ID,Investigation_Order_Sub.TB_ID, TestGroup.TGName,Test_Booking.TB_Name as TBName FROM  
                   Test_Booking INNER JOIN 
                    TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN 
                    Investigation_Order_Sub INNER JOIN  
                    Investigation_Order_Main ON Investigation_Order_Sub.Investigation_Order_ID = Investigation_Order_Main.Investigation_Order_ID ON 
                    Test_Booking.TB_ID = Investigation_Order_Sub.TB_ID  where    (Investigation_Order_Main.YearlyNo = @YearlyNo) AND (Investigation_Order_Main.RegNo = @RegNo) and (CONVERT(varchar,Investigation_Order_Main.Date_Time, 103) = @Date)&#13;&#10;">
                                                    <SelectParameters>
                                                        <asp:Parameter Name="YearlyNo" />
                                                        <asp:Parameter Name="RegNo" />
                                                        <asp:Parameter Name="Date" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>

                                            </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                </tr>
                            </table>
                            <asp:SqlDataSource ID="SqlDataSourcePreviousTestForPathology" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                SelectCommand="  SELECT DISTINCT CONVERT(varchar, Date_Time, 103) AS TestDate,YearlyNo FROM     
	     Investigation_Order_Main a inner join Investigation_Order_Sub b on 
		 a.Investigation_Order_ID=b.Investigation_Order_ID
		  WHERE    YearlyNo in( select top(3) PayID  from Payment  where PayID not in 
(select MAX(PayID) from Payment) and  RegNo=@RegNo  order by PayID desc)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>



                        </div>
                        <%--</ContentTemplate> <!-- Main Update Panel--!>
                            </asp:UpdatePanel>--%>
                    </div>

                    <h3 runat="server">Radiology </h3>

                    <div id="Radiology">
                        <ul>
                            <li><a id="currentTEST" href="#CurrentTest">Current Tests</a></li>
                            <li><a id="previousTEST" href="#PreviousTest">Previous Tests</a></li>
                        </ul>


                        <%--<asp:UpdatePanel ID="updatepanel6" runat="server"><ContentTemplate>--%>


                        <br />

                        <asp:HiddenField ID="HiddenField_Radiology_Order_ID" runat="server" Value="0"></asp:HiddenField>
                        <div id="CurrentTest">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <cc1:AutoCompleteExtender ID="Get_Radiology_Test" runat="server" CompletionInterval="10"
                                            CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList"
                                            CompletionListHighlightedItemCssClass="AutoExtenderHighlight" CompletionSetCount="12"
                                            EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="Get_Radiology_Test"
                                            ServicePath="../AutoComplete.asmx" OnClientItemSelected="ForRadSelected" TargetControlID="TextBox_TestRadiology" BehaviorID="Get_Radiology_Test">
                                        </cc1:AutoCompleteExtender>

                                        <table style="width: 100%;">
                                            <tr>
                                                <td style="font-weight: bold; width: 120px; text-align: right;">Test Name :
                                                </td>
                                                <td>
                                                    <asp:TextBox AccessKey="n" ID="TextBox_TestRadiology" runat="server" Style="width: 65%"
                                                        AutoPostBack="false"></asp:TextBox>
                                                    <asp:Button Text="Add" ID="btnAddRadiologyTest" OnClick="btnAddRadiologyTest_Click" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:UpdatePanel ID="UpdatePanelRadiology" runat="server" UpdateMode="Always">
                                            <ContentTemplate>
                                                <asp:DataList ID="DataList_Radiology" runat="server" DataSourceID="SqlDataSourceRadiology"
                                                    Width="100%" Style="margin-left: 15px;">
                                                    <ItemTemplate>
                                                        <ul class="medication_cnt">
                                                            <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;">
                                                                <strong
                                                                    class="mname">
                                                                    <asp:Label ID="Label_Date" runat="server" Text='<%# Eval("DateTime")  %>'></asp:Label></strong></li>
                                                            <asp:DataList ID="DataList_Radiology_Sub" runat="server" RepeatDirection="Vertical"
                                                                RepeatColumns="1" DataSourceID="SqlDataSource_Radiology_Sub">
                                                                <ItemTemplate>
                                                                    <li style="border: 0; height: auto; font-size: 11px; padding-right: 5px;">
                                                                        <asp:Label ID="RadiologyNameLabel" runat="server" Text='<%# Eval("tbname") %>'></asp:Label>:
                                                                       <asp:ImageButton OnClick="imgDeletRadiology_Click" CommandArgument='<%# Eval("Radiology_SubId")%>' runat="server" ID="imgDeletRadiology" ImageUrl="~/images_hacims/icon_delete.GIF" />
                                                                    </li>
                                                                </ItemTemplate>
                                                            </asp:DataList>

                                                        </ul>
                                                        <asp:SqlDataSource ID="SqlDataSource_Radiology_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                                            SelectCommand="SELECT DISTINCT Radiology_Order_Main.Order_ID,Radiology_Order_Sub.Radiology_SubId, Radiology.dbo.TestGroup.TGName,Radiology_Order_Sub.RadiologyTestName  AS tbname FROM         Radiology_Order_Sub INNER JOIN  Radiology_Order_Main 
ON Radiology_Order_Sub.Order_ID = Radiology_Order_Main.Order_ID INNER JOIN  radiology.dbo.Test_Booking 
ON Radiology_Order_Sub.TB_ID = Radiology.dbo.Test_Booking.TB_ID INNER JOIN  
Radiology.dbo.TestGroup ON Radiology.dbo.Test_Booking.MG_ID = Radiology.dbo.TestGroup.TGID WHERE   (Radiology_Order_Main.YearlyNo = @YearlyNo) AND (Radiology_Order_Main.RegNo =@RegNo) AND (CONVERT(varchar, Radiology_Order_Main.Date_Time, 103) &#13;&#10;                      = @Date)">
                                                            <SelectParameters>
                                                                <asp:Parameter Name="YearlyNo" />
                                                                <asp:Parameter Name="RegNo" />
                                                                <asp:Parameter Name="Date" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="PreviousTest">
                            <table width="100%">
                                <tr>
                                    <td valign="top" style="width: 48%">
                                        <asp:DataList ID="DataListPreviousTestParent" runat="server" DataSourceID="SqlDataSourceRadiologyPreviousTest_Parent"
                                            Width="100%" Style="margin-left: 15px;">
                                            <ItemTemplate>
                                                <ul class="medication_cnt">
                                                    <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;">
                                                        <strong
                                                            class="mname">
                                                            <asp:Label ID="Label_Date" runat="server" Text='<%# Eval("DateTime") %>'></asp:Label>
                                                            <%#  "(" & Eval("YearlyNo") & ")" %></strong></li>
                                                    <asp:HiddenField ID="yearlyNO" runat="server" Value='<%# Eval("YearlyNo") %>' />
                                                    <asp:DataList ID="DataListPreviousTest_Sub" runat="server" RepeatDirection="Vertical"
                                                        RepeatColumns="1">
                                                        <ItemTemplate>
                                                            <li style="border: 0; height: auto; font-size: 11px; padding-right: 5px;">
                                                                <asp:Label ID="RadiologyNameLa" runat="server" Text='<%# Eval("tbname") %>'></asp:Label>:
                                                                       
                                                            </li>
                                                        </ItemTemplate>
                                                    </asp:DataList>

                                                </ul>
                                                <asp:SqlDataSource ID="SqlDataSource_Radiology_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                                    SelectCommand="SELECT DISTINCT Radiology_Order_Main.Order_ID,Radiology_Order_Sub.Radiology_SubId, Radiology.dbo.TestGroup.TGName,Radiology_Order_Sub.RadiologyTestName  AS tbname FROM         Radiology_Order_Sub INNER JOIN  Radiology_Order_Main 
ON Radiology_Order_Sub.Order_ID = Radiology_Order_Main.Order_ID INNER JOIN  radiology.dbo.Test_Booking 
ON Radiology_Order_Sub.TB_ID = Radiology.dbo.Test_Booking.TB_ID INNER JOIN  
Radiology.dbo.TestGroup ON Radiology.dbo.Test_Booking.MG_ID = Radiology.dbo.TestGroup.TGID WHERE   (Radiology_Order_Main.YearlyNo = @YearlyNo) AND (Radiology_Order_Main.RegNo =@RegNo) AND (CONVERT(varchar, Radiology_Order_Main.Date_Time, 103) &#13;&#10;                      = @Date)">
                                                    <SelectParameters>
                                                        <asp:Parameter Name="YearlyNo" />
                                                        <asp:Parameter Name="RegNo" />
                                                        <asp:Parameter Name="Date" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                </tr>
                            </table>

                        </div>



                        <%--  <asp:SqlDataSource ID="SqlDataSource_Radiology_PreviousTest_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                            SelectCommand="SELECT DISTINCT Radiology_Order_Main.Order_ID,Radiology_Order_Sub.Radiology_SubId, Radiology.dbo.TestGroup.TGName,Radiology_Order_Sub.RadiologyTestName  AS tbname FROM         Radiology_Order_Sub INNER JOIN  Radiology_Order_Main 
ON Radiology_Order_Sub.Order_ID = Radiology_Order_Main.Order_ID INNER JOIN  radiology.dbo.Test_Booking 
ON Radiology_Order_Sub.TB_ID = Radiology.dbo.Test_Booking.TB_ID INNER JOIN  
Radiology.dbo.TestGroup ON Radiology.dbo.Test_Booking.MG_ID = Radiology.dbo.TestGroup.TGID WHERE   (Radiology_Order_Main.YearlyNo = @YearlyNo) AND (Radiology_Order_Main.RegNo =@RegNo) AND (CONVERT(varchar, Radiology_Order_Main.Date_Time, 103) &#13;&#10;                      = @Date)">
                                            <SelectParameters>
                                                <asp:Parameter Name="YearlyNo" />
                                                <asp:Parameter Name="RegNo" />
                                                <asp:Parameter Name="Date" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>    --%>


                        <asp:SqlDataSource ID="SqlDataSourceRadiology" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                            SelectCommand="SELECT DISTINCT CONVERT(varchar, Date_Time, 103) AS DateTime&#13;&#10;FROM         Radiology_Order_Main&#13;&#10;WHERE     (YearlyNo = @PayID) and (RegNo = @RegNo) and  Order_ID in (
	 select Order_ID from Radiology_Order_Sub
	 )">
                            <SelectParameters>
                                <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                                <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceRadiologyPreviousTest_Parent" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                            SelectCommand="SELECT distinct CONVERT(varchar, Date_Time, 103) AS DateTime,YearlyNo FROM     Radiology_Order_Main WHERE     (YearlyNo in ( select top(3) PayID  from Payment  where PayID not in 
(select MAX(PayID) from Payment) and  RegNo=@RegNo  order by PayID desc
	))
	">
                            <SelectParameters>
                                <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />

                            </SelectParameters>
                        </asp:SqlDataSource>


                        <%--<asp:GridView ID="GridViewRadiology" runat="server" CssClass="Grid_1" Width="100%"
                                                DataSourceID="SqlDataSourceRadiology" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:BoundField DataField="DateTime" HeaderText="Advise Date" SortExpression="DateTime" />
                                                    <asp:BoundField DataField="TGName" HeaderText="Group" SortExpression="TGName" />
                                                    <asp:BoundField DataField="TB_Name" HeaderText="Radiology Investigation" SortExpression="TB_Name" />
                                                </Columns>
                                                <RowStyle CssClass="GridItem" />
                                                <HeaderStyle CssClass="GridHeader" />
                                                <AlternatingRowStyle CssClass="GridAltItem" />
                                            </asp:GridView>--%>
                        <%--<asp:SqlDataSource ID="SqlDataSourceRadiology" runat="server" SelectCommandType="StoredProcedure"
                                                SelectCommand="pt_Radiology_Select_Tests" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" Type="String" />
                                                    <asp:SessionParameter Name="PayID" SessionField="YearlyNo" Type="Decimal" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>--%>
                                            &nbsp;<br />
                        &nbsp;
                                    <asp:SqlDataSource ID="SqlDataSourceXray" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                                        SelectCommand="SELECT   TestGroup.TGName, Radiology_Order_Sub.Instructions, Radiology_Order_Sub.RadiologyTestName&#13;&#10;FROM         Radiology_Order_Main INNER JOIN&#13;&#10;                      Radiology_Order_Sub ON Radiology_Order_Main.Order_ID = Radiology_Order_Sub.Order_ID INNER JOIN&#13;&#10;                      Test_Booking ON Radiology_Order_Sub.TB_ID = Test_Booking.TB_ID INNER JOIN&#13;&#10;                      TestGroup ON Test_Booking.MG_ID = TestGroup.TGID&#13;&#10;WHERE     (Radiology_Order_Main.YearlyNo = @YearlyNo) AND (Radiology_Order_Main.RegNo = @RegNo) AND &#13;&#10;                      (Radiology_Order_Main.SubDept_Id = @SubDept_Id) AND (Radiology_Order_Main.DeptId = @DeptId)"
                                        ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="YearlyNo" SessionField="Yearlyno" />
                                            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
                                            <asp:SessionParameter Name="DeptId" SessionField="dept_id" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                        <div style="border-right: #999999 3px solid; padding-right: 10px; border-top: #999999 3px solid; padding-left: 10px; z-index: 100; left: 568px; visibility: hidden; padding-bottom: 10px; border-left: #999999 3px solid; width: 250px; padding-top: 10px; border-bottom: #999999 3px solid; position: absolute; top: 16px; height: 100px; background-color: #ffffff"
                            id="Div_Text">
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tbody>
                                    <tr>
                                        <td style="width: 255px" align="right">
                                            <asp:Button ID="Button1" runat="server" Text="" CssClass="btn_close"></asp:Button></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 255px">
                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt" Width="100%" Height="88px"
                                                TextMode="MultiLine"></asp:TextBox></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--</ContentTemplate>
                            </asp:UpdatePanel>--%>
                    </div>

                    
                    <h3 runat="server">Complications </h3>
                    <div>
                        <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                            <ContentTemplate>
                                <div id="chkList" style="width:100%">
                    <asp:CheckBoxList ID="chkboxDialysisComplications"  runat="server" RepeatDirection="Horizontal" RepeatColumns="2"></asp:CheckBoxList>                
                                </div>
                               


                                <div align="center" style="padding-top: 10px;">
                                    <asp:Button ID="Button_phy_Notes" runat="server" OnClick="Button_phy_Notes_Click" Text="save" CssClass="btn1"></asp:Button>
                                </div>
                                <br />
                                <p style="width:40%;margin:auto;padding-left:80px;color: blue;font-size: 17px;padding-bottom:2px;">Patient Complications</p>
                                <hr style="width:40%;margin:auto; background-color: #fff;padding-bottom:10px;	border-top: 2px dashed #8c8b8b;" />
                                 <div>
                                    <asp:Label ID="lblDialysisComplications" style="color:darkblue" runat="server"></asp:Label>
                                </div>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                   
                    
                </div>
                <asp:SqlDataSource ID="SqlDataSource_Alert" runat="server"
                    SelectCommand="SELECT [Reg_No], [Yearly_No], [Alert], [Alert_ID] FROM [OPD_Alert] where [Reg_No]=@Reg_No and [Yearly_No]=@Yearly_No"
                    ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>" UpdateCommand="UPDATE [OPD_Alert] SET [Reg_No] = @Reg_No, [Yearly_No] = @Yearly_No, [Alert] = @Alert WHERE [Alert_ID] = @Alert_ID"
                    InsertCommand="INSERT INTO [OPD_Alert] ([Reg_No], [Yearly_No], [Alert]) VALUES (@Reg_No, @Yearly_No, @Alert)"
                    DeleteCommand="DELETE FROM [OPD_Alert] WHERE [Alert_ID] = @Alert_ID">
                    <SelectParameters>
                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
                        <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="Alert_ID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Reg_No" Type="String" />
                        <asp:Parameter Name="Yearly_No" Type="String" />
                        <asp:Parameter Name="Alert" Type="String" />
                        <asp:Parameter Name="Alert_ID" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" Type="String" />
                        <asp:SessionParameter Name="Yearly_No" SessionField="Yearlyno" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_Alert" Name="Alert" PropertyName="Text"
                            Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <br />

                <div class="bx_infos_patients" style="display: none;">
                    <h2>
                        <span>Vitals
                                            <asp:HyperLink ID="HyperLink5" runat="server" CssClass="example_vitals" NavigateUrl="~/Nursing/nursevitals_encounterform.aspx">Add Vitals</asp:HyperLink></span></h2>
                    <div class="bxinfo_marginb">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>

                                <asp:GridView ID="GridViewVitals" runat="server" CssClass="Grid_1" Width="100%">
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader_abs" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        &nbsp;
                                        <br />

                        <br />


                        <asp:RadioButtonList ID="RadioButtonListCategory" runat="server" RepeatDirection="Horizontal"
                            RepeatLayout="Flow" Visible="False">
                            <asp:ListItem>Ward</asp:ListItem>
                            <asp:ListItem>ICU</asp:ListItem>
                            <asp:ListItem>OT</asp:ListItem>
                        </asp:RadioButtonList>
            </td>


            <asp:SqlDataSource ID="SqlDataSourcevitals" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                InsertCommand="Insert_Patient_Vital_Nurse" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                DeleteCommand="DELETE FROM Pt_Stages_Vitals WHERE (vitalsid = @vitalsID)" UpdateCommand="UPDATE Pt_Stages_Vitals SET TemperatureF = @TempF, TemperatureC = @TempC, Pulsebeats = @Pulse, Respirationbeats = @RR, BPHigh = @BPHigh, BPLow = @BPlow, datetime = @DateTime WHERE (vitalsid = @VitalsID)">
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenFieldVitalID" Name="VitalID" PropertyName="Value"
                        Type="Int32" />
                    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                    <asp:SessionParameter Name="SubDeptID" SessionField="SubDeptID" Type="Int32" />
                    <asp:ControlParameter ControlID="RadioButtonListCategory" Name="Category" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:SessionParameter Name="EmpID" SessionField="emp_Id" Type="Int32" />
                    <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                    <asp:ControlParameter ControlID="HiddenFieldVital_Value" Name="Result" PropertyName="Value"
                        Type="Double" />
                    <asp:ControlParameter ControlID="HiddenFieldVitalTakeDate" Name="DateTime" PropertyName="Value"
                        Type="DateTime" />
                    <asp:Parameter DefaultValue="0" Name="Transfusion_Id" Type="Int32" />
                    <asp:Parameter DefaultValue=" " Name="val" Type="String" />
                    <asp:ControlParameter ControlID="hf_Remarks_Identity" Name="Vital_Remark_ID" PropertyName="Value"
                        Type="Int32" />
                </InsertParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridViewVitals" Name="vitalsID" PropertyName="SelectedValue" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="HiddenFieldTemp" Name="TempF" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenFieldTempC" Name="TempC" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenFieldPulse" Name="Pulse" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenFieldRR" Name="RR" PropertyName="Value" />
                    <asp:ControlParameter ControlID="RangeValidatorBPHigh" Name="BPHigh" PropertyName="Text" />
                    <asp:ControlParameter ControlID="RangeValidatorBPLow" Name="BPlow" PropertyName="Text" />
                    <asp:ControlParameter ControlID="HiddenFieldDateTime" Name="DateTime" PropertyName="Value" />
                    <asp:ControlParameter ControlID="GridViewVitals" Name="VitalsID" PropertyName="SelectedValue" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:HiddenField ID="hf_Remarks_Identity" runat="server" />
            <asp:HiddenField ID="HiddenFieldVital_Value" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="HiddenFieldVitalTakeDate" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="HiddenFieldVitalID" runat="server"></asp:HiddenField>



            <br />
            <asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)"
                ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>">
                <SelectParameters>
                    <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                    <asp:SessionParameter Name="deptid" SessionField="dept_id" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField2" runat="server" Value="0"></asp:HiddenField>
            <asp:HiddenField ID="HiddenField3" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="HiddenFieldTextOther" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="HiddenFieldTemplate_ID" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true"></asp:HiddenField>
            <asp:HiddenField ID="HiddenField1" runat="server" Value="true"></asp:HiddenField>
            <asp:HiddenField ID="HiddenField_Mg_Code" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="HiddenField_Count" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="HiddenField_root" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="HiddenField_MH_Code" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="hfName" runat="server"></asp:HiddenField>

            

            <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>


        </tr>
    </table>
    <asp:UpdateProgress ID="UpdateProgress_search" runat="server" DisplayAfter="0">
        <ProgressTemplate>
            <div style="top: 50%; left: 45%; margin-top: 5px; font-size: 11px; position: absolute; margin-top: -29px;">
                <img id="Img1" src="~/Images_hacims/process.gif" alt="" runat="server" />
                <span style="margin-left: 5px; color: #999999; display: inline-block; margin-top: 5px; float: right;">Processing your request.  Please wait.... </span>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:HiddenField ID="hdnSelectedTab" runat="server" />
    <asp:HiddenField ID="hdnSelectedTabforRadiology" runat="server" />
    <asp:HiddenField ID="hdnSelectedTabforPathology" runat="server" />

    <asp:HiddenField ID="hfForAutoPostBack" runat="server" />
</asp:Content>
