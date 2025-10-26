 using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
public partial class HR_TemplateType : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        grd.DataBind();
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        DbManager db = new DbManager();
        db.ExecuteNonQuery("uspInsertHrTemplateType", "HRConnectionString",
            new SqlParameter[] { new SqlParameter("@TypeName", txtboxTemplateType.Text),
                new SqlParameter("@Hospital_ID",Session["HospitalID"])
            });
        grd.DataBind();

    }
}