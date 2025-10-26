using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
public partial class Pt_EMR_ForRadialogyImageControl : System.Web.UI.UserControl
{
    String Conster = ConfigurationManager.ConnectionStrings["RadiologyConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();

            DirectoryInfo di = new DirectoryInfo(Server.MapPath("~/pt_EMR/Images"));

            foreach (FileInfo file in di.GetFiles())
            {
                file.Delete();
            }

        }
    }


    private void LoadData()
    {
        int Yearly = 0,TB_ID=0;
        if (!string.IsNullOrEmpty(Session["YearlyNo"] as string))
        {
            Yearly = Convert.ToInt32(Session["YearlyNo"]);
        }
        if (!string.IsNullOrEmpty(Session["TBID"] as string))
        {
            TB_ID = Convert.ToInt32(Session["TBID"]);
        }

        DataSet ds = new DataSet();
        DbManager manager = new DbManager();
        ds = manager.ExecuteDataSet("Report_GetPatientRadiologyTestResults", "RadiologyConnectionString", new SqlParameter[]
        {
            new SqlParameter() { ParameterName = "@TBId", Value = TB_ID} ,
            new SqlParameter() { ParameterName = "@YearlyNo", Value = Yearly }
        });
        ddlImages.DataSource = ds.Tables[0];
        ddlImages.DataBind();
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertUser", "enlargeImage()", false);
        

    }





    protected void ddlImages_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drv = e.Item.DataItem as DataRowView;
            if (drv != null)
            {
                System.Web.UI.WebControls.Image RadImage = (System.Web.UI.WebControls.Image)e.Item.FindControl("RadImage");
                HtmlAnchor anchorImg = (HtmlAnchor)e.Item.FindControl("anchorImg");

                byte[] image = (byte[])drv["ImageFile"];
                string base64 = Convert.ToBase64String(image);
                RadImage.ImageUrl = "data:Image/png;base64," + base64;
                RadImage.Attributes.Add("onclick", "enlargeImage()");


                byte[] imageBytes = Convert.FromBase64String(base64);
                MemoryStream ms = new MemoryStream(imageBytes, 0, imageBytes.Length);
                ms.Write(imageBytes, 0, imageBytes.Length);
                System.Drawing.Image image1 = System.Drawing.Image.FromStream(ms, true);

                Guid id = Guid.NewGuid();

                image1.Save(Server.MapPath("~/pt_EMR/Images/RadiologyImage" + id + ".png"));
                anchorImg.HRef = "~/pt_EMR/Images/RadiologyImage" + id + ".png";


            }
        }
    }

    protected void btn_Show_Image_Click(object sender, EventArgs e)
    {
        LoadData();

    }
}