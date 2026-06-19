extends Node2D

var generatedName : String

func getEasterEggLine(inputName):
	if (checkStringForArrayValue(inputName, easterEggNames) == true):
		if ("Krath Isarlith" in inputName):
			return krathLines.pick_random()
		if ("Perit Ackermann" in inputName):
			return ackerLines.pick_random()
	else:
		return "false"

func checkStringForArrayValue(string:String, stringList:Array):
	for eachString in stringList:
		if eachString in string:
			return true
	return false

var easterEggNames = [
	"Krath Isarlith",
	"Perit Ackermann"
	]

var krathLines = [
	"I'm going to commit deicide."
	]

var ackerLines = [
	"If a goose's parts are all replaced by new goose parts, is it the same goose?"
	]

var rejectLines = [
	"Never speak to me ever again.",
	"Pathetic.",
	"Shouldn't have dropped out of university.",
	"Jesus loves you! Bye!",
	"Ew!",
	"Stay away from me.",
	"Ummm no thanks.",
	"L.",
	"You are cringe.",
	"May your Ls be many and your bitches few.",
	"...?",
	"The wind is very loud today...",
	"I don't speak English.",
	"I haven't got money on me...",
	"Good luck?",
	"Please don't talk to me again."
	]

var acceptLines = [
	"You seem cool.",
	"Yeah, I've got some change.",
	"Good luck!",
	"Just to see what you do with it...",
	"We shall watch your career with great interest.",
	"I love you.",
	"I hate empathy! It keeps making me give away money!",
	"...this is realllly awkward.",
	"Your prayers have been answered!",
	"I don't believe in you, but keep going or something.",
	"Have faith!",
	"Yeah, I was once unable to buy coffee too...",
	"Go, do a crime.",
	"Pay me back.",
	"One time offer.",
	"You won't enslave all of humanity and turn Earth into a corporatocracy with this money right?"
	]

var logosLines = [
	"If you donate to me, you'll be helping me become a functioning member of society AND you won't have to pay taxes.",
	"Logically, you should donate to the homeless.",
	"If you don't give me money I will kill you",
	"Don't worry, I won't enslave all of humanity and turn Earth into a corporatocracy with this money.",
	"I'll pay you back - one day.",
	"You should give your money to me - I'll keep it safe!",
	"Hey, you might drop that cash anyway. Why not help me out?",
	"Looks like that money's really heavy - let me take the weight off your shoulders.",
	"You're gonna get robbed anyway, let me do it.",
	"Is that red envelope money?! Quick, give it to me before your parents take it!",
	"I will solve world hunger with this money.",
	"Come on, you'd be helping the economy!",
	"I'm going to be such a functioning member of society don't even worry about it!",
	"You don't want the other homeless people using this money on drugs, do you?",
	"It's mathematically and deterministically impossible for you to not donate.",
	"What's yours is mine, what's mine is mine. Pay up."
	]

var pathosLines = [
	"Please, don't you want to help those in need?",
	"If you don't help me, I'm gonna kill myself",
	"Please, I HAD a family!",
	"WE need the money...",
	"Have you heard of the legend Karl Marx?",
	"Sharing is caring!",
	"You're a greedy little shit right?! Treat others the way you want to be treated!",
	"Think of a delicious McDonald's meal. That I could be having!",
	"This game is entirely serious about it's depiction of homelessness and I can't believe you're not feeling guilty enough to hand over that cash.",
	"HELP ME. I'M GONNA STARVE.",
	"I'm not the greatest with words but I'm sure you're really empathetic and not a terrible person who wouldn't donate to a homeless person!",
	"I will never achieve my dreams if you specifically do not give me money.",
	"It is mathematically and deterministically impossible for me to get money from anyone else. Give it to me... please...",
	"I made zero poor life decisions! The system screwed me over!",
	"My dad will be very angry if I don't buy an apartment..."
	]

var ethosLines = [
	"As an authority on homelessness, I can confirm it is very bad. Please help with the problem.",
	"My uncle is the Duke of Homelesstown! He will have people mob you!",
	"I'm actually a Greek deity. If you don't give me money, I will smite you.",
	"I'm the descendant of a Nigerian prince and I will give you very much money if you give me money.",
	"It's me, your old friend. Don't you want to help me out?",
	"I'm your long lost child. Are you so heartless?!",
	"It's me, Gabriel. The doctors said you seem to think I'm some ...'ultra-kill' character. But I am your wife. Please honey... wake up.",
	"I foresee all futures, and there is only one where you don't give me money. It is inevitable",
	"Leave me without a coin, and I shall become more powerful than you can possibly imagine.",
	"Remember, anyone could be Jesus.",
	"I'm the world's foremost expert on cookie manufacturing. The clones, they threw me out of my own universe and I need money to get back!",
	"When I die, I have it on good word that I shall reincarnate as your soon to be stepparent. I will make your life hell.",
	"We homeless, we command the streets. Fail to pay your tithe today, and you shall find your apartment looted tomorrow.",
	"Your mother said you'd help me! Please, don't let her down!",
	"I am your parent. I am the reason you are adopted. I made you. You owe me.",
	"I am skilled in combat and a banned weapon in all 193 UN recognized countries. Give me money."
	]

