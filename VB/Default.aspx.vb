Imports DevExpress.Web
Imports System
Imports System.Data
Imports System.Linq
Imports System.Web.UI

Partial Public Class _Default
	Inherits System.Web.UI.Page

	Protected Sub HeaderCheckBox_Init(ByVal sender As Object, ByVal e As EventArgs)
		Dim view As DataView = DirectCast(SqlDataSource1.Select(DataSourceSelectArguments.Empty), DataView)
		Dim expression = view.Table.Rows.OfType(Of DataRow)()
		Dim selectedRowsCount As Integer = expression.AsEnumerable().Count(Function(r) CType(r("Discontinued"), Boolean?).Equals(True))
		Dim allRowsCount As Integer = view.Count
		Dim checkBox As ASPxCheckBox = TryCast(sender, ASPxCheckBox)
		If selectedRowsCount = 0 Then
			checkBox.CheckState = CheckState.Unchecked
		ElseIf selectedRowsCount = allRowsCount Then
			checkBox.CheckState = CheckState.Checked
		Else
			checkBox.CheckState = CheckState.Indeterminate
		End If
	End Sub

	Protected Sub CellCheckBox_Init(ByVal sender As Object, ByVal e As EventArgs)
		Dim tempCheckBox As ASPxCheckBox = TryCast(sender, ASPxCheckBox)
		Dim container As GridViewDataItemTemplateContainer = TryCast(tempCheckBox.NamingContainer, GridViewDataItemTemplateContainer)
		Dim key As String = container.KeyValue.ToString()
		tempCheckBox.ClientSideEvents.CheckedChanged = String.Format("function (s, e) {{ CellValueChanged(s, e, {0}); }}", key)
	End Sub

	Protected Sub ASPxGridView1_CustomCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)
		Dim Parameters() As String = e.Parameters.Split(New Char() { "|"c })
		Dim value As String = Parameters(1)
'INSTANT VB NOTE: The variable id was renamed since Visual Basic does not handle local variables named the same as class members well:
		Dim id_Conflict As Object
		If Parameters(0) = "CellClick" Then
			Dim key As String = Parameters(2)
			id_Conflict = ASPxGridView1.GetRowValuesByKeyValue(key, New String() { "ProductID" })
			SqlDataSource1.UpdateCommand = String.Format("Update [Products] set [Discontinued] = '{0}' Where [ProductID] = {1}", value, id_Conflict)
			SqlDataSource1.Update()
			ASPxGridView1.DataBind()
		ElseIf Parameters(0) = "HeaderClick" Then
			For i As Integer = 0 To ASPxGridView1.VisibleRowCount - 1
				id_Conflict = ASPxGridView1.GetRowValues(i, New String() { "ProductID" })
				SqlDataSource1.UpdateCommand = String.Format("Update [Products] set [Discontinued] = '{0}' Where [ProductID] = {1}", value, id_Conflict)
				SqlDataSource1.Update()
			Next i
			ASPxGridView1.DataBind()
		End If
	End Sub
End Class