import std.stdio;

import derelict.pq.pq;
import std.conv : to;
import std.string;
import derelict_pq_ex.p395;

void main() {
    // Load the Postgres library.
    DerelictPQ.load();
    //enum CONNECTION_STRING = "host=localhost dbname=egon user=postgres password=postgres";
    enum CONNECTION_STRING = "host=localhost dbname=test user=postgres password=postgres";
    //do395(CONNECTION_STRING);
    PGconn* conn = PQconnectdb(CONNECTION_STRING);
    //foo1(conn);
    bar1(conn);
    //conn.close;
}

/**
 * Before running this, populate a database with the following commands
 * (provided in sql/foo.sql):
 *
 * CREATE TABLE foo (id bigint , pi double precision, s text, i integer);
 *
 * INSERT INTO foo values (1, 3.14,  'cul', 42);
 */
void foo1(PGconn* conn) {
   import std.string;
   const(char)* cmd = cast(const(char)*)"select pi::float8 from foo;".toStringz;
   PGresult* res = PQexec(conn, cmd);
   if (PQresultStatus(res) == PGRES_TUPLES_OK) {
      writeln("type ", PQftype(res, 0), " size ", PQgetlength(res, 0, 0) );

      const(ubyte)* ptr = PQgetvalue(res, 0, 0);
      immutable(char)* p = cast(immutable(char)*)PQgetvalue(res, 0, 0);
      string s  = fromStringz(p);
      writefln("* %s", s);

      ubyte[] b  = ptr[0 .. 8].dup;

      writefln("%( 0x%x %)", b);
      writeln();
      PQclear(res);
   } else{
      writeln("ERR");
   }
}

void bar1(PGconn* conn) {
   import std.string;
   import std.datetime;
   import std.array : replace;
   const(char)* cmd = cast(const(char)*)"select created_at from bar;".toStringz;
   PGresult* res = PQexec(conn, cmd);
   writeln("status ", PQresultStatus(res));
   writeln("msg ", PQresultErrorMessage(res).fromStringz);

   if (PQresultStatus(res) == PGRES_TUPLES_OK) {
      writeln("type ", PQftype(res, 0), " size ", PQgetlength(res, 0, 0) );

      const(ubyte)* ptr = PQgetvalue(res, 0, 0);
      immutable(char)* p = cast(immutable(char)*)PQgetvalue(res, 0, 0);
      string s  = fromStringz(p);
      writefln("* %s", s);

      ubyte[] b  = ptr[0 .. 8].dup;

      string iso = s.replace(" ", "T");
      SysTime d = SysTime.fromISOExtString(iso);
      writeln("date ", d);


      writefln("%( 0x%x %)", b);
      writeln();

      PQclear(res);
   } else{
      writeln("ERR");
   }
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
