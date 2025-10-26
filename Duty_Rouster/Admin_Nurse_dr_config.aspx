<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Admin_Nurse_dr_config, App_Web_eqmkimbh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



<script language = "javascript" type ="text/javascript" >
function checkrequired(a)
{
        var Hour = document.getElementById("TextBoxShiftDuration").value;
        var Min = document.getElementById("TextBoxMin").value;
        var shift = document.getElementById("TextBoxShiftName").value;
    if(document.getElementById("TextBoxShiftDuration").value.length==0)
        {
        alert("Enter Shift Duration Hours");
        document.getElementById("TextBoxShiftDuration").focus();
        return false;
        }
    if(document.getElementById("TextBoxShiftName").value.length==0)
        {
        alert("Enter Shift Name");
        document.getElementById("TextBoxShiftName").focus();
        return false;
        }
    if(document.getElementById("TextBoxMin").value.length==0)
        {
        alert("Enter Shift Duration Minutes");
        document.getElementById("TextBoxMin").focus();
        return false;
        }
    if(Hour -0 !=Hour)
        {
        alert("Enter the Integer Only In Hours");
        document.getElementById("TextBoxShiftDuration").focus();
        return false;
        }
//        if((PMName.length-0) != 0)
//        {
 //               if(PMName -0 ==PMName) 
   //             {
     //           alert("Enter the Correct Patient Middle Name");
       //         document.getElementById("textboxpmname").focus();
         //       return false;
           //     }        
           // }
    
    if(Min -0 !=Min)
        {
        alert("Enter the Correct Minute Only Integer");
        document.getElementById("TextBoxMin").focus();
        return false;
        }
    if(shift -0 ==shift)
        {
        alert("Enter the Valid Shift Name");
        document.getElementById("TextBoxShiftName").focus();
        return false;
        }
//    if((shift.length-0) !=RMName)
  //      {
    //           if(RMName -0 ==RMName) 
      //          {
        //        alert("Enter the Correct Patient Relation Middle Name");
          //      document.getElementById("textboxrmname").focus();
            //    return false;
              //  } 
                // }


}



</script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="bxmain">
<table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
    <tr>
        <td align="right" style="height: 18px" width="40%">
            Designation :</td>
        <td style="height: 18px" width="60%">
            <asp:DropDownList ID="DropDownList_Dsgn" runat="server" DataSourceID="SqlDataSource_Dept_Dsgn"
                DataTextField="Designation_Name" DataValueField="Designation_id" Width="200px">
            </asp:DropDownList></td>
    </tr>
                <tr>
                    <td  width="40%" align="right" style="height: 18px"  >
                      Shift Name :</td>
                    <td width="60%" style="height: 18px"  >
                        <asp:DropDownList ID="DropDownListShift" runat="server" DataSourceID="SqlDataSourceShift"
                            DataTextField="ShiftName" DataValueField="ShiftID" Width="200px" >                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td align="right" style="height: 18px"  >
                        No of Days :</td>
                    <td style="height: 18px" >
                        &nbsp;<asp:TextBox ID="TextBox_Days" runat="server" MaxLength="2" Width="19px">00</asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBox_Days"
                            ErrorMessage="Invalid Range" MaximumValue="24" MinimumValue="0"></asp:RangeValidator></td>
                </tr>
                <tr>
                    <td align="right" style="height: 18px" >
                        Weekly Rest :</td>
                    <td align="left" style="height: 18px" >
                        &nbsp;<asp:TextBox ID="TextBox_Holidays" runat="server" MaxLength="2" Width="19px">00</asp:TextBox>Days</td>
                </tr>
                <tr>
                    <td align="right" style="height: 18px">
                      </td>
                    <td style="height: 18px" >
                        &nbsp;<asp:Button ID="ButtonSave" runat="server" Text="Save"    /></td>
                </tr>
                <tr>
                    <td align="right" style="height: 18px">
                      </td>
                    <td style="height: 18px" >
                        </td>
                </tr>
                
                <tr>
                    <td >                    </td>
                    <td >&nbsp;
                        </td>
                </tr>
            </table></div>
