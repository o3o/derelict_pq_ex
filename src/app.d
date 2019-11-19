import std.stdio;

import derelict.pq.pq;
import std.conv : to;
import std.string;
import derelict_pq_ex.p395;

void main() {
    // Load the Postgres library.
    DerelictPQ.load();
    enum CONNECTION_STRING = "host=localhost dbname=egon user=postgres password=postgres";
    do395(CONNECTION_STRING);
}

/+
void simple(string conn) {
    // Now libpq functions can be called.
    PGconn* conn = PQconnectdb(conn);
    if (PQstatus(conn) == CONNECTION_OK) {
       writeln("OK");
       writeln(PQdb(conn).to!string());
       const(char)* cmd = cast(const(char)*)"select * from account where id=2;".toStringz;

       PGresult* res = PQexec(conn, cmd);
       if (PQresultStatus(res) == PGRES_TUPLES_OK){
          writeln(PQntuples(res), " fi:", PQnfields(res));
       } else{
          writeln("ERR");

       }
    } else {
       writeln("NOK");
    }
    PQfinish(conn);
}
+/
