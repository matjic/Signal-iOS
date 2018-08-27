//
//  Copyright (c) 2018 Open Whisper Systems. All rights reserved.
//

#import "DebugUIContacts.h"
#import "OWSTableViewController.h"
#import "Signal-Swift.h"
#import "SignalApp.h"
#import <Contacts/Contacts.h>
#import <Curve25519Kit/Randomness.h>

NS_ASSUME_NONNULL_BEGIN

@implementation DebugUIContacts

#pragma mark - Factory Methods

- (NSString *)name
{
    return @"Contacts";
}

- (nullable OWSTableSection *)sectionForThread:(nullable TSThread *)thread
{
    return [OWSTableSection sectionWithTitle:self.name
                                       items:@[
                                           [OWSTableItem itemWithTitle:@"Create 1 Random Contact"
                                                           actionBlock:^{
                                                               [DebugUIContacts createRandomContacts:1];
                                                           }],
                                           [OWSTableItem itemWithTitle:@"Create 100 Random Contacts"
                                                           actionBlock:^{
                                                               [DebugUIContacts createRandomContacts:100];
                                                           }],
                                           [OWSTableItem itemWithTitle:@"Create 1k Random Contacts"
                                                           actionBlock:^{
                                                               [DebugUIContacts createRandomContacts:1000];
                                                           }],
                                           [OWSTableItem itemWithTitle:@"Create 10k Random Contacts"
                                                           actionBlock:^{
                                                               [DebugUIContacts createRandomContacts:10 * 1000];
                                                           }],
                                           [OWSTableItem itemWithTitle:@"Delete Random Contacts"
                                                           actionBlock:^{
                                                               [DebugUIContacts deleteRandomContacts];
                                                           }],
                                           [OWSTableItem itemWithTitle:@"Delete All Contacts"
                                                           actionBlock:^{
                                                               [DebugUIContacts deleteAllContacts];
                                                           }],
                                           [OWSTableItem itemWithTitle:@"Clear SignalAccount Cache"
                                                           actionBlock:^{
                                                               [DebugUIContacts clearSignalAccountCache];
                                                           }],
                                           [OWSTableItem itemWithTitle:@"Clear SignalRecipient Cache"
                                                           actionBlock:^{
                                                               [DebugUIContacts clearSignalRecipientCache];
                                                           }],
                                           [OWSTableItem itemWithTitle:@"New Unregistered Contact Thread"
                                                           actionBlock:^{
                                                               [DebugUIContacts createUnregisteredContactThread];
                                                           }],
                                           [OWSTableItem itemWithTitle:@"New Unregistered Group Thread"
                                                           actionBlock:^{
                                                               [DebugUIContacts createUnregisteredGroupThread];
                                                           }],
                                       ]];
}

+ (NSString *)randomFirstName
{
    NSArray<NSString *> *values = @[
        @"Alice",
        @"Arthur",
        @"Bertha",
        @"Bob",
        @"Carol",
        @"Carole",
        @"Carlos",
        @"Charlie",
        @"Chuck",
        @"Craig",
        @"Dan",
        @"Dave",
        @"David",
        @"Erin",
        @"Eve",
        @"Faythe",
        @"Frank",
        @"Grace",
        @"Heidi",
        @"Lilia",
        @"Mallory",
        @"Mallet",
        @"Moxie",
        @"Oscar",
        @"Peggy",
        @"Pat",
        @"Paul",
        @"Riya",
        @"Scott",
        @"Sybil",
        @"Trent",
        @"Ted",
        @"Trevor",
        @"Trudy",
        @"Victor",
        @"Vanna",
        @"Walter",
        @"Wendy",
        @"Merlin",
    ];
    return values[(NSUInteger)arc4random_uniform((uint32_t)values.count)];
}

