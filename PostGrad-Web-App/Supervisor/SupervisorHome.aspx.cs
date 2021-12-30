using PostGrad_Web_App.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad_Web_App
{
	public partial class SupervisorHome : System.Web.UI.Page
	{
		DBMaster dbm = new DBMaster();

		protected void Page_Load(object sender, EventArgs e)
		{
		}

        protected void OnEvaluate(object sender, EventArgs e)
        {
			//connecting to the database
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				//inputs
				String TSN = ThesisSerialNo.Text;
				String PRN = ProgressReportNo.Text;
				String Evaluation = Eval.Text;

				int EvaluationInt = Convert.ToInt32(Evaluation);
				//creating the command to execute the procedure
				SqlCommand evaluateProgressReport = new SqlCommand("EvaluateProgressReport", connection);
				evaluateProgressReport.CommandType = CommandType.StoredProcedure;
			
				Label successeful = new Label();
				try
				{
					//passing paramters from inputs to the procedure

					evaluateProgressReport.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = Convert.ToInt32(TSN);
					evaluateProgressReport.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = Convert.ToInt32(PRN);
					evaluateProgressReport.Parameters.Add(new SqlParameter("@supervisorID", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
					evaluateProgressReport.Parameters.Add(new SqlParameter("@evaluation", SqlDbType.Int)).Value = EvaluationInt;

					int noOfRecords = -1;
					if (EvaluationInt >= 0 && EvaluationInt <= 3)
					{
						noOfRecords = evaluateProgressReport.ExecuteNonQuery(); // this is where I run my stored procedure
						if (noOfRecords == -1)
						{
							successeful.Text = "Failed to evaluate, Inputs don't exsist!";
						}
						else
						{
							successeful.Text = "Evaluated successfully";
						}
						System.Diagnostics.Debug.WriteLine(noOfRecords);
					}
					else
                    {
						successeful.Text = "Evaluation must be between 0 and 3";
                    }
					
				}
				catch (FormatException FE)
				{
					successeful.Text = "Failed to evaluate, Invalid input";
					System.Diagnostics.Debug.WriteLine(FE);
				}
				catch (Exception es)
                {
					successeful.Text = "Failed to evaluate!";
				}
				
				evaluateSuccess.Controls.Add(successeful);
			}
		}
		
		protected void OnCancelThesis(object sender, EventArgs e)
        {
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				//inputs
				String TSN = ThesisSerialNo.Text;

				//creating the command to execute the procedure
				SqlCommand cancelThesis = new SqlCommand("CancelThesis", connection);
				cancelThesis.CommandType = CommandType.StoredProcedure;

				Label successeful = new Label();
				try
                {
					//passing paramters from inputs to the procedure
					cancelThesis.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = Convert.ToInt32(TSN);

					int noOfRecords = cancelThesis.ExecuteNonQuery(); // this is where I run my stored procedure

					if (noOfRecords == -1)
					{
						successeful.Text = "Last report evaluation is not 0. Thesis not canceled";
					}
					else
					{
						successeful.Text = "Canceled successfully";
					}
					System.Diagnostics.Debug.WriteLine(noOfRecords);
				}
				catch (FormatException FE)
				{
					successeful.Text = "Failed to evaluate, Invalid input";
					System.Diagnostics.Debug.WriteLine(FE);
				}
				CancelSuccess.Controls.Add(successeful);

			}
		}
	
		protected void OnListStudents(object sender, EventArgs e)
        {
			Response.Redirect("ListMyStudents.aspx");
        }
	}
}