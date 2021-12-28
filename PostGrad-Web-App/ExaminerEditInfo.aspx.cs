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
    public partial class ExaminerEditInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void ConfirmName_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);
            String newName = EditNameB.Text;
            SqlCommand examinerChangeNameProc = new SqlCommand("ExaminerEditName", Connection);
            examinerChangeNameProc.CommandType = CommandType.StoredProcedure;
            examinerChangeNameProc.Parameters.Add(new SqlParameter("@id", SqlDbType.VarChar)).Value = Session["userID"];
            examinerChangeNameProc.Parameters.Add(new SqlParameter("@newName", SqlDbType.VarChar)).Value = newName;

            Connection.Open();
            examinerChangeNameProc.ExecuteNonQuery();
            Connection.Close();
        }

        protected void ConfirmPassword_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);
            String newPassword = EditPasswordB.Text;
            SqlCommand examinerChangePasswordProc = new SqlCommand("ExaminerEditPassword", Connection);
            examinerChangePasswordProc.CommandType = CommandType.StoredProcedure;
            examinerChangePasswordProc.Parameters.Add(new SqlParameter("@id", SqlDbType.VarChar)).Value = Session["userID"];
            examinerChangePasswordProc.Parameters.Add(new SqlParameter("@newPassword", SqlDbType.VarChar)).Value = newPassword;

            Connection.Open();
            examinerChangePasswordProc.ExecuteNonQuery();
            Connection.Close();
        }

        protected void ConfirmEmail_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);
            String newEmail = EditEmailB.Text;
            SqlCommand examinerChangeEmailProc = new SqlCommand("ExaminerEditEmail", Connection);
            examinerChangeEmailProc.CommandType = CommandType.StoredProcedure;
            examinerChangeEmailProc.Parameters.Add(new SqlParameter("@id", SqlDbType.VarChar)).Value = Session["userID"];
            examinerChangeEmailProc.Parameters.Add(new SqlParameter("@newEmail", SqlDbType.VarChar)).Value = newEmail;

            Connection.Open();
            examinerChangeEmailProc.ExecuteNonQuery();
            Connection.Close();
        }

        protected void ConfirmNational_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);
            Boolean isNational = NationalC.Checked; 
            SqlCommand examinerChangeNationalProc = new SqlCommand("ExaminerEditNational", Connection);
            examinerChangeNationalProc.CommandType = CommandType.StoredProcedure;
            examinerChangeNationalProc.Parameters.Add(new SqlParameter("@id", SqlDbType.VarChar)).Value = Session["userID"];
            examinerChangeNationalProc.Parameters.Add(new SqlParameter("@newEmail", SqlDbType.VarChar)).Value = isNational;

            Connection.Open();
            examinerChangeNationalProc.ExecuteNonQuery();
            Connection.Close();
        }

        protected void ConfirmFieldOfWork_Click(object sender, EventArgs e)
        {

        }

        protected void BackFromEditInfoB_Click(object sender, EventArgs e)
        {

        }
    }
}