+ (NSString *)randomLastName
{
    NSArray<NSString *> *values = @[
        @"Smith",
        @"Johnson",
        @"Williams",
        @"Jones",
        @"Brown",
        @"Davis",
        @"Miller",
        @"Wilson",
        @"Moore",
        @"Taylor",
        @"Anderson",
        @"Thomas",
        @"Jackson",
        @"White",
        @"Harris",
        @"Martin",
        @"Thompson",
        @"Garcia",
        @"Martinez",
        @"Robinson",
        @"Clark",
        @"Rodriguez",
        @"Lewis",
        @"Lee",
        @"Walker",
        @"Hall",
        @"Allen",
        @"Young",
        @"Hernandez",
        @"King",
        @"Wright",
        @"Lopez",
        @"Hill",
        @"Scott",
        @"Green",
        @"Adams",
        @"Baker",
        @"Gonzalez",
        @"Nelson",
        @"Carter",
        @"Mitchell",
        @"Perez",
        @"Roberts",
        @"Turner",
        @"Phillips",
        @"Campbell",
        @"Parker",
        @"Evans",
        @"Edwards",
        @"Collins",
        @"Stewart",
        @"Sanchez",
        @"Morris",
        @"Rogers",
        @"Reed",
        @"Cook",
        @"Morgan",
        @"Bell",
        @"Murphy",
        @"Bailey",
        @"Rivera",
        @"Cooper",
        @"Richardson",
        @"Cox",
        @"Howard",
        @"Ward",
        @"Torres",
        @"Peterson",
        @"Gray",
        @"Ramirez",
        @"James",
        @"Watson",
        @"Brooks",
        @"Kelly",
        @"Sanders",
        @"Price",
        @"Bennett",
        @"Wood",
        @"Barnes",
        @"Ross",
        @"Henderson",
        @"Coleman",
        @"Jenkins",
        @"Perry",
        @"Powell",
        @"Long",
        @"Patterson",
        @"Hughes",
        @"Flores",
        @"Washington",
        @"Butler",
        @"Simmons",
        @"Foster",
        @"Gonzales",
        @"Bryant",
        @"Alexander",
        @"Russell",
        @"Griffin",
        @"Diaz",
        @"Hayes",
        @"Myers",
        @"Ford",
        @"Hamilton",
        @"Graham",
        @"Sullivan",
        @"Wallace",
        @"Woods",
        @"Cole",
        @"West",
        @"Jordan",
        @"Owens",
        @"Reynolds",
        @"Fisher",
        @"Ellis",
        @"Harrison",
        @"Gibson",
        @"Mcdonald",
        @"Cruz",
        @"Marshall",
        @"Ortiz",
        @"Gomez",
        @"Murray",
        @"Freeman",
        @"Wells",
        @"Webb",
        @"Simpson",
        @"Stevens",
        @"Tucker",
        @"Porter",
        @"Hunter",
        @"Hicks",
        @"Crawford",
        @"Henry",
        @"Boyd",
        @"Mason",
        @"Morales",
        @"Kennedy",
        @"Warren",
        @"Dixon",
        @"Ramos",
        @"Reyes",
        @"Burns",
        @"Gordon",
        @"Shaw",
        @"Holmes",
        @"Rice",
        @"Robertson",
        @"Hunt",
        @"Black",
        @"Daniels",
        @"Palmer",
        @"Mills",
        @"Nichols",
        @"Grant",
        @"Knight",
        @"Ferguson",
        @"Rose",
        @"Stone",
        @"Hawkins",
        @"Dunn",
        @"Perkins",
        @"Hudson",
        @"Spencer",
        @"Gardner",
        @"Stephens",
        @"Payne",
        @"Pierce",
        @"Berry",
        @"Matthews",
        @"Arnold",
        @"Wagner",
        @"Willis",
        @"Ray",
        @"Watkins",
        @"Olson",
        @"Carroll",
        @"Duncan",
        @"Snyder",
        @"Hart",
        @"Cunningham",
        @"Bradley",
        @"Lane",
        @"Andrews",
        @"Ruiz",
        @"Harper",
        @"Fox",
        @"Riley",
        @"Armstrong",
        @"Carpenter",
        @"Weaver",
        @"Greene",
        @"Lawrence",
        @"Elliott",
        @"Chavez",
        @"Sims",
        @"Austin",
        @"Peters",
        @"Kelley",
        @"Franklin",
        @"Lawson",
        @"Fields",
        @"Gutierrez",
        @"Ryan",
        @"Schmidt",
        @"Carr",
        @"Vasquez",
        @"Castillo",
        @"Wheeler",
        @"Chapman",
        @"Oliver",
        @"Montgomery",
        @"Richards",
        @"Williamson",
        @"Johnston",
        @"Banks",
        @"Meyer",
        @"Bishop",
        @"Mccoy",
        @"Howell",
        @"Alvarez",
        @"Morrison",
        @"Hansen",
        @"Fernandez",
        @"Garza",
        @"Harvey",
        @"Little",
        @"Burton",
        @"Stanley",
        @"Nguyen",
        @"George",
        @"Jacobs",
        @"Reid",
        @"Kim",
        @"Fuller",
        @"Lynch",
        @"Dean",
        @"Gilbert",
        @"Garrett",
        @"Romero",
        @"Welch",
        @"Larson",
        @"Frazier",
        @"Burke",
        @"Hanson",
        @"Day",
        @"Mendoza",
        @"Moreno",
        @"Bowman",
        @"Medina",
        @"Fowler",
        @"Brewer",
        @"Hoffman",
        @"Carlson",
        @"Silva",
        @"Pearson",
        @"Holland",
        @"Douglas",
        @"Fleming",
        @"Jensen",
        @"Vargas",
        @"Byrd",
        @"Davidson",
        @"Hopkins",
        @"May",
        @"Terry",
        @"Herrera",
        @"Wade",
        @"Soto",
        @"Walters",
        @"Curtis",
        @"Neal",
        @"Caldwell",
        @"Lowe",
        @"Jennings",
        @"Barnett",
        @"Graves",
        @"Jimenez",
        @"Horton",
        @"Shelton",
        @"Barrett",
        @"O'brien",
        @"Castro",
        @"Sutton",
        @"Gregory",
        @"Mckinney",
        @"Lucas",
        @"Miles",
        @"Craig",
        @"Rodriquez",
        @"Chambers",
        @"Holt",
        @"Lambert",
        @"Fletcher",
        @"Watts",
        @"Bates",
        @"Hale",
        @"Rhodes",
        @"Pena",
        @"Beck",
        @"Newman",
        @"Haynes",
        @"Mcdaniel",
        @"Mendez",
        @"Bush",
        @"Vaughn",
        @"Parks",
        @"Dawson",
        @"Santiago",
        @"Norris",
        @"Hardy",
        @"Love",
        @"Steele",
        @"Curry",
        @"Powers",
        @"Schultz",
        @"Barker",
        @"Guzman",
        @"Page",
        @"Munoz",
        @"Ball",
        @"Keller",
        @"Chandler",
        @"Weber",
        @"Leonard",
        @"Walsh",
        @"Lyons",
        @"Ramsey",
        @"Wolfe",
        @"Schneider",
        @"Mullins",
        @"Benson",
        @"Sharp",
        @"Bowen",
        @"Daniel",
        @"Barber",
        @"Cummings",
        @"Hines",
        @"Baldwin",
        @"Griffith",
        @"Valdez",
        @"Hubbard",
        @"Salazar",
        @"Reeves",
        @"Warner",
        @"Stevenson",
        @"Burgess",
        @"Santos",
        @"Tate",
        @"Cross",
        @"Garner",
        @"Mann",
        @"Mack",
        @"Moss",
        @"Thornton",
        @"Dennis",
        @"Mcgee",
        @"Farmer",
        @"Delgado",
        @"Aguilar",
        @"Vega",
        @"Glover",
        @"Manning",
        @"Cohen",
        @"Harmon",
        @"Rodgers",
        @"Robbins",
        @"Newton",
        @"Todd",
        @"Blair",
        @"Higgins",
        @"Ingram",
        @"Reese",
        @"Cannon",
        @"Strickland",
        @"Townsend",
        @"Potter",
        @"Goodwin",
        @"Walton",
        @"Rowe",
        @"Hampton",
        @"Ortega",
        @"Patton",
        @"Swanson",
        @"Joseph",
        @"Francis",
        @"Goodman",
        @"Maldonado",
        @"Yates",
        @"Becker",
        @"Erickson",
        @"Hodges",
        @"Rios",
        @"Conner",
        @"Adkins",
        @"Webster",
        @"Norman",
        @"Malone",
        @"Hammond",
        @"Flowers",
        @"Cobb",
        @"Moody",
        @"Quinn",
        @"Blake",
        @"Maxwell",
        @"Pope",
        @"Floyd",
        @"Osborne",
        @"Paul",
        @"Mccarthy",
        @"Guerrero",
        @"Lindsey",
        @"Estrada",
        @"Sandoval",
        @"Gibbs",
        @"Tyler",
        @"Gross",
        @"Fitzgerald",
        @"Stokes",
        @"Doyle",
        @"Sherman",
        @"Saunders",
        @"Wise",
        @"Colon",
        @"Gill",
        @"Alvarado",
        @"Greer",
        @"Padilla",
        @"Simon",
        @"Waters",
        @"Nunez",
        @"Ballard",
        @"Schwartz",
        @"Mcbride",
        @"Houston",
        @"Christensen",
        @"Klein",
        @"Pratt",
        @"Briggs",
        @"Parsons",
        @"Mclaughlin",
        @"Zimmerman",
        @"French",
        @"Buchanan",
        @"Moran",
        @"Copeland",
        @"Roy",
        @"Pittman",
        @"Brady",
        @"Mccormick",
        @"Holloway",
        @"Brock",
        @"Poole",
        @"Frank",
        @"Logan",
        @"Owen",
        @"Bass",
        @"Marsh",
        @"Drake",
        @"Wong",
        @"Jefferson",
        @"Park",
        @"Morton",
        @"Abbott",
        @"Sparks",
        @"Patrick",
        @"Norton",
        @"Huff",
        @"Clayton",
        @"Massey",
        @"Lloyd",
        @"Figueroa",
        @"Carson",
        @"Bowers",
        @"Roberson",
        @"Barton",
        @"Tran",
        @"Lamb",
        @"Harrington",
        @"Casey",
        @"Boone",
        @"Cortez",
        @"Clarke",
        @"Mathis",
        @"Singleton",
        @"Wilkins",
        @"Cain",
        @"Bryan",
        @"Underwood",
        @"Hogan",
        @"Mckenzie",
        @"Collier",
        @"Luna",
        @"Phelps",
        @"Mcguire",
        @"Allison",
        @"Bridges",
        @"Wilkerson",
        @"Nash",
        @"Summers",
        @"Atkins",
        @"Wilcox",
        @"Pitts",
        @"Conley",
        @"Marquez",
        @"Burnett",
        @"Richard",
        @"Cochran",
        @"Chase",
        @"Davenport",
        @"Hood",
        @"Gates",
        @"Clay",
        @"Ayala",
        @"Sawyer",
        @"Roman",
        @"Vazquez",
        @"Dickerson",
        @"Hodge",
        @"Acosta",
        @"Flynn",
        @"Espinoza",
        @"Nicholson",
        @"Monroe",
        @"Wolf",
        @"Morrow",
        @"Kirk",
        @"Randall",
        @"Anthony",
        @"Whitaker",
        @"O'connor",
        @"Skinner",
        @"Ware",
        @"Molina",
        @"Kirby",
        @"Huffman",
        @"Bradford",
        @"Charles",
        @"Gilmore",
        @"Dominguez",
        @"O'neal",
        @"Bruce",
        @"Lang",
        @"Combs",
        @"Kramer",
        @"Heath",
        @"Hancock",
        @"Gallagher",
        @"Gaines",
        @"Shaffer",
        @"Short",
        @"Wiggins",
        @"Mathews",
        @"Mcclain",
        @"Fischer",
        @"Wall",
        @"Small",
        @"Melton",
        @"Hensley",
        @"Bond",
        @"Dyer",
        @"Cameron",
        @"Grimes",
        @"Contreras",
        @"Christian",
        @"Wyatt",
        @"Baxter",
        @"Snow",
        @"Mosley",
        @"Shepherd",
        @"Larsen",
        @"Hoover",
        @"Beasley",
        @"Glenn",
        @"Petersen",
        @"Whitehead",
        @"Meyers",
        @"Keith",
        @"Garrison",
        @"Vincent",
        @"Shields",
        @"Horn",
        @"Savage",
        @"Olsen",
        @"Schroeder",
        @"Hartman",
        @"Woodard",
        @"Mueller",
        @"Kemp",
        @"Deleon",
        @"Booth",
        @"Patel",
        @"Calhoun",
        @"Wiley",
        @"Eaton",
        @"Cline",
        @"Navarro",
        @"Harrell",
        @"Lester",
        @"Humphrey",
        @"Parrish",
        @"Duran",
        @"Hutchinson",
        @"Hess",
        @"Dorsey",
        @"Bullock",
        @"Robles",
        @"Beard",
        @"Dalton",
        @"Avila",
        @"Vance",
        @"Rich",
        @"Blackwell",
        @"York",
        @"Johns",
        @"Blankenship",
        @"Trevino",
        @"Salinas",
        @"Campos",
        @"Pruitt",
        @"Moses",
        @"Callahan",
        @"Golden",
        @"Montoya",
        @"Hardin",
        @"Guerra",
        @"Mcdowell",
        @"Carey",
        @"Stafford",
        @"Gallegos",
        @"Henson",
        @"Wilkinson",
        @"Booker",
        @"Merritt",
        @"Miranda",
        @"Atkinson",
        @"Orr",
        @"Decker",
        @"Hobbs",
        @"Preston",
        @"Tanner",
        @"Knox",
        @"Pacheco",
        @"Stephenson",
        @"Glass",
        @"Rojas",
        @"Serrano",
        @"Marks",
        @"Hickman",
        @"English",
        @"Sweeney",
        @"Strong",
        @"Prince",
        @"Mcclure",
        @"Conway",
        @"Walter",
        @"Roth",
        @"Maynard",
        @"Farrell",
        @"Lowery",
        @"Hurst",
        @"Nixon",
        @"Weiss",
        @"Trujillo",
        @"Ellison",
        @"Sloan",
        @"Juarez",
        @"Winters",
        @"Mclean",
        @"Randolph",
        @"Leon",
        @"Boyer",
        @"Villarreal",
        @"Mccall",
        @"Gentry",
        @"Carrillo",
        @"Kent",
        @"Ayers",
        @"Lara",
        @"Shannon",
        @"Sexton",
        @"Pace",
        @"Hull",
        @"Leblanc",
        @"Browning",
        @"Velasquez",
        @"Leach",
        @"Chang",
        @"House",
        @"Sellers",
        @"Herring",
        @"Noble",
        @"Foley",
        @"Bartlett",
        @"Mercado",
        @"Landry",
        @"Durham",
        @"Walls",
        @"Barr",
        @"Mckee",
        @"Bauer",
        @"Rivers",
        @"Everett",
        @"Bradshaw",
        @"Pugh",
        @"Velez",
        @"Rush",
        @"Estes",
        @"Dodson",
        @"Morse",
        @"Sheppard",
        @"Weeks",
        @"Camacho",
        @"Bean",
        @"Barron",
        @"Livingston",
        @"Middleton",
        @"Spears",
        @"Branch",
        @"Blevins",
        @"Chen",
        @"Kerr",
        @"Mcconnell",
        @"Hatfield",
        @"Harding",
        @"Ashley",
        @"Solis",
        @"Herman",
        @"Frost",
        @"Giles",
        @"Blackburn",
        @"William",
        @"Pennington",
        @"Woodward",
        @"Finley",
        @"Mcintosh",
        @"Koch",
        @"Best",
        @"Solomon",
        @"Mccullough",
        @"Dudley",
        @"Nolan",
        @"Blanchard",
        @"Rivas",
        @"Brennan",
        @"Mejia",
        @"Kane",
        @"Benton",
        @"Joyce",
        @"Buckley",
        @"Haley",
        @"Valentine",
        @"Maddox",
        @"Russo",
        @"Mcknight",
        @"Buck",
        @"Moon",
        @"Mcmillan",
        @"Crosby",
        @"Berg",
        @"Dotson",
        @"Mays",
        @"Roach",
        @"Church",
        @"Chan",
        @"Richmond",
        @"Meadows",
        @"Faulkner",
        @"O'neill",
        @"Knapp",
        @"Kline",
        @"Barry",
        @"Ochoa",
        @"Jacobson",
        @"Gay",
        @"Avery",
        @"Hendricks",
        @"Horne",
        @"Shepard",
        @"Hebert",
        @"Cherry",
        @"Cardenas",
        @"Mcintyre",
        @"Whitney",
        @"Waller",
        @"Holman",
        @"Donaldson",
        @"Cantu",
        @"Terrell",
        @"Morin",
        @"Gillespie",
        @"Fuentes",
        @"Tillman",
        @"Sanford",
        @"Bentley",
        @"Peck",
        @"Key",
        @"Salas",
        @"Rollins",
        @"Gamble",
        @"Dickson",
        @"Battle",
        @"Santana",
        @"Cabrera",
        @"Cervantes",
        @"Howe",
        @"Hinton",
        @"Hurley",
        @"Spence",
        @"Zamora",
        @"Yang",
        @"Mcneil",
        @"Suarez",
        @"Case",
        @"Petty",
        @"Gould",
        @"Mcfarland",
        @"Sampson",
        @"Carver",
        @"Bray",
        @"Rosario",
        @"Macdonald",
        @"Stout",
        @"Hester",
        @"Melendez",
        @"Dillon",
        @"Farley",
        @"Hopper",
        @"Galloway",
        @"Potts",
        @"Bernard",
        @"Joyner",
        @"Stein",
        @"Aguirre",
        @"Osborn",
        @"Mercer",
        @"Bender",
        @"Franco",
        @"Rowland",
        @"Sykes",
        @"Benjamin",
        @"Travis",
        @"Pickett",
        @"Crane",
        @"Sears",
        @"Mayo",
        @"Dunlap",
        @"Hayden",
        @"Wilder",
        @"Mckay",
        @"Coffey",
        @"Mccarty",
        @"Ewing",
        @"Cooley",
        @"Vaughan",
        @"Bonner",
        @"Cotton",
        @"Holder",
        @"Stark",
        @"Ferrell",
        @"Cantrell",
        @"Fulton",
        @"Lynn",
        @"Lott",
        @"Calderon",
        @"Rosa",
        @"Pollard",
        @"Hooper",
        @"Burch",
        @"Mullen",
        @"Fry",
        @"Riddle",
        @"Levy",
        @"David",
        @"Duke",
        @"O'donnell",
        @"Guy",
        @"Michael",
        @"Britt",
        @"Frederick",
        @"Daugherty",
        @"Berger",
        @"Dillard",
        @"Alston",
        @"Jarvis",
        @"Frye",
        @"Riggs",
        @"Chaney",
        @"Odom",
        @"Duffy",
        @"Fitzpatrick",
        @"Valenzuela",
        @"Merrill",
        @"Mayer",
        @"Alford",
        @"Mcpherson",
        @"Acevedo",
        @"Donovan",
        @"Barrera",
        @"Albert",
        @"Cote",
        @"Reilly",
        @"Compton",
        @"Raymond",
        @"Mooney",
        @"Mcgowan",
        @"Craft",
        @"Cleveland",
        @"Clemons",
        @"Wynn",
        @"Nielsen",
        @"Baird",
        @"Stanton",
        @"Snider",
        @"Rosales",
        @"Bright",
        @"Witt",
        @"Stuart",
        @"Hays",
        @"Holden",
        @"Rutledge",
        @"Kinney",
        @"Clements",
        @"Castaneda",
        @"Slater",
        @"Hahn",
        @"Emerson",
        @"Conrad",
        @"Burks",
        @"Delaney",
        @"Pate",
        @"Lancaster",
        @"Sweet",
        @"Justice",
        @"Tyson",
        @"Sharpe",
        @"Whitfield",
        @"Talley",
        @"Macias",
        @"Irwin",
        @"Burris",
        @"Ratliff",
        @"Mccray",
        @"Madden",
        @"Kaufman",
        @"Beach",
        @"Goff",
        @"Cash",
        @"Bolton",
        @"Mcfadden",
        @"Levine",
        @"Good",
        @"Byers",
        @"Kirkland",
        @"Kidd",
        @"Workman",
        @"Carney",
        @"Dale",
        @"Mcleod",
        @"Holcomb",
        @"England",
        @"Finch",
        @"Head",
        @"Burt",
        @"Hendrix",
        @"Sosa",
        @"Haney",
        @"Franks",
        @"Sargent",
        @"Nieves",
        @"Downs",
        @"Rasmussen",
        @"Bird",
        @"Hewitt",
        @"Lindsay",
        @"Le",
        @"Foreman",
        @"Valencia",
        @"O'neil",
        @"Delacruz",
        @"Vinson",
        @"Dejesus",
        @"Hyde",
        @"Forbes",
        @"Gilliam",
        @"Guthrie",
        @"Wooten",
        @"Huber",
        @"Barlow",
        @"Boyle",
        @"Mcmahon",
        @"Buckner",
        @"Rocha",
        @"Puckett",
        @"Langley",
        @"Knowles",
        @"Cooke",
        @"Velazquez",
        @"Whitley",
        @"Noel",
        @"Vang",
    ];
    
    uint32_t index = arc4random_uniform((uint32_t)values.count);
    return values[index];
}


