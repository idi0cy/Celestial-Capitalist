extends Node2D

#to put in front of " developed by idi0cy and Ratseer"
var wordBank = ["unfortunately", "terribly", "wonderfully", "generously",
"slowly", "beautifully", "miserably", "questionably", "undeniably", "possibly",
"truly", "weirdly", "strangely", "stupidly", "idi0tically", "amazingly",
"mistakenly", "wrongfully", "sadly", "poorly", "perfectly", "mysteriously",
"greedily", "disturbingly", "demonstrably", "debatably", "woefully",
"insanely", "crazily", "ignorantly", "rationally", "irationally", "ignorantly",
"pathetically", "awesomely", "obtusely", "moronically", "efficiently",
"traditionally", "enjoyably", "stylishly", "significantly", "badly", "exhaustingly",
"apparently", "somehow", "miraculously", "critically", "flawlessly", "imperfectly",
"actually", "really", "painfully", "goofily", "suspiciously", "violently", "peacfully",
"fearfully", "definitley", "half", "hilariously", "sympathetically", "fortunately",
"luckily", "honestly", "genuinely", "conventionally", "legitimately", "illegally",
"legally", "altruistically", "ethically", "unethically", "morally", "benevolently",
"charitably", "inevitably", "inexorably", "pedantically", "clearly", "prudently",
"offensively", "shrewdly", "cautiously", "wisely", "foolishly", "witlessly",
"densely", "obliviously", "objectively", "subjectively", "deniably", "selfishly",
"selflessly", "tactically", "unintentionally", "intentionally", "basically",
"kind of", "complicatedly", "intricately", "plainly", "indeed", "frankly",
"seemingly", "plausibly", "ostensibly", "authentically", "synthetically",
"sparsely"]

func _ready():
	hide()

func _on_credits_button_credits_pressed() -> void:
	$RichTextLabel.text = "[color=yellow]Celestial Capitalist[/color] is a game [color=green]" + pickRandom() + "[/color] developed by [color=cyan]idi0cy[/color] and [color=red]Ratseer[/color]"
	show()

func pickRandom():
	return wordBank[randi_range(0, (len(wordBank) - 1))]

func _on_exit_button_pressed() -> void:
	hide()
