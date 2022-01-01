using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
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
			Boolean isGucian = Gucian.Checked;
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

			int newUserID;
			SqlCommand getRegisteredID = new SqlCommand("SELECT IDENT_CURRENT('PostGradUser')", Connection);
			if (firstName.Length == 0 || lastName.Length == 0 || pass.Length == 0 || fclty.Length == 0 || mail.Length == 0|| adrs.Length == 0|| mail.Length == 0)
			{
				RegisterMessage.Text = "Fill in all the fields";
			}
			else
			{
				Connection.Open();
				registerStudentProc.ExecuteNonQuery();
				newUserID = Convert.ToInt32(getRegisteredID.ExecuteScalar());
				Connection.Close();

				Session["userID"] = newUserID;
				FormsAuthentication.SetAuthCookie(newUserID.ToString(), false);
				Response.Redirect("StudentHome.aspx");
			}
		}
	}
}