<br />
<asp:GridView ID="GridViewDutyRouster" runat="server" AutoGenerateColumns="False"
                AutoGenerateDeleteButton="True"   CssClass="Grid_1" DataSourceID="SqlDataSourceSaveInfo"
                Width="100%" DataKeyNames="ID">
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                <Columns>
                    <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
                    <asp:BoundField DataField="ShiftName" HeaderText="ShiftName" SortExpression="ShiftName" />
                    <asp:BoundField DataField="Days" HeaderText="Days" SortExpression="Days" />
                    <asp:BoundField DataField="Off_Days" HeaderText="Off Days" SortExpression="Off_Days" />
                </Columns>
    </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceShiftName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT Department.Dept_Name, SubDepartment.SubDept_Name, Admin_Shift.ShiftName, CONVERT (varchar, Admin_DutyRoster.StartTime, 108) AS start_Time, CONVERT (varchar, Admin_DutyRoster.EndTime, 108) AS End_Time, Admin_DutyRouster.Duty_Rouster_ID FROM Admin_DutyRouster INNER JOIN Department ON Admin_DutyRouster.DeptID = Department.Dept_ID INNER JOIN SubDepartment ON Admin_DutyRouster.SubDeptId = SubDepartment.SubDept_Id INNER JOIN Admin_Shift ON Admin_DutyRouster.Shift_ID = Admin_Shift.ShiftID" DeleteCommand="DELETE FROM Admin_DutyRouster WHERE (Duty_Rouster_ID = @Duty_Rouster_ID)">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridViewDutyRouster" Name="Duty_Rouster_ID" PropertyName="SelectedValue" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenFieldFlag" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource_Dept_Dsgn" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="Select_Dept_Designation" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter DefaultValue="183" Name="dept_id" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
    &nbsp;
            <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" InsertCommand="INSERT INTO [BasicDataInfo].[dbo].[Admin_Nurse_Roster_Config]&#13;&#10;           ([Dsgn_id]&#13;&#10;           ,[Shift_id]&#13;&#10;           ,[Days]&#13;&#10;           ,[Off_Days])&#13;&#10;     VALUES&#13;&#10;           (@Dsgn_id&#13;&#10;           ,@Shift_id&#13;&#10;           ,@Days&#13;&#10;           ,@Off_Days)" DeleteCommand="Delete Admin_Nurse_Roster_Config where id=@ID" SelectCommand="Select_NurseDutyRoster_DsgnWise" SelectCommandType="StoredProcedure">
                <InsertParameters>
                    <asp:ControlParameter ControlID="DropDownList_Dsgn" Name="Dsgn_id" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownListShift" Name="Shift_id" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="TextBox_Days" Name="Days" PropertyName="Text" />
                    <asp:ControlParameter ControlID="TextBox_Holidays" Name="Off_Days" PropertyName="Text" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList_Dsgn" Name="Dsgn_id" PropertyName="SelectedValue"
                        Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridViewDutyRouster" Name="ID" PropertyName="SelectedValue" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenFieldStartTime" runat="server" />
            <asp:HiddenField ID="HiddenFieldToTime" runat="server" /><asp:SqlDataSource ID="SqlDataSourceShift" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" InsertCommand="INSERT INTO emp_DutyShift(ShiftName, StartTime, EndTime, Dept_ID, SubDept_Id) VALUES (@ShiftName, @StartTime, @EndTime, @DeptID, @SubDeptId)" SelectCommand="SELECT ShiftID, ShiftName FROM Admin_Shift">
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBoxShiftName" Name="ShiftName" PropertyName="Text" />
                    <asp:ControlParameter ControlID="HiddenFieldStartTime" Name="StartTime" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenFieldToTime" Name="EndTime" PropertyName="Value" />
                    <asp:ControlParameter ControlID="DropDownListDepartment" Name="Dept_ID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDept_Id" PropertyName="SelectedValue" />
                </InsertParameters>
            </asp:SqlDataSource>
        <br />
<br />

  </asp:Content>