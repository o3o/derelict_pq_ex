module derelict_pq_ex.p395;

import derelict.pq.pq;
import std.conv : to;
import std.string;
import std.stdio;

void doSQL(PGconn* conn, string cmd) {
   writefln("com : %s", cmd);

   const(char)* command = cast(const(char)*)cmd.toStringz;
   PGresult* result = PQexec(conn, command);
   writefln("status is %s", PQresStatus(PQresultStatus(result)).to!string);
   writefln("result message: %s", PQresultErrorMessage(result).to!string);
   writeln();

   PQclear(result);
}

void do395(string connectionString) {
   const(char)* cs = cast(const(char)*)connectionString.toStringz;
   PGresult* result;
   PGconn* conn = PQconnectdb(cs);
   if (PQstatus(conn) == CONNECTION_OK) {
      writeln( "connection made");
      /* doSQL(conn, "DROP TABLE number"); */
      doSQL(conn, "CREATE TABLE number (value INTEGER, name TEXT)");

      doSQL(conn, "INSERT INTO number values(42,'The Answer')");
      doSQL(conn, "INSERT INTO number values(29,'My Age')");
      doSQL(conn, "INSERT INTO number values(29,'Anniversary')");
      doSQL(conn, "INSERT INTO number values(66,'Clickety-Click')");
   } else {
      writefln("connection failed %s", PQerrorMessage(conn));
   }
    PQfinish(conn);
}