+ (NSString *)randomPhoneNumber
{
    if (arc4random_uniform(2) == 0) {
        // Generate a US phone number.
        NSMutableString *result = [@"+1" mutableCopy];
        for (int i = 0; i < 10; i++) {
            // Add digits.
            [result appendString:[@(arc4random_uniform(10)) description]];
        }
        return result;
    } else {
        // Generate a UK phone number.
        NSMutableString *result = [@"+441" mutableCopy];
        for (int i = 0; i < 9; i++) {
            // Add digits.
            [result appendString:[@(arc4random_uniform(10)) description]];
        }
        return result;
    }
}

+ (void)createRandomContacts:(NSUInteger)count
{
    [self createRandomContacts:count contactHandler:nil];
}

+ (void)createRandomContacts:(NSUInteger)count
              contactHandler:
                  (nullable void (^)(CNContact *_Nonnull contact, NSUInteger idx, BOOL *_Nonnull stop))contactHandler
{
    OWSAssert(count > 0);

    NSUInteger remainder = count;
    const NSUInteger kMaxBatchSize = 20;
    NSUInteger batch = MIN(kMaxBatchSize, remainder);
    remainder -= batch;
    [self createRandomContactsBatch:batch
                     contactHandler:contactHandler
             batchCompletionHandler:^{
                 if (remainder > 0) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [self createRandomContacts:remainder contactHandler:contactHandler];
                     });
                 }
             }];
}

