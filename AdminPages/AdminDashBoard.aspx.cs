using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;

namespace AMCComplaintSystem.AdminPages
{
    public partial class AdminDashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string role = Session["Role"].ToString();
            if (role == null)
            {
                Response.Redirect("LoginForm.aspx");
            }
            else if (role != "Admin")
            {
                Response.Redirect("LoginForm.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    LoadStats();
                    LoadRecentComplaints();
                    LoadEngineerPerformanceChart();
                    LoadCategoryStatusChart();
                }
            }
        }

        private void LoadCategoryStatusChart()
        {

            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetCategoryStatusComplaints", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    
                    chartCategoryStatus.Series.Clear();
                    chartCategoryStatus.ChartAreas[0].AxisX.Interval = 1;

                   
                    while (reader.Read())
                    {
                        string categoryStatus = reader["CategoryStatus"].ToString();
                        int complaintCount = Convert.ToInt32(reader["ComplaintCount"]);

                        
                        Series series = new Series(categoryStatus)
                        {
                            ChartType = SeriesChartType.Column,
                            IsValueShownAsLabel = true
                        };
                        series.Points.AddXY(categoryStatus, complaintCount);

                        
                        chartCategoryStatus.Series.Add(series);
                    }
                }
            }
        }

        

        private void LoadEngineerPerformanceChart()
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                
                SqlCommand cmd = new SqlCommand("sp_GetEngineerPerformance", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    chartEngineerPerformance.Series.Clear();
                    chartEngineerPerformance.ChartAreas[0].AxisX.Interval = 1;
                    Dictionary<string, Series> seriesDict = new Dictionary<string, Series>();
                     while (reader.Read())
                    {
                        string engineerName = reader["EngineerName"].ToString();
                        string status = reader["Status"].ToString();
                        int count = Convert.ToInt32(reader["ComplaintCount"]);
                        if (!seriesDict.ContainsKey(status))
                        {
                            Series series = new Series(status)
                            {
                                ChartType = SeriesChartType.Column,
                                IsValueShownAsLabel = true
                            };
                            seriesDict[status] = series;
                            chartEngineerPerformance.Series.Add(series);
                        }
                        seriesDict[status].Points.AddXY(engineerName, count);
                    }
                }
            }

        }


        private void LoadStats()
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetAdminDashboardStats", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                   // lblTotalComplaints.Text = reader["TotalComplaints"].ToString();
                    lblPendingComplaints.Text = reader["PendingComplaints"].ToString();
                    lblNotAttend.Text = reader["NotAttendComplaints"].ToString();
                    lblCompletedJobs.Text = reader["ResolvedComplaints"].ToString();
                    lblInprogressComplaints.Text = reader["InProgressComplaints"].ToString();
                }
                reader.Close();
            }
        }

        private void LoadRecentComplaints()
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetRecentComplaints", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                gvRecentComplaints.DataSource = dt;
                gvRecentComplaints.DataBind();
            }
        }

    }
}