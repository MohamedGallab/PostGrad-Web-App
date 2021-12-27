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
	public partial class SupervisorRegister : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void RegisterBtn_Click(object sender, EventArgs e)
		{
			String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();

			SqlConnection Connection = new SqlConnection(ConnectionString);

			String firstName = first_name.Text;
			String lastName = last_name.Text;
			String pass = password.Text;
			String fclty = faculty.Text;
			String mail = email.Text;

			SqlCommand supervisorRegisterProc = new SqlCommand("supervisorRegister", Connection);
			supervisorRegisterProc.CommandType = CommandType.StoredProcedure;

			supervisorRegisterProc.Parameters.Add(new SqlParameter("@first_name", SqlDbType.VarChar)).Value = firstName;
			supervisorRegisterProc.Parameters.Add(new SqlParameter("@last_name", SqlDbType.VarChar)).Value = lastName;
			supervisorRegisterProc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = pass;
			supervisorRegisterProc.Parameters.Add(new SqlParameter("@faculty", SqlDbType.VarChar)).Value = fclty;
			supervisorRegisterProc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;


			Connection.Open();
			supervisorRegisterProc.ExecuteNonQuery();
			Connection.Close();

			Session["user"] = mail;
			Response.Redirect("SupervisorHome.aspx");
		}
	}
}