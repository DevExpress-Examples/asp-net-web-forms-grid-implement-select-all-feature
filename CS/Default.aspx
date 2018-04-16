<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

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
                    <dx:GridViewCommandColumn VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="1">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="2">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="SupplierID" VisibleIndex="3">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="CategoryID" VisibleIndex="4">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="QuantityPerUnit" VisibleIndex="5">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataColumn FieldName="Discontinued" VisibleIndex="6">
                        <HeaderTemplate>
                            <dx:ASPxCheckBox ID="HeaderCheckBox" runat="server" OnInit="HeaderCheckBox_Init" AllowGrayed="true" AllowGrayedByClick="false">
                                <ClientSideEvents CheckedChanged="HeaderValueChanged" />
                            </dx:ASPxCheckBox>
                        </HeaderTemplate>
                        <DataItemTemplate>
                            <dx:ASPxCheckBox ID="CellCheckBox" runat="server" OnInit="CellCheckBox_Init" Checked='<%# Eval("Discontinued")%>'>
                            </dx:ASPxCheckBox>
                        </DataItemTemplate>
                        <Settings AllowSort="False" />
                    </dx:GridViewDataColumn>
                </Columns>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                SelectCommand="SELECT [ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [Discontinued] FROM [Products]"
                ConnectionString="<%$ ConnectionStrings:ConnStr %>"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
