#!/bin/bash
/opt/mssql/bin/sqlservr & /var/opt/mssql/scripts/Wait.sh localhost:1433 -s --timeout=6010 -- /var/opt/mssql/scripts/Actions.sh & wait