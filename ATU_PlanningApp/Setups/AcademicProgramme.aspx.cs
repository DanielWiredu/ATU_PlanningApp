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
    public partial class AcademicProgramme : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            programmeGrid.MasterTableView.ExportToExcel();
        }

        protected void btnPDFExport_Click(object sender, EventArgs e)
        {
            programmeGrid.MasterTableView.ExportToPdf();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "INSERT INTO tblAcademicProgramme(Programme,ProgrammeOptionId,Description) VALUES(@Programme,@ProgrammeOptionId,@Description)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Programme", SqlDbType.VarChar).Value = txtProgramme.Text;
                    command.Parameters.Add("@ProgrammeOptionId", SqlDbType.Int).Value = dlProgrammeOption.SelectedValue;
                    command.Parameters.Add("@Description", SqlDbType.VarChar).Value = txtDescription.Text;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            programmeGrid.Rebind();
                            txtProgramme.Text = "";
                            txtDescription.Text = "";
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
            string query = "Update tblAcademicProgramme SET Programme=@Programme,ProgrammeOptionId=@ProgrammeOptionId,Description=@Description where Id=@Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Programme", SqlDbType.VarChar).Value = txtProgramme1.Text;
                    command.Parameters.Add("@ProgrammeOptionId", SqlDbType.Int).Value = dlProgrammeOption1.SelectedValue;
                    command.Parameters.Add("@Description", SqlDbType.VarChar).Value = txtDescription1.Text;
                    command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["ID"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                            programmeGrid.Rebind();
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void programmeGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["ID"] = item["Id"].Text;
                txtProgramme1.Text = item["Programme"].Text;
                dlProgrammeOption1.SelectedValue = item["ProgrammeOptionId"].Text;
                txtDescription1.Text = item["Description"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void programmeGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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