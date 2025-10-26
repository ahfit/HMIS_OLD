<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="EmployeeLeaves_MainPage.aspx.cs" Inherits="Leave_Management_EmployeeLeaves_MainPage" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
 
     
    <%--<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css--%>
  <style type="text/css">
        .bld {
            font-weight:bold
        }
    </style>
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 
     <script src="validate.js" type="text/javascript"></script>

 
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
 <asp:Label ID="LabelDoctorName" runat="server" Visible="false" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment" Visible="False"></asp:Label>
 <asp:Label ID="LabelDate" runat="server" Visible="false" ></asp:Label>
<div class="bxmain inner_content" style="width:100%;">

      <div class="bxmain inner_content" style="text-align:left; width:100%;background-color:transparent; border:none; font-weight:bold;">
<h2><span>Main Page</span> </h2>
</div>

   
  <%--<div  class="jumbotron" style="background-color:#00994d">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%--<asp:Image ID="Image1" runat="server" src="~/Images/Asp.png" style="width:40px;height:40px" />--%>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%--<asp:Label ID="Label1" runat="server" Text="Register New User"></asp:Label>--%>
      <%--</div>--%>
    <div style="width: 100%">
        
        <div style="width: 320px; height: 250px; background-color: #e6ffff; float: left; margin: 30px 0 auto 140px">
            <div style="width: 100%; height: 30px; background-color: #00b300; padding: 5px">
                <p style="margin-left: 10px; font-weight: bold">
                    My Profile
                </p>
            </div>
            <div style="width: 100%; height: 100%; padding: 5px 0 0 5px">
                <div style="width: 100%; height: 20px">
                </div>
                <div style="width: 100%; height: 30px">
                    <div style="width: 115px; height: 30px; float: left">
                        <p class="bld" style="width:120px;margin-left:8px">
                            Employee Code:
                        </p>
                    </div>
                    <div style="float: right; width: 200px; height: 30px">
                        <asp:Label ID="lbl_Code" runat="server" Text=""></asp:Label>
                    </div>


                </div>
                <div style="width: 100%; height: 30px">
                    <div style="width: 115px; height: 30px; float: left">
                        <p class="bld" style="width:120px;margin-left:8px">
                            Name:
                        </p>
                    </div>
                    <div style="float: right; width: 200px; height: 30px">
                        <asp:Label ID="lbl_Name" runat="server" Text=""></asp:Label>
                    </div>


                </div>
                <div style="width: 100%; height: 30px">
                    <div style="width: 115px; height: 30px; float: left">
                        <p class="bld" style="width:120px;margin-left:8px">
                            Father Name:
                        </p>
                    </div>
                    <div style="float: right; width: 200px; height: 30px">
                        <asp:Label ID="lbl_FatherName" runat="server" Text=""></asp:Label>
                    </div>


                </div>
                <%--<div style="width: 100%; height: 30px">
                    <div style="width: 115px; height: 30px; float: left">
                        <p class="bld">
                            Job Type:
                        </p>
                    </div>
                    <div style="float: right; width: 160px; height: 30px">
                        <asp:Label ID="Label4" runat="server" Text="Engineer"></asp:Label>
                    </div>


                </div>--%>
                <div style="width: 100%; height: 30px">
                    <div style="width: 115px; height: 30px; float: left">
                        <p class="bld" style="width:120px;margin-left:8px">
                            Designation:
                        </p>
                    </div>
                    <div style="float: right; width: 200px; height: 30px">
                        <asp:Label ID="lbl_Designation" runat="server" Text=""></asp:Label>
                    </div>


                </div>
                <div style="width: 100%; height: 30px">
                    <div style="width: 115px; height: 30px; float: left">
                        <p class="bld" style="width:120px;margin-left:8px">
                            Email:
                        </p>
                    </div>
                    <div style="float: right; width: 200px; height: 30px">
                        <asp:Label ID="lbl_Email" runat="server" Text=""></asp:Label>
                    </div>


                </div>
                <div style="width: 100%; height: 30px">
                    <div style="width: 115px; height: 30px; float: left">
                        <p class="bld" style="width:120px;margin-left:8px">
                            Mobile:
                        </p>
                    </div>
                    <div style="float: right; width: 200px; height: 30px">
                        <asp:Label ID="lbl_Mobile" runat="server" Text=""></asp:Label>
                    </div>


                </div>

            </div>
        </div>
        <%--<div style="width:280px;height:300px;  display:inline-block;margin:100px 0 0 30px">--%>
        <div style=" width: 320px; height: 300px; display:none; margin: 30px 0 auto 50px">
            
            <%--</div>--%>
            <div style="width: 300px; height: 150px; background-color: #e6ffff; margin: 0 0 0 0">
                <div style="width: 100%; height: 30px; background-color: #00b300; padding: 5px">
                    <p style="margin-left: 10px; font-weight: bold">
                        Reporting
                    </p>
                </div>
                <div style="width: 100%; height: 20px">
                </div>
                <div style="width: 100%; height: 30px">
                    <div style="width: 45%; height: 30px; margin: 0 0 0 5px; float: left">
                        <p style="margin: 10px 0 0 10px" class="bld">
                            Report To:
                        </p>
                    </div>
                    <div style="width: 52%; height: 40px; margin: 0 0 0 0; float: right">
                        <p style="margin: 10px 0 0 10px">
                            <asp:Label ID="lblAuthority" runat="server" Text=""></asp:Label>
                        </p>
                    </div>
                </div>
                <div style="width: 100%; height: 40px">
                    <div style="width: 45%; height: 40px; margin: 5px 0 0 5px; float: left">
                        <p style="margin: 10px 0 0 10px" class="bld">
                            Reporting To me:
                        </p>
                    </div>
                    <div style="width: 52%; height: 40px; margin: 5px 0 0 0; float: right">
                        <p style="margin: 0 0 0 10px" class="bld">
                            <asp:HyperLink ID="HyperLinkForEmployeeReporting" NavigateUrl="~/Leave_Management/EmployeeReportingTo.aspx" runat="server">Click to View</asp:HyperLink>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div style="width: 300px; height: 262px; background-color: #e6ffff; float: right; margin: 30px 128px auto 0">
            <div style="width: 100%; height: 30px; background-color: #00b300; padding: 5px">
                <p style="margin-left: 10px; font-weight: bold">
                    Actions
                </p>
            </div>

            <div style="width: 100%; height: 90%">
                <div style="margin: 10px 2px 2px 5px; width: 100%; height: 100px">
                    <div style="margin: 15px 0 0 30px; height: 70%; width: 30%; float: left">
                        <asp:ImageButton ID="Img_ViewAttendane" src="../images/Attendance_Icon_2.jpg" width="81px" Height="68px" runat="server"/>
                    </div>
                    <div style="margin: 15px 35px 0 15px; height: 70%; width: 30%; float: right">
                        <asp:ImageButton ID="Img_LeaveHistory" src="../images/LeaveHistrory.png" width="81px" Height="68px" runat="server" />
                    </div>
                    <div style="margin: 2px 0 0 6px; width: 45%; height: 10px; float: left; text-align: center">
                        <asp:HyperLink ID="HYK_ViewAttendnace" runat="server" class="bld" Target="_blank">My Attendance</asp:HyperLink>
                    </div>
                    <div style="margin: 2px 15px 0 0; width: 45%; height: 10px; float: right; text-align: center">
                        <asp:HyperLink ID="HYK_LeaveHistory" runat="server" class="bld" Target="_blank">Leave History</asp:HyperLink>
                    </div>
                </div>
                <div style="margin: 5px 2px 2px 5px; width: 100%; height: 100px">
                    <div style="margin: 15px 0 0 30px; height: 70%; width: 30% ;float:left">
                        <asp:ImageButton ID="IMG_leave_Request"  src="../images/leave-application-7510407.jpg" width="81px" Height="68px" runat="server" />
                    </div>
                    <div style="margin: 15px 35px 0 0; height: 70%; width: 30% ;float:right">
                        
                        
                        <asp:ImageButton ID="Img_LeaveSummary" src="../images/LeaveSummary.jpg" width="81px" Height="68px" runat="server" />
                    </div>
                    
                    <div style="margin: 2px 0 0 6px; width: 45%; height: 10px; float: left; text-align: center">
                        <asp:HyperLink ID="HYK_LeaveRequest"   runat="server" class="bld" Target="_blank">Apply for Leave</asp:HyperLink>
                    </div>
                <div style="margin: 2px 0 0 6px; width: 45%; height: 10px; float: left; text-align: center">
                        <asp:HyperLink ID="HYK_LeaveSummary" runat="server" class="bld" Target="_blank">Leave Summary</asp:HyperLink>
                    </div>
                    
                 <div style="margin: 5px 2px 2px 5px; width: 100%; height: 100px">
                    <div style="margin: 15px 0 0 30px; height: 70%; width: 30% ;float:left">
                        <asp:ImageButton ID="ImageButton1"  src="../images/leave-application-7510407.jpg" width="81px" Height="68px" runat="server" />
                    </div>
                    <div style="margin: 15px 35px 0 0; height: 70%; width: 30% ;float:right">
                        
                        
                    </div>
                    
                    <div style="margin: 2px 0 0 6px; width: 45%; height: 10px; float: left; text-align: center">
                        <asp:HyperLink ID="HyperLink1"   runat="server" class="bld" Target="_blank">Duty Roaster</asp:HyperLink>
                    </div>
                <div style="margin: 2px 0 0 6px; width: 45%; height: 10px; float: left; text-align: center">
                    </div>
                    
                </div>


                </div>


             <%--   <div style="margin: 5px 2px 2px 5px; width: 100%; height: 100px">
                    <div style="margin: 15px 0 0 30px; height: 70%; width: 30%;float:left">
                        
                            <asp:ImageButton ID="Img_ApplyForOverTime" src="../images/pending.jpg" runat="server" width="81px" Height="68px"   Visible="false" />
                    </div>
                    <div style="margin: 15px 35px 0 0; height: 70%; width: 30% ;float:right">
                       <asp:ImageButton ID="Img_ApplyForMissingAttendacnce" src="../images/Attendance_Icon_2.jpg" runat="server" width="81px" Height="68px"  Visible="false" />
                    </div>
                   
                    
                    <div style="margin: 2px 0 0 6px; width: 45%; height: 10px; float: left; text-align: center">
                        <asp:HyperLink ID="HYK_ApplyForOverTime"  runat="server" class="bld" Target="_blank" Visible="false">Apply For OverTime</asp:HyperLink>
                    </div>

                    <div style="margin: 2px 0 0 6px; width: 45%; height: 10px; float: left; text-align: center">
                        <asp:HyperLink ID="HYK_ApplyForMissingAttendacnce" runat="server" class="bld" Target="_blank" Visible="false">Missing Attendance</asp:HyperLink>
                    </div>--%>
                
                    
                </div>

            </div>
        </div>
    </div>
</asp:Content>
