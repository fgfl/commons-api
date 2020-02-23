require "rails_helper"

# Specs in this file have access to a helper object that includes
# the CategoryMapperHelper. For example:
#
# describe CategoryMapperHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CategoryMapperHelper, type: :helper do
  it "should return the agriculture category name given the agriculture string" do
    cat_name = "Agriculture, environment, fisheries and natural resources"
    expect(CategoryMapperHelper::map(cat_name)).to eq("agriculture_environment")
  end
  it "should return the arts category name given the arts string" do
    cat_name = "Arts, culture and entertainment"
    expect(CategoryMapperHelper::map(cat_name)).to eq("arts_culture")
  end
  it "should return the business category name given the business string" do
    cat_name = "Business, industry and trade"
    expect(CategoryMapperHelper::map(cat_name)).to eq("business_industry")
  end
  it "should return the economics category name given the economics string" do
    cat_name = "Economics and finance"
    expect(CategoryMapperHelper::map(cat_name)).to eq("economics_finance")
  end
  it "should return the education category name given the education string" do
    cat_name = "Education, language and training"
    expect(CategoryMapperHelper::map(cat_name)).to eq("education_language")
  end
  it "should return the employment category name given the employment string" do
    cat_name = "Employment and labour"
    expect(CategoryMapperHelper::map(cat_name)).to eq("employment_labour")
  end
  it "should return the government category name given the government string" do
    cat_name = "Government, Parliament and politics"
    expect(CategoryMapperHelper::map(cat_name)).to eq("government_politics")
  end
  it "should return the health category name given the health string" do
    cat_name = "Health and safety"
    expect(CategoryMapperHelper::map(cat_name)).to eq("health_safety")
  end
  it "should return the indigenous category name given the indigenous string" do
    cat_name = "Indigenous affairs"
    expect(CategoryMapperHelper::map(cat_name)).to eq("indigenous_affairs")
  end
  it "should return the information category name given the information string" do
    cat_name = "Information and communications"
    expect(CategoryMapperHelper::map(cat_name)).to eq("information_communications")
  end
  it "should return the international category name given the international string" do
    cat_name = "International affairs and defence"
    expect(CategoryMapperHelper::map(cat_name)).to eq("international_affairs")
  end
  it "should return the law category name given the law string" do
    cat_name = "Law, justice and rights"
    expect(CategoryMapperHelper::map(cat_name)).to eq("law_justice")
  end
  it "should return the science category name given the science string" do
    cat_name = "Science and technology"
    expect(CategoryMapperHelper::map(cat_name)).to eq("science_technology")
  end
  it "should return the social affairs category name given the social affairs string" do
    cat_name = "Social affairs and population"
    expect(CategoryMapperHelper::map(cat_name)).to eq("social_affairs")
  end
  it "should return nil for invalid category" do
    cat_name = "Places"
    expect(CategoryMapperHelper::map(cat_name)).to eq(nil)
  end
end
