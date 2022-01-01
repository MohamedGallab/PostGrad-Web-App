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
	public partial class StudentHome : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void AddMobileClicked(object sender, EventArgs e)
		{
			String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
			SqlConnection Connection = new SqlConnection(ConnectionString);

			SqlCommand getStudent = new SqlCommand();
			getStudent.Connection = Connection;
			getStudent.CommandText = "SELECT * FROM PostGradUser WHERE email = '" + Session["user"] + "' ";
			Connection.Open();

			SqlDataReader reader;
			reader = getStudent.ExecuteReader();
			int i = 0;
			int id = -1;
			while (reader.Read())
			{
				id = (int)reader[0];
				System.Diagnostics.Debug.WriteLine(reader[i]);
				i += 1;
			}
			reader.Close();
			System.Diagnostics.Debug.WriteLine(Session["user"]);

			SqlCommand addMobileProc = new SqlCommand("addMobile", Connection);
			addMobileProc.CommandType = CommandType.StoredProcedure;

			addMobileProc.Parameters.Add(new SqlParameter("@id", SqlDbType.VarChar)).Value = id;
			addMobileProc.Parameters.Add(new SqlParameter("@mobile_number", SqlDbType.VarChar)).Value = mobileNumber.Text;
			addMobileProc.ExecuteNonQuery();
			Connection.Close();
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