using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace ATU_PlanningApp.Setups
{
    public partial class Department : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            departmentGrid.MasterTableView.ExportToExcel();
        }

        protected void btnPDFExport_Click(object sender, EventArgs e)
        {
            departmentGrid.MasterTableView.ExportToPdf();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "INSERT INTO tblDepartment(DepartmentName,FacultyId) VALUES(@DepartmentName,@FacultyId)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@DepartmentName", SqlDbType.VarChar).Value = txtDepartment.Text;
                    command.Parameters.Add("@FacultyId", SqlDbType.Int).Value = dlFaculty.SelectedValue;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            departmentGrid.Rebind();
                            txtDepartment.Text = "";
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "Update tblDepartment SET DepartmentName=@DepartmentName,FacultyId=@FacultyId where Id=@Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@DepartmentName", SqlDbType.VarChar).Value = txtDepartment1.Text;
                    command.Parameters.Add("@FacultyId", SqlDbType.Int).Value = dlFaculty1.SelectedValue;
                    command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["ID"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                            departmentGrid.Rebind();
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void departmentGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["ID"] = item["Id"].Text;
                txtDepartment1.Text = item["DepartmentName"].Text;
                dlFaculty1.SelectedValue = item["FacultyId"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void departmentGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
            }
        }
    }
}