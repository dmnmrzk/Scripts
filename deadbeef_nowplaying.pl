#!/usr/bin/perl -w

# Send title, time and progress bar from deadbeef music player to Weechat IRC Client
# Bar will appear in active window of your irc client

sub bar{
	my $db = `deadbeef --nowplaying %lv%e`;
	my ($length, $elapsed) = split('v', $db);
	my ($min_l, $sec_l) = split(':', $length);
	my ($min_e, $sec_e) = split(':', $elapsed);
	$sec_l += ($min_l * 60);
	$sec_e += ($min_e * 60);
	my $k = $sec_e / $sec_l * 20;
	my $bar = "[8";
	for(my $i = 1; $i <= $k; $i++){
		$bar.="\=";
	}
	$bar.="D";
	for(my $i = 1; $i <= 20 - $k; $i++){
		$bar .= "\ ";
	}
	$bar .= "( Y )]";
	return "$bar\n";
}
my $bar = bar();
my $song = `deadbeef --nowplaying "%a - %t"`;

# If you have weechat on remote machine, uncomment this ↓ line
# my $ssh = `ssh user\@some.host "echo '*/me is playing $song $bar' > ~/.weechat/weechat_fifo_*"`;

# If you are using weechat on localhost, uncomment this ↓ line
# my $localhost = `"echo '*/me is playing $song $bar' > ~/.weechat/weechat_fifo_*"`;
