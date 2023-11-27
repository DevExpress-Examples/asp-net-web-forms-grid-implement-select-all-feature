<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v15.1, Version=15.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function CellValueChanged(s, e, key) {
            Grid.PerformCallback("CellClick|" + s.GetChecked() + "|" + key);
        }
        function HeaderValueChanged(s, e) {
            Grid.PerformCallback("HeaderClick|" + s.GetChecked());
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" ClientInstanceName="Grid" KeyFieldName="ProductID" OnCustomCallback="ASPxGridView1_CustomCallback">
                <Columns>
                    <dx:GridViewCommandColumn />
                    <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ProductName" />
                    <dx:GridViewDataTextColumn FieldName="SupplierID" />
                    <dx:GridViewDataTextColumn FieldName="CategoryID" />
                    <dx:GridViewDataTextColumn FieldName="QuantityPerUnit" />
                    <dx:GridViewDataColumn FieldName="Discontinued" >
                        <HeaderTemplate>
                            <dx:ASPxCheckBox ID="HeaderCheckBox" runat="server" OnInit="HeaderCheckBox_Init" AllowGrayed="true" AllowGrayedByClick="false">
                                <ClientSideEvents CheckedChanged="HeaderValueChanged" />
                            </dx:ASPxCheckBox>
                        </HeaderTemplate>
                        <DataItemTemplate>
                            <dx:ASPxCheckBox ID="CellCheckBox" runat="server" OnInit="CellCheckBox_Init" Checked='<%# Eval("Discontinued")%>' />
                        </DataItemTemplate>
                        <Settings AllowSort="False" />
                    </dx:GridViewDataColumn>
                </Columns>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                SelectCommand="SELECT [ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [Discontinued] FROM [Products]"
                ConnectionString="<%$ ConnectionStrings:ConnStr %>" />
        </div>
    </form>
</body>
</html>
