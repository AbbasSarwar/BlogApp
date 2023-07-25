require 'rails_helper'

RSpec.describe 'User', type: :system do
  before(:each) do
    @profile1 = User.create(name: 'Tom',
                            photo: 'https://as2.ftcdn.net/v2/jpg/03/26/98/51/1000_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg',
                            bio: 'Teacher from Mexico.',
                            post_counter: 0)
    @profile2 = User.create(name: 'Lilly',
                            photo: 'https://as2.ftcdn.net/v2/jpg/02/14/74/61/1000_F_214746128_31JkeaP6rU0NzzzdFC4khGkmqc8noe6h.jpg',
                            bio: 'Teacher from Poland.',
                            post_counter: 0)
                            @jin = User.create(name: 'Jin',
                            photo: 'https://as2.ftcdn.net/v2/jpg/03/26/98/51/1000_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg',
                            bio: 'Teacher from Mexico.',
                            post_counter: 0)
                            
         @post1 = Post.create(title: 'title 1',
                              text: 'post content 1',
                              comments_counter: 0,
                              likes_counter: 0,
                              author_id: @jin.id)
         @post2 = Post.create(title: 'title 2',
                              text: 'post content 2',
                              comments_counter: 0,
                              likes_counter: 0,
                              author_id: @jin.id)
         @post3 = Post.create(title: 'title 3',
                              text: 'post content 3',
                              comments_counter: 0,
                              likes_counter: 0,
                              author_id: @jin.id)
         @post4 = Post.create(title: 'title 4',
                              text: 'post content 4',
                              comments_counter: 0,
                              likes_counter: 0,
                              author_id: @jin.id)
        @comment1 = Comment.create(author_id: @profile1.id, post_id: @post1.id, text: "Hello")
        @comment2 = Comment.create(author_id: @profile1.id, post_id: @post1.id, text: "wassup")
        @like1 = Like.create(author_id: @profile1.id, post_id: @post1.id)

  end
  describe 'user index' do
    before(:each) do
      visit users_path
    end
    it 'shows the user details' do
      expect(page).to have_content(@profile1.name)
      expect(page).to have_content(@profile2.name)
    end

    it 'should show the profile picture for each user.' do
      expect(page).to have_xpath("//img[contains(@src,'https://as2.ftcdn.net/v2/jpg/03/26/98/51/1000_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg')]")
    end

    it 'number of posts' do
      expect(page).to have_content('Number of Posts: 0')
    end

    it 'redirect to user page' do
      click_link 'Tom'
      expect(page).to have_current_path("/users/#{@profile1.id}")
    end
  end

  describe 'user#show' do
    before(:each) do
      visit user_path(@jin.id)
    end

    it 'should show the profile picture for each user.' do
      expect(page).to have_xpath("//img[contains(@src,'https://as2.ftcdn.net/v2/jpg/03/26/98/51/1000_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg')]")
    end
    it 'should show the username of all other users.' do
      expect(page).to have_content(@jin.name)
      expect(page).to_not have_content(@profile2.name)
    end
    it 'should show number of posts each user has written.' do
      expect(page).to have_content 'Number of Posts: 4'
    end
    it 'I can see the user bio.' do
      expect(page).to have_content 'Teacher from Mexico.'
    end
    it 'I can see the user first 3 posts.' do
      expect(page).to_not have_content 'post content 4'
    end
    it 'I can see a button that lets me view all of a users posts.' do
      expect(page).to have_content 'See more'
    end
    it 'When I click a users post, it redirects me to that posts show page.' do
      visit "/users/#{@jin.id}/posts/#{@post1.id}"
      expect(page).to have_content 'post content 1'
    end
    it 'When I click to see all posts, it redirects me to the users posts index page.' do
      click_link 'See more'
      expect(page).to have_content 'title 1'
    end
  end

  describe "post#index" do
     before(:each) do
      visit "/users/#{@jin.id}/posts"
     end
    it 'User name show' do
      expect(page).to have_content "#{@jin.name}"
    end
    it 'User Profile picture' do
      expect(page).to have_xpath("//img[contains(@src,'https://as2.ftcdn.net/v2/jpg/03/26/98/51/1000_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg')]")
    end
    it 'Number of Posts user has written' do
      expect(page).to have_content "Number of Posts: 4"
    end
    it 'Post title' do
      expect(page).to have_content "title 1"
    end
    it 'Post body' do
      expect(page).to have_content "post content 1"
    end
    it 'comments show' do
      expect(page).to have_content "Hello"
    end
    it "comments count" do
      expect(page).to have_content "comments: 2"
    end
    it 'likes count' do
      expect(page).to have_content "likes: 1"
    end
    it 'click on link redirect to page' do
      click_link "post content 1"
      expect(page).to have_current_path("/users/#{@jin.id}/posts/#{@post1.id}")
    end
  end

  describe "Post#show" do
    before(:each) do
      visit "/users/#{@jin.id}/posts/#{@post1.id}"
    end
    it 'post title' do
      expect(page).to have_content "title 1"
    end
    it 'Author name' do
      expect(page).to have_content "Posted by: Jin"
    end
    it 'comments count show' do
      expect(page).to have_content "comments: 2"
    end
    it 'likes count show' do
      expect(page).to have_content 'likes: 1'
    end
    it 'who commented?' do
      expect(page).to have_content(@profile1.name)
    end
    it 'show all comments with name:' do
      expect(page).to have_content "Tom: Hello"
      expect(page).to have_content "Tom: wassup"
    end
  end
end
