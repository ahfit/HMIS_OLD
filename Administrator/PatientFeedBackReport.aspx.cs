using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Windows.Forms;

public partial class Pathology_LabTestSummaryReport : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    SqlCommand cmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadDepartments();
            loadAllEmployee();
            startDate.Value = DateTime.Now.AddDays(-1);
            endDate.Value = DateTime.Now;
            //loadPatientType();
            //loadTestGroup();
        }
    }
    private void loadDepartments()
    {

        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 SubDept_ID, '----- ALL -----' SubDept_Name UNION Select SubDept_ID,SubDept_Name From SubDepartment where SubDept_Type="+1+"  Order By SubDept_Name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlSubDepartment.DataSource = dt;
            ddlSubDepartment.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    //protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    ddlSubDepartment.Items.Clear();
    //    ddlSubDepartment.Items.Add("Select SubDepartment");

    //    SqlConnection con = new SqlConnection(connstr);
    //    SqlCommand cmd = new SqlCommand("select * from SubDepartment where Dept_Id=" + ddlDepartment.SelectedItem.Value, con);
    //    SqlDataAdapter sda = new SqlDataAdapter(cmd);
    //    DataTable dt = new DataTable();
    //    sda.Fill(dt);
    //    ddlSubDepartment.DataSource = dt;
    //    ddlSubDepartment.DataBind();
    //}
    protected void ddlSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlEmployee.Items.Clear();
     
        SqlConnection con = new SqlConnection(connstr);

        

        cmd = new SqlCommand("Sp_GetEmployeDeptWise2", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@DeptID", SqlDbType.Int).Value = ddlSubDepartment.SelectedItem.Value;
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        ddlEmployee.DataSource = dt;
        ddlEmployee.DataBind();

        //SqlConnection con = new SqlConnection(connstr);
        //SqlCommand cmd = new SqlCommand("select * from Employee where  SubDeptId=" + ddlSubDepartment.SelectedItem.Value+"And Is_Consultant = "+1+"Or select * from Employee where  SubDeptId=" +0  , con);
        //SqlDataAdapter sda = new SqlDataAdapter(cmd);
        //DataTable dt = new DataTable();
        //sda.Fill(dt);
        //ddlEmployee.DataSource = dt;
        //ddlEmployee.DataBind();
    }

    //protected void ddlEmployee_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //ddlEmployee.Items.Clear();

    //    //SqlConnection con = new SqlConnection(RegconString);

    //    //cmd = new SqlCommand("Sp_GetPatientInfo", con);
    //    //cmd.CommandType = CommandType.StoredProcedure;
    //    //cmd.Parameters.Add("@Doc_ID", SqlDbType.Int).Value = ddlEmployee.SelectedItem.Value;
    //    //con.Open();
    //    //SqlDataAdapter da = new SqlDataAdapter(cmd);
    //    //DataSet ds = new DataSet();
    //    //da.Fill(ds);
    //    //grdcode.DataSource = ds;
    //    //grdcode.DataBind();
    //    ////cmd.ExecuteNonQuery();
    //    //con.Close(); 
    //}
    protected void grdcode_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            int row = grdcode.SelectedRow.RowIndex;
            

            string RegNo = grdcode.Rows[row].Cells[0].Text;
            string name = grdcode.Rows[row].Cells[1].Text;
            string relation = grdcode.Rows[row].Cells[2].Text;
            string relationName = grdcode.Rows[row].Cells[3].Text;
            string phone = grdcode.Rows[row].Cells[4].Text;
            string serviceDate = grdcode.Rows[row].Cells[5].Text;
            DropDownList doctordd = (DropDownList)grdcode.Rows[row].Cells[6].FindControl("drBe");
            var db = doctordd.SelectedValue;
            DropDownList receptiondd = (DropDownList)grdcode.Rows[row].Cells[7].FindControl("RecBe");
            var recp = receptiondd.SelectedValue;
            DropDownList staffdd = (DropDownList)grdcode.Rows[row].Cells[8].FindControl("StaffBe");
            var staff = staffdd.SelectedValue;
            DropDownList cleandd = (DropDownList)grdcode.Rows[row].Cells[9].FindControl("cleandd");
            var clean = cleandd.SelectedValue;
            DropDownList waitingdd = (DropDownList)grdcode.Rows[row].Cells[10].FindControl("waitdd");
            var wait = waitingdd.SelectedValue;
            DropDownList expdd = (DropDownList)grdcode.Rows[row].Cells[11].FindControl("HosptlExp");
            var exp = expdd.SelectedValue;
            int ID = 1;
            int DoctorID = Convert.ToInt32(ddlEmployee.SelectedItem.Value);
            SqlConnection connections = new SqlConnection(connstr);
            string query = "INSERT INTO PatientFeedbak (PatientName, Relation, RelationName, phone, serviceDate, DoctorBehave, RecpBehave, StaffBehave, Cleanlines, WaitingTime, HospitalExp, RegNo,DoctorID,CreatedDate) VALUES (@PatientName, @Relation, @RelationName, @phone, @serviceDate, @DoctorBehave, @recp, @staff, @clean, @wait, @exp,@RegNo,@DocID,@CreatedDate)";
            using (SqlCommand command = new SqlCommand(query, connections))
            {
                command.Parameters.Add("@PatientName", SqlDbType.VarChar, 500).Value = name;
                command.Parameters.Add("@Relation", SqlDbType.VarChar, 100).Value = relation;
                command.Parameters.Add("@RelationName", SqlDbType.VarChar, 300).Value = relationName;
                command.Parameters.Add("@phone", SqlDbType.VarChar, 200).Value = phone;
                command.Parameters.Add("@serviceDate", SqlDbType.VarChar, 300).Value = serviceDate;
                command.Parameters.Add("@DoctorBehave", SqlDbType.VarChar, 300).Value = db;
                command.Parameters.Add("@recp", SqlDbType.VarChar, 200).Value = recp;
                command.Parameters.Add("@staff", SqlDbType.VarChar, 200).Value = staff;
                command.Parameters.Add("@clean", SqlDbType.VarChar, 200).Value = clean;
                command.Parameters.Add("@wait", SqlDbType.VarChar, 200).Value = wait;
                command.Parameters.Add("@exp", SqlDbType.VarChar, 200).Value = exp;
                command.Parameters.Add("@RegNo", SqlDbType.VarChar, 200).Value = RegNo;
                command.Parameters.Add("@DocID", SqlDbType.Int).Value = DoctorID;
                command.Parameters.Add("@CreatedDate", SqlDbType.DateTime, 300).Value = DateTime.Now;
                connections.Open();
                int rowAffected = command.ExecuteNonQuery();
                if (rowAffected != 0)
                {
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Inserted Successfully')", true);
                    this.grdcode.SelectedRow.Visible = false;
                }
                this.grdcode.SelectedRow.Enabled = false;
                //int row2 = grdcode.SelectedRow.RowIndex;
       
                //grdcode.Rows.Remove(row2);
                //gvLoad.DataSource = dt;
                //gvLoad.DataBind();

            }
          
         
            
        }
        catch (Exception ex)
        {

        }
    }
    private void loadAllEmployee()
    {

        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select Prefix+' '+EFName +' '+ ELName as Name,EmpID From Employee where Is_Consultant = " + 1 + " Order By EFName", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlEmployee.DataSource = dt;
            ddlEmployee.DataTextField = "Name";
            ddlEmployee.DataValueField = "EmpID";
            ddlEmployee.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
 
    //protected void ShowReport()
    //{
    //    SqlConnection conn = new SqlConnection(connstr);
    //    DataTable dt = new DataTable();
    //    try
    //    {
    //        SqlCommand cmd = new SqlCommand("LAB_InvestigationGroupWiseReport", conn);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@Date_From", Convert.ToDateTime(txtfromdate.Text));
    //        cmd.Parameters.AddWithValue("@Date_To", Convert.ToDateTime(txttodate.Text));
    //        cmd.Parameters.AddWithValue("@SudDept_Id", Convert.ToInt32(ddlDepartment.SelectedValue));
    //        cmd.Parameters.AddWithValue("@IPDOPD", DropDownList_PatientType.SelectedValue);
    //        cmd.Parameters.AddWithValue("@TGID", ddlTestGroup.SelectedValue);
           

    //        SqlDataAdapter sda = new SqlDataAdapter(cmd);
    //        sda.Fill(dt);
    //    }
    //    catch (Exception ex)
    //    { }
    //    finally
    //    {
    //        ReportViewer1.LocalReport.DataSources.Clear();
    //        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Pathology/LabTestSummaryReport.rdlc");
    //        ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
    //        ReportViewer1.LocalReport.SubreportProcessing += subReports;
    //        ReportViewer1.LocalReport.Refresh();
    //        ReportViewer1.Visible = true;
    //        //if (Request.Browser.Browser == "Chrome")
    //        //{
    //        //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
    //        //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
    //        //    Response.ContentType = "application/pdf";
    //        //    Response.BinaryWrite(bytes);
    //        //    Response.End();
    //        //}
    //    }

    //}
    public void subReports(object sender, SubreportProcessingEventArgs e)
    {
        try
        {
            e.DataSources.Clear();
            DataTable dt = (DataTable)Session["DynamicHeader"];
            e.DataSources.Add(new ReportDataSource("DataSet1", dt));
            e.DataSources.Add(new ReportDataSource("DataSetFooter", dt));

        }
        catch (Exception)
        {
        }
    }

    protected void btnOpen_Click(object sender, EventArgs e)
    {
        //DateTime sd = Convert.ToDateTime(startDate.Text);
        //var StartingDate = String.Format("{0:yyyy-dd-MM}", sd);
        DateTime StartingDate = DateTime.ParseExact(startDate.Text, "dd/MM/yyyy", null);
        DateTime Endingdate = DateTime.ParseExact(endDate.Text, "dd/MM/yyyy", null);

        SqlConnection con = new SqlConnection(RegconString);

        cmd = new SqlCommand("Sp_GetPatientInfo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@Doc_ID", SqlDbType.Int).Value = ddlEmployee.SelectedItem.Value;
        cmd.Parameters.AddWithValue("@StartDate", StartingDate);
        cmd.Parameters.AddWithValue("@EndDate", Endingdate.AddDays(1));
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        grdcode.DataSource = ds;
        grdcode.DataBind();
        //cmd.ExecuteNonQuery();
        con.Close(); 
    }
}