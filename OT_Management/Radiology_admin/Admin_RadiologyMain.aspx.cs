using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Administrator_RadiologyMain : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
     ValidateMainPage();
    }
    protected void ImageButtonDailyreport_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("../Rd_Body_part.aspx");
    }
    protected void ImageButtonTestSubGroup_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("../Rd_Projection.aspx");
    }
    protected void ImageButtonTest_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("../Rd_Xray_entry.aspx");
    }
    protected void  ImageButtonlogout_Click(object sender, ImageClickEventArgs e)
     {
         Session.RemoveAll();
     }

    protected void ImageButtonRDMainGroup_Click(object sender, ImageClickEventArgs e)
    {

    }

  
    protected void  ValidateMainPage()
    {
        try
        {
     //Validate_Pages_for_admin validate_Page  ;
     //int empid = (int)Session["Emp_ID"];
    // string a = Convert.ToString(Session["Emp_ID"]);
     //int empid = Convert.ToInt32(a);
     int empid = (int)Session["Emp_ID"];
          //int i = validate.Validate_Main_pages(empid , "Administrator/PhysicalExamMain.aspx");
          //  if (i == 0 )
          //  {
          //      Response.Redirect("../Loginnew.aspx");
          //      }
          //  else
          //  {
          //      ;
          //  }

           
        }
        catch (Exception ex   )
            {
                    Response.Write(ex.Message);
            }

        
      //  Catch  Exception ex
      //      Response.Write(ex.Message)
      //  End Try 
    
    
    }
          
}