var promoteLines = [
	"This one can cure cancer!",
	"This is what destroyed smallpox.",
	"Watch its resale value, peasant. You shall become a millonaire overnight!",
	"The meaning of life is in this very item.",
	"The journey to enlightenment begins with this.",
	"You will never taste a greater joy than this!",
	"It'll mend your marriage!",
	"Weight loss. 500 lbs. Instantly.",
	"Buy it. You wouldn't want to let it down, would you?",
	"This item is a pure manifestation of emotion. You shall never feel more alive!",
	"Legends say it can instantiate a bullet!",
	"A remnant of something great. Its potential may yet to be unlocked!",
	"You were destined for this.",
	"Take it before it takes you.",
	"The latest trend!"
	]
	
var urgencyLines = [
	"This won't be available tomorrow.",
	"Limited time offer!",
	"You might die tomorrow. Best try this before you do.",
	"You will die tomorrow. Best try this before you do.",
	"Almost out of stock!",
	"Running a discount for all people passing by on the street currently!",
	"Quick, buy this item! No questions! The world is at stake!",
	"You might never see this item again...",
	"Someone's coming to kill me. Buy this while you still can.",
	"You have the opportunity to buy this. This time only.",
	"It's never too late to try something new. Except tomorrow.",
	"Only a few left!",
	"You will need it soon. Be wise.",
	"Calling all procrastinators! This will finish your assignment for tomorrow!",
	"I know your friend wants to commit suicide. This will convince them not to!"
	]

var recommendLines = [
	"I would highly recommend this product.",
	"Your parents recommended this item to sell to you!",
	"I know you need this. Don't lie.",
	"The stock prices on this item will strike the stratosphere, mark my words.",
	"Finance, money, economics - forget about them all. Buy this stupid thing.",
	"It's worth it!",
	"For the low low price of however much you can muster...",
	"I recommend that you give me money. Don't even take the product - that's optional. Just give me money.",
	"You don't know what this is, do you? You don't understand what you're looking at.",
	"You'll love this one.",
	"This can fix your relationship!",
	"This will make your parents proud.",
	"I'm going to keep yelling at you to buy this. Might as well get it now.",
	"This is where your money should go!",
	"The greatest innovation to grace the human consciousness!"
	]

var fearmongerLines = [
	"If you don't buy this, you'll die.",
	"Everyone has this now. Don't get left behind.",
	"This - this is the future!",
	"Get with the times already. You might already be too late.",
	"Lady Death is calling your name - but don't worry. This will save you!",
	"You don't understand what is at stake yet. Act before you do.",
	"Ominous words and spooky prophetics! Act fast!",
	"The Oracle has told me you're going to fucking die if you don't buy this.",
	"This company's about to bought out by Macroslop! This might be the last independent item you can still buy from them!",
	"You're cooked without this.",
	"The latest trend! Don't get left behind.",
	"Join the future today with this legendary product.",
	"You're dying. Cure yourself.",
	"The newest pandemic is on the rise! Stop it before it reaches you!",
	"This shall protect from all danger!"
	]