+ (void)createRandomContactsBatch:(NSUInteger)count
                   contactHandler:(nullable void (^)(
                                      CNContact *_Nonnull contact, NSUInteger idx, BOOL *_Nonnull stop))contactHandler
           batchCompletionHandler:(nullable void (^)(void))batchCompletionHandler
{
    OWSAssert(count > 0);
    OWSAssert(batchCompletionHandler);

    OWSLogDebug(@"createRandomContactsBatch: %zu", count);

    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted) {
        [OWSAlerts showAlertWithTitle:@"Error" message:@"No contacts access."];
        return;
    }

    NSMutableArray<CNContact *> *contacts = [NSMutableArray new];
    CNContactStore *store = [[CNContactStore alloc] init];
    [store
        requestAccessForEntityType:CNEntityTypeContacts
                 completionHandler:^(BOOL granted, NSError *_Nullable error) {
                     if (!granted || error) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [OWSAlerts showAlertWithTitle:@"Error" message:@"No contacts access."];
                         });
                         return;
                     }

                     CNSaveRequest *request = [[CNSaveRequest alloc] init];
                     for (NSUInteger i = 0; i < count; i++) {
                         @autoreleasepool {
                             CNMutableContact *contact = [[CNMutableContact alloc] init];
                             contact.familyName = [@"Rando-" stringByAppendingString:[self randomLastName]];
                             contact.givenName = [self randomFirstName];

                             NSString *phoneString = [self randomPhoneNumber];
                             CNLabeledValue *homePhone = [CNLabeledValue
                                 labeledValueWithLabel:CNLabelHome
                                                 value:[CNPhoneNumber phoneNumberWithStringValue:phoneString]];
                             contact.phoneNumbers = @[ homePhone ];

                             // 50% chance of fake contact having an avatar
                             const NSUInteger kPercentWithAvatar = 50;
                             const NSUInteger kMinimumAvatarDiameter = 200;
                             const NSUInteger kMaximumAvatarDiameter = 800;
                             OWSAssert(kMaximumAvatarDiameter >= kMinimumAvatarDiameter);
                             if (arc4random_uniform(100) < kPercentWithAvatar) {
                                 NSUInteger avatarDiameter
                                     = arc4random_uniform(kMaximumAvatarDiameter - kMinimumAvatarDiameter)
                                     + kMinimumAvatarDiameter;
                                 // Note this doesn't work on iOS9, since iOS9 doesn't generate the imageThumbnailData
                                 // from programmatically assigned imageData. We could make our own thumbnail in
                                 // Contact.m, but it's not worth it for the sake of debug UI.
                                 contact.imageData = UIImageJPEGRepresentation(
                                     [OWSAvatarBuilder buildRandomAvatarWithDiameter:avatarDiameter], (CGFloat)0.9);
                                 OWSLogDebug(@"avatar size: %lu bytes", (unsigned long)contact.imageData.length);
                             }

                             [contacts addObject:contact];
                             [request addContact:contact toContainerWithIdentifier:nil];
                         }
                     }

                     OWSLogError(@"Saving fake contacts: %zu", contacts.count);

                     NSError *saveError = nil;
                     if (![store executeSaveRequest:request error:&saveError]) {
                         OWSLogError(@"Error saving fake contacts: %@", saveError);
                         [OWSAlerts showAlertWithTitle:@"Error" message:saveError.localizedDescription];
                     } else {
                         if (contactHandler) {
                             [contacts enumerateObjectsUsingBlock:contactHandler];
                         }
                     }
                     if (batchCompletionHandler) {
                         batchCompletionHandler();
                     }
                 }];
}

