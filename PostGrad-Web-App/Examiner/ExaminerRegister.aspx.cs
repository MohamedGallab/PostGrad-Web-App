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
	public partial class ExaminerRegister : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void RegisterBtn_Click(object sender, EventArgs e)
		{
			String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();

			SqlConnection Connection = new SqlConnection(ConnectionString);

			String firstName = name.Text;
			String pass = password.Text;
			String mail = email.Text;
			Boolean nationality = isNational.Checked;
			String fldOfWork = fieldOfWork.Text;

			SqlCommand examinerRegisterProc = new SqlCommand("examinerRegister", Connection);
			examinerRegisterProc.CommandType = CommandType.StoredProcedure;

			examinerRegisterProc.Parameters.Add(new SqlParameter("@ExaminerName", SqlDbType.VarChar)).Value = firstName;
			examinerRegisterProc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = pass;
			examinerRegisterProc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;
			examinerRegisterProc.Parameters.Add(new SqlParameter("@fieldOfWork", SqlDbType.VarChar)).Value = fldOfWork;
			examinerRegisterProc.Parameters.Add(new SqlParameter("@National", SqlDbType.Bit)).Value = nationality;

			int newUserID;
			SqlCommand getRegisteredID = new SqlCommand("SELECT IDENT_CURRENT('PostGradUser')", Connection);
			if (firstName.Length == 0 || pass.Length == 0 || mail.Length == 0 || fldOfWork.Length == 0)
			{
				RegisterMessage.Text = "Fill in all the fields";
			}
			else
			{
				Connection.Open();
				examinerRegisterProc.ExecuteNonQuery();
				newUserID = Convert.ToInt32(getRegisteredID.ExecuteScalar());
				//System.Diagnostics.Debug.WriteLine(newUserID);
				Connection.Close();

				Session["userID"] = newUserID;
				FormsAuthentication.SetAuthCookie(newUserID.ToString(), false);
				Response.Redirect("ExaminerHome.aspx");
			}
		}
	}
}