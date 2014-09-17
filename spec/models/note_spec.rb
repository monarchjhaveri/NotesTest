require 'rails_helper'

RSpec.describe Note, :type => :model do
  it "requires a title to be valid" do
    expect(
      FactoryGirl.build(
        :note, title: nil
      )
    ).not_to be_valid
  end
  it "validates title length to 100 characters" do
    require 'securerandom'
    expect(
      FactoryGirl.build(
        :note, title: SecureRandom.hex(51)
      )
    ).not_to be_valid
  end
  it "validates content length to 5000 characters" do
    expect(
      FactoryGirl.build(
        :note, 
        content: SecureRandom.hex(2501)
      )
    ).not_to be_valid
  end
  it "can generate a blurb consisting of the title and content" do
    note = FactoryGirl.create(:note)
    expect(note.blurb).to eq "#{note.title} #{note.content}".slice(0,255)
  end
  it "blurb is up to 255 characters in length" do
    the_title = SecureRandom.hex(25)
    the_content = SecureRandom.hex(200)
    note = FactoryGirl.create(:note, title: the_title, content: the_content)
    expect(note.blurb.length).to eq 255
  end
  it "returns a sorted array of results that match" do
    smith = FactoryGirl.create(:note, title: "Smith S S S")
    strauss = FactoryGirl.create(:note, title: "Strauss S S S")
    jones = FactoryGirl.create(:note, title: "Jones S S S")

    expect(Note.by_letter("S")).to eq [smith, strauss]
  end
end
