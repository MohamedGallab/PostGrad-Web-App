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
    public partial class StudentProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //connecting to the database
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);


            //creating the command to execute the procedure
            SqlCommand viewMyProfile = new SqlCommand("viewMyProfile", Connection);
            viewMyProfile.CommandType = CommandType.StoredProcedure;

            //passing paramters from inputs to the procedure
            viewMyProfile.Parameters.Add(new SqlParameter("@studentId", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);

            string temp = "";
            Connection.Open();
            SqlDataReader reader = viewMyProfile.ExecuteReader();
            while (reader.Read())
            {
                temp += "ID : " + reader["id"].ToString() + "<br>";
                temp += "firstName : " + reader["firstName"].ToString() + "<br>";
                temp += "lastName : " + reader["lastName"].ToString() + "<br>";
                temp += "type : " + reader["type"].ToString() + "<br>";
                temp += "faculty : " + reader["faculty"].ToString() + "<br>";
                temp += "address : " + reader["address"].ToString() + "<br>";
                temp += "GPA : " + reader["GPA"].ToString() + "<br>";
                temp += "email : " + reader["email"].ToString() + "<br>";
            }
            Connection.Close();
            studentProf.Text = temp;
        }
    }
}