use v6;

# return the expected score of 2 players at a time
# NOTE: this is actually not used by any of the following elo() functions
sub expectedBoth ($p1, $p2)
{
	return (1/(1+10**(($p1 - $p2)/400))), (1/(1+10**(($p2 - $p1)/400)));
}

# return the expected score of only one player ($p1)
sub expected ($p1, $p2)
{
	return 1/(1+10**(($p1 - $p2)/400));
}

# update rating of only $p1 (default k=32)
sub elo ($p1, $p2, $score)
{
	return round($p1 + 32 * ($score - expected($p1, $p2)) );
}

# update rating of both $p1 and $p2 (default k=32)
sub eloBoth ($p1, $p2, $score)
{
	return (round($p1 + 32 * ($score - expected($p1, $p2)) ),
			round($p2 + 32 * ((1-$score) - expected($p2, $p1)) ));
}

# update rating of only $p1 (k given as input)
sub eloK ($p1, $p2, $score, $k)
{
	return round($p1 + $k * ($score - expected($p1, $p2)) );
}

# update rating of both $p1 and $p2 (k given as input)
sub eloBothK ($p1, $p2, $score, $k)
{
	return ( round($p1 + $k * ($score - expected($p1, $p2)) ), 
			round($p2 + $k * ((1-$score) - expected($p2, $p1)) ) );
}

# a more generic version of the elo function, with score, k factor and expected
# result all supplied to get a new elo rating.
sub eloN ($p1, $score, $k, $e)
{
	return $p1 + $k * ($score - $e);
}

#############################
#
#
#	The actual "doing" part of the script
#	begins below this break
#
#
#############################


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
	# say $p1_name ~ $p2_name ~ $score;
	# set scores to 1600 if it's the first time their results appear
	if (%player.exists($p1_name) == Bool::False) {%player{$p1_name} = $defaultELO};
	if (%player.exists($p2_name) == Bool::False) {%player{$p2_name} = $defaultELO};
	(%player{$p1_name}, %player{$p2_name}) = eloBoth(%player{$p1_name}, %player{$p2_name}, $score);
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