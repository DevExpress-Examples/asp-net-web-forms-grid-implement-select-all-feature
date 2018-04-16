using DevExpress.Web;
using System;
using System.Data;
using System.Linq;
using System.Web.UI;

public partial class _Default : System.Web.UI.Page {
    protected void HeaderCheckBox_Init(object sender, EventArgs e) {
        DataView view = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        var expression = view.Table.Rows.OfType<DataRow>();
        int selectedRowsCount = expression.Count(r => (bool?)r["Discontinued"] == true);
        int allRowsCount = view.Count;
        ASPxCheckBox checkBox = sender as ASPxCheckBox;
        if (selectedRowsCount == 0)
            checkBox.CheckState = CheckState.Unchecked;
        else if (selectedRowsCount == allRowsCount)
            checkBox.CheckState = CheckState.Checked;
        else
            checkBox.CheckState = CheckState.Indeterminate;
    }

    protected void CellCheckBox_Init(object sender, EventArgs e) {
        ASPxCheckBox tempCheckBox = sender as ASPxCheckBox;
        GridViewDataItemTemplateContainer container = tempCheckBox.NamingContainer as GridViewDataItemTemplateContainer;
        string key = container.KeyValue.ToString();
        tempCheckBox.ClientSideEvents.CheckedChanged = string.Format("function (s, e) {{ CellValueChanged(s, e, {0}); }}", key);
    }

    protected void ASPxGridView1_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e) {
        string[] Parameters = e.Parameters.Split(new char[] { '|' });
        string value = Parameters[1];
        object id;
        if (Parameters[0] == "CellClick") {
            string key = Parameters[2];
            id = ASPxGridView1.GetRowValuesByKeyValue(key, new string[] { "ProductID" });
            SqlDataSource1.UpdateCommand = string.Format("Update [Products] set [Discontinued] = '{0}' Where [ProductID] = {1}", value, id);
            SqlDataSource1.Update();
            ASPxGridView1.DataBind();
        } else if (Parameters[0] == "HeaderClick") {
            for (int i = 0; i < ASPxGridView1.VisibleRowCount; i++) {
                id = ASPxGridView1.GetRowValues(i, new string[] { "ProductID" });
                SqlDataSource1.UpdateCommand = string.Format("Update [Products] set [Discontinued] = '{0}' Where [ProductID] = {1}", value, id);
                SqlDataSource1.Update();
            }
            ASPxGridView1.DataBind();
        }
    }
}