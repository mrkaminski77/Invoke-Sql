
function Invoke-SQL {
		param(
	[string] $dataSource = "",
	[string] $database = "",
	[string] $sqlCommand = "SELECT * FROM sys.tables"
	)

	$connectionString = "server=$dataSource;database=$database;trusted_connection=true;"
	$connection = new-object system.data.SqlClient.SQLConnection($connectionString)
	$command = new-object system.data.sqlclient.sqlcommand($sqlCommand,$connection)
	$connection.Open() | Out-Null

	$adapter = new-object System.Data.SqlClient.SqlDataAdapter $command
	$dataset = new-object System.Data.DataSet
	$adapter.Fill($dataset) | Out-Null

	$connection.Close()

	$views = $dataSet.Tables | %{New-Object System.Data.DataView($_)}

    	$views
	}
