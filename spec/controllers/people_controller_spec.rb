require "rails_helper"

describe PeopleController do
  describe "#create" do
    context "when person is valid" do
      it "redirects to #show" do
        person_attributes = {first_name: "First"}
        person = stub_person(person_attributes, valid: true)

        post :create, {person: person_attributes}

        expect(response).to redirect_to(person)
      end
    end

    context "when person is invalid" do
      it "renders the 'new' template" do
        person_attributes = {first_name: ""}
        stub_person(person_attributes, valid: false)

        post :create, {person: person_attributes}

        expect(response).to render_template(:new)
      end
    end

    def stub_person(attributes, valid:)
      Person.new.tap do |person|
        allow(Person).to receive(:new).with(attributes).
          and_return(person)
        allow(person).to receive(:save).and_return(valid)
      end
    end
  end
end
