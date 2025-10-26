/*
    =====================********======================================
     Developer Name          Muhammad Jahangir
     Design Approved  by     
     Web Designed By         
     Strating date           11 Jan , 2007  
     Modify date             11 Jan , 2007
     Language                C#.Net      
     Description             
     Session Value Require   
    
    ====================*********======================================
*/
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

public partial class dermatoms_mark : System.Web.UI.Page
{
    Encryption ENC = new Encryption();
   protected void Page_Load(object sender, EventArgs e)
    {
        Patientinfo();
        if (Session["YearlyNo"] == null || Session["registrationNo"] == null || Session["emp_id"] == null || Session["dept_id"] == null)// || Session["From"]== null)
        {
            Server.Transfer("../login.aspx");
        }
        try
        {   string clientQuerry = GridView1.Rows[0].Cells[0].Text.ToString();
            if (clientQuerry.Length > 0)
            {
             Label_flash.Text = "<OBJECT classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0' WIDTH=932 HEIGHT=533> <PARAM NAME=movie VALUE='../images_hacims/dermatomes_reciever.swf?" + clientQuerry + "'> <PARAM NAME=quality VALUE=high><PARAM NAME=bgcolor VALUE=#ffffff> <EMBED src='../images_hacims/dermatomes_reciever.swf?" + clientQuerry + "' quality=high WIDTH=932 HEIGHT=533 TYPE='application/x-shockwave-flash'></EMBED></OBJECT>";
            }
            else
            { 
                Label_flash.Text = "<OBJECT classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0' WIDTH=932 HEIGHT=533> <PARAM NAME=movie VALUE='../images_hacims/dermatomes.swf'> <PARAM NAME=quality VALUE=high><PARAM NAME=bgcolor VALUE=#ffffff> <EMBED src='../images_hacims/dermatomes.swf' quality=high WIDTH=932 HEIGHT=533 TYPE='application/x-shockwave-flash'></EMBED></OBJECT>"; 
            }
        }
        catch (Exception ex) 
        { 
            string str = ex.ToString(); 
            Label_flash.Text = "<OBJECT classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0' WIDTH=932 HEIGHT=533> <PARAM NAME=movie VALUE='../images_hacims/dermatomes.swf'> <PARAM NAME=quality VALUE=high><PARAM NAME=bgcolor VALUE=#ffffff> <EMBED src='../images_hacims/dermatomes.swf' quality=high WIDTH=932 HEIGHT=533 TYPE='application/x-shockwave-flash'></EMBED></OBJECT>";
        }
   }
  
   protected void Patientinfo()
   {
       int payid = Convert.ToInt32(Session["PayID"]);
       string regNo = Session["RegistrationNo"].ToString();
       PatientFaceSheet obj = new PatientFaceSheet();
       DataTable tbl = obj.GetData(regNo, payid);
       if (tbl.Rows.Count > 0)
       {
           DataRow row = tbl.Rows[0];
           lblPatientName.Text = row["Prefix"].ToString() + "." + ENC.Encrypt_Main(row["PFName"].ToString(), false) + " " + ENC.Encrypt_Main(row["PMName"].ToString(), false) + " " + ENC.Encrypt_Main(row["PLName"].ToString(), false);
           lblRelationName.Text = row["Prefix"].ToString() + "." + row["RFName"].ToString() + " " + row["RMName"].ToString() + " " + row["RLName"].ToString();
           lblMedicalRecord.Text = ENC.Encrypt_Main(row["RegNo"].ToString(), false);
           lblRoomNo.Text = row["Bed_No"].ToString();
           lblSex.Text = row["Gender"].ToString();
           lblRelation.Text = row["Relation"].ToString();
           lblDateAdmission.Text = row["RegDateTime"].ToString();
           lblDateOfDischarge.Text = row["DischargeDateTime"].ToString();
           lblAge.Text = row["Age"].ToString();
           lblPhone.Text = row["HomePhone"].ToString() + ", " + row["MobilePhone"].ToString();
           lblAddress.Text = row["House_No"].ToString() + " " + row["StreetAddress"].ToString() + " " + row["TehsilName"].ToString() + " , " + row["ProvinceName"].ToString() + " " + row["CountryName"].ToString();
           lblConsultantName.Text = row["Employee"].ToString();
           lblDeptName.Text = row["Dept_Name"].ToString();
           lblVisitNo.Text = Session["YearlyNo"].ToString();
       }
   }

}