+ (void)deleteContactsWithFilter:(BOOL (^_Nonnull)(CNContact *contact))filterBlock
{
    OWSAssert(filterBlock);

    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted) {
        [OWSAlerts showAlertWithTitle:@"Error" message:@"No contacts access."];
        return;
    }

    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts
                    completionHandler:^(BOOL granted, NSError *_Nullable error) {
                        if (!granted || error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [OWSAlerts showAlertWithTitle:@"Error" message:@"No contacts access."];
                            });
                            return;
                        }

                        CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[
                            CNContactIdentifierKey,
                            CNContactGivenNameKey,
                            CNContactFamilyNameKey,
                            [CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],
                        ]];
                        CNSaveRequest *request = [[CNSaveRequest alloc] init];
                        NSError *fetchError = nil;
                        BOOL result =
                            [store enumerateContactsWithFetchRequest:fetchRequest
                                                               error:&fetchError
                                                          usingBlock:^(CNContact *contact, BOOL *stop) {
                                                              if (filterBlock(contact)) {
                                                                  [request deleteContact:[contact mutableCopy]];
                                                              }
                                                          }];

                        NSError *saveError = nil;
                        if (!result || fetchError) {
                            OWSLogError(@"error = %@", fetchError);
                            [OWSAlerts showAlertWithTitle:@"Error" message:fetchError.localizedDescription];
                        } else if (![store executeSaveRequest:request error:&saveError]) {
                            OWSLogError(@"error = %@", saveError);
                            [OWSAlerts showAlertWithTitle:@"Error" message:saveError.localizedDescription];
                        }
                    }];
}

