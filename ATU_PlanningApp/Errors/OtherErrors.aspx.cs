using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ATU_PlanningApp.Errors
{
    public partial class OtherErrors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.TrySkipIisCustomErrors = true;
        }
    }
}