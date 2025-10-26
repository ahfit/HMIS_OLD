using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Pt_EMR_FavoriteMedicineDoctorWise : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        DbManager manager = new DbManager();
        manager.ExecuteNonQuery("usp_InsertFavoriteMedicines", "TreatmentConnectionString",
            new SqlParameter[] { new SqlParameter("@SubDept_id", Session["SubDeptID"]),
            new SqlParameter("@MedicineCode_ID", hfName.Value),
        new SqlParameter("@CreatedBy", Session["emp_id"])
        });
        BindGrid();
        TextBox_specificMedicine.Text = "";
    }

    private void BindGrid()
    {
        DbManager dbmanager = new DbManager();
        DataTable dt  =dbmanager.ExecuteDataTable("DoctorFavoriteMedicines", "TreatmentConnectionString",
            new SqlParameter[] { new SqlParameter("@empid", Session["emp_id"]) });
        gvd.DataSource = dt;
        gvd.DataBind();
    }

}