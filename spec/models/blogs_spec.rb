require 'rails_helper'

RSpec.describe Blog, type: :model do
  before(:each) do
    @user = User.create!(email: "test@example.com", password: "password")

  it "is valid with valid attributes" do
    blog = Blog.new(title: "Sample Title", body: "Sample Body", user: @user)
    expect(blog).to be_valid
  end

  it "is not valid without a title" do
    blog = Blog.new(title: nil, body: "Sample Body", user: @user)
    expect(blog).to_not be_valid
    puts blog.errors.full_messages
  end

  it "is not valid without a body" do
    blog = Blog.new(title: "Sample Title", body: nil, user: @user)
    expect(blog).to_not be_valid
    puts blog.errors.full_messages
  end

end
end
