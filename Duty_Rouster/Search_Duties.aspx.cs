using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

public partial class Administrator_Search_Duties : System.Web.UI.Page
{
    SqlConnection con = null;
    ImageButton imgBtn = null;

    public Administrator_Search_Duties()
    {
        con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        
    }

    private void Open()
    {
        if (con != null)
            con.Open();
        else
        {
            con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        }
    }

    private void Close()
    {
        if (con != null && con.State == ConnectionState.Open)
            con.Close();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

       
        
        if (!Page.IsPostBack)
        {
            DropDownListDepartment.DataBind();
            //Search();
            PnlAddEmp.Visible = false;
            WebDateChooser_start_From.Value = DateTime.Now.AddDays(-7);
            WebDateChooser_end_to.Value = DateTime.Now;
            HiddenField_fromDate.Value = Convert.ToString(WebDateChooser_start_From.Value);
            HiddenField_Todate.Value = Convert.ToString(WebDateChooser_end_to.Value);
        }
        WebDateChooser_end_to.Enabled = true;
        Search();
    }
   
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Search();

    }

    private void Search()
    {
        //pnlWeekView.Controls.Clear();

        //HiddenField_fromDate.Value = Convert.ToString(WebDateChooser_start_From.Value);
        //HiddenField_Todate.Value = Convert.ToString(WebDateChooser_end_to.Value);
        //DataTable dt = GetRecord();
        //if (dt.Rows.Count > 0 || dt != null)
        //{
        //    string[] dates = new string[dt.Rows.Count];
        //    for (int m = 0; m < dt.Rows.Count; m++)
        //    {
        //        dates[m] = dt.Rows[m]["Duty_Start_Date"].ToString();
        //    }
        //    ArrayList SelectedDates = new ArrayList();

        //    for (int i = 0; i < dates.Length; i++)
        //    {
        //        if (SelectedDates.Contains(dates[i]))
        //            continue;
        //        SelectedDates.Add(dates[i]);
        //    }
        //    Table tblWeek = new Table();

        //    TableRow trHeader = new TableRow();
        //    TableCell tcH = new TableCell();

        //    tcH = new TableCell();
        //    Label lH = new Label();
        //    lH.Text = Convert.ToString("");
        //    tcH.Controls.Add(lH);
        //    tcH.CssClass = "headerCell";
        //    trHeader.Cells.Add(tcH);

        //    // Dates are listed
        //    for (int i = 0; i < SelectedDates.Count; i++)
        //    {
        //        if (SelectedDates.Count > 0 && SelectedDates.Count > i)
        //        {
        //            tcH = new TableCell();
        //            Label lbl = new Label();
                    
        //                lbl.Text = Convert.ToDateTime((SelectedDates[i])).ToString("dd/MM/yyyy");
                   
        //            tcH.Controls.Add(lbl);
        //            tcH.CssClass = "headerCell";
        //            trHeader.Cells.Add(tcH);
        //        }
        //    }
        //    trHeader.CssClass = "HeaderRowStyle";
        //    tblWeek.Rows.Add(trHeader);
        //    ArrayList shifts = new ArrayList();
        //    DataTable dtShifts = GetShifts();

        //    string[] Shift = new string[dtShifts.Rows.Count];
        //    for (int m = 0; m < dtShifts.Rows.Count; m++)
        //    {
        //        Shift[m] = dtShifts.Rows[m]["ShiftName"].ToString();
        //    }

        //    for (int i = 0; i < Shift.Length; i++)
        //    {
        //        if (shifts.Contains(Shift[i]))
        //            continue;
        //        shifts.Add(Shift[i]);
        //    }
        //    for (int shift = 0; shift < shifts.Count; shift++)
        //    {
        //        TableRow tr1 = new TableRow();
        //        TableCell tc = null;
        //        tc = new TableCell();
        //        Label ShiftName = new Label();
        //        ShiftName.Text = Convert.ToString(shifts[shift]);
        //        tc.Controls.Add(ShiftName);
        //        tc.CssClass = "TableDataStyle";
        //        tc.Width = 200;
        //        tr1.Cells.Add(tc);

        //        for (int date_Calender = 0; date_Calender < SelectedDates.Count; date_Calender++)
        //        {
        //            tc = new TableCell();
        //            tc.Controls.Clear();

        //            tc.Controls.Add(new LiteralControl("<div class = btnStyle>"));
        //            Button btnAddEmp = new Button();
        //            btnAddEmp.Text = "Add";
                   
        //                btnAddEmp.ID = "btnAddEmp_" + Convert.ToDateTime(SelectedDates[date_Calender]).ToString("yyyyMMdd") + "_" + shifts[shift].ToString();
                   
        //            btnAddEmp.CommandArgument = Convert.ToDateTime(SelectedDates[date_Calender]).ToString("dd/MM/yyyy") + "_" + shifts[shift].ToString();
        //            btnAddEmp.Click += new EventHandler(this.btnAddEmp_Click);
        //            //btnAddEmp.OnClientClick = "ButtonClick('" + btnAddEmp.ClientID + "')";
        //            tc.Controls.Add(btnAddEmp);
        //            tc.Controls.Add(new LiteralControl("</div>"));


        //            Label lbl = null;
        //            tc.Controls.Add(new LiteralControl("<div class = TdStyle style=width:200px;>"));

        //            for (int empName = 0; empName < dt.Rows.Count; empName++)
        //            {
        //                if (Convert.ToDateTime(SelectedDates[date_Calender]).ToString("dd/MM/yyyy") == Convert.ToDateTime(dt.Rows[empName]["Duty_Start_Date"]).ToString("dd/MM/yyyy")
        //                && shifts[shift].ToString() == dt.Rows[empName]["ShiftName"].ToString())
        //                {
        //                    lbl = new Label();
        //                    lbl.Text = dt.Rows[empName]["EMPLOYEE_NAME"].ToString();
        //                    tc.Controls.Add(lbl);

        //                    ImageButton tmpImgBtn = new ImageButton();
        //                    tmpImgBtn.Click += new ImageClickEventHandler(this.imgBtn_Click);
        //                    tmpImgBtn.ID = "imgBtn_" + dt.Rows[empName]["Emp_Duty_Roster"].ToString();
        //                    tmpImgBtn.CommandArgument = dt.Rows[empName]["Emp_Duty_Roster"].ToString();
        //                    tmpImgBtn.ImageUrl = "~/images/delete.png";
        //                    tc.Controls.Add(tmpImgBtn);
        //                    tc.Controls.Add(new LiteralControl("<div style= 'padding: 2px'></div>"));
        //                }
        //            }
        //            tc.CssClass = "TableDataStyle";
        //            tr1.Cells.Add(tc);
        //            tc.Controls.Add(new LiteralControl("</div>"));
        //        }
        //        tr1.CssClass = "RowStyle";
        //        tblWeek.Rows.Add(tr1);
        //    }
        //    tblWeek.CssClass = "ShiftDutyTable";
        //    tblWeek.Attributes["cellpadding"] = "0";
        //    tblWeek.Attributes["cellspacing"] = "0";
        //    pnlWeekView.Controls.Add(tblWeek);
        //}
        
    }

    public DataTable GetRecord()
    {
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            Open();
            SqlCommand cmd = new SqlCommand("sp_SearchDuties", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@stDate", HiddenField_fromDate.Value);
            cmd.Parameters.AddWithValue("@edDate", HiddenField_Todate.Value);
            cmd.Parameters.AddWithValue("@deptid", DropDownListDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@subdeptid", DropDownListSubDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@empid", DDLEMployee.SelectedValue);

            da.SelectCommand = cmd;
            da.Fill(dt);
            cmd.Dispose();
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.Message);
            dt = null;
        }
        finally
        {
            Close();
        }

        return dt;
    }


    public DataTable GetShifts()
    {
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            Open();
            SqlCommand cmd = new SqlCommand("SELECT ShiftID, ShiftName FROM Admin_Shift S inner join Admin_DutyRoster D on S.ShiftID = D.Shift_ID where DeptID =" + DropDownListDepartment.SelectedValue
                , con);
            
            cmd.CommandType = CommandType.Text;

            da.SelectCommand = cmd;
            da.Fill(dt);
            cmd.Dispose();
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.Message);
        }
        finally
        {
            Close();
        }
        return dt;
    }

    public void DeleteEmp(string id)
    {
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM Admin_Employee_Duty_Roster WHERE (Emp_Duty_Roster = @id)", con);
            cmd.CommandType = CommandType.Text;

            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.Message);
        }
        finally
        {
            Close();
        }
    }


    public void SelectDutyRosterId()
    {
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            Open();
            SqlCommand cmd = new SqlCommand("SELECT Admin_DutyRoster.Duty_Roster_ID ,  (SELECT Ward_id FROM dbo.admin_Hospital_Wards WHERE Dept_Id = @DeptID AND SubDept_Id = @SubDeptID) AS wardID FROM Admin_DutyRoster INNER JOIN Admin_Shift ON Admin_DutyRoster.Shift_ID = Admin_Shift.ShiftID WHERE (Admin_DutyRoster.DeptID = @DeptID) AND (Admin_DutyRoster.SubDeptId = @SubDeptID)  AND (Admin_Shift.ShiftName = @ShiftName)", con);
            cmd.CommandType = CommandType.Text;

            cmd.Parameters.AddWithValue("@DeptID", DropDownListDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@SubDeptID", DropDownListSubDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@ShiftName", HiddenField_ShiftName.Value);
            
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                HiddenField_dutyRosterID.Value = Convert.ToString(dr[0]);
                HiddenField_WardId.Value = Convert.ToString(dr[1]) ?? string.Empty;
            }
            
            cmd.Dispose();
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.Message);
        }
        finally
        {
            Close();
        }
    }


    protected void WebDateChooser_start_From_ValueChanged(object sender, Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs e)
    {
        if (WebDateChooser_start_From.Value != null)
        {
           WebDateChooser_end_to.Value = Convert.ToDateTime(WebDateChooser_start_From.Value).AddDays(5); 
        }
        
    }
    protected void imgBtn_Click(object sender, ImageClickEventArgs e)
    {
        string id = (string)(sender as ImageButton).ID.Replace("imgBtn_", "");
        DeleteEmp(id);
        Search();
    }


    protected void btnAddEmp_Click(object sender, EventArgs e)
    {
        Button thisButton = (Button)sender;
        string[] data = thisButton.CommandArgument.Split('_');
        HiddenField_Date_Start.Value = Convert.ToString(Utility.GetDateTimeForFormat(data[0]).ToString("yyyy/MM/dd"));
        HiddenField_ShiftName.Value = Convert.ToString(data[1]);
        SelectDutyRosterId();
        if (HiddenField_dutyRosterID.Value == string.Empty)
        {
            lblMsg.Text = "Please select Department!";
            return;
        }
        DDLDeptForEmp.SelectedIndex = -1;
        DDLSubDeptForEmp.SelectedIndex = -1;
        PnlAddEmp.Visible = true;
        Search();
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        PnlAddEmp.Visible = false;
    }
    protected void DDLDeptForEmp_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckBoxList_Emp.DataBind();
    }
    protected void DDLSubDeptForEmp_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckBoxList_Emp.DataBind();
        //SelectDutyRosterId();

    }
    protected void ButtonSave_Click(object sender, EventArgs e)
    {
        SaveData();
        Search();
    }

    private void SaveData()
    {
        for (int i = 0; i < CheckBoxList_Emp.Items.Count; i++)
        {
            if (CheckBoxList_Emp.Items[i].Selected == true)
            {
                HiddenField_EmpID.Value = CheckBoxList_Emp.Items[i].Value;
                SqlDataSource_Saveinfo.Insert();
            }
        }
        PnlAddEmp.Visible = false;
    }
    protected void DropDownListSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;
        DDLEMployee.DataBind();
        //SelectDutyRosterId();
    }
    protected void Button_Report_Click(object sender, EventArgs e)
    {

        HiddenField_Sdate.Value = WebDateChooser_start_From.Value.ToString();
        HiddenField_EDate.Value = WebDateChooser_end_to.Value.ToString();
        HiddenField_Dept.Value = DropDownListDepartment.SelectedValue;
        HiddenField_Sub_Dept.Value = DropDownListSubDepartment.SelectedValue;
        HiddenField_Employee.Value = DDLEMployee.SelectedValue;
        hfdempdep.Value = rdrbtn.SelectedValue; 

        Response.Redirect("~/Duty_Rouster/Duty_Rouster_Report.aspx?id=" + HiddenField1.Value + "&Sdate=" + HiddenField_Sdate.Value + " &EDate=" + HiddenField_EDate.Value + "&Dept=" + HiddenField_Dept.Value + "&SubDept=" + HiddenField_Sub_Dept.Value + "&EmpId=" + HiddenField_Employee.Value+ "&empdep=" + hfdempdep.Value);
       
      
        

    }
}
