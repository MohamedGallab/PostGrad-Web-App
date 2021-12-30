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
		protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void OnEvaluate(object sender, EventArgs e)
        {
			//connecting to the database
			String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
			SqlConnection Connection = new SqlConnection(ConnectionString);

			//inputs
			String TSN = ThesisSerialNo.Text;
			String PRN = ProgressReportNo.Text;
			String Evaluation = Eval.Text;

			//creating the command to execute the procedure
			SqlCommand evaluateProgressReport = new SqlCommand("EvaluateProgressReport", Connection);
			evaluateProgressReport.CommandType = CommandType.StoredProcedure;

			//passing paramters from inputs to the procedure
			evaluateProgressReport.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = Convert.ToInt32(TSN);
			evaluateProgressReport.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = Convert.ToInt32(PRN);
			evaluateProgressReport.Parameters.Add(new SqlParameter("@supervisorID", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
			evaluateProgressReport.Parameters.Add(new SqlParameter("@evaluation", SqlDbType.Int)).Value = Convert.ToInt32(Evaluation);
			
			//executing the procudeure
			Connection.Open();
			evaluateProgressReport.ExecuteNonQuery();
			Connection.Close();

			//System.Diagnostics.Debug.WriteLine("hey");
		}
	}
}