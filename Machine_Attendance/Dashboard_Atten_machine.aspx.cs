using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Machine_Attendance_Dashboard_Atten_machine : System.Web.UI.Page
{

    string sConnectionString = ConfigurationManager.ConnectionStrings["Machine_AttendanceConnectionString"].ConnectionString;
    public zkemkeeper.CZKEMClass axCZKEM1 = new zkemkeeper.CZKEMClass();
    int count = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            PNL_Device.Visible = false;
        }

    }

    private void LOAD_OLD_DATA(string M_IP)
    {
        //Dim idwTMachineNumber As Integer
        //Dim idwEnrollNumber As Integer
        //Dim idwEMachineNumber As Integer
        //Dim idwVerifyMode As Integer
        //Dim idwInOutMode As Integer
        //Dim idwYear As Integer
        //Dim idwMonth As Integer
        //Dim idwDay As Integer
        //Dim idwHour As Integer
        //Dim idwMinute As Integer

        //Dim idwErrorCode As Integer
        //Dim iGLCount = 0
        //Dim iMachineNumber As Integer = 1


        //axCZKEM1.EnableDevice(iMachineNumber, False) 'disable the device
        //If axCZKEM1.ReadGeneralLogData(iMachineNumber) Then 'read all the attendance records to the memory
        //    'get records from the memory
        //    While axCZKEM1.GetGeneralLogData(iMachineNumber, idwTMachineNumber, idwEnrollNumber, idwEMachineNumber, idwVerifyMode, idwInOutMode, idwYear, idwMonth, idwDay, idwHour, idwMinute)

        //        Dim Atten_Date As String = "'" + idwYear.ToString() + Right("00" + idwMonth.ToString(), 2) & Right("00" + idwDay.ToString(), 2) + "'"
        //        'Atten_Date = "'" + idwYear.ToString() + "-" + idwMonth.ToString() & "-" & idwDay.ToString() & " " & idwHour.ToString() & ":" & idwMinute.ToString() + "'"
        //        Dim Atten_time As String = "'" & idwHour.ToString() & ":" & idwMinute.ToString() + "'"
        //        Insert_Data(idwEnrollNumber.ToString(), idwVerifyMode.ToString(), idwInOutMode.ToString(), Atten_Date, M_IP, Atten_time)


        //    End While
        //Else
        int idwTMachineNumber = 0;
        int idwEnrollNumber = 0;
        int idwEMachineNumber = 0;
        int idwVerifyMode = 0;
        int idwInOutMode = 0;
        int idwYear = 0;
        int idwMonth = 0;
        int idwDay = 0;
        int idwHour = 0;
        int idwMinute = 0;

        int idwErrorCode = 0;
        int iGLCount = 0;
        int iIndex = 0;

        int iMachineNumber = 1;

        axCZKEM1.EnableDevice(iMachineNumber, false);
        ////disable the device
        if (axCZKEM1.ReadGeneralLogData(iMachineNumber))
        {
            while (axCZKEM1.GetGeneralLogData(iMachineNumber, idwTMachineNumber, idwEnrollNumber, idwEMachineNumber, idwVerifyMode, idwInOutMode, idwYear, idwMonth, idwDay, idwHour,
            idwMinute))
            {
                string Atten_Date = null;
                string TimeIN_ID = null;
                string TimeOut_ID = null;
                TimeOut_ID = idwEnrollNumber.ToString() + "" + idwYear + "" + Convert.ToString(idwMonth).PadLeft(2, '0') + "" + idwDay.ToString().PadLeft(2, '0');
                TimeIN_ID = idwEnrollNumber.ToString() + "" + idwYear + "" + idwMonth.ToString().PadLeft(2, '0') + "" + idwDay.ToString().PadLeft(2, '0') + "" + idwHour.ToString().PadLeft(2, '0') + "" + idwMinute.ToString().PadLeft(2, '0');
                Atten_Date = "'" + idwYear.ToString() + "-" + idwMonth.ToString().PadLeft(2, '0') + "-" + idwDay.ToString() + " " + idwHour.ToString() + ":" + idwMinute.ToString() + "'";

                //Label1.Text = Label1.Text + "Insert data-->"
                Insert_Data(idwEnrollNumber.ToString(), idwVerifyMode.ToString(), idwInOutMode.ToString(), Atten_Date, M_IP, Atten_Date, TimeIN_ID, TimeOut_ID);



            }
        }
        else
        {
            axCZKEM1.GetLastError(idwErrorCode);
            if (idwErrorCode != 0)
            {
               // Interaction.MsgBox("Reading data from terminal failed,ErrorCode: " + idwErrorCode, MsgBoxStyle.Exclamation, "Error");
            }
            else
            {
               // Interaction.MsgBox("No data from terminal returns!", MsgBoxStyle.Exclamation, "Error");
            }
        }

        axCZKEM1.EnableDevice(iMachineNumber, true);
        //enable the device

    }

    private void Insert_log(string M_IP, ref int LOG_ID)
    {
        SqlConnection objConn = new SqlConnection(sConnectionString);


        string sSQL = "Insert_Net_Attendence_LOG";
        SqlCommand objCmd = new SqlCommand(sSQL, objConn);
        objCmd.CommandType = CommandType.StoredProcedure;
        objCmd.Parameters.AddWithValue("@M_IP", M_IP);

        objCmd.Parameters.Add("@LOG_ID", System.Data.SqlDbType.Int);
        objCmd.Parameters["@LOG_ID"].Direction = ParameterDirection.Output;


        objConn.Open();
        objCmd.ExecuteNonQuery();

        if (!string.IsNullOrEmpty(Convert.ToString(objCmd.Parameters["@LOG_ID"].Value)))
        {
            LOG_ID =Convert.ToInt32( objCmd.Parameters["@LOG_ID"].Value);
        }
        objConn.Close();

    }
    private void Insert_Data(string EnrollNumber, string VerifyMode, string idwInOutMode, string A_Date, string M_IP, string A_Time, string TimeIN_ID, string TimeOutId)
    {
        try
        {
            SqlConnection objConn = new SqlConnection(sConnectionString);
            string sSQL = "if not exists( Select ID from [Attendence_Machines_LOG] where TimeInID=" + TimeIN_ID + ") Begin INSERT INTO [Attendence_Machines_LOG]" + "([EnrollNumber],[VerifyMode],[InOutMode],[A_Date],[Machine_IP],[A_Time],TimeInID,TimeOutID)" + "VALUES (" + EnrollNumber + "," + VerifyMode + "," + idwInOutMode + "," + A_Date + ",'" + M_IP + "'," + A_Time + "," + TimeIN_ID + "," + TimeOutId + ") end";
            SqlCommand objCmd = new SqlCommand(sSQL, objConn);

            objConn.Open();
            count = count + 1;
            objCmd.ExecuteNonQuery();

            objConn.Close();
            objConn.Dispose();

        }
        catch (Exception ex)
        {

        }
    }

    private void LOAD_NEW_DATA(string M_IP)
    {
        //Dim sdwEnrollNumber As String = ""
        //Dim idwVerifyMode As Integer
        //Dim idwInOutMode As Integer
        //Dim idwYear As Integer
        //Dim idwMonth As Integer
        //Dim idwDay As Integer
        //Dim idwHour As Integer
        //Dim idwMinute As Integer
        //Dim idwSecond As Integer
        //Dim idwWorkcode As Integer

        //Dim idwErrorCode As Integer
        //Dim iGLCount = 0
        //Dim iMachineNumber As Integer = 1

        //' Label1.Text = Label1.Text + "Start-->"

        //axCZKEM1.EnableDevice(iMachineNumber, False) 'disable the device
        //If axCZKEM1.ReadGeneralLogData(iMachineNumber) Then 'read all the attendance records to the memory
        //    'get records from the memory
        //    While axCZKEM1.SSR_GetGeneralLogData(iMachineNumber, sdwEnrollNumber, idwVerifyMode, idwInOutMode, idwYear, idwMonth, idwDay, idwHour, idwMinute, idwSecond, idwWorkcode)


        //        Dim Atten_Date As String
        //        Atten_Date = "'" + idwYear.ToString() + "-" + idwMonth.ToString() & "-" & idwDay.ToString() & " " & idwHour.ToString() & ":" & idwMinute.ToString() + "'"
        //        'Label1.Text = Label1.Text + "Insert data-->"
        //        Insert_Data(sdwEnrollNumber.ToString(), idwVerifyMode.ToString(), idwInOutMode.ToString(), Atten_Date, M_IP, Atten_Date)


        //    End While
        //Else
       int idwTMachineNumber=0;
            string idwEnrollNumber = "";
            int idwEMachineNumber=0;
            int idwVerifyMode=0;
            int idwInOutMode=0;
            int idwYear=0;
            int idwMonth=0;
            int idwDay=0;
            int idwHour=0;
            int idwMinute=0;
            int idwSecond = 0;
            int idwWorkcode = 0;

            int idwErrorCode=0;
            int iGLCount = 0;
            int iIndex = 0;

        int iMachineNumber = 1;

        axCZKEM1.EnableDevice(iMachineNumber, false);
        ////disable the device
        if (axCZKEM1.ReadGeneralLogData(iMachineNumber))
        {
            while (axCZKEM1.SSR_GetGeneralLogData(iMachineNumber, out idwEnrollNumber, out idwVerifyMode, out idwInOutMode, out idwYear, out idwMonth, out idwDay, out idwHour, out idwMinute, out idwSecond, ref idwWorkcode))
            {
                {
                    string Atten_Date = null;
                    string TimeIN_ID = null;
                    string TimeOut_ID = null;
                    TimeOut_ID = idwEnrollNumber.ToString() + "" + idwYear + "" + Convert.ToString(idwMonth).PadLeft(2, '0') + "" + idwDay.ToString().PadLeft(2, '0');
                    TimeIN_ID = idwEnrollNumber.ToString() + "" + idwYear + "" + idwMonth.ToString().PadLeft(2, '0') + "" + idwDay.ToString().PadLeft(2, '0') + "" + idwHour.ToString().PadLeft(2, '0') + "" + idwMinute.ToString().PadLeft(2, '0');
                    Atten_Date = "'" + idwYear.ToString() + "-" + idwMonth.ToString().PadLeft(2, '0') + "-" + idwDay.ToString() + " " + idwHour.ToString() + ":" + idwMinute.ToString() + "'";

                    //Label1.Text = Label1.Text + "Insert data-->"
                    Insert_Data(idwEnrollNumber.ToString(), idwVerifyMode.ToString(), idwInOutMode.ToString(), Atten_Date, M_IP, Atten_Date, TimeIN_ID, TimeOut_ID);

                }
            }
        }
        else
        {
            //Label1.Text = Label1.Text + "Error-->"
            axCZKEM1.GetLastError(idwErrorCode);
            if (idwErrorCode != 0)
            {
                //Interaction.MsgBox("Reading data from terminal failed,ErrorCode: " + idwErrorCode, MsgBoxStyle.Exclamation, "Error");
            }
            else
            {
                // Label1.Text = Label1.Text + "No record read-->"
                //  Interaction.MsgBox("No data from terminal returns!", MsgBoxStyle.Exclamation, "Error");
            }
        }

        axCZKEM1.EnableDevice(iMachineNumber, true);
        //enable the device

    }
    private void CONNECT_MACHINE(string M_IP, int PORT, string M_Type)
    {

        bool b = axCZKEM1.Connect_Net(M_IP, PORT);
        if (axCZKEM1.Connect_Net(M_IP, PORT))
        {
            int iMachineNumber = 1;

            lbl_IP.Text = M_IP;

            int idwErrorCode = 0;

            int iValue = 0;

            axCZKEM1.EnableDevice(iMachineNumber, false);
            //disable the device
            //Here we use the function "GetDeviceStatus" to get the record's count.The parameter "Status" is 6.
            if (axCZKEM1.GetDeviceStatus(iMachineNumber, 6, ref iValue) == true)
            {
                LBL_RECORD.Text = "Total Record Found = " + iValue.ToString();

            }
            else
            {
            }

            axCZKEM1.EnableDevice(iMachineNumber, true);
            //enable the device

        }
        else
        {

        }




    }
    private void update_status(ref int log_id, ref int Status, string remarks)
    {
        SqlConnection objConn = new SqlConnection(sConnectionString);

        if (Status == 1)
        {
            int iValue = 0;
            string record = "0";

            //Here we use the function "GetDeviceStatus" to get the record's count.The parameter "Status" is 6.
            if (axCZKEM1.GetDeviceStatus(1, 6, iValue) == true)
            {
                remarks = "Record Imported : " + iValue.ToString() + " -- " + remarks;
            }
        }


        string sSQL = "Update [Attendence_Machines_Status]" + " SET [Disconnect_Time] = GetDATE() , [Log_Status] = " + Status.ToString() + " , [Remarks] =ISNULL([Remarks],'') +'  --  ' + '" + remarks + "'" + "where ID = " + log_id.ToString();


        SqlCommand objCmd = new SqlCommand(sSQL, objConn);
        objCmd.CommandType = CommandType.Text;

        objConn.Open();
        objCmd.ExecuteNonQuery();
        objConn.Close();

    }
    protected void btn_Import_Click(object sender, System.EventArgs e)
    {
        try
        {
            Button btn_temp = (Button)sender;

            if (btn_temp.Text == "Load Record(s) From Machine")
            {
                LOAD_DATA();
                //GridView1.DataBind();
            }
            else
            {
                try
                {
                    Import_Attendence(lbl_IP.Text);
                    lbl_IR_MSG.Text = "Imported Successsfully...";
                    //GridView1.DataBind();
                }
                catch (Exception ex)
                {
                   // lbl_IR_MSG.Text = "Failed in importing Attendence.. :: " + ex.Message();
                }

            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }

    }

    protected void Btn_Disconnect_Click(object sender, System.EventArgs e)
    {
        axCZKEM1.Disconnect();
        PNL_Device.Visible = false;
       reset();

    }


    protected void btn_Clear_Click(object sender, System.EventArgs e)
    {




        //Dim idwErrorCode As Integer = 0
        //Dim iMachineNumber As Integer = 1

        //axCZKEM1.EnableDevice(iMachineNumber, False)
        //'disable the device
        //If axCZKEM1.ClearGLog(iMachineNumber) Then
        //    axCZKEM1.RefreshData(iMachineNumber)
        //    'the data in the device should be refreshed

        //Else

        //End If
        //axCZKEM1.EnableDevice(iMachineNumber, True)
        //enable the device
        int iMachineNumber = 1;
        int idwErrorCode = 0;
        string MSG = string.Empty;

        try
        {
            if (axCZKEM1.Connect_Net(lbl_IP.Text,Convert.ToInt32( hdf_Port.Value)))
            {
                axCZKEM1.EnableDevice(iMachineNumber, false);
                //disable the device
                //        If hf_Status.Value = "1" Then
                //            Cleared_Machine_Logs.Insert()
                //            backup_logs()

                //        Else
                //            LOAD_DATA()

                //        End If

                if (axCZKEM1.ClearGLog(iMachineNumber) == true)
                {
                    axCZKEM1.RefreshData(iMachineNumber);
                    //the data in the device should be refreshed
                    MSG = "All attendance logs have been cleared from machine :" + lbl_IP.Text.Trim();
                    //Interaction.MsgBox(MSG, MsgBoxStyle.Information, "success");
                }
                else
                {
                    axCZKEM1.GetLastError(idwErrorCode);
                    MSG = "Operation failed,errorcode=" + idwErrorCode.ToString();
                   // Interaction.MsgBox(MSG, MsgBoxStyle.Exclamation, "error");
                }

                //        axCZKEM1.EnableDevice(iMachineNumber, True)
                //        lbl_CR_MSG.Text = MSG
                //    Else
                //        lbl_CR_MSG.Text = "error in connecting device :" + lbl_IP.Text


            }

        }
        catch (Exception ex)
        {
            lbl_CR_MSG.Text = "error in clearing data : " + ex.Message;
        }


    }

    private void backup_logs()
    {
        SqlConnection objConn = new SqlConnection(sConnectionString);
        string sSQL = "Machine_log_backup";
        SqlCommand objCmd = new SqlCommand(sSQL, objConn);
        objCmd.CommandType = CommandType.StoredProcedure;

        objConn.Open();
        objCmd.ExecuteNonQuery();
        objConn.Close();

    }

    private void LOAD_DATA()
    {
        try
        {
            // Label1.Text = "Loading-->"

            int Log_ID = 0;
            int Status = 0;
            string Remarks = "Fail Due to ";
            count = 0;

            try
            {
                //Insert_log(Convert.ToString(lbl_IP.Text), Log_ID);
                try
                {
                     if (axCZKEM1.Connect_Net(lbl_IP.Text,Convert.ToInt32( hdf_Port.Value))){
                    // Label1.Text = Label1.Text + hdf_Type.Value.ToUpper() + "-->"
                    if (hdf_Type.Value.ToUpper() == "O")
                    {
                        LOAD_NEW_DATA(lbl_IP.Text);
                        //LOAD_OLD_DATA(lbl_IP.Text)
                    }
                    else if (hdf_Type.Value == "N")
                    {
                        LOAD_NEW_DATA(lbl_IP.Text);

                    }
                    }
                    Status = 1;

                    update_status(ref Log_ID, ref Status, "Record Importd Successfully");
                    axCZKEM1.Disconnect();
                    hf_Status.Value = "1";
                    backup_logs();
                    //Else
                    //    Dim Err As Integer = 0
                    //    axCZKEM1.GetLastError(Err)
                    //    update_status(Log_ID, Status, "Unable to connect the device,ErrorCode=" & Err.ToString())

                    //End If

                }
                catch (Exception ex)
                {
                    update_status(ref Log_ID, ref Status, Remarks + ex.ToString());

                }


            }
            catch (Exception ex)
            {
                //lbl_IR_MSG.Text = "Error in Importing data : " + ex.Message();

            }
            lbl_IR_MSG.Text = lbl_IR_MSG.Text + "   -->" + count.ToString();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
    private void Import_Attendence(string Machine_IP)
    {
        SqlConnection objConn = new SqlConnection(sConnectionString);
        string sSQL = "ImportAttendance";
        SqlCommand objCmd = new SqlCommand(sSQL, objConn);
        objCmd.CommandType = CommandType.StoredProcedure;
        //if (!string.IsNullOrEmpty(Machine_IP))
        //{
        //    objCmd.Parameters.AddWithValue("@Machine_IP", Machine_IP);
        //}

        //objCmd.Parameters.AddWithValue("@date",Convert.ToDateTime(txtDate.Text));
        objConn.Open();
        objCmd.ExecuteNonQuery();
        objConn.Close();

    }
    private void reset()
    {
        lbl_CR_MSG.Text = string.Empty;
        lbl_IR_MSG.Text = string.Empty;
        LBL_RECORD.Text = string.Empty;
        lbl_IP.Text = string.Empty;
        lbl_MSG.Text = string.Empty;
        hf_Status.Value = "0";
        hdf_Type.Value = string.Empty;
        hdf_Port.Value = string.Empty;

    }

    //protected void Page_Load(object sender, System.EventArgs e)
    //{
    //    if (!Page.IsPostBack)
    //    {
    //        PNL_Device.Visible = false;
    //    }

    //}

    protected void TextBox1_TextChanged(object sender, System.EventArgs e)
    {
        if (string.IsNullOrEmpty(txt_emp_no.Text))
        {
            HFD_emp_no.Value = "%";
        }
        else
        {
            HFD_emp_no.Value = txt_emp_no.Text;
        }
        //GridView1.DataBind();



    }

    //=======================================================
    //Service provided by Telerik (www.telerik.com)
    //Conversion powered by NRefactory.
    //Twitter: @telerik
    //Facebook: facebook.com/telerik
    //=======================================================


    //=======================================================
    //Service provided by Telerik (www.telerik.com)
    //Conversion powered by NRefactory.
    //Twitter: @telerik
    //Facebook: facebook.com/telerik
    //=======================================================




    protected void gdv_Show_IP_SelectedIndexChanged(object sender, EventArgs e)
    {

        LinkButton lkbtn = sender as LinkButton;
        GridViewRow row =(GridViewRow) lkbtn.NamingContainer;
        HiddenField hf_type = (HiddenField)row.FindControl("hd_type");

        hdf_Type.Value = hf_type.Value;
        hdf_Port.Value = lkbtn.CommandArgument;
        CONNECT_MACHINE(lkbtn.Text,Convert.ToInt32( lkbtn.CommandArgument), hf_type.Value);
        GridView1.DataBind();
        PNL_Device.Visible = true;

        //=======================================================
        //Service provided by Telerik (www.telerik.com)
        //Conversion powered by NRefactory.
        //Twitter: @telerik
        //Facebook: facebook.com/telerik
        //=======================================================

    }
    protected void btn_Save_IP_Click(object sender, EventArgs e)
    {
        SDS_Insert_IP.Insert();
        gdv_Show_IP.DataBind();
    }
    protected void btn_Import_Click1(object sender, EventArgs e)
    {

        try
        {
            Button btn_temp = (Button)sender;

            if (btn_temp.Text == "Load Record(s) From Machine")
            {
                LOAD_DATA();
                //GridView1.DataBind();
            }
            else
            {
                try
                {
                    Import_Attendence(lbl_IP.Text);
                    lbl_IR_MSG.Text = "Imported Successsfully...";
                    //GridView1.DataBind();
                }
                catch (Exception ex)
                {
                  //  lbl_IR_MSG.Text = "Failed in importing Attendence.. :: " + ex.Message();
                }

            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);

        }


        //=======================================================
        //Service provided by Telerik (www.telerik.com)
        //Conversion powered by NRefactory.
        //Twitter: @telerik
        //Facebook: facebook.com/telerik
        //=======================================================

    }
    protected void btn_Clear_Click1(object sender, EventArgs e)
    {


        //Dim idwErrorCode As Integer = 0
        //Dim iMachineNumber As Integer = 1

        //axCZKEM1.EnableDevice(iMachineNumber, False)
        //'disable the device
        //If axCZKEM1.ClearGLog(iMachineNumber) Then
        //    axCZKEM1.RefreshData(iMachineNumber)
        //    'the data in the device should be refreshed

        //Else

        //End If
        //axCZKEM1.EnableDevice(iMachineNumber, True)
        //enable the device

        {
            int iMachineNumber = 1;
            int idwErrorCode = 0;
            string MSG = string.Empty;

            try
            {
                if (axCZKEM1.Connect_Net(lbl_IP.Text,Convert.ToInt32( hdf_Port.Value)))
                {
                    axCZKEM1.EnableDevice(iMachineNumber, false);
                    //disable the device
                    //        If hf_Status.Value = "1" Then
                    //            Cleared_Machine_Logs.Insert()
                    //            backup_logs()

                    //        Else
                    //            LOAD_DATA()

                    //        End If

                    if (axCZKEM1.ClearGLog(iMachineNumber) == true)
                    {
                        axCZKEM1.RefreshData(iMachineNumber);
                        //the data in the device should be refreshed
                        MSG = "All attendance logs have been cleared from machine :" + lbl_IP.Text.Trim();
                        //Interaction.MsgBox(MSG, MsgBoxStyle.Information, "success");
                    }
                    else
                    {
                        axCZKEM1.GetLastError(idwErrorCode);
                        MSG = "Operation failed,errorcode=" + idwErrorCode.ToString();
                      //  Interaction.MsgBox(MSG, MsgBoxStyle.Exclamation, "error");
                    }

                    //        axCZKEM1.EnableDevice(iMachineNumber, True)
                    //        lbl_CR_MSG.Text = MSG
                    //    Else
                    //        lbl_CR_MSG.Text = "error in connecting device :" + lbl_IP.Text


                }

            }
            catch (Exception ex)
            {
                lbl_CR_MSG.Text = "error in clearing data : " + ex.Message;
            }
        }

        //=======================================================
        //Service provided by Telerik (www.telerik.com)
        //Conversion powered by NRefactory.
        //Twitter: @telerik
        //Facebook: facebook.com/telerik
        //=======================================================

    }
    protected void Btn_Disconnect_Click1(object sender, EventArgs e)
    {
        axCZKEM1.Disconnect();
        PNL_Device.Visible = false;
        reset();

    }
    protected void lnk_btn_Click(object sender, EventArgs e)
    {
        LinkButton lkbtn = sender as LinkButton;
        GridViewRow row =(GridViewRow) lkbtn.NamingContainer;
        HiddenField hf_type = (HiddenField)row.FindControl("hd_type");

        hdf_Type.Value = hf_type.Value;
        hdf_Port.Value = lkbtn.CommandArgument;
        CONNECT_MACHINE(lkbtn.Text,Convert.ToInt32( lkbtn.CommandArgument), hf_type.Value);
        //GridView1.DataBind();
        PNL_Device.Visible = true;
    }
}