<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="Test.aspx.vb" Inherits="Test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width=100% border=0 cellpadding=0 cellspacing=0 class=tbl_form>
        <tr><td width=25% ></td><td width=25%></td><td width=25%></td><td width=25%></td></tr>
        <tr><td align=right >Visit # :</td><td >TextBoxYearlyNo
            </td><td align=right>Patient First Name :</td>
            TextBoxPFName
        </td></tr><tr><td align=right>MR # : </td><td >
        TextBoxRegNo
        </td><td align=right>Patient Middle Name : </td><td >
        TextBoxPMName

        </td></tr><tr><td align=right>Patient Age :</td><td align=left>
            <table border=0 cellpadding=0 cellspacing=0><tr><td align=left>
        TextBoxAge0
        </td><td align=left>
        DropDownListAgeType

        </td></tr></table>

        </td></tr><tr><td align=right>Patient Age : </td><td>
        TextBoxAge
        </td></tr><tr><td align=right>Patient Age : </td><td>
        TextBoxAge

        </td><td align=right>Patient Last Name : </td><td >
        TextBoxPLName

        </td></tr><tr><td align=right>Registration Date : </td><td >
        Draw_Date("WebDateChooser1", 114, P1)


        </td><td align=right>Father Name : </td><td >
        TextBoxRelation
        </td><td align=right>Relation First Name :</td><td>
        TextBoxRFName
        </td><tr><td align=right>  </td><td>

        </td><tr><td align=right>Shift : </td><td>
        Draw_RadioButtonList("RadioButtonList_Shift
        </td><td align=right>Relation Middle Name : </td><td>
        TextBoxRMName
        </td></tr><tr><td align=right>CNIC # : </td><td >
        TextBoxCNIC
        </td><td align=right>Relation Last Name : </td><td >
        </td></tr><tr><td align=right>Mobile # : </td><td >
        TextBoxPhone
        </td><td align=right>Relation Last Name : </td><td >
        </td></tr><tr><td align=right>Mobile #</td><td></td> <td align=right>Relation Last Name :</td><td>
        TextBoxRLName
        </td></tr><tr><td></td></tr></table>
    </table>

</asp:Content>

