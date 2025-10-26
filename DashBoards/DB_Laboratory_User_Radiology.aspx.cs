using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DashBoards_DB_Laboratory_User_Radiology : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadHaematologyReport();
            LoadHeamatologyAmountReport();
            
        }
    }

    protected void LoadHaematologyReport()
    {
        SqlDataSource1.SelectParameters["Date_From"].DefaultValue = DateTime.Now.AddYears(-5).ToString("yyyy-MM-dd");
        SqlDataSource1.SelectParameters["Date_To"].DefaultValue = DateTime.Now.ToString("yyyy-MM-dd");
        gvIPDOPDGroupSummary.DataBind();
        Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;
        
        
    }

    protected void LoadHeamatologyAmountReport()
    {
        SqlDataSource2.SelectParameters["Date_From"].DefaultValue =DateTime.Now.AddYears(-5).ToString("yyyy-MM-dd");
        SqlDataSource2.SelectParameters["Date_To"].DefaultValue = DateTime.Now.ToString("yyyy-MM-dd");
        gvIPDOPDGroupAmountSummary.DataBind();
        Chart2.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;
        
    }

    
    
}