using DRPS.SZUOfficalWebsite.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace SZUOfficalWebsite.Pages
{
    public partial class PartyNumber : System.Web.UI.Page
    {
        public int id { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //id = int.Parse(Utility.ReplaceStr(Request.QueryString["id"]) ?? "1");
            id = int.Parse(Utility.ReplaceStr(Utility.GetQueryString("id","1")));
            if (!IsPostBack)
            {
                BindList();
            }
        }
        private void BindList()
        {
            string path = Server.MapPath("~/Configuration/PartyNumber.xml");
            XmlDocument doc = new XmlDocument();
            doc.Load(path);
            XmlNodeList noList = doc.SelectNodes("/dataConfig/data");
            if (noList == null || noList.Count < 1)
            {
                return;
            }
            StringBuilder sb = new StringBuilder();
            foreach (XmlNode noItem in noList)
            {
                if (noItem.Attributes["flag"].InnerText == "1")
                {
                    sb.Append("<p>");
                    sb.Append(string.Format("<a class='PartyContent.aspx?id={1}' title=\"{0}\">{0}</a>", noItem.Attributes["name"].InnerText, noItem.Attributes["id"].InnerText));
                    sb.Append("</p>");

                }
            }
            this.ltNav.Text = sb.ToString();
        }
        protected void btnSub_Click(object sender, EventArgs e)
        {
            //this.ZDAboutUsView.EditId = this.hidType.Value;
            //this.ZDAboutUsView.InitData();
        }
    }
}