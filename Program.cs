using Microsoft.Data.SqlClient;
using static System.Net.Mime.MediaTypeNames;
using static System.Runtime.InteropServices.JavaScript.JSType;
using System;
using Microsoft.VisualBasic;
namespace ToDo_ADO_NET_DEMO
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string connectionString = @"Server=LAPTOP-GFMLGC10\SQLEXPRESS;Initial Catalog=ToDoListDB;Integrated Security=True;Trust Server Certificate=True";
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    Console.WriteLine("Databasen är öppen");
                    //-Hämta och presentera alla kategorier med tillhörande uppgifter från databasen
                    string queryGetCategories = $"SELECT * FROM Categories;";
                    string queryGetTasks = $"SELECT * FROM Tasks;";
                    //- Låt användaren lägg till nya uppgifter genom att mata in informationen om uppgiften.
                    string queryAddNewCategory = $"INSERT INTO Categories(CategoryName, CategoryLocation) VALUES (@CategoryName, @CategoryLocation);";
                    //- Låt användaren blocka av en uppgift som genomförd genom att uppge ID för uppgiften
                    string queryUpdateStatus = $"UPDATE Tasks SET TaskStatus = 1 WHERE TaskId = @TaskId;";

                    using (SqlCommand command3 = new SqlCommand(queryUpdateStatus, connection))
                    {
                        command3.Parameters.AddWithValue("@TaskId", 13);

                        // Execute the query
                        int rowsAffected2 = command3.ExecuteNonQuery();

                        // Confirm success
                        Console.WriteLine($"{rowsAffected2} row(s) inserted successfully.");
                    }
                    using (SqlCommand command2 = new SqlCommand(queryAddNewCategory, connection))
                    {
                        command2.Parameters.AddWithValue("@CategoryName", "Private Pooping");
                        command2.Parameters.AddWithValue("@CategoryLocation", "Toilet");

                        // Execute the query
                        int rowsAffected = command2.ExecuteNonQuery();

                        // Confirm success
                        Console.WriteLine($"{rowsAffected} row(s) inserted successfully.");
                    }
                    using (SqlCommand command = new SqlCommand(queryGetCategories, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                for (int i = 0; i < reader.FieldCount; i++)
                                {
                                    Console.Write($"{reader[i]} ");
                                }
                                Console.WriteLine();
                            }
                        }
                    }
                    using (SqlCommand command4 = new SqlCommand(queryGetTasks, connection))
                    {
                        using (SqlDataReader reader5 = command4.ExecuteReader())
                        {
                            while (reader5.Read())
                            {
                                for (int j = 0; j < reader5.FieldCount; j++)
                                {
                                    Console.Write($"{reader5[j]} ");
                                }
                                Console.WriteLine();
                            }
                        }
                    }


                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
