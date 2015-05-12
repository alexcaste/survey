require 'spec_helper'

describe('Survey') do

  it("validates the presence of a name") do
    survey = Survey.create(name: "")
    expect(survey.save()).to(eq(false))
  end

  describe('#upcase_name') do
    it("capitalizes the first letter of the survey") do
      survey = Survey.create(name: "howling at the moon")
      expect(survey.name).to(eq("Howling At The Moon"))
    end
  end


end
