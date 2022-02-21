extends RichTextLabel

export var other_display_path : NodePath
onready var other_display : RichTextLabel = get_node(other_display_path)

var all_texts = [
	"consulting priestbot...",
	"eating raw slime...",
	"extracting...",
	"bracing for impact...",
	"dancing in the sun...",
	"yodelling in a public location...",
	"colonizing...",
	"compiling assets...",
	"moving progress bar...",
	"stalling...",
	"Stalin...",
	"rejecting reality...",
	"substituting my own...",
	"generating history textbook...",
	"removing easter eggs...",
	"replacing easter eggs...",
	"moving everything 4 pixels to the left...",
	"using a fork for soup...",
	"reloading assets...",
	"generating mipmaps...",
	"connecting to ALBANIA-WEST server...",
	"sinking monaco...",
	"exiting development hell...",
	"entering development hell...",
	"winning game jams...",
	"compiling assembly...",
	"uploading local files...",
	"helling your chives...",
]
var texts = []

func _ready():
	randomize()

func add_new_text():
	all_texts.shuffle()
	texts.append(all_texts[0])
	
	bbcode_text = ""
	var a = 1.0
	for i in len(texts):
		var color_str = Color(1, 1, 1, a).to_html()
		bbcode_text += "[center][color=%s]%s" % [color_str, texts[len(texts) - i - 1]]
	
	other_display.bbcode_text = bbcode_text

func _on_UpdateTimer_timeout():
	$UpdateTimer.wait_time = rand_range(1.0, 1.5)
	add_new_text()
