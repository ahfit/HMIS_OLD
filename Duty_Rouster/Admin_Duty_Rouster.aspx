<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Admin_Duty_Rouster, App_Web_eqmkimbh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
    <div><h2><span>Admin Duty Rouster</span></h2></div>
<table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                <tr>
                    <td  width="40%" align="right"  >
                      Department Name :</td>
                    <td width="60%"  >
                        <asp:DropDownList ID="DropDownListDepartment" runat="server"  AutoPostBack="True"  DataSourceID="SqlDataSource_Dept" DataTextField="Dept_Name" DataValueField="Dept_ID">                        </asp:DropDownList>                    </td>
                </tr>
                <tr>
                    <td align="right" style="height: 18px"  >
                      Sub Department Name :</td>
                    <td style="height: 18px" >
                        <asp:DropDownList ID="DropDownListSubDepartment" runat="server"  Css DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="True">                        </asp:DropDownList>                                        </td>
                </tr>
                <tr>
                    <td align="right" >
                      Shift Name :</td>
                    <td align="left" >
                        <asp:DropDownList ID="DropDownListShift" runat="server" DataSourceID="SqlDataSourceShift"
                            DataTextField="ShiftName" DataValueField="ShiftID" >                        </asp:DropDownList>                    </td>
                </tr>
                <tr>
                    <td align="right">
                      Start Time :</td>
                    <td >
                        <igtxt:webdatetimeedit id="WebDateTimeEditStartTime" runat="server" displaymodeformat="t"
                            editmodeformat="t" nullable="False"  ></igtxt:webdatetimeedit>                                        </td>
                </tr>
                <tr>
                    <td align="right">
                      Duration Time :</td>
                    <td >
                        <asp:TextBox ID="TextBoxShiftDuration" runat="server" Skinid="intdata"  Width="86px"></asp:TextBox>hr.
                        &nbsp;
                        <asp:TextBox ID="TextBoxMin" runat="server"  Skinid="intdata" Text="0"  Width="86px"></asp:TextBox>min                        </td>
                </tr>
                 <%--<tr>
                <td align="right">
                    Next Day(Night Shift):
                </td>
                <td>
                    <asp:CheckBox ID="CKNightSHift" runat="server" />
                </td>
            </tr>--%>
                <tr>
                    <td >                    </td>
                    <td >
                        <asp:Button ID="ButtonSave" runat="server" Text="Save"    />   
                        <asp:Label runat="server" ID="lblMsg"></asp:Label>                     
                        <asp:LinkButton ID="LinkButton1" runat="server"   Visible="False">Show All Shift</asp:LinkButton></td>
                </tr>
            </table></div>
<br />
    &nbsp;<asp:GridView ID="GridViewDutyRoster" runat="server" AutoGenerateColumns="False" DataKeyNames="Duty_Roster_ID"
        DataSourceID="SqlDataSourceShiftName" CssClass="Grid_1" Width="100%">
        <Columns>
            <asp:BoundField DataField="Dept_Name" HeaderText="Department Name" SortExpression="Dept_Name" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Department Name" SortExpression="SubDept_Name" />
            <asp:BoundField DataField="ShiftName" HeaderText="Shift Name" SortExpression="ShiftName" />
            <asp:BoundField DataField="start_Time" HeaderText="Start Time" ReadOnly="True" SortExpression="start_Time" />
            <asp:BoundField DataField="End_Time" HeaderText="End Time" ReadOnly="True" SortExpression="End_Time" />
            <asp:BoundField DataField="Duty_Roster_ID" HeaderText="Duty_Roster_ID" InsertVisible="False"
                ReadOnly="True" SortExpression="Duty_Roster_ID" Visible="False" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%# Eval("Duty_Roster_ID") %>'
                        OnClick="lnkDelete_Click">Delete</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        
            <asp:SqlDataSource ID="SqlDataSourceShiftName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
                SelectCommand="Select_Shift_Dept" 
                 DeleteCommand="DELETE FROM Admin_DutyRoster WHERE (Duty_Roster_ID = @Duty_Rouster_ID)" 
                SelectCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="HiddenField_DutyRosterID" Name="Duty_Rouster_ID"
                        PropertyName="Value" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="Dept_id" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenFieldFlag" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource_Dept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="Select_Dept"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Deptid)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListDepartment" Name="Deptid" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" InsertCommand="INSERT INTO Admin_DutyRoster(StartTime, EndTime,isComplicated, DeptID, SubDeptId, Shift_ID,ShiftType) VALUES ( Cast(Cast(Cast(@StartTime as varchar(50))+' '+Cast(Cast(GetDate() as date) as varchar(50)) as varchar ) as datetime) ,DateAdd(Minute,@min ,DateAdd(Hour,@hr,Cast(Cast(Cast(@StartTime as varchar(50))+' '+Cast(Cast(GetDate() as date) as varchar(50)) as varchar ) as datetime))),Case when DatePArt(hour,DateAdd(Minute,@min ,DateAdd(Hour,@hr,Cast(Cast(Cast(@StartTime as varchar(50))+' '+Cast(Cast(GetDate() as date) as varchar(50)) as varchar ) as datetime))))  between 0 and 8 then 1 else 0 end, @DeptID, @SubDeptId, @Shift_ID,@htyp)">
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenFieldStartTime" Name="StartTime" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenFieldToTime" Name="EndTime" PropertyName="Value" />
                    <asp:ControlParameter ControlID="TextBoxShiftDuration" Name="hr" PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="TextBoxMin" Name="min" PropertyName="Text" Type="Int32" />

                    <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownListShift" Name="Shift_ID" PropertyName="SelectedValue" />
                 <asp:ControlParameter ControlID="hdtype" Name="htyp" PropertyName="Value" />
                </InsertParameters>
            </asp:SqlDataSource>
    <asp:HiddenField ID="hdtype" runat="server" />
            <asp:HiddenField ID="HiddenFieldStartTime" runat="server" />
            <asp:HiddenField ID="HiddenFieldToTime" runat="server" /><asp:SqlDataSource ID="SqlDataSourceShift" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" InsertCommand="INSERT INTO Emp_DutyShift(ShiftName, StartTime, EndTime, Dept_ID, SubDept_Id) VALUES (@ShiftName, @StartTime, @EndTime, @DeptID, @SubDeptId)" SelectCommand="SELECT ShiftID, ShiftName FROM Admin_Shift">
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBoxShiftName" Name="ShiftName" PropertyName="Text" />
                    <asp:ControlParameter ControlID="HiddenFieldStartTime" Name="StartTime" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenFieldToTime" Name="EndTime" PropertyName="Value" />
                    <asp:ControlParameter ControlID="DropDownListDepartment" Name="Dept_ID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDept_Id" PropertyName="SelectedValue" />
                </InsertParameters>
            </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_DutyRosterID" runat="server" />
        <br />
<br />

  </asp:Content>