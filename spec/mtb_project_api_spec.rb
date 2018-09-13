RSpec.describe MtbProjectApi do
  it "has a version number" do
    expect(MtbProjectApi::VERSION).not_to be nil
  end

  it "import the Client" do
    expect(MtbProjectApi::Client).not_to be nil
  end
end
