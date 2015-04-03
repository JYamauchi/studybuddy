require_relative '../models'


describe Card do

  it "has a question" do
    card = Card.new(q: "hi", a: "sup")
    expect(card.q).to eq("hi")
  end

  it "has an answer" do
    card = Card.new(q: "hi", a: "sup")
    expect(card.a).to eq("sup")
  end

end

describe Deck do

  it "has a name" do
    deck = Deck.new(name: "Test deck", description: "This deck is full of questions about tests")
    expect(deck.name).to eq("Test deck")
  end

    it "has a description" do
    deck = Deck.new(name: "Test deck", description: "This deck is full of questions about tests")
    expect(deck.description).to eq("Test deck")
  end

end



