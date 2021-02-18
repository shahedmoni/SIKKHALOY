﻿using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace EDUCATION.COM.Handeler
{
    /// <summary>
    /// Summary description for Student_Id_Based_Photo
    /// </summary>
    public class Student_Id_Based_Photo : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EducationConnectionString"].ToString());
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT Image from Student_Image where StudentImageID = (SELECT StudentImageID from Student where StudentID = @StudentID)", con);
            cmd.Parameters.AddWithValue("@StudentID", context.Request.QueryString["StudentID"]);
            SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            if (reader.Read())
            {
                if (reader.GetValue(0) != DBNull.Value)
                {
                    if (((Byte[])reader.GetValue(0)).Length != 0)
                    {
                        context.Response.BinaryWrite((Byte[])reader.GetValue(0));
                    }
                    else
                    {
                        context.Response.BinaryWrite(File.ReadAllBytes(context.Server.MapPath("Default/Male.png")));
                    }
                }
                else
                {
                    context.Response.BinaryWrite(File.ReadAllBytes(context.Server.MapPath("Default/Male.png")));
                }
            }
            else
                context.Response.BinaryWrite(File.ReadAllBytes(context.Server.MapPath("Default/Male.png")));

            reader.Close();
            con.Close();
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}