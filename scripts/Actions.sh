#!/bin/bash
echo "Begin Restore";/opt/mssql-tools/bin/sqlcmd -U SA -P "PWD@1234" -i "/var/opt/mssql/scripts/Restore.sql";echo "End Restore";