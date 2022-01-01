﻿using PostGrad_Web_App.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad_Web_App
{
	public partial class SupervisorHome : System.Web.UI.Page
	{
		DBMaster dbm = new DBMaster();

		protected void Page_Load(object sender, EventArgs e)
		{
		}

		protected void OnEvaluate(object sender, EventArgs e)
		{
			//connecting to the database
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				//inputs
				String TSN = ThesisSerialNo.Text;
				String PRN = ProgressReportNo.Text;
				String Evaluation = Eval.Text;

				int EvaluationInt = Convert.ToInt32(Evaluation);
				//creating the command to execute the procedure
				SqlCommand evaluateProgressReport = new SqlCommand("EvaluateProgressReport", connection);
				evaluateProgressReport.CommandType = CommandType.StoredProcedure;

				Label successful = new Label();
				try
				{
					//passing paramters from inputs to the procedure

					evaluateProgressReport.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = Convert.ToInt32(TSN);
					evaluateProgressReport.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = Convert.ToInt32(PRN);
					evaluateProgressReport.Parameters.Add(new SqlParameter("@supervisorID", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
					evaluateProgressReport.Parameters.Add(new SqlParameter("@evaluation", SqlDbType.Int)).Value = EvaluationInt;

					int noOfRecords = -1;
					if (EvaluationInt >= 0 && EvaluationInt <= 3)
					{
						noOfRecords = evaluateProgressReport.ExecuteNonQuery(); // this is where I run my stored procedure
						if (noOfRecords == -1)
						{
							successful.Text = "Failed to evaluate, Inputs don't exsist!";
						}
						else
						{
							successful.Text = "Evaluated successfully";
						}
						System.Diagnostics.Debug.WriteLine(noOfRecords);
					}
					else
					{
						successful.Text = "Evaluation must be between 0 and 3";
					}

				}
				catch (FormatException FE)
				{
					successful.Text = "Failed to evaluate, Invalid input";
					System.Diagnostics.Debug.WriteLine(FE);
				}
				catch (Exception es)
				{
					successful.Text = "Failed to evaluate!";
				}

				evaluateSuccess.Controls.Add(successful);
			}
		}

		protected void OnCancelThesis(object sender, EventArgs e)
		{
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				//inputs
				String TSN = CancelThesisSerialNo.Text;

				//creating the command to execute the procedure
				SqlCommand cancelThesis = new SqlCommand("CancelThesis", connection);
				cancelThesis.CommandType = CommandType.StoredProcedure;

				Label successful = new Label();
				try
				{
					//passing paramters from inputs to the procedure
					cancelThesis.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = Convert.ToInt32(TSN);

					int noOfRecords = cancelThesis.ExecuteNonQuery(); // this is where I run my stored procedure

					if (noOfRecords == -1)
					{
						successful.Text = "Last report evaluation is not 0. Thesis not canceled";
					}
					else
					{
						successful.Text = "Canceled successfully";
					}
					System.Diagnostics.Debug.WriteLine(noOfRecords);
				}
				catch (FormatException FE)
				{
					successful.Text = "Failed to evaluate, Invalid input";
					System.Diagnostics.Debug.WriteLine(FE);
				}
				CancelSuccess.Controls.Add(successful);

			}
		}

		protected void OnListStudents(object sender, EventArgs e)
		{
			Response.Redirect("ListMyStudents.aspx");
		}

		protected void OnViewPublications(object sender, EventArgs e)
		{
			Session["StudentIDPublications"] = PublicationsID.Text;
			Response.Redirect("ViewStudentPublications.aspx");
		}

		protected void DateChange(object sender, EventArgs e)
		{
			DefenseDate.Text = DefenseDateCalendar.SelectedDate.ToShortDateString();
		}
		protected void OnAddDefense(object sender, EventArgs e)
		{
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				//inputs
				String DTSN = DefenseThesisSerialNumber.Text;
				DateTime defenseDate = DefenseDateCalendar.SelectedDate;
				String defenseLocation = DefenseLocation.Text;
				
				//creating the command to execute the procedure
				SqlCommand addDefense = new SqlCommand("CheckGucianForThesis", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
				Label successful = new Label();
                try
				{
					//passing paramters from inputs to the procedure
					if (DTSN == "")
                    {
						successful.Text = "Please Enter Thesis Serial Number";
						throw new Exception("Please Enter Thesis Serial Number");
					}
					else if (defenseDate.Equals(DateTime.Parse("1/1/0001 12:00:00 AM")))
					{
						successful.Text = "Please Enter Defense Date";
						throw new Exception("Please Enter Defense Date");
					}
					else if (defenseLocation == "")
					{
						successful.Text = "Please Enter Defense Location";
						throw new Exception("Please Enter Defense Location");
					}

					addDefense.Parameters.Add(new SqlParameter("@thesisSerialNumber", SqlDbType.Int)).Value = DTSN;
					addDefense.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defenseDate;
					addDefense.Parameters.Add(new SqlParameter("@DefenseLocation", SqlDbType.VarChar)).Value = defenseLocation;
					
					addDefense.ExecuteNonQuery();
					successful.Text = "Defense Added Successfully";
				}
				catch (SqlException ex)
				{
					successful.Text = ex.Message;
				}
				catch (Exception es)
				{
					System.Diagnostics.Debug.WriteLine("ERROR");
					System.Diagnostics.Debug.WriteLine(es.Message);
					successful.Text = es.Message;
				}
				AddDefenseSuccess.Controls.Add(successful);
			}
		}

		protected void OnAddExaminer(object sender, EventArgs e)
		{
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				//inputs
				String DTSN = DefenseThesisSerialNumber.Text;
				DateTime defenseDate = DefenseDateCalendar.SelectedDate;
				String examinerName = ExaminerName.Text;
				String password = Password.Text;
				Boolean national = National.Checked;
				String fieldOfWork = FieldOfWork.Text;
				System.Diagnostics.Debug.WriteLine(national);
				//creating the command to execute the procedure
				SqlCommand addExaminer = new SqlCommand("AddExaminer", connection)
				{
					CommandType = CommandType.StoredProcedure
				};
				Label successful = new Label();
				try
				{
					//passing paramters from inputs to the procedure
					if (DTSN == "")
					{
						successful.Text = "Please Enter Thesis Serial Number";
						throw new Exception("Please Enter Thesis Serial Number");
					}
					else if (defenseDate.Equals(DateTime.Parse("1/1/0001 12:00:00 AM")))
					{
						successful.Text = "Please Enter Defense Date";
						throw new Exception("Please Enter Defense Date");
					}
					else if (examinerName == "")
					{
						successful.Text = "Please Enter Examiner Name";
						throw new Exception("Please Enter Examiner Name");
					}else if (password == "")
					{
						successful.Text = "Please Enter Password";
						throw new Exception("Please Enter Password");
					}
					else if (national.Equals(""))
					{
						successful.Text = "Please Enter National";
						throw new Exception("Please Enter National");
					}
					else if (fieldOfWork == "")
					{
						successful.Text = "Please Enter Field of Work";
						throw new Exception("Please Enter Field of Work");
					}

					addExaminer.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = DTSN;
					addExaminer.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defenseDate;
					addExaminer.Parameters.Add(new SqlParameter("@ExaminerName", SqlDbType.VarChar)).Value = examinerName;
					addExaminer.Parameters.Add(new SqlParameter("@Password", SqlDbType.VarChar)).Value = password;
					addExaminer.Parameters.Add(new SqlParameter("@National", SqlDbType.Bit)).Value = Convert.ToBoolean(national);
					addExaminer.Parameters.Add(new SqlParameter("@FieldOfWork", SqlDbType.VarChar)).Value = fieldOfWork;

					addExaminer.ExecuteNonQuery();
					successful.Text = "Examiner is added Successfully";
				}
				catch (SqlException ex)
				{
					successful.Text = ex.Message;
				}
				catch (Exception es)
				{
					System.Diagnostics.Debug.WriteLine("ERROR");
					System.Diagnostics.Debug.WriteLine(es.Message);
					successful.Text = es.Message;
				}
				AddNewExaminerSuccess.Controls.Add(successful);
			}
		}

		protected void OnAddExistingExaminer(object sender, EventArgs e)
		{
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				//inputs
				String DTSN = DefenseThesisSerialNumber.Text;
				DateTime defenseDate = DefenseDateCalendar.SelectedDate;
				String examinerId = ExaminerID.Text;

				SqlCommand addExistingExaminer = new SqlCommand("AddExistingExaminer", connection)
				{
					CommandType = CommandType.StoredProcedure
				};

				Label successful = new Label();

				try
                {
					if (DTSN == "")
					{
						successful.Text = "Please Enter Thesis Serial Number";
						throw new Exception("Please Enter Thesis Serial Number");
					} else if (defenseDate.Equals(DateTime.Parse("1/1/0001 12:00:00 AM")))
                    {
						successful.Text = "Please Enter Defense Date";
						throw new Exception("Please Enter Defense Date");
					} else if (examinerId == "")
					{
						successful.Text = "Please Enter Examiner Id";
						throw new Exception("Please Enter Examiner Id");
					}
					addExistingExaminer.Parameters.Add(new SqlParameter("@defenseDate", SqlDbType.DateTime)).Value = defenseDate;
					addExistingExaminer.Parameters.Add(new SqlParameter("@thesisSerialNumber", SqlDbType.Int)).Value = DTSN;
					addExistingExaminer.Parameters.Add(new SqlParameter("@examinerId", SqlDbType.Int)).Value = examinerId;
					addExistingExaminer.ExecuteNonQuery();
					successful.Text = "Examiner Added Successfully";
				}
				catch (SqlException ex)
				{
					successful.Text = ex.Message;
				}
				catch (Exception es)
                {
                    System.Diagnostics.Debug.WriteLine("ERROR");
                    System.Diagnostics.Debug.WriteLine(es.Message);
				}
				ExistingExaminerSuccess.Controls.Add(successful);
			}
		}
    }
}