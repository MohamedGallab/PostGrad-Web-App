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

            if (DefenseDateB.Text == "")
            {
                responseL.Text = "Enter a Date.";
            }
            else
            {
                if (DefenseNoB.Text == "")
                {
                    responseL.Text = "Enter a Defense Number.";

                }
                else
                {
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
                        if (GradeDefenseB.Text == "")
                        {
                            responseL.Text = "Enter a Grade.";

                        }
                        else
                        {
                            Decimal grade = Convert.ToDecimal(GradeDefenseB.Text);
                            if (Decimal.Compare(100, grade) <= 0 || Decimal.Compare(0, grade) > 0)
                            {
                                responseL.Text = "Enter a valid grade.";
                            }

                            else
                            {
                                SqlCommand examinerAddGrade = new SqlCommand("AddDefenseGrade", Connection);

                                examinerAddGrade.CommandType = CommandType.StoredProcedure;
                                examinerAddGrade.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = defenseNumber;
                                examinerAddGrade.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defenseDate;
                                examinerAddGrade.Parameters.Add(new SqlParameter("@grade", SqlDbType.Decimal)).Value = grade;

                                Connection.Open();
                                try
                                {

                                    if (examinerAddGrade.ExecuteNonQuery() == -1)
                                    {
                                        throw new Exception("You entered an invalid grade.");
                                    }
                                    responseL.Text = "Grade added succesfully.";
                                }
                                catch (FormatException)
                                {
                                    responseL.Text = "Please enter valid inputs.";
                                }
                                catch (Exception ex)
                                {
                                    responseL.Text = ex.Message;
                                }
                                Connection.Close();
                            }

                        }

                    }
                    else
                    {
                        responseL.Text = "You entered a wrong date or number.";
                    }
                }
            }
        }

        protected void CommentDefense_Click(object sender, EventArgs e)
        {
            String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
            SqlConnection Connection = new SqlConnection(ConnectionString);

            DateTime defenseDate = Convert.ToDateTime(DefenseDateB.Text);
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
                if (CommentDefenseB.Text == "")
                {
                    responseL.Text = "Enter a Comment.";
                }
                else
                {
                    String comment = CommentDefenseB.Text;
                    SqlCommand examinerAddGrade = new SqlCommand("ExaminerAddCommentsGrade", Connection);

                    examinerAddGrade.CommandType = CommandType.StoredProcedure;
                    examinerAddGrade.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = defenseNumber;
                    examinerAddGrade.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defenseDate;
                    examinerAddGrade.Parameters.Add(new SqlParameter("@examinerId", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]); ;
                    examinerAddGrade.Parameters.Add(new SqlParameter("@comments", SqlDbType.VarChar)).Value = comment;

                    Connection.Open();
                    try
                    {

                        if (examinerAddGrade.ExecuteNonQuery() == -1)
                        {
                            throw new Exception("You entered an invalid comment.");
                        }
                        responseL.Text = "Comment added succesfully.";
                    }
                    catch (FormatException)
                    {
                        responseL.Text = "Please enter valid inputs.";
                    }
                    catch (Exception ex)
                    {
                        responseL.Text = ex.Message;
                    }
                    Connection.Close();
                }
                
            }
            else
            {
                responseL.Text = "You entered a wrong date or number.";
            }
        }

        protected void Back_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerHome.aspx");
        }
    }
}