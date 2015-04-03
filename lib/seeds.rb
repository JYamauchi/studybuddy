require_relative 'models.rb'

#Set up tables in database for Cards, Decks, Games, and Users

CreateTables.new

#Create a few users to start with

@u1 = User.create(name: "Julia")
@u2 = User.create(name: "Benedict Cumberbatch")
@u3 = User.create(name: "Nicki Minaj")
@u4 = User.create(name: "Batman")

#Create decks for these users to play with

@d1 = @u1.decks.create(name: "French vocab (fruits)", description: "For each French word, enter the English translation.")
@d2 = @u2.decks.create(name: "Capital cities", description: "For each country listed, enter its capital city.")
@d3 = @u3.decks.create(name: "True or false", description: "For each statement, enter either 'true' or 'false.'")
@d4 = @u4.decks.create(name: "Really difficult", description: "LOL GOOD LUCK!")
@d5 = @u1.decks.create(name: "French vocab (animals)", description: "For each French word, enter the English translation.")

#Create some cards to go in these decks

@d1.cards.create(q: "pomme", a: "apple")
@d1.cards.create(q: "fraise", a: "strawberry")
@d1.cards.create(q: "pamplemousse", a: "grapefruit")
@d1.cards.create(q: "framboise", a: "raspberry")
@d1.cards.create(q: "citron", a: "lemon")
@d2.cards.create(q: "Norway", a: "Oslo")
@d2.cards.create(q: "China", a: "Beijing")
@d2.cards.create(q: "Canada", a: "Ottawa")
@d2.cards.create(q: "Egypt", a: "Cairo")
@d3.cards.create(q: "Puppies are cute", a: "true")
@d3.cards.create(q: "The sky is green", a: "false")
@d3.cards.create(q: "We're all slowly dying", a: "true")
@d4.cards.create(q: "EXAMPLE CARD SAYS WHAT?", a: "what")
@d4.cards.create(q: "Who lives in a pineapple under the sea?", a: "Spongebob Squarepants")
@d4.cards.create(q: "How do you type with boxing gloves on your hands?", a: "Strong Bad won't tell")
@d5.cards.create(q: "chien", a: "dog")
@d5.cards.create(q: "vache", a: "cow")
@d5.cards.create(q: "cheval", a: "horse")
@d5.cards.create(q: "singe", a: "monkey")
@d5.cards.create(q: "lapin", a: "rabbit")



