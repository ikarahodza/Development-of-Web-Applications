using System;
using System.CodeDom.Compiler;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace WebApplication1
{
    public class SearchHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            string query = context.Request.QueryString["q"];

            if (string.IsNullOrWhiteSpace(query))
            {
                context.Response.Write("[]");
                return;
            }

            List<SearchResult> results = SearchNews(query);

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string json = serializer.Serialize(results);

            context.Response.Write(json);
        }

        private List<SearchResult> SearchNews(string searchQuery)
        {
            List<SearchResult> results = new List<SearchResult>();
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP 5 ID, title
                                FROM News
                                WHERE title LIKE @search OR contents LIKE @search
                                ORDER BY ID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@search", "%" + searchQuery + "%");

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            results.Add(new SearchResult
                            {
                                id = reader["ID"].ToString(),
                                title = reader["title"].ToString(),
                            });
                        }
                    }
                }
            }

            return results;
        }

  

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public class SearchResult
        {
            public string id { get; set; }
            public string title { get; set; }
        }
    }
}