@onready var names = ["Alex","Oliver","Lily","Amanda","Murray","Albert","Porter","Fred",
	"Mitchell","Vasquez","Richard","Hall","Steven","Torres","Randy","Gonzalez","Bailey",
	"Earl","Martinez","Sean","Ruiz","Sharon","Moore","Terry","Evans","Shawn","Edward",
	"Edwards","Donna", "Myers","Louise","Scott","Phillip","Miller","Ashley","Daniel",
	"Daniels","Michael","Russell","Robert","Frances","Baker","Aryon","Ari","Hastor","Bia",
	"Faelorn","Duskir","Castell","Rosa","Rosalith","Verosaven","Dan","Krath","Isarlith",
	"Raelia","Mael","Vir","Drehbal","Anyr","Malsohm","Dahr","Keppelky","Arodorros","Nayirah",
	"May","Lloyd","Limril","Ramuj","Drehn","Jason","Asano","Humphrey","Geller","Sophie","Melody",
	"Jain","Will","Neil","Davone","Belinda","Callahan","Clive","Standish","Rufus","Remore",
	"Arabelle","Gabriel", "Perit", "Ackermann", "Rebecca", "Mason", "Mary", "Patricia","Linda",
	"Barbara","Elizabeth","Charist","Jennifer","Maria","Susan","Margaret","Dorothy","Lisa","Nancy",
	"Karen","Betty","Helen","Sandra","Donna","Carol","Ruth","Sharon","Michelle","Laura","Sarah",
	"Kimberly","Deborah","Jessica","Shirley","Cynthia","Angela","Melissa","Brenda","Amy","Anna",
	"Virginia","Kathleen","Pamela","Martha","Debra","Stephanie","Carolyn","Christine","Marie",
	"Janet","Catherine","Ann","Joyce","Diane","Julie","Heather","John","Matthews","Malie","Door",
	"Guy","Ponder","Kali","Aimes","Max","Teresa","Doris","Gloria","Evelyn","Jean","Cheryl","Mildred",
	"Joan","Judith","Rose","Janice","Kelly","Nicole","Judy","Christina","Kathy","Theresa","Beverly",
	"Denise","Tammy","Jane","Lori","Rachel","Marilyn","Andrea","Kathryn","Sara","Anne","Jacqueline",
	"Wanda","Bonnie","Julia","Lois","Ruby","Tina","Phyllis","Norma","Paula","Diana","Annie","Lillian",
	"Emily","Robin","Hailon","Halos","Aleth","Baruch","Noka","Uzi","Doll","Siri","Keeton","Daniel",
	"Bruks","Ell","Lull","Circe","Kira","Jim","Sunday","Ahzmundin","Viktor","Thalleous","Senn","Ria",
	"Ingressus","Achillean","Nestoris","Kaltaris","Voltaris","Sendaris","Mendoris","Zulius","Sonya",
	"Kyra","Kye","Democritus","Jinx","Violet","James","David","Kim","Liam","Vickers","Lee","Ham",
	"Vinegars","Caitlyn","Grace","Ryland","Khive","Rihelma","Taihgel","Mytho","Vehmil","Baen","Thresa",
	"Vera","Gohri","Zed","Kahmas","Orix","Cehein","Eleis","Koen","Verpyne","Devro","Ihb","Ekari","Zevve",
	"Kai","Runt","Breeze","Wizard","Harry","Mel","Mossa","Asahi","Ayaka","Kazuma","Takei","Nakamura",
	"Fujita","Max","Kirie","Ash","William","Charles","Joseph","Thomas","Christopher","Paul","Mark","Donald",
	"Trump","George","Kenneth","Brian","Ronald","Anthony","Gary","Timothy","Jose","Larry","Jeffrey",
	"Frank","Eric","Raymond","Holt","Joshua","Jerry","Dennis","Jeremy","Joel","Walter","Patrick","Peter",
	"Watts","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Jonathan",
	"Justin","Terry","Gerald","Keith","Samuel","Ralph","Lawrence","Fox","Fosh","Nicholas","Roy","Benjamin",
	"Maurice","Bruce","Brandon","Adam","Wayne","Billy","Steve","Louis","Aaron","Howard","Eugene","Carlos",
	"Russell","Victor","Martin","Ernest","Todd","Jesse","Craig","Alan","Shawn","Clarence","Chris","Johnny",
	"Antonio","Jimmy","Smith","Johnson","Brown","Jones","Miller","Davis","Garcia","Rodriguez","Wilson",
	"Anderson","Taylor","Hernandez","Martin","Jackson","Thompson","White","Lopez","Gonzalez","Zhang","Harris",
	"Clark","Washington","Lewis","Robinson","Walker","Perez","Young","Allen","Sanchez","Wright","King",
	"Green","Baker","Adams","Nelson","Hill","Ramirez","Campbell","Mitchell","Roberts","Carter","Turner",
	"Parker","Collins","Stewart","Flores","Morris","Nguyen","Murphy","Rivera","Cook","Rogers","Morgan",
	"Peterson","Cooper","Reed","Bailey","Bell","Gomez","Kelly","Howard","Ward","Cox","Diaz","Richardson",
	"Wood","Watson","Brooks","Benett","Gray","Reyes","Cruz","Hughes","Price","Long","Foster","Sanders",
	"Ross","Morales","Powell","Miles","Sullivan","Sulliman","Ortiz","Jenkins","Gutierrez","Perry","Butler",
	"Barnes","Fisher","Henderson","Coleman","Simmons","Patterson","Jordan","Reynolds","Hamilton","Alexander",
	"Ramos","Wallace","Amos","Pensinata","Rimaros","Mercer","Griffin","West","Cole","Hayes","Chavez","Gibson",
	"Amouz","Bryant","Ellis","Ford","Marshall","Owen","Harrison","Kennedy","Wells","Alvarez","Mendoza",
	"Castillo","Olson","Webb","Tucker","Freeman","Burns","Snyder","Simpson","Crawford","Jimenez","Shaw","Gordon",
	"Wagner","Hunter","Romero","Romeo","Juliet","Hicks","Dixon","Hunt","Palmer","Robertson","Black","Holmes",
	"Sherlock","Stone","Meter","Boyd","Mills","Warren","Rice","Moreno","Schmidt","Patel","Sherry","Sawchuk",
	"Valente","Giovanni","Manhas","Ferguson","Nichols","Herrera","Medina","Fernandez","Weaver","Gardner",
	"Payne","Kelley","Dunn","Pierce","Arnold","Tran","Spencer","Peters","Hawkins","Cunningham","Grant",
	"Hansen","Castro","Hoffman","Hart","Elliott","Knight","Bradley","Millicent","Alinor","Eleanor","Agnes",
	"Avice","Beatrice","Cecily","Emma","Isabella","Juliana","Matilda","Roh","Kethleen","Annabel","Mabel",
	"Meredith","Geoffrey","Gilbert","Hugh","Nicholas","Ralf","Albin","Bayard","Edwin","Erwin","Percival",
	"Godfrey","Glad","Tall","Mont","Lov","Rain","Craft","Lion","Ship","Quiver","Ashdown","Baker","Bigge",
	"Brickenden","Brooker","Browne","Carpenter","Cheeseman","Clarke","Fletcher","Payne","Rolfe","Webb","Abbey",
	"Baxter","Arkwright","Bauer","Brewster","Chamberlain","Chandler","Chapman","Collier","Dempster","Harper",
	"Koch","Saylor","Scrivens","Sommer","Steele","Spinner","Stoddard","Swit","Toller","Wainwright","Aimar",
	"Blythe","Bonner","Bullard","Chance","Curtis","Daft","Everett","Hardy","Keen","Pratt","Proude","Rey","Russ",
	"Terrell","Truman","Campbell","Dunn","Lola","Zeria","Myriad","Lovelace","Cassidy","Bob","Borbon","Bradbury",
	"Isaac","Werber","Alastor","Star","Aelia","Amelia","Agrippa","Aurelia","Aurelius","Camilla","Claudia","Cornelia",
	"Lucia","Octavia","Priscilla","Paula","Valerie","Claudius","Cassius","Cornelius","Dominus","Julius","Caesar",
	"Amirlith","Arithine","Criodun","Aethein","Daethai","Dysphorium","Haelborne","Heathborne","Verion",
	"Diorvana","Diansu","Vulkarch","Lux","Moriya","Dune","Kaal","Jes","Fin","Boris","Allev","Fel","Roril",
	"Sehrogate","Alluvlos","Atlantan","Aunper","Delira","Edenthein","Eorwin","Altegan","Ando","Balvant","Cor",
	"Delvo","Naf","Neidle","Noro","Seymont","Sojas","Takyoth","Therton","Verth","Ahnoa","Alleveis","Dawe",
	"Kandor","Kynor","Ruryon","Sahrongard","Carioneth","Feykang","Haelcrien","Dewlos","Haequar","Evedast",
	"Javen","Roriodo","Troltano","Avertine","Rueleva","Dawne","Aethereanil","Aether","Aethe","Mirhro","Dustheus",
	"Anaslithim","Doroclob","Leforgoj","Prieniad","Akhloroma","Prieniad","Savestinov","Elzorn","Almveth","Arkenturia",
	"Lilianaera","Calchime","Lillina","Shwombosia","Sol","Varuhn","Veruhkt","Arkeje","Aelon","Greyspire","Ihted",
	"Rihanar","Yriel","Palaesida","Naharja","Avsal","Avsohm","Caer","Hovadchear","Drehua","Loraga","Sahd","Sal",
	"Drahbes","Faehrcyle","Yav","Casai","Lorahn","Kahl","Zithis","Carrow","Vayel","Drabyel","Dusps","Mohta","Okeke",
	"Elvett","Marahza","Schlonko","Tahva"
	]

func _ready() -> void:
	pass
