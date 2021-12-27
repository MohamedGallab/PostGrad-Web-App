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
	public partial class StudentRegister : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void RegisterBtnClicked(object sender, EventArgs e)
		{
			String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();

			SqlConnection Connection = new SqlConnection(ConnectionString);

			String firstName = first_name.Text;
			String lastName = last_name.Text;
			String pass = password.Text;
			String fclty = faculty.Text;
			String isGucian = Gucian.Text;
			String mail = email.Text;
			String adrs = address.Text;

			SqlCommand registerStudentProc = new SqlCommand("studentRegister", Connection);
			registerStudentProc.CommandType = CommandType.StoredProcedure;

			registerStudentProc.Parameters.Add(new SqlParameter("@first_name", SqlDbType.VarChar)).Value = firstName;
			registerStudentProc.Parameters.Add(new SqlParameter("@last_name", SqlDbType.VarChar)).Value = lastName;
			registerStudentProc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = pass;
			registerStudentProc.Parameters.Add(new SqlParameter("@faculty", SqlDbType.VarChar)).Value = fclty;
			registerStudentProc.Parameters.Add(new SqlParameter("@Gucian", SqlDbType.Bit)).Value = isGucian;
			registerStudentProc.Parameters.Add(new SqlParameter("@address", SqlDbType.VarChar)).Value = adrs;
			registerStudentProc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;
			

			Connection.Open();
			registerStudentProc.ExecuteNonQuery();
			Connection.Close();

			Session["user"] = mail;
			Response.Redirect("StudentHome.aspx");
		}
	}
}