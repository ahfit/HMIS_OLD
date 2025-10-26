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
            startDate.Value = DateTime.Now.AddDays(-1);
            endDate.Value = DateTime.Now;
            //divPop.Visible = true;
        }
    }



    //protected void ddlEmployee_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //ddlEmployee.Items.Clear();

    //    SqlConnection con = new SqlConnection(RegconString);

    //    cmd = new SqlCommand("Sp_GetPatientInfo", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.Add("@Doc_ID", SqlDbType.Int).Value = ddlEmployee.SelectedItem.Value;
    //    con.Open();
    //    SqlDataAdapter da = new SqlDataAdapter(cmd);
    //    DataSet ds = new DataSet();
    //    da.Fill(ds);
    //    grdcode.DataSource = ds;
    //    grdcode.DataBind();
    //    //cmd.ExecuteNonQuery();
    //    con.Close(); 
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
            int DoctorID = 2546;
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

    protected void ShowGrid()
    {
    //    DateTime sd = Convert.ToDateTime(startDate.Text);
    //    var StartingDate = String.Format("{0:yyyy-dd-MM}", sd);

    //    DateTime ed = Convert.ToDateTime(endDate.Text);
    //    var EndingDate = String.Format("{0:yyyy-dd-MM}", ed);

        DateTime StartingDate = DateTime.ParseExact(startDate.Text, "dd/MM/yyyy", null);
        DateTime Endingdate = DateTime.ParseExact(endDate.Text, "dd/MM/yyyy", null);

        string FNo = fileNo.Text;
        if(FNo == "")
        {
            FNo = "123";
        }
        string RNo = mrNo.Text;
        if (RNo == null)
        {
            RNo = "123";
        }
        string Phone = mobileNo.Text;
        if (Phone == null)
        {
            Phone = "123";
        }

        SqlConnection con = new SqlConnection(RegconString);

        cmd = new SqlCommand("Sp_GetGayniProfileInfo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@fileID", SqlDbType.Int).Value = Convert.ToInt32(FNo);
        cmd.Parameters.Add("@MRNo", SqlDbType.VarChar, 300).Value = RNo;
        cmd.Parameters.Add("@Phone", SqlDbType.VarChar,300).Value = Phone;
        cmd.Parameters.Add("@startDate", SqlDbType.DateTime).Value = StartingDate;
        cmd.Parameters.Add("@endDate", SqlDbType.DateTime).Value = Endingdate.AddDays(1);
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        grdcode.DataSource = ds;
        grdcode.DataBind();
        //cmd.ExecuteNonQuery();
        con.Close(); 

    }
    protected void ShowData()
    {
        DateTime StartingDate = DateTime.ParseExact(startDate.Text, "dd/MM/yyyy", null);
        DateTime EndingDate = DateTime.ParseExact(endDate.Text, "dd/MM/yyyy", null);

        string FNo = fileNo.Text;
        if (FNo == "")
        {
            FNo = "123";
        }
        string RNo = mrNo.Text;
        if (RNo == null)
        {
            RNo = "123";
        }
        string Phone = mobileNo.Text;
        if (Phone == null)
        {
            Phone = "123";
        }

        SqlConnection con = new SqlConnection(RegconString);

        cmd = new SqlCommand("Sp_GetGayniProfileInfo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@fileID", SqlDbType.Int).Value = Convert.ToInt32(FNo);
        cmd.Parameters.Add("@MRNo", SqlDbType.VarChar, 300).Value = RNo;
        cmd.Parameters.Add("@Phone", SqlDbType.VarChar, 300).Value = Phone;
        cmd.Parameters.Add("@startDate", SqlDbType.DateTime).Value = StartingDate;
        cmd.Parameters.Add("@endDate", SqlDbType.DateTime).Value = EndingDate.AddDays(1);
        //cmd.ExecuteNonQuery();

        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        var data = da.Fill(dt);
        if (data.Equals(0))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No Record Found')", true);
        }
        else
        {
            PName.Text = dt.Rows[0]["FullName"].ToString();
            PRelation.Text = dt.Rows[0]["Relation"].ToString();
            PRelationName.Text = dt.Rows[0]["RFName"].ToString();
            PFileNo.Text = dt.Rows[0]["PayID"].ToString();
            PMRNo.Text = dt.Rows[0]["RegNo"].ToString();
            PMobile.Text = dt.Rows[0]["MobilePhone"].ToString();
            PServiceDate.Text = dt.Rows[0]["ServiceDate"].ToString();
            PCosultant.Text = dt.Rows[0]["Consultant"].ToString();
            DID.Text = dt.Rows[0]["EmpID"].ToString();
            //PDateDelivery.Value = DateTime.Now;
            PPT.Text = "0";
            PDays.Text = "0";

            divPop.Visible = true;
            DID.Visible = false;
            PName.Enabled = false;
            PRelation.Enabled = false;
            PRelationName.Enabled = false;
            PFileNo.Enabled = false;
            PMRNo.Enabled = false;
            PMobile.Enabled = false;
            PServiceDate.Enabled = false;
            PCosultant.Enabled = false;
        }
        
        con.Close();
      
    }
    protected void SaveData()
    {
        //string DateDelivery = PDateDelivery.Text;
        DateTime ed;
        if (PDateDelivery.Text == "")
        {
            ed = Convert.ToDateTime("1900-00-00");
        }
        else
        {
            ed = Convert.ToDateTime(PDateDelivery.Text);
        }
        //var DateDelivery = String.Format("{0:yyyy-dd-MM}", ed);
        int DoctorID = Convert.ToInt32(DID.Text);
        string PatientName = PName.Text;
        string Relation = PRelation.Text;
        string RelationName = PRelationName.Text;

        int FileNo = Convert.ToInt32(PFileNo.Text);
        string MRNo = PMRNo.Text;
        string Phone = PMobile.Text;

        string ServiceDate = PServiceDate.Text;
        string Cosultant = PCosultant.Text;
        string Age = PAgee.Text;

        string Education = PEdu.Text;
        string BloodGroup = PBlood.Text;
        string PastHistory = PPH.Text;

        string FamilyHistory = PFH.Text;
   

        int PT = Convert.ToInt32(PPT.Text);
        string Locality = PLocality.Text;
        string District = PDist.Text;

        string DOA = doa.Text;
        int Days = Convert.ToInt32(PDays.Text);
        string MC = PMC.Text;

        string Case = PCase.Text;
        string Anesthesia = ddanesthesia.SelectedValue;
        string Indication = PIndication.Text;

        string Babywt = PBabywt.Text;
        string BGender = ddgender.Text;

        string TD = PTD.Text;
        //string DateDelivery = PDateDelivery.Text;
        string AS = PAS.Text;
        string BOutcome = PBOutcome.Text;

        string AdmNo = PAdmNo.Text;
        string BDiagnosis = PBDiagnosis.Text;
        string Duration = PDuration.Text;

        string consultant = PCosultant.Text;
        string g = ObsG.Text;
        string p = ObsP.Text;
        string a = ObsA.Text;
        string Trim = "";
        string hb = "";
        string pt = "";
        string lasthb = hbt.Text;
        string hep = hept.Text;
        string marriageDate = WebDateTimeEdit_DOB.Text;
        string DateValue = textboxage.Text;
        string DateString = DropDownListBIndicator.Text;
        //bool IsActive1 = true;
        //bool IsDeleted1 = false;
        SqlConnection connections = new SqlConnection(RegconString);
        string query = "INSERT INTO GayniProfile (PatientName, Relation, RelationName, FileNo, MRNo, MobileNo, ServiceDate, DoctorID, Age, Education, BloodGroup, PastHistory,FamilyHistory,Ptwt,Locality,District,DOA,Days,MedicalCondition,PCase,Anesthesia,Indication,BabyWt,BabyGender,DateOfDelivery,ApgarScore,BabyOutcome,NNAdmNo,BabyDignosis,Duration,Consultan,ObsHistG,ObsHistP,ObsHistA,Trim,HB,LastHB,HEP,MarriageDate,DateValue,MarriageDateString) VALUES (@PatientName, @Relation, @RelationName, @FileNo, @MRNo, @Phone, @ServiceDate, @DoctorID, @Age, @Education, @BloodGroup,@PastHistory,@FamilyHistory,@PT,@Locality,@District,@DOA,@Days,@MC,@Case,@Anesthesia,@Indication,@Babywt,@BGender,@DateDelivery,@AS,@BOutcome,@AdmNo,@BDiagnosis,@Duration,@Consultant,@ObsHistG,@ObsHistP,@ObsHistA,@Trim,@HB,@LastHB,@HEP,@MarriageDate,@DateValue,@MarriageDateString)";

         using (SqlCommand command = new SqlCommand(query, connections))
         {
             command.Parameters.Add("@PatientName", SqlDbType.VarChar, 500).Value = PatientName;
             command.Parameters.Add("@Relation", SqlDbType.VarChar, 100).Value = Relation;
             command.Parameters.Add("@RelationName", SqlDbType.VarChar, 300).Value = RelationName;
             command.Parameters.Add("@FileNo", SqlDbType.Int).Value = FileNo;
             command.Parameters.Add("@MRNo", SqlDbType.VarChar, 300).Value = MRNo;
             command.Parameters.Add("@Phone", SqlDbType.VarChar, 300).Value = Phone;
             command.Parameters.Add("@ServiceDate", SqlDbType.VarChar, 200).Value = ServiceDate;
             command.Parameters.Add("@DoctorID", SqlDbType.Int).Value = DoctorID;
             command.Parameters.Add("@Age", SqlDbType.VarChar, 200).Value = Age;
             command.Parameters.Add("@Education", SqlDbType.VarChar, 200).Value = Education;
             command.Parameters.Add("@BloodGroup", SqlDbType.VarChar, 200).Value = BloodGroup;
             command.Parameters.Add("@PastHistory", SqlDbType.VarChar, 200).Value = PastHistory;
             command.Parameters.Add("@FamilyHistory", SqlDbType.VarChar,300).Value = FamilyHistory;
             //command.Parameters.Add("@PatientVisits", SqlDbType.VarChar, 300).Value = Trim;

             //command.Parameters.Add("@HB", SqlDbType.VarChar, 200).Value = FamilyHistory;
             command.Parameters.Add("@PT", SqlDbType.Int).Value = PT;
             command.Parameters.Add("@Locality", SqlDbType.VarChar, 200).Value = Locality;
             command.Parameters.Add("@District", SqlDbType.VarChar,300).Value = District;
             command.Parameters.Add("@DOA", SqlDbType.VarChar, 300).Value = DOA;
             command.Parameters.Add("@Days", SqlDbType.Int).Value = Days;
             command.Parameters.Add("@MC", SqlDbType.VarChar, 200).Value = MC;
             command.Parameters.Add("@Case", SqlDbType.VarChar, 200).Value = Case;
             command.Parameters.Add("@Anesthesia", SqlDbType.VarChar,300).Value = Anesthesia;
             command.Parameters.Add("@Indication", SqlDbType.VarChar, 300).Value = Indication;

              command.Parameters.Add("@Babywt", SqlDbType.VarChar, 200).Value = Babywt;
             command.Parameters.Add("@BGender", SqlDbType.VarChar, 200).Value = BGender;
             command.Parameters.Add("@DateDelivery", SqlDbType.DateTime,300).Value = ed;
             //command.Parameters.Add("@TD", SqlDbType.Int).Value = TD;
             command.Parameters.Add("@AS", SqlDbType.VarChar, 300).Value = AS;
              command.Parameters.Add("@BOutcome", SqlDbType.VarChar, 200).Value = BOutcome;
             command.Parameters.Add("@AdmNo", SqlDbType.VarChar, 200).Value = AdmNo;
             command.Parameters.Add("@BDiagnosis", SqlDbType.VarChar, 200).Value = BDiagnosis;
             command.Parameters.Add("@Duration", SqlDbType.VarChar,300).Value = Duration;

             command.Parameters.Add("@Consultant", SqlDbType.VarChar, 300).Value = consultant;
             command.Parameters.Add("@ObsHistG", SqlDbType.VarChar, 200).Value = ObsG.Text;
             command.Parameters.Add("@ObsHistP", SqlDbType.VarChar, 200).Value = ObsP.Text;
             command.Parameters.Add("@ObsHistA", SqlDbType.VarChar, 200).Value = ObsA.Text;
             command.Parameters.Add("@Trim", SqlDbType.VarChar, 300).Value = Trim;

             command.Parameters.Add("@HB", SqlDbType.VarChar, 300).Value = hb;
             command.Parameters.Add("@LastHB", SqlDbType.VarChar, 200).Value = lasthb;
             command.Parameters.Add("@HEP", SqlDbType.VarChar, 200).Value = hep;
             command.Parameters.Add("@MarriageDate", SqlDbType.VarChar, 200).Value = marriageDate;
             command.Parameters.Add("@DateValue", SqlDbType.VarChar, 300).Value = DateValue;
             command.Parameters.Add("@MarriageDateString", SqlDbType.VarChar, 300).Value = DateString;

             connections.Open();
             int rowAffected = command.ExecuteNonQuery();
             if (rowAffected != 0)
             {
                 ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Data Saved Successfully')", true);
                 divPop.Visible = false;
                 fileNo.Text = "";
                 startDate.Value = DateTime.Now.AddDays(-1);
                 endDate.Value = DateTime.Now;
                 //this.grdcode.SelectedRow.Visible = false;
             }
            
         }

       
    }
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //divPop.Visible = true;
        ShowData();
      //  ShowGrid();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }
    protected void ddtrim_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddtrim.Text == "")
        {
            hbl.Visible = false;
            hbt.Visible = false;
            ptl.Visible = false;
            ptt.Visible = false;
            lhbl.Visible = false;
            hl.Visible = false;
            hept.Visible = false;
            countLabel.Visible = false;
            countText.Visible = false;
            countText.Visible = false;
            ddtrimvisit.Visible = false;
            //InputTextBox3.Visible = false;
        }

        else if (ddtrim.Text == "1st Trim")
        {
            hbl.Visible = true;
            hbt.Visible = true;
            ptl.Visible = true;
            ptt.Visible = true;
            lhbl.Visible = false;
            hl.Visible = false;
            hept.Visible = false;
            countLabel.Visible = true;
            countText.Visible = true;
            countText.Visible = true;
            ddtrimvisit.Visible = true;
        }
        else if (ddtrim.Text == "2nd Trim")
        {
            hbl.Visible = true;
            hbt.Visible = true;
            ptl.Visible = true;
            ptt.Visible = true;
            hl.Visible = false;
            hept.Visible = false;
            lhbl.Visible = false;
            countLabel.Visible = true;
            countText.Visible = true;
            countText.Visible = true;
            ddtrimvisit.Visible = true;
        }
        else if (ddtrim.Text == "3rd Trim")
        {
            hbl.Visible = false;
            lhbl.Visible = true;
            hbt.Visible = true;
            ptl.Visible = true;
            ptt.Visible = true;
            hl.Visible = true;
            hept.Visible = true;
            countLabel.Visible = true;
            countText.Visible = true;
            countText.Visible = true;
            ddtrimvisit.Visible = true;
        }
    }
    protected void ddtrimvisit_SelectedIndexChanged(object sender, EventArgs e)
    {
        //int MachineID = Convert.ToInt32(ddlMachine.SelectedValue);
        //int TCID = Convert.ToInt32(ddTestComponent.SelectedValue);

        SqlConnection connections = new SqlConnection(RegconString);
        string query = "INSERT INTO GayniProfileTrims (MRNo,Count,HB,PT,HEP,Trim) VALUES (@MRNo,@Count, @HB, @PT,@HEP,@Trim)";
        using (SqlCommand command = new SqlCommand(query, connections))
        {
            command.Parameters.Add("@MRNo", SqlDbType.VarChar,300).Value = PMRNo.Text;
            command.Parameters.Add("@Count", SqlDbType.Int).Value = 2;
            command.Parameters.Add("@HB", SqlDbType.VarChar, 300).Value = hbt.Text;
            command.Parameters.Add("@PT", SqlDbType.VarChar, 300).Value = ptt.Text;
            command.Parameters.Add("@HEP", SqlDbType.VarChar, 300).Value = hept.Text;
            command.Parameters.Add("@Trim", SqlDbType.VarChar,300).Value = ddtrimvisit.Text;

            connections.Open();
            int rowAffected = command.ExecuteNonQuery();
            if (rowAffected != 0)
            {
                hbl.Visible = false;
                hbt.Visible = false;
                ptl.Visible = false;
                ptt.Visible = false;
                lhbl.Visible = false;
                hl.Visible = false;
                hept.Visible = false;
                countLabel.Visible = false;
                countText.Visible = false;
                countText.Visible = false;
                ddtrimvisit.Visible = false;
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Inserted Successfully')", true);
                //this.grdcode.SelectedRow.Visible = false;
            }
            //this.grdcode.SelectedRow.Enabled = false;
 

        }
    }
}