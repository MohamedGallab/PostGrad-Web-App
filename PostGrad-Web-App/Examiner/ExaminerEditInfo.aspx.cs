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
            if (newName == "")
            {
                responseL.Text = "Name can't be empty.";
            }
            else
            {
                SqlCommand examinerChangeNameProc = new SqlCommand("ExaminerEditName", Connection);
                examinerChangeNameProc.CommandType = CommandType.StoredProcedure;
                examinerChangeNameProc.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
                examinerChangeNameProc.Parameters.Add(new SqlParameter("@newName", SqlDbType.VarChar)).Value = newName;

                Connection.Open();
                try
                {

                    if (examinerChangeNameProc.ExecuteNonQuery() == -1)
                    {
                        throw new Exception("Your ID is wrong, Please re-login.");
                    }
                    responseL.Text = "Name Change Successeeded.";
                }
                catch (FormatException)
                {
                    responseL.Text = "Please write a valid name.";
                }
                catch (Exception ex)
                {
                    responseL.Text = ex.Message;
                }
                Connection.Close();
            }
        }

        protected void ConfirmPassword_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);
            String newPassword = EditPasswordB.Text;
            if (newPassword == "")
            {
                responseL.Text = "Password can't be Empty.";
            }
            else
            {
                SqlCommand examinerChangePasswordProc = new SqlCommand("ExaminerEditPassword", Connection);
                examinerChangePasswordProc.CommandType = CommandType.StoredProcedure;
                examinerChangePasswordProc.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
                examinerChangePasswordProc.Parameters.Add(new SqlParameter("@newPassword", SqlDbType.VarChar)).Value = newPassword;

                Connection.Open();
                try
                {

                    if (examinerChangePasswordProc.ExecuteNonQuery() == -1)
                    {
                        throw new Exception("Your ID is wrong, Please re-login.");
                    }
                    responseL.Text = "Password Change Successeeded.";
                }
                catch (FormatException)
                {
                    responseL.Text = "Please write a valid password.";
                }
                catch (Exception ex)
                {
                    responseL.Text = ex.Message;
                }
                Connection.Close();
            }
        }

        protected void ConfirmEmail_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);
            String newEmail = EditEmailB.Text;
            if (newEmail == "")
            {
                responseL.Text = "Email can't be empty.";
            }
            else
            {
                SqlCommand examinerChangeEmailProc = new SqlCommand("ExaminerEditEmail", Connection);
                examinerChangeEmailProc.CommandType = CommandType.StoredProcedure;
                examinerChangeEmailProc.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
                examinerChangeEmailProc.Parameters.Add(new SqlParameter("@newEmail", SqlDbType.VarChar)).Value = newEmail;

                Connection.Open();
                try
                {

                    if (examinerChangeEmailProc.ExecuteNonQuery() == -1)
                    {
                        throw new Exception("Your ID is wrong, Please re-login.");
                    }
                    responseL.Text = "Email Change Successeeded.";
                }
                catch (FormatException)
                {
                    responseL.Text = "Please write a valid email.";
                }
                catch (Exception ex)
                {
                    responseL.Text = ex.Message;
                }
                Connection.Close();
            }
        }

        protected void ConfirmNational_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);
            Boolean isNational = NationalC.Checked; 
            SqlCommand examinerChangeNationalProc = new SqlCommand("ExaminerEditNational", Connection);
            examinerChangeNationalProc.CommandType = CommandType.StoredProcedure;
            examinerChangeNationalProc.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
            examinerChangeNationalProc.Parameters.Add(new SqlParameter("@newIsNational", SqlDbType.Bit)).Value = isNational;

            Connection.Open();
            try
            {

                if (examinerChangeNationalProc.ExecuteNonQuery() == -1)
                {
                    throw new Exception("Your ID is wrong, Please re-login.");
                }
                responseL.Text = "National status Change Successeeded.";
            }
            catch (FormatException)
            {
                responseL.Text = "Please enter a valid option.";
            }
            catch (Exception ex)
            {
                responseL.Text = ex.Message;
            }
            Connection.Close();
        }

        protected void ConfirmFieldOfWork_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);
            String newFieldOfWork = EditFieldOfWorkB.Text;
            if (newFieldOfWork == "")
            {
                responseL.Text = "Field Of Work can't be Empty.";
            }
            else
            {
                SqlCommand examinerChangeFieldOfWorkProc = new SqlCommand("ExaminerEditFieldOfWork", Connection);
                examinerChangeFieldOfWorkProc.CommandType = CommandType.StoredProcedure;
                examinerChangeFieldOfWorkProc.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
                examinerChangeFieldOfWorkProc.Parameters.Add(new SqlParameter("@newFieldOfWork", SqlDbType.VarChar)).Value = newFieldOfWork;

                Connection.Open();
                try
                {

                    if (examinerChangeFieldOfWorkProc.ExecuteNonQuery() == -1)
                    {
                        throw new Exception("Your ID is wrong, Please re-login.");
                    }
                    responseL.Text = "Field of work change Successeeded.";
                }
                catch (FormatException)
                {
                    responseL.Text = "Please enter a valid field of work.";
                }
                catch (Exception ex)
                {
                    responseL.Text = ex.Message;
                }
                Connection.Close();
            }
        }

        protected void BackFromEditInfoB_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerHome.aspx");
        }
    }
}