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
	public partial class ExaminerHome : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            //connecting to the database
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);
            //creating the command to execute the procedure
            SqlCommand viewExaminerProfile = new SqlCommand("ExaminerViewProfile", Connection);
            viewExaminerProfile.CommandType = CommandType.StoredProcedure;
            //passing paramters from inputs to the procedure
            viewExaminerProfile.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);

            string temp = "";
            Connection.Open();
            SqlDataReader reader = viewExaminerProfile.ExecuteReader();
            while (reader.Read())
            {
                temp += "ID: " + reader["id"].ToString() + "<br>";
                temp += "Name: " + reader["name"].ToString() + "<br>";
                temp += "Field of Work: " + reader["fieldOfWork"].ToString() + "<br>";
                temp += "National: : " + (bool)reader["isNational"] + "<br>";
                temp += "Email: : " + reader["email"] + "<br>";
                temp += "Password: : " + reader["password"] + "<br>";
            }
            Connection.Close();
            ExaminerProfile.Text = temp;
        }


        protected void EditInfo_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("ExaminerEditInfo.aspx");
        }

        protected void ViewInfo_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("ExaminerViewInfo.aspx");
        }

        protected void evaluate_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("ExaminerEvaluate.aspx");
        }

        protected void lookUpThesis_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("ExaminerLookUp.aspx");
        }

        protected void ViewProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerProfile.aspx");
        }

        protected void ExaminerLogOut_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}