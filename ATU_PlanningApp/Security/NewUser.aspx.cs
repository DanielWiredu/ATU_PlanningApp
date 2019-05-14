using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using Telerik.Web.UI;

namespace ATU_PlanningApp.Security
{
    public partial class NewUser : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            byte[] hashedPassword = GetSHA1(txtPassword.Text.Trim());
            string roles = "";
            foreach (RadComboBoxItem item in dlRoles.CheckedItems)
            {
                roles += item.Value + ",";
            }
            roles = roles.TrimEnd(',');

            string query = "insert into tblUsers(username,userpassword,userroles,fullname,gender,maritalstatus,contactno,email,posttype,address,active) values(@uname,@upass,@uroles,@fname,@gender,@mstatus,@contactno,@email,@post,@address,@active)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@uname", SqlDbType.VarChar).Value = txtUsername.Text;
                    command.Parameters.Add("@upass", SqlDbType.VarBinary).Value = hashedPassword;
                    command.Parameters.Add("@uroles", SqlDbType.VarChar).Value = roles;
                    command.Parameters.Add("@fname", SqlDbType.VarChar).Value = txtFullname.Text;
                    command.Parameters.Add("@gender", SqlDbType.VarChar).Value = dlGender.SelectedText;
                    command.Parameters.Add("@mstatus", SqlDbType.VarChar).Value = dlMaritalStatus.SelectedText;
                    command.Parameters.Add("@contactno", SqlDbType.VarChar).Value = txtMobile.Text;
                    command.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmail.Text;
                    command.Parameters.Add("@post", SqlDbType.VarChar).Value = dlPost.SelectedText;
                    command.Parameters.Add("@address", SqlDbType.VarChar).Value = txtAddress.Text;
                    command.Parameters.Add("@active", SqlDbType.Bit).Value = chkActive.Checked;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('User Saved Successfully', 'Success');", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        /// <summary>
        /// Returns the SHA1 hash of the combined userID and password.
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        private static byte[] GetSHA1(string password)
        {
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
            return sha.ComputeHash(System.Text.Encoding.ASCII.GetBytes(password));
        }
    }
}