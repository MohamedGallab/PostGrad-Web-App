using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using PostGrad_Web_App.App_Code;

namespace PostGrad_Web_App
{
	public partial class StudentHome : System.Web.UI.Page
	{
		DBMaster dbm = new DBMaster();

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void AddMobileClicked(object sender, EventArgs e)
		{	

			using (SqlConnection connection = dbm.GetSqlConnection())
			{
                //creating the command to execute the procedure

                SqlCommand addMobile = new SqlCommand("addMobile", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                
				Label successeful = new Label();
				try
				{
					//passing paramters from inputs to the procedure
					addMobile.Parameters.Add(new SqlParameter("@ID", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
					addMobile.Parameters.Add(new SqlParameter("@mobile_number", SqlDbType.VarChar)).Value = mobileNumber.Text;

					int noOfRecords = addMobile.ExecuteNonQuery(); // this is where I run my stored procedure

					if (noOfRecords == -1)
					{
						successeful.Text = "Phone Number not added!";
					}
					else
					{
						successeful.Text = "Phone Number added Sucessfully!";
					}
				}
				catch (Exception ex)
				{
					successeful.Text = "Failed to evaluate, Phone Number already exists";
					System.Diagnostics.Debug.WriteLine(ex);
				}
				MobileSuccess.Controls.Add(successeful);
			}
		}

		protected void publication_Click(object sender, EventArgs e)
		{
			Response.Redirect("StudentPublication.aspx");
		}

		protected void progressReport_Click(object sender, EventArgs e)
		{
			Response.Redirect("StudentProgressReport.aspx");

		}

		protected void courses_Click(object sender, EventArgs e)
		{
			Response.Redirect("StudentCourses.aspx");

		}

		protected void theses_Click(object sender, EventArgs e)
		{
			Response.Redirect("StudentTheses.aspx");

		}

		protected void profile_Click(object sender, EventArgs e)
		{
			Response.Redirect("StudentProfile.aspx");

		}
	}
}