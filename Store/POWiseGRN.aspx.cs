using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_POWiseGRN : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            loadGrid();
        }
    }
    protected void loadGrid()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@PO_ID", Request.QueryString["PO_ID"]) };
        gvGRN.DataSource = dbMgr.ExecuteDataTable("uspGetPOGRNList", "STOREConnectionString", sqlParm);
        gvGRN.DataBind();
    }
}