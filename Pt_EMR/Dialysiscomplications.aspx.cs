using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pt_EMR_Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_Click(object sender, EventArgs e)
    {
        SqlConnection c = new SqlConnection(ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("insert into dialysiscomplication(name)values(@name)", c);
        c.Open();
        cmd.Parameters.AddWithValue("@name", txt.Text);
        cmd.ExecuteNonQuery();
        c.Close();
        txt.Text = string.Empty;
        gv.DataBind();
    }
}