+ (void)clearSignalAccountCache
{
    OWSLogWarn(@"Deleting all signal accounts.");
    [SignalAccount removeAllObjectsInCollection];
}

+ (void)clearSignalRecipientCache
{
    OWSLogWarn(@"Deleting all signal recipients.");
    [SignalRecipient removeAllObjectsInCollection];
}

+ (void)deleteAllContacts
{
    [self deleteContactsWithFilter:^(CNContact *contact) {
        return YES;
    }];
}

+ (void)deleteRandomContacts
{
    [self deleteContactsWithFilter:^(CNContact *contact) {
        return [contact.familyName hasPrefix:@"Rando-"];
    }];
}

+ (NSString *)unregisteredRecipientId
{
    // We ensure that the phone number is invalid by appending too many digits.
    NSMutableString *recipientId = [@"+1" mutableCopy];
    for (int i = 0; i < 11; i++) {
        [recipientId appendFormat:@"%d", (int)(arc4random() % 10)];
    }
    return [recipientId copy];
}

+ (void)createUnregisteredContactThread
{
    NSString *recipientId = [self unregisteredRecipientId];
    TSContactThread *thread = [TSContactThread getOrCreateThreadWithContactId:recipientId];
    [SignalApp.sharedApp presentConversationForThread:thread animated:YES];
}

+ (void)createUnregisteredGroupThread
{
    NSString *unregisteredRecipientId = [self unregisteredRecipientId];
    NSString *validRecipientId = @"+19174054216";

    NSString *groupName = @"Partially invalid group";
    NSMutableArray<NSString *> *recipientIds = [@[
        unregisteredRecipientId,
        validRecipientId,
        [TSAccountManager localNumber],
    ] mutableCopy];
    NSData *groupId = [Randomness generateRandomBytes:16];
    TSGroupModel *model =
        [[TSGroupModel alloc] initWithTitle:groupName memberIds:recipientIds image:nil groupId:groupId];
    TSGroupThread *thread = [TSGroupThread getOrCreateThreadWithGroupModel:model];

    [SignalApp.sharedApp presentConversationForThread:thread animated:YES];
}

@end

NS_ASSUME_NONNULL_END
