using PostGrad_Web_App.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad_Web_App.Supervisor
{
    public partial class ListMyStudents : System.Web.UI.Page
    {
        DBMaster dbm = new DBMaster();

        protected void Page_Load(object sender, EventArgs e)
        {
            using (SqlConnection connection = dbm.GetSqlConnection())
            {
                //Creating the procedure
                SqlCommand viewSupStudentsYears = new SqlCommand("ViewSupStudentsYears", connection);
                viewSupStudentsYears.CommandType = CommandType.StoredProcedure;
                viewSupStudentsYears.Parameters.Add(new SqlParameter("@supervisorID", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
                
                //Create table and add column names
                DataTable table = new DataTable();
                table.Columns.Add("First Name");
                table.Columns.Add("Second Name");
                table.Columns.Add("Years");
                
                //Read the output of the procedure
                using (SqlDataReader reader = viewSupStudentsYears.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        table.Rows.Add(reader[0], reader[1], reader[2]);
                    }
                    
                    DataGrid1.DataSource = table;
                    DataGrid1.DataBind();
                }
            }
        }
 
    }
}