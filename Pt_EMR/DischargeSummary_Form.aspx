<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DischargeSummary_Form.aspx.vb"
    Inherits="DischargeSummary_Form" MasterPageFile="~/hacims_masterpage.master" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/jquery.UrduEditor.js" type="text/javascript"></script>
    <link href="../Scripts/JqueryUrduEditor.css" rel="stylesheet" />
    <link href="css/DischargeSummary.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        $(document).ready(function () {
            $("[id$='TextBox_Diagnosis_search']").keyup(function () {
                $("[id$='divMsg']").html("Message");
                $("[id$='BTN_SaveDiagnosis']").attr("disabled", "disabled");


            });
            $("[id$='BTN_SaveDiagnosis']").removeClass("btn_hacims");

            $("[id$='txtUrduInstruction']").UrduEditor().css("background", "#fff");
            $(".imgUrduBtn").hide();
            $(".imgEngBtn").hide();


            $(document).click("body", function () {
                $("[id$='divDischargeSummaryInstrutions']").hide();
            });
            if ($("#divPathologyTests input:checked").length == $("#divPathologyTests input[type='checkbox']").length - 1) {
                $("#divPathologyTests input:first").attr("checked", true);
            }
        });
        $(document).on("click", function () {
            $(".filter").hide();
        });
        //******************************* Instructions Section****************************//
        function filterInstructions() {

            var inst = $.trim($("[id$='txtInstructionsSearch']").val());
            $("[id$='divDischargeSummaryInstrutions']").hide();
            $("[id$='divDischargeSummaryInstrutions']").html("");

            if (inst.length >= 3) {
                $.post("Controls/Instructions_Filter.aspx", { EnglishInst: inst }).done(function (data) {

                    var response = data;
                    var start = data.indexOf("#StartInst") + 10;
                    var end = data.indexOf("#EndInst");
                    $("[id$='divDischargeSummaryInstrutions']").html(response.substring(start, end));
                    $("[id$='divDischargeSummaryInstrutions']").show();

                    if ($("[id$='divDischargeSummaryInstrutions']").find("table tr.clsInstructions").length == 0) {
                        $("[id$='divDischargeSummaryInstrutions']").hide();
                    }
                }).fail(function (mesg) {
                    if (mesg.responseText.indexOf("SessionOut") != -1) {
                        window.location = "../login.aspx";
                    }
                });
            }

        }
        function selectInstruction(elem) {
            $("[id$='tblInstructionsAdded'] tbody").append("<tr class='clsInstructions'>" + $(elem).html() + "</tr>");
            $("[id$='divDischargeSummaryInstrutions']").hide();
            $("[id$='divDischargeSummaryInstrutions']").html("");
            $("#tblInstructionsAdded").show();
        }
        function confirmChangeStatus(id) {

            var r = confirm("Do you want to change status?");
            if (r == true) {
                setTimeout("__doPostBack(\"ctl00$ContentPlaceHolder1$rptInstructions$ctl" + id + "$chkStatus\",\"\")", 0);
            } else {

                return false;
            }
        }
        function saveInstructions() {

            var engInst = $.trim($("[id$='txtEnglishInstruction']").val());
            var urduInst = $.trim($("[id$='txtUrduInstruction']").val());
            if (urduInst != "" || engInst != "") {
                $.post("Controls/DischargeSummarySegments.aspx", { EnglishIns: engInst, UrduIns: urduInst, Action: "Save HospitalInstructions" }).done(function (data) {

                    $("[id$='lblInstructionsMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);
                    var response = data;
                    var start = data.indexOf("#StartGetInstructions#") + 22;
                    var end = data.indexOf("#EndGetInstructions#");
                    $("#tbodyInstructions").html(response.substring(start, end));
                }).fail(function (mesg) {
                    if (mesg.responseText.indexOf("SessionOut") != -1) {
                        window.location = "../login.aspx";
                    }
                });
            }
            else {
                $("[id$='lblInstructionsMsg']").html("Please enter Instructions").css("color", "red").show().fadeOut(5000);
            }
        }
        function getInstructions() {
            $.post("Controls/DischargeSummarySegments.aspx", { Action: "Get HospitalInstructions" }).done(function (data) {
                var response = data;
                var start = data.indexOf("#StartGetInstructions#") + 22;
                var end = data.indexOf("#EndGetInstructions#");
                $("#tbodyInstructions").append(response.substring(start, end));
                $("#divInstructions").show();
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }
        function changeInstructinStatus(instId, elem) {
            if (window.confirm("Do you want to delete?")) {
                $.post("Controls/DischargeSummarySegments.aspx", { InstId: instId, Action: "Delete Instructions" }).done(function (data) {
                    $(elem).closest("tr").remove();
                }).fail(function (mesg) {
                    if (mesg.responseText.indexOf("SessionOut") != -1) {
                        window.location = "../login.aspx";
                    }
                });
            }
            else {
                $(elem).attr("checked", "checked");
            }

        }
        function addInstructionClick() {

            if ($.trim($("[id$='txtInstructionsSearch']").val()) != "") {
                var tblhtml = "<tr class='clsInstructions'>";
                tblhtml += "<td>" + $.trim($("[id$='txtInstructionsSearch']").val()) + "</td>";
                tblhtml += "<td></td>";
                tblhtml += "</tr>";

                $("[id$='tblInstructionsAdded'] tbody").append(tblhtml);
            }
        }
        function saveDischargeSummaryInstructions() {

            $("[id$='lblDischargeSummaryInstructionsMsg']").html("").hide();

            var instructionsArray = new Array();
            $("[id$='tblInstructionsAdded'] tr.clsInstructions").each(function () {
                var objInstruction = new Object();
                objInstruction.EngInstruction = $(this).find("td:eq(0)").html();
                objInstruction.UrduInstruction = $(this).find("td:eq(1)").html();

                instructionsArray.push(objInstruction);
            });

            $.post("Controls/DischargeSummarySegments.aspx", { InstructionsArray: JSON.stringify(instructionsArray), Action: "Save Instructions" }).done(function (data) {
                $("[id$='lblDischargeSummaryInstructionsMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);

                $("#tblInstructionsAdded tbody").html("");
                $("#tblInstructionsAdded").hide()

                var response = data;
                var start = data.indexOf("#StartGetDischargeInstructions#") + 31;
                var end = data.indexOf("#EndGetDischargeInstructions#");

                $("#tblDischargeSummaryInstructions").html(response.substring(start, end));
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }


        //******************************* Allerg and  Adverse Reaction Section****************************//
        function saveAllergy() {
            var allergy = "";

            $("#tableDischargeSummary input:checked").each(function () {

                allergy += $(this).next().text() + ",";
            });

            $.post("Controls/DischargeSummarySegments.aspx", { allergy: allergy, Action: "Save Allergy" }).done(function (data) {

                $("[id$='lblAllergyMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);
                var response = data;
                var start = data.indexOf("#StartAllergy#") + 14;
                var end = data.indexOf("#EndAllergy#");
                $("[id$='divAllergies']").html(response.substring(start, end));
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }
        function saveAdverseReaction() {
            $.post("Controls/DischargeSummarySegments.aspx", { Reaction: $.trim($("[id$='txtAdverseReaction']").val()), Action: "Save Reaction" }).done(function (data) {

                $("[id$='lblAllergyMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);
                var response = data;
                var start = data.indexOf("#StartReaction#") + 15;
                var end = data.indexOf("#EndReaction#");
                $("[id$='divAdverseReaction']").html(response.substring(start, end));
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }
        //******************************* Follow Up ****************************//
        function SaveFollowUp() {
            
            $.post("Controls/DischargeSummarySegments.aspx", { FollowUp: $("[id$='txtFollowup']").val(), Action: "Save Follow Up" }).done(function (data) {
                $("[id$='lblFollowUp']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);

            }).fail(function (Msg) {
                if (Msg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }
        //******************************* END ****************************//

        //******************************* Reason For Discharge ****************************//
        function SaveDischargeReason() {
            $.post("Controls/DischargeSummarySegments.aspx", { Parameter_Name: $("[id$='RBL_DischrageReason'] :checked").next().html(), Parameter_Value: $("[id$='RBL_DischrageReason'] :checked").val(), Action: "Save Discharge Reason" }).done(function (date) {
                $("[id$='lblReasonFroDischarge']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);

            }).fail(function (msg) {
                if (msg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }

        //******************************* END ****************************//

        //******************************* Complaint Section****************************//
        function saveComplaintRemarks() {
            $.post("Controls/DischargeSummarySegments.aspx", { CheifComplaint: $.trim($("[id$='ddlCheifComplaint'] :selected").text()), CheifComplaintRemarks: $.trim($("[id$='txtCheifComplaintRemarks']").val()), Action: "Save CheifComplaint" }).done(function (data) {
                $("[id$='lblComplaintMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);

                var response = data;
                var start = data.indexOf("#StartDischargeSumaryComplaints#") + 32;
                var end = data.indexOf("#EndDischargeSumaryComplaints#");
                $("#tbodyComplaintRemarks").html(response.substring(start, end));
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }

        function getCheifComplaintRemarks() {
            $.post("Controls/DischargeSummarySegments.aspx", { CheifComplaintId: $("[id$='ddlCheifComplaint']").val(), Action: "Get CheifComplaintRemarks" }).done(function (data) {

                var response = data;
                var start = data.indexOf("#StartComplaintRemarks#") + 23;
                var end = data.indexOf("#EndComplaintRemarks#");
                $("[id$='txtCheifComplaintRemarks']").val($("[id$='txtCheifComplaintRemarks']").val() + $.trim(response.substring(start, end)));
                checkCharacterLimit($("[id$='txtCheifComplaintRemarks']"));
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }

        //******************************* History Section****************************//
        function saveHistory() {

            $.post("Controls/DischargeSummarySegments.aspx", { History: $.trim($("[id$='ddlHistory'] :selected").text()), HistoryRemarks: $.trim($("[id$='txtHistoryRemarks']").val()), Action: "Save History" }).done(function (data) {

                $("[id$='lblHistoryMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);


                var response = data;
                var start = data.indexOf("#StartDischargeSumaryHistory#") + 29;
                var end = data.indexOf("#EndDischargeSumaryHistory#");
                $("#tbodyHistory").html(response.substring(start, end));
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }

        function getHistoryRemarks() {
            $.post("Controls/DischargeSummarySegments.aspx", { MgCode: $("[id$='ddlHistory']").val(), Action: "Get HistoryRemarks" }).done(function (data) {

                var response = data;
                var start = data.indexOf("#StartHistoryRemarks#") + 21;
                var end = data.indexOf("#EndHistoryRemarks#");
                $("[id$='txtHistoryRemarks']").val($("[id$='txtHistoryRemarks']").val() + $.trim(response.substring(start, end)));
                checkCharacterLimit($("[id$='txtHistoryRemarks']"));
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }

        //******************************* Pathology Tests Section****************************//
        function showTestsClick(divId) {
            $("#" + divId).toggle();
        }
        function closeTestWindow(divId) {
            $("#" + divId).toggle();
        }
        var _TestId = "";
        var _OrderId = "";
        function showPathologyTestResults() {
            if ($("#divPathologyTests input:checked").length == 0) {
                alert("Please select Test");
            }
            else {
                _TestId = "";
                _OrderId = "";
                $("#divPathologyTests input:checked").each(function () {
                    var idsArr = $(this).parent().attr("id").split('|');
                    if (idsArr[0] != 0) {
                        _TestId += idsArr[0] + ",";
                        _OrderId += idsArr[1] + ",";
                    }
                });

                $.post("Controls/DischargeSummarySegments.aspx", { TestId: _TestId, OrderId: _OrderId, Action: "Get Pathalogy Results" }).done(function (data) {
                    var response = data;
                    var start = data.indexOf("#StartLabortoryFindings#") + 24;
                    var end = data.indexOf("#EndLabortoryFindings#");
                    $("#divPathologyTestsResults").html(response.substring(start, end));

                    $("#btnSavePathologyTestResults").show();
                    $("#divPathologyTests").hide();
                }).fail(function (mesg) {
                    if (mesg.responseText.indexOf("SessionOut") != -1) {
                        window.location = "../login.aspx";
                    }
                });
            }
        }
        function pathalogyTestClicked(elem) {
            var chkId = $(elem).parent().attr("id").split('|');
            if (chkId[0] == 0) {
                if ($(elem).is(":checked")) {
                    $("#divPathologyTests input").attr("checked", true);
                }
                else {
                    $("#divPathologyTests input").attr("checked", false);
                }
            }
            else {
                if ($(elem).is(":checked")) {
                    if ($("#divPathologyTests input:checked").length == $("#divPathologyTests input[type='checkbox']").length - 1) {
                        $("#divPathologyTests input:first").attr("checked", true);
                    }
                }
                else {
                    $("#divPathologyTests input:first").attr("checked", false);
                }
            }
        }
        function savePathologyTestResults() {
            $.post("Controls/DischargeSummarySegments.aspx", { TestId: _TestId, OrderId: _OrderId, Action: "Save Pathalogy Results" }).done(function (data) {
                $("[id$='lblLabortoryFindingsMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);
                $("#btnSavePathologyTestResults").hide();
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }

        //******************************* Radiology Tests Section****************************//

        function getRadiologyTestResults(elem) {

            if ($(elem).is(":checked")) {
                var ids = $(elem).parent().attr("id").toString().split('|');
                var testId = ids[0];
                var orderId = ids[1];

                $.post("Controls/DischargeSummarySegments.aspx", { TestId: testId, OrderId: orderId, Action: "Get Radiology Results" }).done(function (data) {

                    var response = data;
                    var start = data.indexOf("#StartRadiologyTestResults#") + 27;
                    var end = data.indexOf("#EndRadiologyTestResults#");
                    $(elem).parent().find(".radiologyResults").html(response.substring(start, end));
                    $(elem).parent().find(".radiologyResultsWrappre").show();
                }).fail(function (mesg) {
                    if (mesg.responseText.indexOf("SessionOut") != -1) {
                        window.location = "../login.aspx";
                    }
                });
            }
            else {
                $(elem).parent().find(".radiologyResultsWrappre").hide();
            }
        }

        function saveRadiologyTestResults() {

            var radiologyResults = new Array();
            //var resultSelected = "";
            $("#divRadiologyTests input:checked").each(function () {

                var objradiologyResults = new Object();

                var testName = $(this).next().html();
                var testResult = $.trim($(this).parent().find("[id*='txtRadiologyTestResultSelected']").val());

                objradiologyResults.TestName = testName;
                objradiologyResults.TestResult = testResult;
                radiologyResults.push(objradiologyResults);


                //                resultSelected += "<div style='color: darkmagenta;font-weight: bold;'>" + testName + "</div>";
                //                resultSelected += "<div style='padding: 10px;'>" + testResult + "</div>";
            });

            $.post("Controls/DischargeSummarySegments.aspx", { RadiologyResults: JSON.stringify(radiologyResults), Action: "Save Radiology Results" }).done(function (data) {

                var response = data;
                var start = data.indexOf("#StartRadiologyFindings#") + 24;
                var end = data.indexOf("#EndRadiologyFindings#");
                $("#divRadiologyTestsResultsSelected").html(response.substring(start, end));

                closeTestWindow("divRadiologyTests");
                $("[id$='lblRadiologyFindingsMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }
        //******************************* Medications Section****************************//
        function saveMedication() {
            var objMedications = "";

            $("#tbodyMedications input:checked").each(function () {
                objMedications += $(this).parent().attr("id") + ",";
            });

            $.post("Controls/DischargeSummarySegments.aspx", { Medications: objMedications, Action: "Save Medications" }).done(function () {
                $("[id$='lblMedicationMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }
        //******************************* Summary ofcConsultation Section****************************//
        function saveSummaryofConsultation() {

            $.post("Controls/DischargeSummarySegments.aspx", { SummaryofConsultation: $.trim($("[id$='txtSummaryofConsultation']").val()), Action: "Save SummaryofConsultation" }).done(function () {

                $("[id$='lblSummaryofConsultationMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);
                //$("#DischargeSummaryConsultation").html($.trim($("[id$='txtSummaryofConsultation']").val()));
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }
        //******************************* Diagnosis Section****************************//
        function diagnoseSelected() {
            $("[id$='btnSavePtDiagnosis']").addClass("btn_hacims");
            $("[id$='btnSavePtDiagnosis']").removeAttr("disabled");
        }
        function saveDiagnosis() {


            var diagnosisArr = new Array();
            $("#tblDiagnosis tr").each(function () {

                if ($(this).find("[id*='chkAdmission']").is(":checked")) {
                    var objDiagnosis = new Object();
                    objDiagnosis.DiagnoseType = "Admission Diagnosis";
                    objDiagnosis.DiagnoseName = $(this).find("[id*='lblDiagnosisName']").html();
                    diagnosisArr.push(objDiagnosis);
                }
                if ($(this).find("[id*='chkDischarge']").is(":checked")) {
                    var objDiagnosis = new Object();
                    objDiagnosis.DiagnoseType = "Discharge Diagnosis";
                    objDiagnosis.DiagnoseName = $(this).find("[id*='lblDiagnosisName']").html();
                    diagnosisArr.push(objDiagnosis);
                }
            });
            $.post("Controls/DischargeSummarySegments.aspx", { DiagnosisArr: JSON.stringify(diagnosisArr), Action: "Save Diagnosis" }).done(function (data) {
                $("[id$='lblAdmissionDiagnosisMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);
                var response = data;
                var start = data.indexOf("#StartDiagnosis#") + 16;
                var end = data.indexOf("#EndDiagnosis#");
                $("#tblDischargeDiagnosis").html(response.substring(start, end));

            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }
        //****************************Procedure Section*******************************//
        function saveProcedures() {
            if ($("#tblProceduresAdded tr.clsProcedures").length > 0) {
                var proceduresArray = new Array();
                var addedhtml = "<tr>";
                $("#tblProceduresAdded tr.clsProcedures").each(function () {

                    var objProcedures = new Object();
                    objProcedures.ProceduresName = $.trim($(this).find("td:eq(0)").html());
                    objProcedures.ProceduresRemarks = $(this).find("td:eq(1) input").val();

                    addedhtml += "<td style='background-color: aliceblue; vertical-align: middle;'>" + objProcedures.ProceduresName + "</td>";
                    addedhtml += "<td  style='background-color: aliceblue; vertical-align: middle;'>" + objProcedures.ProceduresRemarks + "</td>";
                    addedhtml += "</tr>";

                    proceduresArray.push(objProcedures);
                });

                $.post("Controls/DischargeSummarySegments.aspx", { ProceduresArray: JSON.stringify(proceduresArray), Action: "Save Procedures" }).done(function () {

                    $("[id$='lblProcedureMsg']").html("Information saved successfully.").css("color", "green").show().fadeOut(5000);
                    $("#tblDischargeSummaryProcedures tbody").append(addedhtml);
                    $("#tblProceduresAdded tbody tr").remove();
                    $("#tblProceduresAdded").hide();
                }).fail(function (mesg) {
                    if (mesg.responseText.indexOf("SessionOut") != -1) {
                        window.location = "../login.aspx";
                    }
                });
            }
            else {
                $("[id$='lblProcedureMsg']").html("Please select Procedure").css("color", "red").show().fadeOut(5000);
            }
        }
        function filterProcedures() {
            var procedureName = $.trim($("[id$='txtFilterProcedure']").val());
            $("[id$='divProceduresFiltered']").hide();
            $("[id$='divProceduresFiltered']").html("");

            if (procedureName.length >= 3) {
                $.post("Controls/Procedures_Filter.aspx", { ProcedureName: procedureName }).done(function (data) {

                    var response = data;
                    var start = data.indexOf("#StartProcedureFilter#") + 22;
                    var end = data.indexOf("#EndProcedureFilter#");
                    $("[id$='divProceduresFiltered']").html(response.substring(start, end));
                    $("[id$='divProceduresFiltered']").show();

                    if ($("[id$='divProceduresFiltered']").find("table tr.clsProcedures").length == 0) {
                        $("[id$='divProceduresFiltered']").html("<div class='No-Recourd' style='padding: 10px;'>No Record Found</div>");
                    }
                }).fail(function (mesg) {
                    if (mesg.responseText.indexOf("SessionOut") != -1) {
                        window.location = "../login.aspx";
                    }
                });
            }
        }
        function selectProcedure(elem) {
            var html = "<tr class='clsProcedures'>" + $(elem).html();
            //html += "<td><input type='text' id='txtProcedureRemarks' class='input_txt' style='width:100%;'></textarea></td></tr>";

            $("#tblProceduresAdded tbody").append(html);
            $("[id$='divProceduresFiltered']").hide();
            $("[id$='divProceduresFiltered']").html("");
            $("#tblProceduresAdded").show();
        }
        //***********************************************************//
        function showInstructionPopUp() {
            getInstructions();
        }
        //****************************************************//
        function filterMedicine() {
            var medicineName = $.trim($("[id$='txtMedicineName']").val());
            $("[id$='divMedicineFilter']").hide();
            $("[id$='divMedicineFilter']").html("");


            if (medicineName.length >= 3) {
                $.post("Controls/Medications_Filter.aspx", { MedicineName: medicineName, Action: $("[id$='RadioButtonList_HospitalMed'] input:checked").next().text() }).done(function (data) {
                    var response = data;
                    var start = data.indexOf("#StartMedicineFilter#") + 21;
                    var end = data.indexOf("#EndMedicineFilter#");
                    $("[id$='divMedicineFilter']").html(response.substring(start, end));
                    $("[id$='divMedicineFilter']").show();

                    if ($("[id$='divMedicineFilter']").find("table tr.clsMedicine").length == 0) {
                        $("[id$='divMedicineFilter']").html("<div class='No-Recourd' style='padding: 10px;'>No Record Found</div>");
                    }
                }).fail(function (mesg) {
                    if (mesg.responseText.indexOf("SessionOut") != -1) {
                        window.location = "../login.aspx";
                    }
                });
            }
        }
        function selectMedicine(elem) {
            debugger;
            $("[id$='divMedicineFilter']").hide();
            $("[id$='divMedicineFilter']").html("");
            $("#hdnItemCode").val($.trim($(elem).find("td.ItemCode").html()));
            //$("#hdnDrugCategory").val($.trim($(elem).find("td.DrugCategory").html()));
            $("#txtMedicineName").val($.trim($(elem).find("td.MedicineName").html()));
            //getCategoryAndRoute();
        }

        function getCategoryAndRoute() {
            $.post("Controls/DischargeSummarySegments.aspx", { DrugCategory: $("#hdnDrugCategory").val(), ItemCode: $("#hdnItemCode").val(), Action: 'Get CategoryAndRoute' }).done(function (data) {
                var response = data;

                var start = data.indexOf("#StartGetCategory#") + 18;
                var end = data.indexOf("#EndGetCategory#");

                $("#hdnCategory").val($.trim(response.substring(start, end)));

                var start = data.indexOf("#StartGetRoute#") + 18;
                var end = data.indexOf("#EndGetRoute#");

                $("#divRoute").html($.trim(response.substring(start, end)));
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }
        function SaveDischargeMedications() {

            if ($("#hdnItemCode").val() == "") {
                $("[id$='lblDischargeMedicationMsg']").html("Please select Medication").css("color", "red").show().fadeOut(5000);
            }
            else if ($("[id$='DropDownList_frequencyName']").val() == "0") {
                $("[id$='lblDischargeMedicationMsg']").html("Please select Frequency").css("color", "red").show().fadeOut(5000);
            }
            else {
                var medCode = $("#hdnItemCode").val();
                var dosage = $("[id$='DropDownList_dosage']").val() == undefined ? "0" : $("[id$='DropDownList_dosage']").val();
                dosage = 1 + parseInt(dosage);

                var routeId = $("[id$='DropDownList_route']").val();
                var dilution = $("[id$='TextBox_dilution']").val() == undefined ? "" : $("[id$='TextBox_dilution']").val();
                dilution = dilution == "" ? "XX" : dilution;
                var meal = $("[id$='DropDownList_Meal']").val() == undefined ? "NA" : $("[id$='DropDownList_Meal']").val();
                var frequencyId = $("[id$='DropDownList_frequencyName']").val();
                var instruction = $("[id$='TextBoxInstruction']").val();
                var days = $("[id$='txtDays']").val();
                var startDate = $($("#tblDischargeMedication tr:eq(1)").find(".startDate input")[1]).val();
                var dose = "";
                var ct = "";
                if ($("[id$='CheckBox_CT']").is(":checked")) {
                    ct = "Continue Treatment";
                }
                else {
                    ct = "";
                }


                var duration = $("[id$='DropDownList_diution']").val() == undefined ? "" : $("[id$='DropDownList_diution']").val();
                var medicineAdviceCategoryID = $("[id$='DropDownList_Medicine_Advice_Category']").val() == undefined ? "" : $("[id$='DropDownList_Medicine_Advice_Category']").val();
                var medicationStatus = "";
                // if ($("[id$='chkMedicineStatus']").is(":checked")) {
                medicationStatus = "DM";
                //}
                //else {
                //    medicationStatus = "HM";
                //}

                //liFrequency
                var frequencyArr = new Array();
                $("#divFrequencyDetails table div.medbg").each(function () {

                    var objfrequency = new Object();
                    objfrequency.Dosage = $.trim($(this).find("[id$='TextBox_dosage2']").val());
                    objfrequency.FrequencySubId = $.trim($(this).find("[id$='HF_F_S_Id']").val());

                    frequencyArr.push(objfrequency)
                });

                $.post("Controls/DischargeSummarySegments.aspx", { MedCode: medCode, Dosage: dosage, RouteId: routeId, Dilution: dilution, Meal: meal, FrequencyId: frequencyId, Instruction: instruction, Days: days, StartDate: startDate, Dose: dose, CT: ct, Duration: duration, MedicineAdviceCategoryID: medicineAdviceCategoryID, MedicationStatus: medicationStatus, FrequencyArr: JSON.stringify(frequencyArr), chkMedicineStatus: $("[id$='chkMedicineStatus']").is(":checked"), Action: 'Save DischargeMedication' }).done(function (data) {
                    $("[id$='lblDischargeMedicationMsg']").html("Information save Successfully.").css("color", "green").show().fadeOut(5000);
                    $("#divFrequencyDetails").html("").hide();
                    $("#hdnItemCode").val("");
                    $("#txtMedicineName").val("");
                    $("[id$='TextBoxInstruction']").val("");
                    $("[id$='txtDays']").val("1");
                    $("[id$='DropDownList_frequencyName']").val("");

                    var response = data;
                    var start = data.indexOf("#StartPatientMedications#") + 25;
                    var end = data.indexOf("#EndPatientMedications#");

                    $("#divPatientMedications").html($.trim(response.substring(start, end)));

                }).fail(function (mesg) {
                    if (mesg.responseText.indexOf("SessionOut") != -1) {
                        window.location = "../login.aspx";
                    }
                });
            }
        }
        function getFrequenciesDetails() {
            $("[id$='TextBox_Frequency']").val("1");
            $.post("Controls/DischargeSummarySegments.aspx", { FrequencyId: $("[id$='DropDownList_frequencyName']").val(), Action: 'Get FrequenciesDetails' }).done(function (data) {
                var response = data;
                var start = data.indexOf("#StartFrequencyDetails#") + 23;
                var end = data.indexOf("#EndFrequencyDetails#");

                $("#divFrequencyDetails").html($.trim(response.substring(start, end)));
                //$("#divFrequencyDetails").show();
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });

        }
        function showHideFrequencyDetails() {

            if ($("#divFrequencyDetails").css('display') == "block") {
                $("#divFrequencyDetails").hide();
            }
            else {
                if ($("[id$='DropDownList_frequencyName']").val() == "0") {
                    $("[id$='lblDischargeMedicationMsg']").html("Please select Frequecy.").css("color", "red").show().fadeOut(5000);
                }
                else {
                    $.post("Controls/DischargeSummarySegments.aspx", { FrequencyId: $("[id$='DropDownList_frequencyName']").val(), Action: 'Get FrequenciesDetails' }).done(function (data) {
                        var response = data;
                        var start = data.indexOf("#StartFrequencyDetails#") + 23;
                        var end = data.indexOf("#EndFrequencyDetails#");

                        $("#divFrequencyDetails").html($.trim(response.substring(start, end)));
                        $("#divFrequencyDetails").show();
                    }).fail(function (mesg) {
                        if (mesg.responseText.indexOf("SessionOut") != -1) {
                            window.location = "../login.aspx";
                        }
                    });
                }
            }
        }

        //*********************************** Diagnosis********************************///
        function filterDiagnosis() {
            var diseaseName = $.trim($("#txtFilterDiagnosis").val());
            $("[id$='divFilterDiagnosis']").hide();
            $("[id$='divFilterDiagnosis']").html("");

            if (diseaseName.length >= 3) {
                $.post("Controls/Diagnosis_Filter.aspx", { DiseaseName: diseaseName }).done(function (data) {

                    var response = data;
                    var start = data.indexOf("#StartDiagnosiFilter#") + 21;
                    var end = data.indexOf("#EndDiagnosiFilter#");
                    $("[id$='divFilterDiagnosis']").html(response.substring(start, end));
                    $("[id$='divFilterDiagnosis']").show();

                    if ($("[id$='divFilterDiagnosis']").find("table tr.clsDiagnosis").length == 0) {
                        $("[id$='divFilterDiagnosis']").html("<div class='No-Recourd' style='padding: 10px;'>No Record Found</div>");
                    }
                }).fail(function (mesg) {
                    if (mesg.responseText.indexOf("SessionOut") != -1) {
                        window.location = "../login.aspx";
                    }
                });
            }

        }
        function selectDiagnose(elem) {
            $("[id$='divFilterDiagnosis']").hide();
            $("[id$='divFilterDiagnosis']").html("");
            $("#txtFilterDiagnosis").val("");

            $("#txtFilterDiagnosis").val($.trim($(elem).find("td.DiseaseCode").html()) + " " + $.trim($(elem).find("td.DiseaseName").html()));


        }
        function addDiagnose() {

            $.post("Controls/DischargeSummarySegments.aspx", { DiseaseName: $.trim($("#txtFilterDiagnosis").val()), Action: 'Add Diagnosis' }).done(function (data) {
                var response = data;
                var start = data.indexOf("#StartPatientDiagnosis#") + 23;
                var end = data.indexOf("#EndPatientDiagnosis#");

                $("#tblDiagnosis tbody").html($.trim(response.substring(start, end)));

            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }
        function closeInstructionsPopUp() {
            $("#tbodyInstructions").html("");
            $("[id$='txtEnglishInstruction']").val("");
            $("[id$='txtUrduInstruction']").val("");

            $("#divInstructions").hide();

        }
        //*********************************** Final********************************///
        function btnfinalClicked() {
            $.post("Controls/DischargeSummarySegments.aspx", { Action: 'Final' }).done(function (data) {
                $("#btnFinal").attr("disabled", "disabled").removeClass("btn_hacims").addClass("btn_hacims_disabled");
                $("#lblMsgFinal").html("Discharged Successfully.").css("color", "green").show().fadeOut(5000);
            }).fail(function (mesg) {
                if (mesg.responseText.indexOf("SessionOut") != -1) {
                    window.location = "../login.aspx";
                }
            });
        }

        function checkCharacterLimit(elem) {

            var txt = $.trim($(elem).val());
            if (txt.length > 3999) {
                $(elem).val(txt.substr(0, 3999));
                alert("Maximum character limit is 4000");
            }
        }

        $(document).ajaxStart(function () {
            $("#divloading").show();
        });
        $(document).ajaxStop(function () {
            $("#divloading").hide();
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
    <script type="text/javascript">
        $(document).ready(function () {

            $(".example_radiology").colorbox({ width: "1000px", height: "580px", iframe: true });
            $(".example_radiology1").colorbox({ onClosed: function () { window.location.reload(true); } });
            $(".example_diagnosis").colorbox({ width: "1000px", height: "580px", iframe: true });
            $(".example_diagnosis").colorbox({ onClosed: function () { window.location.reload(true); } });
            $(".example_medicine").colorbox({ width: "1000px", height: "580px", iframe: true });
            $(".example_medicine").colorbox({ onClosed: function () { window.location.reload(true); } });
            $(".example_pathology").colorbox({ width: "1000px", height: "580px", iframe: true });
            $(".example_pathology").colorbox({ onClosed: function () { window.location.reload(true); } });
            $(".example_vitals").colorbox({ width: "1000px", height: "580px", iframe: true });
            $(".example_vitals").colorbox({ onClosed: function () { window.location.reload(true); } });


        });
    </script>
    <style type="text/css">
        .bxinfo_margin {
            height: 250px;
            width: 87px;
        }

        .darkc {
            font-size: 9px;
            font-family: arial;
        }

        #nav {
            display: none;
        }

        .style1 {
            height: 14px;
        }

        .style2 {
        }

        .style3 {
            height: 14px;
            width: 499px;
        }

        .style4 {
            height: 14px;
            width: 775px;
        }

        .style5 {
            width: 775px;
        }

        .style6 {
            width: 356px;
        }

        .style7 {
            height: 14px;
            width: 286px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"
    EnableViewState="True" ClientIDMode="Inherit">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <h1>
        <b style="color: darkslateblue; padding: 15px;">Discharge Summary</b>
    </h1>
    <h1 style="display:none;" class="discharge-summary-title">
        <span>Follow Up</span></h1>
    <div class="divOPDEncounterContent" style="display:none;">
        <div class="div-msg">
            <asp:Label ID="lblFollowUp" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <div style="margin-left:5%">
            <table>
                <tr>
                    <td style="text-align:right"> Follow Up :</td>
                    <td width="35px">
                        <asp:TextBox ID="txtFollowup" runat="server" TextMode="Date"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: center; padding-top: 10px;">
            <input type="button" id="btnSaveFollowUp" value="Save" class="btn_hacims" onclick="SaveFollowUp();" />
        </div>
    </div>
    <h1 class="discharge-summary-title">
        <span>Reason for Discharge</span></h1>
    <div class="divOPDEncounterContent">
        <div class="div-msg">
            <asp:Label ID="lblReasonFroDischarge" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <div>
            <table>
                <tr>
                    <td style="text-align: right; width: 20%">Reason For Discharge :</td>
                    <td>
                        <asp:RadioButtonList ID="RBL_DischrageReason" runat="server" RepeatDirection="Horizontal" RepeatColumns="2">
                            <asp:ListItem Text="Normal Discharge With Improved Health" Value="1" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Leave With Request" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Leave Without Medical Advice" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Death" Value="4"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: center; padding-top: 10px;">
            <input type="button" id="btnSaveDischargeReason" value="Save" class="btn_hacims" onclick="SaveDischargeReason();" />
        </div>
    </div>
    <h1 class="discharge-summary-title">
        <span>Known Allergy / Other Adverse Reaction</span></h1>
    <div class="divOPDEncounterContent">
        <div style="text-align: center;">
            <asp:Label ID="lblAllergyMsg" runat="server" Style="color: Green; font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <table cellpadding="0" cellspacing="0" style="width: 100%;">
            <tr>
                <td>
                    <div class="knowAllergy">
                        Known Allergy
                    </div>
                </td>
                <td>
                    <div class="AdverseReaction">
                        Other Adverse Reaction
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 60%; padding-top: 10px;">
                    <div style="float: left; width: 40%;">
                        Allergic Reaction from
                    </div>
                    <asp:Panel ID="PanelAllergy" runat="server">
                        <div runat="server" style="float: left; width: 60%;">
                            <table id="tableDischargeSummary" class="tableDischargeSummary" cellpadding="0" cellspacing="0"
                                style="width: 100%;">
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkSulphonamides" runat="server" Text="Sulphonamides" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkNSAIDs" runat="server" Text="NSAIDs" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkFood" runat="server" Text="Food" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkPenicillins" runat="server" Text="Penicillins" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkAntiMalarials" runat="server" Text="Anti-Malarials" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkInsect" runat="server" Text="Insect" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkIgEMedication" runat="server" Text="IgE Medication" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkDrugs" runat="server" Text="Drugs" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkPollen" runat="server" Text="Pollen" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkHouseDust" runat="server" Text="House Dust" />
                                    </td>
                                </tr>
                            </table>
                            <div style="padding-top: 10px; text-align: center;">
                                <%-- <asp:Button ID="btnSaveAllergy" runat="server" Text="Save" />--%>
                                <input type="button" id="btnSaveAllergy" value="Save" class="btn_hacims" onclick="saveAllergy();" />
                            </div>
                        </div>
                    </asp:Panel>
                </td>
                <td style="padding-top: 10px;">
                    <asp:TextBox ID="txtAdverseReaction" TextMode="MultiLine" runat="server" Height="130px" onkeyup="checkCharacterLimit(this)"
                        Width="100%">
                    </asp:TextBox>
                    <div style="padding-top: 10px; text-align: center;">
                        <%-- <asp:Button ID="btnSaveAdverseReaction" runat="server" Text="Save" />--%>
                        <input type="button" id="btnSaveAdverseReaction" value="Save" class="btn_hacims"
                            onclick="saveAdverseReaction();" />
                    </div>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top;">
                    <h1 class="discharge-summary-subtitle" style="background-image: none; box-shadow: none; width: 90%;">
                        <span style="background-image: none; padding-left: 0; color: brown;">Known Allergy</span></h1>
                    <div id="divAllergies" runat="server" style="line-height: 25px;">
                    </div>
                </td>
                <td style="vertical-align: top;">
                    <h1 class="discharge-summary-subtitle" style="background-image: none; box-shadow: none; width: 95%;">
                        <span style="background-image: none; padding-left: 0; color: darkmagenta;">Other Adverse
                            Reaction</span></h1>
                    <div id="divAdverseReaction" runat="server" style="line-height: 25px;">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <h1 class="discharge-summary-title">
        <span>Cheif Complaint</span></h1>
    <div class="divOPDEncounterContent">
        <div style="float: left; width: 50%;">
            <asp:DropDownList ID="ddlCheifComplaint" onchange="getCheifComplaintRemarks();" runat="server">
            </asp:DropDownList>
        </div>
        <div style="float: left; width: 50%;">
            <asp:Label ID="lblComplaintMsg" runat="server" Style="color: Green; font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <div style="padding-top: 35px;">
            <asp:TextBox ID="txtCheifComplaintRemarks" runat="server" Height="120px" TextMode="MultiLine" onkeyup="checkCharacterLimit(this)"
                Width="100%"></asp:TextBox>
        </div>
        <div style="text-align: center; padding-top: 10px;">
            <%-- <asp:Button ID="btnSaveComplaintRemarks" runat="server" Text="Save" />--%>
            <input type="button" id="btnSaveComplaintRemarks" value="Save" class="btn_hacims"
                onclick="saveComplaintRemarks();" />
        </div>
        <div style="padding-top: 10px;">
            <table class="Grid_DischargeSummary" style="width: 100%;">
                <thead>
                    <tr>
                        <th style="width: 25%;">Complaint
                        </th>
                        <th>Remarks
                        </th>
                    </tr>
                </thead>
                <tbody id="tbodyComplaintRemarks">
                    <asp:Repeater ID="rptComplaintRemarks" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td style="background-color: aliceblue; vertical-align: middle; line-height: 25px;">
                                    <%# Eval("ParameterName") %>
                                </td>
                                <td style="background-color: aliceblue; vertical-align: middle; line-height: 25px;">
                                    <%# Eval("ParameterValue")%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
    <h1 class="discharge-summary-title">
        <span>History</span></h1>
    <div class="divOPDEncounterContent">
        <div style="float: left; width: 50%;">
            <asp:DropDownList ID="ddlHistory" onchange="getHistoryRemarks();" runat="server">
                <asp:ListItem Text="History of Present Illness" Value="97"></asp:ListItem>
                <asp:ListItem Text="Systemic History" Value="111"></asp:ListItem>
                <asp:ListItem Text="Past History" Value="110"></asp:ListItem>
                <asp:ListItem Text="Family History" Value="113"></asp:ListItem>
                <asp:ListItem Text="Allergy History" Value="117"></asp:ListItem>
                <asp:ListItem Text="Personal History" Value="95"></asp:ListItem>
                <asp:ListItem Text="Socio-Economic History" Value="119"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div style="float: left; width: 50%;">
            <asp:Label ID="lblHistoryMsg" runat="server" Style="color: Green; font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <div style="padding-top: 35px;">
            <asp:TextBox ID="txtHistoryRemarks" runat="server" Height="120px" TextMode="MultiLine" onkeyup="checkCharacterLimit(this)"
                Width="100%"></asp:TextBox>
        </div>
        <div style="text-align: center; padding-top: 10px;">
            <%--<asp:Button ID="btnSaveHistoryRemarks" runat="server" Text="Save" />--%>
            <input type="button" id="btnSaveHistoryRemarks" value="Save" class="btn_hacims" onclick="saveHistory();" />
        </div>
        <div style="padding-top: 10px;">
            <table class="Grid_DischargeSummary" style="width: 100%;">
                <thead>
                    <tr>
                        <th style="width: 25%;">History
                        </th>
                        <th>Remarks
                        </th>
                    </tr>
                </thead>
                <tbody id="tbodyHistory">
                    <asp:Repeater ID="rptHistory" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td style="background-color: aliceblue; vertical-align: middle; line-height: 25px;">
                                    <%# Eval("ParameterName") %>
                                </td>
                                <td style="background-color: aliceblue; vertical-align: middle; line-height: 25px;">
                                    <%# Eval("ParameterValue")%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
    <h1 class="discharge-summary-title">
        <span>Hospital Course</span></h1>
    <div class="divOPDEncounterContent">
        <div class="div-msg">
            <asp:Label ID="lblLabortoryFindingsMsg" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <h1 class="discharge-summary-subtitle" style="color: blueviolet;">Labortory   Findings
                <span onclick="showTestsClick('divPathologyTests');" class="show_icon"
                    style="float: right;">Show Tests</span>
        </h1>
        <div style="position: relative;">
            <div id="divPathologyTestsResults" style="padding-left: 20px;">
                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tbody>
                        <asp:Repeater ID="rptTestResultsOuter" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <h1 class="discharge-summary-subtitle">
                                            <span style="color: mediumseagreen; font-size: 14px;">
                                                <%# Eval("TestName") %></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="tableDischargeSummary" cellpadding="0" cellspacing="0" style="width: 100%;">
                                            <thead>
                                                <tr class="table-th">
                                                    <th style="text-align: left; width: 30%;">Component
                                                    </th>
                                                    <th style="text-align: left; width: 25%;">Results
                                                    </th>
                                                    <th style="text-align: left; width: 25%;">Ref. Value
                                                    </th>
                                                    <th style="text-align: left; width: 20%;">Unit
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptTestResultsInner" runat="server" DataSource='<%#Container.DataItem.Row.GetChildRows("results")%>'>
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <%#Container.DataItem("ComponentName")%>
                                                            </td>
                                                            <td>
                                                                <%#Container.DataItem("PatientValue")%>
                                                            </td>
                                                            <td>
                                                                <%#Container.DataItem("RefValue")%>
                                                            </td>
                                                            <td>
                                                                <%#Container.DataItem("Unit")%>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
            <div style="text-align: center; padding-top: 10px;">
                <input type="button" id="btnSavePathologyTestResults" class="btn_hacims" value="Save" onclick="savePathologyTestResults()" style="display: none;" />
            </div>
            <div id="divPathologyTests" class="divTests" style="display: none; width: 400px; max-height: 300px;">
                <span class="close-icon" onclick="closeTestWindow('divPathologyTests');" style="position: absolute; top: 5px; right: 5px;"></span>
                <asp:Repeater ID="rptPathologyTests" runat="server">
                    <ItemTemplate>
                        <div id='<%# Eval("TestId")%>|<%# Eval("Order_Id")%>' style="padding: 5px;">
                            <asp:CheckBox ID="chkTest" runat="server" Text='<%# Eval("TestName")%>' onClick="pathalogyTestClicked(this)" />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div style="width: 100%; text-align: center;">
                    <input type="button" class="btn_hacims" value="Show Results" onclick="showPathologyTestResults()" />
                </div>
            </div>
        </div>
        <h1 class="discharge-summary-subtitle" style="color: brown; display: none">Radiology Findings
            <span onclick="showTestsClick('divRadiologyTests');" class="show_icon" style="float: right;">Show Tests</span>
        </h1>
        <div class="div-msg" style="display: none">
            <asp:Label ID="lblRadiologyFindingsMsg" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <div style="position: relative; width: 100%; display: none">
            <div id="divRadiologyTestsResultsSelected" style="padding: 0 2%;">
                <asp:Repeater runat="server" ID="rptRadiologyFindings">
                    <ItemTemplate>
                        <div style="padding-bottom: 10px; font-size: 13px;">
                            <span style="font-weight: bold; color: darkmagenta;"><%# Eval("ParameterName") %>:</span>
                            <%# Eval("ParameterValue") %>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div id="divRadiologyTests" class="divTests" style="display: none; max-width: 700px;">
                <span class="close-icon" onclick="closeTestWindow('divRadiologyTests');" style="position: absolute; top: 5px; right: 5px;"></span>
                <asp:Repeater ID="rptRadiologyTests" runat="server">
                    <ItemTemplate>
                        <div id='<%# Eval("TestId")%>|<%# Eval("Order_Id")%>' style="padding: 5px;">
                            <asp:CheckBox ID="chkTest" runat="server" onclick="getRadiologyTestResults(this);"
                                Text='<%# Eval("TestName")%>' />
                            <div class="radiologyResultsWrappre" style="width: 685px; max-height: 300px; overflow-y: auto; display: none; padding: 10px;">
                                <div class="radiologyResults" style="width: 100%;">
                                </div>
                                <div style="padding-top: 10px; margin-bottom: 10px; width: 100%;">
                                    <asp:TextBox ID="txtRadiologyTestResultSelected" runat="server" TextMode="MultiLine"
                                        Style="height: 100px; width: 99%;"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div style="width: 100%; text-align: center; padding-top: 10px;">
                    <input type="button" class="btn_hacims" value="Save" onclick="saveRadiologyTestResults()" />
                </div>
            </div>
        </div>
        <h1 class="discharge-summary-subtitle" style="color: navy; padding-top: 10px;">Medication
        </h1>
        <div class="div-msg">
            <asp:Label ID="lblMedicationMsg" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <div style="padding-top: 10px; width: 100%;">
            <table style="width: 100%; border: dotted 1px #ddd; border-radius: 3px; padding: 5px; line-height: 22px; width: 85%; margin: 0 auto;">
                <tbody id="tbodyMedications">
                    <asp:Repeater ID="rptMedications" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%# Eval("MedicineName")%>
                                </td>
                                <td>
                                    <%# Eval("ParaUrdu")%>
                                </td>
                                <td>
                                    <%# Eval("StartDate")%>
                                    -
                                    <%# Eval("EndDate")%>
                                </td>
                                <td style="text-align: center;">
                                    <div id='<%# Eval("Priscriptionid")%>' style="padding: 5px;">
                                        <asp:CheckBox ID="chkPriscription" runat="server" />
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <div style="text-align: center; padding-top: 10px;">
                <input type="button" class="btn_hacims" value="Save" onclick="saveMedication()" />
            </div>
        </div>
        <h1 class="discharge-summary-subtitle" style="color: forestgreen">Clinical Narrative / Information Given To Patient
        </h1>
        <div class="div-msg">
            <asp:Label ID="lblSummaryofConsultationMsg" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <div style="padding-top: 10px; width: 100%;">
            <asp:TextBox ID="txtSummaryofConsultation" Height="120px" Width="100%" runat="server"
                TextMode="MultiLine"></asp:TextBox>
            <div style="text-align: center; padding-top: 10px;">
                <input type="button" class="btn_hacims" value="Save" onclick="saveSummaryofConsultation()" />
            </div>
        </div>
        <h1 class="discharge-summary-subtitle" style="color: mediumvioletred;">Procedure
        </h1>
        <div class="div-msg">
            <asp:Label ID="lblProcedureMsg" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <div style="float: left; width: 100%;">
            <div style="float: left; width: 25%;">
                <asp:TextBox ID="txtFilterProcedure" runat="server" onkeyup="filterProcedures()"
                    Style="width: 90%;"></asp:TextBox>
            </div>

        </div>
        <div id="divProceduresFiltered" class="filter" style="display: none; margin-top: 27px;">
        </div>
        <div style="padding: 10px 0; text-align: center; float: left; width: 100%;">
            <table id="tblProceduresAdded" class="Grid_DischargeSummary" style="width: 100%; display: none;">
                <thead>
                    <tr>
                        <th style="width: 50%;">Procedure Name
                        </th>
                        <%--<th>Remarks
                        </th>--%>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div style="padding-top: 10px; width: 100%;">
            <div style="text-align: center; padding-top: 10px;">
                <input type="button" class="btn_hacims" value="Save" onclick="saveProcedures()" />
            </div>
        </div>
        <div style="padding-top: 10px; width: 100%;">
            <table id="tblDischargeSummaryProcedures" class="Grid_DischargeSummary" style="width: 100%;">
                <thead>
                    <tr>
                        <th style="width: 50%;">Procedure Name
                        </th>
                        <%--<th>Remarks
                        </th>--%>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptProcedure" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td style="background-color: aliceblue; vertical-align: middle;">
                                    <%# Eval("ParameterName") %>
                                </td>
                                <%--<td style="background-color: aliceblue; vertical-align: middle;">
                                    <%# Eval("ParameterValue")%>
                                </td>--%>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
    <h1 class="discharge-summary-title">
        <span>Plan Of Care</span></h1>
    <div class="divOPDEncounterContent">
        <div>
            <asp:Label ID="lblPocMsg" runat="server" Style="color: Green; font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <h1 class="discharge-summary-subtitle">
            <span style="background-image: none; padding-left: 0; color: indigo; float: left; width: 50%;">Hospital Discharge Medication</span> <span style="float: left;">
                <asp:Label ID="lblDischargeMedicationMsg" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
            </span>
        </h1>
        <div style="display: none">
            <asp:TextBox ID="TextBox_Medicine" runat="server" Height="1px" Visible="false" Width="1px"></asp:TextBox>&nbsp;
            <div style="float: left;">
                <asp:RadioButtonList ID="RadioButtonList_HospitalMed" runat="server" RepeatColumns="2">
                    <asp:ListItem Selected="True" Value="0">All</asp:ListItem>
                    <asp:ListItem Value="1">Hospital Stock</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div style="padding: 5px 25px; float: left; font-size: 15px;">
                <asp:CheckBox ID="chkMedicineStatus" runat="server" Text="Discharge Medication" />
            </div>
        </div>
        <table cellpadding="0" cellspacing="0" style="width: 100%;">
            <tr>
                <td>
                    <table id="tblDischargeMedication" class="Grid_DischargeSummary" cellpadding="0"
                        cellspacing="0" width="100%" style="margin-left: 7px;">
                        <tr>
                            <th align="center" style="width: 244px">Name
                            </th>
                            <th align="center">Route
                            </th>
                            <th align="center">Frequency
                            </th>
                            <th align="center">Days
                            </th>
                            <th align="center">Start Date
                            </th>
                            <th align="center" colspan="1">Comments
                            </th>
                            <th align="center" colspan="1">Store Stock
                            </th>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 244px">
                                <input type="text" id="txtMedicineName" style="width: 99%;" onkeyup="filterMedicine();" />
                                <input type="hidden" id="hdnItemCode" />
                                <input type="hidden" id="hdnDrugCategory" />
                                <input type="hidden" id="hdnCategory" />
                                <asp:Label ID="Label1" CssClass="red" runat="server"></asp:Label>
                                <div id="divMedicineFilter" class="filter" style="display: none; margin-top: 4px;">
                                </div>
                            </td>
                            <td valign="top">
                                <div id="divRoute">
                                    <asp:DropDownList ID="DropDownList_route" runat="server" AutoPostBack="true"
                                        Width="60px">
                                        <asp:ListItem Text="Oral" Value="4" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="I/V" Value="5"></asp:ListItem>
                                        <asp:ListItem Text="N/G" Value="6"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <asp:DropDownList ID="DropDownList_dosage" runat="server"
                                    Width="75px" Visible="False">
                                </asp:DropDownList>
                            </td>
                            <td valign="top">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                    <tr>
                                        <td style="border: none;">
                                            <asp:DropDownList ID="DropDownList_frequencyName" runat="server" onchange="getFrequenciesDetails()"
                                                DataSourceID="SqlDataSource_frequency" DataTextField="Name" DataValueField="id"
                                                Width="100px">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="border: none;">
                                            <asp:TextBox ID="TextBox_Frequency" runat="server" Style="width: 20px;">1</asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <div onclick="showHideFrequencyDetails();" style="background-image: url('../images_hacims/add.png'); height: 16px; width: 15px; display: block; float: right; background-repeat: no-repeat; background-position-y: 5px; cursor: pointer;">
                                </div>
                                <div id="divFrequencyDetails" style="display: none; width: 100%;">
                                </div>
                            </td>
                            <td align="center" valign="top">
                                <input type="text" id="txtDays" value="1" style="width: 20px;" />
                                <asp:CheckBox ID="CheckBox_CT" runat="server" Text="CT" Visible="False" />
                            </td>
                            <td valign="top" style="border: none;">
                                <igsch:WebDateChooser ID="WebDateChooserStartDate" runat="server" CssClass="startDate drop_date"
                                    Width="100px" Value="2008-01-16">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                                <igsch:WebDateChooser ID="WebDateChooserEndDate" CssClass="EndDate drop_date" Visible="false"
                                    runat="server" Value="2010-06-17" Width="100px">
                                    <AutoPostBack ValueChanged="True" />
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                            <td valign="top" style="width: 374px">
                                <asp:DropDownList ID="DropDownList_Meal" runat="server" Visible="false" Width="87px">
                                    <asp:ListItem Value="NA">.NA</asp:ListItem>
                                    <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                    <asp:ListItem Value="After Meal">After</asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="TextBoxInstruction" runat="server" CssClass="input_txt" Width="99%"></asp:TextBox>
                                <asp:DropDownList ID="DropDownList_Medicine_Advice_Category" runat="server" Visible="false">
                                </asp:DropDownList>
                                <asp:DropDownList ID="DropDownList_diution" runat="server" Width="65px" Visible="False">
                                </asp:DropDownList>
                                <asp:TextBox ID="TextBox_dilution" CssClass="input_txt" runat="server" Width="25px"
                                    Visible="False"></asp:TextBox>
                                <asp:Label ID="Label_Dilution" runat="server" Text="Dilution" Visible="False"></asp:Label>
                            </td>
                            <td valign="top">
                                <asp:Label ID="Label_Stock" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="text-align: center; padding: 10px 0;">
                    <input type="button" id="btnSaveDischargeMedications" class="btn_hacims" onclick="SaveDischargeMedications();"
                        value="Save" />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div id="divPatientMedications">
                        <asp:DataList ID="DataList_ConfirmedPrescriptions" runat="server" Style="margin-left: 15px" Width="100%" Height="16px">
                            <ItemTemplate>
                                <ul class="medication_cnt">
                                    <li style="border-right: 0; border-left: 0;">
                                        <%--<strong class="mname">
                                        <%# Eval("[Medicine Name]") %>
                                        <span style="padding-left:10px;color:#004393;"><%#Eval("Para")%></span>
                                        
                                    </strong>--%>
                                        <span style="font-weight: bold; color: #000;"><%#Eval("Medication")%></span>
                                    </li>
                                </ul>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <h1 class="discharge-summary-title">
        <span>Hospital Admission Diagnosis</span></h1>
    <div class="divOPDEncounterContent">
        <div class="div-msg">
            <asp:Label ID="lblAdmissionDiagnosisMsg" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <div style="padding-top: 15px;">
            <strong>Diagnosis
                <input type="text" id="txtFilterDiagnosis" onkeyup="filterDiagnosis();" style="width: 300px;" />
            </strong>
            <input type="button" id="btnSavePtDiagnosis" class="btn_hacims" onclick="addDiagnose();"
                value="Add" />
        </div>
        <div id="divFilterDiagnosis" class="filter" style="margin-top: 5px; margin-left: 58px;">
        </div>
        <div style="padding-top: 15px; margin-left: 30px;">
            <table id="tblDiagnosis" style="width: 60%; border: none;">
                <tbody>
                    <asp:Repeater ID="rptDiagnosis" runat="server">
                        <ItemTemplate>
                            <tr style="line-height: 25px;">
                                <td style="border-bottom: dotted 1px #ccc;">
                                    <strong>
                                        <asp:Label ID="lblDiagnosisName" runat="server" Text='<%# Eval("[ICD Name]") %>'></asp:Label>
                                    </strong>
                                </td>
                                <td>
                                    <span style="padding-left: 20px;">
                                        <asp:CheckBox ID="chkAdmission" runat="server" Text="Admission Diagnosis" />
                                        <asp:CheckBox ID="chkDischarge" runat="server" Text="Discharge Diagnosis" />
                                    </span>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
        <div style="padding-top: 10px; text-align: center;">

            <input type="button" id="btnSaveDiagnosis" value="Save" class="btn_hacims" onclick="saveDiagnosis();" />
        </div>
        <div style="padding-top: 10px; margin-left: 40px;">
            <table class="Grid_DischargeSummary" cellpadding="0" cellspacing="0" style="width: 50%;">
                <thead>
                    <tr class="table-th">
                        <th>Diagnosis
                        </th>
                        <th style="width: 200px;">Type
                        </th>
                    </tr>
                </thead>
                <tbody id="tblDischargeDiagnosis">
                    <asp:Repeater ID="rptDischargeSummaryDiagnosis" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td style="background-color: aliceblue; vertical-align: middle;">
                                    <%# Eval("ParameterName") %>
                                </td>
                                <td style="background-color: aliceblue; vertical-align: middle;">
                                    <%# Eval("MainCategory")%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
    <h1 class="discharge-summary-title">
        <span>Further Treatment Plan / Discharge Instructions</span></h1>
    <div class="divOPDEncounterContent">
        <div class="div-msg">
            <asp:Label ID="lblDischargeSummaryInstructionsMsg" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
        </div>
        <div style="float: left; width: 100%;">
            <div style="float: left; width: 25%;">
                <asp:TextBox ID="txtInstructionsSearch" runat="server" onkeyup="filterInstructions()"
                    Style="width: 90%;"></asp:TextBox>
            </div>
            <div style="float: left; padding: 2px 0 0 5px;">
                <span onclick="addInstructionClick()" style="color: Blue; font-size: 15px; font-weight: bold; cursor: pointer; padding-right: 25px;">Add</span> <span class="add_icon" onclick="showInstructionPopUp();"
                    style="cursor: pointer;">Add</span>
            </div>
        </div>
        <div id="divDischargeSummaryInstrutions" class="filter" style="margin-top: 27px">
        </div>
        <div style="padding: 10px 0; text-align: center; float: left; width: 100%;">
            <table id="tblInstructionsAdded" class="Grid_DischargeSummary" style="width: 100%; display: none;">
                <thead>
                    <tr>
                        <th style="width: 50%;">English
                        </th>
                        <th>Urdu
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div style="text-align: center; padding-bottom: 10px; float: left; margin: 0 auto; width: 100%;">
            <input type="button" id="btnSaveDischargeSummaryInstructions" value="Save" class="btn_hacims"
                onclick="saveDischargeSummaryInstructions();" />
        </div>
        <div style="padding: 10px 0; float: left; width: 100%;">
            <table class="Grid_DischargeSummary" style="width: 100%;">
                <thead>
                    <tr class="table-th">
                        <th>Instructions
                        </th>
                    </tr>
                </thead>
                <tbody id="tblDischargeSummaryInstructions">
                    <asp:Repeater runat="server" ID="rptDischargeInstruction">
                        <ItemTemplate>
                            <tr>
                                <td style="background-color: aliceblue; vertical-align: middle;">
                                    <%# Eval("ParameterValue") %>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>

    <div style="text-align: center;">

        <div class="div-msg">
            <asp:Label ID="lblMsgFinal" Style="font-size: 15px; padding: 15px; font-weight: bold;"></asp:Label>
        </div>
        <input type="button" id="btnFinal" value="Final Discharge Summary" runat="server" onclick="btnfinalClicked();" />
    </div>
    <div id="divloading" style="display: none;">
    </div>
    <div id="divInstructions" class="popup-wrapper" style="display: none;">
        <div class="popup-inner">
            <h1 class="popup-header">Instructions</h1>
            <div class="div-msg">
                <asp:Label ID="lblInstructionsMsg" runat="server" Style="font-size: 15px; font-weight: bold;"></asp:Label>
            </div>
            <div style="padding: 10px 0;">
                <div style="padding-bottom: 5px;">
                    English Instructions:
                </div>
                <asp:TextBox TextMode="MultiLine" ID="txtEnglishInstruction" runat="server" Style="height: 60px; width: 100%"></asp:TextBox>
            </div>
            <div class="urdurEditorWrapper" style="padding: 10px 0; position: relative;">
                <div style="padding-bottom: 5px;">
                    Urdu Instructions:
                </div>
                <asp:TextBox TextMode="MultiLine" ID="txtUrduInstruction" runat="server" Style="height: 60px; width: 100%"></asp:TextBox>
                <div class="divKeyboardIcon" style="position: absolute; top: 3px; left: 105px;"></div>
            </div>
            <div style="padding: 10px 0; text-align: center;">
                <%-- <asp:Button ID="btnSaveInstructions" runat="server" Text="Save" />    --%>
                <input type="button" class="btn_hacims" value="Save" onclick="saveInstructions();" />
                &nbsp; &nbsp;
                <input type="button" class="btn_hacims" value="Close" onclick="closeInstructionsPopUp();" />
            </div>
            <div style="width: 100%; height: 130px; overflow-y: auto;">
                <table class="Grid_DischargeSummary" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>English
                            </th>
                            <th>Urdu
                            </th>
                            <th>Status
                            </th>
                        </tr>
                    </thead>
                    <tbody id="tbodyInstructions">
                    </tbody>
                </table>
            </div>
        </div>
    </div>



    <%--
    <asp:SqlDataSource ID="SqlDataSource_Confirmed_Prescriptions" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        SelectCommand="Select_Med_Presc_Urdu" DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
        </SelectParameters>
      
    </asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="SqlDataSource_frequency" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT '' AS id,'' AS Name,0 AS count union SELECT     id, Name + ' (' + Occasion + ')' AS Name, CASE WHEN dbo.ufn_CountChar(Occasion, '+') > 0 THEN dbo.ufn_CountChar(Occasion, '+') ELSE 1000 END AS count&#13;&#10;FROM         Medicine_Frequency&#13;&#10;WHERE     (IS_Available = 1)"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"></asp:SqlDataSource>

</asp:Content>
