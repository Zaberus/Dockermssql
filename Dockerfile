FROM microsoft/mssql-server-linux:2017-latest

RUN mkdir -p /var/opt/mssql/bkp
RUN mkdir -p /var/opt/mssql/scripts

# ENTRYPOINT ["/var/opt/mssql/scripts/Restore.sh"]
# CMD ["start"]