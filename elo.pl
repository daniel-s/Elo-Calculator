use v6;

# Using the elo module
use Chess::elo;

# Note: The functions in Chess are not "is export". Use their fully qualified
# name, eg.: Chess::elo.elo()

# K factor used in calculating new rating
# my $kFactor = 32;

# default value to give a new player
my $defaultELO = 1600;
my $file_in = open "results.csv";

# @results will hold everything. It's an array, with each element a result
# result is (First, Second, outcome) ie. (Bob, Alice, 1) (3 element array)
my @results;

# hash table of player name (key) and rating
my %player;

# collecting results from file into array
for $file_in.lines -> $line
{
    @results.push($line.split(":"));
}

for @results -> $p1_name, $p2_name, $score
{
    # set scores to 1600 if it's the first time their results appear
    if (%player.exists($p1_name) == Bool::False) {%player{$p1_name} = $defaultELO};
    if (%player.exists($p2_name) == Bool::False) {%player{$p2_name} = $defaultELO};
    (%player{$p1_name}, %player{$p2_name}) = Chess::elo.eloBoth(%player{$p1_name}, %player{$p2_name}, $score);
}

# this simply lists all of the players and their ratings
for %player.keys -> $p1_name
{
    say "$p1_name has rating of: %player{$p1_name}";
}

# outputting results to elo_list.csv
my $file_out = open "elo_list.csv", :w;
for %player.keys -> $p1_name
{
    $file_out.say($p1_name ~ ":" ~ %player{$p1_name});
    #say $file_out: $p1_name ~ ":" ~ %player{$p1_name};
}

say "Writing files to disk";
$file_out.close;
say "\n\nDone!\n"
