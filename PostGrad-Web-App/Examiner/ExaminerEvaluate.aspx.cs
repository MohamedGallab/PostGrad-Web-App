﻿using System;
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
    public partial class ExaminerEvaluate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            

        }

        protected void GradeDefense_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);

            DateTime defenseDate = DateTime.Parse(DefenseDateB.Text);
            int defenseNumber = int.Parse(DefenseNoB.Text);

            SqlCommand checkDefense = new SqlCommand("ExaminerSearchDefense", Connection);
            checkDefense.CommandType = CommandType.StoredProcedure;

            checkDefense.Parameters.Add(new SqlParameter("@serialNo", SqlDbType.Int)).Value = defenseNumber;
            checkDefense.Parameters.Add(new SqlParameter("@date", SqlDbType.DateTime)).Value = defenseDate;

            SqlParameter success = checkDefense.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = System.Data.ParameterDirection.Output;

            Connection.Open();
            checkDefense.ExecuteNonQuery();
            Connection.Close();

            if (Convert.ToBoolean(success.Value))
            {
                Decimal grade = Convert.ToDecimal(GradeDefenseB.Text);
                SqlCommand examinerAddGrade = new SqlCommand("AddDefenseGrade", Connection);

                examinerAddGrade.CommandType = CommandType.StoredProcedure;
                examinerAddGrade.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = defenseNumber;
                examinerAddGrade.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defenseDate;
                examinerAddGrade.Parameters.Add(new SqlParameter("@grade", SqlDbType.Decimal)).Value = grade;

                Connection.Open();
                examinerAddGrade.ExecuteNonQuery();
                Connection.Close();
            }
            else
            {
                Response.Write("You Picked a Wrong Timing or Number");
            }
        }

        protected void CommentDefense_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);

            DateTime defenseDate = DateTime.Parse(DefenseDateB.Text);
            int defenseNumber = int.Parse(DefenseNoB.Text);

            SqlCommand checkDefense = new SqlCommand("ExaminerSearchDefense", Connection);
            checkDefense.CommandType = CommandType.StoredProcedure;

            checkDefense.Parameters.Add(new SqlParameter("@serialNo", SqlDbType.Int)).Value = defenseNumber;
            checkDefense.Parameters.Add(new SqlParameter("@date", SqlDbType.DateTime)).Value = defenseDate;

            SqlParameter success = checkDefense.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = System.Data.ParameterDirection.Output;

            Connection.Open();
            checkDefense.ExecuteNonQuery();
            Connection.Close();

            if (Convert.ToBoolean(success.Value))
            {
                String comment = CommentDefenseB.Text;
                SqlCommand examinerAddComment = new SqlCommand("ExaminerAddCommentsGrade", Connection);

                examinerAddComment.CommandType = CommandType.StoredProcedure;
                examinerAddComment.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = defenseNumber;
                examinerAddComment.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defenseDate;
                examinerAddComment.Parameters.Add(new SqlParameter("@examinerId", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
                examinerAddComment.Parameters.Add(new SqlParameter("@comments", SqlDbType.VarChar)).Value = comment;


                Connection.Open();
                examinerAddComment.ExecuteNonQuery();
                Connection.Close();
            }
            else
            {
                Response.Write("You Picked a Wrong Timing or Number");
            }
        }

        protected void Back_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerHome.aspx");
        }
    }
}