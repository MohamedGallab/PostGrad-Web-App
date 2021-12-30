using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace PostGrad_Web_App.App_Code
{
	public class DBMaster
	{
		private SqlConnection Connection;

		public SqlConnection GetSqlConnection ()
		{
			String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();
			Connection = new SqlConnection(ConnectionString);
			Connection.Open ();
			return Connection;
		}

		public SqlDataReader GetReader(string query)
		{
			SqlCommand cmd = new SqlCommand(query, GetSqlConnection())
			{
				CommandType = System.Data.CommandType.Text
			};
			// same as
			// SqlCommand cmd = new SqlCommand (query, Connection);
			// cmd.CommandType = System.Data.CommandType.Text;

			SqlDataReader reader = cmd.ExecuteReader ();
			return reader;
		}

		public void CloseConnection()
		{
			if (Connection != null && Connection.State == System.Data.ConnectionState.Open)
			{
				Connection.Close();
			}
		}
	}
}