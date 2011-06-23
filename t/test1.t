use v6;
use Test;
use Chess::elo;

say "Beginning tests for Chess::elo";

my ($p1, $p2);

($p1, $p2) = Chess::elo.expectedBoth(1300, 900);
ok(1, "method: Chess::elo.expectedBoth() \tpassed");

if $p1 == Chess::elo.expected(1300, 900)[0]
{
    ok(1, "method: Chess::elo.expected() \t\tpassed");
} else {
    ok(0, "ERROR: method Chess::elo.expected() appears to have executed, but returned incorrect result");
    say '$p1 was: ', $p1.perl;
    say 'Chess::elo.expected($p1, $p2)[0] was: ', Chess::elo.expected($p1, $p2)[0].perl;
}

$p1 = Chess::elo.elo(1300, 900, 0.5);
ok(1, "method: Chess::elo.elo() \t\tpassed");

if $p1 == Chess::elo.eloBoth(1300, 900, 0.5)[0]
{
    ok(1, "method: Chess::elo.eloBoth() \t\tpassed");
} else {
    ok(0, "ERROR: method Chess::elo.eloBoth() appears to have executed, but returned incorrect result");
    say "test was $p1 == Chess::elo.eloBoth(1300, 900, 0.5)[0]";
    say '$p1 is: ', $p1.perl;
    say 'Chess::elo.eloBoth(1300, 900, 0.5) is: ', Chess::elo.eloBoth(1300, 900, 0.5)[0].perl
}

$p1 = Chess::elo.eloK(1300, 900, 0.5, 55);
ok(1, "method: Chess::elo.eloK() \t\tpassed");

if $p1 == Chess::elo.eloBothK(1300, 900, 0.5, 55)[0]
{
    ok(1, "method: Chess::elo.eloBothK() \t\tpassed");
} else {
    ok(0, "ERROR: method Chess::elo.eloBothK() appears to have executed, but returned incorrect result");
    say "test was $p1 == Chess::elo.eloBothK(1300, 900, 0.5)[0]";
    say '$p1 is: ', $p1.perl;
    say 'Chess::elo.eloBothK(1300, 900, 0.5) is: ', Chess::elo.eloBothK(1300, 900, 0.5, 55)[0].perl
}

if 1277.505 == Chess::elo.eloN(1300, 0.5, 55, .909)
{
    ok(1, "method: Chess::elo.eloN() \t\tpassed");
} else {
    ok(1, "ERROR: method Chess::elo.eloN() appears to have executed, but returned incorrect result");
}
