#!/bin/bash
/opt/mssql/bin/sqlservr & /var/opt/mssql/scripts/wait.sh localhost:1433 -s --timeout=6010 -- /var/opt/mssql/scripts/actions.sh & wait